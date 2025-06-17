using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace task1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //function called when we click on the login page
        protected void btn_login_Click(object sender, EventArgs e)
        {
            try
            {
                //connect the database in ms sql server
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BANK_DBConnectionString2"].ConnectionString))
                {
                    conn.Open();

                    
                    //query to get the role_id and departement_id of the user loging in to redirect them to appropriate page
                    string select_Query = @"
                SELECT ROLE.role_id, PERSONAL_INFORMATION.department_id 
                FROM ROLE 
                INNER JOIN PERSONAL_INFORMATION ON ROLE.role_id = PERSONAL_INFORMATION.role_id 
                INNER JOIN [USER] ON PERSONAL_INFORMATION.user_id = [USER].user_id 
                WHERE [USER].username = @username 
                AND [USER].password = @password 
                AND [USER].status = 'Active'";

                    SqlCommand cmd = new SqlCommand(select_Query, conn);

                    // Use parameters to prevent SQL injection
                    cmd.Parameters.AddWithValue("@username", txt_username.Text.Trim());
                    cmd.Parameters.AddWithValue("@password", txt_password.Text.Trim());

                    SqlDataReader sdrr = cmd.ExecuteReader();

                    if (sdrr.Read())
                    {
                       
                        //store both username and roleid in the session
                        Session["username"] = txt_username.Text.Trim();
                        

                        int roleid = Convert.ToInt32(sdrr["role_id"]);
                        int departmentId = Convert.ToInt32(sdrr["department_id"]);

                        //we store the roleid as well so that if the user is an employee we hide certain items
                        Session["roleid"] = roleid;

                        // Redirect based on role and department
                        if ((roleid == 8 || roleid == 9) && departmentId == 4 ) // Employee or Manager from Branch Management
                        {
                            Response.Redirect("./viewBranches.aspx");
                        }
                        else
                        {
                            Response.Redirect("./home.aspx");
                        }
                    }
                    else
                    {
                        displayAlertBox("Email or password are wrong");
                    }
                }
            }
            // we specify two types of errors database error and any other type of error
            catch (SqlException sqlEx)
            {
                displayAlertBox("Database error: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                displayAlertBox("Error: " + ex.Message);
            }
        }

        // Display Alert Box function
        public void displayAlertBox(string msg)
        {
            string message = msg;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type='text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }
    }
}
