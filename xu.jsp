if(rs.getString("location").equals"正版"){
						sqlz = "select * from waiwangtibao order by update_time desc limit 1000";
						rsz = stmt1.executeQuery(sqlz);
						if(rs1.next()){%>
						<br><a href="http://14.23.56.194:8888/dinner/download.jsp?id=<%=rsz.getString("id")%>&code=<%=rsz.getString("code")%>" target="_blank">下载</a>
						<%}
						
					}else{
						sql1="select * from yunapk where instr(url,'"+rs1.getString("apk")+"')>0";
						rs1=stmt1.executeQuery(sql1);
						if(rs1.next()){%>
						<br><a href="<%=rs1.getString("url")%>" target="_blank">下载</a>
						<%}
					}
					

					
<br><a href="http://192.168.1.204:8080/dinner/download.jsp?id=<%=rs1.getString("id")%>&code=<%=rs1.getString("code")%>" target="_blank">dis内网下载</a>
<br><a href="http://14.23.56.194:8888/dinner/download.jsp?id=<%=rs1.getString("id")%>&code=<%=rs1.getString("code")%>" target="_blank">dis外网下载</a>
							sql1="select * from waiwangtibao where instr(wenjian,'"+rs1.getString("apk").replaceAll("dev","dis")+"')>0";
							rs1=stmt1.executeQuery(sql1);
							
					sql1="select * from waiwangtibao where instr(wenjian,'"+rs1.getString("apk")+"')>0";
					rs1=stmt1.executeQuery(sql1);
					if(rs1.next()){%>
					<br><a href="http://192.168.1.204:8080/dinner/download.jsp?id=<%=rs1.getString("id")%>&code=<%=rs1.getString("code")%>" target="_blank">dev内网下载</a>
					
					
					<%}
					
					<td><%=rs3.getString("sign")%>&nbsp;</td>
				<td><%=rs2.getString("conclusion")%>&nbsp;</td>
					
					sql = "select * from 360_check where instr(url,'"+rs.getString("ltask")+"') order by id desc";
					rs3 = stmt3.executeQuery(sql);
					sql = "select * from qq_check where instr(url,'"+rs.getString("ltask")+"') order by id desc";
					rs2 = stmt2.executeQuery(sql);
					sql = "select d.id,d.reason,l.id lid,d.risk,d.manage,d.update_time,d.belong,d.comment,d.file,l.d_task_id ltask from xuqiu_dahui d,xuqiu_list l where d.xuqiulist_id = '"+xuqiulist_id+"' and d.xuqiulist_id = l.id order by id desc limit 1";
					rs = stmt.executeQuery(sql);
					
					<%if(rs.getString("appstore_dahui").equals("")){%>
	<td><%=rs.getString("appstore_dahui")%></td>
<%}else{%>
	<td><%=rs.getString("state")%></td>
<%}%>