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
    public partial class DeleteBranch : System.Web.UI.Page
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

        protected void btn_srch_Click(object sender, EventArgs e)
        {
            // Clear previous parameters
            SqlDataSource1.SelectParameters.Clear();

            // Build the SQL query dynamically based on filled fields
            string query = "SELECT * FROM [BRANCH] WHERE 1=1"; // Start with a base query

            // Check each textbox and append to the query
            if (!string.IsNullOrWhiteSpace(txt_srch_id.Text))
            {
                query += " AND [branch_id] = @branch_id";
                SqlDataSource1.SelectParameters.Add("branch_id", txt_srch_id.Text.Trim());
            }

            if (!string.IsNullOrWhiteSpace(txt_srch_name.Text))
            {
                query += " AND [branch_name] LIKE '%' + @branch_name + '%'";
                SqlDataSource1.SelectParameters.Add("branch_name", txt_srch_name.Text.Trim());
            }

            if (!string.IsNullOrWhiteSpace(txt_srch_address.Text))
            {
                query += " AND [address] LIKE '%' + @address + '%'";
                SqlDataSource1.SelectParameters.Add("address", txt_srch_address.Text.Trim());
            }

            if (!string.IsNullOrWhiteSpace(txt_srch_city.Text))
            {
                query += " AND [city] LIKE '%' + @city + '%'";
                SqlDataSource1.SelectParameters.Add("city", txt_srch_city.Text.Trim());
            }

            if (!string.IsNullOrWhiteSpace(txt_srch_pro.Text))
            {
                query += " AND [province] LIKE '%' + @province + '%'";
                SqlDataSource1.SelectParameters.Add("province", txt_srch_pro.Text.Trim());
            }

            if (!string.IsNullOrWhiteSpace(txt_srch_manager_id.Text))
            {
                query += " AND [manager_id] = @manager_id";
                SqlDataSource1.SelectParameters.Add("manager_id", txt_srch_manager_id.Text.Trim());
            }

            if (!string.IsNullOrWhiteSpace(txt_srch_status.Text))
            {
                query += " AND [status] LIKE '%' + @status + '%'";
                SqlDataSource1.SelectParameters.Add("status", txt_srch_status.Text.Trim());
            }

            // Set the constructed query to the SqlDataSource
            SqlDataSource1.SelectCommand = query;

            // Rebind the GridView to reflect the search results
            try
            {
                GridView1.DataBind();
                GridView1.Visible = true;
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., log them or show a message)
                Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
            }
        }



        protected void btnDownload_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string fileName = btn.CommandArgument; // Get the file name from CommandArgument

            if (!string.IsNullOrEmpty(fileName))
            {
                // Construct the file path from the database or a specific folder
                string filePath = Server.MapPath("~/UploadedFiles/" + fileName); // Adjust the path as necessary

                if (File.Exists(filePath))
                {
                    Response.Clear();
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
                    Response.TransmitFile(filePath);
                    Response.End();
                }
                else
                {
                    // Handle file not found scenario
                    Response.Write("<script>alert('File not found.');</script>");
                }
            }
        }
    }
}