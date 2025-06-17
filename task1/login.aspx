<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="task1.WebForm1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <%--link the css page--%>
    <link rel="stylesheet" type="text/css" href="/loginStyle.css">
</head>

<body>
    <form id="form1" runat="server">
        <%--Container for login box--%>
        <div class="container">

            <h1 class="text-center">Log-in</h1>

            <div class="form-group">

                <label for="txt_username">Username</label>
                <asp:TextBox ID="txt_username" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>

                <%--validate if the user has entered to username--%>
                <asp:RequiredFieldValidator ID="req_val_username" runat="server" ErrorMessage="Enter your username" ControlToValidate="txt_username" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">

                <label for="txt_password">Password</label>
                <asp:TextBox ID="txt_password" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password"></asp:TextBox>

                <%--validate if the user has entered to password--%>
                <asp:RequiredFieldValidator ID="req_val_password" runat="server" ErrorMessage="Enter your password" ControlToValidate="txt_password" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            
            <%--login button--%>
            <asp:Button ID="btn_login" runat="server" Text="Login" CssClass="btn" OnClick="btn_login_Click" />
            
            <p>
                <%--data source is form the database in ms sql server--%>
                <asp:SqlDataSource ID="SqlDataSourse1" runat="server" ConnectionString="<%$ ConnectionStrings:BankConnectionString %>" SelectCommand="SELECT * FROM [bank_users]"></asp:SqlDataSource>

            </p>
        </div>
    </form>
</body>
</html>
