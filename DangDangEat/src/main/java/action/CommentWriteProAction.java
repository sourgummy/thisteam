package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import svc.CommentWriteProService;
import vo.ActionForward;
import vo.CommentBean;

public class CommentWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("CommentWriteProAction");
		
		ActionForward forward = null;		

	try {
		    
		    CommentBean comment = new CommentBean();
		    comment.setReview_code(Integer.parseInt(request.getParameter("review_code")));
		    comment.setMember_id(request.getParameter("member_id"));
		    comment.setComment_content(request.getParameter("comment_content"));
	   		
	        CommentWriteProService service = new CommentWriteProService();
	        boolean isWriteSuccess = service.registComment(comment);
				
	        request.setAttribute("comment", comment);
	
	        if(!isWriteSuccess) {		
		
            response.setContentType("text/html; charset=UTF-8");
		
	     	PrintWriter out = response.getWriter();
		
	    	out.println("<script>");
		   out.println("alert('글쓰기 실패!')");
		   out.println("history.back()");
		   out.println("</script>");
	       } else {
	    	 response.sendRedirect("ReviewDetail.bo?review_code=" + comment.getReview_code() + "&pageNum=" + request.getParameter("pageNum"));		
	       }
	} catch (IOException e) {
		e.printStackTrace();
	}
		
		return forward; 
	}

}