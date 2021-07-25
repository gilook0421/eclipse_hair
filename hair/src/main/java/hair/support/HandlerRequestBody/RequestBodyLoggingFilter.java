package hair.support.HandlerRequestBody;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest; 

public class RequestBodyLoggingFilter implements Filter {
	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
			ReadableRequestBodyWrapper wrapper = new ReadableRequestBodyWrapper((HttpServletRequest)request);
			wrapper.setAttribute("requestBody", wrapper.getRequestBody());
			chain.doFilter(wrapper, response);
		} catch (Exception e) {
			chain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}
}