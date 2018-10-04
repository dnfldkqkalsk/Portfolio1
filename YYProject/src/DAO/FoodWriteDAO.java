package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import VO.FoodWriteVO;

public class FoodWriteDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;

	public Connection getInstance() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/java/Orcl");
			return ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	// 값 넣어주기
	public void insert(FoodWriteVO vo, String bKind) {
		String sql = "insert into food_board(bNum, bName, bTel, bTime, bImg, bAdd1, bAdd2, bLocation, bKind, bMenu1_Img, bMenu2_Img, bMenu3_Img, bMenu1_Detail, bMenu2_Detail, bMenu3_Detail, bInfo, bHash, bStar) values(fb_seq.nextVal, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getbName());
			pstmt.setString(2, vo.getbTel());
			pstmt.setString(3, vo.getbTime());
			pstmt.setString(4, vo.getbImg());
			pstmt.setString(5, vo.getbAdd1());
			pstmt.setString(6, vo.getbAdd2());
			pstmt.setString(7, vo.getbLocation());
			pstmt.setString(8, bKind);
			pstmt.setString(9, vo.getbMenu1_Img());
			pstmt.setString(10, vo.getbMenu2_Img());
			pstmt.setString(11, vo.getbMenu3_Img());
			pstmt.setString(12, vo.getbMenu1_Detail());
			pstmt.setString(13, vo.getbMenu2_Detail());
			pstmt.setString(14, vo.getbMenu3_Detail());
			pstmt.setString(15, vo.getbInfo());
			pstmt.setString(16, vo.getbHash());
			pstmt.setInt(17, vo.getbStar());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 값 뿌려주기
	//지역클릭시
	public ArrayList<FoodWriteVO> getFoodList(String location) { // Seoul, Incheon......을 받아온다.

		ArrayList<FoodWriteVO> list = new ArrayList<FoodWriteVO>(); // list란 ArrayList객체를 생성한다.
		String sql = "SELECT * FROM food_board WHERE bAdd1 LIKE '%" + location + "%'";
		// food_board에서 bAdd1을 가져오고 그 bAdd1과 location값이 값으면 다 불러온다.
		// bAdd1이 addSeoul이면 location이 Seoul이니까 Seoul이 포함됐으므로 불러온다.

		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				FoodWriteVO vo = new FoodWriteVO();
				vo.setbNum(rs.getInt("bNum"));
				vo.setbName(rs.getString("bName"));
				vo.setbDate(rs.getTimestamp("bDate"));
				vo.setbTel(rs.getString("bTel"));
				vo.setbTime(rs.getString("bTime"));
				vo.setbImg(rs.getString("bImg"));
				vo.setbAdd1(rs.getString("bAdd1"));
				vo.setbAdd2(rs.getString("bAdd2"));
				vo.setbLocation(rs.getString("bLocation"));

				String temp = rs.getString("bKind");

				// 음식 종류 체크박스
				StringTokenizer tokens = new StringTokenizer(temp, "_");// _를 기준으로 자른다.
				String[] bKind = new String[tokens.countTokens()];

				int count = 0;

				while (tokens.hasMoreTokens()) {
					bKind[count++] = tokens.nextToken();
				}

				vo.setbKind(bKind);
				vo.setbMenu1_Img(rs.getString("bMenu1_Img"));
				vo.setbMenu2_Img(rs.getString("bMenu2_Img"));
				vo.setbMenu3_Img(rs.getString("bMenu3_Img"));
				vo.setbMenu1_Detail(rs.getString("bMenu1_Detail"));
				vo.setbMenu2_Detail(rs.getString("bMenu2_Detail"));
				vo.setbMenu3_Detail(rs.getString("bMenu3_Detail"));
				vo.setbInfo(rs.getString("bInfo").replace("\r\n", "<br/>"));
				vo.setbStar(rs.getInt("bStar"));
				
				//vo.setbHash(rs.getString("bHash"));
				String temp2 = rs.getString("bHash");
				//_를 제거해준다. 
				StringTokenizer temp3 = new StringTokenizer(temp2, "_"); //_를 기준으로 쪼갠다.
				//_를 공백으로 바꾼다. 
				 String bHash = temp3.nextToken();//쪼갠것의 맨 앞의것을 넣어준다. //배열의 0번째를 넣어주는것과 같음
				 
				 while(temp3.hasMoreElements()) { //몇개인지 알수있는 함수가 없어서 while문
					 bHash += " " + temp3.nextToken();
				 }
				 vo.setbHash(bHash);
				

				list.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return list;
	}

	
	// search결과를 위한 메소드
	public ArrayList<FoodWriteVO> getSearchList(String keyword, String type) {
		ArrayList<FoodWriteVO> list = new ArrayList<FoodWriteVO>();
		String sql = ""; // 변수는 밖에 선언하고

		// type
		// 이 안에서 초기화를 시켜준다.
		if (type.equals("tbName")) {
			sql = "SELECT * FROM food_board WHERE bName LIKE '%" + keyword + "%'";
			//%로 키워드를 감싸야 한다. %는 와일드카드라고 함
		} else if (type.equals("tbLocation")) {
			sql = "SELECT * FROM food_board WHERE bLocation LIKE '%" + keyword + "%'";
		} else if (type.equals("tbHash")) {
			sql = "SELECT * FROM food_board WHERE bHash LIKE '%" + keyword + "%'";
		}

		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				// 검색결과 전체를 불러와야 한다.
				FoodWriteVO vo = new FoodWriteVO();

				vo.setbNum(rs.getInt("bNum"));
				vo.setbName(rs.getString("bName"));
				vo.setbDate(rs.getTimestamp("bDate"));
				vo.setbTel(rs.getString("bTel"));
				vo.setbTime(rs.getString("bTime"));
				vo.setbImg(rs.getString("bImg"));
				vo.setbAdd1(rs.getString("bAdd1"));
				vo.setbAdd2(rs.getString("bAdd2"));
				vo.setbLocation(rs.getString("bLocation"));

				String temp = rs.getString("bKind");

				StringTokenizer tokens = new StringTokenizer(temp, "_");// _를 기준으로 자른다.
				String[] bKind = new String[tokens.countTokens()];

				int count = 0;

				while (tokens.hasMoreTokens()) {
					bKind[count++] = tokens.nextToken();
				}

				vo.setbKind(bKind);
				vo.setbMenu1_Img(rs.getString("bMenu1_Img"));
				vo.setbMenu2_Img(rs.getString("bMenu2_Img"));
				vo.setbMenu3_Img(rs.getString("bMenu3_Img"));
				vo.setbMenu1_Detail(rs.getString("bMenu1_Detail"));
				vo.setbMenu2_Detail(rs.getString("bMenu2_Detail"));
				vo.setbMenu3_Detail(rs.getString("bMenu3_Detail"));
				vo.setbInfo(rs.getString("bInfo"));
				vo.setbStar(rs.getInt("bStar"));
				
				
				//vo.setbHash(rs.getString("bHash"));
				String temp2 = rs.getString("bHash");
				//_를 제거해준다. 
				StringTokenizer temp3 = new StringTokenizer(temp2, "_"); //_를 기준으로 쪼갠다.
				//_를 공백으로 바꾼다. 
				 String bHash = temp3.nextToken();//쪼갠것의 맨 앞의것을 넣어준다. //배열의 0번째를 넣어주는것과 같음
				 
				 while(temp3.hasMoreElements()) { //몇개인지 알수있는 함수가 없어서 while문
					 bHash += " " + temp3.nextToken();
				 }
				 vo.setbHash(bHash);
				 
				 

				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 글 삭제
	public void boardDelete(String bNum) {

		String sql = "delete from food_board where bNum=?";
		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, bNum);

			pstmt.executeUpdate(); // select빼고는 다 update

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 비밀번호 변경하는 메소드의 id, email이 일치하는지 판별하는 메소드
	public int findChangeIdEmail(String id, String email) {
		String sql = "select * from member where id=? and email=?";
		//아이디와, 이메일을 가져온다.
		//아이디가 ?이고, 이메일이?인 행만 가져온다.

		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, email);

			rs = pstmt.executeQuery();
			//위의 두 개를 담는 것이다.

			if (rs.next()) {
				return 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	// mypage의 비밀번호 찾기 페이지의 비밀번호 변경 메소드와
	// mypage의 비밀번호 변경 페이지의 비밀번호 변경 메소드
	public int findChangePass(String password, String id) {

		String sql = "update member set password = ? where id=?";
		//비밀번호를 변경해야 하기 때문에 update를 사용한다.
		//id가 ?인 것의 password를 업데이트 해라
		//update, delete는 항상!!!! where절이 있어야 한다. 없으면 다 업뎃, 삭제 함
		
		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, password);
			pstmt.setString(2, id);

			return pstmt.executeUpdate();
			//pstmt는 원래 int형이다.

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	
	// 비밀번호 변경하는 메소드의 원래 비밀번호와 입력한 비밀번호가 같은지 판별하는 메소드
	public int changePass(String password, String id) {
		String sql = "select password from member where id=?";
		//아이디가 ?인 것의 비밀번호를 선택하여 읽는다.

		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			// 조회해서 값이 있으면 (그 유저가 테이블에 있으면(그비밀번호)일치하면 return 1
			//없다면 아예 rs.next()가 일어나지 않는다.
			if (rs.next()) {
				if (rs.getString(1).equals(password)) {
					// password는 사용자가 페이지에서 입력한 값
					return 1;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	//해당 사용자를 id기준으로 선택해서 지운다.
	public int deleteMember(String userId) {
		String sql = "DELETE FROM member where id = ?";
		
		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 1;
	}
	
	
	//글 수정 폼
	public FoodWriteVO boardUpdateForm(String bNum) {
		//vo에 담긴 것들을 받아와야 하니까 자료형은 vo이다.
		FoodWriteVO vo = new FoodWriteVO(); //vo에서 값을 가져와야 하니까 객체생성한다. 
		String sql = "select * from food_board where bNum=?";
		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bNum); //위에 String값으로 가져온 bNum을 말gksek. 
			rs = pstmt.executeQuery(); //select문이니까 query를 사용한다.
			
			while(rs.next()) {
				//처음엔 빈곳을 가리키고 있기 때문에 rs로 조회했으면 무조건 rs.next()로 호출해야 한다.ㅏ
				//rs로 불러온 값들을 vo에 셋팅해준다. -> 글 수정에 필요한 값들만 가져온다.
				
				//그래서 vo객체를 생성해 준 것이다.
				vo.setbNum(rs.getInt("bNum"));
				vo.setbName(rs.getString("bName"));
				vo.setbTel(rs.getString("bTel"));
				vo.setbTime(rs.getString("bTime"));
				vo.setbAdd1(rs.getString("bAdd1"));
				vo.setbAdd2(rs.getString("bAdd2"));
				vo.setbLocation(rs.getString("bLocation"));
				
				String temp = rs.getString("bKind"); //메뉴는 잘라야 하기 때문에 tokenizer를 사용한다.
				
				StringTokenizer tokens = new StringTokenizer(temp, "_"); //_가 기준으로 잘린다.
				String[] bKind = new String[tokens.countTokens()]; 
				
				int count = 0;
				
				while(tokens.hasMoreTokens()) { //다음것이 있다면
					bKind[count++] = tokens.nextToken(); //count를 1씩 더해라
				}
				
				vo.setbKind(bKind);
	            vo.setbMenu1_Img(rs.getString("bMenu1_Img"));
	            vo.setbMenu2_Img(rs.getString("bMenu2_Img"));
	            vo.setbMenu3_Img(rs.getString("bMenu3_Img"));
	            vo.setbMenu1_Detail(rs.getString("bMenu1_Detail"));
	            vo.setbMenu2_Detail(rs.getString("bMenu2_Detail"));
	            vo.setbMenu3_Detail(rs.getString("bMenu3_Detail"));
	            vo.setbInfo(rs.getString("bInfo"));
	            vo.setbHash(rs.getString("bHash"));
	            vo.setbStar(rs.getInt("bStar"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo; //vo자체를 한번에 return해준다.
	}
	
	
	
	
	//글 수정하고 업데이트 하는 메소드 ==insert
	public void boardUpdate(FoodWriteVO vo, String bKind) {
		
		String sql = "update food_board set bName=?, bTel=?, bTime=?, bImg=?, bAdd1=?, bAdd2=?, bLocation=?, bKind=?, bMenu1_Img=?, bMenu2_Img=?, bMenu3_Img=?, bMenu1_Detail=?, bMenu2_Detail=?, bMenu3_Detail=?, bInfo=?, bHash=?, bStar=? where bNum = ?";
		
		 try{
		        conn = getInstance();
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, vo.getbName());
		        pstmt.setString(2, vo.getbTel());
		        pstmt.setString(3, vo.getbTime());
		        pstmt.setString(4, vo.getbImg());
		        pstmt.setString(5, vo.getbAdd1());
		        pstmt.setString(6, vo.getbAdd2());
		        pstmt.setString(7, vo.getbLocation());
		        pstmt.setString(8, bKind);
		        pstmt.setString(9, vo.getbMenu1_Img());
		        pstmt.setString(10, vo.getbMenu2_Img());
		        pstmt.setString(11, vo.getbMenu3_Img());
		        pstmt.setString(12, vo.getbMenu1_Detail());
		        pstmt.setString(13, vo.getbMenu2_Detail());
		        pstmt.setString(14, vo.getbMenu3_Detail());
		        pstmt.setString(15, vo.getbInfo());
		        pstmt.setString(16, vo.getbHash());
		        pstmt.setInt(17, vo.getbStar());
		        pstmt.setInt(18, vo.getbNum());

		        pstmt.executeUpdate();
		    } catch(Exception e) { 
		        e.printStackTrace();
		    }
		
	}
	
	
	
	
	/* close */
	public void finally_close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
