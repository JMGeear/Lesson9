<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="department.aspx.cs" Inherits="Lesson9.department" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Department Details</h1>
    <h5>All fields are required</h5>

     <fieldset>
        <label for="txtDeptName" class="col-sm-2">Department:</label>
        <asp:TextBox ID="txtDeptName" runat="server" required MaxLength="50" />
    </fieldset>
    <fieldset>
        <label for="txtBudget" class="col-sm-2">Budget:</label>
        <asp:TextBox ID="txtBudget" runat="server" required TextMode="Number" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ErrorMessage="Number required" ControlToValidate="txtBudget" type="currancy"></asp:RequiredFieldValidator>
    </fieldset>

    <div class="col-sm-offset-2">
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary"
             OnClick="btnSave_Click" />
    </div>

    <h2>Courses</h2>
    <asp:gridview ID="grdcourses" runat="server" AutoGenerateColumns="false"
         DataKeyNames="CourseID" OnRowDeleting="grdcourses_RowDeleting"
         CssClass="table table-striped table-hover">
        <Columns>
            <asp:BoundField DataField="CourseID" HeaderText="CourseID" />
            <asp:BoundField DataField="Title" HeaderText="Course" />
            <asp:BoundField DataField="Name" HeaderText="Department" />
                        
            <asp:CommandField ShowDeleteButton="true" DeleteText="Delete" HeaderText="Delete" />
        </Columns>
    </asp:gridview>

    

</asp:Content>
