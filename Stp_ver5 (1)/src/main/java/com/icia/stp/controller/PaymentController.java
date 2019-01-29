package com.icia.stp.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icia.stp.service.PaymentService;

@Controller
@RequestMapping(value = "/payment/*")
public class PaymentController {

	@Autowired
	PaymentService ps;

	ModelAndView mav;

	// 결제 내역 페이지
	@RequestMapping(value = "/paymentList", method = RequestMethod.POST)
	public ModelAndView paymentList() {
		mav = new ModelAndView();
		mav = ps.paymentList();
		return mav;

	}

	// 결제 페이지 연결
	@RequestMapping(value = "/payPage", method = RequestMethod.POST)
	public ModelAndView payPage(@RequestParam String payment_balance) {
		mav = new ModelAndView();
		String balance = payment_balance; // 포인트 +1000p
		mav = ps.payPage(balance);
		return mav;
	}

	// 예약 페이지에서 결제하기
	@RequestMapping(value = "/payUse", method = RequestMethod.POST)
	public ModelAndView payUse(@RequestParam("balance") String balance,
			@RequestParam("parkingName") String parkingName) {
		mav = new ModelAndView();
		String option = parkingName + " 결제";
		mav = ps.payUse(option, balance);
		return mav;
	}

	// 결제 완료 페이지(포인트)
	@RequestMapping(value = "/resultPage", method = RequestMethod.GET)
	public String resultPage() {
		return "payment/result";
	}

	// ----------------------------------------------------------------------------포인트

	// 포인트 내역 페이지(잔액 페이지)
	@RequestMapping(value = "/pointPage", method = RequestMethod.POST)
	public ModelAndView pointPage() {
		System.out.println("pointPage() 호출");
		mav = new ModelAndView();
		mav = ps.pointPage();
		return mav;

	}

	// 포인트 내역 페이지(잔액 페이지)
		@RequestMapping(value = "/pointList", method = RequestMethod.GET)
		public ModelAndView pointList() {
			System.out.println("pointList() 호출");
			mav = new ModelAndView();
			mav = ps.pointPage();
			return mav;

		}
	// 포인트 충전 페이지 (충전 금액 .jsp)
	@RequestMapping(value = "/pointCharge", method = RequestMethod.POST)
	public ModelAndView pointCharge() {
		mav = new ModelAndView();
		mav = ps.pointCharge();
		return mav;
	}

	// 포인트 잔액 확인하기
	@RequestMapping(value = "/pointCheck", method = RequestMethod.POST)
	public void pointCheck(@RequestParam("email") String email, HttpServletResponse response) throws IOException {
		ps.pointCheck(email, response);
	}

	// 포인트 사용하기
	@RequestMapping(value = "/pointUse", method = RequestMethod.POST)
	public ModelAndView pointUse(@RequestParam("balance") String balance,
			@RequestParam("parkingName") String parkingName, HttpServletResponse response) throws IOException {
		mav = new ModelAndView();
		mav = ps.pointUse(balance, parkingName, response);
		return mav;
	}

	// 페이 사용 결과페이지
	@RequestMapping(value = "/result", method = RequestMethod.POST)
	public ModelAndView result(@RequestParam String data, @RequestParam String parkingName, String payment,
			HttpServletResponse response) throws IOException {
		mav = new ModelAndView();
		mav = ps.result(data, payment, parkingName, response);
		return mav;
	}

//-------------------------------------------------------------------------------------환전

	// 환전가능한 포인트 확인
	@RequestMapping(value = "/ownerInfo", method = RequestMethod.POST)
	public void exchange(HttpServletResponse response) throws IOException {
		ps.ownerInfo(response);
	}

	// 환전 신청하기
	@RequestMapping(value = "/exchangeApply", method = RequestMethod.POST)
	public void exchangeApply(@RequestParam String exchangeBalance, HttpServletResponse response) throws IOException {
		System.out.println("jsp에서 넘어온 exchangeBalance 값 : " + exchangeBalance);
		ps.exchangeApply(exchangeBalance, response);
	}

	// 환전 페이지
	@RequestMapping(value = "/exchange", method = RequestMethod.POST)
	public String exchange() {
		return "payment/exchange";
	}

	// 환전 관리 페이지 (admin용)
	@RequestMapping(value = "/exchangeManage", method = RequestMethod.POST)
	public ModelAndView exchangeManage() {
		mav = new ModelAndView();
		mav = ps.exchangeManage();
		return mav;
	}

	// 환전 번호에 해당하는 balance 가져오기
	@RequestMapping(value = "/exchangeIdBalance", method = RequestMethod.POST)
	public void exchangeIdBalance(@RequestParam String exchangeId, HttpServletResponse response) throws IOException {
		System.out.println("환전 번호 :" + exchangeId);
		ps.exchangeIdBalance(exchangeId, response);

	}

	// 환전 승인하기
	@RequestMapping(value = "/exchangeOK", method = RequestMethod.POST)
	public void exchangeOK(@RequestParam String exchangeId, @RequestParam String balance, HttpServletResponse response)
			throws IOException {
		System.out.println("컨트롤러로 넘어온 값 : " + exchangeId + "," + balance);
		ps.exchangeOK(exchangeId, balance, response);
	}

	// 환전 신청 목록 페이지
	@RequestMapping(value = "/exchangeList", method = RequestMethod.POST)
	public ModelAndView exchangeList() {
		mav = new ModelAndView();
		mav = ps.exchangeList();
		return mav;
	}

	// 결제 완료(result)페이지에서 부모창을 홈페이지로 넘기기
	@RequestMapping(value = "/pointListPage", method = RequestMethod.POST)
	public void pointListPage(HttpServletResponse response) throws IOException {
		ps.pointListPage(response);
	}

}