package hair.support.HandlerMap;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class RequestMap extends HashMap<String, Object>{ 
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(RequestMap.class);
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public RequestMap() {
    	super();
    	
    	Date currDate = new Date();
    	put("SYS_DT", new SimpleDateFormat("yyyyMMdd").format(currDate));
    	put("SYS_TM", new SimpleDateFormat("HHmmss").format(currDate));
    	put("SYS_DTTM", new SimpleDateFormat("yyyyMMddHHmmss").format(currDate));
    	
        Set set2 = this.getSession().entrySet();
        Iterator iterator2 = set2.iterator();
        while(iterator2.hasNext()){
            Entry<String, Object> entry = (Entry)iterator2.next();
            String key = (String)entry.getKey();
            if( entry.getValue() instanceof String ) {
                String value = (String)entry.getValue();
            	put(key, value);
            }
            else if( entry.getValue() instanceof Integer ) {
                int value = (int)entry.getValue();
            	put(key, value);
            }
            else {
                Object value = (Object)entry.getValue();
            	put(key, value);
            }
        }
		
    	this.toString();
        
    }
    
    @SuppressWarnings("unchecked")
	private HashMap<String, Object> getSession(){
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession httpSession = servletRequestAttribute.getRequest().getSession(true);
        
        return (HashMap<String, Object>) httpSession.getAttribute("memInfo");
    }

    

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String toString() {
		
        Set set2 = this.entrySet();
        Iterator iterator2 = set2.iterator();
        StringBuffer sb = new StringBuffer();
        while(iterator2.hasNext()){
            Entry<String, Object> entry = (Entry)iterator2.next();
            String key = (String)entry.getKey();
            if( entry.getValue() instanceof String ) {
                String value = (String)entry.getValue();
                sb.append(key + "=" + value + ","); 
                if(logger.isInfoEnabled()) logger.info("[RequestMap] Key : " + key + ", Value : " + value);
            }
            else if( entry.getValue() instanceof Integer ) {
                int value = (int)entry.getValue();
                sb.append(key + "=" + value + ","); 
                if(logger.isInfoEnabled()) logger.info("[RequestMap] Key : " + key + ", Value : " + value);
            }
            else {
                Object value = (Object)entry.getValue();
                sb.append(key + "=" + value + ","); 
                if(logger.isInfoEnabled()) logger.info("[RequestMap] Key : " + key + ", Value : " + value);
            }
        }

        if(logger.isInfoEnabled()) logger.info(sb.toString());
		return sb.toString();
	}
    
    
}
