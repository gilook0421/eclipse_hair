package hair.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//@RestController
@Controller
@RequestMapping("/main")
public class DashController {

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(DashController.class);
	
	
	// 상품 리스트 뷰
	@RequestMapping(value="/dashView.api", method=RequestMethod.GET)
	public String ProductListView() throws Exception{
		return "main/dashBoard";
	}
	
	
}
