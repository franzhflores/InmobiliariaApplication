using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using Model = Inmobiliaria.Client.Controller.ServiceInmobiliaria;

namespace Inmobiliaria.Client.Controller
{
    public static class LocalDataStore
    {
        //nuevo cambio

        #region trabajando con edificios
        static List<Model.Edificio> _listEdificios;

        public static List<Model.Edificio> ListEdificios
        {
            get
            {
                if (_listEdificios == null)
                    _listEdificios = ServicesManager.Instance.ServiceClient.GetTodosLosEdificios().ToList();
                return _listEdificios;
            }
        }

        public static bool modificarEdificio(Model.Edificio edificio)
        {
            Model.Edificio tempEdificio = new Model.Edificio()
            {
                Id = edificio.Id,
                Nombre = edificio.Nombre,
                N_Plantas = edificio.N_Plantas,
                mainfoto = edificio.mainfoto,
                A_Contruccion = edificio.A_Contruccion,
                Inf_Adicional = edificio.Inf_Adicional,
                Id_Ubi_Detalle = edificio.Id_Ubi_Detalle
            };
            bool response = ServicesManager.Instance.ServiceClient.ModificarEdificio(tempEdificio);
            if (response)
            {
                Model.Edificio copyedificio = _listEdificios.Find(P => P.Id == edificio.Id);
                copyedificio = edificio;
            }
            return false;
        }

        public static bool GuardarEdificio(Model.Edificio edificio, string pathImageOrigen)
        {
            string response = ServicesManager.Instance.ServiceClient.GuardarEdificio(edificio, pathImageOrigen);
            if (response != "")
            {
                edificio.Id = response;
                _listEdificios.Add(edificio);
                return true;
            }
            return false;
        }

        public static bool EliminarEdificio(string Id_Edificio)
        {
            bool response = ServicesManager.Instance.ServiceClient.EliminarEdificio(Id_Edificio);
            if (response)
                _listEdificios.RemoveAll(P => P.Id == Id_Edificio);
            return response;
        }

        public static InformacionEdificio GetViewDetailEdificio(Model.Edificio edificio)
        {
             InformacionEdificio queryResult = (from e in ListEdificios
                                                  where e.Id == edificio.Id
                                                  join ud in GetUbicacionDetalle() on e.Id_Ubi_Detalle equals ud.Id
                                                 join u in ListUbicaciones on ud.Id_Ubicacion equals u.Id
                                                 select new InformacionEdificio()
                                                          {
                                                              A_Construccion = e.A_Contruccion,
                                                              Direccion = ud.Direccion,
                                                              Inf_Adicional = e.Inf_Adicional,
                                                              N_Apartamentos = GetApartamentsOf(e.Id).Count,
                                                              N_Plantas = (int)e.N_Plantas,
                                                              Provincia = u.Provincia,
                                                              Zona = ud.Zona
                                                        }).ElementAt(0);
            return queryResult;
        }

       static List<Model.Foto_Edificio> _listFotoEdificio;
        public static List<Model.Foto_Edificio> ListFotoEdificio
        {
            get
            {
                if (_listFotoEdificio == null)
                    _listFotoEdificio = ServicesManager.Instance.ServiceClient.GetFotosEdificio();
                return _listFotoEdificio;
            }
        }

        public static List<InfoCategoriaFoto> GetFotoEdificioOf(Model.Edificio edificio)
        {

            var queryResult = (from fe in ListFotoEdificio
                               where fe.Id_Edificio == edificio.Id
                               select new InfoGeneralFoto()
                               {
                                   Descripcion = fe.Descripcion,
                                   Foto = fe.Foto
                                   //Infraestructura = id.Descripcion
                               });

            return GetListCategoriaFoto(queryResult);
        }

        public static bool GuardarFotoEdificio(Model.Foto_Edificio fedificio)
        {
            string response = ServicesManager.Instance.ServiceClient.GuardarFotosEdificio(fedificio);
            if (response != "")
            {
                fedificio.Id = response;
                ListFotoEdificio.Add(fedificio);
                return true;
            }
            return false;
        }

        public static List<Model.Edificio> FiltrarEdificiosPorUbicacion(string provincia, string zona)
        {
            if(zona !=null)
                return ListEdificios.FindAll(E => E.Ubicacion_Detalle.Ubicacion.Provincia == provincia && E.Ubicacion_Detalle.Zona == zona);
            return ListEdificios.FindAll(E => E.Ubicacion_Detalle.Ubicacion.Provincia == provincia );
        }

        #endregion

        #region trabajando  con Ubicaciones
        static Dictionary<Model.Ubicacion, List<Model.Ubicacion_Detalle>> _dicUbicaciones;
        public static Dictionary<Model.Ubicacion, List<Model.Ubicacion_Detalle>> DictionaryUbicaciones
        {
            get 
            {
                 if (_dicUbicaciones == null)
                                    _dicUbicaciones = ServicesManager.Instance.ServiceClient.GetDictionaryUbicaciones();
                 return _dicUbicaciones;
            }
        }

        public static List<Model.Ubicacion> ListUbicaciones
        {
            get
            {
                return DictionaryUbicaciones.Keys.ToList();
            }

        }

        public static List<Model.Ubicacion_Detalle> GetUbicacionDetalle(Model.Ubicacion ubicacion)
        {
            List<Model.Ubicacion_Detalle> result = _dicUbicaciones.First(U => U.Key.Id == ubicacion.Id).Value;
            return result;
        }

        public static List<Model.Ubicacion_Detalle> GetUbicacionDetalle()
        {
            List<Model.Ubicacion_Detalle> result = new List<Model.Ubicacion_Detalle>();
            DictionaryUbicaciones.Values.ToList().ForEach(LD => result.AddRange(LD));
            return result;
        }
        #endregion

        #region Trabajando con apartament

        static List<Model.Apartamento> _listApartament;
        public static List<Model.Apartamento> ListApartament
        {
            get
            {
                if (_listApartament == null) 
                _listApartament = ServicesManager.Instance.ServiceClient.GetApartamentosAll();
                return _listApartament;
            }
        }

        static List<Model.Fotos_Apartamento> _listFotoApartament;
        public static List<Model.Fotos_Apartamento> ListFotoApartament
        {
            get
            {
                if (_listFotoApartament == null)
                    _listFotoApartament = ServicesManager.Instance.ServiceClient.GetFotosApartamento();
                return _listFotoApartament;
            }
        }

        static List<Model.Infraestructura_Apartamento> _infraestructuraApartament;

        public static List<Model.Infraestructura_Apartamento> ListInfraestructuraApartament
        {
            get
            {
                if (_infraestructuraApartament == null) ;
                _infraestructuraApartament = ServicesManager.Instance.ServiceClient.GetInfraestructuraApartamento();
                return _infraestructuraApartament;
            }
        }

        public static List<Model.Apartamento> GetApartamentsOf(string idEdificio)
        {
            return ListApartament.FindAll(P => P.Id_Edificio == idEdificio);
        }

        public static List<Model.Infraestructura_Apartamento> GetInfraestructarOf(string idApartament) 
        {
            return  _infraestructuraApartament.FindAll(P => P.Id_Apartamento == idApartament);
        }

        public static bool GuardarApartamento(Model.Apartamento apartamento)
        {
            string response = ServicesManager.Instance.ServiceClient.GuardarApartamento(apartamento);
            if (response != "")
            {
                apartamento.Id = response;
                _listApartament.Add(apartamento);
                return true;
            }
            return false;
        }

        public static List<InfoCategoriaFoto> GetFotoApartamentOf(Model.Apartamento apartamento)
        {
            List<Model.Infraestructura_Detalle> ListInfraDetalle = new List<Model.Infraestructura_Detalle>();
            DictionaryInfraestructura.Values.ToList().ForEach(LD => ListInfraDetalle.AddRange(LD));

            var queryResult = (from fa in ListFotoApartament
                               where fa.Id_Apartamento == apartamento.Id
                               join id in ListInfraDetalle on fa.Id_Infra_Detalle equals id.Id
                               select new InfoGeneralFoto()
                               {
                                   Descripcion = fa.Descripcion,
                                   Foto = fa.Foto,
                                   Infraestructura = id.Descripcion
                               });

            return GetListCategoriaFoto(queryResult);         
        }

        public static bool GuardarFotoApartamento(Model.Fotos_Apartamento fapartamento)
        {
            string response = ServicesManager.Instance.ServiceClient.GuardarFotosApartamento(fapartamento);
            if (response != "")
            {
                fapartamento.Id = response;
                ListFotoApartament.Add(fapartamento);
                return true;
            }
            return false;
        }

        public static List<Model.Apartamento> FilterForServicios(List<Model.Servicios> listServicios)
        {
            List<Model.Apartamento> result = ListApartament.FindAll(A => HasSomeServices(A.Servcio_Apartamento, listServicios) == true);
            return result;
        }

        //Preguntamos si el apartamento enviado tiene algunos de los servicion de la lista
        public static bool HasSomeServices(List<Model.Servcio_Apartamento> listServiciosDeApartamento, List<Model.Servicios> listServicios)
        {
            foreach (var servicio in listServicios)
            {
                var result = listServiciosDeApartamento.Find(S=> S.Id_Servicio ==servicio.Id);
                if (result == null) return false;
            }
            return true;
        }

        #endregion

        #region trabajando  con Infraestructura

        private static Dictionary<Model.Infraestructura, List<Model.Infraestructura_Detalle>> _dicInfraestructura;
        public static Dictionary<Model.Infraestructura, List<Model.Infraestructura_Detalle>> DictionaryInfraestructura
        {
            get
            {
                if (_dicInfraestructura == null) 
                    _dicInfraestructura = ServicesManager.Instance.ServiceClient.GetDictionaryInfraestructuras();
                return _dicInfraestructura;
            }
        }

        public static List<Model.Infraestructura> ListInfraestructura
        {
            get
            {
                return DictionaryInfraestructura.Keys.ToList();
            }
        }

        public static IEnumerable<Model.Infraestructura_Detalle> GetInfraestructuraDetalle(Model.Infraestructura infraestructura)
        {
            List<Model.Infraestructura_Detalle> result = DictionaryInfraestructura.First(U => U.Key.Id == infraestructura.Id).Value;
            return result;
        }

        public static IEnumerable<Model.Infraestructura_Detalle> GetInfraestructuraDetalleForFoto(string id_apartamento)
        {
            List<Model.Infraestructura_Detalle> ListInfraDetalle = new List<Model.Infraestructura_Detalle>();
            DictionaryInfraestructura.Values.ToList().ForEach(LD => ListInfraDetalle.AddRange(LD));

            var tempfraDetalle = from id in ListInfraDetalle
                                 join ia in ListInfraestructuraApartament on id.Id equals ia.Id_Infrac_Detalle 
                                 where ia.Id_Apartamento == id_apartamento
                                 select new Model.Infraestructura_Detalle()
                                 {
                                     Descripcion = id.Descripcion,
                                     Id_Infra = id.Id_Infra,
                                     Id = id.Id
                                 };
            return tempfraDetalle;
        }

        public static List<Model.Infraestructura_Detalle> GetInfraestructuraDetalle(string id_Infraestructura)
        {
            List<Model.Infraestructura_Detalle> result = DictionaryInfraestructura.First(U => U.Key.Id == id_Infraestructura).Value;
            return result;
        }

        public static List<Model.Infraestructura_Detalle> GetInfraestructuraDetalle()
        {
            List<Model.Infraestructura_Detalle> result = new List<Model.Infraestructura_Detalle>();
            DictionaryInfraestructura.Values.ToList().ForEach(LD => result.AddRange(LD));
            return result;
        }

        public static bool GuardarDetalleInfraestructura(Model.Infraestructura_Detalle infraestructuraDetalle)
        {
            string response = ServicesManager.Instance.ServiceClient.GuardarInfraestructuraDetalle(infraestructuraDetalle);
            if (response != "")
            {
                infraestructuraDetalle.Id = response;
                DictionaryInfraestructura.First(I => I.Key.Id == infraestructuraDetalle.Id_Infra).Value.Add(infraestructuraDetalle);
                return true;
            }
            return false;
        }

        public static bool GuardarInfraestructuraApartamento(Model.Infraestructura_Apartamento infraestructuraApartamento)
        {
            string response = ServicesManager.Instance.ServiceClient.GuardarInfraestructuraApartamento(infraestructuraApartamento);
            if (response != "")
            {
                infraestructuraApartamento.Id = response;
                ListInfraestructuraApartament.Add(infraestructuraApartamento);
                return true;
            }
            return false;
        }

        /// <summary>
        /// Reunimos los dato mas relevantes agregando a una clase info para posteriormento enlasarlo a un ListBox
        /// </summary>
        /// <param name="apartamento"></param>
        /// <returns></returns>
        public static IEnumerable<InfoInfraestructuraApartamento> GetViewDetailInfraestructura(Model.Apartamento apartamento)
        {
           var queryResult = (from a in ListApartament
                                                                where a.Id == apartamento.Id
                                                                join ia in ListInfraestructuraApartament on a.Id equals ia.Id_Apartamento
                                                                join id in GetInfraestructuraDetalle() on ia.Id_Infrac_Detalle equals id.Id
                                                                join i in ListInfraestructura on id.Id_Infra equals i.Id
                                                                select new InfoInfraestructuraApartamento()
                                                                {
                                                                    Cantidad = ia.Cantidad,
                                                                    IdApartament = a.Id,
                                                                    DescripcionInfraestructura = id.Descripcion,
                                                                    IdIDetalle = id.Id,
                                                                    NombreInfraestructura = i.Nombre,
                                                                    TamanoInfraestructura = id.Tamano
                                                                }) ;
            return queryResult ;
        }

        #endregion
            
        #region trabajando  con Servicio

        private static List<Model.Servicios> _listServicios;

        public static List<Model.Servicios> ListServicios
        {
            get
            {
                if(_listServicios==null)
                    _listServicios = ServicesManager.Instance.ServiceClient.GetListServicios();
                return _listServicios;
            }
        }

        private static List<Model.Servcio_Apartamento> _listServicioApartamento;

        public static List<Model.Servcio_Apartamento> ListServicioApartamento 
        {
            get 
            {
                if (_listServicioApartamento == null)
                    _listServicioApartamento = ServicesManager.Instance.ServiceClient.GetListServicioApartamento();
                return _listServicioApartamento;
            }
        }

        public static bool GuardarServicio(Model.Servicios servicio)
        {
            string response = ServicesManager.Instance.ServiceClient.GuardarServicio(servicio);
            if (response != "")
            {
                servicio.Id = response;
                _listServicios.Add(servicio);
                return true;
            }
            return false;
        }

        public static void imprime(List<Model.Servcio_Apartamento> ls)
        {
            ls.ForEach(SA=> Debug.WriteLine("{0} {1} {2}",SA.Id, SA.Id_Apartemento,SA.Id_Servicio));
        }

        public static void imprime(List<Model.Servicios> ls)
        {
            ls.ForEach(S => Debug.WriteLine("{0} {1} ", S.Id, S.Nombre));
        }

        public static bool GuardarServicioApartamento(List<Model.Servicios> listServcios, string id_Apartamento)
        {
            ServicesManager.Instance.ServiceClient.GuardarServicioApartamento(listServcios, id_Apartamento);
            if (_listServicioApartamento != null)                
                    _listServicioApartamento.Clear();
            _listServicioApartamento = ServicesManager.Instance.ServiceClient.GetListServicioApartamento();
            return true;
        }

        public static IEnumerable<InfoServicioApartamento> GetViewDetailServicio(Model.Apartamento apartamento)
        {
            var queryResult = (from a in ListApartament
                                                         where a.Id == apartamento.Id
                                                        join sa in ListServicioApartamento on a.Id equals sa.Id_Apartemento 
                                                         join s in ListServicios on sa.Id_Servicio equals s.Id
                                                         select new InfoServicioApartamento()
                                                         {
                                                             Descripcion = s.Descripcion,
                                                             IdApartament = a.Id,
                                                             IdSApartamento = sa.Id_Servicio,
                                                             NombreServicio = s.Nombre,
                                                             TipoServicio = s.Tipo
                                                         }) ;
            return queryResult;
        }

        #endregion

        #region trabajando con fotos

        private static List<InfoCategoriaFoto> GetListCategoriaFoto(IEnumerable<InfoGeneralFoto> infoGeneralFoto)
        {
            var resultGeneralFoto = (from igf in infoGeneralFoto
                                     group igf by igf.Infraestructura into grupo
                                     select grupo).ToList();
            List<InfoCategoriaFoto> listInfoCategoria = new List<InfoCategoriaFoto>();
            foreach (var infoFoto in resultGeneralFoto)
            {
                InfoCategoriaFoto infoCategoria = new InfoCategoriaFoto();
                infoCategoria.Categoria = infoFoto.Key;
                infoCategoria.ListaDeFotos = new List<InfoGeneralFoto>();
                foreach (InfoGeneralFoto infoGeneral in infoFoto)
                {
                    infoCategoria.ListaDeFotos.Add(infoGeneral);
                }
                listInfoCategoria.Add(infoCategoria);
            }
            return listInfoCategoria;
        }

        #endregion
    }
}
