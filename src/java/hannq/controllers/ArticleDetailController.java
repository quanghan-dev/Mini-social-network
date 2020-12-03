package hannq.controllers;

import hannq.blos.ArticleBLO;
import hannq.blos.CommentBLO;
import hannq.blos.EmotionBLO;
import hannq.entities.Article;
import hannq.entities.Comment;
import hannq.entities.Emotion;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Han Quang
 */
public class ArticleDetailController extends HttpServlet {

    private static final String HOME = "member/home.jsp";
    private static final String ERROR = "error.jsp";

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
            int articleID;
            if (request.getAttribute("articleID") != null) {
                articleID = (int) request.getAttribute("ARTICLEID");
            } else {
                articleID = Integer.parseInt(request.getParameter("articleID"));
            }
            ArticleBLO aBlo = new ArticleBLO();
            Article article = aBlo.getArticleByArticleID(articleID);
            if (article == null) {
                request.setAttribute("DELETED", "This article has been deleted!");
            } else {
                EmotionBLO eBlo = new EmotionBLO();
                CommentBLO cBlo = new CommentBLO();
                HttpSession session = request.getSession();
                String memberID = (String) session.getAttribute("MEMBERID");
                String role = (String) session.getAttribute("ROLE");
                long likeNum = eBlo.getAmountOfEachArticle(article.getArticleID(), "Like");
                long dislikeNum = eBlo.getAmountOfEachArticle(article.getArticleID(), "Dislike");
                List<Comment> listComment = cBlo.getCommentByArticleID(articleID);
                Emotion emotion = eBlo.getEmotionByArticleIDAndMemberID(article.getArticleID(), memberID);
                request.setAttribute("ARTICLE", article);
                request.setAttribute("LIKE_NUM", likeNum);
                request.setAttribute("DISLIKE_NUM", dislikeNum);
                request.setAttribute("LIST_COMMENT", listComment);
                request.setAttribute("EMOTION", emotion);
                request.setAttribute("ADD_FORM", "ARTICLE_DETAIL");
                if (article.getMemberID().getMemberID().equals(memberID) || role.equals("admin")) {
                    request.setAttribute("DELETE_BUTTON", 1);
                }
            }
            url = HOME;
        } catch (Exception e) {
            log("ERROR at ArticleDetailController: " + e.getMessage());
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
