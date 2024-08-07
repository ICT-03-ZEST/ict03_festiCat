<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/setting.jsp"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰게시판 상세페이지</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/normal_board/review_free_content.css">
<script src="https://kit.fontawesome.com/e3f7bcf3d6.js" crossorigin="anonymous"></script>
<script src="${path}/resources/js/request.js"></script>
<script type="text/javascript">
$(function() {

		$('#mod_input').click(function() {
			document.updateForm.action="${path}/boardUpdateAction.bc";
			document.updateForm.submit();
		});

		//목록으로 돌아가기(새로고침)
		$('#btn_back').click(function() {
			if(${myBoard == null}) {
				location.href="${path}/board.bc?board_category=${dto.board_category}&pageNum=${pageNum}";
			}	
			else {
				location.href="${path}/myBoardList.myp";
			}
		});		
		
        $('#board_thumnail').change(function() {
            let fileName = $(this).val().split('\\').pop();
            $('#thumnail_name').text(fileName);
        });

        $('#board_image').change(function() {
        	let fileName = $(this).val().split('\\').pop(); // '\\'의마지막부분 반환
            $('#image_name').text(fileName);
        });
        
});
	
</script>

</head>
<body>

	<!-- header 시작-->
	<%@ include file="/common/header.jsp"%>
	<!-- header 끝-->
	
    <div class="mod_title" align="center"><h3>게시글 수정</h3></div>
    
    <section>
        <div class="review_box">
        	<form name="updateForm" method="post" enctype="multipart/form-data">
	        	<input type="hidden" name="hiddenNum" value="${dto.board_num}">
	        	<input type="hidden" name="hiddenThumnail" value="${dto.board_thumnail}">
	        	<input type="hidden" name="hiddenImage" value="${dto.board_image}">
	        	<input type="hidden" name="hiddenCategory" value="${dto.board_category}">
	          
	          <div class="mod_container">
		          <table class="mod_table" cellspacing="0" cellpadding="0">
		          	<tr>
		          		<td colspan="3">
		          			<div class="headMod">
	                			<ul>
	                    			<li class="writerMod"><span>${dto.board_writer}</span>
	                        			<ul class="ul_list">
				                            <li class="regDate">${dto.board_regDate}</li>
				                            <li class="views">조회수 ${dto.board_views}</li>
	                            			<li><i id="board_heart" class="fa-regular fa-heart"></i>${dto.board_heart}</li>
	                        			</ul>
	                        			<ul>
	                        				<li class=li_category><span>${dto.board_category}</span></li>
	                        			</ul>
	                    			</li>
	                			</ul>
	          				</div> 
		          		</td>
		          	</tr>
		          	
		          	<tr>
		          		<th>제목</th>
		          		<td colspan="2"><input type="text" name="board_title"  class="board_title" value="${dto.board_title}"></td>
		          	</tr>
		          	
		          	<tr> 
		          		<th class="th_img">이미지</th>
			       		<td class="td_oldImg" align="center">
				       		<c:if test="${dto.board_image != null}"> 
	            				<img src="${dto.board_image}" class="oldImg">
	            			</c:if>
	            			
	            			<c:if test="${dto.board_image == null}"> 
	            				이미지 없음
	            			</c:if>
			       		</td>
			       		
				        <td class="td_newImg" align="center">
				        	<label class="btn_choice" for="board_image">파일선택</label>
				        	<input type="file" class="input_file" name="board_image" id="board_image" accept="image/*">
				        	<span class="file_name" id="image_name">파일선택 없음</span>
				        </td>
		          	</tr>
		          	
			        <tr>
			        	<td colspan="4"><textarea name="board_content" id="board_content" cols="50" rows="15" placeholder="내용을 입력하세요" required>${dto.board_content}</textarea></td>
			        </tr>
			        
			        <tr>
			        	<td align="left" class="td_bottom">
			        		<input type="button" name="btn_back" class="mod_back" id="btn_back" value="목록">
			        	</td>
			        	<td colspan="3" align="right" class="td_bottom">
			        		<input type="reset" name="reset" class="mod_input" id="reset" value="초기화">
			        		<input type="button" name="modify" class="mod_input" id="mod_input" value="확인">
			        	</td> 
			        </tr>
		          </table>
	          </div>
          </form>
        </div>
    </section>

    <!-- footer 시작-->
	<%@ include file="/common/footer.jsp"%>
	<!-- footer 끝-->
</body>
</html>