package Action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserDAO;
import VO.UserVO;

public class JoinAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		// 실질적인 로직 처리
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		// 아래의 script태그 안에 있는 한글을 위해 인코딩을 해주는 것이다.

		// 사용자가 입력한 값을 가져온다. -> main-cafe에 있는 join에 작성한 값
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String email = request.getParameter("email");

		// 위에 선언한 변수들을 넣어준다.
		UserVO vo = new UserVO();
		vo.setName(name);
		vo.setId(id);
		vo.setPassword(password);
		vo.setEmail(email);

		// db와 연결한다.
		int result = new UserDAO().join(vo);

		UserDAO dao = new UserDAO();
		dao.finally_close();
		
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입을 축하합니다.')");
			script.println("location.href='main-food.jsp'");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입에 실패했습니다.')");
			script.println("location.href='main-food.jsp'");
			script.println("</script>");
		}

	}

}
