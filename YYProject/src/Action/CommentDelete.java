package Action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CommentDAO;

public class CommentDelete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String location = request.getParameter("l");		
		int cNum = Integer.parseInt(request.getParameter("c"));
		
		CommentDAO dao = new CommentDAO();
		
		dao.commentDelete(cNum);
		
		
		response.sendRedirect("/YYProject/user?actionName=list&l="+URLEncoder.encode(location, "UTF-8"));
	}

}
