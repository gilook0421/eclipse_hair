package hair.product.controller;

import java.util.HashMap;
import java.util.List;

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
	
	// 상품 리스트 뷰
	@RequestMapping(value="/productListView.api", method=RequestMethod.GET)
	public String productListView() throws Exception{
		return "product/productList";
	}
	

	// 상품 리스트
	@ResponseBody
	@RequestMapping(value="/productList.api", method=RequestMethod.POST)
	public HashMap<String, Object> productList(@RequestBody RequestMap param, HttpServletRequest request) throws Exception{

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
	
	
	// 상품 글쓰기
	@ResponseBody
	@RequestMapping(value="/productWrite.api", method=RequestMethod.POST)
	public HashMap<String, Object> ProductWrite(@RequestBody RequestMap param, HttpServletRequest request) throws Exception{

		String prod_name = param.get("prod_name")==null?"":(String) param.get("prod_name");
		String prod_price = param.get("prod_name")==null?"":(String) param.get("prod_price");
		String prod_use_yn = param.get("prod_name")==null?"":(String) param.get("prod_use_yn");
		if("".equals(prod_name) || "".equals(prod_price) || "".equals(prod_use_yn)) {
			throw new RuntimeException("파라미터 null 오류."); 
		}
		//, #{prod_name}
		//, #{prod_price}
		//, #{prod_use_yn}
		
		HashMap<String, Object> view = new HashMap<>();
		view = service.write(param);
		
		return view;
	}
	
	// excelDown
	@ResponseBody
	@RequestMapping(value="/prodExcelDown.api", method=RequestMethod.POST)
	public Object prodExcelDown(HttpServletRequest request) throws Exception{
		
		return null;
	}
}
