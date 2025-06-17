<%@ Page Title="" Language="C#" MasterPageFile="~/BranchDashboard.Master" AutoEventWireup="true" CodeBehind="viewBranches.aspx.cs" Inherits="task1.viewBranches" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--link the css page--%>
    <link rel="stylesheet" type="text/css" href="ViewStyle.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--header has three bottons add, view, delete--%>
    <div class="header">
        <h1>Branch Administration</h1>
        <asp:Button runat="server" CssClass="h_btn" Text="Add Branch" ID="add_btn" PostBackUrl="~/AddBranch.aspx" />
        <asp:Button ID="del_btn" CssClass="h_btn" runat="server" Text="delete Branch" PostBackUrl="~/DeleteBranch.aspx" />
    </div>

    <div class="container">

        <%--the side bar is for searching a specific field--%>
        <div class="aside">
            <h2>Search for a Branch</h2>
            <asp:TextBox ID="txt_srch_id" runat="server" placeholder="search by id"></asp:TextBox>
            <asp:TextBox ID="txt_srch_name" runat="server" placeholder="search by name"></asp:TextBox>
            <asp:TextBox ID="txt_srch_city" runat="server" placeholder="search by city"></asp:TextBox>
            <asp:TextBox ID="txt_srch_manager_id" runat="server" placeholder="search by manager id"></asp:TextBox>
            <asp:TextBox ID="txt_srch_address" runat="server" placeholder="search by address"></asp:TextBox>
            <asp:TextBox ID="txt_srch_pro" runat="server" placeholder="search by province"></asp:TextBox>
            <asp:TextBox ID="txt_srch_status" runat="server" placeholder="search by status"></asp:TextBox>
            <asp:Button ID="btn_srch" CssClass="s_btn" runat="server" Text="search" OnClick="btn_srch_Click" />
        </div>

        <%--the main class has a gridview to display fields with options to select and edit a branch and download the brochure--%>
        <div class="main">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="branch_id" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

                <Columns>
                    <asp:CommandField ShowEditButton="True" ShowSelectButton="True" /> <%--enable the edit and select button--%>
                    <asp:BoundField DataField="branch_id" HeaderText="branch_id" ReadOnly="True" SortExpression="branch_id" />
                    <asp:BoundField DataField="branch_name" HeaderText="branch_name" SortExpression="branch_name" />
                    <asp:BoundField DataField="province" HeaderText="province" SortExpression="province" />
                    <asp:BoundField DataField="city" HeaderText="city" SortExpression="city" />
                    <asp:BoundField DataField="address" HeaderText="address" SortExpression="address" />
                    <asp:BoundField DataField="upload_file" HeaderText="upload_file" SortExpression="upload_file" />
                    <asp:BoundField DataField="manager_id" HeaderText="manager_id" SortExpression="manager_id" />
                    <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />

                    <%--template button to download a file--%>
                    <asp:TemplateField HeaderText="download_file">
                        <ItemTemplate>
                            <asp:Button ID="btnDownload" runat="server" Text="Download" CommandName="Download" CommandArgument='<%# Eval("upload_file") %>' OnClick="btnDownload_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
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

            <%-- data source is from the ms sql database --%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BANK_DBConnectionString7 %>" SelectCommand="SELECT * FROM [BRANCH]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [BRANCH] WHERE [branch_id] = @original_branch_id AND [branch_name] = @original_branch_name AND [province] = @original_province AND [city] = @original_city AND [address] = @original_address AND (([upload_file] = @original_upload_file) OR ([upload_file] IS NULL AND @original_upload_file IS NULL)) AND (([manager_id] = @original_manager_id) OR ([manager_id] IS NULL AND @original_manager_id IS NULL)) AND [status] = @original_status" InsertCommand="INSERT INTO [BRANCH] ([branch_id], [branch_name], [province], [city], [address], [upload_file], [manager_id], [status]) VALUES (@branch_id, @branch_name, @province, @city, @address, @upload_file, @manager_id, @status)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [BRANCH] SET [branch_name] = @branch_name, [province] = @province, [city] = @city, [address] = @address, [upload_file] = @upload_file, [manager_id] = @manager_id, [status] = @status WHERE [branch_id] = @original_branch_id AND [branch_name] = @original_branch_name AND [province] = @original_province AND [city] = @original_city AND [address] = @original_address AND (([upload_file] = @original_upload_file) OR ([upload_file] IS NULL AND @original_upload_file IS NULL)) AND (([manager_id] = @original_manager_id) OR ([manager_id] IS NULL AND @original_manager_id IS NULL)) AND [status] = @original_status">
                
                <%-- manage the update row command --%>
                <DeleteParameters>
                    <asp:Parameter Name="original_branch_id" Type="Int32" />
                    <asp:Parameter Name="original_branch_name" Type="String" />
                    <asp:Parameter Name="original_province" Type="String" />
                    <asp:Parameter Name="original_city" Type="String" />
                    <asp:Parameter Name="original_address" Type="String" />
                    <asp:Parameter Name="original_upload_file" Type="String" />
                    <asp:Parameter Name="original_manager_id" Type="Int32" />
                    <asp:Parameter Name="original_status" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="branch_id" Type="Int32" />
                    <asp:Parameter Name="branch_name" Type="String" />
                    <asp:Parameter Name="province" Type="String" />
                    <asp:Parameter Name="city" Type="String" />
                    <asp:Parameter Name="address" Type="String" />
                    <asp:Parameter Name="upload_file" Type="String" />
                    <asp:Parameter Name="manager_id" Type="Int32" />
                    <asp:Parameter Name="status" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="branch_name" Type="String" />
                    <asp:Parameter Name="province" Type="String" />
                    <asp:Parameter Name="city" Type="String" />
                    <asp:Parameter Name="address" Type="String" />
                    <asp:Parameter Name="upload_file" Type="String" />
                    <asp:Parameter Name="manager_id" Type="Int32" />
                    <asp:Parameter Name="status" Type="String" />
                    <asp:Parameter Name="original_branch_id" Type="Int32" />
                    <asp:Parameter Name="original_branch_name" Type="String" />
                    <asp:Parameter Name="original_province" Type="String" />
                    <asp:Parameter Name="original_city" Type="String" />
                    <asp:Parameter Name="original_address" Type="String" />
                    <asp:Parameter Name="original_upload_file" Type="String" />
                    <asp:Parameter Name="original_manager_id" Type="Int32" />
                    <asp:Parameter Name="original_status" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
