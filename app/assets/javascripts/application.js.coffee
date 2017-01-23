//= require jquery
//= require jquery_ujs
//= require init
//= require chosen-jquery
//= require jquery.remotipart
//= require jquery_nested_form
//= require jquery-ui
//= require jquery.html5-placeholder-shim
//= require camp_surveys
//= require tether
//= require bootstrap
//= require datatables
//= require moment
//= require bootstrap-datetimepicker
//= require underscore
//= require pages
//= require registrations

jQuery ->
  $('.datatable').DataTable
    responsive: true,
    pagingType: 'simple'
    order:      [[ 0, "desc" ]]

  $('.datepicker').datepicker
    dateFormat: "yy-mm-dd"

  $('.chosen').chosen()
