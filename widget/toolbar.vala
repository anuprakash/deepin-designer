using Gtk;

namespace Widgets {
    public class Toolbar : Gtk.Overlay {
        public ImageButton close_button;
        public ImageButton max_button;
        public ImageButton menu_button;
        public ImageButton min_button;
        public ImageButton unmax_button;
        public Box max_toggle_box;
        public Box window_button_box;
        public Box window_close_button_box;
        public Label title_label;
		public int height = Constant.TITLEBAR_HEIGHT;
        public int logo_width = 48;
        public int logo_margin_top = 8;
        public int button_margin_right = 5;
        public int button_margin_top = 8;
        public Widgets.WindowEventArea event_area;
        public Gdk.RGBA background_color;
        public Gdk.RGBA frame_color;

        public signal void close_window();
        
        public Toolbar() {
			set_size_request(-1, height);
            
            window_button_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            window_close_button_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            
            background_color = Utils.hex_to_rgba("#f2f2f2", 0.8);
            frame_color = Utils.hex_to_rgba("#303030", 0.1);
            
            menu_button = new ImageButton("window_menu", true);
            min_button = new ImageButton("window_min", true);
            max_button = new ImageButton("window_max", true);
            unmax_button = new ImageButton("window_unmax", true);
            close_button = new ImageButton("window_close", true);
			
            window_button_box.margin_end = button_margin_right;
            window_button_box.margin_top = button_margin_top;
            
            close_button.click.connect((w) => {
                    close_window();
                });
            
            max_toggle_box = new Box(Gtk.Orientation.HORIZONTAL, 0);
            
            min_button.button_release_event.connect((w, e) => {
                    ((Gtk.Window) w.get_toplevel()).iconify();
                    
                    return false;
                });
            max_button.button_release_event.connect((w, e) => {
                    ((Gtk.Window) w.get_toplevel()).maximize();

                    return false;
                });
            unmax_button.button_release_event.connect((w, e) => {
                    ((Gtk.Window) w.get_toplevel()).unmaximize();

                    return false;
                });
            
            Box box = new Box(Gtk.Orientation.HORIZONTAL, 0);
			
			var logo_box = new Box(Gtk.Orientation.VERTICAL, 0);
			Gtk.Image logo_image = new Gtk.Image.from_file(Utils.get_image_path("title_icon.png"));
            logo_image.margin_top = logo_margin_top;
			logo_box.set_size_request(logo_width, Constant.TITLEBAR_HEIGHT);
			logo_box.pack_start(logo_image, false, false, 0);
			box.pack_start(logo_box, false, false, 0);
			
            max_toggle_box.add(max_button);

            title_label = new Label(null);
            title_label.margin_top = margin_top;
            box.pack_start(title_label, true, true, 0);
            box.pack_start(window_button_box, false, false, 0);
            
            window_button_box.pack_start(menu_button, false, false, 0);
            window_button_box.pack_start(min_button, false, false, 0);
            window_button_box.pack_start(max_toggle_box, false, false, 0);
            window_button_box.pack_start(close_button, false, false, 0);
            
            event_area = new Widgets.WindowEventArea(this);
            // Don't override window button area.
            event_area.margin_end = Constant.CLOSE_BUTTON_WIDTH * 4;
            
            add(box);
            add_overlay(event_area);

            box.draw.connect(on_draw);
        }
        
        private bool on_draw(Gtk.Widget widget, Cairo.Context cr) {
            Gtk.Allocation rect;
            widget.get_allocation(out rect);
            
            var window = (Widgets.Window) get_toplevel();
            
            Utils.set_context_color(cr, background_color);
            if (window.window_is_normal()) {
                Draw.draw_titlebar_rectangle(cr, 0, 0, rect.width, rect.height, 5);
            } else {
                Draw.draw_rectangle(cr, 0, 0, rect.width, rect.height);
            }
            
            Utils.set_context_color(cr, frame_color);
            Draw.draw_rectangle(cr, 0, rect.height - 1, rect.width, 1);
            
            Utils.propagate_draw((Gtk.Container) widget, cr);
            
            return true;
        }
        
        public void update_max_button() {
            Utils.remove_all_children(max_toggle_box);
            
            if (((Widgets.Window) get_toplevel()).window_is_max()) {
                max_toggle_box.add(unmax_button);
            } else {
                max_toggle_box.add(max_button);
            }
            
            max_toggle_box.show_all();
        }
    }

    public class ToolbarBox : Gtk.VBox {
        public Toolbar toolbar;
        public Gtk.Box expand_box;
        
        public ToolbarBox() {
            toolbar = new Toolbar();
            expand_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            
            pack_start(toolbar, false, false, 0);
            pack_start(expand_box, true, true, 0);
        }
    }
}