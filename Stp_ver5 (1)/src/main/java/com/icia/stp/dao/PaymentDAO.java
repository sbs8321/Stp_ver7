package com.icia.stp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.stp.vo.BookingVo;
import com.icia.stp.vo.ExchangeVo;
import com.icia.stp.vo.MeetyouallParkVo;
import com.icia.stp.vo.OwnerVo;
import com.icia.stp.vo.PaymentListVo;
import com.icia.stp.vo.PaymentVo;
import com.icia.stp.vo.PointVo;
import com.icia.stp.vo.UserVo;

@Repository
public class PaymentDAO {

	@Autowired
	private SqlSessionTemplate sql;

	// 포인트 내역 리스트
	public List<PointVo> pointList(String id) {
		return sql.selectList("Point.PointList", id);
	}

	// 포인트 잔액
	public UserVo memberPoint(String id) {
		return sql.selectOne("User.pointBalance", id);
	}

	// 회원 정보 가져오기
	public UserVo memberInfo(String login) {
		return sql.selectOne("User.memberInfo", login);
	}

	public int paymentInput(PaymentVo payment) {
		return sql.insert("Payment.paymentInput", payment);
	}

	public PaymentVo paymentInfo(String booking_id) {
		return sql.selectOne("Payment.paymentInfo", booking_id);
	}
	public PaymentVo paymentInfo2(String booking_id) {
		return sql.selectOne("Payment.paymentInfo2", booking_id);
	}


	// 포인트 변경사항 저장.
	public int pointInsert(PointVo point) {
		return sql.insert("Point.pointInsert", point);
	}

	// 포인트 충전
	public int pointUp(UserVo user) {
		return sql.update("User.pointUp", user);
	}

	// 포인트 사용-user
	public int memberPointUse(UserVo user) {
		return sql.update("User.pointUse", user);
	}

	// user가 사용한 포인터를 저장한 주차장owner email 찾기
	public MeetyouallParkVo ownerEmail(MeetyouallParkVo info) {
		return sql.selectOne("Parking.ownerEmail", info);
	}

	// owner의 point 올리기
	public int ownerPointup(OwnerVo owner) {
		return sql.update("Owner.ownerPointUp", owner);
	}

	// 결제 내역 저장하기
	public int paymentAdd(PaymentVo payment) {
		return sql.insert("Payment.paymentAdd", payment);
	}

	// 예약 테이블 결제 플레그 상태변환
	public int bookingFlagChange(String login) {
		return sql.update("Booking.bookingFlagChange", login);

	}

	// 예약 및 결제 정보 가져옴.
	public BookingVo bookingInfo(String login) {
		return sql.selectOne("Booking.bookingInfo", login);
	}

	public BookingVo bookingInfo2(String booking_id) {
		return sql.selectOne("Booking.bookingInfo2", booking_id);
	}

	// booking 테이블의 payment 업데이트
	public int bookingChange(BookingVo booking) {
		return sql.update("Booking.bookingChange", booking);

	}

	// point 테이블의 payment 업데트
	public int paymentUpdate(PointVo point) {
		return sql.update("Point.paymentUpdate", point);

	}

	// user가 카드 결제시 admin 계좌에 돈이 들어감.
	public int adminBalanceUp(UserVo admin) {
		return sql.update("User.adminBalanceUp", admin);

	}

	// 기업회원 정보 가져오기
	public OwnerVo ownerInfo(String login) {
		return sql.selectOne("Owner.ownerInfo", login);
	}

	// 환전 신청한 owner의 exchange 필드 값 1로 변경하기
	public int exchangeChange(OwnerVo owner) {
		return sql.update("Owner.exchangeChange", owner);
	}

	// 환전 테이블에 신청 내역 저장하기
	public int exchangeUpdate(ExchangeVo exchange) {
		return sql.insert("Exchange.exchangeInsert", exchange);

	}

	// 환전 리스트 가져오기
	public List<ExchangeVo> exchangeLists() {
		return sql.selectList("Exchange.exchangeLists");
	}

	// 환전 번호에 해당하는 정보 가져오기
	public ExchangeVo exchangeInfo(String exchangeId) {
		return sql.selectOne("Exchange.exchangeIdBalance", exchangeId);

	}

	// 환전 테이블에서 해당 환전 번호 관련 정보 삭제하기
	public int exchangeDelete(String exchangeId) {
		return sql.delete("Exchange.exchangeDelete", exchangeId);
	}

	// owner 테이블 point, balance 변경하기 (exchange 변경하지 않음)
	public int exchangeApplyChange(OwnerVo owner) {
		return sql.update("Owner.exchangeApplyChange", owner);
	}

	// owner 테이블 point, balance 변경하기 (exchange 변경함)
	public int exchangeApplyExchangeChange(OwnerVo owner) {
		return sql.update("Owner.exchangeApplyChange", owner);
	}

	// user테이블에 있는 admin balance 변경
	public int userAdminChange(UserVo admin) {
		return sql.update("User.adminUpdate", admin);

	}

	// owner테이블에 있는 admin balance 변경
	public int ownerAdminChange(OwnerVo admin) {
		return sql.update("Owner.adminUpdate", admin);
	}

	// 결제 내역 페이지
	public List<PaymentListVo> paymentList(String login) {
		return sql.selectList("PaymentList.paymentList", login);
	}

	// 환전 내역 페이지
	public List<ExchangeVo> exchangeList(String login) {
		return sql.selectList("Exchange.exchangeList", login);
	}

	// 결과 페이지에 보여줄 내용
	public BookingVo bookingList(String login) {
		return sql.selectOne("Booking.bookingInsertInfo", login);
	}

}
