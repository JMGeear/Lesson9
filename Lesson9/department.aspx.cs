using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Lesson9.Models;
using System.Web.ModelBinding;

namespace Lesson9
{
    public partial class department : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //if save wasnot clicked and we have a student id
            if (!IsPostBack && (Request.QueryString.Count > 0))
            {
                
                GetDepartment();
            }
        }
        protected void GetDepartment()
        {
            // populate form
            Int32 DepartmentID = Convert.ToInt32(Request.QueryString["DepartmentID"]);
            //Connect
            using (comp2007Entities db = new comp2007Entities())
            {
                Department d = (from objd in db.Departments
                                where objd.DepartmentID == DepartmentID
                                select objd).FirstOrDefault();

                //Map student to controls
                if (d != null)
                {
                    txtDeptName.Text = d.Name;
                    txtBudget.Text = d.Budget.ToString();
                }

                //Courses - this code goes in the same method that populates 
                //the student form but below the existing code that's already in GetDepartment()              
                var objC = (from c in db.Courses
                            select new { c.CourseID, c.Title, c.Department.Name });

                grdcourses.DataSource = objC.ToList();
                grdcourses.DataBind();

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //use EF to connect to SQL Server
            using (comp2007Entities db = new comp2007Entities())
            {

                //use the Student model to save the new record
                Department d = new Department();

                d.Name = txtDeptName.Text;
                d.Budget = Convert.ToDecimal(txtBudget.Text);

                db.Departments.Add(d);
                db.SaveChanges();

                //redirect to the updated students page
                Response.Redirect("departments.aspx");
            }
        }

        protected void grdcourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //get selected course ID
            Int32 CourseID = Convert.ToInt32(grdcourses.DataKeys[e.RowIndex].Values["CourseID"]);

            using (comp2007Entities db = new comp2007Entities())
            {
                //get selected course
                Course objC = (from c in db.Courses
                               where c.CourseID == CourseID
                               select c).FirstOrDefault();

                //delete
                db.Courses.Remove(objC);
                db.SaveChanges();

                //refresh grid
                GetDepartment();
            }
        }



        



    }
}