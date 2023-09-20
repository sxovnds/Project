package com.spring.pet.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.pet.util.FileUploadDownloadUtils;
import com.spring.pet.util.MediaUtils;

@Controller
public class UploadController {
	
	// @Resource(name = "uploadPath")
	private String uploadPath = File.separator + "resources" + File.separator + "upload";
	
	
	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public String deleteFile(String filename, HttpSession session)  {
		/* 주의할 점 : view에서 넘어오는 fileName 은 썸네일명이다!! */
		String result = null;
		filename = filename.replace('/', File.separatorChar); /* 구분자를 다시 char형의 /로 변경해줌 : 시스템에 저장되어있는 파일 경로를 가져오기 위해서 */
		
		String uploadPath = session.getServletContext().getRealPath(this.uploadPath);
		/* httpSession객체를 이용해 절대경로를 가져옴 */
		
		int idx = filename.lastIndexOf(".")+1;
		String type = filename.substring(idx);
		MediaType mType = MediaUtils.getMediaType(type);
		/* fileName 을 통해 넘겨받은 파일이 미디어파일인지 기타파일인지를 구분할 수 있도록 MediaUtils클래스를 사용해 mType을 만든다 
		 * mType이 null이면 기타파일이고, mType이 어떠한 값을 가지고있다면 미디어파일이 된다 */
		
		boolean exe0 = true; 
		/* true인 이유 : 기타파일의 경우 if문에 들어갈 일이 없으므로 true로 지정해줘야 result반환시에 에러가 발생하지 않음 */
		
		if (mType != null) {
			/* 미디어파일의 경우, 썸네일과 원본파일을 모두 삭제해줘야 한다 
			 * 하지만 fileName으로 넘겨받은 파일명은 썸네일의 파일명이고, 원본파일명은 아니다 
			 * 그냥 fileName으로 delete를 해 버리면 썸네일파일만 삭제되고 원본은 그대로 남아있는다. 
			 * 따라서 substring()을 이용해 원본파일명을 구해서, */
			String pre = filename.substring(0, 12);
			String suf = filename.substring(14);
			
			String oriName = pre + suf;
			
			File f2 = new File(uploadPath + oriName);
			exe0 = f2.delete();
			/* 파일 객체에 절대경로+원본파일명 을 입력해 삭제하는 과정을 선행해야 한다 : 원본파일 삭제 완료 */
			
		}
		
		
		File f = new File(uploadPath + filename);
		/* 일반파일 또는 썸네일의 경우 ; 넘어오는 fileName 그대로 삭제를 해도 상관없다. */
		boolean exe1  = f.delete();
		
		if (exe1 && exe0) {
			/* 이미지파일의 경우, 원본파일도 삭제되고 썸네일도 삭제 된 경우에만 result로 o를 반환하게 하고
			 * 기타파일의 경우에는, if문이 실행되기 전, exe0 변수를 true로 초기화 해 뒀기 때문에 그대로 true값을 가지고 내려오므로
			 * 기타파일의 삭제가 잘 됐을 경우 (exe1가 true인 경우) 문제없이 result="O"를 반환한다. */
			result = "O";
		} else {
			result = "X";
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String filename, HttpSession session) {
		/* ResponseEntity를 리턴해주는 이유? byte[]로 데이터만 넘겨주면 우리가 원하는 화면을 볼 수 없다. 
		 * 우리가 원하는 화면처럼 출력하기 위해서는 header값이 필요한데, byte[]로 return할 경우, header를 넘겨줄 수가 없다 
		 * 따라서 ResponseEntity 객체를 이용해 데이터가 담긴 바이트배열/헤더값/상태코드를 view 에 넘겨줘야 한다 */
		
		ResponseEntity<byte[]> entity = null; /* 변수 초기화 */
		byte[] arr = null; /* a태그로 넘겨받은 데이터를 읽어와서 byte[]에 저장 후 return하면 브라우저에서 이미지를 바이트배열로 받아와 출력 */
		
		InputStream in = null;
		
		try {
			int idx = filename.lastIndexOf(".")+1;
			String type = filename.substring(idx);
			MediaType mType = MediaUtils.getMediaType(type);
			/* 미디어파일인 경우 MediaUtils클래스에서 파일 확장자를 이용해 미디어타입을 가져옴 */
			HttpHeaders headers = new HttpHeaders();
			String uploadPath = session.getServletContext().getRealPath(this.uploadPath);
			
			in = new FileInputStream(uploadPath + filename);
		
			if (mType != null) {
				/* 넘어온 데이터가 이미지 파일인 경우 : 그냥 새 창으로 화면에 원본을 띄워주기만 하면 됨 */
				headers.setContentType(mType);
			} else {
				/* mType이 null이면 기타파일이다 : 썸네일을 클릭하면 기타파일을 다운로드 할 수 있도록 함 */
				String fileName = filename.substring(filename.indexOf("_")+1); /* 파일의 original Name*/
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				/* MediaType.APPLICATION_OCTET_STREAM : 파일 다운로드를 가능하게 해주는 미디어 타입 */
				headers.add("Content-Disposition", "attachment;filename=\""
							+ new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
				/* original File Name으로 다운로드 해줄 수 있게 함 : 한글인코딩 + 웹브라우저 인코딩 ("ISO-8859-1") */
			}
			
			arr = IOUtils.toByteArray(in);
			entity = new ResponseEntity<byte[]>(arr, headers, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return entity;
		/* byte[]만 전송하면? 데이터만 보내기 때문에 출력이 안됨 
		 * headers정보가 있어야 웹 브라우저에 원하는 결과를 띄울 수 있다 (새로 창을 열어 원본이미지를 보여준다던가, 다운로드를 가능하게 한다던가) 
		 * headers정보를 넘겨주기 위해 사용하는 것이 ResponseEntity 객체
		 * entity = new ResponseEntity<byte[]>(byte[], headers정보, HttpStatus.OK 또는 CREATED - 상태코드); 
		 * 상태코드는 현재 작업이 제대로 이루어졌는지 실패했는지 알려주는 코드이다 
		 * catch부의 printstackTrace() 뒤에, entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST); 를 추가한다 */
		
	}
	
	
	@RequestMapping(value = "/ajaxtest", method = RequestMethod.GET)
	public void ajaxtest() {
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajaxtest", method = RequestMethod.POST, produces = "application/text;charset=utf-8")
	/* produces = "application/text;charset=utf-8" : 한글 인코딩이 깨지지 않게 해줌 */
	public String ajaxtest(MultipartHttpServletRequest requset, HttpSession session) throws Exception {
		
		MultipartFile file = requset.getFile("file");
		String uploadPath = session.getServletContext().getRealPath(this.uploadPath);
		/* uploadPath는 절대경로를 가져와야 함 : 지역변수 uploadPath를 가져와 realpath를 구한 뒤 지역변수 uploadPath 에 대입 */
		String fileUploadPath = FileUploadDownloadUtils.upload(uploadPath, file);
		
		return fileUploadPath;
	}
	
	
}
