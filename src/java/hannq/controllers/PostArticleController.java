package hannq.controllers;

import hannq.blos.ArticleBLO;
import hannq.entities.ArticleErrObj;
import java.io.File;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Han Quang
 */
public class PostArticleController extends HttpServlet {

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
        boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
        if (isMultiPart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = null;
            ArticleErrObj errObj = new ArticleErrObj();
            HttpSession session = request.getSession();
            ArticleBLO blo = new ArticleBLO();
            try {
                items = upload.parseRequest(request);
                Iterator iter = items.iterator();
                Hashtable params = new Hashtable();
                String filename = null;
                FileItem fi = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        fi = item;
                    }
                }
                String title = (String) params.get("txtTitle");
                String description = (String) params.get("txtDescription");
                boolean valid = true;
                String itemname = fi.getName();
                if (title.length() > 100) {
                    valid = false;
                    errObj.setTitleErr("Title length less than 100 characters.");
                }
                if (!itemname.equals("")) {
                    if (!itemname.endsWith(".jpg") && !itemname.endsWith(".png") && !itemname.endsWith(".jpeg")) {
                        valid = false;
                        errObj.setImageErr("Please choose .jpg, .png, .jpeg file.");
                    }
                    if (itemname.endsWith(".jpg")) {
                        filename = "Article" + blo.nextArticleID() + ".jpg";
                    } else if (itemname.endsWith(".png")) {
                        filename = "Article" + blo.nextArticleID() + ".png";
                    } else if (itemname.endsWith(".jpeg")) {
                        filename = "Article" + blo.nextArticleID() + ".jpeg";
                    }
                }
                if (valid) {
                    if (blo.insert(title, description, filename, (String) session.getAttribute("MEMBERID"))) {
                        if (filename != null) {
                            String realPath = getServletContext().getRealPath("/") + "images\\" + filename;
                            File file = new File(realPath);
                            fi.write(file);
                        }
                        request.setAttribute("SUCCESS", "Insert Article Successful!");
                    }
                } else{
                    errObj.setArticleTitle(title);
                    errObj.setArticleDescription(description);
                    request.setAttribute("INVALID", errObj);
                }
                request.setAttribute("ADD_FORM", "POST_FORM");
                url = HOME;
            } catch (Exception e) {
                log("ERROR at PostArticleController: " + e.getMessage());
            } finally {
                request.getRequestDispatcher(url).forward(request, response);
            }
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
