using System;
using System.Collections;
using Benq.Flower.UtilityShell; using BenQGuru.GAIA;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Benq.Flower.Facade;

using Benq.Flower.SystemFramework.Table;
using Benq.Flower.Web;
using Benq.Flower.Web.Component;

namespace Benq.Flower.Web.Application
{
	/// <summary>
	/// Summary description for Application.
	/// </summary>
	public partial class Application :Component.PageBase
	{
		#region �Զ��x?��
		protected bool m_bolDeep=false;
		protected int m_intRows=0;
		protected int m_intPage=1;
		protected int m_intTotalCount=0;
		protected int m_intPageCount=0;
		protected string m_strApp_Emp_ID=null ;
		protected string m_strFormKind="";
		protected string m_serchFormName = string.Empty;
		protected DataSet m_datasetFunctionList=null;
		protected DataSet m_datasetFormList=null;
		protected string m_Region = "";
		protected System.Web.UI.WebControls.TextBox hdnFormKind;
        protected string m_queryCondition = "";
		#endregion

		protected void Page_Load(object sender, System.EventArgs e)
		{
            m_Region = this.LogonRegion;
			m_strApp_Emp_ID = this.LogonId;
            m_queryCondition = this.txtQuery.Value.Trim();
			if(IsPostBack)
			{
				string strFormKind=Request.Form["hdnFormKind"];
				m_strFormKind=strFormKind;
				m_serchFormName = Request.Form["inputFormName"];
			}
			if(m_strFormKind == null || m_strFormKind == string.Empty)
			{
				m_strFormKind = "ALL";
			}
			if(m_serchFormName == null || m_serchFormName == string.Empty)
			{
				m_serchFormName = "ALL";
			}
			LoadFunctionList();
		}

		#region �Զ��x����
		private void LoadFunctionList()
		{
			if (Request.Form.Count>0)
			{
				m_intPage=int.Parse(Request.Form["CurrentPage"]);
			}
			else
				m_intPage=1;
			if(m_intPage<1) 
				m_intPage=1;
            
			ApplicationFacade appFacade = new ApplicationFacade();
			if (m_strFormKind=="")
			{
                m_datasetFunctionList = appFacade.GetApplicationList(m_intPage, System.Convert.ToInt32(CookiesNaming.ROWS_PER_PAGE_SERVICE), out m_intTotalCount, m_strApp_Emp_ID, m_Region, m_queryCondition);
			}
			else
			{
                m_datasetFunctionList = appFacade.GetApplicationListByFormKind(m_strFormKind, m_intPage, System.Convert.ToInt32(CookiesNaming.ROWS_PER_PAGE_SERVICE), out m_intTotalCount, m_strApp_Emp_ID, m_Region, m_queryCondition);
			}
            m_intPageCount = (m_intTotalCount - 1) / System.Convert.ToInt32(CookiesNaming.ROWS_PER_PAGE_SERVICE) + 1;
			m_intPage=m_intPage>m_intPageCount?m_intPageCount:m_intPage;
			this.DataBind();
		}
		#endregion

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{ 			
		}
		#endregion
	}
}
