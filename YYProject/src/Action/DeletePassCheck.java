package Action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.FoodWriteDAO;

public class DeletePassCheck implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		response.setContentType("text/html; charset=utf-8");
		
		//세션에 있는 아이디를 가져와야 한다. 그래서 그 사용자의 세션id와 비밀번호를 비교한다.
		String id = (String)request.getSession().getAttribute("sessionID");
		String password = request.getParameter("password");
		
		FoodWriteDAO dao = new FoodWriteDAO();
		
		int result= dao.changePass(password, id);
		
		if(result == 1) {
			dao.deleteMember(id);
			request.getSession().invalidate(); // 모두 지우기
			// request.getSession().removeAttribute("sessionID"); 하나만 지우기
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴되었습니다.')");
			script.println("location.href='main-food.jsp'");
			script.println("</script>");
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('사용자의 비밀번호가 일치하지 않습니다.')");
			script.println("location.href='mypage.jsp'");
			script.println("</script>");
		}
		
		
		
	}

}
