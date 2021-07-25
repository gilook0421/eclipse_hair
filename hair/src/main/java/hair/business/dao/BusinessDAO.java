package hair.business.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BusinessDAO {

	@Inject
	SqlSession sqlSession;
	
	// 사업장등록
	public int write(HashMap<String, Object> VO) throws Exception{
		return sqlSession.insert("business.write", VO);
	}
	
	// 사업장변경
	public int update(HashMap<String, Object> VO) throws Exception{
		return sqlSession.insert("business.update", VO);
	}
	
	// 사업장리스트
	public List<Object> list(String mem_id) throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("business.list", mem_id);
		
		return arr;
	}
	
}
