package hair.code.dao;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CodeDAO {

	@Inject
	SqlSession sqlSession;
	
	// 상품리스트
	public List<Object> list(HttpServletRequest request) throws Exception{
		List<Object> arr = new ArrayList<>();
		
		String flag = request.getParameter("flag");
		String mem_id = (String)request.getAttribute("mem_id");
		if ( "staff".equals(flag) ) {
			arr = sqlSession.selectList("code.staff", mem_id);
		}
		else if ( "product".equals(flag) ) {
			arr = sqlSession.selectList("code.product", mem_id);
		}
		
		return arr;
	}
	
}
