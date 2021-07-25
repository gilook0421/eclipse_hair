package hair.support.HandlerRequestBody;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.IOUtils; 

public class ReadableRequestBodyWrapper extends HttpServletRequestWrapper {
	private byte[] bytes;
	private String requestBody;

	public ReadableRequestBodyWrapper(HttpServletRequest request) throws IOException{
		super(request);

		InputStream in = super.getInputStream();
		bytes = IOUtils.toByteArray(in);
		requestBody = new String(bytes);
	}


	public String getRequestBody() {
		return this.requestBody;
	}

}