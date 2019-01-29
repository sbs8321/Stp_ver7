package com.icia.stp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.stp.vo.OwnerVo;
import com.icia.stp.vo.UserVo;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate sql;

	public int joinUserDao(UserVo userVo) {
		return sql.update("User.joinUser", userVo);

	}

	public int joinOwnerDao(OwnerVo ownerVo) {
		return sql.insert("User.joinOwner", ownerVo);

	}

	public UserVo userLoginDao(UserVo userVo) {
		System.out.println("DAO");
		return sql.selectOne("User.userLogin", userVo);
	}

	public OwnerVo ownerLoginDao(OwnerVo ownerVo) {
		return sql.selectOne("User.ownerLogin", ownerVo);
	}

	public UserVo userFindIdDao(UserVo userVo) {
		return sql.selectOne("User.userFindId", userVo);
	}

	public OwnerVo ownerFindIdDao(UserVo userVo) {
		return sql.selectOne("User.ownerFindId", userVo);
	}

	public UserVo idOverlap(String email) {
		return sql.selectOne("User.idOverlap", email);
	}

	public OwnerVo idOverlapOwner(String email) {
		return sql.selectOne("User.idOverlapOwner", email);
	}

	public void idInsert(String id) {
		sql.insert("User.idInsert", id);

	}

	public void idInsertOwner(String id) {
		sql.insert("User.idInsertOwner", id);

	}

	public int joinCancel(String id) {
		return sql.delete("User.joinCancel", id);
	}

	// 일반회원 해당 email에 인증 키 업데이트
	public void usercreateAuthKey(String email, String key) {
		UserVo vo = new UserVo();
		vo.setAuthkey(key);
		vo.setEmail(email);
		;
		sql.update("User.usercreateAuthKey", vo);
	}

	// 일반회원 이메일 인증 코드 확인
	public UserVo userchkAuth(UserVo userVo) {
		return sql.selectOne("User.userchkAuth", userVo);
	}

	// 일반회원 인증 후 계정 활성화
	public void useruserAuth(UserVo userVo) {
		sql.update("User.useruserAuth", userVo);
	}

	// 기업 회원 해당 email에 인증 키 업데이트
	public void ownercreateAuthKey(String email, String key) {
		OwnerVo vo = new OwnerVo();
		vo.setAuthkey(key);
		vo.setEmail(email);
		;
		sql.update("User.ownercreateAuthKey", vo);
	}

	// 기업 회원 이메일 인증 코드 확인
	public OwnerVo ownerchkAuth(OwnerVo ownerVo) {
		return sql.selectOne("User.ownerchkAuth", ownerVo);
	}

	// 기업 회원 인증 후 계정 활성화
	public void owneruserAuth(OwnerVo ownerVo) {
		sql.update("User.owneruserAuth", ownerVo);
	}

	// 인증하지 않은 계정 로그인 막기
	public UserVo userstatecheck(UserVo userVo) {
		return sql.selectOne("User.userchkstate", userVo);
	}

	public OwnerVo ownerstatecheck(OwnerVo owner) {
		return sql.selectOne("User.ownerchkstate", owner);
	}

	// 일반회원 비밀번호 변경시 정보가 맞는자 확인
	public UserVo userckmember(UserVo userVo) {
		return sql.selectOne("User.userckmember", userVo);
	}

	// 일반회원 비밀번호 변경을위한 정보 가져오기
	public UserVo userSearch(UserVo userVo2) {
		return sql.selectOne("User.userSerch", userVo2);
	}

	// 일반회원 비밀번호 변경
	public int modifypassword(UserVo userVo2) {
		return sql.update("User.usermodifypassword", userVo2);
	}

	// 기업회원 비밀번호 변경시 정보가 맞는자 확인
	public OwnerVo ownerckmember(OwnerVo owner) {
		return sql.selectOne("User.ownerckmember", owner);
	}

	// 기업회원 비밀번호 변경을위한 정보 가져오기
	public OwnerVo ownerSearch(OwnerVo owner) {
		return sql.selectOne("User.ownerSearch", owner);
	}

	// 기업회원 비밀번호 변경
	public int ownermodifypassword(OwnerVo owner) {
		return sql.update("User.ownermodifypassword", owner);
	}

	// 회원 관리 페이지 (user list)
	public List<UserVo> userList() {
		return sql.selectList("User.userList");
	}

	// 회원 관리 페이지 (owner list)
	public List<OwnerVo> ownerList( ) {
		return sql.selectList("Owner.ownerList");
	}

}
