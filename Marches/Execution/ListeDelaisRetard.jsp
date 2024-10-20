<%@ page language="java" import="java.util.*" import="metier.Appelsoffres" import="java.text.SimpleDateFormat" import="java.math.BigDecimal" import="metier.Delaiprestation" contentType="text/html; charset=UTF-8"%>
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
	Delaiprestation[] tabDelaiPrestation;
	tabDelaiPrestation=(Delaiprestation[])request.getAttribute("listeDelaiPrestation");
	BigDecimal nombreDecimal=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);
	%>
	<% 
    Appelsoffres appelsoffres=null;
    appelsoffres=(Appelsoffres)session.getAttribute("Appelsoffres"); 
    Integer modeOrdreDeService=0;
    BigDecimal tauxPenalite = nombreDecimal; 
    BigDecimal tauxPlafondPenalite =nombreDecimal;
    modeOrdreDeService = appelsoffres.getNumOrdreService();
    tauxPenalite = appelsoffres.getTauxPenalite();
    tauxPlafondPenalite = appelsoffres.getTauxPlafondPenalite();
    %>
	<% int size = tabDelaiPrestation.length;  
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
	$(function(){
	<%if (modeOrdreDeService != 0) {%>
	$("#ajouterModeOrdreDeService").hide();
    $("#ajouterModeOrdreDeService2").show(); 
    <%}else { %>  
    $("#ajouterModeOrdreDeService2").hide();
    $("#ajouterModeOrdreDeService").show();
    <%} %>    	
	});
	
	$('#ajouterModeOrdreDeService').click(function ajouterModeOrdreDeService() 
    { 
      $("#chargement").show();
      $("#modeOrdreDeService").val(20); 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterModeOrdreDeService.do", 
            data:$("#formRechercherMarches").serialize(),
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
               $("#listeDelaisExecution").html(html);  
               $("#listeDelaisExecution").show(); 
               $("#ajouterModeOrdreDeService").hide();
               $("#ajouterModeOrdreDeService2").show();     
            } 
         });
    } 
    );
    $('#ajouterModeOrdreDeService2').click(function ajouterModeOrdreDeService2() 
    { 
      $("#chargement").show();
      $("#modeOrdreDeService").val(0);  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterModeOrdreDeService.do", 
            data:$("#formRechercherMarches").serialize(),
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
               $("#listeDelaisExecution").html(html);  
               $("#listeDelaisExecution").show();  
               $("#ajouterModeOrdreDeService2").hide();
               $("#ajouterModeOrdreDeService").show();    
            } 
         });
    } 
    ); 
	$('#ajouterDelaiPrestation').click(function ajouterDelaiPrestation() 
    {       
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterDelaiPrestation.do", 
            data:$("#formRechercherMarches").serialize(),
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
               $("#listeDelaisExecution").html(html);  
               $("#listeDelaisExecution").show();     
            } 
         }); 
    } 
    );
    </script>
	<%for(int i=0;i<tabDelaiPrestation.length;i++) {%>
    <script type="text/javascript">
   	$('#modifierDelaiPrestation<%=i%>').click(function modifierDelaiPrestation() 
    {         
        $("#chargement").show();
        $("#idDelaiPrestation").val("<%= tabDelaiPrestation[i].getIdDelaiPrestation() %>");
        $("#delaiInitial").val($('#delaiInitial2<%=i%>').val());
        $("#delaiEffectif").val($('#delaiEffectif2<%=i%>').val());
        $("#numPhase3").val($('#numPhase2<%=i%>').val());
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierDelaiPrestation.do", 
            data:$("#formDelaiPrestation").serialize(),
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
               $("#listeDelaisExecution").html(html);  
               $("#listeDelaisExecution").show();                                              
            } 
         }); 
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabDelaiPrestation.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Délai de Prestation </center>
      <%} %>
     <table  border="3" bgcolor=""  bordercolor="#000000" width="" >     <tr>    
     <tr>
     <td align="center"> Taux pénalité journalière <input type="number" name="tauxPenalite2" id="tauxPenalite2" class="number_input"  value="<%=tauxPenalite%>" size="14"/> 
     Taux du plafond <input type="number" name="tauxPlafondPenalite2" id="tauxPlafondPenalite2" class="number_input"  value="<%=tauxPlafondPenalite%>" size="14"/>
     </td>     
     </tr>
     </table>
     <%if(tabDelaiPrestation.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >     <tr>    
     <tr> 
     <%if (modeOrdreDeService != 0) {	%>
     <th width="" > Phase </th>
     <th width=""> Délai de retard</th>
     <th width=""> Montant de pénalité </th>
     <%}else { %>  
     <th width=""> Délai de retard</th>
     <th width=""> Montant de pénalité </th>
     <%} %>
     <th> <input type="button"  id="ajouterDelaiPrestation" class="btn btn-default4" value=" + " size="35"/>   </th>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr>      
     <%if (modeOrdreDeService != 0) {	%>
     <td align="center" id="idPhase2" ><select name="numPhase2<%=i%>"   id="numPhase2<%=i%>"  class="newsletter_input"  >	
                        <option  value="<%=tabDelaiPrestation[i].getNumPhase()%>"> Phase <%=tabDelaiPrestation[i].getNumPhase()%></option>                              
	                    <option  value="1">Phase 1 </option><option  value="2">Phase 2</option><option  value="3">Phase 3</option>	
	                    <option  value="4">Phase 4</option> <option  value="5">Phase 5</option><option  value="6">Phase 6</option>                                    
	                    <option  value="7">Phase 7</option> <option  value="8">Phase 8</option><option  value="9">Phase 9</option>                                    
	                    <option  value="10">Phase 10</option> <option  value="11">Phase 11</option><option  value="12">Phase 12</option>                                    
	                    <option  value="13">Phase 13</option> <option  value="14">Phase 14</option><option  value="15">Phase 15</option>                                    
	                    <option  value="16">Phase 16</option> <option  value="17">Phase 17</option><option  value="18">Phase 18</option>                                    	                    
	                    <option  value="19">Phase 19</option> <option  value="20">Phase 20</option>                        	                    	                    
	                    </select>
     </td>
     <%if (tabDelaiPrestation[i].getDelaiDeRetard() != 0) {	%>
     <td align="center"> <input type="number" name="delaiDeRetard2<%=i%>" id="delaiDeRetard2<%=i%>" class="number_input"  value="<%=tabDelaiPrestation[i].getDelaiDeRetard() %>" size="14"/> </td> 
     <%}else { %> <td align="center"> <input type="number" name="delaiDeRetard2<%=i%>" id="delaiDeRetard2<%=i%>" class="number_input"  value="" size="14"/> </td>  <%} %>
     <%if (tabDelaiPrestation[i].getMontantDePenalite() != nombreDecimal) {	%>
     <td align="center"> <input type="number" name="montantDeRetard2<%=i%>" id="montantDeRetard2<%=i%>" class="number_input"  value="<%=tabDelaiPrestation[i].getMontantDePenalite() %>" size="10"/></td>               
     <%}else { %> <td align="center"> <input type="number" name="montantDeRetard2<%=i%>" id="montantDeRetard2<%=i%>" class="number_input"  value="" size="10"/> </td>  <%} %>    
     <td align="center"><input type="button" class="btn btn-default4" id="modifierDelaiPrestation<%=i%>"  value="Valider" size="35"/> </td>             
     <%}else { %>
     <%if (tabDelaiPrestation[i].getDelaiDeRetard() != 0) {	%>
     <td align="center"> <input type="number" name="delaiDeRetard2<%=i%>" id="delaiDeRetard2<%=i%>" class="number_input"  value="<%=tabDelaiPrestation[i].getDelaiDeRetard() %>" size="14"/> </td> 
     <%}else { %> <td align="center"> <input type="number" name="delaiDeRetard2<%=i%>" id="delaiDeRetard2<%=i%>" class="number_input"  value="" size="14"/> </td>  <%} %>
     <%if (tabDelaiPrestation[i].getMontantDePenalite() != nombreDecimal) {	%>
     <td align="center"> <input type="number" name="montantDeRetard2<%=i%>" id="montantDeRetard2<%=i%>" class="number_input"  value="<%=tabDelaiPrestation[i].getMontantDePenalite() %>" size="10"/></td>               
     <%}else { %> <td align="center"> <input type="number" name="montantDeRetard2<%=i%>" id="montantDeRetard2<%=i%>" class="number_input"  value="" size="10"/> </td>  <%} %>    
     <td align="center"><input type="button" class="btn btn-default4" id="modifierDelaiPrestation<%=i%>"  value="Valider" size="35"/> </td>        
     <%} %>
     </tr>
     <%} %>
     </table>
     <%} %>
     <%} %>
    
  </body>
</html>