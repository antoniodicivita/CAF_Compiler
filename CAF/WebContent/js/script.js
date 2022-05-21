/**
 * 
 */
 
 
 
 function exploreModal(action,postData,container,callback)
	{

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		$.ajax({
            type: "POST",
            url: action,
	        data: postData,

            //if received a response from the server
            success: function( data, textStatus) {
            	pleaseWaitDiv.modal('hide');
            	$(container).html(data);

            	if (typeof callback === "function") {

            	    	callback(data, textStatus);
            	}
            },
            error: function( data, textStatus) {
            	pleaseWaitDiv.modal('hide');

            	$(container).html(data);
            	
            	if (typeof callback === "function") {

        	    	callback(data, textStatus);
        	}

            }
            });
  
	
	}
	
	
		function callAction(action,formid,loader)
	{
		if(loader){
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
		}
		if(!formid){
			$("#callActionForm").attr("action",action);
			$("#callActionForm").submit();
		}else{
			$(formid).attr("action",action);
			$(formid).submit();
		}

	}
 
 function callAjax(dataObj, url, callback){
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

	  $.ajax({
type: "POST",
url: url,
data: dataObj,
dataType: "json",
//if received a response from the server
success: function( data, textStatus) {
	pleaseWaitDiv.modal('hide');
		  
	  if(data.success)
	  { 
		  
		  if (callback!=null && typeof callback === "function") {

  	    	callback(data, textStatus);
  	}else{
  	
  		
  		$('#report_button').hide();
		$('#visualizza_report').hide();
	  $("#modalNuovoReferente").modal("hide");
	  $('#myModalErrorContent').html(data.messaggio);
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-success");
		$('#myModalError').modal('show');
		
	$('#myModalError').on('hidden.bs.modal', function(){	         			
		
		 location.reload()
	});
  	}
		  
		
	
	  }else{
		  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
			$('#visualizza_report').show();
				$('#myModalError').modal('show');	      			 
	  }
},
error: function( data, textStatus) {
	  $('#myModalYesOrNo').modal('hide');
	  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
			$('#visualizza_report').show();
				$('#myModalError').modal('show');

}
});
	
	 
}



function callAjaxForm(form, url, callback){
	 

	pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

		  var f = $(form)[0]; 
		  var formData = new FormData(f);
		 
$.ajax({
	  type: "POST",
	  url: url,
	  data: formData,
	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
	  processData: false, // NEEDED, DON'T OMIT THIS
	  success: function( data, textStatus) {
		pleaseWaitDiv.modal('hide');
		  	      		  
		  if(data.success)
		  { 
			  if (callback!=null && typeof callback === "function") {

		  	    	callback(data, textStatus);
		  	}else{
		  	
		  		
		  		$('#report_button').hide();
				$('#visualizza_report').hide();
			  $("#modalNuovoReferente").modal("hide");
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
			$('#myModalError').on('hidden.bs.modal', function(){	         			
				
				 location.reload()
			});
		  	}
			 
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
					$('#myModalError').modal('show');	      			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				

	  }
});
	
	 
}