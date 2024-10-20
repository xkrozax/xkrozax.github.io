<%@ page language="java" import="java.util.*" import="java.text.SimpleDateFormat" import="metier.Attachement" contentType="text/html; charset=UTF-8"%>
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
	Attachement[] tabAttachements;
	tabAttachements=(Attachement[])request.getAttribute("listeAttachements");
	SimpleDateFormat inSDF = new SimpleDateFormat("yyyy-mm-dd");
	SimpleDateFormat outSDF = new SimpleDateFormat("dd-mm-yyyy");
	String DateAttachement1 ="";
	String DateAttachement2 ="";
	 %>
	<% int size = tabAttachements.length;  
			int sizeParPage = 16;
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
     var size =<%=tabAttachements.length%>;  
			var sizeParPage = 16;
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
	<%for(int i=0;i<tabAttachements.length;i++) {%>
    <script type="text/javascript">
   	$('#afficherAttachement<%=i%>').click(function afficherAttachement() 
    {         
        $("#chargement").show();
        //$("#listeBordereauPrix").show();
        $("#idAttachement").val("<%= tabAttachements[i].getIdAttachement() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("input[type='button']").removeClass("active btn-info");
        $('#btnAttachements').addClass("active btn-info");
        $('#afficherAttachement<%=i%>').addClass("active btn-info");
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherLignesAttachement.do", 
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
               $("#listeBordereauPrix2").show();                      
            } 
         });            
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body> 
  
        <option  value="0">---------------------------------</option>
        <%if(tabAttachements.length>0){ %>
        <%for(int i=0;i<tabAttachements.length;i++) {%>
        <%if(tabAttachements[i].getCategorieAttachement().equals("Livraison")){ %>
		        <option  value="<%=tabAttachements[i].getIdAttachement()%>" >
		        Livraison <%=tabAttachements[i].getTypeAttachement()%> N° <%=tabAttachements[i].getNumAttachement()%> du <%= tabAttachements[i].getDateAttachement()%>
		        </option>	
		<%}else{ %>
		        <option value="<%=tabAttachements[i].getIdAttachement()%>">
		        Attachement <%=tabAttachements[i].getTypeAttachement()%> N° <%=tabAttachements[i].getNumAttachement()%> du <%= tabAttachements[i].getDateAttachement()%>
		        </option>
		<%} %>
		<%} %>
        <%} %>
  </body>
</html>