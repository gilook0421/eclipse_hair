package hair.customer.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDAO {

	@Inject
	SqlSession sqlSession;
	
	// 손님등록
	public int write(HashMap<String, Object> VO) throws Exception{
		return sqlSession.insert("customer.write", VO);
	}
	
	// 손님리스트
	public List<Object> list(String mem_id) throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("customer.list", mem_id);
		
		return arr;
	}
	
	// 손님검색
	public List<Object> selectOne(HashMap<String, Object> param)	throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("customer.selectOne", param);
		
		return arr;
	}
	
}
