public class TapForBPM : Gtk.Application {
    public TapForBPM () {
        Object (
            application_id: "com.kisaragi-hiu.tap-for-bpm",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }
    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow(this);
        main_window.show_all();
    }
    public static int main (string[] args) {
        var app = new TapForBPM;
        return app.run(args);
    }
}
