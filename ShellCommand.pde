import java.io.IOException;
import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteException;

static class ShellCommand{

    static int exec(String _command){
        CommandLine cl = CommandLine.parse(_command);
        DefaultExecutor de = new DefaultExecutor();
        de.setExitValue(0);
        int exitValue = 0;
        try{
            exitValue = de.execute(cl);
        } catch (ExecuteException e) {
            System.err.println("Execution failed.");
            e.printStackTrace();
        } catch (IOException e) {
            System.err.println("permission denied.");
            e.printStackTrace();
        }
        return exitValue;
    }
}
