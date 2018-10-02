package Action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.FoodWriteDAO;
import VO.FoodWriteVO;

public class BoardUpdateForm implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		// vo에 저장된 해당 bNum의 게시물을 가져와서 food-write.jsp에 띄워준다.
		String bNum = request.getParameter("bNum");

		FoodWriteDAO dao = new FoodWriteDAO();
		FoodWriteVO vo = dao.boardUpdateForm(bNum);
	
		request.setAttribute("list", vo); //request안에 vo를 담는다. 
		
		RequestDispatcher rd = request.getRequestDispatcher("food-update.jsp");
		rd.forward(request, response);// request에 세팅된 값을 rd로 보냄
		// sendRedirect() : 내가 가져갈 정보가 없을 때 사용
		 // requestDispatcher() : 내가 가져갈 정보가 있을 때 사용(글을 볼 때, 글을 띄울 때)
		
		
	}
}
