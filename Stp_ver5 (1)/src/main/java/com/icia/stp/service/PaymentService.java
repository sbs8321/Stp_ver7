package com.icia.stp.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.stp.dao.PaymentDAO;
import com.icia.stp.vo.BookingVo;
import com.icia.stp.vo.ExchangeVo;
import com.icia.stp.vo.MeetyouallParkVo;
import com.icia.stp.vo.OwnerVo;
import com.icia.stp.vo.PaymentListVo;
import com.icia.stp.vo.PaymentVo;
import com.icia.stp.vo.PointVo;
import com.icia.stp.vo.UserVo;

@Service
public class PaymentService {

	@Autowired
	private PaymentDAO paymentDAO;

	private ModelAndView mav;

	@Autowired
	private HttpSession session;

	// 포인트 내역 페이지
	public ModelAndView pointPage() {
		mav = new ModelAndView();
		String login = (String) session.getAttribute("loginID");
		List<PointVo> pointList = paymentDAO.pointList(login);

		System.out.println("!!!!!!!!!사이즈" + pointList.size());
		for (int i = 0; i < pointList.size(); i++) {
			System.out.println("가져온 List : " + pointList.get(i).toString());
		}

		UserVo member = paymentDAO.memberPoint(login);
		System.out.println("db에서 가져온 잔여 포인트 값: " + member.getPoint());

		mav.addObject("pointList", pointList);
		mav.addObject("pointBalance", member.getPoint());

		mav.setViewName("payment/pointPage");
		return mav;
	}

	// 결제 페이지로 넘길 데이터 가져오기
	public ModelAndView payPage(String payment_balance) {
		mav = new ModelAndView();
		String login = (String) session.getAttribute("loginID");
		UserVo member = paymentDAO.memberInfo(login);
		int balance = Integer.parseInt(payment_balance);

		String addr = member.getAddr2() + member.getAddr3();
		String phone = member.getPhone_front() + member.getPhone_mid() + member.getPhone_end();

		mav.addObject("memberInfo", member);
		mav.addObject("addr", addr);
		mav.addObject("phone", phone);
		mav.addObject("paymentOption", "포인트 충전");
		mav.addObject("charge", balance);
		mav.setViewName("payment/payment");

		return mav;
	}

	// 포인트 충전 페이지
	public ModelAndView pointCharge() {
		mav = new ModelAndView();
		String login = (String) session.getAttribute("loginID");
		UserVo member = new UserVo();
		member = paymentDAO.memberInfo(login); // 정보 가져오기

		if (member != null) {
			mav.addObject("memberInfo", member);
			mav.setViewName("payment/pointCharge");

		}
		return mav;
	}

	// pay 사용 결과
	public ModelAndView result(String data, String parkingName, String payment, HttpServletResponse response)
			throws IOException {
		mav = new ModelAndView();
		response.setContentType("text/html; charset=utf-8");

		System.out.println("payment에서 넘어온  parkingName 값 : " + parkingName);
		mav = new ModelAndView();
		PrintWriter out = response.getWriter(); // alert창 띄우기 위해서 선언

		int charge = Integer.parseInt(data);// 값
		String paymentOption = payment;// 결제 유형 (포인트 충전, 환불 등)
		String login = (String) session.getAttribute("loginID");

		// 포인트 충전
		if (parkingName.contains("포인트")) {
			System.out.println("포인트");
			int division = 0;

			// 0이면 충전, 1이면 사용, 2이면 환불
			if (paymentOption.contains("충전")) {
				division = 0;
			} else if (paymentOption.contains("사용")) {
				division = 1;
			} else if (paymentOption.contains("환불")) {
				division = 2;
			} else if (paymentOption.contains("환전")) {
				division = 3;
			}

			PointVo point = new PointVo();

			point.setUser_email(login);
			point.setDivision(division);

			UserVo user = new UserVo();
			user.setEmail(login);
			user.setPoint(charge);
			// 포인트 테이블에 추가하기
			int pointResult = paymentDAO.pointInsert(point);

			if (pointResult > 0) {// 입력 성공하면
				// user테이블 point값 더해주기
				int pointUp = paymentDAO.pointUp(user);
				if (pointUp > 0) {
					mav.addObject("point", parkingName);
					mav.addObject("charge", data);
					mav.setViewName("payment/payResult");
				}
			}
		}
		// pay 결제
		else {
			System.out.println("pay결제");
			// admin balance에 결제한 금액 들어가도록하기
			UserVo admin = new UserVo();
			admin.setName("admin");
			admin.setBalance(charge);
			paymentDAO.adminBalanceUp(admin);
			System.out.println("admin balance 값 추가 ");

			// booking_list 내역 가져오기
			BookingVo booking = paymentDAO.bookingInfo(login);
			System.out.println("예약된 값만 내역 가져오기 " + booking.toString());

			// payment 테이블에 결제 내역 저장하기
			PaymentVo payments = new PaymentVo();
			payments.setPayment_balance(charge);
			payments.setUser_email(login);
			payments.setPayment_state(1);// 포인트 결제:0 / 카카오페이:1
			payments.setBooking_id(booking.getBooking_id());
			paymentDAO.paymentAdd(payments);
			System.out.println("payment 테이블 추가");

			// payment 정보가져오기
			payments = paymentDAO.paymentInfo2(booking.getBooking_id());
			System.out.println("가져온 payment 값 :" + payments.toString());

			// booking list flag를 1로 변환하기(결제완료 표시)
			booking.setPayment_flag(1);
			booking.setBooking_id(booking.getBooking_id());
			booking.setPayment_id(payments.getPayment_id());
			paymentDAO.bookingChange(booking);
			System.out.println("booking 테이블 payment 관련 필드 변경");

			// 예약 정보가져오기
			String booking_id = booking.getBooking_id();
			booking = paymentDAO.bookingInfo2(booking_id); 
			System.out.println("result 페이지로 보낸 정보 가져옴 :"+booking.toString());
			
			// 주차장 관련 정보 가져오기.
			MeetyouallParkVo info = new MeetyouallParkVo();
			String[] name = parkingName.split(" ");
			System.out.println(name[0]);
			info.setPrkplcenm(name[0]);
			info.setPrkplceno(booking.getParking_id());
			MeetyouallParkVo parking = paymentDAO.ownerEmail(info);
			
			System.out.println("result 페이지로 보낸 정보 가져옴 :"+parking.toString());

			mav.addObject("booking", booking);
			mav.addObject("parking", parking);
			mav.setViewName("payment/result");

		}

		return mav;

	}

	// 잔액 조회하기
	public void pointCheck(String email, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");

		UserVo member = paymentDAO.memberPoint(email);
		if (member != null) {
			response.getWriter().print(member.getPoint());
		} else {
			response.getWriter().print("0");
		}

	}

	// 예약페이지에서 결제하기
	public ModelAndView payUse(String option, String balance) {
		mav = new ModelAndView();
		String login = (String) session.getAttribute("loginID");
		UserVo member = paymentDAO.memberInfo(login);

		String addr = member.getAddr2() + member.getAddr3();
		String phone = member.getPhone_front() + member.getPhone_mid() + member.getPhone_end();
		System.out.println("예약 페이지에서 결제하기");

		mav.addObject("memberInfo", member);
		mav.addObject("addr", addr);
		mav.addObject("phone", phone);
		mav.addObject("paymentOption", option);
		mav.addObject("charge", balance);
		mav.setViewName("payment/payment");

		return mav;
	}

	// 포인트 사용하기
	public ModelAndView pointUse(String balance, String parkingName, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");

		mav = new ModelAndView();
		PrintWriter out = response.getWriter(); // alert창 띄우기 위해서 선언

		String login = (String) session.getAttribute("loginID");
		System.out.println("시작");

		// user 테이블 point 변경시키기
		UserVo user = new UserVo();
		user.setPoint(Integer.parseInt(balance));
		user.setEmail(login);
		paymentDAO.memberPointUse(user); // user테이블 point 변경
		System.out.println("user 테이블 point 변경");

		// booking정보 가져오기
		// 로그인한 회원의 예약및결제 확인 테이블의 정보를 가져옴.
		BookingVo booking = paymentDAO.bookingInfo(login);
		System.out.println("booking정보 가져오기" + booking.toString());

		// 주차장 관련 정보 가져오기.
		MeetyouallParkVo info = new MeetyouallParkVo();
		info.setPrkplcenm(parkingName);
		info.setPrkplceno(booking.getParking_id());

		MeetyouallParkVo ownerEmail = paymentDAO.ownerEmail(info);
		System.out.println("ownerEmail!!!!" + ownerEmail);
		OwnerVo owner = new OwnerVo();

		// owner 테이블 point 변경시키기
		owner.setEmail(ownerEmail.getOwner());
		owner.setPoint(Integer.parseInt(balance));
		paymentDAO.ownerPointup(owner);
		System.out.println("owner 테이블 point 변경");

		// point 테이블 변경 내역 저장하기 ==>paymentId 업데이트 해야 함.
		PointVo point = new PointVo();
		point.setBooking_id(booking.getBooking_id());
		point.setDivision(1); // 포인트 충전:0 / 포인트 사용:1 / 포인트환불:2 / 포인트환전:3
		point.setUser_email(login);
		paymentDAO.pointInsert(point);
		System.out.println("point 테이블 추가");

		// payment 테이블에 결제 내역 저장하기
		PaymentVo payment = new PaymentVo();
		payment.setPayment_balance(Integer.parseInt(balance));
		payment.setUser_email(login);
		payment.setPayment_state(0);// 포인트 결제:0 / 카카오페이:1
		payment.setBooking_id(booking.getBooking_id());
		paymentDAO.paymentAdd(payment);
		System.out.println("payment 테이블 추가");

		// payment 정보가져오기
		payment = paymentDAO.paymentInfo(booking.getBooking_id());

		// points 테이블 payment_id 업데이트
		point.setBooking_id(booking.getBooking_id());
		point.setPayment_id(payment.getPayment_id());
		paymentDAO.paymentUpdate(point);
		System.out.println("point 테이블에 payment_id 변경");

		// booking list flag를 1로 변환하기(결제완료 표시)
		booking.setPayment_flag(1);
		booking.setBooking_id(booking.getBooking_id());
		booking.setPayment_id(payment.getPayment_id());
		paymentDAO.bookingChange(booking);
		System.out.println("booking 테이블 payment 관련 필드 변경");

		out.println("<script> alert('포인트 결제가 완료되었습니다.'); ");
		out.println(" </script>");

		// 예약 정보 띄우기
		mav.addObject("parking", ownerEmail);
		mav.addObject("booking", booking);
		mav.setViewName("payment/result");
		return mav;
	}

	// 환전 포인트 가져오기
	public void ownerInfo(HttpServletResponse response) throws IOException {
		String login = (String) session.getAttribute("loginID");
		System.out.println("환전페이지로 넘긴 아이디 :" + login);

		OwnerVo owner = paymentDAO.ownerInfo(login);
		System.out.println("가져온 owner 정보 :" + owner);
		if (owner != null) {
			response.getWriter().print(owner.getPoint());
			System.out.println("환전 포인트 가져오기");
		}

	}

	// 환전 신청하기
	public void exchangeApply(String exchangeBalance, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter(); // 팝업창 없애기 위해서 사용

		int balance = Integer.parseInt(exchangeBalance);
		String login = (String) session.getAttribute("loginID");

		// owner 테이블 exchange 필드 1로 바꾸기
		OwnerVo owner = new OwnerVo();
		owner.setExchange(1);
		owner.setEmail(login);
		paymentDAO.exchangeChange(owner);
		System.out.println("owner 테이블의 exchange 필드 변경");

		// exchange 테이블 신청 내역 추가하기
		ExchangeVo exchange = new ExchangeVo();
		exchange.setOwner_id(login);
		exchange.setBalance(balance);
		paymentDAO.exchangeUpdate(exchange);
		System.out.println(" exchange 테이블 신청 내역 추가하기");

		out.println("<script> alert('환전신청이 되었습니다.'); ");
		out.println("window.opener.location.reload(); self.close();");
		out.println(" </script>");

	}

	// 환전 관리 페이지
	public ModelAndView exchangeManage() {
		mav = new ModelAndView();
		// 환전 신청 이름(name) / 환전 신청한 포인트 / 환전된 금액 / 승인 버튼
		List<ExchangeVo> exchange = paymentDAO.exchangeLists();

		mav.addObject("exchangeList", exchange);
		mav.setViewName("payment/exchangeManage");
		return mav;
	}

	// 환전 번호에 해당하는 balance 가져오기
	public void exchangeIdBalance(String exchangeId, HttpServletResponse response) throws IOException {
		// exchange table에서 해당하는 balance 가져오기
		ExchangeVo exchange = paymentDAO.exchangeInfo(exchangeId);

		if (exchange != null) {
			System.out.println(exchange.getBalance());
			response.getWriter().print(exchange.getBalance());
		}

	}

	// 환전 신청 승인하기
	public void exchangeOK(String exchangeId1, String balance1, HttpServletResponse response) throws IOException {
		boolean flag = false;
		String exchangeId = exchangeId1;
		int balance = Integer.parseInt(balance1);

		// exchangeId에 해당하는 정보 가져오기
		ExchangeVo exchange = paymentDAO.exchangeInfo(exchangeId);
		System.out.println("exchangeId에 해당하는 정보 가져오기" + exchange.toString());

		// exchange 테이블에서 삭제하기
		paymentDAO.exchangeDelete(exchangeId);
		System.out.println("exchange 테이블에 id에 해당하는 데이터 삭제하기");

		// 승인 신청했던 아이디가 환전 테이블에 있는지 확인
		List<ExchangeVo> exchangeList = paymentDAO.exchangeLists();
		System.out.println("삭제 후 exchangeList 가져오기" + exchangeList.toString());

		int count = 0;
		if (exchangeList != null) {
			for (int i = 0; i < exchangeList.size(); i++) {
				// 같은게 있다면 owner 의 exchange 필드 변경 없음.
				if (exchangeList.get(i).getOwner_id().equals(exchange.getOwner_id())) {
					count++;
				}
			}
		}
		System.out.println("count 값 : " + count);
		if (count > 0)
			flag = true;
		else
			flag = false;

		// 환전 승인된 owner 테이블 데이터 변경
		OwnerVo owner = new OwnerVo();
		if (flag) {// 같은게 있다면 owner 의 exchange 필드 변경 없음.
			// owner 테이블 변경 point- balance+
			owner.setBalance(balance);
			owner.setEmail(exchange.getOwner_id());
			owner.setPoint(exchange.getBalance());
			paymentDAO.exchangeApplyChange(owner);
		} else {// 같은 게 없으면 owner의 exchange 필드 변경 필요.
			owner.setBalance(balance);
			owner.setEmail(exchange.getOwner_id());
			owner.setPoint(exchange.getBalance());
			paymentDAO.exchangeApplyExchangeChange(owner);
		}

		// admin(user,owner)의 balance 변경하기
		UserVo uAdmin = new UserVo();
		uAdmin.setName("admin");
		uAdmin.setBalance(balance);
		paymentDAO.userAdminChange(uAdmin);

		OwnerVo oAdmin = new OwnerVo();
		oAdmin.setName("admin");
		oAdmin.setBalance(balance);
		paymentDAO.ownerAdminChange(oAdmin);

		response.getWriter().print(true);
		System.out.println("승인 완료창!!!");

	}

	// 결제 내역 페이지
	public ModelAndView paymentList() {
		mav = new ModelAndView();
		String login = (String) session.getAttribute("loginID");
		System.out.println("로그인한 아이디 : " + login);
		List<PaymentListVo> paymentList = paymentDAO.paymentList(login);
		System.out.println("결제 내역 리스트 ");

		// payment 정보
		mav.addObject("payment", paymentList);
		mav.setViewName("payment/paymentList");

		// booking 정보

		// parking 정보

		return mav;
	}

	// 환전 신청 목록 페이지
	public ModelAndView exchangeList() {
		mav = new ModelAndView();
		String login = (String) session.getAttribute("loginID");
		List<ExchangeVo> exchangeList = paymentDAO.exchangeList(login);

		System.out.println("exchangeList 목록 :" + exchangeList.toString());
		mav.addObject("exchange", exchangeList);
		mav.setViewName("payment/exchangeList");
		return mav;
	}

	// 자식창 close, 부모창 home으로.
	public void pointListPage(HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter(); // 팝업창 없애기 위해서 사용
		out.println("<script> window.opener.location.href='../payment/pointList'; self.close();");
		out.println("</script>");
	}

}
