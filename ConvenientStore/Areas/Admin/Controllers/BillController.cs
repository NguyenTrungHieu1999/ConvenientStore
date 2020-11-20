using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using ConvenientStore.Models;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class BillController : BaseController
    {
        ConvenientStoreDBContext db = null;
        public BillController()
        {
            db = new ConvenientStoreDBContext();
        }

        // GET: Admin/Bill
        public ActionResult Index(string searchString, int page = 1, int pageSize = 4)
        {
            var data = new BillData();
            var model = data.ListAllBill(searchString, page, pageSize);
            ViewBag.Bill = data.ListAll();
            ViewBag.User = new UserData().ListAll();
            ViewBag.SearchString = searchString;
            return View(model);
        }
        [HttpPost]
        public JsonResult ChangeStatus(long id)
        {
            var result = new BillData().ChangeStatus(id);
            return Json(new
            {
                status = result
            });
        }
    }
}