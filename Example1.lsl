// Sencillo ejemplo para comprender el funcionamiento de la API Coins (RP-HUD [G&S])
// Simple example to understand how the API Coins (RP-HUD [G&S]) work

// Coloque este script en el mismo prim que el  API Coins (RP-HUD [G&S])
// Put this script in same prim as the API Coins (RP-HUD [G&S])


default {

    
    touch_start(integer num_detected) {
        
        // Envio de petición de cobro. [Nombre del Objeto],[Precio]
        // Send the request for recovery. [Object Name],[Price]
        
        llMessageLinked(LINK_SET, 700, "Object,5" , llDetectedKey(0) );    
            
    }
    
    link_message(integer sender_num, integer num, string str, key id) {
        
        
        if(num == 701){// Respuesta correcta, objeto cobrado. || Correct answer, the object has been paid
            
            llSay( 0 , "Objeto vendido" );
            //
            // Por hacer : Entregar el objeto  || To do : Give the object
        }
        
        
        if(num == 702){
            // Respuesta incorrecta, el vendor está siendo utilizado por otro usuario.
            // Wrong answer, the vendor is being used by another user.
            
            llSay( 0 , "El vendor esta ocupado por "+str );
    
        }
    }
    
}
