package hair.restBoard.service;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.restBoard.dao.RestBoardDAO;

@Service
public class RestBoardService{

	private static final Logger logger = LoggerFactory.getLogger(RestBoardService.class);
	
	@Inject
	private RestBoardDAO restBoardDao;
	
	public HashMap<String, Object> boardWrite(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("impl BoardWrite");
		HashMap<String, Object> result = new HashMap<>();
		
			//param.setId(memberVO.getMem_id());
			restBoardDao.boardWrite(param);
		
		result.put("data", "");
		
		return result;
	}
	
}
