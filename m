Return-Path: <netdev+bounces-255441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHslB6wSfmlLVQIAu9opvQ
	(envelope-from <netdev+bounces-255441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:33:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B195FC2728
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EE8C3037375
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F237D36C0C5;
	Sat, 31 Jan 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWjwGdDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE535B638;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=FuWEdT441tzclI/Mq/NQPYVrhS/X6u8EciedPxffAfTqG2Rq6tQqNFvXTeB+VULI+GfGFK70aH47kwVHmnQt6w3LXce6zf2+bsCx0L4KuJpF4+O0WasbDB3xvZhKGVLl1PgV5nc5EHEtZvLN34rpcuuomI8X9OHd35SVCpojCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=JgAESjeyMdGBTP/DT74Q19UkIkpbBQsD4O6RYrpw4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuTGCed9RDlz2hO8e/NSNrdP8hHIIzwTlTnaaRtzHe8cbKoPRqV+CWYCeo11hf13KdZU1W1wyxf/4tjeHsHjMp4R6B5bj3VNVXIiR6+E8Ryp1nW3Ae0WjsGGmMX5AS+zAp8ACOvpkohA0/30eYs7UCuQ+SyYDvczl7eRpaUtSR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWjwGdDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFFCC2BCAF;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=JgAESjeyMdGBTP/DT74Q19UkIkpbBQsD4O6RYrpw4MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWjwGdDDFTueSCv2dGBxIxcKTvz6ucwoQyWv2j0Enk5xwhFFzMr/Ai1X7nhp7J0Zn
	 KUZWXHrUjbulh7pnOD45vi2mjdH9u1F+3y55NKPPkrYzNy4Svo+LXOhE95ucYTCkqs
	 zm4i6CzQop1iYv6z8oZ8TnQOhSk/9BLdRXK06mDyPMJnjoIWWrE8MBP43XiAHGqFlT
	 sVOK8sBbmRg991tJEBDsw1JPHerSy4TVVL3/W1Lm52j+xgKTOMWxuYO30ST/Bj8CoK
	 tIyYF3hyUU0JvsJ+CCR7VWRAzO/+o1rg53sCKQ57wQ0PxRSyOm/afznVCo5F8higx+
	 OCD2IcsBZSeGA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVmN-1hvH;
	Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 40/41] docs: python: add helpers to run unit tests
Date: Sat, 31 Jan 2026 15:25:14 +0100
Message-ID: <b6502c5c5576d00afb6eb275600eb1fdc8abff87.1769867954.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255441-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B195FC2728
X-Rspamd-Action: no action

While python internal libraries have support for unit tests, its
output is not nice. Add a helper module to improve its output.

I wrote this module last year while testing some scripts I used
internally. The initial skeleton was generated with the help of
LLM tools, but it was higly modified to ensure that it will work
as I would expect.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/tools/python.rst      |   2 +
 Documentation/tools/unittest.rst    |  24 ++
 tools/lib/python/unittest_helper.py | 348 ++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)
 create mode 100644 Documentation/tools/unittest.rst
 create mode 100755 tools/lib/python/unittest_helper.py

diff --git a/Documentation/tools/python.rst b/Documentation/tools/python.rst
index 1444c1816735..3b7299161f20 100644
--- a/Documentation/tools/python.rst
+++ b/Documentation/tools/python.rst
@@ -11,3 +11,5 @@ Python libraries
    feat
    kdoc
    kabi
+
+   unittest
diff --git a/Documentation/tools/unittest.rst b/Documentation/tools/unittest.rst
new file mode 100644
index 000000000000..14a2b2a65236
--- /dev/null
+++ b/Documentation/tools/unittest.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Python unittest
+===============
+
+Checking consistency of python modules can be complex. Sometimes, it is
+useful to define a set of unit tests to help checking them.
+
+While the actual test implementation is usecase dependent, Python already
+provides a standard way to add unit tests by using ``import unittest``.
+
+Using such class, requires setting up a test suite. Also, the default format
+is a little bit ackward. To improve it and provide a more uniform way to
+report errors, some unittest classes and functions are defined.
+
+
+Unittest helper module
+======================
+
+.. automodule:: lib.python.unittest_helper
+   :members:
+   :show-inheritance:
+   :undoc-members:
diff --git a/tools/lib/python/unittest_helper.py b/tools/lib/python/unittest_helper.py
new file mode 100755
index 000000000000..d2efb78d8561
--- /dev/null
+++ b/tools/lib/python/unittest_helper.py
@@ -0,0 +1,348 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025-2026: Mauro Carvalho Chehab <mchehab@kernel.org>.
+#
+# pylint: disable=C0103,R0912,R0914,E1101
+
+"""
+Provides helper functions and classes execute python unit tests.
+
+Those help functions provide a nice colored output summary of each
+executed test and, when a test fails, it shows the different in diff
+format when running in verbose mode, like::
+
+    $ tools/unittests/nested_match.py -v
+    ...
+    Traceback (most recent call last):
+    File "/new_devel/docs/tools/unittests/nested_match.py", line 69, in test_count_limit
+        self.assertEqual(replaced, "bar(a); bar(b); foo(c)")
+        ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+    AssertionError: 'bar(a) foo(b); foo(c)' != 'bar(a); bar(b); foo(c)'
+    - bar(a) foo(b); foo(c)
+    ?       ^^^^
+    + bar(a); bar(b); foo(c)
+    ?       ^^^^^
+    ...
+
+It also allows filtering what tests will be executed via ``-k`` parameter.
+
+Typical usage is to do::
+
+    from unittest_helper import run_unittest
+    ...
+
+    if __name__ == "__main__":
+        run_unittest(__file__)
+
+If passing arguments is needed, on a more complex scenario, it can be
+used like on this example::
+
+    from unittest_helper import TestUnits, run_unittest
+    ...
+    env = {'sudo': ""}
+    ...
+    if __name__ == "__main__":
+        runner = TestUnits()
+        base_parser = runner.parse_args()
+        base_parser.add_argument('--sudo', action='store_true',
+                                help='Enable tests requiring sudo privileges')
+
+        args = base_parser.parse_args()
+
+        # Update module-level flag
+        if args.sudo:
+            env['sudo'] = "1"
+
+        # Run tests with customized arguments
+        runner.run(__file__, parser=base_parser, args=args, env=env)
+"""
+
+import argparse
+import atexit
+import os
+import re
+import unittest
+import sys
+
+from unittest.mock import patch
+
+
+class Summary(unittest.TestResult):
+    """
+    Overrides ``unittest.TestResult`` class to provide a nice colored
+    summary. When in verbose mode, displays actual/expected difference in
+    unified diff format.
+    """
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+
+        #: Dictionary to store organized test results.
+        self.test_results = {}
+
+        #: max length of the test names.
+        self.max_name_length = 0
+
+    def startTest(self, test):
+        super().startTest(test)
+        test_id = test.id()
+        parts = test_id.split(".")
+
+        # Extract module, class, and method names
+        if len(parts) >= 3:
+            module_name = parts[-3]
+        else:
+            module_name = ""
+        if len(parts) >= 2:
+            class_name = parts[-2]
+        else:
+            class_name = ""
+
+        method_name = parts[-1]
+
+        # Build the hierarchical structure
+        if module_name not in self.test_results:
+            self.test_results[module_name] = {}
+
+        if class_name not in self.test_results[module_name]:
+            self.test_results[module_name][class_name] = []
+
+        # Track maximum test name length for alignment
+        display_name = f"{method_name}:"
+
+        self.max_name_length = max(len(display_name), self.max_name_length)
+
+    def _record_test(self, test, status):
+        test_id = test.id()
+        parts = test_id.split(".")
+        if len(parts) >= 3:
+            module_name = parts[-3]
+        else:
+            module_name = ""
+        if len(parts) >= 2:
+            class_name = parts[-2]
+        else:
+            class_name = ""
+        method_name = parts[-1]
+        self.test_results[module_name][class_name].append((method_name, status))
+
+    def addSuccess(self, test):
+        super().addSuccess(test)
+        self._record_test(test, "OK")
+
+    def addFailure(self, test, err):
+        super().addFailure(test, err)
+        self._record_test(test, "FAIL")
+
+    def addError(self, test, err):
+        super().addError(test, err)
+        self._record_test(test, "ERROR")
+
+    def addSkip(self, test, reason):
+        super().addSkip(test, reason)
+        self._record_test(test, f"SKIP ({reason})")
+
+    def printResults(self):
+        """
+        Print results using colors if tty.
+        """
+        # Check for ANSI color support
+        use_color = sys.stdout.isatty()
+        COLORS = {
+            "OK":            "\033[32m",   # Green
+            "FAIL":          "\033[31m",   # Red
+            "SKIP":          "\033[1;33m", # Yellow
+            "PARTIAL":       "\033[33m",   # Orange
+            "EXPECTED_FAIL": "\033[36m",   # Cyan
+            "reset":         "\033[0m",    # Reset to default terminal color
+        }
+        if not use_color:
+            for c in COLORS:
+                COLORS[c] = ""
+
+        # Calculate maximum test name length
+        if not self.test_results:
+            return
+        try:
+            lengths = []
+            for module in self.test_results.values():
+                for tests in module.values():
+                    for test_name, _ in tests:
+                        lengths.append(len(test_name) + 1)  # +1 for colon
+            max_length = max(lengths) + 2  # Additional padding
+        except ValueError:
+            sys.exit("Test list is empty")
+
+        # Print results
+        for module_name, classes in self.test_results.items():
+            print(f"{module_name}:")
+            for class_name, tests in classes.items():
+                print(f"    {class_name}:")
+                for test_name, status in tests:
+                    # Get base status without reason for SKIP
+                    if status.startswith("SKIP"):
+                        status_code = status.split()[0]
+                    else:
+                        status_code = status
+                    color = COLORS.get(status_code, "")
+                    print(
+                        f"        {test_name + ':':<{max_length}}{color}{status}{COLORS['reset']}"
+                    )
+            print()
+
+        # Print summary
+        print(f"\nRan {self.testsRun} tests", end="")
+        if hasattr(self, "timeTaken"):
+            print(f" in {self.timeTaken:.3f}s", end="")
+        print()
+
+        if not self.wasSuccessful():
+            print(f"\n{COLORS['FAIL']}FAILED (", end="")
+            failures = getattr(self, "failures", [])
+            errors = getattr(self, "errors", [])
+            if failures:
+                print(f"failures={len(failures)}", end="")
+            if errors:
+                if failures:
+                    print(", ", end="")
+                print(f"errors={len(errors)}", end="")
+            print(f"){COLORS['reset']}")
+
+
+def flatten_suite(suite):
+    """Flatten test suite hierarchy."""
+    tests = []
+    for item in suite:
+        if isinstance(item, unittest.TestSuite):
+            tests.extend(flatten_suite(item))
+        else:
+            tests.append(item)
+    return tests
+
+
+class TestUnits:
+    """
+    Helper class to set verbosity level.
+
+    This class discover test files, import its unittest classes and
+    executes the test on it.
+    """
+    def parse_args(self):
+        """Returns a parser for command line arguments."""
+        parser = argparse.ArgumentParser(description="Test runner with regex filtering")
+        parser.add_argument("-v", "--verbose", action="count", default=1)
+        parser.add_argument("-f", "--failfast", action="store_true")
+        parser.add_argument("-k", "--keyword",
+                            help="Regex pattern to filter test methods")
+        return parser
+
+    def run(self, caller_file=None, pattern=None,
+            suite=None, parser=None, args=None, env=None):
+        """
+        Execute all tests from the unity test file.
+
+        It contains several optional parameters:
+
+        ``caller_file``:
+            -  name of the file that contains test.
+
+               typical usage is to place __file__ at the caller test, e.g.::
+
+                    if __name__ == "__main__":
+                        TestUnits().run(__file__)
+
+        ``pattern``:
+            - optional pattern to match multiple file names. Defaults
+              to basename of ``caller_file``.
+
+        ``suite``:
+            - an unittest suite initialized by the caller using
+              ``unittest.TestLoader().discover()``.
+
+        ``parser``:
+            - an argparse parser. If not defined, this helper will create
+              one.
+
+        ``args``:
+            - an ``argparse.Namespace`` data filled by the caller.
+
+        ``env``:
+            - environment variables that will be passed to the test suite
+
+        At least ``caller_file`` or ``suite`` must be used, otherwise a
+        ``TypeError`` will be raised.
+        """
+        if not args:
+            if not parser:
+                parser = self.parse_args()
+            args = parser.parse_args()
+
+        if not caller_file and not suite:
+            raise TypeError("Either caller_file or suite is needed at TestUnits")
+
+        if env:
+            patcher = patch.dict(os.environ, env)
+            patcher.start()
+            # ensure it gets stopped after
+            atexit.register(patcher.stop)
+
+        verbose = args.verbose
+
+        if verbose >= 2:
+            unittest.TextTestRunner(verbosity=verbose).run = lambda suite: suite
+
+        # Load ONLY tests from the calling file
+        if not suite:
+            if not pattern:
+                pattern = caller_file
+
+            loader = unittest.TestLoader()
+            suite = loader.discover(start_dir=os.path.dirname(caller_file),
+                                    pattern=os.path.basename(caller_file))
+
+        # Flatten the suite for environment injection
+        tests_to_inject = flatten_suite(suite)
+
+        # Filter tests by method name if -k specified
+        if args.keyword:
+            try:
+                pattern = re.compile(args.keyword)
+                filtered_suite = unittest.TestSuite()
+                for test in tests_to_inject:  # Use the pre-flattened list
+                    method_name = test.id().split(".")[-1]
+                    if pattern.search(method_name):
+                        filtered_suite.addTest(test)
+                suite = filtered_suite
+            except re.error as e:
+                sys.stderr.write(f"Invalid regex pattern: {e}\n")
+                sys.exit(1)
+        else:
+            # Maintain original suite structure if no keyword filtering
+            suite = unittest.TestSuite(tests_to_inject)
+
+        if verbose >= 2:
+            resultclass = None
+        else:
+            resultclass = Summary
+
+        runner = unittest.TextTestRunner(verbosity=args.verbose,
+                                            resultclass=resultclass,
+                                            failfast=args.failfast)
+        result = runner.run(suite)
+        if resultclass:
+            result.printResults()
+
+        sys.exit(not result.wasSuccessful())
+
+
+def run_unittest(fname):
+    """
+    Basic usage of TestUnits class.
+
+    Use it when there's no need to pass any extra argument to the tests
+    with. The recommended way is to place this at the end of each
+    unittest module::
+
+        if __name__ == "__main__":
+            run_unittest(__file__)
+    """
+    TestUnits().run(fname)
-- 
2.52.0


