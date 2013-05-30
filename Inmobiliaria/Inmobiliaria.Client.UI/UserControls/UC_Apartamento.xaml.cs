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
    /// Lógica de interacción para UC_Apartamento.xaml
    /// </summary>
    public partial class UC_Apartamento : UserControl
    {
        string _IdEdificio;
        string _apartamento;
        ControladorUserControls _controlerUserControls;
        IListaEntidad _uCListEntidad;
        public UC_Apartamento(ControladorUserControls controlerUserControls, string IdEdificio)
        {
            InitializeComponent();
            this._IdEdificio = IdEdificio;
            _controlerUserControls = controlerUserControls;
            _uCListEntidad = new UC_ListApartamento(LocalDataStore.GetApartamentsOf(_IdEdificio));
            StartUserControl();
        }

        public UC_Apartamento(ControladorUserControls controlerUserControls,List<Model.Apartamento> listApartamentos)
        {
            InitializeComponent();
            _controlerUserControls = controlerUserControls;
            _uCListEntidad = new UC_ListApartamento(listApartamentos);
            lbl_Numero.Content += "  " + listApartamentos.Count;
            StartUserControl();
        }


        private void StartUserControl()
        {
           SetUCList(_uCListEntidad as UC_ListApartamento);
            HelpContentVisual.ListenExpanded(exp_Infraestructura, exp_Servicios, exp_Fotos);
            SubscriveEventHandlers();
        }

        private void SetUCList(UserControl usercontrol)
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
            this._apartamento = (sender as Button).Tag.ToString();
            _controlerUserControls.PutUserControlIntoWin(new UC_ListInfraestructura(NotificarElementosSeleccionados));
        }

        private void btn_servicios_Click(object sender, EventArgs e)
        {
            this._apartamento = (sender as Button).Tag.ToString();
            _controlerUserControls.PutUserControlIntoWin(new UC_ListServicios(_apartamento));
            lbx_Servicios.ItemsSource = LocalDataStore.GetViewDetailServicio(new Model.Apartamento() { Id = _apartamento });
        }

        private void btn_Fotos_Click(object sender, EventArgs e)
        {
            this._apartamento = (sender as Button).Tag.ToString();
            _controlerUserControls.PutUserControlIntoWin(new UC_NFotoApartamento(_apartamento));
        }

        private void lbx_DataList_SelectionChanged(object sender, EventArgs e)
        {
            SelectionChangedEventArgs eSelection = e as SelectionChangedEventArgs;
            Model.Apartamento apartamentSelected = eSelection.AddedItems[0] as Model.Apartamento;
            lbx_Infraestructura.ItemsSource = LocalDataStore.GetViewDetailInfraestructura(apartamentSelected);
            lbx_Servicios.ItemsSource = LocalDataStore.GetViewDetailServicio(apartamentSelected);
            exp_Fotos.Content = new UC_ViewFotos(LocalDataStore.GetFotoApartamentOf(apartamentSelected));
            //lbx_FotosApart.ItemsSource = LocalDataStore.GetFotoApartamentOf(apartamentSelected);
        }
        #endregion

        private void btn_AgregarApartamento_Click(object sender, RoutedEventArgs e)
        {
            _controlerUserControls.PutUserControlIntoWin(new UC_NApartament(_IdEdificio, _uCListEntidad.Lbx_DataList));
        }

        public void NotificarElementosSeleccionados(List<Model.Infraestructura> listSeleccted)
        {
            _controlerUserControls.CloseWinActive();
            _controlerUserControls.PutUserControlIntoWin(new UC_DetalleInfraestructura(listSeleccted, _apartamento));

            //MessageBox.Show("Element selected"+listSeleccted.Count);
        }

        class Info
        {
            public string des { get; set; }
            public List<InfoGeneralFoto> fotos { get; set; }
        }
    }
}
