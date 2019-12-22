package org.apache.jsp.jsp.common;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class Login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html >\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>devmaster.edu.vn</title>\r\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/login.css\">\r\n");
      out.write("    <script src=\"");
      out.print(request.getContextPath());
      out.write("/js/prefixfree.min.js\"></script>\r\n");
      out.write("    <script type=\"text/javascript\"\r\n");
      out.write("\t\tsrc=\"");
      out.print(request.getContextPath());
      out.write("/js/jquery-1.10.2.js\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t<script>\r\n");
      out.write("\t\tfunction login() {\r\n");
      out.write("\t\t\tvar username = document.getElementById(\"username\").value;\r\n");
      out.write("\t\t\tif(username == \"\") {\r\n");
      out.write("\t\t\t\talert(\"Please set your username!\");\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t// Prevent submit form (have submit button) when validate not valid.\r\n");
      out.write("\t\t\t\t/* document.getElementById('formLogin').onsubmit = function() {\r\n");
      out.write("\t\t\t\t    return false;\r\n");
      out.write("\t\t\t\t} */\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tvar password = document.getElementById(\"password\").value;\r\n");
      out.write("\t\t\tif(password == \"\") {\r\n");
      out.write("\t\t\t\talert(\"Please set your password!\");\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t// Submit from without use submit button\r\n");
      out.write("\t\t\tdocument.getElementById('formLogin').submit();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("  </head>\r\n");
      out.write("\r\n");
      out.write("  <body>\r\n");
      out.write("    <div class=\"body\"></div>\r\n");
      out.write("\t\t<div class=\"grad\"></div>\r\n");
      out.write("\t\t<div class=\"header\">\r\n");
      out.write("\t\t\t<div>Site<span>Dev</span></div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<br>\r\n");
      out.write("\t\t<div class=\"login\">\r\n");
      out.write("\t\t\t<form id = \"formLogin\" method=\"post\" action=\"");
      out.print(request.getContextPath());
      out.write("/login\">\r\n");
      out.write("\t\t\t<input type=\"text\" placeholder=\"username\" name=\"username\" id=\"username\"><br>\r\n");
      out.write("\t\t\t<input type=\"password\" placeholder=\"password\" name=\"password\" id=\"password\" autocomplete=\"off\"><br>\r\n");
      out.write("\t\t\t<input type=\"button\" value=\"Login\" onclick=\"login()\">\r\n");
      out.write("\t\t\t</form>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("        \r\n");
      out.write("  </body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
