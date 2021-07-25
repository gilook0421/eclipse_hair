package hair.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.board.dao.BoardDAO;

@Service
public class BoardService {

	private static final Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	@Inject
	private BoardDAO boardDao;
	
	// 글쓰기
	public HashMap<String, Object> boardWrite(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("impl BoardWrite");
		HashMap<String, Object> result = new HashMap<>();
		
		//param.setBod_id( memberVO.getMem_id() );
		boardDao.boardWrite(param);
		
		result.put("data", "");
		
		return result;
	}
	
	// 게시판 리스트
	public HashMap<String, Object> boardList() throws Exception{
	
		List<Object> board = new ArrayList<>();
		board = boardDao.boardList();
				
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", board);
		
		return result; 
	}
	
}
