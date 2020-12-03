package hannq.controllers;

import hannq.mailUtil.SendingEmail;
import hannq.blos.MemberBLO;
import hannq.entities.Member;
import hannq.entities.MemberErrObj;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Han Quang
 */
public class VerifyController extends HttpServlet {

    private static final String REGISTER = "register.jsp";
    private static final String VERIFY = "verify.jsp";

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
        String url = REGISTER;
        MemberErrObj errObj = new MemberErrObj();
        try {
            String memberID = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            String memberFullname = request.getParameter("txtName");
            String confirm = request.getParameter("txtConfirm");
            boolean valid = true;
            if (!memberID.matches("([a-zA-Z0-9.]{3,20})@([a-zA-Z]{3,10})([.])([a-zA-Z]{1,10})([.][a-zA-Z]{1,10})?")) {
                if (!memberID.equals("admin")) {
                    valid = false;
                    errObj.setIdErr("Invalid Email format(abc@xyz.xyz) and maximum 50 characters.");
                }
            }
            if (!password.matches("[\\S]{6,20}")) {
                valid = false;
                errObj.setPwErr("Password must not contains blank and in range [6, 20]");
            }
            if (!memberFullname.matches("[a-zA-Z ]{3,50}")) {
                valid = false;
                errObj.setNameErr("Name must not contains special character and maximum 50 characters.");
            }
            if (!confirm.equals(password)) {
                valid = false;
                errObj.setConfirmErr("Confirm must matches Password");
            }
            if (valid) {
                MemberBLO blo = new MemberBLO();
                Member tmpMember = new Member();
                String passwordEncode = tmpMember.encode(password);
                if (blo.getMemberByMemberID(memberID) != null) {
                    request.setAttribute("EXIST", "That email is exist.");
                } else {
                    SendingEmail sendEmail = new SendingEmail();
                    int code = sendEmail.sendEmail(memberID);
                    if (code != 0) {
                        Member member = new Member(memberID, passwordEncode, memberFullname, "member", "New");
                        HttpSession session = request.getSession();
                        session.setAttribute("NEW_MEMBER", member);
                        session.setAttribute("CODE", code);
                        url = VERIFY;
                    }
                }
            } else {
                errObj.setId(memberID);
                errObj.setName(memberFullname);
                request.setAttribute("INVALID", errObj);
            }
        } catch (Exception e) {
            log("ERROR at RegisterController: " + e.getMessage());
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
