package jkworld.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CheckService {

	public boolean checkUser(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
