package hair.customer.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.customer.dao.CustomerDAO;

@Service
public class CustomerService {

	private static final Logger logger = LoggerFactory.getLogger(CustomerService.class);
	
	@Inject
	private CustomerDAO dao;
	
	// 글쓰기
	public HashMap<String, Object> write(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 1" + param.toString());
		
		HashMap<String, Object> result = new HashMap<>();

			//param.setCust_id(memberVO.getMem_id());
			dao.write(param);
		
		result.put("data", "");
		
		return result;
	}
	
	// 게시판 리스트
	public HashMap<String, Object> list(HttpServletRequest request) throws Exception{

		String mem_id = "";
		List<Object> board = new ArrayList<>();
		board = dao.list(mem_id);
				
		HashMap<String, Object> result = new HashMap<>();
		//result.put("msg", commonVO);
		result.put("data", board);
		
		return result; 
	}
	
	// 손님 조회
	public HashMap<String, Object> selectOne(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

			//param.setCust_id( memberVO.get("Mem_id") );
		
		List<Object> list = new ArrayList<>();
		list = dao.selectOne(param);
				
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", list);
		
		return result;
	}
	
}
