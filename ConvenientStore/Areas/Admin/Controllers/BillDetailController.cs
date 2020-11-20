using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class BillDetailController : BaseController
    {
        ConvenientStoreDBContext db = null;
        public BillDetailController()
        {
            db = new ConvenientStoreDBContext();
        }

        // GET: Admin/Bill
        public ActionResult Index(string searchString, int page = 1, int pageSize = 2)
        {
            var data = new BillDetailData();
            var model = data.ListAllBillDetails(searchString, page, pageSize);
            ViewBag.Product = new ProductData().ListAll();
            ViewBag.SearchString = searchString;
            return View(model);
        }

    }
}