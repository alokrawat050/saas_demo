$(function() {
$("#company_master_company_establish_dt").datepicker({
        changeMonth: true,
        changeYear: true,
        format: 'dd/mm/yyyy',
        language: "en",
        orientation: "bottom auto",
        todayHighlight: true,
        toggleActive: true,
        autoclose: true,
        startDate: '1950/01/01'
        //endDate: year + '/04/01',
    });
});    