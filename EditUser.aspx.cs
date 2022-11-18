using IntakeSheet.BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditUser : System.Web.UI.Page
{
    DBHelperClass db = new DBHelperClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == null)
            Response.Redirect("Login.aspx");

        if (!IsPostBack)
        {
            GetDesignations();
            if (Request["id"] != null)
            {
                string id = Request.QueryString["id"];
                BindUserDetails(id);
                DataSet ds = db.selectData("select locations_id,page_id from tblUserMaster  where User_ID=" + Request["id"].ToString());

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    Session["chklocations"] = ds.Tables[0].Rows[0][0].ToString();
                    string pages = ds.Tables[0].Rows[0][1].ToString();

                    for (int i = 0; i < chkPages.Items.Count; i++)
                    {
                        if (pages.ToString().Contains(chkPages.Items[i].Value))
                            chkPages.Items[i].Selected = true;
                    }
                }
            }
          
            GetLocations();
            GetReports();
            GetRole();


            if (Request["id"] != null)
            {
               


            }

        }
    }

    protected void BindUserDetails(string userId = null)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connString_V3"].ConnectionString))
        {
            SqlCommand cmd = new SqlCommand("GetAllUser", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtEmail.Text = ds.Tables[0].Rows[0]["eMailID"].ToString();
                txtFirstName.Text = ds.Tables[0].Rows[0]["FirstName"].ToString();
                txtLastName.Text = ds.Tables[0].Rows[0]["LastName"].ToString();
                txtLoginID.Text = ds.Tables[0].Rows[0]["LoginID"].ToString();
                txtMiddleName.Text = ds.Tables[0].Rows[0]["MiddleName"].ToString();
                txtPhoneNo.Text = ds.Tables[0].Rows[0]["Ph_No"].ToString();
                txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                Session["chkreport"] = ds.Tables[0].Rows[0]["reports"].ToString();
                Session["chkrole"] = ds.Tables[0].Rows[0]["role_id"].ToString();
                //  txtDesignation.Text = ds.Tables[0].Rows[0]["Designation"].ToString();

                ddlDesig.ClearSelection();
                if (ds.Tables[0].Rows[0]["desig_id"] != null && ds.Tables[0].Rows[0]["desig_id"].ToString() != "")
                    ddlDesig.Items.FindByValue(ds.Tables[0].Rows[0]["desig_id"].ToString()).Selected = true;
                txtPassowrd.Attributes.Add("value", ds.Tables[0].Rows[0]["Password"].ToString());
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //try
        //{
        string query = "", locations = "", locations_id = "", page_id = "", pages = "",reports="",roleid="";


        for (int i = 0; i < chkLocations.Items.Count; i++)
        {
            if (chkLocations.Items[i].Selected)
            {
                locations = locations + "," + chkLocations.Items[i].Text;
                locations_id = locations_id + "," + chkLocations.Items[i].Value;
            }
        }

        for (int i = 0; i < chkPages.Items.Count; i++)
        {
            if (chkPages.Items[i].Selected)
            {
                pages = pages + "," + chkPages.Items[i].Text;
                page_id = page_id + "," + chkPages.Items[i].Value;
            }
        }

        for (int i = 0; i < chkReports.Items.Count; i++)
        {
            if (chkReports.Items[i].Selected)
            {
                reports = reports + "," + chkReports.Items[i].Text;
        
            }
        }

        for (int i = 0; i < chkRole.Items.Count; i++)
        {
            if (chkRole.Items[i].Selected)
            {
                roleid = roleid + "," + chkRole.Items[i].Value;

            }
        }

        if (Request["id"] != null)
        {
            //query = "update tblUserMaster set LoginID='" + txtLoginID.Text + "',Password='" + txtPassowrd.Text + "',designation='" + ddlDesig.SelectedItem.Text + "',";
            //query = query + " desig_id=" + ddlDesig.SelectedItem.Value + ",FirstName='" + txtFirstName.Text + "',";
            //query = query + " LastName='" + txtLastName.Text + "',MiddleName='" + txtMiddleName.Text + "',";
            //query = query + " page_id='" + page_id.TrimStart(',') + "',pages='" + pages.TrimStart(',') + "',";
            //query = query + " Address='" + txtAddress.Text + "',Ph_No='" + txtPhoneNo.Text + "',";
            //query = query + " eMailID='" + txtEmail.Text + "',locations_id='" + locations_id.TrimStart(',') + "',locations='" + locations.TrimStart(',') + "',reports='" + reports.TrimStart(',') + "',role_id='" + roleid.TrimStart(',') + "' where User_ID=" + Request["id"].ToString();

            query = "update tblUserMaster set LoginID=@loginid,Password=@password,designation=@designation,";
            query = query + " desig_id=@desig_id,FirstName=@firstname,";
            query = query + " LastName=@lastname,MiddleName=@middlename,";
            query = query + " page_id=@page_id,pages=@pages,";
            query = query + " Address=@address,Ph_No=@ph_no,";
            query = query + " eMailID=@emailid,locations_id=@locations_id,locations=@locations,reports=@reports,role_id=@role_id where User_ID=@user_id";

        }
        else
        {
            query = "insert into tblUserMaster(LoginID,Password,Designation,FirstName,LastName,MiddleName,eMailID,Signature,CreatedBy,CreatedDate,desig_id,locations_id,locations,UserMasterId,page_id,pages,reports,role_id,Address,Ph_No) values(@loginid,@password,@designation,@firstname,@lastname,@middlename,@emailid,@signature,@createdby,@createddate,@desig_id,@locations_id,@locations,@usermasterid,@page_id,@pages,@reports,@role_id,@address,@ph_no) ";
        }

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connString_V3"].ConnectionString))
        {
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.CommandType = CommandType.Text;

            cmd.Parameters.AddWithValue("@loginid", txtLoginID.Text);
            cmd.Parameters.AddWithValue("@desig_id", ddlDesig.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@designation", ddlDesig.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@password", txtPassowrd.Text);
            cmd.Parameters.AddWithValue("@firstname", txtFirstName.Text.TrimStart().TrimEnd());
            cmd.Parameters.AddWithValue("@lastname", txtLastName.Text.TrimStart().TrimEnd());
            cmd.Parameters.AddWithValue("@middlename", txtMiddleName.Text);
            cmd.Parameters.AddWithValue("@page_id", page_id.TrimStart(','));
            cmd.Parameters.AddWithValue("@pages", pages.TrimStart(','));
            cmd.Parameters.AddWithValue("@address", txtAddress.Text);
            cmd.Parameters.AddWithValue("@ph_no", txtPhoneNo.Text);
            cmd.Parameters.AddWithValue("@emailid", txtEmail.Text);
            cmd.Parameters.AddWithValue("@locations_id", locations_id.TrimStart(','));
            cmd.Parameters.AddWithValue("@locations", locations.TrimStart(','));
            cmd.Parameters.AddWithValue("@reports", reports.TrimStart(','));
            cmd.Parameters.AddWithValue("@role_id", roleid.TrimStart(','));

            if (Request["id"] != null)
                cmd.Parameters.AddWithValue("@user_id", Request["id"].ToString());
            else
            {
                cmd.Parameters.AddWithValue("@signature", "");
                cmd.Parameters.AddWithValue("@createdby", "admin");
                cmd.Parameters.AddWithValue("@createddate", System.DateTime.Now.ToString());
                cmd.Parameters.AddWithValue("@usermasterid", "ASMPC");

            }


            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

          
        }
        Response.Redirect("ManageUser.aspx");
        //}
        //catch (Exception ex)
        //{
        //}
    }

    public void GetDesignations()
    {
        try
        {
            DataSet ds = db.selectData("select * from tbl_designation");

            ddlDesig.DataSource = ds;
            ddlDesig.DataBind();
        }
        catch (Exception ex)
        {

        }

    }

    public void GetLocations()
    {
        try
        {
            DataSet ds = db.selectData("select * from tblLocations order by Location ASC ");

            chkLocations.DataTextField = "Location";
            chkLocations.DataValueField = "Location_ID";

            chkLocations.DataSource = ds;
            chkLocations.DataBind();

            if (Session["chklocations"] != null)
            {

                for (int i = 0; i < chkLocations.Items.Count; i++)
                {
                    if (Session["chklocations"].ToString().Contains(chkLocations.Items[i].Value))
                        chkLocations.Items[i].Selected = true;
                }
            }
        }
        catch (Exception ex)
        {

        }

    }

    public void GetReports()
    {
        try
        {
            DirectoryInfo rootInfo = new DirectoryInfo(Server.MapPath("~/TemplateStore/"));
            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Name");
            DataRow _dtr = null;
            foreach (DirectoryInfo directory in rootInfo.GetDirectories())
            {
                foreach (FileInfo file in directory.GetFiles())
                {

                    _dtr = dt.NewRow();
                    _dtr["Name"] = file.Name;
                    dt.Rows.Add(_dtr);
                }
            }
            //DataSet ds = db.selectData("select * from tblLocations");

            chkReports.DataTextField = "Name";
            chkReports.DataValueField = "Name";

            //Sorting the Table
            DataView dv = dt.DefaultView;
            dv.Sort = "Name asc";
            DataTable sortedtable1 = dv.ToTable();

            chkReports.DataSource = sortedtable1;
            chkReports.DataBind();

            if (Session["chkreport"] != null)
            {

                for (int i = 0; i < chkReports.Items.Count; i++)
                {
                    if (Session["chkreport"].ToString().Contains(chkReports.Items[i].Value))
                        chkReports.Items[i].Selected = true;
                }
            }
        }
        catch (Exception ex)
        {

        }

    }

    public void GetRole()
    {
        try
        {
            DataSet ds = db.selectData("select * from tblRole");

            chkRole.DataTextField = "RoleName";
            chkRole.DataValueField = "RoleID";

            chkRole.DataSource = ds;
            chkRole.DataBind();

            if (Session["chkrole"] != null)
            {

                for (int i = 0; i < chkRole.Items.Count; i++)
                {
                    if (Session["chkrole"].ToString().Contains(chkRole.Items[i].Value))
                        chkRole.Items[i].Selected = true;
                }
            }
        }
        catch (Exception ex)
        {

        }

    }

}