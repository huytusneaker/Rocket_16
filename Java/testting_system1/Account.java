package testting_system1;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Account {
	Byte		accountID;
	String		email;
	String		userName;
	Department  departmentID;
	Position	positionID;
	Date		createDate;
	public Account(Byte accountID, String email, String userName, Department departmentID, Position positionID,
			Date createDate) {
		
		this.accountID = accountID;
		this.email = email;
		this.userName = userName;
		this.departmentID = departmentID;
		this.positionID = positionID;
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		DateFormat dateformat = new  SimpleDateFormat("yyyy/MM/dd");
		return "Account [accountID=" + accountID + ", email=" + email + ", userName=" + userName + ", departmentID="
				+ departmentID.DepartmentName + ", positionID=" + positionID.positionName+ ", createDate=" + dateformat.format(createDate) + "]";
	}
	
	
	
	
}
