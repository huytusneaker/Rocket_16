package testting_system1;

import java.util.Date;

public class Group {
	Byte		groupID;
	String		groupName;
	Account		creatorID;
	Date		createDate;
	public Group(Byte groupID, String groupName, Account creatorID, Date createDate) {
		super();
		this.groupID = groupID;
		this.groupName = groupName;
		this.creatorID = creatorID;
		this.createDate = createDate;
	}
	public Group() {
		super();
	}
	
	
	
	
}
