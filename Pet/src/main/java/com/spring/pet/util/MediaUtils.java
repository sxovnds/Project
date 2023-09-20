package com.spring.pet.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	/* 이미지파일인지 기타파일인지 구분할 수 있도록 하는 클래스 */
	private static Map<String, MediaType> mediaMap = new HashMap<String, MediaType>();
	/* MediaType : 스프링에 존재하는 미디어파일 전용 자료형 */
	
	static {
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);

		/* {} : 필드에 {}로 블럭을 잡아주면 필드에 선언한 변수를 초기화/대입 할 수 있다 */
		/* key에 없는 필드값이 들어오면 null을, 이미지파일의 확장자가 들어오면 해당하는 value값이 출력된다 */
	}
	
	public static MediaType getMediaType(String type) {
		/* 업로드 받은 파일이 이미지파일인지 아닌지를 구분할 수 있는 메서드 */
		
		return mediaMap.get(type.toUpperCase());
		/* 외부에서 들어온 파일 확장자를 대문자로 변환해, mediaMap에 실제 객체가 있다면 
		 * 확장자에 해당하는 value값을 반환하고, 이미지파일이 아니면 null을 반환한다 */
	}
}
