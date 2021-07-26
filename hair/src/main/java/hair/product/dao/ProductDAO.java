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
	
	// 등록
	public int write(RequestMap req) throws Exception{
		return sqlSession.insert("product.write", req);
	}
	
	// 리스트
	public List<HashMap<String, Object>> productList(RequestMap req) throws Exception{
		
		return sqlSession.selectList("product.list", req);
	}

	// 리스트건수
	public int productListCnt(RequestMap req) throws Exception{
		
		return sqlSession.selectOne("product.listCnt", req);
	}
	
}
