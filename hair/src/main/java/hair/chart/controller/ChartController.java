package hair.chart.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//@RestController
@Controller
@RequestMapping("/chart")
public class ChartController {

	// 리스트
	@RequestMapping(value="/chartView.api", method=RequestMethod.GET)
	public String chartView(HttpServletRequest request) throws Exception{
		
		return "/chart/chartList";
	}
	
	
}
