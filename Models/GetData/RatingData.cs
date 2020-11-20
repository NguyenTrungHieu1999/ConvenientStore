using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using PagedList;

namespace Models.GetData
{
    public class RatingData
    {
        ConvenientStoreDBContext db = null;
        public RatingData()
        {
            db = new ConvenientStoreDBContext();
        }
        public ProductRate GetByID(long ID)
        {
            return db.ProductRates.Find(ID);
        }
        public ProductRate Rated(long userID,long productID)
        {
            return db.ProductRates.SingleOrDefault(x => x.UserID == userID && x.ProductID == productID);
        }
        public List<ProductRate> ListProductRate(long productID)
        {
            return db.ProductRates.Where(x => x.ProductID == productID).ToList();
        }
        public List<ProductRate> ListAll()
        {
            return db.ProductRates.ToList();
        }
        public long insert(ProductRate entity)
        {
            try
            {
                db.ProductRates.Add(entity);
                db.SaveChanges();
                return entity.ID;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
        public bool update(ProductRate entity)
        {
            try
            {
                var rate = db.ProductRates.Find(entity.ID);
                rate.RateStar = entity.RateStar;
                rate.CommentContent = entity.CommentContent;
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
                var rate = db.ProductRates.Find(ID);
                db.ProductRates.Remove(rate);
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
