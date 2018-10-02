package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import VO.UserVO;

public class UserDAO {

	// 회원관리를 위한 dao
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "java";
	private String pass = "java";

	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pass);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 아이디 중복체크
	public int checkId(String inputId) {

		String sql = "select * from member where id=?"; // 해당한 id가 있으면
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, inputId);

			rs = pstmt.executeQuery();

			// if문으로 들어오면 id가 중복된다는 뜻이다.
			// (다음이 있다면 안되는것이니까)
			if (rs.next()) {
				return 0; // 중복값이 있으면 0을준다.
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return 1; // 중복값이 없다는 뜻
	}

	// 회원가입
	public int join(UserVO vo) {

		String sql = "insert into member(name, id, password, email) values (?, ?, ?, ?)";
		int result = 0;

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getPassword());
			pstmt.setString(4, vo.getEmail());

			result = pstmt.executeUpdate();
			// 행이 있을경우 1이 들어감(4열)

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result; // 0이 들어가면 회원가입이 실패했습니다가 된다.
	}

	// 등록시간
	public String getDate() {
		String sql = "select sysdate from dual";

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			rs.next();
			return rs.getString(1).substring(0, 10);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 로그인
	public boolean login(String id, String password) {

		boolean isLogin = false;// 기본은 false이다.

		String sql = "select password from member where id=?";
		// 받아온 id와 password가 같은지 확인한다.

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// table에 있는 회원들의 정보들을 하나씩 검사하며 일치하는 것을 찾아본다.
				if (rs.getString(1).equals(password)) {// getString(1)은 ?인 id를 뜻한다.
					isLogin = true; // true로 바꾼다. -> 로그인 성공
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isLogin;
	}
	
	
	/*close*/
	public void finally_close(){
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
