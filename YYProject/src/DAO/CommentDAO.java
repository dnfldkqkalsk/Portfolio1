package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import VO.CommentVO;
import VO.FoodWriteVO;

public class CommentDAO {

	// 댓글 관리를 위한 dao
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
			// TODO: handle exception
			e.printStackTrace();
		}
		return conn;

	}

	
	
	
	//댓글 넣어주기
	public void commentInsert(CommentVO vo) {
		
		String sql = "insert into y_comment(cNum, cId, cContent, cStar, cReg_flag) values(yc_seq.nextVal, ?, ?, ?, ?)";
		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getcId());
			pstmt.setString(2, vo.getcContent());
			pstmt.setInt(3, vo.getcStar());
			pstmt.setInt(4, vo.getcReg_flag());
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public ArrayList<CommentVO> getCommentList() {
		ArrayList<CommentVO> commentList = new ArrayList<CommentVO>();
		
		String sql1 = "select bNum from food_board order by bNum desc"; //각 맛집리스트의 게시글 번호
		String sql2 = "select * from y_comment where cReg_flag=?";
		
		try {
				
			conn = getInstance();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			
			ArrayList<Integer> bNums = new ArrayList<Integer>(); //게시글이 여러개(글번호)니까 배열에 담아준다.
			
			
			//부모게시글 번호
			while(rs.next()) { //게시글이 있다면 그 안에서 게시글번호만 가져온다. 
				//안에 rs에 값을 넣어주면 안된다. 
				bNums.add(rs.getInt("bNum"));
				//bNums에 담긴 값으로 댓글을 불러온다. (해당 게시글의 댓글)
			}
			
			for(int i=0; i<bNums.size(); i++) {
				pstmt = conn.prepareStatement(sql2);
				
				pstmt.setInt(1, bNums.get(i)); //첫번째에 담긴 게시글의 번호를 담아온다. 
				//그럼 sql2엔 i번째의 게시글의 정보가 들어간다. 
				
				rs = pstmt.executeQuery();
				
				//해당 게시글의 달린 댓글들을 불러옴
				while(rs.next()) {
					CommentVO vo = new CommentVO();
					vo.setcNum(rs.getInt("cNum"));
					vo.setcId(rs.getString("cId"));
					vo.setcContent(rs.getString("cContent"));
					vo.setcStar(rs.getInt("cStar"));
					vo.setcReg_date(rs.getString("cReg_date"));
					vo.setcReg_flag(rs.getInt("cReg_flag"));
					
					commentList.add(vo);
					
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return commentList;
	}
	
	
	
	/*사용자 댓글 평점*/
	public ArrayList<FoodWriteVO> getScore(ArrayList<FoodWriteVO> list) {
		String sql = "select cStar from y_comment where cReg_flag=?";
		
		
		//원래 가져온 값에 cStar만 추가하는 것이기 때문에 어레이리스트객체 생성을 안해준다.
		try {
			conn = getInstance();
			
			for(int i=0; i<list.size(); i++) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, list.get(i).getbNum()); //bNum은 foodWrite vo
					
				rs = pstmt.executeQuery();
				
				int total = 0;
				int count = 0;
				
				
				while(rs.next()) {
				
					total += rs.getInt("cStar"); //총합
					count++;
					//이게 한번돌았다는건 댓글이 한개있다는 것
				}
				if(count>0) {
					list.get(i).setcStar(total/count);
				}else {
					list.get(i).setcStar(0);
				}
			}
				
			
			
		} catch (Exception e) {
			// TODO: handleee exception
			e.printStackTrace();
		}
		
		return list; 
	}


	
	//댓글 삭제
	public void commentDelete(int cNum) {
		String sql = "delete from y_comment where cNum=?";
		
		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cNum);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	// y_comment 테이블의 cNum으로 데이터 한 개 가져오기
	
	public ArrayList<CommentVO> getNum(int cNum) {

		CommentVO vo = new CommentVO();
		ArrayList<CommentVO> list = new ArrayList<CommentVO>(); 
		String sql = "select * from y_comment where cNum=?"; // cNum을 기준으로 가져온다.

		try {
			conn = getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cNum);

			rs = pstmt.executeQuery();
			rs.next(); // 하나이므로 if문이나 while문에 넣어줄 필요가 없다.

			vo.setcNum(rs.getInt("cNum"));
			vo.setcId(rs.getString("cId"));
			vo.setcContent(rs.getString("cContent"));
			vo.setcReg_date(rs.getString("cReg_date"));
			vo.setcStar(rs.getInt("cStar"));
			vo.setcReg_flag(rs.getInt("cReg_flag"));
			
			list.add(vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
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
