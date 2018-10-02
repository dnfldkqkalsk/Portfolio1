package Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DAO.FoodWriteDAO;
import VO.FoodWriteVO;

/**
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("UTF-8");
		String directory = request.getRealPath("/upload");
		int size = 1024 * 1024 * 100;
		String enc = "UTF-8";

		try {
			MultipartRequest multi = new MultipartRequest(request, directory, size, enc, new DefaultFileRenamePolicy());
		    // 파일 업로드해주는 함수. (순서 중요)
		    // DefaultFileRenamePolicy() : a.jpg, a(1).jpg, a(2).jpg
			Enumeration fileNames = multi.getFileNames();
			 // 파일이 한 개 이상일 때 차곡차곡 넣음

			FoodWriteVO vo = new FoodWriteVO();
			
			//bNum가져오는것만 다르다
			vo.setbNum(Integer.parseInt(multi.getParameter("bNum")));
			
			vo.setbName(multi.getParameter("bName"));
			vo.setbTel(multi.getParameter("bTel"));
			vo.setbTime(multi.getParameter("bTime"));
			vo.setbAdd1(multi.getParameter("bAdd1"));
			vo.setbAdd2(multi.getParameter("bAdd2"));
			vo.setbLocation(multi.getParameter("bLocation"));

			String[] temp = multi.getParameterValues("bKind");

			String bKind = temp[0];

			for (int i = 1; i < temp.length; i++) {
				bKind += "_" + temp[i];
			}

			vo.setbMenu1_Detail(multi.getParameter("bMenu1-Detail"));
			vo.setbMenu2_Detail(multi.getParameter("bMenu2-Detail"));
			vo.setbMenu3_Detail(multi.getParameter("bMenu3-Detail"));
			vo.setbInfo(multi.getParameter("bInfo"));
			vo.setbHash(multi.getParameter("bHash"));
			vo.setbStar(Integer.parseInt(multi.getParameter("bStar")));

			String[] uploadFiles = new String[4];
		    // 전체 업로드할 파일이 4개
			int count = 0;

			while (fileNames.hasMoreElements()) { // ==rs.next()
				String file = (String) fileNames.nextElement();
				String fileName = multi.getOriginalFileName(file);
				uploadFiles[count++] = multi.getFilesystemName(file);

				if (!fileName.endsWith(".jpg") && !fileName.endsWith(".png") && !fileName.endsWith(".jpeg")
						&& !fileName.endsWith(".gif")) {
					File upFile = new File(directory + multi.getFilesystemName(file));
					  // 올린 파일을 찾아서 객체에 담아서
					upFile.delete();
					  // 삭제
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('업로드할 수 없는 확장자 입니다.')");
					script.println("history.back()");
					 // 뒤로가기
					script.println("</script>");
				}
			}

			vo.setbImg(uploadFiles[0]);
			vo.setbMenu1_Img(uploadFiles[1]);
			vo.setbMenu2_Img(uploadFiles[2]);
			vo.setbMenu3_Img(uploadFiles[3]);

			FoodWriteDAO dao = new FoodWriteDAO();
			dao.boardUpdate(vo, bKind);

			//l은 여기서 변수명을 지어준것이다. 여기서 foodListAction으로 간다.
			//매핑값은 상관이 없다. 왜냐하면 어떤서블릿으로 들어가든 하나의 actionFactory로 이동하기 때문이다. 
			response.sendRedirect("/YYProject/user?actionName=list&l="+URLEncoder.encode(vo.getbAdd1(), "UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
