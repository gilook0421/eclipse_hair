package hair.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.product.service.ProductService;
import hair.support.HandlerMap.RequestMap;
import hair.support.excelAjax.ExcelMakeUtilSXSSF;
import hair.support.paging.DefaultPaginationManager;
import hair.support.paging.PaginationInfo;
import hair.support.paging.PaginationManager;
import hair.support.paging.PaginationRenderer;

//@RestController
@Controller
@RequestMapping("/product")
public class ProductController {

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Resource
	ProductService service;
	
	// 리스트 뷰
	@RequestMapping(value="/productListView.api", method=RequestMethod.GET)
	public String productListView() throws Exception{
		return "product/productList";
	}
	

	// 리스트
	@ResponseBody
	@RequestMapping(value="/productList.api", method=RequestMethod.POST)
	public HashMap<String, Object> productList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) throws Exception{

        //if(logger.isInfoEnabled()) logger.info("[RequestMap] paramMap : " + paramMap.toString());
        
        RequestMap param = new RequestMap(paramMap);
		int pageIndex = param.get("pageIndex")==null?1:(int) param.get("pageIndex");
		int mntViewCnt = param.get("mntViewCnt")==null?10:(int) param.get("mntViewCnt");
		int pageSize = param.get("pageSize")==null?5:(int) param.get("pageSize");
		int listCnt = service.productListCnt(param);
		
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
		List<HashMap<String, Object>> data = service.productList(param);
		
		HashMap<String, Object> view = new HashMap<>();
		view.put("data", data);
		view.put("paging", pageContents);
		
		return view;
	}
	
	
	// 생성 
	@ResponseBody
	@RequestMapping(value="/productWrite.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductWrite(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		String prod_name = param.get("prod_name")==null?"":(String) param.get("prod_name");
		String prod_price = param.get("prod_price")==null?"":(String) param.get("prod_price");
		String prod_use_yn = param.get("prod_use_yn")==null?"":(String) param.get("prod_use_yn");
		if("".equals(prod_name) || "".equals(prod_price) || "".equals(prod_use_yn)) {
			throw new RuntimeException("파라미터 null 오류."); 
		}
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.productWrite(param);
		
		return view;
	}
	

	// 변경
	@ResponseBody
	@RequestMapping(value="/productUpd.api", method=RequestMethod.POST)
	public HashMap<String, Object> productUpd(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		String prod_ymd = param.get("prod_ymd")==null?"":(String) param.get("prod_ymd");
		String prod_no = param.get("prod_no")==null?"":(String) param.get("prod_no");
		String prod_name = param.get("prod_name")==null?"":(String) param.get("prod_name");
		String prod_price = param.get("prod_price")==null?"":(String) param.get("prod_price");
		String prod_use_yn = param.get("prod_use_yn")==null?"":(String) param.get("prod_use_yn");

		if("".equals(prod_ymd) || "".equals(prod_no) || "".equals(prod_name) || "".equals(prod_price) || "".equals(prod_use_yn)) {
			throw new RuntimeException("파라미터 null 오류."); 
		}
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.productUpd(param);
		
		return view;
	}

	// 삭제
	@ResponseBody
	@RequestMapping(value="/productDel.api", method=RequestMethod.POST)
	public HashMap<String, Object> productDel(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) throws Exception{

        RequestMap param = new RequestMap(paramMap);
		String prod_ymd = param.get("prod_ymd")==null?"":(String) param.get("prod_ymd");
		String prod_no = param.get("prod_no")==null?"":(String) param.get("prod_no");
		if("".equals(prod_ymd) || "".equals(prod_no)) {
			throw new RuntimeException("파라미터 null 오류."); 
		}
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.productDel(param);
		
		return view;
	}
	
	// excelDown
	@RequestMapping(value="/prodExcelDown.api", method=RequestMethod.POST)
	public void prodExcelDown(HttpServletRequest request, HttpServletResponse response) throws Exception{

		String prod_name = request.getParameter("prod_name")==null?"":(String) request.getParameter("prod_name");
		String prod_price = request.getParameter("prod_name")==null?"":(String) request.getParameter("prod_price");
		String prod_use_yn = request.getParameter("prod_name")==null?"":(String) request.getParameter("prod_use_yn");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("prod_name", prod_name);
		paramMap.put("prod_price", prod_price);
		paramMap.put("prod_use_yn", prod_use_yn);
		
        RequestMap param = new RequestMap(paramMap);
		List<HashMap<String, Object>> data = service.prodExcelDown(param);
        
		// title,col,type
		String[] header = {
				"ymd:PROD_YMD:String"
				,"no:PROD_NO:String"
				,"상품:PROD_NAME:String"
				,"가격:PROD_PRICE:String"
				,"사용여부:PROD_USE_YN:String"
				,"비고:PROD_ETC:String"
		};
		
		ExcelMakeUtilSXSSF.excelMaker(header, data, "상품관리", response);
		
	}
	
	
}
