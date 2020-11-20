var user = {
    init: function () {
        user.registerEvents();
    },
    registerEvents: function () {
        $('.btn-statusactive').off('click').on('click', function (e) {
            e.preventDefault();
            var btn = $(this);
            var id = btn.data('id');
            $.ajax({
                url: "/Admin/Bill/ChangeStatus",
                data: { id: id },
                dataType: "json",
                type: "POST",
                success: function (response) {
                    console.log(response);
                    if (response.status == 0) {
                        btn.text('Chờ xác nhận');
                    }
                    else if (response.status == 1) {
                        btn.text('Chờ lấy hàng');
                    }
                    else if (response.status == 2) {
                        btn.text('Đang giao');
                    }
                    else if (response.status == 3) {
                        btn.text('Đã giao');
                    }
                    else if (response.status == 4) {
                        btn.text('Đã hủy');
                    }
                    else {
                        btn.text('Trả hàng/ Hoàn tiền');
                    }
                    location.reload();
                }
            });
        });
    }
}
user.init();