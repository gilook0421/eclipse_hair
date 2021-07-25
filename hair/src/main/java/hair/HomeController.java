package hair;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hair.member.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Resource
	MemberService memberService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		if(logger.isDebugEnabled()) logger.debug("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home.home";
	}

	// 로그인 상태 체크
	@ResponseBody
	@RequestMapping(value="/home.api", method=RequestMethod.POST)
	public HashMap<String, Object> homeInit(HttpServletRequest request){

		if(logger.isDebugEnabled()) logger.debug("controller {homeInit} : " + request.getMethod());
		
		HashMap<String, Object> view = new HashMap<>();
		HttpSession session = request.getSession();
//		if(logger.isDebugEnabled()) logger.debug("controller {homeInit}"+session);
//		if(logger.isDebugEnabled()) logger.debug("controller {homeInit}"+session.toString());
		if(logger.isDebugEnabled()) logger.debug("controller {homeInit}"+session.getAttribute("member"));
		
		view.put("data", session.getAttribute("member"));
		
		return view;
	}

	// 로그인
	@ResponseBody
	@RequestMapping(value="/login.api", method=RequestMethod.POST)
	public HashMap<String, Object> MemberLogin(@RequestBody Map<String, Object> param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("controller {MemberLogin}" + param.toString());
		
		HashMap<String, Object> req = new HashMap<>();
		req.put("mem_id", param.get("mem_id")==null?"":param.get("mem_id"));
		req.put("mem_pw", param.get("mem_pw")==null?"":param.get("mem_pw"));
		
		HashMap<String, Object> view = new HashMap<>();
		view =  memberService.MemberLogin(req, request);

		if(view != null) {
			// 해당정보로 세션 구성한다.
			HttpSession session = request.getSession();
			session.setAttribute("memInfo", view);
			/*
			 * session.setAttribute("mem_email_approval_key",
			 * (String)view.get("mem_email_approval_key"));
			 * session.setAttribute("mem_reg_date",
			 * ((String)view.get("mem_reg_date")).replaceAll("-", "").replaceAll(":", ""));
			 * session.setAttribute("mem_email_approval_status",
			 * (String)view.get("mem_email_approval_status"));
			 * session.setAttribute("mem_upd_date",
			 * ((String)view.get("mem_upd_date")).replaceAll("-", "").replaceAll(":", ""));
			 * session.setAttribute("mem_name", (String)view.get("mem_name"));
			 * session.setAttribute("mem_id", (String)view.get("mem_id"));
			 * session.setAttribute("mem_no", String.valueOf((int) view.get("mem_no")));
			 * session.setAttribute("mem_manager_yn", (String)view.get("mem_manager_yn"));
			 * session.setAttribute("mem_phone1", (String)view.get("mem_phone1"));
			 * session.setAttribute("mem_email", (String)view.get("mem_email"));
			 */
			
			// 고객정보이므로, 필요한 컬럼만 리턴한다.
			HashMap<String, Object> filterView = new HashMap<>();
			filterView.put("mem_name", (String)view.get("mem_name"));
			filterView.put("mem_id", (String)view.get("mem_id"));
			view = filterView;
		}
		
		return view;
	}
	
	// 로그아웃
	@ResponseBody
	@RequestMapping(value="/logout.api", method=RequestMethod.POST)
	public HashMap<String, Object> MemberLogout(HttpServletRequest request) throws Exception{
		
		HttpSession session = request.getSession();
		session.invalidate();

		HashMap<String, Object> view = new HashMap<>();
		view.put("resultStatus", "succes");
		view.put("resultCode","000");
		view.put("resultMsg","");
		
		return view;
	}
	
	 
}
