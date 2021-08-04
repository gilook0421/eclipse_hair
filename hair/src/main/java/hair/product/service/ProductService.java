package hair.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.product.dao.ProductDAO;
import hair.support.HandlerMap.RequestMap;

@Service
public class ProductService {

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ProductService.class);
	
	@Inject
	private ProductDAO dao;

	// 리스트 건수
	public int productListCnt(RequestMap req) throws Exception{

		int rslt = dao.productListCnt(req);
		
		return rslt; 
	}
	
	// 리스트
	public List<HashMap<String, Object>> productList(RequestMap req) throws Exception{

		List<HashMap<String, Object>> board = new ArrayList<>();
		board = dao.productList(req);
		
		return board; 
	}

	// 쓰기
	public HashMap<String, Object> productWrite(RequestMap req) throws Exception{

		dao.productWrite(req);

		return new HashMap<String, Object>();
	}

	// 변경
	public HashMap<String, Object> productUpd(RequestMap req) throws Exception{

		dao.productUpd(req);

		return new HashMap<String, Object>();
	}

	// 삭제
	public HashMap<String, Object> productDel(RequestMap req) throws Exception{

		dao.productDel(req);

		return new HashMap<String, Object>();
	}

	// 엑셀다운로드
	public List<HashMap<String, Object>> prodExcelDown(RequestMap req) throws Exception{

		List<HashMap<String, Object>> board = new ArrayList<>();
		board = dao.prodExcelDown(req);
		
		return board; 
	}
	
}
