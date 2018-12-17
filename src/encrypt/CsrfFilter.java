package encrypt;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

//@WebFilter(filterName = "CsrfFilter")
public class CsrfFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
//        chain.doFilter(req, resp);
        HttpServletRequest req = (HttpServletRequest)request;

        HttpSession s = req.getSession();

        // 从 session 中得到 csrftoken 属性

//        String sToken = (String)s.getAttribute();
        String sToken = (String) s.getAttribute("csrftoken");


        if(sToken == null){

            // 产生新的 token 放入 session 中

            sToken = generateCSRFToken();

            s.setAttribute("csrftoken",sToken);
            System.out.println((String)"first: " + s.getAttribute("csrftoken"));

            chain.doFilter(request, response);

        } else{

            // 从 HTTP 头中取得 csrftoken

//            String xhrToken = req.getHeader(“csrftoken”);

            // 从请求参数中取得 csrftoken

//            String pToken = req.getParameter("csrftoken");
//            String tempToken = req.getParameter("token");
//            String users = req.getParameter("username");
            String pToken = (String) req.getParameter("csrftoken");
//            String pToken = (String) req.getHeader("csrftoken");
            String testhead = req.getHeader("csrftoken");  //获取一个指定头字段的值
            System.out.println("testhead"+":"+testhead);
            Enumeration<String> enumeration = req.getHeaderNames();
            while (enumeration.hasMoreElements()) {
                String name = (String) enumeration.nextElement();
                String values = req.getHeader(name);
                System.out.println(name+":"+values);
            }



            if(sToken != null && pToken != null && sToken.equals(pToken)){
                System.out.println("GoodS: " + sToken);
                System.out.println("GoodP: " + pToken);
                chain.doFilter(request, response);
            }else{
                System.out.println("wrongS: " + sToken);
                System.out.println("wrongp: " + pToken);
//                System.out.println("temp:" + tempToken);
//                System.out.println("userameFilter:" + users);
                req.getRequestDispatcher("error.jsp").forward(request,response);
            }

        }
    }

    public void init(FilterConfig config) throws ServletException {
        String testParam = config.getInitParameter("test-param");

        //Print the init parameter
        System.out.println("Test Param: " + testParam);

    }

    public String generateCSRFToken(){
        String result;
        result = UUID.randomUUID().toString();
        return result;
    }


}
