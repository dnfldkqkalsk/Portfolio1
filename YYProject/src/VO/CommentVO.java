package VO;

import java.sql.Timestamp;

public class CommentVO {

	private int cNum;
	private int cReg_flag;
	private String cReg_date;
	private String cId;
	private String cContent;
	private int cStar;
	
	
	
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	
	public int getcReg_flag() {
		return cReg_flag;
	}
	public void setcReg_flag(int cReg_flag) {
		this.cReg_flag = cReg_flag;
	}
	public String getcReg_date() {
		return cReg_date;
	}
	public void setcReg_date(String cReg_date) {
		this.cReg_date = cReg_date;
	}
	public String getcId() {
		return cId;
	}
	public void setcId(String cId) {
		this.cId = cId;
	}
	public String getcContent() {
		return cContent;
	}
	public void setcContent(String cContent) {
		this.cContent = cContent;
	}
	public int getcStar() {
		return cStar;
	}
	public void setcStar(int cStar) {
		this.cStar = cStar;
	}
	
	
	
	
}
