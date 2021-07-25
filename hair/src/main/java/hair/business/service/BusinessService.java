package hair.business.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.business.dao.BusinessDAO;

@Service
public class BusinessService {

	private static final Logger logger = LoggerFactory.getLogger(BusinessService.class);
	
	@Inject
	private BusinessDAO dao;
	
	// 글쓰기
	public HashMap<String, Object> write(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 1" + param.toString());
		
		HashMap<String, Object> result = new HashMap<>();

			//param.setBusi_id(memberVO.get("Mem_id"));
			
			//if ( 0 == param.getBusi_no() ) {
				//신규
				dao.write(param);
			//}
			//else {
				// 변경
				dao.update(param);
			//}
		
		result.put("data", "");
		
		return result;
	}
	
	// 리스트
	public HashMap<String, Object> list(HttpServletRequest request) throws Exception{

		String mem_id = "";
		List<Object> board = new ArrayList<>();
		board = dao.list(mem_id);
				
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", board);
		
		return result; 
	}
	
}
