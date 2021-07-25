package hair.restBoard.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class RestBoardDAO {

	@Inject
	SqlSession sqlSession;
	
	// 게시판글 작성
	public int boardWrite(HashMap<String, Object> boardVO) throws Exception{
		return sqlSession.insert("board.boardWrite", boardVO);
	}
}
