using System;
using System.IO;
using System.Linq;
using Mono.Cecil;
using Mono.Cecil.Cil;

internal static class DisableFriendlyRedirect
{
    public static int Main(string[] args)
    {
        if (args.Length != 1)
        {
            Console.Error.WriteLine("Expected the path to A.dll.");
            return 1;
        }

        var assembly = AssemblyDefinition.ReadAssembly(args[0]);
        var routeConfig = assembly.MainModule.Types.Single(type => type.FullName == "A.RouteConfig");
        var registerRoutes = routeConfig.Methods.Single(method => method.Name == "RegisterRoutes");
        var redirectMode = registerRoutes.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Ldc_I4_0);

        redirectMode.OpCode = OpCodes.Ldc_I4_2;
        var patchedPath = args[0] + ".patched";
        assembly.Write(patchedPath);
        assembly.Dispose();
        File.Delete(args[0]);
        File.Move(patchedPath, args[0]);
        return 0;
    }
}
