package hair.code.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import hair.code.dao.CodeDAO;

@Service
public class CodeService {

	@Inject
	private CodeDAO dao;
	
	// 게시판 리스트
	public HashMap<String, Object> list(HttpServletRequest request) throws Exception{

		String mem_id = "";
		request.setAttribute("mem_id", mem_id);
		
		List<Object> board = new ArrayList<>();
		board = dao.list(request);
				
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", board);
		
		HashMap<String, Object> user = new HashMap<>(); 
		
		result.put("user", user);
		
		return result; 
	}
}
