using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace Inmobiliaria.Service.ServiceInmobiliaria
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IService1" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IService1
    {

        [OperationContract]
        List<Edificio> GetTodosLosEdificios();

        [OperationContract]
        Dictionary<Ubicacion, List<Ubicacion_Detalle>> GetDictionaryUbicaciones();

        [OperationContract]
        string GuardarEdificio(Edificio edificio, string pathImageOrigen);

        [OperationContract]
        bool EliminarEdificio(string Id_Edificio);

        [OperationContract]
        bool ModificarEdificio(Edificio edificio);

        [OperationContract]
        List<Apartamento> GetApartamentosByIdEdificio(string idEdificio);

        [OperationContract]
        List<Apartamento> GetApartamentosAll();

        [OperationContract]
        string GuardarApartamento(Apartamento apartamento);

        [OperationContract]
        Dictionary<Infraestructura, List<Infraestructura_Detalle>> GetDictionaryInfraestructuras();

        [OperationContract]
        string GuardarInfraestructuraApartamento(Infraestructura_Apartamento infraestructuraApartamento);

        [OperationContract]
        string GuardarInfraestructuraDetalle(Infraestructura_Detalle infraestructuraDetalle);

        [OperationContract]
        List<Infraestructura_Apartamento> GetInfraestructuraApartamento();

        [OperationContract]
        List<Servicios> GetListServicios();

        [OperationContract]
        List<Servcio_Apartamento> GetListServicioApartamento();

        [OperationContract]
        void GuardarServicioApartamento(List<Servicios> listServicios,string id_apartamento);

        [OperationContract]
        string GuardarServicio(Servicios servicio);

        [OperationContract]
        string GuardarFotosApartamento(Fotos_Apartamento servicio);

        [OperationContract]
        List<Fotos_Apartamento> GetFotosApartamento();

        [OperationContract]
        List<Foto_Edificio> GetFotosEdificio();

        [OperationContract]
        string GuardarFotosEdificio(Foto_Edificio fedificio);

        [OperationContract]
        string GuardarInmueble(Inmueble inmu);
    }
}
