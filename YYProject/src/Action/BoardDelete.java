package Action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.FoodWriteDAO;

public class BoardDelete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		
		String bNum = request.getParameter("bNum");
		//삭제한 그 지역의 페이지로 넘어와야 하니까 l이 필요하다(지역을 받아와야 한다.)
		String location =  request.getParameter("l"); //l을 받아온 것을 사용한다. 
		//(location-food.jsp의  삭제버튼의 a태그에 걸려있는  title을 뜻한다.)
		
		System.out.println("delete : "+location);
		
		FoodWriteDAO dao = new FoodWriteDAO();
		
		dao.boardDelete(bNum);
		
		response.sendRedirect("/YYProject/user?actionName=list&l="+URLEncoder.encode(location, "UTF-8"));
		//한글처리
		
		
	}

}
