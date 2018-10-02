package Action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.UserDAO;
import VO.UserVO;

public class LoginAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String id = request.getParameter("id");
		String password = request.getParameter("password");

		// 변수들을 넣어주어야 한다.
		UserVO vo = new UserVO();
		vo.setId(id);
		vo.setPassword(password);

		UserDAO dao = new UserDAO();

		// 사용자가 있나 없나 확인하기 위해 boolean을 한다.
		boolean isLogin = dao.login(id, password);// dao에 id, password를 넘겨준다.

		HttpSession session = request.getSession();
		// 세션준비

		if (isLogin == true) {
			// 여기에 사용한 sessionID를 사용하는 곳은 게시글을 작성할 때 사용한다.
			// writer에서 사용한다. -> 작성자
			// 글 작성 시 작성자이름은 자동으로 넘어가게 (input type="hidden")
			session.setAttribute("sessionID", id);// 로그인한 id로 sessionID를 유지한다.
			dao.finally_close();
			
			// 쓰고싶은것만 넘겨준다.
			response.sendRedirect("/YYProject/main-food.jsp");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 존재하지 않거나 비밀번호가 일치하지 않습니다.')");
			script.println("location.href='main-food.jsp'");
			script.println("</script>");
		}

	}

}
