package hair.member.service;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.member.dao.MemberDAO;

@Service
public class MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Inject
	private MemberDAO memberDao;
	
	// 회원가입 화면 이동
	public void MemberInit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(logger.isDebugEnabled()) logger.debug("member serviceImpl {MemberInit}");
	}

	// 아이디 중복검사
	public HashMap<String, Object> MemberCheckId(HashMap<String, Object> param) throws Exception {
		if(logger.isDebugEnabled()) logger.debug("member serviceImpl {MemberCheckId}");
		
//		PrintWriter pw = response.getWriter();
//		pw.println(memberDao.checkId(id));
//		pw.close();

		HashMap<String, Object> result = new HashMap<>();

		if ( 0 != memberDao.MemberCheckId( (String)param.get("mem_id") ) ) {
			result.put("data", "");
			
			return result;
		}
		
		result.put("data", "" );
		
		return result;
	}
	
	// 이메일 중복검사
	public HashMap<String, Object> MemberCheckEmail(HashMap<String, Object> param) throws Exception {
		if(logger.isDebugEnabled()) logger.debug("member serviceImpl {MemberCheckEmail}");

		HashMap<String, Object> result = new HashMap<>();
		result.put("data", memberDao.MemberCheckEmail( (String) param.get("mem_email") ) );
		
		return result;
	}
	
	// 회원가입
	public HashMap<String, Object> MemberJoin(HashMap<String, Object> param) throws Exception {
		if(logger.isDebugEnabled()) logger.debug("member serviceImpl {MemberJoin}");

		HashMap<String, Object> result = new HashMap<>();
		
		// 중복아이디체크 
		if ( 0 != memberDao.MemberCheckId( (String)param.get("Mem_id") ) ) {
			result.put("data", "");
			
			return result;
		}

		
		// 비관리자
		if ( "N".equals( param.get("Mem_manager_yn") ) ) {

			// 인증키 생성
			//param.setMem_email_approval_key( (String) CreateKey() );
			
			//param.setMem_email(param.getMem_id() + "@gwgroup.com");
			//param.setMem_email_approval_status("T");
			
			// 가입성공
			if ( 1 != memberDao.MemberJoin(param) ) {
				memberDao.MemberLeave(param);
			}
			
		}
		// 관리자
		else {

			// 중복이메일체크
			if ( 0 != memberDao.MemberCheckEmail( (String)param.get("Mem_email") ) ) {
				result.put("data", "");
				
				return result;
			}
			
			// 인증키 생성
			//param.setMem_email_approval_key( (String) CreateKey() );
			
			//param.setMem_email_approval_status("F");
			
			// 가입성공
			if ( 1 != memberDao.MemberJoin(param) ) {
				if ( SendMail(param, "welcome") ) {
					memberDao.MemberLeave(param);
				}
			}
			
		}

		result.put("data", "");
		
		return result;
	}

	public String CreateKey() throws Exception{
	
		String key = "";
		Random ran = new Random();
		
		for( int i = 0 ; i < 8; i++ ) {
			key += ran.nextInt(10);
		}
		
		return key; 
	}
	
	
	public boolean SendMail(HashMap<String, Object> param, String div) throws Exception{
		boolean sendYn = false;
		// mail server - naver
//		String charSet = "utf-8";
//		String hostSMTP = "smtp.naver.com";
//		String hostSMTPId = "80gilook";
//		String hostSMTPPwd = "na180418";
//		// 보내는사람 email, title, content
//		String fromEmail = "80gilook@naver.com";
//		String fromName = "GWGroup Ltd.";
//		String subject = "";
//		String msg = "";

		// mail server - gmail
//		String charSet = "utf-8";
//		String hostSMTP = "smtp.gmail.com";
//		String hostSMTPId = "gilook0421";
//		String hostSMTPPwd = "Gm18041804!";
		// 보내는사람 email, title, content
//		String fromEmail = "gilook0421@gmail.com";
//		String fromName = "GWGroup Ltd.";
//		String subject = "";
//		String msg = "";

		// mail server - daum
		String charSet = "utf-8";
		String hostSMTP = "smtp.daum.net";
		String hostSMTPId = "80gilook";
		String hostSMTPPwd = "da180418";
		// 보내는사람 email, title, content
		String fromEmail = "80gilook@daum.net";
		String fromName = "GWGroup Ltd.";
		String subject = "";
		String msg = "";
		
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		if ( "welcome".equals(div) ) {

			// 회원가입메일내용
			subject = "[ " + fromName + " ] 회원가입 인증 메일입니다.( "+sdf.format(dt)+" )";
			
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += param.get("Mem_name") + "(" + param.get("Mem_id") + ")님 회원가입을 환영합니다.</h3>";
			msg += "<div style='font-size: 130%'>";
			msg += "하단의 인증 버튼 클릭 시 정상적으로 회원가입이 완료됩니다.</div><br/>";
			msg += "<form method='post' action='http://localhost:8080/member/approvalMember.api'>";
			msg += "<input type='hidden' name='mem_email' value='" + param.get("Mem_email") + "'>";
			msg += "<input type='hidden' name='mem_email_approval_key' value='" + param.get("Mem_email_approval_key") + "'>";
			msg += "<input type='submit' value='인증'></form><br/></div>";	
		}
		else if ( "pwInit".equals(div) ){

			// 비밀번호 초기화
			subject = "[ " + fromName + " ] 임시 비밀번호 입니다.( "+sdf.format(dt)+" )";

			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += param.get("Mem_name") + "(" + param.get("Mem_id") + ")님의 임시 비밀번호 입니다. \n비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += param.get("Mem_pw") + "</p></div>";

		}
		else {
			if(logger.isDebugEnabled()) logger.debug("email구분값이 존재하지 않습니다.");
		}

		// 받는 사람 email주소
		String mail = (String)param.get("Mem_email");
		
		HtmlEmail email = new HtmlEmail();
		email.setDebug(true);
		email.setCharset(charSet);
		email.setSSL(true);
		email.setHostName(hostSMTP);
		email.setSmtpPort(587);
		email.setAuthentication(hostSMTPId, hostSMTPPwd);
		email.setTLS(true);
		email.addTo(mail, charSet);
		email.setFrom(fromEmail, fromName, charSet);
		email.setSubject(subject);
		email.setHtmlMsg(msg);
		email.send();
		
		sendYn = true;
		
		return sendYn;
	}

	// 회원인증
	public int ApprovalMember(HashMap<String, Object> param, HttpServletResponse response) throws Exception{
		int result = 0;
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		if ( 1 == memberDao.ApprovalMember(param) ) {
			// 인증성공
			if(logger.isDebugEnabled()) logger.debug("member serviceImpl {approvalMember success.}");
			result = 1;
			
			out.println("<script>");
			out.println("alert('인증이 완료되었습니다. 로그인 후 이용하세요.');");
			out.println("location.href='../';");
			out.println("</script>");
			out.close();
		}
		else {
			// 인증실패
			if(logger.isDebugEnabled()) logger.debug("member serviceImpl {approvalMember fail.}");
			
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}
		
		return result;
	}
	
	// 로그인
	public HashMap<String, Object> MemberLogin(HashMap<String, Object> param, HttpServletRequest request) throws Exception{
		if(logger.isDebugEnabled()) logger.debug("param : " + param.toString());
		
		HashMap<String, Object> rslt = new HashMap<>();
		rslt = memberDao.Login(param);

		if ( rslt != null ) {
			//memberDao.UpdateLog(param.getMem_id());

			// 세션 등록
			HttpSession session = request.getSession();
			session.setAttribute("member", rslt);
		}

		return rslt;
	}
	
	// 로그아웃
//	public int MemberLogout() throws Exception{
//		
//		return 1;
//	}
	
	// 아이디찾기
	public HashMap<String, Object> FindId(HashMap<String, Object> param) throws Exception{
			
		
		String findId = "";//memberDao.FindId(param.getMem_email() );
		if ( findId == null || "".equals(findId) ) {
		}
			
		
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", findId);
		return result;
	}
	
	// 비밀번호 찾기
	@SuppressWarnings("unused")
	public HashMap<String, Object> FindPw(HashMap<String, Object> param) throws Exception{
	
		
		String findPw = memberDao.FindPw(param);
		if( findPw == null || findPw == "" ) {
		}
		else {
			// 비밀번호 생성
			String imsiPw = "";
			for(int i = 0 ; i < 12 ; i++ ) {
				imsiPw += (char) (( Math.random() * 26) + 97);
			}
			
			// 비밀번호변경
			//param.setMem_pw( imsiPw );
			memberDao.UpdatePw(param);
			
			// 비밀번호변경 메일발송
			SendMail(param, "pwInit");

		}
		
		
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", "");
		
		return result;
	}
	
	// 회원탈되
	public HashMap<String, Object> MemberLeave(HashMap<String, Object> param, HttpServletRequest request)throws Exception{
		
		
		int leave = memberDao.MemberLeave(param);
		
		if ( leave < 1) {
		}
		else {
			HttpSession session = request.getSession();
			session.invalidate();
		}
		
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", "");
		
		return result;
	}
	
	// 회원리스트
	public HashMap<String, Object> MemberList() throws Exception{
	
		List<Object> member = new ArrayList<Object>();
		member = memberDao.MemberList();
		
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", member);
		
		return result;
	}
	
}
