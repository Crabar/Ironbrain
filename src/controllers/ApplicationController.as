package controllers
{
import models.ApplicationModel;

public class ApplicationController
{
    private static var _instance:ApplicationController;

    public static function get instance():ApplicationController
    {
        if (!_instance)
            _instance = new ApplicationController();

        return _instance;
    }

    public function ApplicationController()
    {
    }

    private var _model:ApplicationModel;

    public function changeView(view:String, data:Object = null):void
    {
        _model.currentViewId = view;
        _model.currentView.model = _model.getModel(view);
        _model.currentView.data = data;
    }

    public function init(model:ApplicationModel):void
    {
        _model = model;
    }
}
}