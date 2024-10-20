<%@ page language="java" import="java.util.*" import="java.text.SimpleDateFormat" import="java.text.DecimalFormat" import="java.math.BigDecimal" import="metier.Attachement" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Attachement[] tabAttachements;
	tabAttachements=(Attachement[])request.getAttribute("listeAttachements");
	BigDecimal nombreDecimal=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);
	SimpleDateFormat inSDF = new SimpleDateFormat("yyyy-mm-dd");
	SimpleDateFormat outSDF = new SimpleDateFormat("dd-mm-yyyy");
	String DateAttachement1 ="";
	String DateAttachement2 ="";
	DecimalFormat f = new DecimalFormat();
	f.setMaximumFractionDigits(2); 
	f.setMinimumFractionDigits(2);
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
	
	<%for(int i=0;i<tabAttachements.length;i++) {%>
    <script type="text/javascript">
   	$('#enregistrerDecompte<%=i%>').click(function enregistrerDecompte() 
    {         
        $("#chargement").show();
        $("#idAttachement2").val("<%= tabAttachements[i].getIdAttachement() %>");      
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#numDecompte").val($('#numDecompte2<%=i%>').val()); 
        $("#typeDecompte").val($('#typeDecompte2<%=i%>').val()); 
        $("#dateDecompte").val($('#dateDecompte2<%=i%>').val()); 
        $("#typeRetenue").val($('#typeRetenue2<%=i%>').val()); 
        $("#montantRevisionPrix").val($('#montantRevisionPrix2<%=i%>').val()); 
        $("#montantP").val($('#montantP2<%=i%>').val());
        $("#travauxT").val($('#travauxT2<%=i%>').val()); 
    
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "enregistrerDecompte.do", 
            data:$("#formAjouterDecomptes").serialize(),
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
               $("#listeDecomptes").html(html); 
               $("#Decomptes").show(); 
               afficherBienEnregistrer();                  
            } 
         });            
    } 
    ); 
    $('#afficherDecompte<%=i%>').click(function afficherDecompte() 
    {         
        $("#chargement").show();
        $("#idAttachement").val("<%= tabAttachements[i].getIdAttachement() %>");     
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
      
        if (<%=tabAttachements[i].getNumDecompte()%> <= 0){
            $("#chargement").hide(); 
            alert("Vous devez remplir le N° de Décompte"); 
        }else if ('<%=tabAttachements[i].getDateDecompte()%>' == ""){
            $("#chargement").hide(); 
            alert("Vous devez remplir la date de Décompte"); 
        }else 
        {
           $.ajax(          
           {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "afficherDecompte.do", 
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
               $("#listePrixDecompte").html(html);  
               $("#listePrixDecompte").show();             
               $("#Decomptes").show();                 
            } 
            });  
            }          
    } 
    ); 
    $('#exporterDecompte<%=i%>').click(function exporterDecompte() 
    {         
        $("#chargement").show();
        $("#idAttachement").val("<%= tabAttachements[i].getIdAttachement() %>");     
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
      
        if (<%=tabAttachements[i].getNumDecompte()%> <= 0){
            $("#chargement").hide(); 
            alert("Vous devez remplir le N° de Décompte"); 
        }else if ('<%=tabAttachements[i].getDateDecompte()%>' == ""){
            $("#chargement").hide(); 
            alert("Vous devez remplir la date de Décompte"); 
        }else 
        {
           $.ajax(          
           {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterDecompte.do", 
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
               window.location.replace("../../GestionEntrepriseBTP/Fichiers/DecompteProvisoire.docx");                    
            } 
            });  
            }          
    } 
    ); 
    $('#exporterDecompteDefinitif<%=i%>').click(function exporterDecompteDefinitif() 
    {         
        $("#chargement").show();
        $("#idAttachement").val("<%= tabAttachements[i].getIdAttachement() %>");     
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
      
        if (<%=tabAttachements[i].getNumDecompte()%> <= 0){
            $("#chargement").hide(); 
            alert("Vous devez remplir le N° de Décompte"); 
        }else if ('<%=tabAttachements[i].getDateDecompte()%>' == ""){
            $("#chargement").hide(); 
            alert("Vous devez remplir la date de Décompte"); 
        }else 
        {
           $.ajax(          
           {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterDecompteDefinitif.do", 
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
               window.location.replace("../../GestionEntrepriseBTP/Fichiers/DécompteDéfinitif.docx");                    
            } 
            });  
            }          
    } 
    ); 
    </script>
    <%} %>   
  </head> 
  <body> 
  
    <%if(tabAttachements.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Décompte </center>
      <%} %>
     <%if(tabAttachements.length>0){ %>
     <table   border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1642" >    
     <tr>    
     <th width="520" class="" align="left">  </th>
     <th width="25" class="" align="center"> N° Décompte  </th> 
     <th width="95"> Type Décompte </th>
     <th width="95"> Date Décompte </th>
     <th width="95"> Retenue de garantie </th>
     <th width="95"> Montant </br> Révision des prix </th>
     <th width="95"> Travaux Terminés </th>
     <th width="95"> Montant Décompte </th>
     <th width="95"> Montant Acompte </th>
     <th width="95"> Montant </br> Pénalité de retard </th>
     <th width="20">  </th>
     <th width="20">  </th>
     <th width="20">  </th>
     </tr>   
     <%for(int i=0;i<tabAttachements.length;i++) {%>
     <tr id="ligne<%=i%>"> 
     <%if(tabAttachements[i].getCategorieAttachement().equals("Livraison")){ %>      
     <td align="left">Facture <%=tabAttachements[i].getTypeAttachement()%> N° <%=tabAttachements[i].getNumAttachement()%> </td>                 
     <%}else{ %>
     <td align="left">Attachement <%=tabAttachements[i].getTypeAttachement()%> N° <%=tabAttachements[i].getNumAttachement()%> </td>                 
     <%} %>
     <%if(tabAttachements[i].getNumDecompte() != 0){ %>     
     <td align="center" > <input type="number" name="numDecompte2<%=i%>" id="numDecompte2<%=i%>"  value="<%= tabAttachements[i].getNumDecompte() %>" size="10"/> </td>
     <%}else { %>     
     <td align="center" > <input type="number" name="numDecompte2<%=i%>" id="numDecompte2<%=i%>"  value="" size="10"/> </td>
     <%} %>
     <td><select name="typeDecompte2<%=i%>"  id="typeDecompte2<%=i%>" class="newsletter_input"  >
         <option  value="<%=tabAttachements[i].getTypeDecompte()%>"><%=tabAttachements[i].getTypeDecompte()%></option>
         <option  value="">---------------------------</option>	                   	                    
	     <option  value="Provisoire">Provisoire</option>
		 <option  value="Provisoire et dérnier">Provisoire et dérnier</option>	                
		 <option  value="Définitif">Définitif</option>
		 <option  value="Partiel provisoire">Partiel provisoire</option>
		 <option  value="Géneral provisoire">Géneral provisoire</option>		                
		 <option  value="Partiel définitif">Partiel définitif</option>
		 <option  value="Géneral définitif">Géneral définitif</option>
		 </select>
     </td>
     <td align="center"><input type="date" name="dateDecompte2<%=i%>" id="dateDecompte2<%=i%>" class="newsletter_input"  value="<%= tabAttachements[i].getDateDecompte() %>" size="10"/> </td>
     <td><select name="typeRetenue2<%=i%>"  id="typeRetenue2<%=i%>" class="newsletter_input"  >
         <option  value="<%=tabAttachements[i].getTypeRetenue()%>"><%=tabAttachements[i].getTypeRetenue()%></option> 
         <option  value="---------------------------">---------------------------</option>             	                    
	     <option  value="Retenue de garantie">Retenue de garantie</option>
		 <option  value="Caution bancaire">Caution bancaire</option>	                
		 </select>
     </td>     
     <%if(tabAttachements[i].getMontantRevisionPrix() != nombreDecimal){ %> 
     <td align="center"><input type="number" name="montantRevisionPrix2<%=i%>" id="montantRevisionPrix2<%=i%>"  class="number_input1" value="<%= tabAttachements[i].getMontantRevisionPrix() %>" size="12"/> </td>    
     <%}else { %> <td align="center"><input type="number" name="montantRevisionPrix2<%=i%>" id="montantRevisionPrix2<%=i%>" class="number_input1"  value="0.00" size="12"/> </td>  <%} %>
     <%if(tabAttachements[i].getTravauxT() == 20){ %> 
     <td><select name="travauxT2<%=i%>"  id="travauxT2<%=i%>" >
         <option  value="20">Travaux terminés</option>  
         <option  value="0">Travaux non terminés</option>          	                                   
		 </select>
     </td>  
     <%}else { %>
     <td><select name="travauxT2<%=i%>"  id="travauxT2<%=i%>"  >
         <option  value="0">Travaux non terminés</option>   
         <option  value="20">Travaux terminés</option>          	                                   
		 </select>
     </td>  
     <%} %>
     <%if(tabAttachements[i].getMontantDecompte() != nombreDecimal){ %> 
     <td align="right"> <font color="#000000"> <%= (f.format( ((tabAttachements[i].getMontantDecompte()).subtract(tabAttachements[i].getMontantP())).setScale(2, BigDecimal.ROUND_DOWN) )).replace(",", ".") %> </font> </td>
     <%}else { %>
     <td align="right">  </td>
     <%} %>
     <%if(tabAttachements[i].getMontantAcompte() != nombreDecimal){ %> 
     <td align="right"> <font color="#000000"> <%= (f.format(tabAttachements[i].getMontantAcompte())).replace(",", ".") %> </font> </td>    
     <%}else { %>
     <td align="right"> </td>         
     <%} %>
     <%if(tabAttachements[i].getMontantP() != nombreDecimal){ %> 
     <td align="center"><input type="number" name="montantP2<%=i%>" id="montantP2<%=i%>" class="number_input1"  value="<%= tabAttachements[i].getMontantP() %>" size="12"/> </td>    
     <%}else { %> <td align="center"><input type="number" name="montantP2<%=i%>" id="montantP2<%=i%>" class="number_input1"  value="0.00" size="12"/> </td>  <%} %>
             
     <td align="center"><input type="button" id="enregistrerDecompte<%=i%>" class="btn btn-default4" value="+" size="35"/> </td>
     <td align="center"><input type="button" id="afficherDecompte<%=i%>" class="btn btn-default4" value="Réaliser Décompte" size="35"/> </td>
     <td align="center"><input type="button" id="exporterDecompte<%=i%>" class="btn btn-default2" value="Imprimer Décompte" size="35"/> 
     <%if (tabAttachements[i].getTypeDecompte().equals("Provisoire et dérnier") || tabAttachements[i].getTypeDecompte().equals("Définitif") 
		    || tabAttachements[i].getTypeDecompte().equals("Partiel définitif")  || tabAttachements[i].getTypeDecompte().equals("Géneral définitif") ) {
     %>
     <input type="button" id="exporterDecompteDefinitif<%=i%>" class="btn btn-default2" value="Imprimer décompte définitif" size="35"/>
     <%}%>
     </td>     
     </tr>
     <%} %>
     </table>
     <%} %>
    
  </body>
</html>