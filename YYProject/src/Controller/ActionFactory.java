package Controller;

import Action.Action;
import Action.BoardDelete;
import Action.BoardUpdateForm;
import Action.ChangePass;
import Action.ChangePassCheck;
import Action.CheckIdAction;
import Action.CommentDelete;
import Action.CommentWriteAction;
import Action.DeletePassCheck;
import Action.FindChangeIdEmail;
import Action.FindChangePass;
import Action.FoodListAction;
import Action.JoinAction;
import Action.LoginAction;
import Action.LogoutAction;
import Action.SearchAction;

public class ActionFactory {

	public Action getAction(String actionName) {
		Action action = null;

		if (actionName.equals("userLogin")) { // 로그인
			action = new LoginAction();
		} else if (actionName.equals("userJoin")) { // 회원가입
			action = new JoinAction();
		} else if (actionName.equals("checkId")) { // 아이디 중복확인
			action = new CheckIdAction();
		} else if (actionName.equals("userLogout")) { // 로그아웃
			action = new LogoutAction();
		
		} else if (actionName.equals("list")) { // 글 (있을때)뽑기
			action = new FoodListAction();
		} else if (actionName.equals("search")) { // 검색
			action = new SearchAction();

			
			
		} else if (actionName.equals("boardUpdateForm")) { // 글 수정페이지를 띄우는 form
			action = new BoardUpdateForm();
		
		} else if (actionName.equals("boardDelete")) {
			action = new BoardDelete();

			
			
			
			
			
		} else if (actionName.equals("findChangeIdEmail")) { // mypage 비번찾기에서 아이디랑 이메일이 같은지
			action = new FindChangeIdEmail();

		} else if (actionName.equals("findChangePass")) { // mypage 비번찾기에서 두 비번이 같은지
			action = new FindChangePass();

		} else if (actionName.equals("changePass")) { // mypage 비번변경에서 원래비번과 입력한 비번이 같은지
			action = new ChangePass();
		} else if (actionName.equals("changePassCheck")) { // mypage 비번변경에서 이제 새 비밀번호를 변경하는 메소드
			action = new ChangePassCheck();
		} else if (actionName.equals("deletePassCheck")) { //mypage 회원탈퇴
			action = new DeletePassCheck();
			
		} else if (actionName.equals("commentWrite")) { //댓글 작성
			action = new CommentWriteAction();
		} else if (actionName.equals("commentDelete")) { //댓글 삭제
				action = new CommentDelete();
			
			
			
			
		} else {
			action = new FoodListAction(); // 글이 없을때도 창 자체를 띄워준다.
		}

		return action;
	}
}
