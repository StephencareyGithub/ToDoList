<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ToDoList.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width:400px; height:400px; margin-left:40%">
                  <tr style="height:100px">
                      <td style="width:10%"></td>
                    <td>
                        <p style="font-size:35px;">Login</p>
                    </td>
                      <td style="width:35%"></td>
                </tr>
                <tr style="height:100px">
                    <td>
                        <p>Username</p>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="TxtUsername"></asp:TextBox>
                    </td>
                </tr>
                 <tr style="height:100px">
                    <td>
                        <p>Password</p>
                    </td>
                    <td>
                         <asp:TextBox runat="server" ID="TxtPassword"></asp:TextBox>
                    </td>
                </tr>
                 <tr style="height:100px">
                    <td>
                        <asp:Button runat="server" text="Login" style="height:30px; width:80px" onclick="btnLogin_Click"/>
                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
