package com.icia.stp.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.stp.dao.SearchDAO;
import com.icia.stp.vo.BookMarkVo;
import com.icia.stp.vo.BookingVo;
import com.icia.stp.vo.MeetyouallParkVo;
import com.icia.stp.vo.ReplyVo;
import com.icia.stp.vo.UserVo;

@Service
public class SearchService {

	private ModelAndView mav;

	@Autowired
	private SearchDAO searchDao;

	@Autowired
	private HttpSession session;

	@Autowired
	private PaymentService ps; // 다른 서비스에 있는 함수 호출시 사용하기 위해

	// 검색단어 없이 검색
	public ModelAndView search(String place) {
		mav = new ModelAndView();
		System.out.println(place);
		List<MeetyouallParkVo> parkmark = new ArrayList<>();
		parkmark = searchDao.pkmk();

		mav.addObject("parkmark", parkmark);
		mav.addObject("place", place);
		mav.setViewName("search/searchResult");
		return mav;
	}

	// 주차장 목록
	public ModelAndView parkListsearch(MeetyouallParkVo meetyouall) {
		mav = new ModelAndView();
		List<MeetyouallParkVo> parkList = new ArrayList<>();

		parkList = searchDao.pkList(meetyouall);
		mav.addObject("parkList", parkList);
		mav.setViewName("search/parkList");
		return mav;
	}

	public ModelAndView detailParkForm(HttpServletResponse response, MeetyouallParkVo meetyouall) {
		mav = new ModelAndView();
		MeetyouallParkVo parkDetail = new MeetyouallParkVo();
		parkDetail = searchDao.parkDetail(meetyouall);
		mav.addObject("parkDetail", parkDetail);
		mav.setViewName("search/detailPark");
		return mav;
	}

	// 예약 가능한지 확인하는 코드. detailParkForm 페이지에서 검색 누르면 실행되는 코드.
	public ModelAndView bookable(HttpServletResponse response, BookingVo bookingVo) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		System.out.println("가져온 bookingvo에 저장된 값 : " + bookingVo.toString());
		PrintWriter out = response.getWriter();

		mav = new ModelAndView();
		Date exitDate = bookingVo.getEntrance_date();
		bookingVo.setExit_date(exitDate);
		int bookableResult = searchDao.bookable(bookingVo);
		System.out.println("예약 가능한지 확인");

		// 해당하는 parking 정보 가져옴.
		MeetyouallParkVo mp = searchDao.countArea(bookingVo);
		int parkArea = mp.getPrkcmprt();

		int areaAble = 0;
		if (parkArea >= bookableResult) {
			areaAble = parkArea - bookableResult;
		} else {
			areaAble = 0;
		}

		int parkingTime = (bookingVo.getExit_time() - bookingVo.getEntrance_time());
		bookingVo.setParking_time(parkingTime);
		bookingVo.setArea_able(areaAble);
		bookingVo.setUser_id((String) session.getAttribute("loginID"));

		int price = 0;
		if (parkingTime < 24) {
			price = (mp.getHourPayment() * parkingTime); // 1일 이내 가격 (시간)
		} else {
			int day = (int) (parkingTime / 24);
			price = mp.getDaycmmtkt() * day; // 24시간이면 1일로 취급하기
		}
		bookingVo.setPrice(price);

		if (bookableResult < parkArea) {
			mav.addObject("bookingInfo", bookingVo);
			System.out.println("result로 보내는 vo 값" + bookingVo.toString());
			mav.setViewName("search/bookableResult");
		} else {
			out.println("<script>");
			out.println("alert('예약 가능한 자리가 없습니다.')");
			out.println("history.back()");
			out.println("</script>");
			out.close();
		}

		return mav;
	}

	// 북마크 여부
	public ModelAndView isbook(BookMarkVo book) {

		BookMarkVo bookmark = searchDao.bookmark(book);
		int boo;

		if (bookmark != null) {
			boo = 1;
		} else {
			boo = 0;
		}
		mav.addObject("book", bookmark);
		mav.addObject("bookmark", boo);
		mav.setViewName("search/bookmark");
		return mav;
	}

	// 북마크 추가
	public ModelAndView addbook(BookMarkVo book) {
		int result = searchDao.addbookmark(book);
		int boo;

		if (result > 0) {
			boo = 1;
		} else {
			boo = 0;
		}
		mav.addObject("bookmark", boo);
		mav.setViewName("search/bookmark");
		return mav;
	}

	public ModelAndView delbook(BookMarkVo book) {
		int result = searchDao.delbookmark(book);
		int boo;

		if (result > 0) {
			boo = 1;
		} else {
			boo = 0;
		}
		mav.addObject("bookmark", boo);
		mav.setViewName("search/bookmark");
		return mav;
	}

	public ModelAndView bookList(BookMarkVo book) {
		mav = new ModelAndView();
		List<BookMarkVo> bookmark = new ArrayList<>();
		bookmark = searchDao.bookmarkList(book);

		mav.addObject("book", bookmark);
		mav.setViewName("search/bookmarkList");
		return mav;
	}

	public void replySubmit(String reply_content, String sessionId, String parkingId, HttpServletResponse response)
			throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		ReplyVo replyVO = new ReplyVo();
		replyVO.setReply_content(reply_content);
		replyVO.setReply_id(sessionId);
		replyVO.setReply_bNum(parkingId);

		int result = searchDao.replyWrite(replyVO);
		if (result != 0) {
			System.out.println("댓글 insert 성공");
			out.print("1");
		} else {
			System.out.println("댓글 insert 실패");
			out.print("0");
		}
		out.close();
	}

	public ModelAndView replyList(String parkingId) {
		mav = new ModelAndView();
		List<ReplyVo> replyList = searchDao.replyList(parkingId);
		mav.addObject("replyList", replyList);
		mav.setViewName("search/replies");

		return mav;
	}

	public void replyDelete(HttpServletResponse response, String id, int replyNum) throws IOException {
//			response.setContentType("text/html; charset=UTF-8");
//			PrintWriter out = response.getWriter();

		ReplyVo replyVO = new ReplyVo();
		replyVO.setReply_id(id);
		replyVO.setReply_num(replyNum);
		int result = searchDao.replyDelete(replyVO);
		if (result != 0) {
			System.out.println("댓글 delete 성공");
		} else {
			System.out.println("댓글 delete 실패");
		}
	}

	public ModelAndView registerParking(MeetyouallParkVo meetyouall, String addr2, String addr3) {
		mav = new ModelAndView();

		meetyouall.setParkimg("../resources/img/placeImages/none.png");

		meetyouall.setRdnmadr(addr2 + addr3);
		meetyouall.setLnmadr(addr2 + addr3);

		System.out.println("마지막" + meetyouall.toString());

		int result = searchDao.registerParking(meetyouall);

		if (result > 0) {
			mav.setViewName("search/registersuccess");
		}

		return mav;
	}

	public ModelAndView myparkingkList(BookMarkVo book) {
		mav = new ModelAndView();
		List<MeetyouallParkVo> myparkingkList = new ArrayList<>();
		myparkingkList = searchDao.myparkingkList(book);

		mav.addObject("myparking", myparkingkList);
		mav.setViewName("search/myparkingkList");
		return mav;

	}

	// 주차장 신청시 booking_list에 저장.
	public ModelAndView parkingApply(BookingVo book) {
		mav = new ModelAndView();
		BookingVo applyBook = book;
		// booking_list에 저장
		searchDao.parkingApply(applyBook);
		System.out.println("booking_list에 저장");

		// booking_id 가져오기
		applyBook = searchDao.bookingInfo(applyBook.getUser_id());

		// reservation.jsp에 보낼 예약 정보 가져오기.
		// parking_name이 필요해서 join 후 정보 가져오기
		BookingVo booking = searchDao.bookingInsertInfo(applyBook.getBooking_id());
		mav.addObject("booking", booking);
		mav.setViewName("payment/reservation");
		return mav;
	}

	// 예약 내역 페이지 (로그인 이메일 해당)
	public ModelAndView reservationList() {
		mav = new ModelAndView();
		String login = (String) session.getAttribute("loginID");

		List<BookingVo> reservationList = searchDao.bookingList(login);
		mav.addObject("reservation", reservationList);
		mav.setViewName("payment/reservationList");

		return mav;
	}
	// 예약 관리 페이지
	public ModelAndView reserveList() {
		mav = new ModelAndView();

		// 예약 리스트 가져옴
		List<BookingVo> reserveList = searchDao.reserveList();
		mav.addObject("reserve", reserveList);
		mav.setViewName("payment/reservationManage");

		return mav;
	}

	// 주차장 정보 수정시 정보 보이기
	public ModelAndView modifyparkForm(MeetyouallParkVo meetyouall) {
		mav = new ModelAndView();
		MeetyouallParkVo parkinfo = searchDao.modifyparkForm(meetyouall);
		mav.addObject("parkinfo", parkinfo);
		mav.setViewName("search/modifyparkForm");
		return mav;
	}

	// 주차장 수정
	public ModelAndView modifyparking(MeetyouallParkVo meetyouall, HttpServletResponse response, String addr2,
			String addr3) throws IOException {
		mav = new ModelAndView();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		meetyouall.setRdnmadr(addr2);
		meetyouall.setLnmadr(addr2);
		System.out.println(meetyouall.toString());
		int result = searchDao.modifyparking(meetyouall);

		/*
		 * if(result>0) { out.println("<script>"); out.println("alert('수정 완료')");
		 * out.println("redirect:'../search/search'"); out.println("</script>");
		 * out.close();
		 * 
		 * }
		 */
		mav.setViewName("search/search");
		return mav;
	}

	// 주차장 삭제
	public ModelAndView deletePark(MeetyouallParkVo meetyouall) {
		mav = new ModelAndView();
		searchDao.deletePark(meetyouall);
		mav.setViewName("search/search");
		return mav;
	}

	// 관리자 주차장 미승인 리스트
	public ModelAndView stateparking() {
		mav = new ModelAndView();
		List<MeetyouallParkVo> parkList = new ArrayList<>();

		parkList = searchDao.stateList();
		mav.addObject("parkList", parkList);
		mav.setViewName("search/confirmList");
		return mav;
	}

	// 홈으로가기
	public ModelAndView gotohome() {
		mav = new ModelAndView();
		mav.setViewName("search/search");
		return mav;
	}

	// 관리자 주차장 승인
	public ModelAndView confirmpark(MeetyouallParkVo meetyouall) {
		mav = new ModelAndView();
		mav.setViewName("search/search");
		searchDao.confirmpark(meetyouall);
		return mav;
	}
	
	//자식창 close, 부모창 home으로.
	public void resultHome(HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter(); // 팝업창 없애기 위해서 사용
		out.println("<script> window.opener.location.href='../search/gohome'; self.close();");
		out.println("</script>");
	}

	//자식창 close, 부모창 예약 내역으로
	public void reservePage(HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter(); // 팝업창 없애기 위해서 사용
		out.println("<script> window.opener.location.href='../search/bookingList'; self.close();");
		out.println("</script>");
		
	}
	
	//예약 취소시 삭제
	public void applyCancel(String booking_id) {
		int cancel = searchDao.applyCancel(booking_id);

		if (cancel != 0) {
			System.out.println("중복확인 아이디 삭제 완료");
		} else {
			System.out.println("중복확인 아이디 삭제 실패");
		}
		
	}
	
}
