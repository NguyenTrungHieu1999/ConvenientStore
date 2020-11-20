using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using PagedList;

namespace Models.GetData
{
    public class CategoryData
    {
        ConvenientStoreDBContext db = null;
        public CategoryData()
        {
            db = new ConvenientStoreDBContext();
        }
        public ProductCategory GetByID(long ID)
        {
            return db.ProductCategories.Find(ID);
        }

        public IEnumerable<ProductCategory> ListAllCategory(string searchString, int page, int pageSize)
        {
            IQueryable<ProductCategory> model = db.ProductCategories.Where(x => x.Status == true).OrderBy(x => x.DisplayOrder);
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.Name.Contains(searchString));
            }
            return model.OrderBy(x => x.DisplayOrder).ToPagedList(page, pageSize);
        }
        //Danh mục sản phẩm
        public List<ProductCategory> ListAllCategory()
        {
            return db.ProductCategories.Where(x=>x.ShowOnHome == true).OrderBy(x => x.DisplayOrder).ToList();
        }
        //
        public List<ProductCategory> ListAll()
        {
            return db.ProductCategories.Where(x => x.Status == true).OrderBy(x=>x.DisplayOrder).ToList();
        }
        //
        public bool ChangeStatus(long id)
        {
            var category = db.ProductCategories.Find(id);
            category.ShowOnHome = !category.ShowOnHome;
            db.SaveChanges();
            return category.ShowOnHome;
        }
        //Thêm, xóa, sửa 
        public long insert(ProductCategory entity)
        {
            db.ProductCategories.Add(entity);
            db.SaveChanges();
            return entity.CateID;
        }
        //View Details
        public ProductCategory ViewDetail(long id)
        {
            return db.ProductCategories.Find(id);
        }
        public List<Product> PageProduct(long id)
        {
            return db.Products.Where(x=>x.CategoryID==id).OrderBy(x => x.ProductID).ToList();
        }
        public bool update(ProductCategory entity)
        {
            try
            {
                var category = db.ProductCategories.Find(entity.CateID);
                category.Name = entity.Name;
                category.MetaTitle = entity.MetaTitle;
                category.DisplayOrder = entity.DisplayOrder;
                category.ModifiedDate = entity.ModifiedDate;
                category.ModifiedBy = entity.ModifiedBy;
                category.Status = entity.Status;
                category.ShowOnHome = entity.ShowOnHome;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool UpdateOrder(ProductCategory entity)
        {
            try
            {
                var cate = db.ProductCategories.Find(entity.CateID);
                cate.DisplayOrder = entity.DisplayOrder;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool Delete(long ID)
        {
            try
            {
                var cate = db.ProductCategories.Find(ID);
                db.ProductCategories.Remove(cate);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
