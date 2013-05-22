using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Controls;
using Inmobiliaria.Client.UI.UserControls;

namespace Inmobiliaria.Client.UI
{
    public class ControladorUserControls
    {
        Win_ContenedorUserControls _winUserControlContainer;
        IActionUserControl uc_actual;
        public ControladorUserControls()
        {
        }

        public void PutUserControlIntoWin(IActionUserControl uc)
        {
            this._winUserControlContainer = new Win_ContenedorUserControls();
            uc_actual = uc;
            _winUserControlContainer.btn_Cancelar.Click += EventHandler_Cancelar;
            _winUserControlContainer.btn_Aceptar.Click += uc.Aceptar;
            _winUserControlContainer.btn_Aceptar.Click += EventHandler_Aceptar;
            _winUserControlContainer.LoadUserControlToPanel(uc_actual as UserControl);
            _winUserControlContainer.ShowDialog();
        }

        private void EventHandler_Cancelar(object sender, EventArgs e)
        {
            _winUserControlContainer.Close();
        }

        private void EventHandler_Aceptar(object sender, EventArgs e)
        {
            if(uc_actual.IsPosibleClose)
                    _winUserControlContainer.Close();
        }

        public void CloseWinActive()
        {
            _winUserControlContainer.Close();
        }
    }
}
