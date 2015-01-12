// Coloque este script en el mismo prim que el  API Coins (RP-HUD [G&S])
// Put this script in same prim as the API Coins (RP-HUD [G&S])


// Constantes 
// Constants

integer PVP = 20;




// Variables
string nom_obj;
integer active = FALSE;

default {
    
    state_entry() {
        // Comprobamos objetos en el inventario
        // We check the inventory objects
        integer cnt =  llGetInventoryNumber( INVENTORY_OBJECT );
        
        // La variable "active" estará a true cuando haya objetos en el inventario        
        // The variable "active" will be true when there are objects in the inventory
        active = cnt>0;
        
        if(active){
            llSetText(llGetInventoryName(INVENTORY_OBJECT,0)+" : "+(string)PVP+" [G&S] Coins", <1,1,1>, 1);
        }else{
            llSetText("** Vacio/Empty **", <1,1,1>, 1);    
        }
    }
    
    touch_start(integer num_detected) {
        if(active){
            // enviar peticion de cobro
            // send request for payment
            // llMessageLinked( integer link, integer num, string str, key id );
            //  link = LINK_SET
            //  num  = 700
            //  str  = Object name , Price
            //  id   = UID of avatar
            
            llMessageLinked(LINK_SET, 700, llGetInventoryName(INVENTORY_OBJECT,0)+","+(string)PVP,llDetectedKey(0));          
        }    
    }
    
    link_message(integer sender_num, integer num, string str, key id) {                

        // Respuesta correcta, objeto cobrado.        
        // Correct answer. The object has been paid.  
        if(num == 701){
              
            llSay( 0 , "Objeto "+llGetInventoryName(INVENTORY_OBJECT,0)+" vendido a "+llKey2Name(id) );
            
            // Entregando el objeto al cliente.
            // Delivering the object to the client.
            llGiveInventory( id, llGetInventoryName(INVENTORY_OBJECT,0) );
            
            // Reseteamos el script
            // Resets the script
            llResetScript();
        }
        
        // Respuesta incorrecta, el vendor está siendo utilizado por otro usuario.
        // Wrong answer, the vendor is being used by another user.         
        if(num == 702){
           
            llSay( 0 , "El vendor está ocupado por / the vendor is being used by : "+str );
    
        }
    }
        
    changed(integer change){      
        if (change & CHANGED_INVENTORY){
               llResetScript();
        }
      }   
}
