package hair.code.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.code.service.CodeService;

//@RestController
@Controller
@RequestMapping("/code")
public class CodeController {

	@Resource
	CodeService service;
	
	// 매출 리스트
	@ResponseBody
	@RequestMapping(value="/code.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductList(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.list(request);
		
		return view;
	}
	
	
}
