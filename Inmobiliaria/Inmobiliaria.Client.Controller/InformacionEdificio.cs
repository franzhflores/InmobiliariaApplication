using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Inmobiliaria.Client.Controller;
using Model = Inmobiliaria.Client.Controller.ServiceInmobiliaria;

namespace Inmobiliaria.Client.Controller
{
    public class InformacionEdificio
    {
        
        public string Zona{get;set;}
        public string  Provincia {get;set;} 
        public string  Direccion {get;set;} 

        public string InfoUbicacion 
        {
            get 
            {
                return "Esta ubicado en  la provincia de " + Provincia.ToUpper() + "\n\n" +
                             "zona " +Zona + "\n\n" +
                             "su direccion es   "+ Direccion;
            }            
        }

        public int N_Apartamentos { get; set; }
        public string InfoTotalApartamentos 
        {
            get
            {
                return "Tiene   " + N_Apartamentos + "  apartamentos";
            }
        }

        public int N_Plantas { get; set; }
        public string InfoNPlantas 
        {
            get
            {
                return "Cuenta con  " + N_Plantas  + "  plantas";
            }
        }

        public DateTime A_Construccion { get; set; }
        public string InfoSobreAconstruccion 
        {
            get
            {
                return "Fue construido el " + A_Construccion.ToLongDateString();
            }
        }

        public string Inf_Adicional { get; set; }
        public string InfoMasInformacion
        {
            get
            {
                return " Mas Informacion: " + Inf_Adicional;
            }
        }

    }
}
