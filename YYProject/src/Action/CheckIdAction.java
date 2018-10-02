package Action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserDAO;

public class CheckIdAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// 아이디 중복확인
		request.setCharacterEncoding("utf-8");
		String inputId = request.getParameter("id");
		
		int result = 0;
		
		UserDAO dao = new UserDAO();
		
		result = dao.checkId(inputId); // id가 담겨있는 inputId를 매개변수로 받아서 userDao로 넘겨준다.
		
		dao.finally_close();
		
		
		if(inputId.equals("")) {
			result = -1;
			response.getWriter().println(result);
			//이걸 한다고 페이지가 넘어가는게 아니다. 일단 여기있는 코드를 다 실행한 후에 넘어간다. 
		}else {
			response.getWriter().println(result);
			// getWriter : jsp페이지로 result값을 가져가야 하므로 필요하다.
			// jsp페이지로 이동하기위해 필요
		}

	}

}
