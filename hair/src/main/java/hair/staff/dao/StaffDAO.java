package hair.staff.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class StaffDAO {

	@Inject
	SqlSession sqlSession;
	
	// 사업장등록
	public int write(HashMap<String, Object> VO) throws Exception{
		return sqlSession.insert("staff.write", VO);
	}
	
	// 사업장리스트
	public List<Object> list(String busi_no) throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("staff.list", busi_no);
		
		return arr;
	}
	
}
