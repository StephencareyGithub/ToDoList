using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ToDoList
{
    public partial class ToDoPage : System.Web.UI.Page
    {
        private int ItemToEdit;
        private int ItemToDelete;
        List<AList> Mylist = new List<AList>();
        public AList Currentlist;
        MySQL mysql;
        AList mynewitem = new AList();

        protected void Page_Load(object sender, EventArgs e)
        {
            mysql = new MySQL(StaticVariables.ConnectionString);
            LoadSQLTable();

        }

        public void LoadSQLTable()
        {
            Mylist = mysql.ReturnList(Convert.ToInt32(Session[ID]));

            using (SqlConnection con = new SqlConnection(StaticVariables.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ItemID, IsComplete, Description, DateTimeChanged FROM ToDoTable WHERE LoginID = '" + Session[ID].ToString() + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            ToDoGridView.DataSource = dt;
                            ToDoGridView.DataBind();
                        }
                    }
                }
            }
        }


        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow clickedRow = ((LinkButton)sender).NamingContainer as GridViewRow;
                ItemToEdit = Convert.ToInt32(clickedRow.Cells[0].Text.ToString());

                foreach (AList item in Mylist)
                {
                    if (item.ItemID == ItemToEdit)
                    {
                        EditTable.Visible = Visible;
                        EditLblItemID.Text = item.ItemID.ToString();
                        EditLblLoginID.Text = item.LoginID.ToString();
                        if (item.IsComplete == "false")
                        {
                            RbtnIsComplete.Checked = false;
                            RbtnIsComplete.Text = "Not complete";
                        }
                        else if (item.IsComplete == "true")
                        {
                            RbtnIsComplete.Checked = true;
                            RbtnIsComplete.Text = "Completed";
                        }
                        EditTxtDescription.Text = item.Description;
                        EditLblLastEdit.Text = item.LAstEdit.ToString();
                    }
                }
            }
            catch(Exception ex)
            {
                ex.ToString();
            }

        }

        protected void BtnEditComplete_Click(object sender, EventArgs e)
        {
            try
            {
                AList Item = new AList();
                Item.ItemID = Convert.ToInt32(EditLblItemID.Text);
                Item.LoginID = Convert.ToInt32(EditLblLoginID.Text);

                if (RbtnIsComplete.Checked == true)
                    Item.IsComplete = "true";
                else
                    Item.IsComplete = "false";

                Item.Description = EditTxtDescription.Text;
                Item.LAstEdit = DateTime.Now;

                bool result = mysql.UpdateRow(Item);

                LoadSQLTable();

                if (!result)
                {
                    ErrorTextbox.Text = "Error updating To Do List";
                    ErrorTextbox.BackColor = Color.Red;
                }
                else
                {
                    ErrorTextbox.Text = "Update successful";
                    ErrorTextbox.BackColor = Color.Green;
                    EditTable.Visible = false;
                }

            }
            catch
            {

            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            AddItemTable.Visible = Visible;

            mynewitem.ItemID = mysql.GetMaxItem(Convert.ToInt32(Session[ID]));
            LblAdditemItemID.Text = mynewitem.ItemID.ToString();

            mynewitem.LoginID = Convert.ToInt32(Session[ID]);
            LblAdditemLoginID.Text = mynewitem.LoginID.ToString();

            RbtAdditemIsComplete.Checked = false;
            RbtAdditemIsComplete.Text = "Not complete";

            lbladditemdescription.Text = mynewitem.LAstEdit.ToString();
        }

        protected void Addnewitem_Click(object sender, EventArgs e)
        {
            try
            {
                mynewitem.Description = TxtAdditemDescription.Text;
                mynewitem.LAstEdit = DateTime.Now;
                mynewitem.ItemID = mysql.GetMaxItem(Convert.ToInt32(Session[ID]));
                mynewitem.LoginID = Convert.ToInt32(Session[ID]);

                if (RbtAdditemIsComplete.Checked == false)
                {
                    mynewitem.IsComplete = "false";
                }
                else
                {
                    mynewitem.IsComplete = "true";
                }

                mysql.AddNewRow(mynewitem);

                LoadSQLTable();

                ErrorTextbox.Text = "New item added to list";
                ErrorTextbox.BackColor = Color.Green;
                AddItemTable.Visible = false;
            }
            catch
            {
                ErrorTextbox.Text = "Error adding row to List";
                ErrorTextbox.BackColor = Color.Red;
            }
          
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow clickedRow = ((LinkButton)sender).NamingContainer as GridViewRow;
                ItemToDelete = Convert.ToInt32(clickedRow.Cells[0].Text.ToString());

                bool result = mysql.DeleteRow(ItemToDelete, Convert.ToInt32(Session[ID]));

                if (result == true)
                {
                    LoadSQLTable();

                    ErrorTextbox.Text = "Row deleted";
                    ErrorTextbox.BackColor = Color.Green;
                }
                else
                {
                    ErrorTextbox.Text = "Error deleting item from List";
                    ErrorTextbox.BackColor = Color.Red;
                }
            }
            catch(Exception ex)
            {
                ErrorTextbox.Text = ex.ToString();
                ErrorTextbox.BackColor = Color.Red;
            }

        }
    }
}