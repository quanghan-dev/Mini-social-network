package hannq.controllers;

import hannq.blos.ArticleBLO;
import hannq.blos.CommentBLO;
import hannq.blos.NotificationBLO;
import hannq.entities.Article;
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
public class CommentController extends HttpServlet {
    private static final String ARTICLE_DETAIL = "ArticleDetailController";
    private static final String ERROR = "error.jsp";
    private static final String HOME = "member/home.jsp";
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
            String commentContent = request.getParameter("txtComment");
            int articleID = Integer.parseInt(request.getParameter("articleID"));
            HttpSession session = request.getSession();
            String currentMember = (String) session.getAttribute("MEMBERID");
            CommentBLO cBlo = new CommentBLO();
            ArticleBLO aBlo = new ArticleBLO();
            Article article = aBlo.getArticleByArticleID(articleID);
            String articleOwner = article.getMemberID().getMemberID();
            if (aBlo.getArticleByArticleID(articleID) != null) {
                if(!commentContent.equals("")){
                    if(cBlo.insertComment(commentContent, articleID, currentMember)){
                        request.setAttribute("ARTICLEID", articleID);
                        //notification
                        if (!currentMember.equals(articleOwner)) {
                            NotificationBLO nBlo = new NotificationBLO();
                            nBlo.insertNotification(currentMember + " commented on your article: " + commentContent, articleID, articleOwner);
                        }
                    }
                }
                request.setAttribute("ARTICLEID", articleID);
                url = ARTICLE_DETAIL;
            } else {
                url = HOME;
            }
        } catch (Exception e) {
            log("ERROR at CommentController: " + e.getMessage());
            e.printStackTrace();
        } finally{
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
