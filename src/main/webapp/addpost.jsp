        <%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="com.example.project4_board.BoardDAO"%>
<%@ page import="com.example.project4_board.BoardVO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>

<% request.setCharacterEncoding("utf-8"); %>

        <jsp:useBean id="u" class="com.example.project4_board.BoardVO" />
        <jsp:setProperty property="*" name="u"/>

        <%
            request.setCharacterEncoding("utf-8");

            // 파일 업로드 처리 코드
            String filename = "";
            MultipartRequest multipartRequest = null;

            int sizeLimit = 15 * 1024 * 1024; // 15MB

            String realPath = request.getServletContext().getRealPath("upload");
            File dir = new File(realPath);
            if (!dir.exists()) dir.mkdirs();

            multipartRequest = new MultipartRequest(request, realPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
            Enumeration files = multipartRequest.getFileNames();
            if (files.hasMoreElements()) {
                String paramName = (String) files.nextElement();
                filename = multipartRequest.getFilesystemName(paramName);
            }

            if (filename == null) {
                // 파일이 업로드되지 않은 경우 처리
                filename = "";
            }


            // 데이터베이스에 저장할 정보 추출
            String title = multipartRequest.getParameter("title");
            String writer = multipartRequest.getParameter("writer");
            String content = multipartRequest.getParameter("content");
            String importance = multipartRequest.getParameter("importance");

            // 데이터베이스에 저장
            // 데이터베이스에 저장
            BoardVO boardVO = new BoardVO();
            boardVO.setTitle(title);
            boardVO.setWriter(writer);
            boardVO.setContent(content);
            boardVO.setAttach(filename); // 파일명을 저장
            boardVO.setImportance(importance);

            if (!filename.isEmpty()) {
                boardVO.setAttach(filename);
            }

            BoardDAO boardDAO = new BoardDAO();
            int result = boardDAO.insertBoard(boardVO);



            String msg = "데이터 추가 성공!";
            if (result == 0) {
                msg = "[에러] 데이터 추가 실패";
            }
        %>
<script>
    alert('<%=msg%>');
    location.href='posts.jsp';
</script>