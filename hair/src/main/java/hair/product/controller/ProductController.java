package hair.product.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.product.service.ProductService;
import hair.support.HandlerMap.RequestMap;

//@RestController
@Controller
@RequestMapping("/product")
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Resource
	ProductService service;
	
	// 상품 리스트 뷰
	@RequestMapping(value="/productListView.api", method=RequestMethod.GET)
	public String productListView() throws Exception{
		return "product/productList";
	}
	

	// 상품 리스트
	@ResponseBody
	@RequestMapping(value="/productList.api", method=RequestMethod.POST)
	public HashMap<String, Object> productList(@RequestBody RequestMap param, HttpServletRequest request) throws Exception{

		HashMap<String, Object> view = new HashMap<>();
		view.put("data", service.productList(param));
		
		return view;
	}
	
	
	// 상품 글쓰기
	@ResponseBody
	@RequestMapping(value="/productWrite.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductWrite(@RequestBody HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 0" + param.toString());
		HashMap<String, Object> view = new HashMap<>();
		view = service.write(param, request);
		
		return view;
	}
	
	// excelDown
	@ResponseBody
	@RequestMapping(value="/prodExcelDown.api", method=RequestMethod.POST)
	public Object prodExcelDown(HttpServletRequest request) throws Exception{
		
		return null;
	}
}
