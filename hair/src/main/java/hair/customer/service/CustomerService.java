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
import hair.support.HandlerMap.RequestMap;

@Service
public class CustomerService {

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(CustomerService.class);
	
	@Inject
	private CustomerDAO dao;

	// 리스트 건수
	public int customerListCnt(RequestMap req) throws Exception{

		int rslt = dao.customerListCnt(req);
		
		return rslt; 
	}

	// 리스트
	public List<HashMap<String, Object>> customerList(RequestMap req) throws Exception{

		List<HashMap<String, Object>> board = new ArrayList<>();
		board = dao.customerList(req);
		
		return board; 
	}

	// 쓰기
	public HashMap<String, Object> customerWrite(RequestMap req) throws Exception{

		dao.customerWrite(req);

		return new HashMap<String, Object>();
	}

	// 변경
	public HashMap<String, Object> customerUpd(RequestMap req) throws Exception{

		dao.customerUpd(req);

		return new HashMap<String, Object>();
	}

	// 삭제
	public HashMap<String, Object> customerDel(RequestMap req) throws Exception{

		dao.customerDel(req);

		return new HashMap<String, Object>();
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
