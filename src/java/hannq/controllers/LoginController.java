package hannq.controllers;

import hannq.blos.MemberBLO;
import hannq.entities.Member;
import hannq.entities.MemberErrObj;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Han Quang
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String SEARCH = "SearchController";
    private static final String INVALID = "login.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVALID;
        try {
            String memberID = request.getParameter("txtEmail");
            String memberPassword = request.getParameter("txtPassword");
            MemberErrObj errObj = new MemberErrObj();
            boolean valid = true;
            if (!memberID.matches("([a-zA-Z0-9.]{3,20})@([a-zA-Z]{3,10})([.])([a-zA-Z]{1,10})([.][a-zA-Z]{1,10})?")) {
                if (!memberID.equals("admin")) {
                    valid = false;
                    errObj.setIdErr("Invalid Email format(abc@xyz.xyz)");
                }
            }
            if (!memberPassword.matches("[\\S]{6,20}")) {
                valid = false;
                errObj.setPwErr("Password must not contains blank and in range [6, 20]");
                errObj.setId(memberID);
            }
            if (valid) {
                MemberBLO memberBlo = new MemberBLO();
                Member tmpMember = new Member();
                String passwordEncode = tmpMember.encode(memberPassword);
                Member entity = memberBlo.checkLogin(memberID, passwordEncode);
                if (entity != null) {
                    HttpSession session = request.getSession();
                    String roleName = entity.getRoleName();
                    session.setAttribute("ROLE", roleName);
                    session.setAttribute("MEMBERID", entity.getMemberID());
                    url = SEARCH;
                    request.setAttribute("PAGEID", 1);
                } else{
                    errObj.setId(memberID);
                    request.setAttribute("INVALID", errObj);
                    request.setAttribute("NOTFOUND", "Invalid Email or Password");
                }
            } else {
                errObj.setId(memberID);
                request.setAttribute("INVALID", errObj);
            }
        } catch (Exception e) {
            log("ERROR at LoginController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
