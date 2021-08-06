package hair.sales.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.sales.service.SalesService;
import hair.support.HandlerMap.RequestMap;

//@RestController
@Controller
@RequestMapping("/sales")
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);
	
	@Resource
	SalesService service;
	
	// 리스트 뷰
	@RequestMapping(value="/salesListView.api", method=RequestMethod.GET)
	public String ProductListView() throws Exception{
		return "sales/salesList";
	}

	// 손님검색
	@ResponseBody
	@RequestMapping(value="/customerList.api", method=RequestMethod.POST)
	public HashMap<String, Object> customerList(@RequestBody HashMap<String, Object> paramMap) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
		data = service.customerList(param);

		HashMap<String, Object> view = new HashMap<>();
		view.put("data", data);
		
		return view;
	}

	// 매출 리스트
	@ResponseBody
	@RequestMapping(value="/salesHisList.api", method=RequestMethod.POST)
	public HashMap<String, Object> salesHisList(@RequestBody HashMap<String, Object> paramMap) throws Exception{
		
        RequestMap param = new RequestMap(paramMap);
		List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
		data = service.salesHisList(param);

		HashMap<String, Object> view = new HashMap<>();
		view.put("data", data);
		
		return view;
	}

	// 상품 리스트
	@ResponseBody
	@RequestMapping(value="/prodSearchList.api", method=RequestMethod.POST)
	public HashMap<String, Object> prodSearchList(@RequestBody HashMap<String, Object> paramMap) throws Exception{
		
		// 상품리스트
        RequestMap param = new RequestMap(paramMap);
		List<HashMap<String, Object>> prodData = new ArrayList<HashMap<String, Object>>();
		prodData = service.productList(param);
		
		HashMap<String, Object> view = new HashMap<>();
		view.put("prodData", prodData);
		
		return view;
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
	
	//글쓰기
	@ResponseBody
	@RequestMapping(value="/salesWrite2.api", method=RequestMethod.POST)
	public HashMap<String, Object> salesWrite2(@RequestBody Map<String, Object> paramMap) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		HashMap<String, Object> view = new HashMap<>();
		view = service.salesWrite2(param); 
		
		return view;
	}
	
}
