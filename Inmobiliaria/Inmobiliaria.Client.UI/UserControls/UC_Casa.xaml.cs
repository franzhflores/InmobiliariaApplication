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
    /// Lógica de interacción para UC_Casa.xaml
    /// </summary>
    public partial class UC_Casa : UserControl
    {
        ControladorUserControls _controlerUserControls;
        IListaEntidad _uCListEntidad;
        public UC_Casa(ControladorUserControls controlerUserControls)
        {
            InitializeComponent();
            _controlerUserControls = controlerUserControls;
            LoadUCDataList();
           // _parentContainer = parentContainer;
           // HelpContentVisual.ListenExpanded(exp_Informacion, exp_Fotos);
        }

        private void LoadUCDataList()
        {
            _uCListEntidad = new UC_ListCasa(LocalDataStore.ListCasa);
            var ucListEntidad = _uCListEntidad as UC_ListCasa;
            SetUCActual(ucListEntidad);
            HelpContentVisual.ListenExpanded(exp_Infraestructura, exp_Servicios, exp_Fotos);
            SubscriveEventHandlers();
        }

        private void SetUCActual(UserControl usercontrol)
        {
            Grid.SetColumn(usercontrol, 1);
            Grid.SetRow(usercontrol, 1);
            grid_Context.Children.Add(usercontrol);
        }

        //Se suscriben eventos a la lista de departamentos
        private void SubscriveEventHandlers()
        {
            _uCListEntidad.ListSelectionChange += lbx_DataList_SelectionChanged;
            _uCListEntidad.OnAddFotoClick += btn_Fotos_Click;
            _uCListEntidad.OnButtonExtraClick += btn_AgregarInfoestructura_Click;
            _uCListEntidad.OnButtonExtra1Click += btn_servicios_Click;
        }

        #region Acciones generados dentro la lista De datos
        private void btn_AgregarInfoestructura_Click(object sender, EventArgs e)
        {

        }

        private void btn_servicios_Click(object sender, EventArgs e)
        {

        }

        private void btn_Fotos_Click(object sender, EventArgs e)
        {

        }

        private void lbx_DataList_SelectionChanged(object sender, EventArgs e)
        {

        }

        private void btn_Update_Click(object sender, EventArgs e)
        {
            //string idEdificio = getIdEdificioFromTag(sender);
            //if (idEdificio == "") return;
            //Model.Edificio edificio = LocalDataStore.ListEdificios.Find(P => P.Id == idEdificio);
            //_controlerUserControls.PutUserControlIntoWin(new UC_ModificarEdificio(edificio, _uCListEntidad.Lbx_DataList));

        }

        private void btn_Delete_Click(object sender, EventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Esta seguro de quitar este registro de la base de datos", "Quitar Edificio", MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (MessageBoxResult.Yes == result)
            {
                try
                {
                    //bool response = LocalDataStore.EliminarEdificio(getIdEdificioFromTag(sender));
                    //if (response)
                    //{
                    //    MessageBox.Show("Archivo eliminado", "Eliminar un registro", MessageBoxButton.OK, MessageBoxImage.Information);
                    //    _uCListEntidad.Lbx_DataList.ItemsSource = LocalDataStore.ListEdificios;
                    //}
                    //else
                    //    MessageBox.Show("No puede quitar un registro con informacion", "Quitar Registro", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
                catch (Exception ex)
                {
                    //MessageBox.Show("No puede quitar un registro con informacion", "Quitar Registro",MessageBoxButton.OK,MessageBoxImage.Warning);
                }
            }
        }
        #endregion

        private void btn_AgregarApartamento_Click(object sender, RoutedEventArgs e)
        {
            _controlerUserControls.PutUserControlIntoWin(new UC_NCasa(_uCListEntidad.Lbx_DataList));
        }

        private void btn_AgregarCasa_Click(object sender, RoutedEventArgs e)
        {
            _controlerUserControls.PutUserControlIntoWin(new UC_NCasa(_uCListEntidad.Lbx_DataList));
        }



    }
}
