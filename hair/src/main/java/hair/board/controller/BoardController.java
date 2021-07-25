package hair.board.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.board.service.BoardService;

//@RestController
@Controller
@RequestMapping("/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource
	BoardService boardService;
	
	// 게시판 리스트 뷰
	@RequestMapping(value="/listView.api", method=RequestMethod.GET)
	public String BoardListView() throws Exception{

		if(logger.isDebugEnabled()) logger.debug("cont listView");
		return "board/boardList";
	}
	
	// 게시판 글쓰기 뷰
	@RequestMapping(value="/writeView.api", method=RequestMethod.GET)
	public String BoardListWriteView() throws Exception{

		if(logger.isDebugEnabled()) logger.debug("cont write");
		return "board/boardWrite.bar";
	}
	
	// 게시판 글쓰기
	@ResponseBody
	@RequestMapping(value="/boardWrite.api", method=RequestMethod.POST)
	public HashMap<String, Object> BoardWrite(@RequestParam HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("cont BoardWrite");
		HashMap<String, Object> view = new HashMap<>();
		
		view = boardService.boardWrite(param, request);
		
		return view;
	}
	
	// 게시판 리스트
	@ResponseBody
	@RequestMapping(value="/boardList.api", method=RequestMethod.POST)
	public HashMap<String, Object> BoardList() throws Exception{
		if(logger.isDebugEnabled()) logger.debug("cont BoardList");
		
		HashMap<String, Object> view = new HashMap<>();
		view = boardService.boardList();
		
		return view;
	}
	
}
