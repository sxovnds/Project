<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <style>

        #login {
            max-width: 400px;
            margin: 0 auto;
            margin-top: 100px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        #login td {
            padding : 10px;
        }

        #login .btn {
            width : 350px;
            padding : 15px;
            font-size: 15px;
            margin :0px auto;
            background : #343434;
            color:white;
            cursor: pointer;
        }

        #login input:focus { 
            outline:none;
        }

        #login input {
            border :none;
            border-bottom:1px solid #D0D0D0;
            font-size:16px;
            padding : 10px 10px 10px 0px;
            hint-color:black;
        }

        small {
            color : #C0C0C0;
        }

        .login_title {
            font-weight: 500;
            text-align: center;
            font-size: 40px;
            margin: 10px 0px 20px 0px;
        }

        /* Remove underlines from all anchor tags */
        a {
            text-decoration: none;
            color: black;
        }

        /* Add hover effect on anchor tags */
        a:hover {
            color: #555;
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
<form name="frm" id="login" method="post" action="/member/login" onsubmit="return validateLogin();">
    <p class="login_title">로그인</p>
    <table style="margin:0px auto;">
        <tr>
            <td>
                <small class="titles">아이디</small><br>			
                <input type="text" id="userId" name="userId" placeholder="아이디" size=35>
            </td>
        </tr>
        <tr>
            <td>
                <small class="titles">비밀번호</small><br>			
                <input type="password" id="userPass" name="userPass" placeholder="비밀번호" size=35>
            </td>
        </tr>
        <tr style="padding:10px;">
            <td>
                <input type="checkbox"> 아이디 저장
                <a href="/member/search" style="float:right;">아이디/비밀번호 찾기</a>
            </td>
        </tr>
        <tr>
            <td>
                <button class="btn btn-primary" type="submit" id="submit">로그인</button>
            </td>
        </tr>
        <tr>
            <td>
                <a href="/member/register" style="float:right;">회원가입</a>
            </td>
        </tr>
    </table>
    
    <div class="form-label-group">
    <c:if test="${check == 1}">
        <script>
            alert("${message}");
        </script>
    </c:if>
</div>
</form>
</body>
<script>
        function validateLogin() {
            var userId = document.getElementById("userId").value;
            var userPass = document.getElementById("userPass").value;

            if (userId.trim() === '') {
                alert("아이디를 입력해주세요.");
                return false;
            }

            if (userPass.trim() === '') {
                alert("비밀번호를 입력해주세요.");
                return false;
            }
        }
        

    </script>
</html>
