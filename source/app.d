module app;

import vibe.vibe;

void main()
{
	import std.stdio;
	stderr.writeln("Does this log actually show up?");
	logDiagnostic("Program running");
	//auto logger = cast(shared) new FileLogger("/logdump.txt");
	//registerLogger(logger);
	auto settings = new HTTPServerSettings;
	import std.process;
	auto host = environment.get("HELLO_HOST", "0.0.0.0");
    auto port = to!ushort(environment.get("HELLO_PORT", "8080"));

	settings.port = port;
	settings.bindAddresses = [host];

	auto listener = listenHTTP(settings, &hello);
	scope (exit)
	{
		listener.stopListening();
	}

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
	runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World!");
}
