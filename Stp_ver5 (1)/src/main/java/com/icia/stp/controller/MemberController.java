package com.icia.stp.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.stp.service.MemberService;
import com.icia.stp.vo.OwnerVo;
import com.icia.stp.vo.UserVo;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {
	
	@Autowired
	private MemberService stps;

	private ModelAndView mav;

	// 아이디 찾기 화면 전환
	@RequestMapping(value = "/findIdAction", method = RequestMethod.GET)
	public String findId() {
		return "member/findId";
	}

	// 비밀번호 찾기 화면 전환
	@RequestMapping(value = "/findPasswordAction", method = RequestMethod.GET)
	public String findPassword() {
		return "member/findPassword";
	}

	// 회원가입 신분 확인 화면 전환
	@RequestMapping(value = "/joinTypeAction", method = RequestMethod.GET)
	public String joinType() {
		return "member/joinType";
	}

	// 로그인 처리
	@RequestMapping(value = "/loginAction", method = RequestMethod.POST)
	public ModelAndView loginAction(@ModelAttribute UserVo userVo,HttpServletResponse response) throws IOException {
		System.out.println(userVo.getMemberType());// 0이면 개인회원 1이면 기업회원
		mav = new ModelAndView();
		if (userVo.getMemberType() == 0) {

			mav = stps.userLoginActionService(userVo,response);
		} else {
			mav = stps.ownerLoginActionService(userVo,response);
		}

		return mav;
	}

	// 개인 회원 가입 페이지 전환
	@RequestMapping(value = "/joinUser", method = RequestMethod.GET)
	public ModelAndView joinUser(@ModelAttribute UserVo userVo) throws IOException {
		mav = new ModelAndView();
		mav.setViewName("member/joinUser");
		return mav;
	}

	// 기업 회원 가입 페이지 전환
	@RequestMapping(value = "/joinOwner", method = RequestMethod.GET)
	public ModelAndView joinOwner(@ModelAttribute UserVo userVo) throws IOException {
		mav = new ModelAndView();
		mav.setViewName("member/joinOwner");
		return mav;
	}

	// 개인 회원 가입정보 저장
	@RequestMapping(value = "/joinUserAction", method = RequestMethod.POST)
	public ModelAndView joinUserAction(HttpServletResponse response, @ModelAttribute UserVo userVo) throws IOException, MessagingException {
		mav = new ModelAndView();
		mav = stps.joinUserService(response, userVo);
		return mav;
	}
	
	//일반회원 이메일 인증 코드 검증
    @RequestMapping(value = "/useremailConfirm", method = RequestMethod.GET)
    public String useremailConfirm(UserVo userVo,Model model,RedirectAttributes rttr) throws Exception { 
    	
    	UserVo vo = new UserVo();
        vo=stps.userAuth(userVo);
        
        if(vo == null) {	     	
        // 검증이 안되면 에러 페이지로 이동
        return "member/Error";   
        }else {  	
        // 검증이 되면 인증 페이지로 이동
        return "member/joinSuccess";  
        }
    }
	

	// 기업 회원 가입정보 저장
	@RequestMapping(value = "/joinOwnerAction", method = RequestMethod.POST)
	public ModelAndView joinOwnerAction(HttpServletResponse response, @ModelAttribute OwnerVo ownerVo) throws IOException, MessagingException {
		mav = new ModelAndView();
		mav = stps.joinOwnerService(response, ownerVo);
		return mav;
	}
	
	//기업 회원 이메일 인증 코드 검증
    @RequestMapping(value = "/owneremailConfirm", method = RequestMethod.GET)
    public String emailConfirm(OwnerVo ownerVo,Model model,RedirectAttributes rttr) throws Exception { 
    	
    	OwnerVo vo = new OwnerVo();
        vo=stps.ownerAuth(ownerVo);
        
        if(vo == null) {	     	
        // 검증이 안되면 에러 페이지로 이동
        return "member/Error";   
        }else {  	
        // 검증이 되면 인증 페이지로 이동
        return "member/joinSuccess";   
        }
    }


    // 아이디 찾기
    @RequestMapping(value = "/findId", method = RequestMethod.POST)
    public ModelAndView findId(HttpServletResponse response, UserVo userVo) throws IOException {
       // System.out.println(userVo.getMemberType());// 0이면 개인회원 1이면 기업회원
       mav = stps.findIdService(response, userVo);

       return mav;
    }
    
    
	//비밀번호 찾기
	@RequestMapping(value = "/findPasswordAction", method = RequestMethod.POST)
	public ModelAndView findPasswordAction(@ModelAttribute UserVo userVo,HttpServletResponse response) throws Exception, MessagingException {
		// System.out.println(userVo.getMemberType());// 0이면 개인회원 1이면 기업회원
		mav = new ModelAndView();
		if (userVo.getMemberType() == 0) {
			//개인 회원
			mav = stps.userFindPasswordActionService(userVo,response);
		} else {
			//기업 회원
			mav = stps.ownerFindPasswordActionService(userVo,response);
		}

		return mav;
	}

	//개인 회원 비밀번호 인증 이메일 키값확인
    @RequestMapping(value = "/userpasswordemailConfirm", method = RequestMethod.GET)
    public ModelAndView passwordemailConfirm(UserVo userVo,Model model,RedirectAttributes rttr) throws Exception { 
    	mav = new ModelAndView();
    	UserVo vo = new UserVo();
        vo=stps.userAuth(userVo);
        
        if(vo == null) {	     	
        rttr.addFlashAttribute("msg" , "비정상적인 접근 입니다. 다시 인증해 주세요");
        mav.setViewName("member/Error");
        // 비밀번호 변경을 한뒤 링크 기능 	안될때 이동할 페이지
        }else {
        mav.setViewName("redirect:usermodifyPasswordForm?email="+userVo.getEmail());	        
        }
        return mav;
    }
	
    //개인회원 메일 인증후 비밀번호 변경폼으로 이동
    @RequestMapping(value="/usermodifyPasswordForm", method=RequestMethod.GET) 
	public ModelAndView modifyPasswordForm(@ModelAttribute UserVo userVo,HttpServletResponse response) throws Exception {
		mav = new ModelAndView();
		mav = stps.modifypassword(userVo,response);
		return mav; 
	}
    
    //개인,기업 회원 비밀번호 변경
    @RequestMapping(value="/modifyPasswordAction", method=RequestMethod.POST) 
	public void modifyPassword(@ModelAttribute UserVo userVo,HttpServletResponse response) throws Exception {
    	System.out.println("1단");
    	
		if (userVo.getMemberType() == 0) {
			//개인 회원
			System.out.println("2단");
			stps.modifypasswordpro(userVo,response);
		} else {
			//기업 회원
			System.out.println("3단");
			stps.ownermodifypasswordpro(userVo,response);	
		}
	}    
    
    
  //기업 회원 비밀번호 인증 이메일 키값확인
    @RequestMapping(value = "/ownerpasswordemailConfirm", method = RequestMethod.GET)
    public ModelAndView onwerpasswordemailConfirm(OwnerVo ownerVo,Model model,RedirectAttributes rttr) throws Exception { 
    	mav = new ModelAndView();
    	OwnerVo vo = new OwnerVo();
        vo=stps.ownerAuth(ownerVo);
        
        if(vo == null) {	     	
        rttr.addFlashAttribute("msg" , "비정상적인 접근 입니다. 다시 인증해 주세요");
        mav.setViewName("member/Error");
        // 비밀번호 변경을 한뒤 링크 기능 	안될때 이동할 페이지
        }else {
        mav.setViewName("redirect:usermodifyPasswordForm?email="+ownerVo.getEmail());	        
        }
        return mav;
    }
	
    //기업 회원 메일 인증후 비밀번호 변경폼으로 이동
    @RequestMapping(value="/ownermodifyPasswordForm", method=RequestMethod.GET) 
	public ModelAndView onwermodifyPasswordForm(@ModelAttribute OwnerVo ownerVo,HttpServletResponse response) throws Exception {
		mav = new ModelAndView();
		System.out.println(ownerVo.getEmail());
		mav = stps.ownermodifypassword(ownerVo,response);
		return mav; 
	}
    
   
	
	
  //비밀번호 찾기
  	@RequestMapping(value = "/serchAction", method = RequestMethod.POST)
  	public ModelAndView serchAction(@ModelAttribute UserVo userVo,HttpServletResponse response) throws Exception {
  		// System.out.println(userVo.getMemberType());// 0이면 개인회원 1이면 기업회원
  		mav = new ModelAndView();
  		if (userVo.getMemberType() == 0) {
  			//개인 회원
  			mav = stps.userFindPasswordActionService(userVo,response);
  		} else {
  			//기업 회원
  			mav = stps.ownerFindPasswordActionService(userVo,response);
  		}

  		return mav;
  	}

	// 아이디 중복확인 -원석
	@RequestMapping(value = "/idOverlap", method = RequestMethod.POST) // 주소 값 : "//idOverlap" , 매소드 : post
	public void idOverlap(HttpServletResponse response, @RequestParam("email") String email) throws IOException {
		System.out.println("idOverlap 컨트롤러 호출 / 파라미터 : " + email);
		stps.idOverlap(email, response);
	}
	
	// 기업회원 아이디 중복확인 
	@RequestMapping(value = "/idOverlapOwner", method = RequestMethod.POST) // 주소 값 : "//idOverlap" , 매소드 : post
	public void idOverlapOwner(HttpServletResponse response, @RequestParam("email") String email) throws IOException {
		System.out.println("idOverlap 컨트롤러 호출 / 파라미터 : " + email);
		stps.idOverlapOwner(email, response);
	}

	// 회원가입 취소시 id값 delete -원석
	@RequestMapping(value = "/joinCancel", method = RequestMethod.GET) // 주소 값 : "//idOverlap" , 매소드 : post
	public void joinCancel(HttpServletResponse response, @RequestParam("email") String email) throws IOException {
		System.out.println("joinCancel 컨트롤러 호출 / 파라미터 : " + email);
		stps.joinCancel(email, response);
	}
	// 마이페이지
	@RequestMapping(value = "/mypageForm", method = RequestMethod.POST)
	public String mypageForm() {
		return "member/mypage";
	}
	
	//멤버 관리 페이지
	@RequestMapping(value="/memberManage", method=RequestMethod.POST)
	public ModelAndView memberManage() {
		mav = new ModelAndView();
		mav = stps.memberManage();		
		return mav;
	}

}
