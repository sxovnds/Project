package com.spring.pet.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadDownloadUtils {
	
	public static String calcPath(String uploadPath) {
		
		/* 연.월.일 별로 파일을 나누어서 각각의 폴더에 저장하기 위해서 
		 * Calendar 클래스를 이용해 연, 월, 일을 구해 객체를 만든다 */
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int date = cal.get(Calendar.DATE);
		
		/* 폴더의 경로로 연.월.일자를 지정해 주기 위해 path를 설정한다 */
		String yearPath = File.separator + year; /* uploadPath/2021 */
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(month); /* uploadPath/2021/02 */
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(date); /* uploadPath/2021/02/22 */
		/* 2월일 떄 : 포맷팅 전 - 2 / 포맷팅 후 - 02 (int -> String 으로 자료형이 변경됨 
		 * DecimalFormat("00")을 하는 이유? 00으로 패턴을 설정해주면, 한자리수의 경우 앞쪽에 0을 붙여서 01,02,03과 같은 형태가 된다. */
		
		makeDir(uploadPath, yearPath, monthPath, datePath);
		/* 폴더를 생성하는 메서드를 불러오기 */
		
		return datePath;
		/* view에 파일 경로에서 해당하는 파일을 가져와 보여주기 위해서 datePath를 return 해준다 
		 * datePath를 return하는 이유? 가장 세분화 된 파일이므로 : 결국 최종적으로 저장되는 폴더는 dathPath를 가지는 폴더이기 때문에 
		 * datePath + 시스템파일명 : 원하는 파일을 특정해 미리보기등을 구현할 수 있다 */
	}
	
	private static void makeDir(String uploadPath, String ... arr) {
		/* varargs(가변인자) : 동일한 자료형의 파라미터가 여러개일 경우, varargs로 파라미터를 지정해주면, 동일한 변수들이 배열의 형태를 가지며 참조된다 
		 * varargs 지정방법 : 자료형 ... 배열의 변수명 */
		File fDate = new File(uploadPath + arr[arr.length-1]);
		/* 파일객체를 하나 설정한다. 업로드 한 파일을 저장할 수 있는 path로 파라미터를 지정해주고 (arr[arr.length-1] : datePath) */
		
		if (fDate.exists()) {
			/* 만약 uploadPath/datePath 를 경로로 가지는 폴더가 있다면 */
			return;
			/* 폴더를 생성하지 말고 return 
			 * 폴더가 없다면 for문을 실행 */
		}
		
		for (int i = 0; i < arr.length; i++) {
			/* arr이 가지고 있는 변수들을 하나씩 꺼내와서 */ 
			String path = arr[i];
			/* path에 넣어준다 */
			File f = new File(uploadPath + path);
			/* 파일 객체를 생성해서, uploadPath/yearPath 가 있는지 확인 -> 있으면 for문을 종료 */
			/* 파일 객체를 생성해서, uploadPath/monthPath 가 있는지 확인 -> 있으면 for문을 종료*/
			/* 파일 객체를 생성해서, uploadPath/datePath 가 있는지 확인 -> 있으면 for문을 종료*/
			if (!f.exists()) {
				
				f.mkdir();
				/* 없으면 uploadPath/yearPath 폴더 생성 */
				/* 없으면 uploadPath/monthPath 폴더 생성 */
				/* 없으면 uploadPath/datePath 폴더 생성 */
			}
		}
		
		/* 2021.02.22 폴더가 존재할 때 : return */
		/* 2021.02 폴더는 있는데, 22폴더가 없을 때 : 22폴더를 만들고 return */
		/* 2021 폴더는 있는데 월자, 일자 폴더 모두 없을 때 : 월자 폴더를 만든 뒤, 일자 폴더를 만든 뒤 return */
		/* 연자 폴더도 없을 경우 : 연자 폴더를 만들어준 뒤, 월, 일 순서로 폴더를 생성하도록 해줌 */
		
		/* for문을 통해 위의 세가지 경우에 해당하면 각각의 폴더를 만들어낸다 */
	}

	public static String makeFileName(String originalFileName) {
		
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalFileName;
		
		return savedName;
	}


	private static String makeThumbnail(String uploadPath, String savedPath, String savedName) throws Exception {
		
		/* 원본파일을 buffer에 로딩해두고, 그 내용을 butter에 저장 : 더블 버퍼링 (파일이 아닌 buffer에 저장함 */
		File oriFile = new File(uploadPath + savedPath, savedName); /* 원본 파일을 읽어와서 */
		BufferedImage sourceImg = ImageIO.read(oriFile); /* buffer에 저장함 */
		
		int dw = 242;
		int dh = 200;
		
		int ow = sourceImg.getWidth();
		int oh = sourceImg.getHeight();
		
		int nw = ow; 
		int nh = (ow * dh) / dw;
		
		if(nh > oh) { 
			nw = (oh * dw) / dh; 
			nh = oh; 
		}
		
		BufferedImage cropImg = Scalr.crop(sourceImg, (ow-nw)/2, (oh-nh)/2, nw, nh);

		BufferedImage desImg = Scalr.resize(cropImg, dw, dh);
		/* Scalr.resize(썸네일로 만들 이미지, Scalr.Method.AUTOMATIC (자동으로 사이즈 조절), 
		 * 								Scalr.Mode.FIT_TO_HEIGHT/WIDTH (세로나 가로 비율에 맞춰 사이즈 조절)
		 * 									or FIT_EXACT(원본의 비율과는 상관없이 가로/세로 모두 지정한 픽셀로 리사이징), 픽셀값) */
		
		/* 파일로 만들기 위해 필요한 것 : 파일명, 확장자 .. */
		
		String thumbnailName = uploadPath + savedPath + File.separator + "s_" + savedName;
		/* 썸네일로 만든 파일을 저장하기 위해 파일명을 설정해준다 : "s_" 를 붙여 이 파일이 썸네일임을 표시한다 */
		int idx = savedName.lastIndexOf(".")+1;
		String type = savedName.substring(idx).toUpperCase();
		/* 썸네일로 만든 파일의 확장자명을 부여해준다 ; 원본 파일과 동일하게 확장자를 준다 */
		
		ImageIO.write(desImg, type, new File(thumbnailName));
		/* 이미지 파일을 생성해서 확장자는 type으로 부여해준 뒤, thumbnailName에 저장하라 
		 * thumbnailName : oriFile로 보내면 원본파일에 덮어씌워지므로, 
		 * 					썸네일을 생성하기 위해 만들었던 경로+파일명이 있는 thumbnailName으로 보내야 한다 */
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
		/* == return (savedPath + File.separator + "s_" + savedName).replace(File.separatorChar, '/'); */
		/* 브라우저에서는 / 로 파일구분자를 인식하기 때문에 /로 구분자를 설정해준다 */
	}

	public static String upload(String uploadPath, MultipartFile file) throws Exception {
		
		String savedName = makeFileName(file.getOriginalFilename());
		
		String savedPath = calcPath(uploadPath);
		/* calcPath는 datePath를 반환한다 ex, /2021/02/22 */
		File target = new File((uploadPath + savedPath), savedName);
		/* file객체의 파라미터로 절대경로(uploadPath) + datePath(savedPath)로 지정해주면 
		 * /Users/seoyewon/workspace_spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/MyBoard7/resources/upload (절대경로)
		 * /2021/02/22 (datePath) 
		 * 위와 같이 원하는 위치에 파일이 저장된다 */
		
		FileCopyUtils.copy(file.getBytes(), target); 
		/* 실질적으로 파일 업로드를 하는 부분을 따로 메서드처리 하여 다른 클래스에서도 자유롭게 사용 가능하도록 함 */
		
		/* 업로드 된 파일이 이미지파일인지, 기타파일인지 확인하는 코드 */
		int idx = savedName.lastIndexOf(".")+1;
		String type = savedName.substring(idx);
		
		MediaType mType = MediaUtils.getMediaType(type);
		
		String uploadFileName = null;
		/* 썸네일이 있는 경로를 반환해주기 위해 선언한 변수 */
		if (mType != null) {
			uploadFileName = makeThumbnail(uploadPath, savedPath, savedName);
			/* 썸네일을 만들기 위해서 파일이 있는 폴더의 절대경로와 저장된 이름을 파라미터로 넘겨준다 
			 * 썸네일을 만들어서 view 에 띄워줘야 하므로 썸네일의 파일 명과 경로를 jsp로 넘겨줘야 한다 : 파일명/경로 없이는 화면에 띄워줄 수 없다 */
		} else {
			uploadFileName = (savedPath + File.separator + savedName).replace(File.separatorChar, '/');
			/* 기타파일의 경우에는 썸네일을 따로 만들어 줄 필요가 없기 때문에 업로드 된 파일의 이름만 반환해주면 된다 */ 
		}

		return uploadFileName;
		/* : upload()를 실행한 메서드에 썸네일의 경로를 반환해준다. */
	}

}