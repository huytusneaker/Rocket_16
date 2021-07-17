package testting_system1;

public class Answer {
	Byte		AnswerID;
	String		Content;
	Question	questionID;
	boolean		isCorrect;
	public Answer() {
		super();
	}
	public Answer(Byte answerID, String content, Question questionID, boolean isCorrect) {
		super();
		AnswerID = answerID;
		Content = content;
		this.questionID = questionID;
		this.isCorrect = isCorrect;
	}
	
	
	
}
