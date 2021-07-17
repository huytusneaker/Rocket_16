package testting_system1;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Main {

	public static void main(String[] args) {
		Date a = new Date();
		System.out.println("Định dạng gốc của eclipse: "+a);
		
		
//		 format 
		DateFormat dateformat = new  SimpleDateFormat("yyyy/MM/dd");
		System.out.println("Định dạng sau khi làm lại: "+ dateformat.format(a));
		
		Department dp	= new Department(1, "Dev");
		Department dp1	= new Department(2, "Sale");
		Department dp2	= new Department(3, "Marketing");
		
		Position	po	= new Position((byte) 1,	"Coder");
		Position	po1	= new Position((byte) 2,	"Saler");
		Position	po2	= new Position((byte) 3,	"Markerter");
		
		Account		ac = new	Account((byte) 1 , "tu12345@gmail.com", "tu12345", dp2, po2,new Date ("2021/06/16"));
		Account		ac1 = new Account((byte) 1, "tung@gmail.com", "tung12345", dp, po2,	new Date("2020/06/16"));
		Account		ac2 = new Account((byte) 2, "tuan@gmail.com", "tuan12345", dp1, po,	new Date("2019/06/16"));
		
		TypeQuestion	tp = new TypeQuestion((byte) 1, "Trắc nghiệm");
		TypeQuestion	tp1 = new TypeQuestion((byte) 2, "Tự luận");
		TypeQuestion	tp2 = new TypeQuestion((byte) 3, "Trắc nghiệm nhiều đáp án");
		
		CategoryQuestion	caq	= new CategoryQuestion((byte) 1	, "Loại 1");
		CategoryQuestion	caq1	= new CategoryQuestion((byte) 2	, "Loại 2");
		CategoryQuestion	caq2	= new CategoryQuestion((byte) 3	, "Loại 3");
		
		Question	qu1	 = new Question((byte) 1, "Câu hỏi 1", caq, tp1, ac2, new Date("2021/06/16"));
		Question	qu2	 = new Question((byte) 2, "Câu hỏi 2", caq1, tp2, ac, new Date("2021/06/16"));
		Question	qu3	 = new Question((byte) 3, "Câu hỏi 3", caq2, tp, ac1, new Date("2021/06/16"));
		
		Group		gr	= new Group((byte) 1 , "Group1", ac2, new Date("2019/06/16"));
		Group		gr1	= new Group((byte) 2 , "Group3", ac, new Date("2019/06/16"));
		Group		gr2	= new Group((byte) 3 , "Group2", ac1, new Date("2019/06/16"));
		
		GroupAccount	grac= new GroupAccount(gr2,new Account [] {ac,ac2},new Date("2019/06/16"));
		GroupAccount	grac1= new GroupAccount(gr2,new Account [] {ac1,ac2},new Date("2019/06/16"));
		GroupAccount	grac2= new GroupAccount(gr2,new Account [] {ac,ac1},new Date("2019/06/16"));

		Exam		ex = new Exam((byte)1, "1001", "Kiểm tra java",(byte)1	, 90, ac2, new Date("2019/06/16"));
		Exam		ex1 = new Exam((byte)2, "10012", "Kiểm tra sql",(byte)21	, 120, ac1, new Date("2019/06/16"));
		Exam		ex2 = new Exam((byte)3, "10013", "Kiểm tra html",(byte)31	, 90, ac2, new Date("2019/06/16"));

		ExamQuestion exq = new ExamQuestion(ex, new Question [] {qu1,qu2});
		ExamQuestion exq1 = new ExamQuestion(ex1, new Question [] {qu1,qu3});
		ExamQuestion exq2 = new ExamQuestion(ex2, new Question [] {qu3,qu2});

		Answer		ans	 = new Answer((byte) 1, "câu trả lời 1", qu3, false);
		Answer		ans1	 = new Answer((byte) 2, "câu trả lời 2", qu1, true);
		Answer		ans2	 = new Answer((byte) 3, "câu trả lời 3", qu2, false);


		
		
	}

}
