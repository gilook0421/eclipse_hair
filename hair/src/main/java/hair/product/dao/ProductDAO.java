package hair.product.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import hair.support.HandlerMap.RequestMap;

@Repository
public class ProductDAO {

	@Inject
	SqlSession sqlSession;
	
	// 상품등록
	public int write(HashMap<String, Object> VO) throws Exception{
		return sqlSession.insert("product.write", VO);
	}
	
	// 상품리스트
	public List<HashMap<String, Object>> productList(RequestMap req) throws Exception{
		
		return sqlSession.selectList("product.list", req);
	}
	
}
