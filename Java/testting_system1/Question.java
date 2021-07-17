package testting_system1;

import java.util.Date;

public class Question {
	Byte				questionID;
	String				content;
	CategoryQuestion	categoryID;
	TypeQuestion		typeID;
	Account				creatorID;
	Date				createDate;
	public Question(Byte questionID, String content, CategoryQuestion categoryID, TypeQuestion typeID,
			Account creatorID, Date createDate) {
		super();
		this.questionID = questionID;
		this.content = content;
		this.categoryID = categoryID;
		this.typeID = typeID;
		this.creatorID = creatorID;
		this.createDate = createDate;
	}
	public Question() {
		super();
	}
	
	
	
	
}
