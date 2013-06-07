using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Inmobiliaria.Client.Controller;
using Model = Inmobiliaria.Client.Controller.ServiceInmobiliaria;

namespace Inmobiliaria.Client.UI.UserControls
{
    /// <summary>
    /// Usado como clase controlador 
    /// </summary>
    public partial class UCEdificio : UserControl
    {

        ControladorUserControls _controlerUserControls;
        Grid _parentContainer;
        Model.Edificio edificioSelected;

        IListaEntidad _uCListEntidad;
        public UCEdificio(ControladorUserControls controlerUserControls, Grid parentContainer)
        {
            InitializeComponent();
            LoadUCDataList();
            _controlerUserControls = controlerUserControls;
            _parentContainer = parentContainer;
            HelpContentVisual.ListenExpanded(exp_Informacion, exp_Fotos);
            SubscriveMenuLateralEventHandlers();
            SubscriveEventHandlers(_uCListEntidad);
        }

        //Lista edificio
        private void LoadUCDataList()
        {
            _uCListEntidad = new UC_ListaEdificio(LocalDataStore.ListEdificios);
            var ucListEntidad = _uCListEntidad as UC_ListaEdificio;
            SetUCActual(ucListEntidad);
        }

        private void SetUCActual(UserControl usercontrol)
        {
            Grid.SetColumn(usercontrol, 1);
            Grid.SetRow(usercontrol, 1);
            grid_Context.Children.Add(usercontrol);
        }

        private void SubscriveEventHandlers(IListaEntidad uCListEntidad)
        {
            uCListEntidad.ListSelectionChange += lbx_DataList_SelectionChanged;
            uCListEntidad.OnAddFotoClick += btn_Foto_Click;
            uCListEntidad.OnDeleteClick += btn_Delete_Click;
            uCListEntidad.OnButtonExtraClick += btn_VerApartamentos_Click;
            uCListEntidad.OnUpdateClick += btn_Update_Click;
        }

        private void EventHandler_GetBack(object sender, RoutedEventArgs e)
        {
            var uc_departamento = _parentContainer.Children[1];
            _parentContainer.Children.Remove(uc_departamento);
        }

        private void Nuevo_Click(object sender, RoutedEventArgs e)
        {
            _controlerUserControls.PutUserControlIntoWin(new UC_NuevoEdificio(_uCListEntidad.Lbx_DataList));
        }

        private string getIdEdificioFromTag(object sender)
        {
            if (sender == null) return "";
            string idEdificio = (sender as Button).Tag.ToString();
            if (idEdificio == "") return "";
            return idEdificio;
        }

        private void LoadUCApartamento(UC_Apartamento uc_apartamento)
        {
            uc_apartamento.btn_getBack.Click += EventHandler_GetBack;
            _parentContainer.Children.Add(uc_apartamento);
        }

        #region Acciones generados dentro la lista De datos

        private void btn_Update_Click(object sender, EventArgs e)
        {
            string idEdificio = getIdEdificioFromTag(sender);
            if (idEdificio == "") return;
            Model.Edificio edificio = LocalDataStore.ListEdificios.Find(P => P.Id == idEdificio);
            _controlerUserControls.PutUserControlIntoWin(new UC_ModificarEdificio(edificio, _uCListEntidad.Lbx_DataList));

        }

        private void btn_Delete_Click(object sender, EventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Esta seguro de quitar este registro de la base de datos", "Quitar Edificio", MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (MessageBoxResult.Yes == result)
            {
                try
                {
                    bool response = LocalDataStore.EliminarEdificio(getIdEdificioFromTag(sender));
                    if (response)
                    {
                        MessageBox.Show("Archivo eliminado", "Eliminar un registro", MessageBoxButton.OK, MessageBoxImage.Information);
                        _uCListEntidad.Lbx_DataList.ItemsSource = LocalDataStore.ListEdificios;
                        //lbx_DataList.Items.Refresh();
                        //lbx_DataList.ItemsSource = LocalDataStore.ListEdificios;
                    }else
                        MessageBox.Show("No puede quitar un registro con informacion", "Quitar Registro", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
                catch (Exception ex)
                {
                    //MessageBox.Show("No puede quitar un registro con informacion", "Quitar Registro",MessageBoxButton.OK,MessageBoxImage.Warning);
                }
            }
        }

        private void btn_VerApartamentos_Click(object sender, EventArgs e)
        {
            UC_Apartamento uc_apartamento = new UC_Apartamento(_controlerUserControls, getIdEdificioFromTag(sender));
            LoadUCApartamento(uc_apartamento);

        }

        private void lbx_DataList_SelectionChanged(object sender, EventArgs e)
        {
            SelectionChangedEventArgs eSelection = e as SelectionChangedEventArgs;
            edificioSelected = eSelection.AddedItems[0] as Model.Edificio;
            grid_Context.DataContext = LocalDataStore.GetViewDetailEdificio(edificioSelected);
            exp_Fotos.Content = new UC_ViewFotos(LocalDataStore.GetFotoEdificioOf(edificioSelected));
        }

        private void btn_Foto_Click(object sender, EventArgs e)
        {
            _controlerUserControls.PutUserControlIntoWin(new UC_NFotoEdificio(getIdEdificioFromTag(sender)));
        }
        #endregion

        #region Aciones Generados por el menu lateral de Edificio

        //
        private void SubscriveMenuLateralEventHandlers()
        {
            uc_MenuLateralEdificio.btn_LAPorServicio.Click += new RoutedEventHandler(btn_LAPorServicio_Click);
            uc_MenuLateralEdificio.btn_FEPorUbicacion.Click += new RoutedEventHandler(btn_FEPorUbicacion_Click);
        }

        void btn_FEPorUbicacion_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UC_Ubicacion uc_Ubicacion = new UC_Ubicacion();
                _controlerUserControls.PutUserControlIntoWin(uc_Ubicacion);
                if (!uc_Ubicacion.PressAceptar) return;
                var provinciaSelected = uc_Ubicacion.ProvinciaSelected;
                var zonaSelected = uc_Ubicacion.ZonaSelected;
                IListaEntidad listaEntidad = new UC_ListaEdificio(LocalDataStore.FiltrarEdificiosPorUbicacion(provinciaSelected, zonaSelected));
                SubscriveEventHandlers(listaEntidad);
                SetUCActual(listaEntidad as UC_ListaEdificio);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        void btn_LAPorServicio_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UC_ListServicios uc_listServicios = new UC_ListServicios();
                uc_listServicios._actionButton = "Selectionar";
                _controlerUserControls.PutUserControlIntoWin(uc_listServicios);
                List<Model.Servicios> listServicios = uc_listServicios.ListServiciosSelected;
                UC_Apartamento uc_apartamento = new UC_Apartamento(_controlerUserControls, LocalDataStore.FilterForServicios(listServicios));
                LoadUCApartamento(uc_apartamento);
            }
            catch (Exception)
            {
            }
        }



        #endregion
    }
}
