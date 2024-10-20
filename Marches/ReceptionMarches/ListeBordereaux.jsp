<%@ page language="java" import="java.util.*" import="java.text.DecimalFormat" import="metier.Appelsoffres" import="metier.Bordereauprix" import="metier.Seances" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ListeDossierPermisConstruire2.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Bordereauprix[] tabBordereauprix;
	tabBordereauprix=(Bordereauprix[])request.getAttribute("listeBordereauprix");
	DecimalFormat f = new DecimalFormat();
	f.setMaximumFractionDigits(2); 
	f.setMinimumFractionDigits(2);
	%>
	
	<% int size = tabBordereauprix.length;  
			int sizeParPage = 24;
			int nbPage = 0;
			int marge = size%sizeParPage;
			if ( size <= sizeParPage ){
			nbPage = 1;
			}
			else 
			 {
			   if (marge==0){
			   nbPage = size/sizeParPage;
			   }
			   else{
			   nbPage = size/sizeParPage+1;
			   }
			 } 		 
			int numPage = 0;		
	%>		
	<script type="text/javascript">
     var size =<%=tabBordereauprix.length%>;  
			var sizeParPage = 24;
			var nbPage = <%=nbPage%>;
			var numPage = 0;
    	
	 $(document).ready(function(){   		
	        for(var i=0;i<nbPage;i++){
	        	if(i==numPage){
	        		$("#"+i+"").show();
	        	} else {
	        		$("#"+i+"").hide();
	        	}
	        }
   
	   });
	   
	   function afficher(){
	   			//alert(numP);
	   			//e.preventDefault();

				if(numPage==(nbPage-1)){
				  
					$("#premier").removeAttr("disabled");
		   			$("#precedent").removeAttr("disabled");
		   			$("#next").attr("disabled", "disabled");
		   			$("#dernier").attr("disabled", "disabled");
				}else if(numPage==0){
					$("#premier").attr("disabled", "disabled");
		   			$("#precedent").attr("disabled", "disabled");
		   			$("#next").removeAttr("disabled");
		   			$("#dernier").removeAttr("disabled");
				} else {
					$("#premier").removeAttr("disabled");
		   			$("#precedent").removeAttr("disabled");
		   			$("#next").removeAttr("disabled");
		   			$("#dernier").removeAttr("disabled");
				}

	   			for(var i=0;i<nbPage;i++){
	   			    
	        		if(i==numPage){
		        		$("#"+i+"").show();
		        		$("#page"+i+"").addClass("active btn-info");
		        		$("#page"+i+"").removeClass("btn-default");
		        	} else {
		        		$("#"+i+"").hide();
		        		$("#page"+i+"").addClass("btn-default");
		        		$("#page"+i+"").removeClass("active btn-info");
		        	}
	            }
	   		
	   };
	   		
	   function precedent(){
	   
	   		if(numPage>0){
	   			numPage--;
	   		}
	   		afficher();
	   };
	   function next(){
	   
	   		if(numPage<(nbPage-1)){
	   			numPage++; 
	   		}
	   		afficher();
	   };
	   function afficherPage(numP){
	   		numPage = numP;
	   		afficher();
	   };
	  
	</script>	
	<%for(int i=0;i<tabBordereauprix.length;i++) {%>
    <script type="text/javascript">
   	$('#ajouterPrix<%=i%>').click(function ajouterPrix() 
    {         
        $("#chargement").show();
        $("#idBordereau").val("<%= tabBordereauprix[i].getIdBordereau() %>");
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterPrixAttachement.do", 
            data:$("#formAjouterAttachement").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();             
               $("#listeBordereauPrix2").html(html);  
               $("#BordereauAttachements").show();             
            } 
         });            
    } 
    );  
    </script>
    <%} %> 
    
    <script type="text/javascript">
   	$('#ajouterPrixMarches').click(function ajouterPrixMarches() 
    {         
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterPrixMarches.do", 
            data:$("#formAjouterAttachement").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();             
               $("#listeBordereauPrix2").html(html);  
               $("#BordereauAttachements").show();             
            } 
         });            
    } 
    );  
    </script>
      
  </head> 
  <body>  
   
     <%if(tabBordereauprix.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Prix </center>
      <%} %>
     <%if(tabBordereauprix.length>0){ %>
     <h3> Situation des Travaux exécutés </h3>
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="642" >    
     <tr>    
     <th width="52"> N° Prix </th>
     <th width="492" class="" align="center"> Désignation  </th>  
      <th align="center"> Quantité Marché</th>
     <th width="" > Quantité réalisé</th>  
     <th width="10"> <input type="button" id="ajouterPrixMarches" class="btn btn-default4" value="Tous --->" size="35"/> </th>
     </tr>   
     <%for(int i=0;i<tabBordereauprix.length;i++) {%>
     <tr> 
     <td align="center"><%= tabBordereauprix[i].getNumPrix() %> </td>
     <td align="left"><%= tabBordereauprix[i].getDesignation() %> </td>
     <td align="right"><%= tabBordereauprix[i].getQuantite() %> </td>  
     <td align="right"><%= tabBordereauprix[i].getQuantiteRealiser() %> </td>  
     <td align="center"><input type="button" id="ajouterPrix<%=i%>" class="btn btn-default4"  value="--->" size="35"/> </td>
     </tr>
     <%} %>
     </table>
     <%} %>
    
  </body>
</html>