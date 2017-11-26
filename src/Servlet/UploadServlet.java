package Servlet;

import DBUtil.DBUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.List;

@WebServlet(name = "UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;



    // 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "upload";

    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB

    Boolean uploadResult = false;

    private ServletConfig config;
    public void init(ServletConfig config) throws ServletException {
        this.config = config;
    }

    /**
     * 上传数据及保存文件
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //csrfToken
        String token="";
        String comment="";
        String coordinate="";
        String fileName="";
        System.out.println("_______________________________________________________");

//------------------------------------------------------------------------------------------------
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
        System.out.println("basePath:" + basePath);
        request.setAttribute("basePath", basePath);

        // 检测是否为多媒体上传
        if (!ServletFileUpload.isMultipartContent(request)) {
            // 如果不是则停止
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return;
        }

        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // 设置临时存储目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // 设置最大文件上传值
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // 中文处理
        upload.setHeaderEncoding("UTF-8");

        // 构造临时路径来存储上传的文件
        // 这个路径相对当前应用的目录
        String uploadPath = "D:\\ideaData\\Test2\\web\\img";



        // 如果目录不存在则创建
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // 解析请求的内容提取文件数据
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                        fileName = new File(item.getName()).getName();


                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        // 在控制台输出文件的上传路径
                        System.out.println(filePath);
                        //------------------------------------------------------------------------

                        // 保存文件到硬盘
                        item.write(storeFile);
//                        request.setAttribute("message",
//                                "文件上传成功!");
                        InputStream is = new FileInputStream(storeFile);
                        BufferedImage src = javax.imageio.ImageIO.read(is);
                        int w = src.getWidth();
                        int h = src.getHeight();
                        if(w <= 550 && h<= 550){
                            request.getSession().setAttribute("ImgCenter",true);
                        }else {
                            request.getSession().setAttribute("ImgCenter",false);
                        }
                        is.close();

                    }else {
//                        -------------------------------------------------------------------------

                        if(item.getFieldName().equals("csrftoken")){
                            token = item.getString();
                        }else if (item.getFieldName().equals("comment")){
                            comment = item.getString();
                        }else {
                            coordinate = item.getString();
                        }
                        System.out.println("UploadServlet.token:"+token);
                        System.out.println("UploadServlet.comment:"+comment);
                        System.out.println("UploadServlet.coordinate:"+coordinate);

                    }
                }
                DBUtil db = DBUtil.getDB();
                uploadResult = true;
                String username = (String) request.getSession().getAttribute("username");
                System.out.println("UploadServlet.username:"+username);
                db.AddGift(username,fileName,comment,coordinate);
                request.getSession().setAttribute("uploadResult",uploadResult);
                request.getSession().setAttribute("fileName","img/"+fileName);
                request.getSession().setAttribute("csrfToken",token);
                request.getRequestDispatcher("CreateGifts.jsp").forward(request,response);//跳转
//                response.sendRedirect("CreateGifts.jsp");
            }
        } catch (Exception ex) {
            request.setAttribute("message",
                    "错误信息: " + ex.getMessage());
            System.out.println("错误信息: " + ex.getMessage());
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request,response);
    }
}
