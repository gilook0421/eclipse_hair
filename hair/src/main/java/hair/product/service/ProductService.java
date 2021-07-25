package hair.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.product.dao.ProductDAO;
import hair.support.HandlerMap.RequestMap;

@Service
public class ProductService {

	private static final Logger logger = LoggerFactory.getLogger(ProductService.class);
	
	@Inject
	private ProductDAO dao;
	
	// 글쓰기
	public HashMap<String, Object> write(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 1" + param.toString());
		
		HashMap<String, Object> result = new HashMap<>();
			HashMap<String, Object> req = param;
			//req.put("Prod_id", (String)memberVO.get("Mem_id"));
			dao.write(req);
		
		result.put("data", "");
		
		return result;
	}
	
	// 게시판 리스트
	public List<HashMap<String, Object>> productList(RequestMap req) throws Exception{

		List<HashMap<String, Object>> board = new ArrayList<>();
		board = dao.productList(req);
		
		return board; 
	}
	
}
