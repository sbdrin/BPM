<%@ Page Language="c#" CodeBehind="Application.aspx.cs" AutoEventWireup="True" Inherits="Benq.Flower.Web.Application.Application"
    EnableViewState="False" %>

<%@ Import Namespace="Benq.Flower.Web" %>
<%@ Import Namespace="Benq.Flower.ResourceManagement" %>
<%@ Import Namespace="Benq.Flower.SystemFramework.Table" %>
<%@ Import Namespace="Benq.Flower.Web.Component" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <meta content="Microsoft Visual Studio 7.0" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />

    <script src="../javascript/jquery-1.2.3.pack.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" language="javascript" src="../javascript/Button.js"></script>

    <script type="text/javascript" language="javascript" src="../javascript/Level1.js"></script>

    <script type="text/javascript" language="javascript" src="../javascript/Function.js"></script>

    <script type="text/javascript" language="javascript">
			var varPopTips = null;
			var m_objLastMoved=null;
			var m_strLastRowClass=null;
			var m_bolCurCycle=null;
			var VISIBLE="visible";
			var HIDDEN="hidden";
			
			function openManagement(strFunID,strFunName,strFormKind,strIsGlobal)
			{
				openWindow("FormApp.aspx?FunctionID="+strFunID+"&FunctionName="+strFunName+"&Form_Kind="+strFormKind+"&Emp_ID=<%=m_strApp_Emp_ID%>"+"&IsGlobal="+strIsGlobal);
			}
			function go(p_intPageDelta,p_strDirection)
			{
				window.status="";
				if (p_intPageDelta<1 || (p_strDirection=="BACK" && <%=m_intPage%>==1))
				{
					window.status='<%="分页已经达到第一页".Localize(30010003)%>';
					return;
				}
				if (p_intPageDelta><%=m_intPageCount%> || (<%=m_intPage%>==<%=m_intPageCount%> && p_strDirection=="FORWARD"))
				{
					window.status='<%="分页已经达到最后一页".Localize(30010004)%>';
					return;	
				}
				document.getElementById("CurrentPage").value=p_intPageDelta;
				document.forms[0].submit();
			}
			function showFormName(e)
			{
				var formname = document.getElementById("inputFormName").value;
				$("#lblShowFormName").html(formname);
				//document.getElementById("lblShowFormName").innerText = formname;
				//lblformname.innerText  = "123456";
				varPopTips = document.getElementById("divShowFormName");
				varPopTips.style.left=e.clientX+20;//e.x+document.body.scrollLeft+20;
				varPopTips.style.top=e.clientY;
				
				varPopTips.style.visibility=VISIBLE;
			}
			function hidePopupTips()
			{
				try
				{
					varPopTips.style.visibility=HIDDEN;
					//document.all("tdApproveYes").style.display="none";	
					//document.all("tdApproveNo").style.display="none";	
				}
				catch(ex){}
			}
			function changeStyle(p_obj,p_strClassName,p_strOrigionClassName,rowMark)
			{
				if (p_obj.className!=p_strClassName)
				{
					p_obj.className=p_strClassName;
					if (document.getElementById("Img"+rowMark).src.indexOf("_In")==-1)
					{	
						document.getElementById("Img"+rowMark).src="../image/ApplicationFormSelf.gif";
					}
					else
					{	
						document.getElementById("Img"+rowMark).src="../image/ApplicationFormSelf.gif";
					}
					
					//document.all("Tips").innerHTML+=(p_obj.className+"--"+p_strClassName+"   ");
					if ((m_objLastMoved!=null) && (m_objLastMoved!=p_obj))
					{
						//m_objLastMoved.className=m_strLastRowClass;
					}
					m_objLastMoved=p_obj;
					m_strLastRowClass=p_strOrigionClassName;
				}
			}
			
			
            
			function Query()
			{
				document.getElementById("txtQuery").value=document.getElementById("queryCondition").value;
				Application.submit();
				
			}
			
			function queryAdvance()
			{
				openMiniDialog_New("SelectFormList.aspx?FlowPhase=APPLICATION","../Module/");
				showModalDialogCallback_SelectSingleForm();
			}
			function showModalDialogCallback_SelectSingleForm()
            {
                var objReturn=getReturnValueCommon();
            					
				if (objReturn!=null)
				{
					document.getElementById("hdnFormKind").value=objReturn.FormKind;
					document.getElementById("inputFormName").value=objReturn.FormName;
					Query();
				}
            }
			
			function SetScrollPosition()
			{
				if(window.screen.availWidth>800)
				{				
					document.getElementById("TBApplication").style.left =8;
				}
			}				
    </script>

</head>
<body onload="javascript:SetScrollPosition();">
    <form id="Application" method="post" runat="server">
    <div class="DIVTips" id="divShowFormName" style="z-index: 20;">
        <table cellspacing="0" cellpadding="0" bgcolor="lightyellow" border="0">
            <tr>
                <td class="FontTips" nowrap="nowrap">
                    <label id="lblShowFormName">
                    </label>
                </td>
            </tr>
        </table>
    </div>
    <table id="TBApplication" cellpadding="0" cellspacing="0" border="0" align="center"
        class="TableSelectFormMain">
        <!--1. Query Part-->
        <tr class="TRQueryBanners">
            <td width="100%">
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td width="8px">
                            &nbsp;
                        </td>
                        <td nowrap="nowrap" class="TDQueryLabelNew">
                            <%="表单名称".Localize(30002135)%>:
                        </td>
                        <td width="5px">
                            &nbsp;
                        </td>
                        <td style="cursor: pointer" nowrap="nowrap" onmousemove="javascript:showFormName(event)" onmouseout="javascript:hidePopupTips()" >
                            <input type="text" class="txtQueryNew" size="40" value="<%=m_serchFormName%>" readonly="readonly"
                                id="inputFormName" name="inputFormName" onclick="javascript:queryAdvance()">
                            <input type="hidden" id="hdnFormKind" name="hdnFormKind" value="<%=m_strFormKind%>">
                        </td>
                       
                        <td nowrap="nowrap" class="TDQueryLabelNew">
                            <%="功能名称".Localize(30400010)%>:
                        </td>
                        <td>
                            <input id="txtQuery" type="text" runat="server"  style="display:none;"/>
                        </td>
                        <td  nowrap="nowrap">
                            <input id="queryCondition" runat="server"  type="text" class="txtQueryNew" size="40"/>
                        </td>
                        
                        <td>
                            <input type="button"  class="InputButton" onclick="javascript:Query()" value='<%="查 询".Localize(30001038)%>'>
                        </td>
                        <td width="300px">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!--2. Content Part -->
        <tr>
            <td width="100%">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td width="100%">
                            <asp:DataList ID="DataList1" DataKeyField="FUNCTION_ID" CellSpacing="0" CellPadding="0"  Width="100%"
                                BorderWidth="0" runat="server" RepeatLayout="Table" DataSource="<%#m_datasetFunctionList%>">
                                <HeaderTemplate>
                                    <tr class="TRHeader">
                                        <td nowrap="nowrap" class="TDHeaderLeftNew">
                                        </td>
                                        <td nowrap="nowrap" align="center" width="22px" class="TDHeaderNew">
                                        </td>
                                        <td nowrap="nowrap" align="left" width="520px" class="TDHeaderNew">
                                            <%="功能名称".Localize(30001094)%>
                                        </td>
                                        <td nowrap="nowrap" align="left" width="100%" class="TDHeaderNew">
                                            <%="表单名称".Localize(30001010)%>
                                        </td>
                                        <td nowrap="nowrap" class="TDHeaderRightNew">
                                        </td>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%
                                        if (m_intRows < Convert.ToInt32(CookiesNaming.ROWS_PER_PAGE_SERVICE))
                                        {
                                            if (m_bolDeep)
                                            {%>
                                    <tr class="TRDeepNew" id="TrForm<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>">
                                        <%}
                                                else
                                                {%>
                                    <tr id="TrForm<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>">
                                        <%}
                                                m_bolDeep = !m_bolDeep;
                                                m_intRows++;
                                        %>
                                        <td width="13px">
                                        </td>
                                        <td align="center" class="TDActionNew" id="tdForm<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>"
                                            onmouseover="javascript:try{changeStyle(document.getElementById('<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>'),'SpanMoveNew','TDActionNew','<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>') }catch(ex){}"
                                            onmouseout="javascript:try{changeStyle(document.getElementById('<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>'),'TDActionNew','SpanMoveNew','<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>') }catch(ex){}">
                                            <img id="Img<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>"
                                                src="../image/ApplicationFormSelf.gif">
                                        </td>
                                        <td align="left" class="TDActionNew" id="<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>"
                                            onmouseover="javascript:try{changeStyle(this,'SpanMoveNew','TDActionNew',this.id);  }catch(ex){}"
                                            onmouseout="javascript:try{changeStyle(this,'TDActionNew','SpanMoveNew',this.id)}catch(ex){}"
                                            onclick="javascript:openManagement('<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_ID)%>','<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_EN)%>','<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FORM_KIND)%>','<%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.IS_GLOBAL)%>')">
                                            <%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FUNCTION_NAME)%>
                                        </td>
                                        <td align="left" class="TDLabelSolidNew">
                                            <%#DataBinder.Eval(Container.DataItem, FacadeFormManagement.FORM_NAME)%>
                                        </td>
                                        <td width="13px">
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%
                                        if (m_intRows < Convert.ToInt32(CookiesNaming.ROWS_PER_PAGE_SERVICE))
                                        {%>
                                    <tr>
                                        <td colspan="5">
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
                                                <%for (int _intRows = m_intRows; _intRows < Convert.ToInt32(CookiesNaming.ROWS_PER_PAGE_SERVICE); _intRows++)
                                                  {%>
                                                <%if (m_bolDeep)
                                                  {%><tr class="TRDeepNew">
                                                    <%}
                                                  else
                                                  {%>
                                                <tr>
                                                    <%}%><td nowrap="nowrap" class="TDBlank">
                                                    &nbsp;
                                                    </td>
                                                </tr>
                                                <%m_bolDeep = !m_bolDeep;%>
                                                <%}%>
                                            </table>
                                        </td>
                                    </tr>
                                    <%}%>
                                </FooterTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!--3. Footer Part-->
        <tr>
            <td width="100%">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td class="TDPageChangeNew" nowrap="nowrap">
                            &nbsp;
                        </td>
                        <td class="TDPageChangeNew" width="60px" align="center">
                        </td>
                        <td class="TDPageChangeNew" width="60px">
                            <input id="CurrentPage" type="hidden" value="<%=m_intPage%>" name="CurrentPage">
                        </td>
                        <td class="TDPageChangeNew" nowrap="nowrap">
                        </td>
                        <td class="TDPageChangeNew" width="16px">
                        </td>
                        <td class="TDPageChangeTextNew" width="120px" align="right">
                            &nbsp;&nbsp;<%="Total".Localize(30001087)%>&nbsp;
                        </td>
                        <td class="TDPageChangeTextNew" width="50px" align="center">
                            <%=m_intPage%>/<%=m_intPageCount%>
                        </td>
                        <td class="TDPageChangeNew" width="35px">
                            <input type="button" id="btnPageFirst" name="btnPageFirst" value="|<" class="InputButtonPageChange"
                                onclick="javascript:go(1,'BACK');">
                        </td>
                        <td class="TDPageChangeNew" width="35px">
                            <input type="button" id="btnPagePrevious" name="btnPagePrevious" value="<" class="InputButtonPageChange"
                                onclick="javascript:go(<%=m_intPage-1%>,'BACK');">
                        </td>
                        <td class="TDPageChangeNew" width="35px">
                            <input type="button" id="btnPageNext" name="btnPageNext" value=">" class="InputButtonPageChange"
                                onclick="javascript:go(<%=m_intPage+1%>,'FORWARD');">
                        </td>
                        <td class="TDPageChangeNew" width="35px">
                            <input type="button" id="btnPageLast" name="btnPageLast" value=">|" class="InputButtonPageChange"
                                onclick="javascript:go(<%=m_intPageCount%>,'FORWARD');">
                        </td>
                        <td class="TDPageChangeNew">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <script type="text/javascript" language="javascript">window.status="";</script>

    </form>
</body>
</html>
