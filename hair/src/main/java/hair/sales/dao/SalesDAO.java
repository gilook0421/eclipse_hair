package hair.sales.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import hair.support.HandlerMap.RequestMap;

@Repository
public class SalesDAO {

	@Inject
	SqlSession sqlSession;

	// 손님검색
	public List<HashMap<String, Object>> customerList(RequestMap param)	throws Exception{
		return sqlSession.selectList("sales.customerList", param);
	}

	// 매출리스트
	public List<HashMap<String, Object>> salesHisList(RequestMap param) throws Exception{
		return sqlSession.selectList("sales.sales_list", param);
	}

	// 상품리스트
	public List<HashMap<String, Object>> productList(RequestMap param) throws Exception{
		return sqlSession.selectList("sales.sales_prod_list", param);
	}
	
	// 상품등록
	public int write(HashMap<String, Object> VO) throws Exception{
		return sqlSession.insert("sales.sales_write", VO);
	}

	public int salesWrite2(RequestMap VO) throws Exception{
		return sqlSession.insert("sales.sales_write", VO);
	}

	// 다중등록
	public int foreachIns(HashMap<String, Object> param) throws Exception{
		return sqlSession.insert("sales.sales_foreachIns", param);
	}

}
