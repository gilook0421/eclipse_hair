package hair.member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {

	@Inject
	SqlSession sqlSession = null;
	
	// 아이디 중복검사
	public int MemberCheckId(String id) throws Exception{
		return sqlSession.selectOne("member.checkId", id);
	}

	// 이메일 중복검사
	public int MemberCheckEmail(String email) throws Exception{
		return sqlSession.selectOne("member.checkEmail", email);
	}
	
	// 회원가입
	public int MemberJoin(HashMap<String, Object> member) throws Exception{
		return sqlSession.insert("member.join", member);
	}
	
	// 이메일 인증
	public int ApprovalMember(HashMap<String, Object> member) throws Exception{
		return sqlSession.update("member.approvalMember", member);
	}

	// 로그인 
	public HashMap<String, Object> Login(HashMap<String, Object> member) throws Exception{
		return sqlSession.selectOne("member.login", member);
	}
		
	// 로그인 접속일자 변경
	public int UpdateLog(String id) throws Exception{
		return sqlSession.update("member.updateLog", id);
	}
	
	// 아이디찾기
	public String FindId(String email) throws Exception{
		return sqlSession.selectOne("member.findId", email);
	}
	
	// 비밀번호 찾기
	public String FindPw(HashMap<String, Object> member) throws Exception{
		return sqlSession.selectOne("member.findPw", member);
	}
	
	// 비밀번호 변경
	public int UpdatePw(HashMap<String, Object> member) throws Exception{
		return sqlSession.update("member.updatePw", member);
	}
	
	// 회원탈퇴
	public int MemberLeave(HashMap<String, Object> member)throws Exception{
		return sqlSession.delete("member.memberLeave", member);
	}
	
	// 회원리스트
	public List<Object> MemberList( ) throws Exception{
		List<Object> arr = new ArrayList<>(); 
		arr = sqlSession.selectList("member.memberList");

		return arr;
	}
	
}
