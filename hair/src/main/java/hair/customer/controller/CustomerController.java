package hair.customer.controller;

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

import hair.customer.service.CustomerService;
import hair.support.HandlerMap.RequestMap;
import hair.support.paging.DefaultPaginationManager;
import hair.support.paging.PaginationInfo;
import hair.support.paging.PaginationManager;
import hair.support.paging.PaginationRenderer;

//@RestController
@Controller
@RequestMapping("/customer")
public class CustomerController {

	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);
	
	@Resource
	CustomerService service;
	
	// 리스트 뷰
	@RequestMapping(value="/customerListView.api", method=RequestMethod.GET)
	public String customerListView() throws Exception{
		return "customer/customerList";
	}

	// 리스트
	@ResponseBody
	@RequestMapping(value="/customerList.api", method=RequestMethod.POST)
	public HashMap<String, Object> customerList(@RequestBody Map<String, Object> paramMap) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		int pageIndex = param.get("pageIndex")==null?1:(int) param.get("pageIndex");
		int mntViewCnt = param.get("mntViewCnt")==null?10:(int) param.get("mntViewCnt");
		int pageSize = param.get("pageSize")==null?5:(int) param.get("pageSize");
		int listCnt = service.customerListCnt(param);
		
		// pageRenderer
		PaginationManager pageManager = new DefaultPaginationManager();
		PaginationRenderer pageRenderger = pageManager.getRendererType("image");
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setCurrentPageNo(pageIndex);
		pageInfo.setRecordCountPerPage(mntViewCnt);
		pageInfo.setPageSize(pageSize);
		pageInfo.setTotalRecordCount(listCnt);
		String pageContents = pageRenderger.renderPagination(pageInfo, "pageJs.pageMove");
		// --pageRenderer
		
		param.put("pageIndex", (pageIndex -1)*10);
		param.put("mntViewCnt", mntViewCnt);
		param.put("pageSize", pageSize);
		List<HashMap<String, Object>> data = service.customerList(param);
		
		HashMap<String, Object> view = new HashMap<>();
		view.put("data", data);
		view.put("paging", pageContents);
		
		return view;
	}
	
	// 생성
	@ResponseBody
	@RequestMapping(value="/customerWrite.api", method=RequestMethod.POST)
	public HashMap<String, Object> customerWrite(@RequestBody Map<String, Object> paramMap) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		String cust_name = param.get("cust_name")==null?"":(String) param.get("cust_name");
		String cust_phone1 = param.get("cust_phone1")==null?"":(String) param.get("cust_phone1");
		String cust_sex = param.get("cust_sex")==null?"":(String) param.get("cust_sex");
		String cust_etc = param.get("cust_etc")==null?"":(String) param.get("cust_etc");
		if("".equals(cust_name) || "".equals(cust_phone1) || "".equals(cust_sex)) {
			throw new RuntimeException("파라미터 null 오류."); 
		}
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.customerWrite(param);
		
		return view;
	}
	

	// 변경
	@ResponseBody
	@RequestMapping(value="/customerUpd.api", method=RequestMethod.POST)
	public HashMap<String, Object> customerUpd(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		String cust_ymd = param.get("cust_ymd")==null?"":(String) param.get("cust_ymd");
		String cust_no = param.get("cust_no")==null?"":(String) param.get("cust_no");
		String cust_name = param.get("cust_name")==null?"":(String) param.get("cust_name");
		String cust_phone1 = param.get("cust_phone1")==null?"":(String) param.get("cust_phone1");
		String cust_phone2 = param.get("cust_phone2")==null?"":(String) param.get("cust_phone2");
		String cust_phone3 = param.get("cust_phone3")==null?"":(String) param.get("cust_phone3");
		String cust_sex = param.get("cust_sex")==null?"":(String) param.get("cust_sex");
		String cust_etc = param.get("cust_etc")==null?"":(String) param.get("cust_etc");

		if("".equals(cust_ymd) || "".equals(cust_no) || "".equals(cust_name) || "".equals(cust_phone1) || "".equals(cust_sex)) {
			throw new RuntimeException("파라미터 null 오류."); 
		}
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.customerUpd(param);
		
		return view;
	}

	// 삭제
	@ResponseBody
	@RequestMapping(value="/customerDel.api", method=RequestMethod.POST)
	public HashMap<String, Object> customerDel(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		String cust_ymd = param.get("cust_ymd")==null?"":(String) param.get("cust_ymd");
		String cust_no = param.get("cust_no")==null?"":(String) param.get("cust_no");
		if("".equals(cust_ymd) || "".equals(cust_no)) {
			throw new RuntimeException("파라미터 null 오류."); 
		}
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.customerDel(param);
		
		return view;
	}
	
}
