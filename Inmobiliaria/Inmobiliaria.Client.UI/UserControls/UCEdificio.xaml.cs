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
    /// Lógica de interacción para UCEdificio.xaml
    /// </summary>
    public partial class UCEdificio : UserControl
    {

        ControladorUserControls _controlerUserControls;
        Grid _parentContainer;
        Model.Edificio edificioSelected;
        public UCEdificio(ControladorUserControls controlerUserControls, Grid parentContainer)
        {
            InitializeComponent();
            lbx_DataList.ItemsSource = LocalDataStore.ListEdificios;
            _controlerUserControls = controlerUserControls;
            _parentContainer = parentContainer;            
            HelpContentVisual.ListenExpanded(exp_Informacion, exp_Fotos);
        }

        private void btn_Update_Click(object sender, RoutedEventArgs e)
        {
            string idEdificio = getIdEdificioFromTag(sender);
            if (idEdificio == "") return;         
            Model.Edificio edificio = LocalDataStore.ListEdificios.Find(P => P.Id == idEdificio);
            _controlerUserControls.PutUserControlIntoWin(new UC_ModificarEdificio(edificio,lbx_DataList));
            
        }

        private void btn_Delete_Click(object sender, RoutedEventArgs e)
        {
            
            bool response = LocalDataStore.EliminarEdificio(getIdEdificioFromTag(sender));
            if (response)
            {
                MessageBox.Show("Archivo eliminado", "Eliminar un registro", MessageBoxButton.OK, MessageBoxImage.Information);
                lbx_DataList.Items.Refresh();
                //lbx_DataList.ItemsSource = LocalDataStore.ListEdificios;
            }
        }

        private void Nuevo_Click(object sender, RoutedEventArgs e)
        {
            _controlerUserControls.PutUserControlIntoWin(new UC_NuevoEdificio(lbx_DataList));
        }       

        private string getIdEdificioFromTag(object sender)
        {
            if (sender == null) return "";
            string idEdificio = (sender as Button).Tag.ToString();
            if (idEdificio == "") return"";
            return idEdificio;
        }

        private void btn_VerApartamentos_Click(object sender, RoutedEventArgs e)
        {
            UC_Apartamento uc_apartamento = new UC_Apartamento(_controlerUserControls,getIdEdificioFromTag(sender));
            uc_apartamento.btn_getBack.Click += EventHandler_GetBack;
            _parentContainer.Children.Add(uc_apartamento);
        }

        private void EventHandler_GetBack(object sender, EventArgs e)
        {
             var uc_departamento = _parentContainer.Children[1];
            _parentContainer.Children.Remove(uc_departamento);
        }

        private void lbx_DataList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            edificioSelected = e.AddedItems[0] as Model.Edificio;
            grid_Context.DataContext = LocalDataStore.GetViewDetailEdificio(edificioSelected);
            exp_Fotos.Content = new UC_ViewFotos(LocalDataStore.GetFotoEdificioOf(edificioSelected));
        }

        private void btn_Foto_Click(object sender, RoutedEventArgs e)
        {
            _controlerUserControls.PutUserControlIntoWin(new UC_NFotoEdificio(getIdEdificioFromTag(sender)));
        }
    }
}
