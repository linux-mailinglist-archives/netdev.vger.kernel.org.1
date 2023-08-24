Return-Path: <netdev+bounces-30430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23838787467
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EC41C20E3B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C114263;
	Thu, 24 Aug 2023 15:38:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317513AC0
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:38:17 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26F2CCB
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:38:14 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56ee1ed7781so10035eaf.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692891494; x=1693496294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znNZpSkBCgvI5LFYPjmdkdJz88UeYmVPu/+93Ij5MQo=;
        b=LXUMPz/ReAaEvOvQWCDNbyiOINiZLQXL6ZKhk2Ab69qrpxPA39yiCu7IJQFVHESffd
         aInewXYrxQW5F9vN3U6W496XgMB+pKEjjteoDAep0KR4UYP8dLCjyGV16bVAn2i5hHM+
         94UAYxuhrUusNz2oxMttku6AxMYrPr83RSwlG8pxUu5+RMBZHWef6zihDQfdhUaclOo6
         SSNp2Kbatb4H6R6eKE+/PcPUG5FqjWydXArw01bBx3R5Z7e4E33V8D6g+QZh5HPS+g16
         bH1fpyTtDJe0GMUAl6WFUycSfklobthgbc41V1ZBJK3WrwAxunMWQ8YuXiCUYL7RGPGH
         rG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891494; x=1693496294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znNZpSkBCgvI5LFYPjmdkdJz88UeYmVPu/+93Ij5MQo=;
        b=V5vZ6mz0ez/R4Ya3PBQkztrT50xXUcr2+t3ezDzotGGNLo3Ph7fNZp6OxAHSjSgSS5
         KXNNRoeqmUfgq/4LLQgMtrmln7XgbMOE2+colJTOIqinhV0tY6DbWiqjux3c49ewJAxN
         gJjlySju8PJzssa2vKcrp6tCo9RPNzrHbwNQjRyiMC15yxHPwP6J/zzKrPSdid4z5zJg
         gnOEHcqsWI30dy1ICAEW6tZOuUfzfrhOih4n9QfcieWSqxkB7FuvAUrCLbs6vN9t7QjX
         owGz0vADrWyBZjZBfOJ8es3+LC1VHnm0iEkBTv5a5RP03uaH4KZFSVNLKdNkHpr2927n
         oGPQ==
X-Gm-Message-State: AOJu0Yy017jq66a6X2Zz6vm9omhi6Wv5YxVJS9BuWWgKYITEMtDx1oip
	yRLA1XLAZ0ttKkcqLVWFRjs7Q5p8sVT37sr2hDY=
X-Google-Smtp-Source: AGHT+IFwdHS66vaTs8uVi9tB9hTrkAALn9Mu92anutaIFWnoozlkXMPzNegHztMX624zZRozWIlTnQ==
X-Received: by 2002:a4a:9b52:0:b0:571:1fad:ebe1 with SMTP id e18-20020a4a9b52000000b005711fadebe1mr2358398ook.5.1692891493795;
        Thu, 24 Aug 2023 08:38:13 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:ebd6:5010:2cd8:55fb])
        by smtp.gmail.com with ESMTPSA id q126-20020a4a4b84000000b0056c81dedb3bsm7592392ooa.8.2023.08.24.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:38:13 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	shaozhengchao@huawei.com,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next v2 3/4] selftests/tc-testing: implement tdc parallel test run
Date: Thu, 24 Aug 2023 12:37:35 -0300
Message-Id: <20230824153736.629961-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824153736.629961-1-pctammela@mojatatu.com>
References: <20230824153736.629961-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use a Python process pool to run the tests in parallel.
Not all tests can run in parallel, for instance tests that are not
namespaced and tests that use netdevsim, as they can conflict with one
another.

The code logic will split the tests into serial and parallel.
For the parallel tests, we build batches of 32 tests and queue each
batch on the process pool. For the serial tests, they are queued as a
whole into the process pool, which in turn executes them concurrently
with the parallel tests.

Even though the tests serialize on rtnl_lock in the kernel, this feature
showed results with a ~3x speedup on the wall time for the entire test suite
running in a VM:
   Before - 4m32.502s
   After - 1m19.202s

Examples:
   In order to run tdc using 4 processes:
      ./tdc.py -J4 <...>
   In order to run tdc using 1 process:
      ./tdc.py -J1 <...> || ./tdc.py <...>

Note that the kernel configuration will affect the speed of the tests,
especially if such configuration slows down process creation and/or
fork().

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/TdcResults.py        |   3 +-
 .../tc-testing/plugin-lib/nsPlugin.py         |  79 ++++++-----
 tools/testing/selftests/tc-testing/tdc.py     | 123 +++++++++++++++---
 3 files changed, 148 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/TdcResults.py b/tools/testing/selftests/tc-testing/TdcResults.py
index 1e4d95fdf8d0..e56817b97f08 100644
--- a/tools/testing/selftests/tc-testing/TdcResults.py
+++ b/tools/testing/selftests/tc-testing/TdcResults.py
@@ -59,7 +59,8 @@ class TestResult:
         return self.steps
 
 class TestSuiteReport():
-    _testsuite = []
+    def __init__(self):
+        self._testsuite = []
 
     def add_resultdata(self, result_data):
         if isinstance(result_data, TestResult):
diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 78acbfa5af9d..b62429b0fcdb 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -3,46 +3,65 @@ import signal
 from string import Template
 import subprocess
 import time
+from multiprocessing import Pool
 from functools import cached_property
 from TdcPlugin import TdcPlugin
 
 from tdc_config import *
 
+def prepare_suite(obj, test):
+    original = obj.args.NAMES
+
+    if 'skip' in test and test['skip'] == 'yes':
+        return
+
+    if 'nsPlugin' not in test['plugins']:
+        return
+
+    shadow = {}
+    shadow['IP'] = original['IP']
+    shadow['TC'] = original['TC']
+    shadow['NS'] = '{}-{}'.format(original['NS'], test['random'])
+    shadow['DEV0'] = '{}id{}'.format(original['DEV0'], test['id'])
+    shadow['DEV1'] = '{}id{}'.format(original['DEV1'], test['id'])
+    shadow['DUMMY'] = '{}id{}'.format(original['DUMMY'], test['id'])
+    shadow['DEV2'] = original['DEV2']
+    obj.args.NAMES = shadow
+
+    if obj.args.namespace:
+        obj._ns_create()
+    else:
+        obj._ports_create()
+
+    # Make sure the netns is visible in the fs
+    while True:
+        obj._proc_check()
+        try:
+            ns = obj.args.NAMES['NS']
+            f = open('/run/netns/{}'.format(ns))
+            f.close()
+            break
+        except:
+            time.sleep(0.1)
+            continue
+
+    obj.args.NAMES = original
+
 class SubPlugin(TdcPlugin):
     def __init__(self):
         self.sub_class = 'ns/SubPlugin'
         super().__init__()
 
     def pre_suite(self, testcount, testlist):
+        from itertools import cycle
+
         super().pre_suite(testcount, testlist)
 
         print("Setting up namespaces and devices...")
 
-        original = self.args.NAMES
-
-        for t in testlist:
-            if 'skip' in t and t['skip'] == 'yes':
-                continue
-
-            if 'nsPlugin' not in t['plugins']:
-                continue
-
-            shadow = {}
-            shadow['IP'] = original['IP']
-            shadow['TC'] = original['TC']
-            shadow['NS'] = '{}-{}'.format(original['NS'], t['random'])
-            shadow['DEV0'] = '{}id{}'.format(original['DEV0'], t['id'])
-            shadow['DEV1'] = '{}id{}'.format(original['DEV1'], t['id'])
-            shadow['DUMMY'] = '{}id{}'.format(original['DUMMY'], t['id'])
-            shadow['DEV2'] = original['DEV2']
-            self.args.NAMES = shadow
-
-            if self.args.namespace:
-                self._ns_create()
-            else:
-                self._ports_create()
-
-        self.args.NAMES = original
+        with Pool(self.args.mp) as p:
+            it = zip(cycle([self]), testlist)
+            p.starmap(prepare_suite, it)
 
     def pre_case(self, caseinfo, test_skip):
         if self.args.verbose:
@@ -51,16 +70,6 @@ class SubPlugin(TdcPlugin):
         if test_skip:
             return
 
-        # Make sure the netns is visible in the fs
-        while True:
-            self._proc_check()
-            try:
-                ns = self.args.NAMES['NS']
-                f = open('/run/netns/{}'.format(ns))
-                f.close()
-                break
-            except:
-                continue
 
     def post_case(self):
         if self.args.verbose:
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 3914caa14de1..a6718192aff3 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -17,6 +17,7 @@ import subprocess
 import time
 import traceback
 import random
+from multiprocessing import Pool
 from collections import OrderedDict
 from string import Template
 
@@ -477,26 +478,11 @@ def run_one_test(pm, args, index, tidx):
 
     return res
 
-def test_runner(pm, args, filtered_tests):
-    """
-    Driver function for the unit tests.
-
-    Prints information about the tests being run, executes the setup and
-    teardown commands and the command under test itself. Also determines
-    success/failure based on the information in the test case and generates
-    TAP output accordingly.
-    """
-    testlist = filtered_tests
+def prepare_run(pm, args, testlist):
     tcount = len(testlist)
-    index = 1
-    tap = ''
-    badtest = None
-    stage = None
     emergency_exit = False
     emergency_exit_message = ''
 
-    tsr = TestSuiteReport()
-
     try:
         pm.call_pre_suite(tcount, testlist)
     except Exception as ee:
@@ -506,14 +492,37 @@ def test_runner(pm, args, filtered_tests):
         traceback.print_tb(ex_tb)
         emergency_exit_message = 'EMERGENCY EXIT, call_pre_suite failed with exception {} {}\n'.format(ex_type, ex)
         emergency_exit = True
-        stage = 'pre-SUITE'
 
     if emergency_exit:
-        pm.call_post_suite(index)
+        pm.call_post_suite(1)
         return emergency_exit_message
-    if args.verbose > 1:
+
+    if args.verbose:
         print('give test rig 2 seconds to stabilize')
+
     time.sleep(2)
+
+def purge_run(pm, index):
+    pm.call_post_suite(index)
+
+def test_runner(pm, args, filtered_tests):
+    """
+    Driver function for the unit tests.
+
+    Prints information about the tests being run, executes the setup and
+    teardown commands and the command under test itself. Also determines
+    success/failure based on the information in the test case and generates
+    TAP output accordingly.
+    """
+    testlist = filtered_tests
+    tcount = len(testlist)
+    index = 1
+    tap = ''
+    badtest = None
+    stage = None
+
+    tsr = TestSuiteReport()
+
     for tidx in testlist:
         if "flower" in tidx["category"] and args.device == None:
             errmsg = "Tests using the DEV2 variable must define the name of a "
@@ -576,7 +585,68 @@ def test_runner(pm, args, filtered_tests):
         if input(sys.stdin):
             print('got something on stdin')
 
-    pm.call_post_suite(index)
+    return (index, tsr)
+
+def mp_bins(alltests):
+    serial = []
+    parallel = []
+
+    for test in alltests:
+        if 'nsPlugin' not in test['plugins']:
+            serial.append(test)
+        else:
+            # We can only create one netdevsim device at a time
+            if 'netdevsim/new_device' in str(test['setup']):
+                serial.append(test)
+            else:
+                parallel.append(test)
+
+    return (serial, parallel)
+
+def __mp_runner(tests):
+    (_, tsr) = test_runner(mp_pm, mp_args, tests)
+    return tsr._testsuite
+
+def test_runner_mp(pm, args, alltests):
+    prepare_run(pm, args, alltests)
+
+    (serial, parallel) = mp_bins(alltests)
+
+    batches = [parallel[n : n + 32] for n in range(0, len(parallel), 32)]
+    batches.insert(0, serial)
+
+    print("Executing {} tests in parallel and {} in serial".format(len(parallel), len(serial)))
+    print("Using {} batches".format(len(batches)))
+
+    # We can't pickle these objects so workaround them
+    global mp_pm
+    mp_pm = pm
+
+    global mp_args
+    mp_args = args
+
+    with Pool(args.mp) as p:
+        pres = p.map(__mp_runner, batches)
+
+    tsr = TestSuiteReport()
+    for trs in pres:
+        for res in trs:
+            tsr.add_resultdata(res)
+
+    # Passing an index is not useful in MP
+    purge_run(pm, None)
+
+    return tsr
+
+def test_runner_serial(pm, args, alltests):
+    prepare_run(pm, args, alltests)
+
+    if args.verbose:
+        print("Executing {} tests in serial".format(len(alltests)))
+
+    (index, tsr) = test_runner(pm, args, alltests)
+
+    purge_run(pm, index)
 
     return tsr
 
@@ -605,12 +675,15 @@ def load_from_file(filename):
                 k['filename'] = filename
     return testlist
 
+def identity(string):
+    return string
 
 def args_parse():
     """
     Create the argument parser.
     """
     parser = argparse.ArgumentParser(description='Linux TC unit tests')
+    parser.register('type', None, identity)
     return parser
 
 
@@ -668,6 +741,9 @@ def set_args(parser):
     parser.add_argument(
         '-P', '--pause', action='store_true',
         help='Pause execution just before post-suite stage')
+    parser.add_argument(
+        '-J', '--multiprocess', type=int, default=1, dest='mp',
+        help='Run tests in parallel whenever possible')
     return parser
 
 
@@ -888,7 +964,12 @@ def set_operation_mode(pm, parser, args, remaining):
         except PluginDependencyException as pde:
             print('The following plugins were not found:')
             print('{}'.format(pde.missing_pg))
-        catresults = test_runner(pm, args, alltests)
+
+        if args.mp > 1:
+            catresults = test_runner_mp(pm, args, alltests)
+        else:
+            catresults = test_runner_serial(pm, args, alltests)
+
         if catresults.count_failures() != 0:
             exit_code = 1 # KSFT_FAIL
         if args.format == 'none':
-- 
2.39.2


