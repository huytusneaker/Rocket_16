package testting_system1;

import java.util.Date;

public class Exam {
	Byte		examID;
	String		code;
	String		title;
	Byte		categoryID;
	int			duration;
	Account		CreatorID;
	Date		CreateDate;
	public Exam(Byte examID, String code, String title, Byte categoryID, int duration, Account creatorID,
			Date createDate) {
		super();
		this.examID = examID;
		this.code = code;
		this.title = title;
		this.categoryID = categoryID;
		this.duration = duration;
		CreatorID = creatorID;
		CreateDate = createDate;
	}
	public Exam() {
		super();
	}
	
	
	
	
}
