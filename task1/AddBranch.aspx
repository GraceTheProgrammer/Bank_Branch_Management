<%@ Page Title="" Language="C#" MasterPageFile="~/BranchDashboard.Master" AutoEventWireup="true" CodeBehind="AddBranch.aspx.cs" Inherits="task1.AddBranch" %>

<%--web forms with master page--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--link the css page--%>
     <link rel="stylesheet" type="text/css" href="ViewStyle.css">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="header">
        <h1>Branch Administration</h1>
    </div>

    <div class="container">

       <%-- add a branch form is in the side bar--%>
       <%--the branch id is automatically inserted to the database using a counter--%>
        <div class="aside">
            <h2 class="text-center">Add Branch</h2>

            <%--enter the branch name using a text box--%>
            <div class="form-group">
                <label>Branch Name</label>
                <asp:TextBox ID="txt_bname" runat="server" placeholder="Enter branch name"></asp:TextBox>

                <%--required field validator and regular expression validator the name should start with a letter and contain only letters and numbers--%>
                <asp:RequiredFieldValidator ID="req_val_bname" runat="server" ErrorMessage="Enter branch name" ControlToValidate="txt_bname" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="re_bname" runat="server" ErrorMessage="Branch name should start with a letter" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^[A-Za-z][A-Za-z0-9 ]*$" ControlToValidate="txt_bname"></asp:RegularExpressionValidator>
            </div>

            <%--enter the branch province using the drop down list--%>
            <div class="form-group">
                <label>Province</label>
                <asp:DropDownList ID="ddl_province" runat="server">
                    <asp:ListItem>Damascus</asp:ListItem>
                    <asp:ListItem>Aleppo</asp:ListItem>
                    <asp:ListItem>Homs</asp:ListItem>
                    <asp:ListItem>Lattakia</asp:ListItem>
                    <asp:ListItem>Tartus</asp:ListItem>
                    <asp:ListItem>Hama</asp:ListItem>
                    <asp:ListItem>Raqa</asp:ListItem>
                    <asp:ListItem>Dier Alzor</asp:ListItem>
                    <asp:ListItem>Hasaka</asp:ListItem>
                    <asp:ListItem>Sweida</asp:ListItem>
                    <asp:ListItem>Daraa</asp:ListItem>
                    <asp:ListItem>Qunietra</asp:ListItem>
                    <asp:ListItem>Idlib</asp:ListItem>
                    <asp:ListItem>Damascus_Suburb</asp:ListItem>
                    <asp:ListItem Selected="True">Select Province</asp:ListItem>
                </asp:DropDownList>

                <asp:RequiredFieldValidator ID="req_val_pro" runat="server" ErrorMessage="select province" ControlToValidate="ddl_province" InitialValue="Select Province" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>

            </div>

            <%--enter the city of the branch using text box--%>
            <div class="form-group">
                <label>City</label>
                <asp:TextBox ID="txt_city" runat="server" placeholder="Enter the city where the branch is located"></asp:TextBox>

                <asp:RequiredFieldValidator ID="req_val_city" runat="server" ErrorMessage="enter city" ControlToValidate="txt_city" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>

            <%--enter the address of the branch using text box--%>
            <div class="form-group">
                <label>Address</label>
                <asp:TextBox ID="txt_address" runat="server" placeholder="Enter the address of the branch"></asp:TextBox>

                <asp:RequiredFieldValidator ID="req_val_address" runat="server" ControlToValidate="txt_address" ErrorMessage="enter address" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>


            <%--upload the branch brochure --%>
            <div class="form-group">
                <label for="fup_bfile">Branch Brochure</label>
                <asp:FileUpload ID="fup_bfile" runat="server" />
            </div>

            <%--enter the manager id using text box--%>
            <div class="form-group">
                <label>Manager ID</label>
                <asp:TextBox ID="txt_mid" runat="server" placeholder="Enter the id of the manager of the branch"></asp:TextBox>

                <%--required field validator and regular expression validator, the manager id should be an integer--%>
                <asp:RequiredFieldValidator ID="req_val_mid" runat="server" ErrorMessage="enter manager ID" ControlToValidate="txt_mid" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="rev_mid" runat="server" ErrorMessage="Manager ID should be an integer" Font-Size="X-Small" ForeColor="Red" ControlToValidate="txt_mid" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </div>

            <%--status is added using drop down list--%>
            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddl_status" runat="server">
                    <asp:ListItem Selected="True">Active</asp:ListItem>
                    <asp:ListItem>Inactive</asp:ListItem>
                </asp:DropDownList>
            </div>

            <%--add button--%>
            <asp:Button ID="btn_add" runat="server" Text="Add" CssClass="btn" OnClick="btn_add_Click" />
            <br />
        </div>

        <%--the main class shows the gridview to view the branches it refreshes automatically to show the new added branch, the gridview format is "professional"--%>
        <div class="main">

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="branch_id" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="branch_id" HeaderText="branch_id" ReadOnly="True" SortExpression="branch_id" />
                    <asp:BoundField DataField="branch_name" HeaderText="branch_name" SortExpression="branch_name" />
                    <asp:BoundField DataField="province" HeaderText="province" SortExpression="province" />
                    <asp:BoundField DataField="city" HeaderText="city" SortExpression="city" />
                    <asp:BoundField DataField="address" HeaderText="address" SortExpression="address" />
                    <asp:BoundField DataField="upload_file" HeaderText="upload_file" SortExpression="upload_file" />
                    <asp:BoundField DataField="manager_id" HeaderText="manager_id" SortExpression="manager_id" />
                    <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>

            <%--the data source is the ms sql server database--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BANK_DBConnectionString2 %>" SelectCommand="SELECT * FROM [BRANCH]"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
