package hair.support;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggingInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(LoggingInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (logger.isDebugEnabled()) { 
			logger.debug("====================================== START ======================================"); 
			logger.debug(" Request URI \t: " + request.getRequestURI()); 
		}
		
		logger.debug("--------------------------------");
		// 그리고 다음은 Header 정보를 보는 방법입니다. <br>
		Enumeration<?> eHeader = request.getHeaderNames();
		 while (eHeader.hasMoreElements()) {
		  String hName = (String)eHeader.nextElement();
		  String hValue = request.getHeader(hName);

		  logger.debug("getHeaderNames=> " + hName + " : " + hValue + "<br>");
		 }
		  logger.debug("--------------------------------");
		// Request 객체를 통해서 쿠키 정보를 보는 방식이구요~<br>
		/*
		 * Cookie cookies[] = request.getCookies(); for (int i=0; i < cookies.length;
		 * i++) { String name = cookies[i].getName(); String value =
		 * cookies[i].getValue();
		 * 
		 * logger.debug("getCookies=> " + name + " : " + value + "<br>"); }
		 */
		

		// HTML 폼을 통해 넘어온 데이터를 받는 부분입니다. <br>
		 Enumeration<?> eParam = request.getParameterNames();
		 while (eParam.hasMoreElements()) {
		  String pName = (String)eParam.nextElement();
		  String pValue = request.getParameter(pName);

		  logger.debug("getParameterNames=> " + pName + " : " + pValue + "<br>");
		 }
		// 미리 설정한 attribute를 가져오는 부분이구요..<br>
		 Enumeration<?> eAttr = request.getAttributeNames();
		 while (eAttr.hasMoreElements()) {
		  String aName = (String)eAttr.nextElement();
		  String aValue = request.getHeader(aName);

		  logger.debug("getAttributeNames=> " + aName + " : " + aValue + "<br>");
		 }
		  logger.debug("--------------------------------");
		  

		logger.debug("--------------------------------");
		logger.debug("getProtocol() : " + request.getProtocol() + "<br>");
		logger.debug("getServerName() : " + request.getServerName() + "<br>");
		logger.debug("getMethod() : " + request.getMethod() + "<br>");
		logger.debug("getQueryString() : " + request.getQueryString() + "<br>");
		logger.debug("getRequestURI() : " + request.getRequestURI() + "<br>");
		logger.debug("getRemoteAddr() : " + request.getRemoteAddr() + "<br>");
		logger.debug("getServerPort() : " + request.getServerPort() + "<br>");
		logger.debug("getContextPath() : " + request.getContextPath() + "<br>");
		logger.debug("--------------------------------");
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView view) throws Exception{

		logger.debug("postHandle.request() : " + request.toString());
		logger.debug("postHandle.handler() : " + handler.toString());
		if ( view != null ) {
			logger.debug("view.getViewName() : " + view.getViewName());
			logger.debug("view.getClass() : " + view.getClass());
			logger.debug("view.getModel() : " + view.getModel());
			logger.debug("view.getModelMap() : " + view.getModelMap());
			//logger.debug("view.getStatus() : " + view.getStatus());
			logger.debug("view.getView() : " + view.getView());
		}
		
	    if (logger.isDebugEnabled()) { 
	    	logger.debug("====================================== END ======================================\n"); 
	    }
	    
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception{

		//logger.debug("controller {afterCompletion}");
	}
	
}
