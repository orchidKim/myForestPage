package kr.spring.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminLoginCheckInterceptor 
extends HandlerInterceptorAdapter{

	private Logger log = Logger.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response,
			Object handler)throws Exception {

		HttpSession session = request.getSession();

		//관리자 페이지로 접근 시 

		//비로그인 상태인 경우
		if(session.getAttribute("mem_num") == null){
			response.sendRedirect(
					request.getContextPath()+"/member/login.do");
			return false;
		}

		//회원으로 로그인한 경우(관리자x)
		if((Integer)session.getAttribute("user_auth") != 3){
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/notice.jsp");
			dispatcher.forward(request, response);
			return false;
		}

		return true;
	}
}






