package hair.business.controller;

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

import hair.business.service.BusinessService;
import hair.customer.service.CustomerService;

//@RestController
@Controller
@RequestMapping("/business")
public class BusinessController {

	private static final Logger logger = LoggerFactory.getLogger(BusinessController.class);
	
	@Resource
	BusinessService service;
	
	@Resource
	CustomerService customerService;
	
	// 리스트 뷰
	@RequestMapping(value="/businessListView.api", method=RequestMethod.GET)
	public String ProductListView() throws Exception{
		return "business/businessList";
	}
	
	
	// 글쓰기
	@ResponseBody
	@RequestMapping(value="/businessWrite.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductWrite(@ModelAttribute HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 0" + param.toString());
		HashMap<String, Object> view = new HashMap<>();
		view = service.write(param, request);
		
		return view;
	}
	
	// 리스트
	@ResponseBody
	@RequestMapping(value="/businessList.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductList(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();	
		view = service.list(request);
		
		return view;
	}
	
	
}
