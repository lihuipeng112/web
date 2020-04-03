<%@ page errorPage="error.jsp" contentType="text/html;charset=utf-8" %>
<%@ include file="cksession.jsp" %>
<%@ include file="atconnection.jsp" %>
<%@ include file="public.jsp" %>
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>

<%
request.setCharacterEncoding("UTF-8");
String key=request.getParameter("key");
if(key==null){
	key="";
}
String wwtb_id=request.getParameter("wwtb_id");
if(wwtb_id==null){
	wwtb_id="";
}
String game_name=request.getParameter("game_name");
String channel_name=request.getParameter("channel_name");
String ipa=request.getParameter("ipa");
String submit=request.getParameter("submit");
if(submit==null){
	submit="";
}
Connection conn2=DriverManager.getConnection(db_url,db_user,db_password);
Statement	stmt2=conn2.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rs2;
String sql2;
	//加入cp准入规则
	if(game_name!=null && ipa!=null && !wwtb_id.equals("")){
		//out.println(game_name);
		out.println(submit+"成功! ! ! ! !请核对以下信息,若是错误请通知测试");%><br><%
		if(submit.equals("新增对比任务")){
			sql="insert compare_task (game_name,ipa,wwtb_id,new_time) values ('"+game_name+"','"+ipa+"','"+wwtb_id+"',now()) on duplicate key update state=0";
			stmt.executeUpdate(sql);
			out.println("新增加的比对任务:"+game_name+channel_name+"  " +ipa);%><br><%
			
		}
		if(submit.equals("新增游戏比对配置")){		
			sql="insert compare_config (game_name,channel_name,wwtb_id,new_time) values ('"+game_name+"','"+channel_name+"','"+wwtb_id+"',now()) on duplicate key update channel_name='"+channel_name+"'";
			stmt.executeUpdate(sql);
			out.println("新增加的比对配置:"+game_name+channel_name+"  " +ipa);%><br><%
		}		
		//out.println("新增数据成功");
	}
%>


<html>
<head>
<style type="text/css">
#customers
  {
  font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse:collapse;
  }
#customers td, #customers th 
  {
  font-size:1em;
  border:2px solid #B0E0E6;
  padding:7px 7px 3px 10px;
  }
#customers th 
  {
  font-size:1.1em;
  text-align:left;
  padding-top:5px;
  padding-bottom:4px;
  background-color:#63B8FF;
  color:#ffffff;
  }



</style>
    <title>新增对比任务</title>    
</head>

<body>
<font color="red" size="15">

</font><br>

  <%
  if(!wwtb_id.equals("")){
		sql="select * from waiwangtibao where id='"+wwtb_id+"'";

		//out.println(sql);
		rs=stmt.executeQuery(sql);

		if(rs.next()){

		%>当前需要对比的ipa包:<%out.println(rs.getString("wenjian"));
		%>
		<form action="" method="post">
		  <input name="wwtb_id" type="hidden" value="<%=wwtb_id%>" />

		<input name="ipa" type="hidden" value="<%=rs.getString("wenjian")%>" />
		<label>包渠道名称：</label>
		<input name="channel_name" type="text" value="<%=rs.getString("comment")%>" />
		
		


	<div style="position:relative;display:inline-block"> 
		<span style="margin-left:100px;width:18px;overflow:hidden;">
			<select style="width:118px;margin-left:-100px" onchange="this.parentNode.nextSibling.value=this.value">
					<%
					sql2 = "select * from compare_config group by game_name";
					rs2=stmt2.executeQuery(sql2);
					while(rs2.next()){
					%>
						<option value="<%=rs2.getString("game_name")%>" selected><%=rs2.getString("game_name")%></option>
					<%}%>
			</select></span><input name="game_name" style="width:100px;position:absolute;left:0px;">
	</div>


		<input type="submit" value="新增对比任务" name="submit" value="task"/>
		<input type="submit" value="新增游戏比对配置" name="submit" />
		</form>
		<%}else{
			out.println("上传记录id错误，请联系测试同学");
		}
  }%>
<hr>





<hr>
<form action="" method="post">
<input name="key" type="text" value="<%=key%>" />
<input type="submit" value="查询"/>
<a href="compare_config.jsp" target="_blank">各游戏已有配置查询</a>
</form>
<table border=1 id="customers">
	<tr>
		<th>序号</th>
		<th>game_name</th>
		<th>渠道名</th>
		
		<th>文件名</th>
		<th>任务状态</th>
		<th>创建时间</th>
		<th>操作</th>
	</tr>
		<%
		int i=0;
		sql="select * from compare_task where id=id";
		sql=sql+" and (game_name like '%"+key+"%' or ipa like '%"+key+"%')";
		sql=sql+" order by id desc limit 100";
		rs=stmt.executeQuery(sql);
		 while(rs.next()){
			 i++;
		%>
		<tr>
		<td><%=i%></td>
		<td><%=rs.getString("game_name")%></td>
		
		<td><%
		sql2 = "select * from compare_config where wwtb_id = '"+rs.getString("wwtb_id")+"' order by id desc limit 1";
		rs2=stmt2.executeQuery(sql2);
		if(rs2.next()){
			out.println(rs2.getString("channel_name"));
		}
		%></td>
		
		<td><%=rs.getString("ipa")%></td>
		<td><%
		if(rs.getString("state").equals("0")){
			out.println("未处理");
		}
		if(rs.getString("state").equals("1")){
			out.println("进行中");
		}		
		if(rs.getString("state").equals("2")){
			out.println("已完成");
		}		
		%></td>
		<td><%=rs.getString("new_time")%></td>
		<td><a href="compare_task.jsp?compare_task_id=<%=rs.getString("id")%>">任务详情</a></td>
	</tr>
		 <%}%>

</body>

</html>

<script type="text/javascript">
$('#expertId option').on('click', function() {
                document.getElementById('expertIdt').value=  
                document.getElementById('expertId').options[document.getElementById('expertId').selectedIndex].value;

})



</script>

<%
    stmt.close();
	conn.close();
%>

