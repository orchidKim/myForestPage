package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor 
extends HandlerInterceptorAdapter{

	private Logger log = Logger.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response,
			Object handler)throws Exception {

		//회원 페이지 접근시

		//비로그인 상태인 경우
		HttpSession session = request.getSession();
		
		if(session.getAttribute("mem_num")==null) {
			response.sendRedirect(
					request.getContextPath()+"/member/login.do");
			return false;
		}

		return true;
	}
}






