package hair.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {

	@Inject
	SqlSession sqlSession;
	
	// 게시판글 작성
	public int boardWrite(HashMap<String, Object> boardVO) throws Exception{
		return sqlSession.insert("board.boardWrite", boardVO);
	}
	
	// 게시판 리스트
	public List<Object> boardList() throws Exception{
		List<Object> arr = new ArrayList<>();
		arr = sqlSession.selectList("board.boardList");
		
		return arr;
	}
	
}
