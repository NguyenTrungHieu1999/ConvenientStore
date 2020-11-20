using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using PagedList;
using Common;

namespace Models.GetData
{
    public class UserData
    {
        ConvenientStoreDBContext db = null;
        public UserData()
        {
            db = new ConvenientStoreDBContext();
        }
        public User GetByEmail(string email)
        {
            return db.Users.SingleOrDefault(x => x.Email == email);
        }
        public User GetByUserName(string userName)
        {
            return db.Users.SingleOrDefault(x => x.UserName == userName);
        }
        public User GetByID(long ID)
        {
            return db.Users.Find(ID);
        }

        public long GetEMPID(long userID)
        {
            return db.Employees.Find(userID).EmpID;
        }
        public List<User> ListAll()
        {
            return db.Users.Where(x => x.Status == true).ToList();
        }

        public IEnumerable<User> ListAllUser(string searchString, int page, int pageSize)
        {
            IQueryable<User> model = db.Users.OrderBy(x => x.UserID);
            if(!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.UserName.Contains(searchString) || x.Name.Contains(searchString));
            }
            return model.OrderBy(x=>x.UserID).ToPagedList(page, pageSize);
        }
        public bool ChangeStatus(long id)
        {
            var user = db.Users.Find(id);
            user.Status = !user.Status;
            db.SaveChanges();
            return user.Status;
        }

        public long insert(User entity)
        {
            db.Users.Add(entity);
            db.SaveChanges();
            return entity.UserID;
        }
        public bool update(User entity)
        {
            try
            {
                var user = db.Users.Find(entity.UserID);
                user.Name = entity.Name;
                user.DateOfBirth = entity.DateOfBirth;
                user.Sex = entity.Sex;
                user.Address = entity.Address;
                user.Email = entity.Email;
                user.Phone = entity.Phone;
                user.Status = entity.Status;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool UserUpdate(User entity)
        {
            try
            {
                var user = db.Users.Find(entity.UserID);
                user.Name = entity.Name;
                user.DateOfBirth = entity.DateOfBirth;
                user.Sex = entity.Sex;
                user.Address = entity.Address;
                user.Phone = entity.Phone;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool UpdatePassword(User entity)
        {
            try
            {
                var user = db.Users.Find(entity.UserID);
                user.Password = entity.Password;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public int isLogin(string userName, string passWord, bool isLoginAdmin = false)
        {
            var result = db.Users.SingleOrDefault(x => x.UserName == userName);
            if (result == null)
            {
                //Tên tài khoản hoặc mật khẩu không hợp lệ
                return 0;
            }
            else
            {
                //Đăng nhập trang quản lý
                if (isLoginAdmin == true)
                {
                    if (result.GroupID == CommonConstants.ADMIN_GROUP || result.GroupID == CommonConstants.EMP_GROUP)
                    {
                        if (result.Status == false)
                        {
                            //Tài khoản bị khóa
                            return -1;
                        }
                        else
                        {
                            if (result.Password == passWord)
                            {
                                //Đăng nhập trang quản lý
                                return 1;
                            }
                            else
                            {
                                //Tên tài khoản hoặc mật khẩu không hợp lệ
                                return -2;
                            }
                        }
                    }
                    //Đăng nhập trang chủ
                    else
                    {
                        if (result.Status == false)
                        {
                            //Tài khoản bị khóa
                            return -1;
                        }
                        else
                        {
                            //Đăng nhập thành công
                            if (result.Password == passWord)
                            {
                                return 2;
                            }
                            //Tên tài khoản hoặc mật khẩu không hợp lệ
                            else
                            {
                                return -2;
                            }
                        }
                    }
                }
            }
            return 0;
        }
        public bool Delete(long ID)
        {
            try
            {
                var user = db.Users.Find(ID);
                var temp = new EmpData().GetByEmpID(ID);
                if(temp!=null)
                {
                    var employee = db.Employees.Find(temp.ID);
                    db.Employees.Remove(employee);
                    db.Users.Remove(user);
                    db.SaveChanges();
                    return true;
                }
                db.Users.Remove(user);
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
