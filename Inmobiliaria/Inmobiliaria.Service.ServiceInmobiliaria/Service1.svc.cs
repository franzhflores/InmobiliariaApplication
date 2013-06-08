using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace Inmobiliaria.Service.ServiceInmobiliaria
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "Service1" en el código, en svc y en el archivo de configuración.
    public class Service1 : IService1
    {
        EntitiesManager _entitiesManager = EntitiesManager.Instance;

        public List<Edificio> GetTodosLosEdificios()
        {
            return _entitiesManager.Context.Edificio.ToList();
        }

        public Dictionary<Ubicacion, List<Ubicacion_Detalle>> GetDictionaryUbicaciones()
        {
            Dictionary<Ubicacion, List<Ubicacion_Detalle>> tempDic = new Dictionary<Ubicacion, List<Ubicacion_Detalle>>();
            foreach (Ubicacion ubi in _entitiesManager.Context.Ubicacion)
                tempDic.Add(ubi, new List<Ubicacion_Detalle>());
            foreach (Ubicacion_Detalle ud in _entitiesManager.Context.Ubicacion_Detalle)
                   tempDic.First(P => P.Key.Id == ud.Id_Ubicacion).Value.Add(ud);
            return tempDic;
        }

        public string GuardarEdificio(Edificio edificio, string pathImageOrigen)
        {
            //System.IO.File.Copy(pathImageOrigen, edificio.mainfoto, true);
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertEdificio(edificio.Inmueble.Id_Ubi_Detalle, edificio.Nombre, edificio.Inmueble.A_Construccion, edificio.N_Plantas, edificio.Inmueble.Inf_adicional, edificio.Inmueble.Foto, edificio.Inmueble.Direccion);           
            foreach(string r in objectResponse)
                return r;
            return "";
        }

        public bool EliminarEdificio(string Id_Edificio) 
        {
            try
            {
                System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.sp_EliminarEdificio(Id_Edificio);
                foreach (int r in objectResponse)
                    return r == 1 ? true : false;
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
           
        }

        public bool ModificarEdificio(Edificio edificio)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.msp_ModificarEdificio(edificio.Id, edificio.Inmueble.Id_Ubi_Detalle, edificio.Nombre, edificio.Inmueble.A_Construccion, edificio.N_Plantas, edificio.Inmueble.Inf_adicional, edificio.Inmueble.Foto, edificio.Inmueble.Id);
            foreach (int r in objectResponse)
                return r == 1 ? true : false;
            return false;
        }

        public List<Apartamento> GetApartamentosByIdEdificio(string idEdificio)
        {
            throw new NotImplementedException();
        }

        public List<Apartamento> GetApartamentosAll()
        {
            return _entitiesManager.Context.Apartamento.ToList();
        }

        public string GuardarApartamento(Apartamento apartamento)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertApartamento(apartamento.Id_Edificio,apartamento.N_Piso,apartamento.N_Puerta,apartamento.Bloque);
            foreach (string r in objectResponse)
                return r;
            return "";
        }

        public Dictionary<Infraestructura, List<Infraestructura_Detalle>> GetDictionaryInfraestructuras()
        {
            Dictionary<Infraestructura, List<Infraestructura_Detalle>> tempDic = new Dictionary<Infraestructura, List<Infraestructura_Detalle>>();
            foreach (Infraestructura infra in _entitiesManager.Context.Infraestructura)
                tempDic.Add(infra, new List<Infraestructura_Detalle>());
            foreach (Infraestructura_Detalle infrad in _entitiesManager.Context.Infraestructura_Detalle)
                tempDic.First(P => P.Key.Id == infrad.Id_Infra).Value.Add(infrad);
            return tempDic;
        }

        public string GuardarInfraestructuraApartamento(Infraestructura_Apartamento infraestructuraApartamento)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertInfra_Apartamento(infraestructuraApartamento.Id_Apartamento,infraestructuraApartamento.Id_Infrac_Detalle,infraestructuraApartamento.Cantidad);
            foreach (string r in objectResponse)
                return r;
            return "";
        }

        public string GuardarInfraestructuraDetalle(Infraestructura_Detalle infraestructuraDetalle)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertInfraDetalle(infraestructuraDetalle.Id_Infra, infraestructuraDetalle.Tamano,infraestructuraDetalle.Descripcion);
            foreach (string r in objectResponse)
                return r;
            return "";
        }

        public List<Infraestructura_Apartamento> GetInfraestructuraApartamento()
        {
            return _entitiesManager.Context.Infraestructura_Apartamento.ToList();
        }

        public List<Servicios> GetListServicios()
        {
            return _entitiesManager.Context.Servicios.ToList();
        }

        public List<Servcio_Apartamento> GetListServicioApartamento()
        {
            return _entitiesManager.Context.Servcio_Apartamento.ToList();
        }

        public void GuardarServicioApartamento(List<Servicios> listServicios,string id_apartamento)
        {
            foreach (var servicio in listServicios)
            {
                _entitiesManager.Context.InsertServicioApartamento(id_apartamento,servicio.Id);
            }
        }

        public string GuardarServicio(Servicios servicio)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertServicio(servicio.Nombre,servicio.Tipo,servicio.Descripcion);
            foreach (string r in objectResponse)
                return r;
            return "";
        }

        public string GuardarFotosApartamento(Fotos_Apartamento foto_Apart)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertFotosApartamento(foto_Apart.Foto,foto_Apart.Id_Infra_Detalle,foto_Apart.Id_Apartamento,foto_Apart.Descripcion);
            foreach (string r in objectResponse)
                return r;
            return "";
        }

        public List<Fotos_Apartamento> GetFotosApartamento()
        {
            return _entitiesManager.Context.Fotos_Apartamento.ToList();
        }

        public List<Foto_Edificio> GetFotosEdificio()
        {
            return _entitiesManager.Context.Foto_Edificio.ToList();
        }

        public string GuardarFotosEdificio(Foto_Edificio fedificio)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertFotoEdificio(fedificio.Id_Edificio,fedificio.Foto,fedificio.Descripcion);
            foreach (string r in objectResponse)
                return r;
            return "";
        }

        public string GuardarInmueble(Inmueble inmu)
        {
            throw new NotImplementedException();
        }

        public List<Tipo_Casa> GetTipoCasa()
        {
            return _entitiesManager.Context.Tipo_Casa.ToList();
        }

        public string GuardarCasa(Casa  casa)
        {
            System.Data.Objects.ObjectResult objectResponse = _entitiesManager.Context.InsertCasa(casa.Id_TipoCasa,casa.Mts2,casa.Inmueble.Id_Ubi_Detalle,casa.Inmueble.A_Construccion,casa.Inmueble.Inf_adicional,casa.Inmueble.Foto,casa.Inmueble.Direccion);
            foreach (string r in objectResponse)
                return r;
            return "";
        }
        
        public List<Casa> GetCasas()
        {
            return _entitiesManager.Context.Casa.ToList();
        }
    }
}
