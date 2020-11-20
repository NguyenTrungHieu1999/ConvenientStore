using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using PagedList;

namespace Models.GetData
{
    public class ProductData
    {
        ConvenientStoreDBContext db = null;
        public ProductData()
        {
            db = new ConvenientStoreDBContext();
        }
        public Product GetByID(long ID)
        {
            return db.Products.Find(ID);
        }

        public IEnumerable<Product> ListAllProduct(string searchString, int page, int pageSize)
        {
            IQueryable<Product> model = db.Products.OrderBy(x => x.ProductID);
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.Name.Contains(searchString));
            }
            return model.OrderBy(x => x.ProductID).ToPagedList(page, pageSize);
        }
        //Special Offer Product
        public List<Product> ListSpecialOffer()
        {
            var categories = db.ProductCategories.ToList();
            var products = db.Products.ToList();
            var model = new List<Product>();
            foreach(var category in categories)
            {
                int count = 1;
                foreach(var product in products)
                {
                    if (product.CategoryID == category.CateID && count < 5)
                    {
                        model.Add(product);
                        count++;
                    }
                }
            }
            return model.ToList();
        }
        //
        public List<Product> ListAll()
        {
            return db.Products.Where(x => x.Status == true).ToList();
        }
        public List<string> ListName(string keyword)
        {
            return db.Products.Where(x => x.Name.Contains(keyword)).Select(x => x.Name).ToList();
        }
        //Favorite Product
        public List<FavoriteProduct> ListFavoriteProduct(long id)
        {
            if (db.FavoriteProducts.Where(x => x.UserID == id) != null)
                return db.FavoriteProducts.Where(x => x.UserID == id).OrderBy(x => x.ID).ToList();
            return null;
        }
        public List<WatchedProduct> ListWatchedProduct(long id)
        {
            if (db.WatchedProducts.Where(x => x.UserID == id) != null)
                return db.WatchedProducts.Where(x => x.UserID == id).OrderBy(x => x.ID).ToList();
            return null;
        }
        //        
        public bool ChangeStatus(long id)
        {
            var product = db.Products.Find(id);
            product.Status = !product.Status;
            db.SaveChanges();
            return product.Status;
        }
        //View Details
        public Product ViewDetail(long id)
        {
            return db.Products.Find(id);
        }
        //Sản phẩm cùng loại
        public List<Product> RelateProduct(long ID, long cateID)
        {
            return db.Products.Where(x => x.ProductID != ID && x.CategoryID == cateID).ToList();
        }
        public List<Product> Search(string keyword)
        {
            if(keyword == "")
            {
                return null;
            }
            var model = db.Products.Where(x => x.Name.Contains(keyword));
            return model.OrderBy(x => x.Name).ToList();
        }
        //Thêm, xóa hàng hóa yêu thích
        public FavoriteProduct GetFavotiteProduct(long userID, long productID)
        {
            return db.FavoriteProducts.SingleOrDefault(x => x.UserID == userID && x.ProductID == productID);
        }
        public long InsertFavoriteProduct(FavoriteProduct entity)
        {
            db.FavoriteProducts.Add(entity);
            db.SaveChanges();
            return entity.ID;
        }
        public long InsertWatchedProduct(WatchedProduct entity)
        {
            db.WatchedProducts.Add(entity);
            db.SaveChanges();
            return entity.ID;
        }
        public bool DeleteFavoriteProduct(long id)
        {
            try
            {
                var favorite = db.FavoriteProducts.Find(id);
                db.FavoriteProducts.Remove(favorite);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        //Thêm, xóa, sửa 
        public long insert(Product entity)
        {
            db.Products.Add(entity);
            db.SaveChanges();
            return entity.ProductID;
        }
        public bool update(Product entity)
        {
            try
            {
                var product = db.Products.Find(entity.ProductID);
                product.Name = entity.Name;
                product.BarCode = entity.BarCode;
                product.MetaTitle = entity.MetaTitle;
                product.Descriptions = entity.Descriptions;
                product.Image = entity.Image;
                product.Price = entity.Price;
                product.PromotionPrice = entity.PromotionPrice;
                product.Quantity = entity.Quantity;
                product.CategoryID = entity.CategoryID;
                product.Detail = entity.Detail;
                product.ModifiedDate = entity.ModifiedDate;
                product.ModifiedBy = entity.ModifiedBy;
                product.Status = entity.Status;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool UpdatePopup(Product entity)
        {
            try
            {
                var product = db.Products.Find(entity.ProductID);
                product.PopupID = "model" + entity.ProductID;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool UpdateRatingStar(Product entity)
        {
            try
            {
                var product = db.Products.Find(entity.ProductID);
                product.RateStar = entity.RateStar;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool Delete(long ID)
        {
            try
            {
                var product = db.Products.Find(ID);
                db.Products.Remove(product);
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
