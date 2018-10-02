package Action;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.FoodWriteDAO;
import VO.FoodWriteVO;

public class CafeListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");

		String location = URLDecoder.decode(request.getParameter("c"), "UTF-8");// l에 담겨진 값을 가져온다. -> Seoul, Incheon...
		//uploadServlet에서 넘어온 값을 받아온다. (l)

		FoodWriteDAO dao = new FoodWriteDAO();// 객체생성
		ArrayList<FoodWriteVO> list = dao.getFoodList(location);

		/* location-food.jsp의 title */
		String locationTitle = "";


		// 해당 location에 들어있던 값을 가져와 뿌려준다.
		request.setAttribute("list", list);
		request.setAttribute("title", location);

		dao.finally_close();
		
		// 가져온 값이 있기 때문에 dispacher를 쓴다.
		RequestDispatcher rd = request.getRequestDispatcher("location-cafe.jsp");// location.jsp에 뿌려줘야 한다.
		rd.forward(request, response);
	}

}
