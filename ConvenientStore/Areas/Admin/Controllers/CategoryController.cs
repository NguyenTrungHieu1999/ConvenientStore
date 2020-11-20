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
    public class CategoryController : BaseController
    {
        // GET: Admin/Category
        ConvenientStoreDBContext db = null;
        public CategoryController()
        {
            db = new ConvenientStoreDBContext();
        }
        private static readonly string[] VietnameseSigns = new string[]

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
        public string RemoveHtml(string text)
        {
            return Regex.Replace(text, "<[^>]*>", string.Empty);
        }
        public void SetViewBagCategory(long? selectedID = null)
        {
            var Data = new CategoryData();
            ViewBag.DisplayOrder = new SelectList(Data.ListAll(), "DisplayOrder", "Name", selectedID);
        }
        public ActionResult Index(string searchString, int page = 1, int pageSize = 2)
        {
            var cate = new CategoryData().ListAll();
            int i = 0;
            foreach(var item in cate)
            {
                item.DisplayOrder = i;
                new CategoryData().UpdateOrder(item);
                i++;
            }
            var data = new CategoryData();
            var model = data.ListAllCategory(searchString, page, pageSize);
            ViewBag.SearchString = searchString;
            return View(model);
        }
        [HttpGet]
        public ActionResult Create()
        {
            SetViewBagCategory();
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(ProductCategory cate)
        {
            var result = this.db.ProductCategories.SingleOrDefault(x => x.Name == cate.Name);
            if (ModelState.IsValid)
            {
                if (result == null)
                {
                    var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                    if(session==null)
                    {
                        return RedirectToAction("Login", "Login");
                    }
                    var data = new CategoryData();
                    var list = new CategoryData().ListAll();
                    foreach(var item in list)
                    {
                        if(item.DisplayOrder > cate.DisplayOrder)
                        {
                            item.DisplayOrder++;
                            data.UpdateOrder(item);
                        }
                    }
                    cate.DisplayOrder++;
                    cate.MetaTitle = RemoveSign4VietnameseString(cate.Name);
                    cate.CreateDate = DateTime.Now;
                    cate.CreateBy = session.name;
                    cate.ModifiedDate = DateTime.Now;
                    cate.ModifiedBy = session.name;
                    data.insert(cate);
                    SetAlert("Thêm danh mục thành công", "success");
                    return RedirectToAction("Index", "Category");
                }
                else
                {
                    SetAlert("Danh mục này đã tồn tại", "error");
                }
            }
            SetViewBagCategory();
            return View();
        }
        [HttpGet]
        public ActionResult Edit(long ID)
        {
            SetViewBagCategory();
            var cate = new CategoryData().GetByID(ID);
            return View(cate);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(ProductCategory cate)
        {
            if (ModelState.IsValid)
            {
                var data = new CategoryData();
                var session = (UserLogin)Session[CommonConstants.USER_SESSION];
                if(session==null)
                {
                    return RedirectToAction("Login", "Login");
                }
                cate.MetaTitle = RemoveSign4VietnameseString(cate.Name);
                cate.ModifiedDate = DateTime.Now;
                cate.ModifiedBy = session.name;
                var result = data.update(cate);
                if (result)
                {
                    SetAlert("Sửa danh mục thành công", "success");
                    return RedirectToAction("Index", "Category");
                }
                else
                {
                    SetAlert("Sửa không thành công", "error");
                }
            }
            SetViewBagCategory();
            return View();
        }
        [HttpDelete]
        public ActionResult Delete(long ID)
        {
            new CategoryData().Delete(ID);
            SetAlert("Xóa thành công", "success");
            return RedirectToAction("Index", "Category");
        }
        [HttpPost]
        public JsonResult ChangeStatus(long id)
        {
            var result = new CategoryData().ChangeStatus(id);
            return Json(new
            {
                status = result
            });
        }
    }
}