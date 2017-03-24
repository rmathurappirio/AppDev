public class MyCanvasLifecycleHandler implements Canvas.CanvasLifecycleHandler {
    public Set<Canvas.ContextTypeEnum> excludeContextTypes(){
        Set<Canvas.ContextTypeEnum> excluded = new Set<Canvas.ContextTypeEnum>();
        // Code goes here to add items to excluded list
        // that should be excluded from Context data
        excluded.add(Canvas.ContextTypeEnum.ORGANIZATION);
        excluded.add(Canvas.ContextTypeEnum.USER);
        return excluded;

    }
    public void onRender(Canvas.RenderContext renderContext) {
    // Code goes here to customize behavior when the app is rendered
    Canvas.ApplicationContext app = renderContext.getApplicationContext();
    Canvas.EnvironmentContext env = renderContext.getEnvironmentContext();
    
    //app.setCanvasUrlPath('/WebForm1.aspx');

    }
}