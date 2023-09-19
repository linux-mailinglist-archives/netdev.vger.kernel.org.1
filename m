Return-Path: <netdev+bounces-34988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EEB7A65C7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B29281705
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE7374FA;
	Tue, 19 Sep 2023 13:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAD37C8A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:54:44 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3BF7
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1d6baffcac2so2040493fac.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695131681; x=1695736481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqY5BMia8EeDFoc/kFEm3kU+3WuPvC9nyZmGo9lIKOw=;
        b=0bU6PO5vDVHfQAkDWRA24TQEQwTD1H5Aig0VEmQi3yiTcnYRRLLvDMrZDMx2ktm1PN
         nLNH6Brfat5OKDQELbxwQayiRCAO2S+xhjvEfeIcXqRtOu0YNsJv0nO/B6OQP4YR5Chg
         3ypsxaMbj3JghxLrGTPTpSWBaj8vCTAb8L/DgI6Sdh2Yi8kle4R/Cifi0s5QVxNc6D5Q
         uAlTWiPUo78B3I3vClBY7YgT1bK+gxwHYX3Os0hGTJgCNMV9kU3LHDmW0R6inCk1a1D2
         FN+enL0TqxEoStCDnwwY6U9lIOW6T+Fv65jBvpCAZfaBeMCtChrCi+3EqdSjjC8jNKF8
         NgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131681; x=1695736481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqY5BMia8EeDFoc/kFEm3kU+3WuPvC9nyZmGo9lIKOw=;
        b=LGhVL+bT+fbMtwYNuGT0vuFpZc/xFiBz0aU4AAuo3P8ABsb3ytkZv5fITPz+CMrJ4m
         czhMggeOXDM9+E7xJ2Cv/LUOpnwYboUyDwjOvE5a+GsKFePIInQrMVmiaVRQb8hTAiIk
         79jygVQE3JEoemoVXnrXKFFwFQ7UbKaK5CATbjEdI/9avG+Ofv0LTO4cCSFaELl6Ftp+
         BVWn8mGCRESAilXuRc6fEEaLRPmwQr02nRE/W+MhBtjBnO8XaJkzopvd4tPSf8M9eIOS
         /HE1iQeVKJ16VGoL+21oE8qZutIStCxiBY1NmBPN4NbT9o8IZqwQE5ZF5pcW813ayPvW
         JTow==
X-Gm-Message-State: AOJu0Yy7E/sbK/ojwuzirMmM7t5C9x+TxTct99jStnYEDdhKLZmLnAi9
	vwDzUTrWKC20nCngcTGjp48gXGNQihdn1jQhM/Q=
X-Google-Smtp-Source: AGHT+IEVSuTw0aXrrnoWkyiXRgpsVb4xaPVtd3p22m92yiwpVQ3LtYYcOjVWWGs2mQ4mi7841s7QxA==
X-Received: by 2002:a05:6870:4149:b0:1bb:b9d6:a879 with SMTP id r9-20020a056870414900b001bbb9d6a879mr14330601oad.38.1695131680699;
        Tue, 19 Sep 2023 06:54:40 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:cd1e:1428:689a:5af3])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870a3d600b001ccab369c09sm6004270oak.42.2023.09.19.06.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:54:40 -0700 (PDT)
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
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next 3/4] selftests/tc-testing: implement tdc parallel test run
Date: Tue, 19 Sep 2023 10:54:03 -0300
Message-Id: <20230919135404.1778595-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230919135404.1778595-1-pctammela@mojatatu.com>
References: <20230919135404.1778595-1-pctammela@mojatatu.com>
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

Tested-by: Davide Caratti <dcaratti@redhat.com>
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


