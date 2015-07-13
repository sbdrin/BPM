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

using System.IO;
namespace Benq.Flower.Web.Application
{
    /// <summary>
    /// Summary description for FormApp.
    /// </summary>
    public partial class FormApp : Component.PageBase
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {
            string strFunctionPath = Request.QueryString["FunctionName"];
            string strURL;
            if (Request.QueryString["IsGlobal"].ToUpper() == "Y")
                strURL = strFunctionPath;
            else
                strURL = GetCallAppUrl(strFunctionPath);
            if (!String.IsNullOrEmpty(strURL))
            {
                Response.Redirect(strURL);
            }
            else
            {
                Response.Write("No form application");
            }
        }

        private string GetCallAppUrl(string p_strFunctionPath)
        {
            if (!File.Exists(Global.GetPhysicalAppPath() + p_strFunctionPath))
            {
                return null;
            }
            else
                return "..\\" + p_strFunctionPath + "?" + Request.QueryString.ToString();
        }        
    }
}
