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

	// 리스트건수
	public int productListCnt(RequestMap req) throws Exception{
		
		return sqlSession.selectOne("product.listCnt", req);
	}
	
	// 리스트
	public List<HashMap<String, Object>> productList(RequestMap req) throws Exception{
		
		return sqlSession.selectList("product.list", req);
	}

	// 등록
	public int productWrite(RequestMap req) throws Exception{
		return sqlSession.insert("product.write", req);
	}
	
	// 변경
	public int productUpd(RequestMap req) throws Exception{
		return sqlSession.update("product.upd", req);
	}

	// 삭제
	public int productDel(RequestMap req) throws Exception{
		return sqlSession.delete("product.del", req);
	}
}
