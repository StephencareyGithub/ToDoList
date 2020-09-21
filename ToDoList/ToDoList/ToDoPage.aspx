<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ToDoPage.aspx.cs" Inherits="ToDoList.ToDoPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link rel="stylesheet" href="MyStyles.css" type="text/css" />
    <title>My To Do List</title>
</head>
<body>
    <form id="form1" runat="server">

          <%--Error list--%>
        <asp:Table runat="server" class="BorderTable">
            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns">
                </asp:TableCell>

                  <asp:TableCell >
                    <asp:Label runat="server" Text="Status Textbox"></asp:Label>
                </asp:TableCell>
                 <asp:TableCell >
                     <asp:TextBox runat="server" ID="ErrorTextbox"></asp:TextBox>
                </asp:TableCell>

                 <asp:TableCell CssClass="MainTableSideCollumns">
                </asp:TableCell>
            </asp:TableRow>

        </asp:Table>
        
        <%--To Do List Table (Header & List view)--%>
        <asp:Table runat="server" CssClass="ToDoMainTable">

             <asp:TableRow>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell CssClass="InnerCell"> <asp:Label runat="server" CssClass="MainLables" Text="Your To Do List"></asp:Label> </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>

                 <asp:TableCell>

                    <asp:GridView ID="ToDoGridView" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                        PageSize="10" CssClass="ToDoListDiv">
                        <Columns>   
                            <asp:BoundField ItemStyle-Width="100px" DataField="ItemID" HeaderText="Item ID" />
                            <asp:BoundField ItemStyle-Width="120px" DataField="IsComplete" HeaderText="Is Completed" />
                            <asp:BoundField ItemStyle-Width="400px" DataField="Description" HeaderText="Description" />
                            <asp:BoundField ItemStyle-Width="150px" DataField="DateTimeChanged" HeaderText="Last Edit"/>
                             <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="BtnEdit" Text="Edit" OnClick="BtnEdit_Click" runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="BtnDelete" Text="Delete" onclick="BtnDelete_Click" runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                 </asp:TableCell>

                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

             <asp:TableRow CssClass="BorderTable">
            </asp:TableRow>

        </asp:Table>

        <asp:Table runat="server" CssClass="ToDoMainTable">
            <asp:TableRow>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                    <asp:TableCell>
                        <asp:Button runat="server" Text="Add new Item" ID="BtnAdd" OnClick="BtnAdd_Click"/>
                    </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>

          <%--Edit List Table--%>
        <asp:Table runat="server" ID="EditTable" CssClass="EditTable" Visible="false">

             <asp:TableRow>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell CssClass="InnerCell"> <asp:Label runat="server" Text="Edit Item"></asp:Label> </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Item ID</p>
                  </asp:TableCell>
                  <asp:TableCell>
                     <asp:Label runat="server" ID="EditLblItemID"></asp:Label>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Login ID</p>
                  </asp:TableCell>
                  <asp:TableCell>
                     <asp:Label runat="server" ID="EditLblLoginID"></asp:Label>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>IsComplete</p>
                  </asp:TableCell>
                  <asp:TableCell>
                      <asp:CheckBox runat="server" text="Not finished" ID="RbtnIsComplete" />
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

             <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Description</p>
                  </asp:TableCell>
                  <asp:TableCell>
                      <asp:TextBox runat="server" ID="EditTxtDescription"></asp:TextBox>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Last edit time</p>
                  </asp:TableCell>
                  <asp:TableCell>
                      <asp:Label runat="server" ID="EditLblLastEdit"></asp:Label>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

             <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumnsWithButton"></asp:TableCell>
                 <asp:TableCell>
                     <asp:Button runat="server" ID="BtnEditComplete" Text="Update" OnClick="BtnEditComplete_Click"/>
                 </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumnsWithButton"></asp:TableCell>
            </asp:TableRow>

        </asp:Table>

          <%--Add List Table--%>
        <asp:Table runat="server" ID="AddItemTable" CssClass="EditTable" Visible="false">

             <asp:TableRow>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell CssClass="InnerCell"> <asp:Label runat="server" Text="Add new Item"></asp:Label> </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Item ID</p>
                  </asp:TableCell>
                  <asp:TableCell>
                     <asp:Label runat="server" ID="LblAdditemItemID"></asp:Label>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Login ID</p>
                  </asp:TableCell>
                  <asp:TableCell>
                     <asp:Label runat="server" ID="LblAdditemLoginID"></asp:Label>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>IsComplete</p>
                  </asp:TableCell>
                  <asp:TableCell>
                      <asp:CheckBox runat="server" text="Not finished" ID="RbtAdditemIsComplete"/>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

             <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Description</p>
                  </asp:TableCell>
                  <asp:TableCell>
                      <asp:TextBox runat="server" ID="TxtAdditemDescription"></asp:TextBox>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
                  <asp:TableCell>
                      <p>Last edit time</p>
                  </asp:TableCell>
                  <asp:TableCell>
                      <asp:Label runat="server" ID="lbladditemdescription"></asp:Label>
                  </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumns"></asp:TableCell>
            </asp:TableRow>

             <asp:TableRow>
                <asp:TableCell CssClass="MainTableSideCollumnsWithButton"></asp:TableCell>
                 <asp:TableCell>
                     <asp:Button runat="server" ID="Addnewitem" Text="Create" OnClick="Addnewitem_Click"/>
                 </asp:TableCell>
                  <asp:TableCell CssClass="MainTableSideCollumnsWithButton"></asp:TableCell>
            </asp:TableRow>

        </asp:Table>












        <div>
          


           
          

        </div>
    </form>
</body>
</html>
