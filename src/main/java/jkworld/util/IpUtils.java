package jkworld.util;

import javax.servlet.http.HttpServletRequest;

public class IpUtils {
	 public static String getRemortIP(HttpServletRequest request) {
	        if (request.getHeader("x-forwarded-for") == null) {
	            return request.getRemoteAddr();
	        }
	        return request.getHeader("x-forwarded-for");
	    }
}
