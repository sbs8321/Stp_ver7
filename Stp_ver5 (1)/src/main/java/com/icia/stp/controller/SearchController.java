package com.icia.stp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icia.stp.service.SearchService;
import com.icia.stp.vo.BookMarkVo;
import com.icia.stp.vo.BookingVo;
import com.icia.stp.vo.MeetyouallParkVo;


@Controller
@RequestMapping(value="/search/*")
public class SearchController {
	@Autowired
	private SearchService ms;
	// 서비스클래스 변수
	
	private ModelAndView mav;
	
	@RequestMapping(value="/search", method=RequestMethod.POST) 
	public ModelAndView search(HttpServletResponse response, @RequestParam("place") String place) throws IOException { 
		
		if(place == "") {
			place = "user";
		}
		System.out.println(place);
		mav = new ModelAndView();
		mav = ms.search(place);
		return mav;
	}
	
	@RequestMapping(value="/gohome", method=RequestMethod.GET) 
	public ModelAndView gohome(HttpServletResponse response) throws IOException { 
		mav = new ModelAndView();
		mav = ms.gotohome();
		return mav;
	}
	@RequestMapping(value="/gotoHome", method=RequestMethod.POST) 
	public ModelAndView gotoHome(HttpServletResponse response) throws IOException { 
		mav = new ModelAndView();
		mav = ms.gotohome();
		return mav;
	}
	
	//지도 이동시목록져오기
	@RequestMapping(value="/parkListsearch", method=RequestMethod.POST) 
	public ModelAndView parkListsearch(HttpServletResponse response,@ModelAttribute MeetyouallParkVo meetyouall) throws IOException { 
		mav = new ModelAndView();
		System.out.println(meetyouall.getLatitude());
		System.out.println(meetyouall.getHardness());
		
		
		mav=ms.parkListsearch(meetyouall);
		return mav;
	}
	   
	// 주차장 상세보기
	@RequestMapping(value="/detailParkForm", method=RequestMethod.POST)
	public ModelAndView detailParkForm(HttpServletResponse response, @ModelAttribute MeetyouallParkVo meetyouall) {
		System.out.println("detailParkForm 컨트롤러 호출 : " + meetyouall.getPrkplceno());
		mav = ms.detailParkForm(response, meetyouall);
		
		return mav;
	}
	
	// 주차가능여부 검색하기
		@RequestMapping(value="/bookable", method=RequestMethod.POST)
		public ModelAndView bookable(HttpServletResponse response, @ModelAttribute BookingVo bookingVo) throws IOException {
			System.out.println("bookable 컨트롤러 호출 : " + bookingVo.getEntrance_date() + " / " + bookingVo.getParking_id());
			mav = ms.bookable(response, bookingVo);
			return mav;
		}
		
		//북마크 여부 보여주기
		@RequestMapping(value="/isbookmark", method=RequestMethod.POST) 
		public ModelAndView isbookmark(HttpServletResponse response,@ModelAttribute BookMarkVo book) throws IOException { 
			mav = new ModelAndView();
			System.out.println(book.getEmail());
			System.out.println(book.getPrkplceno());
			mav=ms.isbook(book);
			return mav;
		}
		//북마크 하기
		@RequestMapping(value="/addbookmark", method=RequestMethod.POST) 
		public ModelAndView addbookmark(HttpServletResponse response,@ModelAttribute BookMarkVo book) throws IOException { 
			mav = new ModelAndView();
			System.out.println(book.toString());
			mav=ms.addbook(book);
			return mav;
		}
		// 북마크 지우기
		@RequestMapping(value="/delbookmark", method=RequestMethod.POST) 
		public ModelAndView delbookmark(HttpServletResponse response,@ModelAttribute BookMarkVo book) throws IOException { 
			mav = new ModelAndView();
			System.out.println(book.toString());
			mav=ms.delbook(book);
			return mav;
		}
		// search 페이지 에 리스트 보여주기
		@RequestMapping(value="/bookmarkList", method=RequestMethod.POST) 
		public ModelAndView bookmarkList(HttpServletResponse response,@ModelAttribute BookMarkVo book) throws IOException { 
			mav = new ModelAndView();
			System.out.println(book.getEmail());
			mav=ms.bookList(book);
			return mav;
		}
		
		// 댓글 작성
		@RequestMapping(value = "/replySubmit", method = RequestMethod.POST)
		public void replySubmit(HttpServletResponse response, @RequestParam("sessionId") String sessionId, 
												@RequestParam("content") String reply_content, @RequestParam("parkingId") String parkingId) throws IOException {
			System.out.println("replySubmit 컨트롤러 호출 / 파라미터 : " + reply_content);
			System.out.println("세션 아이디 값 : " + sessionId);
			
			ms.replySubmit(reply_content, sessionId, parkingId, response);
		}
		
		// 댓글 목록 처리
		@RequestMapping(value = "/replyList", method = RequestMethod.POST)
		public ModelAndView replyList(@RequestParam("parkingId") String parkingId, HttpServletResponse response) {
			System.out.println("replyList 컨트롤러 호출");
			mav = ms.replyList(parkingId);
			
			return mav;
		}
		
		// 댓글 삭제 처리
		@RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
		public void replyDelet(HttpServletResponse response, @RequestParam("id") String id, @RequestParam("replyNum") int replyNum) throws IOException {
			System.out.println("replyDelete 컨트롤러 호출 : " + id + " / " + replyNum);
			ms.replyDelete(response, id, replyNum);
		}
		
		// 주차장 등록폼
		@RequestMapping(value="/registerParingForm", method=RequestMethod.POST) 
		public String registerParingForm(HttpServletResponse response,@ModelAttribute BookMarkVo book) throws IOException { 
			return "search/registerParking";
		}	
		
		// 주차장 등록
		@RequestMapping(value="/registerParking", method=RequestMethod.POST) 
		public ModelAndView registerParking(HttpServletResponse response,@ModelAttribute MeetyouallParkVo meetyouall,@RequestParam("addr2") String addr2,@RequestParam("addr3") String addr3) throws IOException { 
			mav = new ModelAndView();
			System.out.println(meetyouall.toString());
			mav=ms.registerParking(meetyouall,addr2,addr3);
			return mav;
		}	
		
		// search 페이지 에 내 주차장 리스트 보여주기
		@RequestMapping(value="/myparkingkList", method=RequestMethod.POST) 
		public ModelAndView myparkingkList(HttpServletResponse response,@ModelAttribute BookMarkVo book) throws IOException { 
			mav = new ModelAndView();
			System.out.println(book.getEmail());
			mav=ms.myparkingkList(book);
			return mav;
		}		
		
				
		// 주차장 신청시 예약 vo에 저장
		@RequestMapping(value="/parkingApply", method=RequestMethod.POST)
		public ModelAndView parkingApply(@ModelAttribute BookingVo book) {
			mav = new ModelAndView();
			System.out.println("신청 버튼 누른 후 컨트롤러로 넘어온 값:"+book.toString());
			mav= ms.parkingApply(book);
			return mav;
		}
		
		//예약 페이지(로그인한 이메일에 해당하는)
		@RequestMapping(value="/reservationList", method=RequestMethod.POST)
		public ModelAndView reservationList() {
			mav = new ModelAndView();
			mav = ms.reservationList();
			return mav;
		}
		
		//예약 페이지(로그인한 이메일에 해당하는)
		@RequestMapping(value="/bookingList", method=RequestMethod.GET)
		public ModelAndView bookingList() {
			mav = new ModelAndView();
			mav = ms.reservationList();
			return mav;
		}
		
		// 에약 관리 페이지
		@RequestMapping(value="/reserveList", method=RequestMethod.POST)
		public ModelAndView reserveList() {
			mav = new ModelAndView();
			mav = ms.reserveList();
			return mav;
		}
		
		// 주차장 수정내용 보여주기
		@RequestMapping(value="/modifyparkForm", method=RequestMethod.POST) 
		public ModelAndView modifyparkForm(HttpServletResponse response,@ModelAttribute MeetyouallParkVo meetyouall) throws IOException { 
			mav = new ModelAndView();
			System.out.println(meetyouall.getPrkplceno());
			mav=ms.modifyparkForm(meetyouall);
			return mav;
		}	
		// 주차장수정
		@RequestMapping(value="/modifyparking", method=RequestMethod.POST) 
		public ModelAndView modifyparking(HttpServletResponse response,@ModelAttribute MeetyouallParkVo meetyouall,@RequestParam("addr2") String addr2,@RequestParam("addr3") String addr3) throws IOException { 
			mav = new ModelAndView();
			System.out.println(meetyouall.getPrkplceno());
			mav=ms.modifyparking(meetyouall,response,addr2,addr3);
			return mav;
		}	
		// 주차장 삭제
		@RequestMapping(value="/deletePark", method=RequestMethod.POST) 
		public ModelAndView deletePark(HttpServletResponse response,@ModelAttribute MeetyouallParkVo meetyouall) throws IOException { 
			mav = new ModelAndView();
			System.out.println(meetyouall.getPrkplceno());
			mav=ms.deletePark(meetyouall);
			return mav;
		}	
		//미승인 리스트 가져오기
		@RequestMapping(value="/stateparking", method=RequestMethod.POST) 
		public ModelAndView stateparking(HttpServletResponse response,@ModelAttribute MeetyouallParkVo meetyouall) throws IOException { 
			mav = new ModelAndView();
			mav=ms.stateparking();
			return mav;
		}	
		//주차장 승인
		@RequestMapping(value="/confirmpark", method=RequestMethod.POST) 
		public ModelAndView confirmpark(HttpServletResponse response,@ModelAttribute MeetyouallParkVo meetyouall) throws IOException { 
			mav = new ModelAndView();
			mav=ms.confirmpark(meetyouall);
			return mav;
		}	
		
		//결제 완료(result)페이지에서 부모창을 홈페이지로 넘기기
		@RequestMapping(value="/resultHome", method=RequestMethod.POST)
		public void resultHome(HttpServletResponse response) throws IOException {
			ms.resultHome(response);
		}
		
		//자식창 close, 부모창 예약 내역 페이지로 이동
		@RequestMapping(value="/reservePage", method=RequestMethod.POST)
		public void reservePage( HttpServletResponse response) throws IOException {
			ms.reservePage(response);
		}
		
		//예약 취소시 삭제
		@RequestMapping(value="/applyCancel", method=RequestMethod.POST)
		public void applyCancel(String booking_id) {
			ms.applyCancel(booking_id);
		}

}
