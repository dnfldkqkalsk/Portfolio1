package Action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.FoodWriteDAO;
import VO.FoodWriteVO;

public class SearchAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		request.setCharacterEncoding("utf-8");
		String keyword = request.getParameter("k");
		String type = request.getParameter("t"); // select

		ArrayList<FoodWriteVO> list = new ArrayList<FoodWriteVO>();
		FoodWriteDAO dao = new FoodWriteDAO();

		list = dao.getSearchList(keyword, type);
		Collections.shuffle(list); //검색을 랜덤으로 띄우기

		request.setAttribute("list", list);
		//가게명으로 검색했을 시
		if(type.equals("tbName")) {
			request.setAttribute("store", keyword); 
		}else {
			request.setAttribute("keyword", keyword); //타이틀에 표시하기 위해서
		}
		// 넘긴다.
		dao.finally_close();
		
		RequestDispatcher rd = request.getRequestDispatcher("location-food.jsp");
		// 검색 목록을 띄우려면 location-food.jsp로 가야함
		rd.forward(request, response);

	}

}
