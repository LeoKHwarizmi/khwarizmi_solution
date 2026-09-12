
import json
import os
import shutil
import subprocess
import tempfile

from http.server import (
    BaseHTTPRequestHandler,
    HTTPServer,
)


# ============================================================
# CONFIGURATION
# ============================================================

HOST = "0.0.0.0"

PORT = int(os.environ.get("PORT", "9000"))


# ============================================================
# REQUEST HANDLER
# ============================================================

class CompilerHandler(
    BaseHTTPRequestHandler
):


    # ========================================================
    # CORS
    # ========================================================

    def send_cors_headers(self):

        self.send_header(
            "Access-Control-Allow-Origin",
            "*",
        )

        self.send_header(
            "Access-Control-Allow-Methods",
            "POST, OPTIONS",
        )

        self.send_header(
            "Access-Control-Allow-Headers",
            "Content-Type",
        )


    # ========================================================
    # OPTIONS
    # ========================================================

    def do_OPTIONS(self):

        self.send_response(
            204,
        )

        self.send_cors_headers()

        self.end_headers()


    # ========================================================
    # POST /compile
    # ========================================================

    def do_POST(self):

        if self.path != "/compile":

            self.send_json(
                {
                    "error":
                        "Unknown endpoint.",
                },
                404,
            )

            return


        temp_dir = None


        try:

            # =================================================
            # READ REQUEST
            # =================================================

            content_length = int(
                self.headers.get(
                    "Content-Length",
                    "0",
                )
            )


            body = self.rfile.read(
                    content_length,
                )


            # =================================================
            # PARSE JSON
            # =================================================

            data = json.loads(
                    body.decode(
                        "utf-8",
                    )
                )


            # =================================================
            # READ FILES
            # =================================================

            files = data.get(
                    "files",
                )


            if not isinstance(
                files,
                dict,
            ):

                self.send_json(
                    {
                        "error":
                            "No files received.",
                    },
                    400,
                )

                return


            # =================================================
            # FIND MAIN.DART
            # =================================================

            dart_code = files.get(
                    "main.dart",
                    "",
                )


            if not isinstance(
                dart_code,
                str,
            ):

                self.send_json(
                    {
                        "error":
                            "main.dart must contain text.",
                    },
                    400,
                )

                return


            if not dart_code.strip():

                self.send_json(
                    {
                        "error":
                            "main.dart is empty.",
                    },
                    400,
                )

                return


            # =================================================
            # CREATE TEMP DIRECTORY
            # =================================================

            temp_dir = tempfile.mkdtemp(
                    prefix="dart_web_ide_",
                )


            # =================================================
            # WRITE ALL FILES
            # =================================================

            for filename, content in files.items():

                if not isinstance(
                    filename,
                    str,
                ):

                    continue


                if not isinstance(
                    content,
                    str,
                ):

                    continue


                # ------------------------------------------------
                # Security:
                # only allow normal relative file paths.
                # ------------------------------------------------

                filename = filename.replace(
                        "\\",
                        "/",
                    )


                if filename.startswith(
                    "/",
                ):

                    continue


                if ".." in filename.split("/"):

                    continue


                file_path = os.path.join(
                        temp_dir,
                        filename,
                    )


                directory = os.path.dirname(
                        file_path,
                    )


                os.makedirs(
                    directory,
                    exist_ok=True,
                )


                with open(
                    file_path,
                    "w",
                    encoding="utf-8",
                ) as file:

                    file.write(
                        content,
                    )


            # =================================================
            # MAIN DART PATH
            # =================================================

            dart_file = os.path.join(
                    temp_dir,
                    "main.dart",
                )


            js_file = os.path.join(
                    temp_dir,
                    "main.js",
                )


            # =================================================
            # COMPILE DART → JAVASCRIPT
            # =================================================

            command = [

                "dart",

                "compile",

                "js",

                dart_file,

                "-o",

                js_file,

            ]


            print()

            print(
                "[compiler] Compiling:",
                dart_file,
            )

            print(
                "[compiler] Files:",
                ", ".join(
                    files.keys()
                ),
            )


            result = subprocess.run(
                    command,
                    capture_output=True,
                    text=True,
                    timeout=60,
                )


            # =================================================
            # COMPILATION FAILED
            # =================================================

            if result.returncode != 0:

                error = result.stderr.strip()


                if not error:

                    error = result.stdout.strip()


                self.send_json(
                    {
                        "error":
                            error,
                    },
                    200,
                )

                return


            # =================================================
            # READ JAVASCRIPT
            # =================================================

            with open(
                js_file,
                "r",
                encoding="utf-8",
            ) as file:

                javascript = file.read()


            # =================================================
            # RETURN JAVASCRIPT
            # =================================================

            self.send_json(
                {
                    "javascript":
                        javascript,
                },
                200,
            )


        except subprocess.TimeoutExpired:

            self.send_json(
                {
                    "error":
                        "Dart compilation timed out.",
                },
                200,
            )


        except json.JSONDecodeError:

            self.send_json(
                {
                    "error":
                        "Invalid JSON request.",
                },
                400,
            )


        except Exception as error:

            self.send_json(
                {
                    "error":
                        str(error),
                },
                500,
            )


        finally:

            # =================================================
            # DELETE TEMPORARY PROJECT
            # =================================================

            if temp_dir is not None:

                try:

                    shutil.rmtree(
                        temp_dir,
                    )

                except Exception:

                    pass


    # ========================================================
    # SEND JSON
    # ========================================================

    def send_json(
        self,
        data,
        status=200,
    ):

        response = json.dumps(
                data,
            ).encode(
                "utf-8",
            )


        self.send_response(
            status,
        )


        self.send_cors_headers()


        self.send_header(
            "Content-Type",
            "application/json",
        )


        self.send_header(
            "Content-Length",
            str(
                len(response)
            ),
        )


        self.end_headers()


        self.wfile.write(
            response,
        )


    # ========================================================
    # QUIET LOGGING
    # ========================================================

    def log_message(
        self,
        format,
        *args,
    ):

        print(
            "[compiler]",
            format % args,
        )


# ============================================================
# START SERVER
# ============================================================

def main():

    server = HTTPServer(
            (
                HOST,
                PORT,
            ),
            CompilerHandler,
        )


    print()

    print(
        "=========================================="
    )

    print(
        "       DART WEB IDE COMPILER"
    )

    print(
        "=========================================="
    )

    print(
        f"Server: http://{HOST}:{PORT}"
    )

    print(
        "Endpoint: POST /compile"
    )

    print(
        "Multi-file project: ENABLED"
    )

    print(
        "Press Ctrl+C to stop."
    )

    print(
        "=========================================="
    )

    print()


    try:

        server.serve_forever()

    except KeyboardInterrupt:

        print()

        print(
            "Compiler server stopped."
        )

    finally:

        server.server_close()


# ============================================================
# ENTRY POINT
# ============================================================

if __name__ == "__main__":

    main()
