public class TapForBPM : Gtk.Application {
    public TapForBPM () {
        Object (
            application_id: "com.kisaragi-hiu.tap-for-bpm",
            flags: ApplicationFlags.FLAGS_NONE
            );
    }
    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow(this);
        var layout = new Gtk.Grid ();
        layout.orientation = Gtk.Orientation.VERTICAL;
        layout.column_spacing = 6;
        layout.row_spacing = 6;

        var button = new Gtk.Button.with_label (_("Click"));
        var title = new Gtk.Label (_("Tap for BPM"));
        var average_label = new Gtk.Label (_("Average BPM:"));
        var integer_label = new Gtk.Label (_("Closest Integer:"));
        var count = 0;

        layout.attach (title, 0, 0, 1, 1);
        layout.attach (button, 0, 1, 1, 1);
        layout.attach (average_label, 0, 2, 1, 1);
        layout.attach (integer_label, 0, 3, 1, 1);

        main_window.add (layout);
        button.clicked.connect (() => {
                count += 1;
                button.label = _(count.to_string ());
            });
        main_window.show_all ();
    }
    public static int main (string[] args) {
        var app = new TapForBPM ();
        return app.run (args);
    }
}
