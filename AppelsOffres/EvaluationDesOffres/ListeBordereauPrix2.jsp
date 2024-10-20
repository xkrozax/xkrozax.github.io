<%@ page language="java" import="java.util.*" import="java.math.BigDecimal" import="java.text.DecimalFormat" import="java.math.RoundingMode" import="metier.Bordereauprix" import="metier.Bordereauconcurrents" contentType="text/html; charset=UTF-8"%>
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
	Bordereauprix [] tabBordereauprix;
	tabBordereauprix=(Bordereauprix[])request.getAttribute("listeBordereauprix");
	BigDecimal [] tabMontant;
	tabMontant =(BigDecimal[]) request.getAttribute("listeMontant");
	String typeBordereau = "";
	typeBordereau = (String) request.getAttribute("typeBordereau");
	String remarqueMontantC = "";
	remarqueMontantC = (String) request.getAttribute("remarqueMontantC");
	if(remarqueMontantC != null && remarqueMontantC.equals("Offre anormalement bas")){
	remarqueMontantC = "Offre anormalement bas";
	}
	else if( remarqueMontantC != null && remarqueMontantC.equals("Offre excessif")){
	remarqueMontantC = "Offre excessif";
	}
	else if( remarqueMontantC == null ){
	remarqueMontantC = "Offre";
	}
	
	DecimalFormat f = new DecimalFormat();
	f.setMinimumFractionDigits(2);
	f.setMaximumFractionDigits(2);
	BigDecimal prixUnitaireConcurrent = new BigDecimal("00.00");	
	%>

	<% int size = tabBordereauprix.length;  
			int sizeParPage = 320;
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
			var sizeParPage = 320;
			var nbPage = <%=nbPage%>;
			var numPage = 0;
    	
	 $(document).ready(function(){   		
	        for(var i=0;i<nbPage;i++){
	        	if(i==numPage){
	        		$("#"+i+"A").show();
	        	} else {
	        		$("#"+i+"A").hide();
	        	}
	        }
   
	   });
	   
	   function afficher(){
	   			//alert(numP);
	   			//e.preventDefault();

				if(numPage==(nbPage-1)){
				  
					$("#premierA").removeAttr("disabled");
		   			$("#precedentA").removeAttr("disabled");
		   			$("#nextA").attr("disabled", "disabled");
		   			$("#dernierA").attr("disabled", "disabled");
				}else if(numPage==0){
					$("#premierA").attr("disabled", "disabled");
		   			$("#precedentA").attr("disabled", "disabled");
		   			$("#nextA").removeAttr("disabled");
		   			$("#dernierA").removeAttr("disabled");
				} else {
					$("#premierA").removeAttr("disabled");
		   			$("#precedentA").removeAttr("disabled");
		   			$("#nextA").removeAttr("disabled");
		   			$("#dernierA").removeAttr("disabled");
				}

	   			for(var i=0;i<nbPage;i++){
	   			    
	        		if(i==numPage){
		        		$("#"+i+"A").show();
		        		$("#pageA"+i+"").addClass("active btn-info");
		        		$("#pageA"+i+"").removeClass("btn-default");
		        	} else {
		        		$("#"+i+"A").hide();
		        		$("#pageA"+i+"").addClass("btn-default");
		        		$("#pageA"+i+"").removeClass("active btn-info");
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
        $("#idBordereauAo").val("<%= tabBordereauprix[i].getIdBordereau() %>");
        $("#prixUnitaire").val($('#quantiteRealiser2<%=i%>').val()); 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterPrixBordereauC.do", 
            data:$("#formAjouterConcurrent7").serialize(),
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
               $("#listeConcurrents").html(html); 
               $("#listeConcurrents").show(); 
               $("#listeSeances").hide(); 
               $("#listeMembresCommission").hide();   
            } 
         });            
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
       
     <%if(tabBordereauprix.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Prix </center>
      <%} %>
     <%if(tabBordereauprix.length>0){ %>
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1314" >    
     <tr>    
     <th width="42"> N° de Prix </th>
     <th width="442" class="" align="center"> Désignation  </th>
     <th width="50" align="center"> Taux TVA </th>
     <th  align="center"> Unité   </th>
     <th class="" align="center"> Prix Unitaire du Marché  </th>
     <th class="" align="center"> Prix Total du Marché   </th>
	 <th align="center"> Quantité du Marché</th>
     <th width="178" > Quantité Réalisée </th>	 
	 <th class="" align="center"> Prix Total réalisé </th>
     <th width="140">  </th>
     </tr>   
     <%for(int i=0;i<tabBordereauprix.length;i++) {%>
     <%if ( (tabBordereauprix[i].getQuantiteRealiser().doubleValue()) >= (tabBordereauprix[i].getQuantite().doubleValue()) )  { %>
     <tr  class="table tr tr-selectionner2"> 
     <%} else {%>  
     <tr>
     <%} %>   
     <td align="center"><%= tabBordereauprix[i].getNumPrix() %> </td>
     <td align="left"><%= tabBordereauprix[i].getDesignation() %> </td>
     <%if( (tabBordereauprix[i].getTauxTva().doubleValue()) == (tabBordereauprix[i].getTauxTva().intValue()) ){ %> 
     <td align="right"><%= tabBordereauprix[i].getTauxTva().intValue() %> %</td>  
     <%}else { %> <td align="right"><%= tabBordereauprix[i].getTauxTva() %> %</td><%} %>
     <td align="center"><%= tabBordereauprix[i].getUnite() %> </td>
     <td align="right"><%= (f.format(tabBordereauprix[i].getPrixUnitaire())).replace(",", ".") %> </td>
     <td align="right"><%= (f.format(tabBordereauprix[i].getPrixTotal())).replace(",", ".") %> </td>
     <td align="right"><%= tabBordereauprix[i].getQuantite() %> </td>  
     <td align="right">
                  <input type="number" name="quantiteRealiser2<%=i%>" id="quantiteRealiser2<%=i%>" class="number_input" dir="rtl" value="<%= tabBordereauprix[i].getQuantiteRealiser() %>" size="15"/> 
                  <input type="button" id="ajouterPrix<%=i%>" class="btn btn-default4" value="+" size="35"/>
     </td>
     
     <td align="right"><%= (f.format(tabBordereauprix[i].getPrixTotalC())).replace(",", ".") %> </td>
     <%if( (tabBordereauprix[i].getQuantite()).equals(tabBordereauprix[i].getQuantiteRealiser()) ){ %>
     <td align="left"> Quantité Terminée </td>
     <%}else if ( (tabBordereauprix[i].getQuantiteRealiser().doubleValue()) >= (tabBordereauprix[i].getQuantite().doubleValue()) ){ %>
     <td align="left"> Quantité Dépassée </td>
     <%}else { %> <td align="left"> </td><%} %>
     </tr>
     <%} %>  
     <tr> 
     <td align="right" colspan="8"> Prix  Total  HT </td>   
     <td align="right"> <%=(f.format(tabMontant[0])).replace(",", ".") %> </td>
     <td align="center" colspan="1"> </td>
     </tr>
     <tr> 
     <td align="right" colspan="8"> TOTAL de TVA % </td>   
     <td align="right"> <%=(f.format(tabMontant[1])).replace(",", ".") %> </td>   
     <td align="center" colspan="1"> </td>
     </tr>
     <tr>
     <td align="right" colspan="8"> Prix Total TTC </td>   
     <td align="right"> <%=(f.format(tabMontant[2])).replace(",", ".") %> </td>
     <td align="left" colspan="1">  <%=remarqueMontantC %>  </td>
     </tr> 
     </table>
     <%} %>
        
  </body>
</html>