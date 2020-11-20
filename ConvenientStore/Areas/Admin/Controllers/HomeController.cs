using Models.GetData;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class HomeController : BaseController
    {
        // GET: Admin/Home
        public ActionResult Index()
        {
            ViewBag.Bill = new BillData().ListAll();
            return View();
        }
        public ActionResult Statistical()
        {
            List<decimal?> revenue = new List<decimal?>();
            for (int i = 1; i <= 12; i++)
            {
                revenue.Add(new BillData().GetRevenue(i));
            }
            ViewBag.Revenue = revenue;
            return View();
        }
        public ActionResult OverView()
        {
            List<decimal?> revenue = new List<decimal?>();
            for (int i = 1; i <= 12; i++)
            {
                revenue.Add(new BillData().GetRevenue(i));
            }
            ViewBag.Revenue = revenue;
            ViewBag.Bill = new BillData().ListAll();
            return View();
        }
        public ActionResult AmountProduct()
        {
            List<string> productName = new List<string>();
            List<int?> product1 = new List<int?>();
            List<int?> product2 = new List<int?>();
            List<int?> product3 = new List<int?>();
            List<int?> product4 = new List<int?>();
            List<int?> product5 = new List<int?>();
            var model = new BillDetailData().ProductID();
            var productList = new ProductData().ListAll();
            foreach(var item in model)
            {
                foreach(var product in productList)
                {
                    if(item.productID==product.ProductID)
                    {
                        productName.Add(product.Name);
                    }
                }
            }
            for(int i=1;i<=12;i++)
            {
                product1.Add(new BillDetailData().GetProductPerMonth(model[0], i));
                product2.Add(new BillDetailData().GetProductPerMonth(model[1], i));
                product3.Add(new BillDetailData().GetProductPerMonth(model[2], i));
                product4.Add(new BillDetailData().GetProductPerMonth(model[3], i));
                product5.Add(new BillDetailData().GetProductPerMonth(model[4], i));
            }
            ViewBag.Name = productName;
            ViewBag.Product1 = product1;
            ViewBag.Product2 = product2;
            ViewBag.Product3 = product3;
            ViewBag.Product4 = product4;
            ViewBag.Product5 = product5;
            return View();
        }
        public ActionResult AmountCustomer()
        {
            //var user = new BillData().ListAll();
            List<int?> cus = new List<int?>();
            for(int i=1;i<=12;i++)
            {
                cus.Add(new BillData().GetCustomer(i));
            }
            int? sum = 0;
            foreach(var item in cus)
            {
                sum = sum + item;
            }
            ViewBag.Sum = sum;
            ViewBag.Customer = cus;
            return View();
        }
        public ActionResult QuarterStatistical()
        {
            List<decimal?> revenue = new List<decimal?>();
            for (int i = 1; i <= 12; i++)
            {
                revenue.Add(new BillData().GetRevenue(i));
            }
            List<decimal?> quarter = new List<decimal?>();
            for (int i = 0; i < 12; i = i + 3)
            {
                decimal? sum = 0;
                sum = revenue[i] + revenue[i + 1] + revenue[i + 2];
                quarter.Add(sum);
            }
            ViewBag.Quarter = quarter;
            return View();
        }
    }
}