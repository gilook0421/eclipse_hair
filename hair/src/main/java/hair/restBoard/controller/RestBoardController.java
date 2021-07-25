package hair.restBoard.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.restBoard.service.RestBoardService;

//@RestController
@Controller
@RequestMapping("/restBoard")
public class RestBoardController {

	private static final Logger logger = LoggerFactory.getLogger(RestBoardController.class);
	
	@Resource
	RestBoardService restBoardService;
	
	@RequestMapping(value="/listView.rest", method=RequestMethod.GET)
	public String BoardListView() throws Exception{

		if(logger.isDebugEnabled()) logger.debug("cont listView");
		return "board/boardList";
	}
	
	@RequestMapping(value="/writeView.rest", method=RequestMethod.GET)
	public String BoardListWriteView() throws Exception{

		if(logger.isDebugEnabled()) logger.debug("cont write");
		return "/board/boardWrite";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/boardWrite.rest", method=RequestMethod.POST)
	public HashMap<String, Object> BoardWrite(@ModelAttribute HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("cont BoardWrite");
		HashMap<String, Object> view = new HashMap<>();
		
		view = restBoardService.boardWrite(param, request);
		
		return view;
	}
	
	@ResponseBody
	@RequestMapping(value="/boardList.rest", method=RequestMethod.POST)
	public HashMap<String, Object> BoardList() throws Exception{
		if(logger.isDebugEnabled()) logger.debug("cont BoardList");
		HashMap<String, Object> view = new HashMap<>();
		
		return view;
	}
	
}
