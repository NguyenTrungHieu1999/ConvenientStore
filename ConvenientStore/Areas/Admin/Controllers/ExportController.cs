using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML.Excel;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using ConvenientStore.Models;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class ExportController : Controller
    {
        // GET: Admin/Export
        public ActionResult Index()
        {
            var model = new BillData().ListAll();
            ViewBag.Name = new UserData().ListAll();
            return View(model);
        }
        public DataTable ToDataTable<T>(List<T> items)

        {

            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties

            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);

            foreach (PropertyInfo prop in Props)

            {

                //Setting column names as Property names

                dataTable.Columns.Add(prop.Name);

            }

            foreach (T item in items)

            {

                var values = new object[Props.Length];

                for (int i = 0; i < Props.Length; i++)

                {

                    //inserting property values to datatable rows

                    values[i] = Props[i].GetValue(item, null);

                }

                dataTable.Rows.Add(values);

            }

            //put a breakpoint here and check datatable

            return dataTable;

        }
        public ActionResult ExportToExcel()
        {
            var model = new BillData().ExportExcel();
            //var excel = model.Select(x => new { x.billID,x.name,x.createDate,x.totalMoney,x.billStatus,x.address,x.creditCard});
            foreach (var item in model)
            {
                switch (item.status)
                {
                    case 0:
                        item.billStatus = "Chờ xác nhận";
                        break;
                    case 1:
                        item.billStatus = "Chờ lấy hàng";
                        break;
                    case 2:
                        item.billStatus = "Đang giao";
                        break;
                    case 3:
                        item.billStatus = "Đã giao";
                        break;
                    case 4:
                        item.billStatus = "Đã hủy";
                        break;
                    case 5:
                        item.billStatus = "Trả hàng/Hoàn tiền";
                        break;
                }
            }
            DataTable dt = ToDataTable(model);
            dt.Columns.RemoveAt(1);
            dt.Columns.RemoveAt(4);
            dt.Columns[0].ColumnName = "Mã hóa đơn";
            dt.Columns[1].ColumnName = "Tên khách hàng";
            dt.Columns[2].ColumnName = "Ngày mua";
            dt.Columns[3].ColumnName = "Tổng tiền";
            dt.Columns[4].ColumnName = "Tình trạng";
            dt.Columns[5].ColumnName = "Địa chỉ";
            dt.Columns[6].ColumnName = "Số thẻ tín dụng";
            //Name of File
            string fileName = "HoaDon.xlsx";
            using (XLWorkbook wb = new XLWorkbook())
            {
                //Add DataTable in worksheet
                wb.Worksheets.Add(dt);
                using (MemoryStream stream = new MemoryStream())
                {
                    wb.SaveAs(stream);
                    //Return xlsx Excel File
                    return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
                }
            }
        }
    }
}