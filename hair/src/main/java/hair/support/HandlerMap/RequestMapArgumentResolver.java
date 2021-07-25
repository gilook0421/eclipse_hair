package hair.support.HandlerMap;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.google.gson.Gson;

public class RequestMapArgumentResolver implements HandlerMethodArgumentResolver{

    private static final Logger logger = Logger.getLogger(RequestMapArgumentResolver.class);
    private static final String JSON_BODY_ATTRIBUTE = "JSON_REQUEST_BODY";
    
	 @Override 
	 public boolean supportsParameter(MethodParameter parameter) {

        if (logger.isDebugEnabled()) {
        	logger.debug(" supportsParameter Params \t:  " + parameter.toString());
        }
	        
		 return RequestMap.class.isAssignableFrom(parameter.getParameterType());
	 } 
	 
	 @SuppressWarnings("unchecked")
	@Override 
	 public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
			/*
			 * RequestMap requestMap = new RequestMap(); HttpServletRequest request =
			 * (HttpServletRequest) webRequest.getNativeRequest(); Enumeration<?>
			 * enumeration = request.getParameterNames(); String key = null; String[] values
			 * = null; while(enumeration.hasMoreElements()){ key = (String)
			 * enumeration.nextElement(); values = request.getParameterValues(key);
			 * if(values != null){ requestMap.put(key, (values.length > 1) ?
			 * values:values[0] ); } }
			 */


        HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
        HttpSession session = request.getSession();
        RequestMap collector = new RequestMap();
        Enumeration<?> enumeration = request.getParameterNames();

        String key = null;
        String[] values = null;
        while (enumeration.hasMoreElements()) {
            key = (String) enumeration.nextElement();
            values = request.getParameterValues(key);
            if (values != null) {
                collector.put(key, (values.length > 1) ? values : values[0]);
            }
        }
        
        String body = getRequestBody(webRequest);
        if (StringUtils.isNotEmpty(body)) {
            Gson gson = new Gson();
            Map<String, Object> map = new HashMap<String, Object>();
            map = gson.fromJson(body, map.getClass());
            collector.putAll(map);
        }

        enumeration = session.getAttributeNames();
        while (enumeration.hasMoreElements()) {
            key = (String) enumeration.nextElement();
            values = (String[]) session.getAttribute(key);
            if (values != null) {
                collector.put(key, (values.length > 1) ? values : values[0]);
            }
        }
        	
        if (logger.isDebugEnabled()) {
        	//logger.debug(" Request Params \t:  " + collector.getMap());
        	logger.debug(" Request Session \t:  " + session.toString());
        }
	        
		 return collector;
	 } 

	    /**
	     * 웹에서 Ajax 호출시 메소드가 'put'이거나 'delete'인 경우 데이터가 담겨오는 그릇이 다르므로
	     * 따로 담아서 String형태로 리턴
	     *  
	     * @param NativeWebRequest
	     * @return String
	     */
	    @SuppressWarnings("deprecation")
		private String getRequestBody(NativeWebRequest webRequest) {
	        HttpServletRequest servletRequest = webRequest.getNativeRequest(HttpServletRequest.class);
	        String body = (String) webRequest.getAttribute(JSON_BODY_ATTRIBUTE, NativeWebRequest.SCOPE_REQUEST);

	        if (body == null) {
	            try {
	                body = IOUtils.toString(servletRequest.getInputStream());
	                webRequest.setAttribute(JSON_BODY_ATTRIBUTE, body, NativeWebRequest.SCOPE_REQUEST);
	                return body;
	            } catch (IOException e) {
	                throw new RuntimeException();
	            }
	        }

	        return body;
	    }

	    @SuppressWarnings("unused")
		private static Map<String, String> splitQuery(String query) throws UnsupportedEncodingException {
	        Map<String, String> query_pairs = new LinkedHashMap<String, String>();
	        String[] pairs = query.split("&");
	        for (String pair : pairs) {
	            int idx = pair.indexOf("=");
	            query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1), "UTF-8"));
	        }
	        return query_pairs;
	    }

}
