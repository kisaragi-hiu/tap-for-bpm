public class TapForBPM : Gtk.Application {
    public TapForBPM () {
        Object (
            application_id: "com.kisaragi-hiu.tap-for-bpm",
            flags: ApplicationFlags.FLAGS_NONE
            );
    }

    protected override void activate () {
        var average_label = new Gtk.Label (_("Average BPM:"));
        var integer_label = new Gtk.Label (_("Closest Integer:"));
        var count_label = new Gtk.Label (_("Taps:"));
        var count = 0;

        var button = new Gtk.Button.with_label (_("Click"));
        button.clicked.connect (() => {
                count += 1;
                button.label = _(count.to_string ());
            });

        var header = new Gtk.HeaderBar ();
        var title = new Gtk.Label (_("Tap for BPM"));
        header.custom_title = title;
        header.show_close_button = true;

        var layout = new Gtk.Grid ();
        layout.orientation = Gtk.Orientation.VERTICAL;
        layout.column_spacing = 6;
        layout.row_spacing = 6;

        layout.attach (button, 0, 0, 1, 1);
        layout.attach (average_label, 0, 1, 1, 1);
        layout.attach (integer_label, 0, 2, 1, 1);
        var window = new Gtk.ApplicationWindow (this);
        window.add (layout);
        window.set_titlebar (header);
        window.show_all ();
    }

    public static int main (string[] args) {
        var app = new TapForBPM ();
        return app.run (args);
    }
}
