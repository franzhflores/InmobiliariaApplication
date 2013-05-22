using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Media;
using System.Windows.Controls;
using System.Windows.Shapes;
using System.Windows.Media.Imaging;
using System.Windows.Input;

namespace Inmobiliaria.Client.UI
{

    public class InfoControler
    {
        public int Code { get; set; }
        public string NameController { get; set; }
        public bool IsEmpty { get; set; }

        private Control _control;
        public Control UsingControl
        {
            get
            {
                return _control;
            }
            set
            {
                DefaultColor = value.Background;
                _control = value;
            }
        }
        public Brush DefaultColor { get; set; }

        /// <summary>
        /// Event Handler
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void text_KeyUp(object sender, KeyEventArgs e)
        {
            if (((TextBox)sender).Text == "")
            {
                this.IsEmpty = true;
            }
            else
                this.IsEmpty = false;
        }

        public void datepicker_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            this.IsEmpty = false;
            ((DatePicker)sender).SelectedDateChanged -= datepicker_SelectedDateChanged;
        }

        public void combo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            this.IsEmpty = false;
            ((ComboBox)sender).SelectionChanged -= combo_SelectionChanged;
        }

    }

    public static class HelpValidacionesDeControles
    {
        private static bool flag;
        private static List<InfoControler> _listInfoController;

        public static bool SomeoneIsEmpty()
        {
            flag = false;
            foreach (var elem in _listInfoController)
            {
                if (elem.IsEmpty == true)
                {
                    elem.UsingControl.Background = Brushes.Red;
                    flag = true;
                }
                else
                {
                    elem.UsingControl.Background = elem.DefaultColor;
                }
            }

            return flag;
        }

        //de la foma  en el codigo cliente debe usarlo AddListenControlers(textbox1,textbox2, combobox2......)
        public static void AddListenControlers(params Control[] Controls)
        {
            _listInfoController = new List<InfoControler>();
            foreach (var currentControl in Controls)
            {
                try
                {
                    InfoControler infoControler = GetBuildInfoControler(currentControl);
                    Control controlerConcreto = GetBuildControlerReal(currentControl, infoControler);
                    infoControler.UsingControl = controlerConcreto;
                    _listInfoController.Add(infoControler);
                }
                catch (Exception)
                { }
            }
        }

        //de la foma  en el codigo cliente debe usarlo AddListenControlers(textbox1,textbox2, combobox2......)
        public static void AddListenControlers(UIElementCollection uiElements)
        {
            _listInfoController = new List<InfoControler>();
            foreach (var uiElement in uiElements)
            {
                try
                {
                    Control currentControl = (Control)uiElement;
                    InfoControler infoControler = GetBuildInfoControler(currentControl);
                    Control controlerConcreto = GetBuildControlerReal(currentControl, infoControler);
                    infoControler.UsingControl = controlerConcreto;
                    _listInfoController.Add(infoControler);
                }
                catch (Exception)
                { }
            }
        }

        public static void StartListenControlers(List<Control> Controls)
        {
 
        }

        private static InfoControler GetBuildInfoControler(Control controler)
        {
            InfoControler infocontroller = new InfoControler();
            infocontroller.Code = controler.GetHashCode();
            infocontroller.NameController = controler.Name;
            infocontroller.IsEmpty = true;
            infocontroller.DefaultColor = controler.Background;
            return infocontroller;
        }

        private static Control GetBuildControlerReal(Control currentControl, InfoControler infoControler)
        {

            if (currentControl is TextBox)
            {
                TextBox foundText = currentControl as TextBox;
                foundText.KeyUp += infoControler.text_KeyUp;
                return foundText;
            }

            if (currentControl is ComboBox)
            {
                ComboBox foundCombo = currentControl as ComboBox;
                foundCombo.SelectionChanged += infoControler.combo_SelectionChanged;
                return foundCombo;
            }

            if (currentControl is DatePicker)
            {
                DatePicker foundDate = currentControl as DatePicker;
                foundDate.SelectedDateChanged += infoControler.datepicker_SelectedDateChanged;
                return foundDate;
            }
            return null;
        }
    }
}
