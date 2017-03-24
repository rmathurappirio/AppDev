public class SelNav_ProjectCanvasLifeCycle 
implements Canvas.CanvasLifecycleHandler {

    public Set<Canvas.ContextTypeEnum> excludeContextTypes(){
        Set<Canvas.ContextTypeEnum> excluded = new Set<Canvas.ContextTypeEnum>();
       // excluded.add(Canvas.ContextTypeEnum.USER);

        // Code goes here to add items to excluded list
        // that should be excluded from Context data

        return excluded;
    }

    public void onRender(Canvas.RenderContext renderContext) {

        // Code goes here to customize behavior when the app is rendered
        Canvas.EnvironmentContext env = renderContext.getEnvironmentContext();
        // Adding Entity Field for this canvas app when it runs with Estimate Object 
        Set<String> fields = new Set<String>{'Id','Name'};
        env.addEntityFields(fields);
    }
}