package hair.member.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.member.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberContoller {
	
	@Resource
	MemberService memberService;
	
	// 회원가입 화면 이동
	@RequestMapping(value="/joinView.api", method = RequestMethod.GET)
	public String MemberInit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//if(logger.isDebugEnabled()) logger.debug("controller in." + request.getParameterNames().toString());
		//if(logger.isDebugEnabled()) logger.debug("controller in." + response.toString());
		
		memberService.MemberInit(request, response);
		
		return "member/join";
		
	}
	
	// 아이디 중복검사
	@ResponseBody
	@RequestMapping(value = "/checkId.api", method = RequestMethod.POST)
	public HashMap<String, Object> MemberCheckId(@RequestParam HashMap<String, Object> param ) throws Exception {

		//if(logger.isDebugEnabled()) logger.debug("controller {checkId}");
		
	    //if(logger.isDebugEnabled()) logger.debug(param);
	    //if(logger.isDebugEnabled()) logger.debug("id is "+param.get("id"));
	 
	    HashMap<String, Object> view = new HashMap<String, Object>();
	    view = memberService.MemberCheckId(param);

	    return view;
	}
	
	// 이메일 중복검사
	@ResponseBody
	@RequestMapping(value="/checkEmail.api", method = RequestMethod.POST)
	public HashMap<String, Object> MemberCheckEmail(@RequestParam HashMap<String, Object> param) throws Exception {

		//if(logger.isDebugEnabled()) logger.debug("controller {checkEmail}");
		
		HashMap<String, Object> view = new HashMap<String, Object>();
		view = memberService.MemberCheckEmail(param);

		//if(logger.isDebugEnabled()) logger.debug("controller {checkEmail} : " + view.toString() );
		return view;
	}
	
	// 회원가입
	@ResponseBody
	@RequestMapping(value="/join.api", method = RequestMethod.POST)
	public HashMap<String, Object> MemberJoin(@ModelAttribute HashMap<String, Object> param) throws Exception {
		//if(logger.isDebugEnabled()) logger.debug("controller {join}");
		
		HashMap<String, Object> view = new HashMap<String, Object>();
		view = memberService.MemberJoin(param);

		//if(logger.isDebugEnabled()) logger.debug("controller {join} : " + view.toString() );
		return view;
	}

	// 회원인증
	@ResponseBody
	@RequestMapping(value="/approvalMember.api", method = RequestMethod.POST)
	public void ApprocalMember(@ModelAttribute HashMap<String, Object> param, HttpServletResponse response)  throws Exception {
		memberService.ApprovalMember(param, response);
	}
	
	// 로그인 화면이동
	@RequestMapping(value="/loginView.api", method=RequestMethod.GET)
	public String LoginView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "member/login";
	}

	// 아이디찾기
	@ResponseBody
	@RequestMapping(value="/findId.api", method=RequestMethod.POST)
	public HashMap<String, Object> FindId(@ModelAttribute HashMap<String, Object> param )throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();
		view = memberService.FindId(param);
		
		return view;
	}
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping(value="/findPw.api", method=RequestMethod.POST)
	public HashMap<String, Object> FindPw(@ModelAttribute HashMap<String, Object> param)throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();
		view = memberService.FindPw(param);
				
		return view;
	}

	// 마이페이지View
	@RequestMapping(value="/mypageView.api", method=RequestMethod.GET)
	public String Mypage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "member/mypage";
	}
	
	// 마이페이지
	@ResponseBody
	@RequestMapping(value="/mypageInfo.api", method=RequestMethod.POST)
	public HashMap<String, Object> MypageInfo(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();

		return view;
	}
	
	// 회원탈퇴
	@ResponseBody
	@RequestMapping(value="/memberLeave.api", method=RequestMethod.POST)
	public HashMap<String, Object> MemberLeave(@ModelAttribute HashMap<String, Object> param, HttpServletRequest request)throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();
		view = memberService.MemberLeave(param, request);
		
		return view;
	}
	
	// 회원리스트 뷰
	@RequestMapping(value="/memberListView.api", method=RequestMethod.GET)
	public String MemberListView() throws Exception{
	
		return "member/memberList";
	}
	
	// 회원리스트
	@ResponseBody
	@RequestMapping(value="/memberList.api", method=RequestMethod.POST)
	public HashMap<String, Object> MemberList() throws Exception{
		
		HashMap<String, Object> view = new HashMap<>();
		view = memberService.MemberList();
		
		return view;
	}

	
	// json
	// 우선 ajax request를 처리하기 위해 @RequestParam Map을 씁니다.
	// 그리고 ajax response를 처리하기 위해 @ResponseBody Map을 쓰면 그만입니다.
	
	// 인자값이 포함된 파라미터의 알리아스는 param
	// 결과값을 response하는 알리아스는 view
	// - view에는 status값을 필수로 넣는다 success, fail
}
