using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ToDoList
{
    public partial class Login : System.Web.UI.Page
    {
        private int loginresult; 

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (TxtUsername.Text != string.Empty && TxtPassword.Text != string.Empty)
            {
                MySQL CheckSQLLogin = new MySQL(StaticVariables.ConnectionString);
                loginresult = CheckSQLLogin.CheckUserLogin(TxtUsername.Text, TxtPassword.Text);

                if (loginresult == 0)
                {
                   //error no matches 
                }
                else
                {
                    Session[ID] = loginresult;
                    Response.Redirect("ToDoPage.aspx");
                }
            }





        }

    }
}