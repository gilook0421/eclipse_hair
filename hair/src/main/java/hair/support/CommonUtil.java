package hair.support;

import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CommonUtil {

	private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);
	
	public String createKey() throws Exception{
	
		String key = "";
		Random ran = new Random();
		
		for( int i = 0 ; i < 8; i++ ) {
			key += ran.nextInt(10);
		}
		if(logger.isDebugEnabled()) logger.debug("createkey = " + key);
		return key; 
	}
	
}
