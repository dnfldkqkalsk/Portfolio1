package Action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.FoodWriteDAO;

public class FindChangeIdEmail implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String id = request.getParameter("id");
		//세션에 저장된 아이디 말고 입력한 아이디이기 때문에 getParameter로 받아온다
		String email = request.getParameter("email");
		
		FoodWriteDAO dao = new FoodWriteDAO();
		
		int result = dao.findChangeIdEmail(id, email);
		
		dao.finally_close();
		
		if(result==1) { //성공
			request.getSession().setAttribute("sessionID", id);
			//findChangePass에서 사용해야하기 때문에 요청한다.
			//위에 친 id를 sessionID로 받는다.
		}
		
		response.getWriter().println(result);
	}
}
