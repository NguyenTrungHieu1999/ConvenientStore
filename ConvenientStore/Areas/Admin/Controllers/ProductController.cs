using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Xml.Linq;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Areas.Admin.Controllers
{
    public class ProductController : BaseController
    {
        ConvenientStoreDBContext db = null;

        public ProductController()
        {
            db = new ConvenientStoreDBContext();
        }
        public static readonly string[] VietnameseSigns = new string[]

        {

            "aAeEoOuUiIdDyY",

            "áàạảãâấầậẩẫăắằặẳẵ",

            "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ",

            "éèẹẻẽêếềệểễ",

            "ÉÈẸẺẼÊẾỀỆỂỄ",

            "óòọỏõôốồộổỗơớờợởỡ",

            "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",

            "úùụủũưứừựửữ",

            "ÚÙỤỦŨƯỨỪỰỬỮ",

            "íìịỉĩ",

            "ÍÌỊỈĨ",

            "đ",

            "Đ",

            "ýỳỵỷỹ",

            "ÝỲỴỶỸ"

        };

        public static string RemoveSign4VietnameseString(string str)

        {

            //Tiến hành thay thế , lọc bỏ dấu cho chuỗi

            for (int i = 1; i < VietnameseSigns.Length; i++)

            {
                for (int j = 0; j < VietnameseSigns[i].Length; j++)

                    str = str.Replace(VietnameseSigns[i][j], VietnameseSigns[0][i - 1]);
            }
            for (int i = 1; i < VietnameseSigns.Length; i++)
            {

                for (int j = 0; j < VietnameseSigns[i].Length; j++)

                    str = str.Replace(" ", "-");

            }
            str = str.ToLower();
            return str;

        }

        // GET: Admin/Product
        public ActionResult Index(string searchString, int page = 1, int pageSize = 2)
        {
            var data = new ProductData();
            var model = data.ListAllProduct(searchString, page, pageSize);
            ViewBag.SearchString = searchString;
            return View(model);
        }
        [HttpGet]
        public ActionResult Create()
        {
            SetViewBagCategory();
            return View();
        }
        public void SetViewBagCategory(long? selectedID = null)
        {
            var Data = new CategoryData();
            ViewBag.CategoryID = new SelectList(Data.ListAll(), "CateID", "Name", selectedID);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(Product product)
        {
            var result = this.db.Products.SingleOrDefault(x => x.Name == product.Name);
            if (ModelState.IsValid)
            {
                if (result == null)
                {
                    var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                    if(session==null)
                    {
                        return RedirectToAction("Login", "Login");
                    }
                    var data = new ProductData();
                    product.MetaTitle = RemoveSign4VietnameseString(product.Name);
                    product.BarCode = product.MetaTitle;
                    if (product.PromotionPrice == null)
                        product.PromotionPrice = 0;
                    product.CreateDate = DateTime.Now;
                    product.CreateBy = session.name;
                    product.ModifiedDate = DateTime.Now;
                    product.ModifiedBy = session.name;
                    var popupID = data.insert(product);
                    Product temp = new ProductData().GetByID(popupID);
                    new ProductData().UpdatePopup(temp);
                    SetAlert("Thêm sản phẩm thành công", "success");
                    return RedirectToAction("Index", "Product");
                }
                else
                {
                    SetAlert("Sản phẩm đã tồn tại", "error");
                }
            }
            SetViewBagCategory();
            return View();
        }
        [HttpGet]
        public ActionResult Edit(long ID)
        {
            var product = new ProductData().GetByID(ID);
            SetViewBagCategory(product.CategoryID);
            return View(product);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Product product)
        {
            if (ModelState.IsValid)
            {
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                var temp = new CategoryData().GetByID(product.CategoryID);
                var data = new ProductData();
                product.MetaTitle = RemoveSign4VietnameseString(product.Name);
                product.BarCode = product.MetaTitle;
                //if (product.Detail != null)
                //{
                //    product.Detail = RemoveHtml(product.Detail);
                //}
                if (product.PromotionPrice == null)
                    product.PromotionPrice = 0;
                product.ModifiedDate = DateTime.Now;
                product.ModifiedBy = session.name;
                var result = data.update(product);
                if (result)
                {
                    SetAlert("Sửa sản phẩm thành công", "success");
                    return RedirectToAction("Index", "Product");
                }
                else
                {
                    SetAlert("Sửa không thành công", "error");
                }
            }
            SetViewBagCategory(product.CategoryID);
            return View();
        }
        [HttpDelete]
        public ActionResult Delete(long ID)
        {
            new ProductData().Delete(ID);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index", "Product");
        }
        [HttpPost]
        public JsonResult ChangeStatus(long id)
        {
            var result = new ProductData().ChangeStatus(id);
            return Json(new
            {
                status = result
            });
        }
    }
}