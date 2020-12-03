package hannq.controllers;

import hannq.blos.ArticleBLO;
import hannq.blos.CommentBLO;
import hannq.blos.NotificationBLO;
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
public class DeleteController extends HttpServlet {

    private static final String SEARCH = "SearchController";
    private static final String ERROR = "error.jsp";
    private static final String ARTICLE_DETAIL = "ArticleDetailController";

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
            HttpSession session = request.getSession();
            String currentMember = (String) session.getAttribute("MEMBERID");
            String role = (String) session.getAttribute("ROLE");
            String memberID = request.getParameter("memberID");
            if (currentMember.equals(memberID) || role.equals("admin")) {
                if (request.getParameter("commentID") != null) {
                    int commentID = Integer.parseInt(request.getParameter("commentID"));
                    int articleID = Integer.parseInt(request.getParameter("articleID"));
                    String commentContent = request.getParameter("commentContent");
                    CommentBLO cBlo = new CommentBLO();
                    if (cBlo.deleteComment(commentID)) {
                        request.setAttribute("ARTICLEID", articleID);
                        url = ARTICLE_DETAIL;
                        if (!currentMember.equals(memberID) && role.equals("admin")) {
                            NotificationBLO nBlo = new NotificationBLO();
                            nBlo.insertNotification("Admin deleted your comment: " + commentContent, articleID, memberID);
                            nBlo.insertNotification("You deleted " + memberID + "'s comment: " + commentContent, articleID, currentMember);
                        }
                    }
                } else {
                    int articleID = Integer.parseInt(request.getParameter("articleID"));
                    ArticleBLO aBlo = new ArticleBLO();
                    String articleTitle = request.getParameter("articleTitle");
                    if (aBlo.deleteArticle(articleID)) {
                        request.setAttribute("PAGEID", 1);
                        url = SEARCH;
                        if (!currentMember.equals(memberID) && role.equals("admin")) {
                            NotificationBLO nBlo = new NotificationBLO();
                            nBlo.insertNotification("Admin deleted your article with title: " + articleTitle, articleID, memberID);
                            nBlo.insertNotification("You deleted " + memberID + "'s article with title: " + articleTitle, articleID, currentMember);
                        }
                    }
                }
            }

        } catch (Exception e) {
            log("ERROR at DeleteController: " + e.getMessage());
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
