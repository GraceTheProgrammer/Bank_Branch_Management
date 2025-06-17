using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace task1
{
    public partial class AddBranch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in by verifying the session variable
            if (Session["username"] == null)
            {
                // User is not logged in, redirect to the login page
                Response.Redirect("./Login.aspx");
            }
            else
            {
                // Retrieve the role ID from the session
                int roleid = Convert.ToInt32(Session["roleid"]);

                // Check if the role ID is 8 (Employee) and hide the delete button if true
                if (roleid == 8)
                {
                    Response.Redirect("./Login.aspx");
                }
            }
        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            {
                try
                {
                    string constr = ConfigurationManager.ConnectionStrings["BANK_DBConnectionString2"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(constr))
                    {
                        con.Open();

                        // Get the next branch_id
                        int nextBranchId = GetNextBranchId(con);

                        string insert_Query = "INSERT INTO dbo.BRANCH (branch_id,branch_name,province,city,address,upload_file,manager_id,status) values (@branch_id,@branch_name,@province,@city,@address,@upload_file,@manager_id,@status)";
                        SqlCommand cmd = new SqlCommand(insert_Query, con);

                        // Create and prepare an SQL statement.
                        cmd.Prepare();
                        cmd.Parameters.AddWithValue("@branch_id", nextBranchId);
                        cmd.Parameters.AddWithValue("@branch_name", txt_bname.Text.Trim());
                        cmd.Parameters.AddWithValue("@province", ddl_province.Text.Trim());
                        cmd.Parameters.AddWithValue("@city", txt_city.Text.Trim());
                        cmd.Parameters.AddWithValue("@address", txt_address.Text.Trim());
                        cmd.Parameters.AddWithValue("@manager_id", txt_mid.Text.Trim());
                        cmd.Parameters.AddWithValue("@status", ddl_status.Text.Trim());
                        // Handle file upload
                        if (fup_bfile.HasFile)
                        {
                            // Define the target directory
                            string targetDir = Server.MapPath("~/UploadedFiles/");

                            // Check if the directory exists, if not, create it
                            if (!Directory.Exists(targetDir))
                            {
                                Directory.CreateDirectory(targetDir);
                            }

                            // Save file to the specified location
                            string fileName = fup_bfile.FileName; // Store only the file name
                            string filePath = Path.Combine(targetDir, fileName);
                            fup_bfile.SaveAs(filePath);
                            cmd.Parameters.AddWithValue("@upload_file", fileName); // Pass only the file name
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@upload_file", DBNull.Value); // Handle case where no file is uploaded
                        }


                        // Call Prepare after setting Parameters.
                        cmd.ExecuteNonQuery();

                        Response.Write("Branch registered Successfully!!!");

                        con.Close();

                        GridView1.DataBind();  // refresh gridview after every insert command automatically
                        ClearAllText(this);   // call method for clear all textbox
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("error" + ex.ToString());
                }
            }

            //get the next branch id from the database
            int GetNextBranchId(SqlConnection con)
            {
                string query = "SELECT ISNULL(MAX(branch_id), 0) + 1 FROM dbo.BRANCH";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    return (int)cmd.ExecuteScalar();
                }
            }

            // clear all textbox
            void ClearAllText(Control con)
            {
                foreach (Control c in con.Controls)
                {
                    if (c is TextBox)
                        ((TextBox)c).Text = string.Empty;
                    else
                        ClearAllText(c);
                }
            }
        }

        
    }
}