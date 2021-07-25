package hair.staff.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.staff.dao.StaffDAO;

@Service
public class StaffService{

	private static final Logger logger = LoggerFactory.getLogger(StaffService.class);
	
	@Inject
	private StaffDAO dao;
	
	// 글쓰기
	public HashMap<String, Object> write(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 1" + param.toString());
		
		HashMap<String, Object> result = new HashMap<>();

		{
			//param.setStaff_busi(request.getParameter("staff_busi"));
			//param.setStaff_name(request.getParameter("staff_name"));
			//param.setStaff_phone1(request.getParameter("staff_phone1"));
			//param.setStaff_memo(request.getParameter("staff_memo"));
			//param.setStaff_id(memberVO.getMem_id());
			dao.write(param);
		}
		
		result.put("data", "");
		
		return result;
	}
	
	// 리스트
	public HashMap<String, Object> list(HttpServletRequest request) throws Exception{
	
		List<Object> board = new ArrayList<>();
		board = dao.list(request.getParameter("busi_no"));
				
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", board);
		
		return result; 
	}
	
}
