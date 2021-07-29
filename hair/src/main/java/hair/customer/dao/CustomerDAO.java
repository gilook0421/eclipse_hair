package hair.customer.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import hair.support.HandlerMap.RequestMap;

@Repository
public class CustomerDAO {

	@Inject
	SqlSession sqlSession;

	// 리스트건수
	public int customerListCnt(RequestMap req) throws Exception{
		
		return sqlSession.selectOne("customer.listCnt", req);
	}
	
	// 리스트
	public List<HashMap<String, Object>> customerList(RequestMap req) throws Exception{
		
		return sqlSession.selectList("customer.list", req);
	}

	// 등록
	public int customerWrite(RequestMap req) throws Exception{
		return sqlSession.insert("customer.write", req);
	}
	
	// 변경
	public int customerUpd(RequestMap req) throws Exception{
		return sqlSession.update("customer.upd", req);
	}

	// 삭제
	public int customerDel(RequestMap req) throws Exception{
		return sqlSession.delete("customer.del", req);
	}
	
	// 손님검색
	public List<Object> selectOne(HashMap<String, Object> param)	throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("customer.selectOne", param);
		
		return arr;
	}
	
}
