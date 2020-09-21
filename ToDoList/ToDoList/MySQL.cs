using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ToDoList
{
    public class MySQL
    {
        SqlConnection Conn;
        SqlDataReader dr;
        int result = 0;

        public MySQL(string ConnectionString)
        {
            Conn = new SqlConnection(ConnectionString);
            //keep Conn open. on close of app close it. 
            //could cause bad perfromance if has to be garbage collected
            Conn.Open();
        }

        public int CheckUserLogin(string Username, string Password)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT LoginID FROM Login_Table WHERE Username = '" + Username + "'  AND Password = '" + Password + "'", Conn);

                dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        result = Convert.ToInt32(dr.GetString(0));
                        return result;
                    }
                }
                return result;
            }
            catch
            {
                return result;
            }
            finally
            {
                dr.Close();
            }
           
        }

        public List<AList> ReturnList(int Session)
        {
            try
            {
                List<AList> MyList = new List<AList>();

                using (SqlCommand cmd = new SqlCommand("SELECT * FROM ToDoTable WHERE LoginID = '" + Session + "'"))
                {
                    cmd.Connection = Conn;
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            AList listitem = new AList();
                            listitem.ItemID = Convert.ToInt32(reader.GetValue(0));
                            listitem.LoginID = Convert.ToInt32(reader.GetValue(1));
                            listitem.IsComplete = reader.GetValue(2).ToString();
                            listitem.Description = reader.GetValue(3).ToString();
                            MyList.Add(listitem);

                        }
                        return MyList;
                    }
                } 
            }
            catch(Exception ex)
            {
                ex.ToString();
                return null;
            }
        }

        public bool UpdateRow(AList listitem)
        {
            try
            {
                SqlCommand cmdupdaterow = new SqlCommand("UPDATE ToDoTable SET IsComplete = '" + listitem.IsComplete + "', Description = '" + listitem.Description + "', " +
                    "DateTimeChanged = '" + listitem.LAstEdit + "' WHERE ItemID = '" + listitem.ItemID + "'", Conn);

                cmdupdaterow.ExecuteNonQuery();
                return true;
            }
            catch(Exception ex)
            {
                ex.ToString();
                return false;
            }
        }

        public int GetMaxItem(int loginid)
        {
            try
            {
                SqlCommand cmdgetmaxitem = new SqlCommand("SELECT MAX(ItemID) FROM ToDoTable WHERE LoginID = '" + loginid + "'", Conn);
                int maxid = Convert.ToInt32(cmdgetmaxitem.ExecuteScalar());
                maxid++;
                return maxid;
            }
            catch(Exception ex)
            {
                ex.ToString();
                return 0;
            }
        }

        public bool AddNewRow(AList itemtoadd)
        {
            try
            {
                SqlCommand cmdadditem = new SqlCommand("INSERT INTO ToDoTable (ItemID, LoginID, IsComplete, Description, DateTimeChanged) " +
               "VALUES ('" + itemtoadd.ItemID + "', '" + itemtoadd.LoginID + "', '" + itemtoadd.IsComplete + "', '" + itemtoadd.Description + "',   " +
               "'" + itemtoadd.LAstEdit + "')", Conn);

                cmdadditem.ExecuteNonQuery();

                return true;
            }
            catch(Exception ex)
            {
                ex.ToString();
                return false;
            }
           
        }

        public bool DeleteRow(int Rowtodelete, int Loginid)
        {
            try
            {
                SqlCommand cmdDeleterow = new SqlCommand("DELETE FROM ToDoTable WHERE ItemID = '" + Rowtodelete + "' AND LoginID = '" + Loginid + "'", Conn);

                cmdDeleterow.ExecuteNonQuery();

                return true;
            }
            catch(Exception ex)
            {
                ex.ToString();
                return false;
            }
        }


    }
}