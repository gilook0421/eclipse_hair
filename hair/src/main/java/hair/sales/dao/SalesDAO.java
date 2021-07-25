package hair.sales.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class SalesDAO {

	@Inject
	SqlSession sqlSession;
	
	// 상품등록
	public int write(HashMap<String, Object> VO) throws Exception{
		return sqlSession.insert("sales.sales_write", VO);
	}
	
	// 상품리스트
	public List<Object> list(HashMap<String, Object> param) throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("sales.sales_list", param);
		
		return arr;
	}

	// 다중등록
	public int foreachIns(HashMap<String, Object> param) throws Exception{
		return sqlSession.insert("sales.sales_foreachIns", param);
	}

	// 손님검색
	public List<Object> selectOne(HashMap<String, Object> param)	throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("sales.sales_selectOne", param);
		
		return arr;
	}
}
