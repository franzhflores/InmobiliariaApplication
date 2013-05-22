using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Inmobiliaria.Client.Controller.ServiceInmobiliaria;

namespace Inmobiliaria.Client.Controller
{
    public sealed class ServicesManager
    {
        
        private Service1Client _serviceClient;

        private static ServicesManager _instance;

        private ServicesManager()
        {
            _serviceClient = new Service1Client();
            
        }

        public static ServicesManager Instance 
        {
            get
            {
                if (_instance == null)
                    _instance = new ServicesManager();
                return _instance;
            }
        }

        public Service1Client ServiceClient 
        {
            get {
                return _serviceClient;
            }
        }

     /*   public static bool isPosibleConexion() 
        {
 
        }
        */
    }
}
