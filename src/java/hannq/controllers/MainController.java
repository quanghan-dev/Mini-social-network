package hannq.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Han Quang
 */
public class MainController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String LOGIN = "LoginController";
    private static final String LOGOUT = "LogoutController";
    private static final String REGISTER = "RegisterController";
    private static final String VERIFY = "VerifyController";
    private static final String HOME = "member/home.jsp";
    private static final String POSTARTICLE = "PostArticleController";
    private static final String SEARCH = "SearchController";
    private static final String ARTICLEDETAIL = "ArticleDetailController";
    private static final String CHANGEEMOTION = "ChangeEmotionController";
    private static final String COMMENT = "CommentController";
    private static final String DELETE = "DeleteController";
    private static final String NOTIFICATION = "NotificationController";

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

        String url = ERROR;
        try {
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (!isMultiPart) {
                String action = request.getParameter("action");
                switch (action) {
                    case "Login":
                        url = LOGIN;
                        break;
                    case "Logout":
                        url = LOGOUT;
                        break;
                    case "Register":
                        url = REGISTER;
                        break;
                    case "Verify":
                        url = VERIFY;
                        break;
                    case "ShowPostForm":
                        url = HOME;
                        request.setAttribute("ADD_FORM", "POST_FORM");
                        break;
                    case "Search":
                        url = SEARCH;
                        break;
                    case "ShowDetail":
                        url = ARTICLEDETAIL;
                        break;
                    case "ChangeEmotion":
                        url = CHANGEEMOTION;
                        break;
                    case "Comment":
                        url = COMMENT;
                        break;
                    case "DeleteArticle":
                        url = DELETE;
                        break;
                    case "DeleteComment":
                        url = DELETE;
                        break;
                    case "Notification":
                        url = NOTIFICATION;
                        break;
                    default:
                        request.setAttribute("ERROR", "Your action is not valid");
                }
            } else {
                url = POSTARTICLE;
            }
        } catch (Exception e) {
            log("ERROR at MainController: " + e.getMessage());
//            e.printStackTrace();
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
