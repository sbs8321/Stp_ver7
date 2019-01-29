package com.icia.stp.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.stp.dao.MemberDAO;
import com.icia.stp.vo.OwnerVo;
import com.icia.stp.vo.UserVo;



@Service
public class MemberService {
	@Autowired
	private MemberDAO stpdao;

	private ModelAndView mav;
	
	@Inject
    private JavaMailSender mailSender;
	
	@Autowired
	private HttpSession session;
	

	UserVo userVo;
	OwnerVo ownerVo;

	// 일반 회원 가입
	public ModelAndView joinUserService(HttpServletResponse response, UserVo userVo) throws IOException, MessagingException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		mav = new ModelAndView();
		int joinResult = stpdao.joinUserDao(userVo);
		
		
		//인증키 생성
        String key = new TempKey().getKey(50,false);  
        
        //인증키 db 저장
        stpdao.usercreateAuthKey(userVo.getEmail(),key); 
		
        //메일 전송
        MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("국제 발신입니다 [STP 서비스 이메일 인증] ");
        sendMail.setText(
        new StringBuffer().append("<h1>메일인증</h1>").append("<a href='http://localhost:8084/stp/member/useremailConfirm?email=").
		append(userVo.getEmail()).
		append("&authkey=").append(key).
		append("' target='_blank'>이메일 인증 확인</a>").toString());
        sendMail.setFrom("sbs8321@gmail.com", "STP KOREA ");
        sendMail.setTo(userVo.getEmail());
        sendMail.send();
		
		
		if (joinResult != 0) {
			out.println("<script>");
			out.println("alert('회원가입이 완료되었습니다. 로그인 해주세요.')");
			out.println("location.href='../'");
			out.println("</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('회원가입에 실패하였습니다. 다시 시도해주세요.')");
			out.println("history.go(-1)");
			out.println("</script>");
			out.close();
		}

		out.close();

		return mav;

	}
	
	public UserVo userAuth(UserVo userVo) {
		UserVo vo =new UserVo();

	 	// db에 해당 이메일과 키값이 일치하는지 확인
        vo=stpdao.userchkAuth(userVo);
   
        //일치한다면 일치한 객체를 가져옴
        if(vo!=null){
        	
        	//일치 할경우 db에 인증상태 변경
        	stpdao.useruserAuth(userVo);
           }
        
        return vo;
	}
	

	// 기업 회원 가입
	public ModelAndView joinOwnerService(HttpServletResponse response, OwnerVo ownerVo) throws IOException, MessagingException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		mav = new ModelAndView();
		int joinResult = stpdao.joinOwnerDao(ownerVo);

		
		//인증키 생성
        String key = new TempKey().getKey(50,false);  
        
        //인증키 db 저장
        stpdao.ownercreateAuthKey(ownerVo.getEmail(),key); 
		
        //메일 전송
        MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("국제 발신입니다 [STP 서비스 이메일 인증] ");
        sendMail.setText(
        new StringBuffer().append("<h1>메일인증</h1>").append("<a href='http://localhost:8084/stp/member/owneremailConfirm?email=").
		append(ownerVo.getEmail()).
		append("&authkey=").append(key).
		append("' target='_blank'>이메일 인증 확인</a>").toString());
        sendMail.setFrom("sbs8321@gmail.com", "STP KOREA ");
        sendMail.setTo(ownerVo.getEmail());
        sendMail.send();
		
        
		if (joinResult != 0) {
			out.println("<script>");
			out.println("alert('회원가입이 완료되었습니다. 로그인 해주세요.')");
			out.println("location.href='../'");
			out.println("</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('회원가입에 실패하였습니다. 다시 시도해주세요.')");
			out.println("history.go(-1)");
			out.println("</script>");
			out.close();
		}

		

		return mav;
	}
	
	public OwnerVo ownerAuth(OwnerVo ownerVo) {
		OwnerVo vo =new OwnerVo();

	 	// db에 해당 이메일과 키값이 일치하는지 확인
        vo=stpdao.ownerchkAuth(ownerVo);
   
        //일치한다면 일치한 객체를 가져옴
        if(vo!=null){
        	
        	//일치 할경우 db에 인증상태 변경
        	stpdao.owneruserAuth(ownerVo);
           }
        
        return vo;
	}
	

	// 일반 회원 로그인
	public ModelAndView userLoginActionService(UserVo userVo,HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		UserVo result = stpdao.userLoginDao(userVo);
		
		if(result != null) {
			// 아이디와 비밀번호가 동일할경우 인증상태 확인
			UserVo statecheck =  stpdao.userstatecheck(userVo);
			
			if(statecheck == null) {
				// 인증 상태가 0 인경우
				out.println("<script>");
				out.println("alert('이메일 을 확인해주세요')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}else {	
				// 인증상태가 1 인 경우
			mav = new ModelAndView();
			session.setAttribute("type", result.getMemberType()); 
			session.setAttribute("loginID", result.getEmail()); 
			System.out.println("type ===="+session.getAttribute("type"));
			mav.addObject("loginmember",result); 
			mav.setViewName("search/search");
			}
		}else {
			//인증은 했으나 비밀번호나 아이디가 다를경우
			out.println("<script>");
			out.println("alert('아이디 또는 비먼 달라....')");
			out.println("location.href='../'");
			out.println("</script>");
			out.close();
			mav.setViewName("Login");
		}
		return mav;
	}

	// 기업 회원 로그인
	public ModelAndView ownerLoginActionService(UserVo userVo,HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		OwnerVo owner = new OwnerVo();
		owner.setEmail(userVo.getEmail());
		owner.setPassword(userVo.getPassword());
		
		OwnerVo result = new OwnerVo();
		result = stpdao.ownerLoginDao(owner);
		
		if(result != null) {
			// 아이디와 비밀번호가 동일할경우 인증상태 확인
			OwnerVo statecheck =  stpdao.ownerstatecheck(owner);
			
			if(statecheck == null) {
				// 인증 상태가 0 인경우
				out.println("<script>");
				out.println("alert('이메일 을 확인해주세요')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}else {	
				// 인증상태가 1 인 경우
			mav = new ModelAndView();
			session.setAttribute("type", result.getMemberType()); 
			session.setAttribute("loginID", result.getEmail()); 
			mav.addObject("loginmember",result); 
			mav.setViewName("search/search");
			}
		}else {
			//인증은 했으나 비밀번호나 아이디가 다를경우
			out.println("<script>");
			out.println("alert('아이디 또는 비먼 달라....')");
			out.println("location.href='../'");
			out.println("</script>");
			out.close();
			mav.setViewName("Login");
		}
		return mav;
	}

	// 모든 회원 아이디 찾기
	   public ModelAndView findIdService(HttpServletResponse response, UserVo userVo) throws IOException {
	      
	      System.out.println("findId 서비스 메소드 실행 : 파라미터 " + userVo.getPhone_mid());
	      response.setContentType("text/html; charset=UTF-8");
	      PrintWriter out = response.getWriter();
	      
	      mav = new ModelAndView();
	      
	      if (userVo.getMemberType() == 0) {
	         UserVo findUserId = stpdao.userFindIdDao(userVo);
	         String email = findUserId.getEmail();
	         System.out.println("찾은 아이디 : " + email);
	         
	         String word1 = email.split("@")[0];
	         String word2 = email.split("@")[1];
	         
	         String sub1 = word1.substring(0,3);
	         
	         String sub2 = word1.substring(3);
	         String[] sub2split = sub2.split("");
	         String sub2str = "";
	         for(int i=0; i<sub2split.length; i++) {
	            sub2split[i] = "*";
	            sub2str += sub2split[i];
	         }
	         String result = sub1+sub2str+"@"+word2;
	         findUserId.setEmail(result);
	         
	         if(findUserId != null) {
	            mav.addObject("findMember", findUserId);
	            mav.setViewName("member/findIdResult");
	            out.print("1");   
	         } 
	         
	      } else {
	         OwnerVo fineOwnerId = stpdao.ownerFindIdDao(userVo);
	         String email = fineOwnerId.getEmail();
	         
	         String word1 = email.split("@")[0];
	         String word2 = email.split("@")[1];
	         
	         String sub1 = word1.substring(0,3);
	         
	         String sub2 = word1.substring(3);
	         String[] sub2split = sub2.split("");
	         String sub2str = "";
	         for(int i=0; i<sub2split.length; i++) {
	            sub2split[i] = "*";
	            sub2str += sub2split[i];
	         }
	         
	         String result = sub1+sub2str+"@"+word2;
	         fineOwnerId.setEmail(result);
	         
	         if(fineOwnerId != null) {
	            mav.addObject("findMember", fineOwnerId);
	            mav.setViewName("member/findIdResult");
	            out.print("1");
	         } 
	      }
	      
	      return mav;
	   }
	
	

	// 일반 회원 비밀번호 찾기
	public ModelAndView userFindPasswordActionService(UserVo userVo,HttpServletResponse response) throws MessagingException, IOException {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
       
        UserVo ck = new UserVo();
        
        ck= stpdao. userckmember(userVo);
        
        if(ck == null) {
        	//다를경우
        	out.println("<script>");
			out.println("alert('잘못된 정보입니다')");
			out.println("location.href='findPasswordAction'");
			out.println("</script>");
			out.close();
        }else {
        	
        //같을경우
        
        // 인증키 생성
        String key = new TempKey().getKey(50,false); 
        
        //인증키 db 저장
        stpdao.usercreateAuthKey(userVo.getEmail(),key);
        
        //메일 전송
        MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("국제 발신입니다 [STP 서비스 이메일 인증] ");
        sendMail.setText(
        new StringBuffer().append("<h1>비밀번호 변경입니다</h1>").append("<a href='http://localhost:8084/stp/member/userpasswordemailConfirm?email=").
		append(userVo.getEmail()).
		append("&authkey=").append(key).
		append("' target='_blank'>이메일 인증 확인</a>").toString());
        sendMail.setFrom("sbs8321@gmail.com", "STP KOREA ");
        sendMail.setTo(userVo.getEmail());
        sendMail.send();
        
        mav = new ModelAndView();
		
		//비밀번호 이메일 전송 확인
		out.println("<script>");
		out.println("alert('메일을 보냈습니다 인증 하세요')");
		out.println("location.href='../'");
		out.println("</script>");
		out.close();
			
		}
		
		return mav;
	}
	
	//일반 회원 비밀번호 변경을 위한 정보 가져오기
	public ModelAndView modifypassword(UserVo userVo2, HttpServletResponse response) {
		mav = new ModelAndView();
		
		UserVo user = new UserVo();
		user = stpdao.userSearch(userVo2);
		
		mav.addObject("user",user);
		mav.setViewName("member/modifyPassword");
		
		return mav;
	}
	
	//일반 회원 비밀번호 변경
	public void modifypasswordpro(UserVo userVo2, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		int result = stpdao.modifypassword(userVo2);
		
			if(result ==0) {
				out.println("<script>");
				out.println("alert('비밀번호 변경 실패 ㅠㅠ....')");
				out.println("location.href='../'");
				out.println("</script>");
				out.close();
			}else {
				out.println("<script>");
				out.println("alert('비밀번호 변경로그인 하세요')");
				out.println("location.href='../'");
				out.println("</script>");
				out.close();					
			}
		
	}

	// 기업 회원 비밀번호 찾기
	public ModelAndView ownerFindPasswordActionService(UserVo userVo,HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
       
        OwnerVo owner = new OwnerVo();
        owner.setEmail(userVo.getEmail());
        owner.setName(userVo.getName());
        owner.setPhone_front(userVo.getPhone_front());
        owner.setPhone_mid(userVo.getPhone_mid());
        owner.setPhone_end(userVo.getPhone_end());
        
        OwnerVo ck = new OwnerVo();
        
        ck= stpdao. ownerckmember(owner);
        
        if(ck == null) {
        	//다를경우
        	out.println("<script>");
			out.println("alert('잘못된 정보입니다')");
			out.println("location.href='member/findPasswordAction'");
			out.println("</script>");
			out.close();
        }else {
        	
        //같을경우
        
        // 인증키 생성
        String key = new TempKey().getKey(50,false); 
        
        //인증키 db 저장
        stpdao.ownercreateAuthKey(owner.getEmail(),key);
        
        //메일 전송
        MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("국제 발신입니다 [STP 서비스 이메일 인증] ");
        sendMail.setText(
        new StringBuffer().append("<h1>비밀번호 변경입니다</h1>").append("<a href='http://localhost:8084/stp/member/ownerpasswordemailConfirm?email=").
		append(owner.getEmail()).
		append("&authkey=").append(key).
		append("' target='_blank'>이메일 인증 확인</a>").toString());
        sendMail.setFrom("sbs8321@gmail.com", "STP KOREA ");
        sendMail.setTo(owner.getEmail());
        sendMail.send();
        
        mav = new ModelAndView();
		
		//비밀번호 이메일 전송 확인
		out.println("<script>");
		out.println("alert('메일을 보냈습니다 인증 하세요')");
		out.println("location.href='../'");
		out.println("</script>");
		out.close();
			
		}
		
		return mav;
	}
	
	//기업 회원 비밀번호 변경을 위한 정보 가져오기
		public ModelAndView ownermodifypassword(OwnerVo ownerVo, HttpServletResponse response) {
			mav = new ModelAndView();
			
			OwnerVo owner = new OwnerVo();
			owner = stpdao.ownerSearch(ownerVo);
			
			mav.addObject("user",owner);
			mav.setViewName("member/modifyPassword");
			
			return mav;
		}
		
		//기업 회원 비밀번호 변경
		public void ownermodifypasswordpro(UserVo userVo, HttpServletResponse response) throws IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			OwnerVo owner = new OwnerVo();
			owner.setEmail(userVo.getEmail());
			owner.setPassword(userVo.getPassword());
			
			int result = stpdao.ownermodifypassword(owner);
			
				if(result ==0) {
					out.println("<script>");
					out.println("alert('비밀번호 변경 실패 ㅠㅠ....')");
					out.println("location.href='../'");
					out.println("</script>");
					out.close();
				}else {
					out.println("<script>");
					out.println("alert('비밀번호 변경로그인 하세요')");
					out.println("location.href='../'");
					out.println("</script>");
					out.close();					
				}
			
		}

	// 아이디 중복확인 메소드
	public void idOverlap(String email, HttpServletResponse response) throws IOException {
		System.out.println("idOverlap 서비스 호출 / 파라미터 : " + email);
		userVo = new UserVo();
		userVo = stpdao.idOverlap(email);
		if (userVo == null) {
			// 해당 아이디 사용 가능
			stpdao.idInsert(email);
			response.getWriter().print("1");
		} else {
			// 해당 아이디 사용 불가능
			response.getWriter().print("0");
		}

	}

	public void idOverlapOwner(String email, HttpServletResponse response) throws IOException {
		System.out.println("idOverlapOwner 서비스 호출 / 파라미터 : " + email);
		ownerVo = new OwnerVo();
		ownerVo = stpdao.idOverlapOwner(email);
		if (ownerVo == null) {
			// 해당 아이디 사용 가능
			stpdao.idInsertOwner(email);
			response.getWriter().print("1");
		} else {
			// 해당 아이디 사용 불가능
			response.getWriter().print("0");
		}

	}

	// -원석
	public void joinCancel(String id, HttpServletResponse response) throws IOException {
		System.out.println("joinCancel 서비스 호출 / 파라미터 : " + id);
		int cancel = stpdao.joinCancel(id);

		if (cancel != 0) {
			System.out.println("중복확인 아이디 삭제 완료");
		} else {
			System.out.println("중복확인 아이디 삭제 실패");
		}
	}

	// 회원 관리하기 
	public ModelAndView memberManage() {
		mav = new ModelAndView();
		//개인 회원 가져오기
		List<UserVo> userList= stpdao.userList();
		List<OwnerVo> ownerList = stpdao.ownerList();
		
		mav.addObject("userList", userList);
		mav.addObject("ownerList",ownerList);
		mav.setViewName("member/memberManage");
		return mav;
	}

	

	

	

	

	

	

	


	

}
