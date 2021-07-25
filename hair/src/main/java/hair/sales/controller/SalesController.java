package hair.sales.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.sales.service.SalesService;

//@RestController
@Controller
@RequestMapping("/sales")
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);
	
	@Resource
	SalesService service;
	
	// 매출 리스트 뷰
	@RequestMapping(value="/salesListView.api", method=RequestMethod.GET)
	public String ProductListView() throws Exception{
		return "sales/salesList";
	}
	
	
	// 매출 글쓰기
	@ResponseBody
	@RequestMapping(value="/salesWrite.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductWrite(HttpServletRequest request, @RequestBody String param) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 0" + param.toString());
		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 0" + request.getParameter("obj").toString());
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.write(param, request);
		
		return view;
	}
	
	// 매출 리스트
	@ResponseBody
	@RequestMapping(value="/salesList.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductList(@ModelAttribute HashMap<String, Object> param) throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.list(param);
		
		return view;
	}
	
	// 손님검색
	@ResponseBody
	@RequestMapping(value="/customerOnce.api", method=RequestMethod.POST)
	public HashMap<String, Object> customerOnce(@ModelAttribute HashMap<String, Object> param, HttpServletRequest request) throws Exception{
	
		HashMap<String, Object> view = new HashMap<>();
		//view = customerService.selectOne(param, request);
		view = service.selectOne(param, request);
		
		return view;
	}
	
}
