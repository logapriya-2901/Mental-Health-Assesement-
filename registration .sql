package com.mental;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Registration
 */
@WebServlet("/Registration")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("sid");
		String uname=request.getParameter("name");
			String email=request.getParameter("email");
			String gender=request.getParameter("gender");
			String job=request.getParameter("profession");
			String age=request.getParameter("age");
			String school=request.getParameter("school");
			String city=request.getParameter("city");

			HttpSession session=request.getSession();
			RequestDispatcher dispatcher=null;
			Connection con=null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mental?useSSL=false","root","priya@6265088");
				PreparedStatement pst=con.prepareStatement("insert into login(id,unmae,email,gender,profession,age,school,city) values(?,?,?,?,?,?,?,?)");
				pst.setString(1,id);
				pst.setString(2,uname);
				pst.setString(3,email);
				pst.setString(4,gender);
				pst.setString(5,job);
				pst.setString(6,age);
				pst.setString(7,school);
				pst.setString(8,city);
				
				session.setAttribute("name",uname);
				session.setAttribute("id",id);
				session.setAttribute("school",school);

				int rowCount=pst.executeUpdate();
				if(job.equals("student"))
				dispatcher=request.getRequestDispatcher("student.jsp");
				else
					dispatcher=request.getRequestDispatcher("employee.jsp");

				if(rowCount>0) {
					request.setAttribute("status", "success");
					
				}
				else {
					request.setAttribute("status", "failed");
					
				}
				dispatcher.forward(request, response);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			}

	
	

}
