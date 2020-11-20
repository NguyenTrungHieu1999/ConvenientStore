using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using PagedList;

namespace Models.GetData
{
    public class CartData
    {
        ConvenientStoreDBContext db = null;
        public CartData()
        {
            db = new ConvenientStoreDBContext();
        }
        public Cart GetByID(long id)
        {
            return db.Carts.Find(id);
        }
        public List<Cart> GetByUserID(long id)
        {
            return db.Carts.Where(x => x.UserID == id).ToList();
        }
        public List<Cart> ListAllUserCart(long id)
        {
            return db.Carts.Where(x => x.UserID == id).OrderBy(x => x.CartID).ToList();
        }
        public long Insert(Cart entity)
        {
            try
            {
                db.Carts.Add(entity);
                db.SaveChanges();
                return entity.CartID;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }
        public bool Update(Cart entity)
        {
            var cart = db.Carts.Find(entity.CartID);
            cart.Quantity = entity.Quantity;
            db.SaveChanges();
            return true;
        }
        public bool Delete(Cart entity)
        {
            try
            {
                var cart = db.Carts.Find(entity.CartID);
                db.Carts.Remove(cart);
                db.SaveChanges();
                return true;
            }
            catch(Exception ex)
            {
                return false;
            }
        }
    }
}
