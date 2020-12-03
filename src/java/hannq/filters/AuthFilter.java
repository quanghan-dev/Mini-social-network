package hannq.filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Han Quang
 */
public class AuthFilter implements Filter {

    private static final boolean debug = true;
    private static final String LOGIN = "/login.jsp";

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    List<String> guest;
    List<String> member;
    List<String> admin;

    public AuthFilter() {
        guest = new ArrayList<>();
        guest.add("login.jsp");
        guest.add("error.jsp");
        guest.add("register.jsp");
        guest.add("MainController");
        guest.add("Login");
        guest.add("Register");
        guest.add("Verify");
//        guest.add("LoginController");
//        guest.add("VerifyController");
//        guest.add("RegisterController");

        member = new ArrayList<>();
        member.add("member/articleDetail.jsp");
        member.add("member/home.jsp");
        member.add("member/notification.jsp");
        member.add("error.jsp");
        member.add("Logout");
        member.add("ShowPostForm");
        member.add("Post");
        member.add("Search");
        member.add("ShowDetail");
        member.add("ChangeEmotion");
        member.add("Comment");
        member.add("DeleteArticle");
        member.add("DeleteComment");
        member.add("Notification");
//        member.add("MainController");

        admin = new ArrayList<>();
        admin.add("member/articleDetail.jsp");
        admin.add("member/home.jsp");
        admin.add("member/notification.jsp");
        admin.add("error.jsp");
        admin.add("Logout");
        admin.add("Search");
        admin.add("ShowDetail");
        admin.add("DeleteArticle");
        admin.add("DeleteComment");
        admin.add("Notification");
//        admin.add("MainController");
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String url = LOGIN;
        String uri = req.getRequestURI();
        int index = uri.lastIndexOf("/");
        String resource = uri.substring(index + 1);
        String action = req.getParameter("action");

        if (uri.contains("Controller")) {
            url = "//" + resource;
        }
        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("ROLE");
        if (uri.endsWith("jpg") || uri.endsWith("js") || uri.contains("css") || uri.endsWith("png") || uri.endsWith("ttf") || uri.endsWith("otf")
                || uri.endsWith("eot") || uri.endsWith("svg") || uri.endsWith("woff") || uri.endsWith("woff2") || uri.endsWith("less") || uri.endsWith("scss")
                || uri.endsWith("txt") || uri.endsWith("jpeg") || uri.endsWith("ico")) {
            chain.doFilter(request, response);
            return;
        }
        if (role == null) { //chua login
            if (!guest.contains(resource)) {
                if (resource.contains("MainController")) { //co MainController
                    if (!action.equals("Login") || !action.equals("Verify") || !action.equals("Register")) { //co MainController nhung khong dung action
                        url = LOGIN;
                    }
                } else { //khong co MainController
                    url = LOGIN;
                }
            } else { //resource co nam trong arraylist
                url = resource;
            }
        } else { //da login
            if (action != null) {
                if (role.equals("member")) {
                    if (!member.contains(action) || !uri.contains("MainController")) { //co action ma khac controller
//                        session.invalidate();
//                        url = LOGIN;
                        url = "MainController?action=Search&txtSearch=&pageID=1";
                    }
                } else if (role.equals("admin")) {
                    if (!admin.contains(action) || !uri.contains("MainController")) { //co action ma khac controller
//                        session.invalidate();
//                        url = LOGIN;
                        url = "MainController?action=Search&txtSearch=&pageID=1";
                    }
                }
            } else if (role.equals("member") || role.equals("admin")) { //Khong co action thi ve trang chinh
                url = "MainController?action=Search&txtSearch=&pageID=1";
            }
        }
        if (url != null) {
            req.getRequestDispatcher(url).forward(request, response); //tra ve url
        } else {
            chain.doFilter(request, response); //ep chain k chay de k gui them request toi cho minh mong muon
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
