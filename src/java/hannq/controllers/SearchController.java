package hannq.controllers;

import hannq.blos.ArticleBLO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Han Quang
 */
public class SearchController extends HttpServlet {

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
            String searchValue = request.getParameter("txtSearch");
            if(searchValue == null)
                searchValue = "";
            int currentPage;
            if (request.getAttribute("PAGEID") != null) {
                currentPage = (int) request.getAttribute("PAGEID");
            } else {
                currentPage = Integer.parseInt(request.getParameter("pageID"));
            }
            
            int pageSize = 20;

            ArticleBLO blo = new ArticleBLO();
            List result = blo.searchByLikeDescription(searchValue, currentPage, pageSize);
            if (result != null) {
                request.setAttribute("LIST_ARTICLE", result);
                request.setAttribute("CURRENT_PAGE", currentPage);
                request.setAttribute("ARTICLE_COUNT", blo.getAmountOfFindByLikeName(searchValue, pageSize));
                url = HOME;
            }
        } catch (Exception e) {
            log("ERROR at SearchController: " + e.getMessage());
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
