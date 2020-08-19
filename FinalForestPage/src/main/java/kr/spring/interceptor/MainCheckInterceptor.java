package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MainCheckInterceptor extends HandlerInterceptorAdapter{
  
	private Logger log = Logger.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response,
			Object handler)throws Exception {

		HttpSession session = request.getSession();

		//메인으로 접근시, 로그인 여부 체크x 
		//관리자로 로그인한 경우(회원x)
		if(session.getAttribute("mem_num") != null && (Integer)session.getAttribute("user_auth")==3){
			//System.out.println((Integer)session.getAttribute("user_auth"));
			response.sendRedirect(
					request.getContextPath()+"/admin/adminList.do");
			return false;
		}

		return true;
	}
}






