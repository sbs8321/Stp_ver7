package com.icia.stp.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.stp.vo.BookMarkVo;
import com.icia.stp.vo.BookingVo;
import com.icia.stp.vo.MeetyouallParkVo;
import com.icia.stp.vo.ReplyVo;
import com.icia.stp.vo.UserVo;

@Repository
public class SearchDAO {
	@Autowired
	private SqlSessionTemplate sql; // mybatis 에서 제공하는 클래스

	public List<MeetyouallParkVo> pkList(MeetyouallParkVo meetyouall) {
		System.out.println("DAO" + meetyouall.getLatitude());
		System.out.println("DAO" + meetyouall.getHardness());
		return sql.selectList("Search.pkList", meetyouall);
	}

	public List<MeetyouallParkVo> pkmk() {
		System.out.println("여기");
		return sql.selectList("Search.pkarmark");
	}

	public MeetyouallParkVo parkDetail(MeetyouallParkVo meetyouall) {
		return sql.selectOne("Search.parkDetail", meetyouall);
	}

	public int bookable(BookingVo bookingVo) {
		return sql.selectOne("Search.bookable", bookingVo);
	}

	public MeetyouallParkVo countArea(BookingVo bookingVo) {
		return sql.selectOne("Search.countArea", bookingVo);
	}

	public BookMarkVo bookmark(BookMarkVo bookmark) {
		return sql.selectOne("Search.bookmaking", bookmark);
	}

	public int addbookmark(BookMarkVo book) {
		return sql.insert("Search.addbook", book);
	}

	public int delbookmark(BookMarkVo book) {
		return sql.delete("Search.delbook", book);
	}

	public List<BookMarkVo> bookmarkList(BookMarkVo book) {
		return sql.selectList("Search.bkList", book);
	}

	public int replyWrite(ReplyVo replyVO) {
		return sql.insert("Search.replyWrite", replyVO);
	}

	public List<ReplyVo> replyList(String parkingId) {
		return sql.selectList("Search.replyList", parkingId);
	}

	public int replyDelete(ReplyVo replyVO) {
		return sql.delete("Search.replyDelete", replyVO);
	}

	// 주차장 번호
	public int prkplceno() {
		return sql.selectOne("Search.prkplceno");
	}

	public int registerParking(MeetyouallParkVo meetyouall) {
		return sql.insert("Search.registerParking", meetyouall);
	}

	public List<MeetyouallParkVo> myparkingkList(BookMarkVo book) {
		return sql.selectList("Search.myparkingkList", book);
	}

	// 주차장 신청 시 booking_list에 저장.
	public int parkingApply(BookingVo book) {
		return sql.insert("Booking.parkingApply", book);

	}

	// 예약 페이지로 넘길 정보 가져오기
	public BookingVo bookingInsertInfo(String booking_id) {
		return sql.selectOne("Booking.bookingInsertInfo", booking_id);
	}

	//가격 계산하기 위해서 정보 가져오기
	public MeetyouallParkVo pakingInfo(String parking_id) {
		return sql.selectOne("Parking.parkingInfo", parking_id);
	}
	//booking_id 가져오기
	public BookingVo bookingInfo(String login) {
		return sql.selectOne("Booking.bookingInfo",login);
	}
	
	//예약 내역 페이지
	public List<BookingVo> bookingList(String login) {
		return sql.selectList("Booking.bookingList", login);
	}

	//예약 전체 리스트 가져오기
	public List<BookingVo> reserveList() {
		return sql.selectList("Booking.reserveList");
	}
	//주차장 정보 가져오기
	public MeetyouallParkVo modifyparkForm(MeetyouallParkVo meetyouall) {
		return  sql.selectOne("Search.modifyparkForm",meetyouall);
	}
	//주차장 수정
	public int modifyparking(MeetyouallParkVo meetyouall) {
		return sql.update("Search.modifyparking",meetyouall);
	}
	//주차장 삭제
	public void deletePark(MeetyouallParkVo meetyouall) {
		sql.delete("Search.deletePark",meetyouall);	
	}
	//관리자 미승인 주차장 리스트	
	public List<MeetyouallParkVo> stateList() {
		return sql.selectList("Search.stateList");
	}
	//관리자 주차장 승인
	public void confirmpark(MeetyouallParkVo meetyouall) {
		sql.update("Search.confirmpark",meetyouall);		
	}
	
	//예약 페이지 벗어나면 값 없애기
	public int applyCancel(String booking_id) {
		return sql.delete("Booking.applyCancel", booking_id);
	}	
	
	
}
