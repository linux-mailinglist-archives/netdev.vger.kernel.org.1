Return-Path: <netdev+bounces-47759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72327EB467
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE461F25017
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290A41A8A;
	Tue, 14 Nov 2023 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qd9FBdgA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55954174B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:05:40 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0D213D
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc329ce84cso51864685ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699977939; x=1700582739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfiY4VVFwJ9EGOwG+Y4qOUyYuus4s/HFryh1H4Lv07U=;
        b=qd9FBdgABGC1TgWB32Xhae29IjdcUVoS7ets1qhlh/pmqZjL5AGRj6YA2bUxPk8YE9
         dlS9CLi1CKHM1/RbRLph/rHCRQ7OZmNZM7B3Usau+T3pk3qu7720l/QSPHGjIWAHRl4n
         LPj4gEKViEYHlmy7nQ7UStkyP/rERoLLGuuaEuY9qtkJwPMj/35GaMveDbGXlGvdcNDs
         SSdkUsTC3vVDypHptCnL+/grSvqvjeBQjFyrl+U6V7M0z/Brze2jVHEUbgAbfjSzwuTn
         UP7iDoEaElKJmjBtku69wLZ8Mr0hyqJ7EvptzTb0ejN+XPjvXxUOx7QUhjqML4xY5Zzi
         rOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977939; x=1700582739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfiY4VVFwJ9EGOwG+Y4qOUyYuus4s/HFryh1H4Lv07U=;
        b=Qbhq8HT5o1R8eRZhkMi0ycguWmzSVXbL/VkaETPfsKG8tL+L3imHG/Nfrmr/QwT6Hs
         OYuUx1gggC+cT+mT9WTgb9RvsLAyVDGMRoTLCMyOClV5619Xos+Zi2jgCHnUc4b19aLg
         wOwRfWYX3QE+MVsZvkL6qDuJb8vNmykX7H81zXbz3p5HiJsGqDTmtY75Z8y467cl/0S5
         lHTEprQiOBaKA3baZUk85Q0jCMnMCLMROZJUIgl2idtQgCN9/x2Kn6G7ZgfLkg1+8Qha
         V6IHebqUzgsra1WBYiO+/V9S2fUUlt6NhHAWbRscVjxn5+T6rd2LPKbKGTFgGWYXLG8U
         hjWQ==
X-Gm-Message-State: AOJu0Yyt5JWfwhAixkokykpd8cFGfLUho/mgAGpw6D7zULA9hz5k7fWb
	azCb1MxsLwM/FOHNXj8mtJryeQk44X+EqnWSP+k=
X-Google-Smtp-Source: AGHT+IGMmaDK/L3Fu31bdemtqGN3xA9KIERntESyCN1g0Zi0q0R70gqRc5iNT3RrvcNuy4yRZDwzmQ==
X-Received: by 2002:a17:902:e84a:b0:1cc:6a09:a495 with SMTP id t10-20020a170902e84a00b001cc6a09a495mr2987047plg.44.1699977938667;
        Tue, 14 Nov 2023 08:05:38 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:fa3f:3165:385:80b3])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c46d04d001sm5833048plg.87.2023.11.14.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:05:38 -0800 (PST)
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
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 2/4] selftests: tc-testing: rework namespaces and devices setup
Date: Tue, 14 Nov 2023 13:04:40 -0300
Message-Id: <20231114160442.1023815-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114160442.1023815-1-pctammela@mojatatu.com>
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in the TC Workshop 0x17, our recent changes to tdc broke
downstream CI systems like tuxsuite. The issue is the classic problem
with rcu/workqueue objects where you can miss them if not enough wall time
has passed. The latter is subjective to the system and kernel config,
in my machine could be nanoseconds while in another could be microseconds
or more.

In order to make the suite deterministic, poll for the existence
of the objects in a reasonable manner. Talking netlink directly is the
the best solution in order to avoid paying the cost of multiple
'fork()' calls, so introduce a netlink based setup routine using
pyroute2. We leave the iproute2 one as a fallback when pyroute2 is not
available.

Also rework the iproute2 side to mimic the netlink routine where it
creates DEV0 as the peer of DEV1 and moves DEV1 into the net namespace.
This way when the namespace is deleted DEV0 is also deleted
automatically, leaving no margin for resource leaks.

Another bonus of this change is that our setup time sped up by a factor
of 2 when using netlink.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/plugin-lib/nsPlugin.py         | 69 +++++++++++++------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 2297b4568ca9..62974bd3a4a5 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -9,6 +9,14 @@ from TdcPlugin import TdcPlugin
 
 from tdc_config import *
 
+try:
+    from pyroute2 import netns
+    from pyroute2 import IPRoute
+    netlink = True
+except ImportError:
+    netlink = False
+    print("!!! Consider installing pyroute2 !!!")
+
 def prepare_suite(obj, test):
     original = obj.args.NAMES
 
@@ -28,7 +36,10 @@ def prepare_suite(obj, test):
     shadow['DEV2'] = original['DEV2']
     obj.args.NAMES = shadow
 
-    obj._ns_create()
+    if netlink == True:
+        obj._nl_ns_create()
+    else:
+        obj._ns_create()
 
     # Make sure the netns is visible in the fs
     while True:
@@ -67,7 +78,6 @@ class SubPlugin(TdcPlugin):
         if test_skip:
             return
 
-
     def post_case(self):
         if self.args.verbose:
             print('{}.post_case'.format(self.sub_class))
@@ -119,23 +129,41 @@ class SubPlugin(TdcPlugin):
             print('adjust_command:  return command [{}]'.format(command))
         return command
 
-    def _ports_create_cmds(self):
-        cmds = []
+    def _nl_ns_create(self):
+        ns = self.args.NAMES["NS"];
+        dev0 = self.args.NAMES["DEV0"];
+        dev1 = self.args.NAMES["DEV1"];
+        dummy = self.args.NAMES["DUMMY"];
 
-        cmds.append(self._replace_keywords('link add $DEV0 type veth peer name $DEV1'))
-        cmds.append(self._replace_keywords('link set $DEV0 up'))
-        cmds.append(self._replace_keywords('link add $DUMMY type dummy'))
-
-        return cmds
-
-    def _ports_create(self):
-        self._exec_cmd_batched('pre', self._ports_create_cmds())
-
-    def _ports_destroy_cmd(self):
-        return self._replace_keywords('link del $DEV0')
-
-    def _ports_destroy(self):
-        self._exec_cmd('post', self._ports_destroy_cmd())
+        if self.args.verbose:
+            print('{}._nl_ns_create'.format(self.sub_class))
+
+        netns.create(ns)
+        netns.pushns(newns=ns)
+        with IPRoute() as ip:
+            ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
+            ip.link('add', ifname=dummy, kind='dummy')
+            while True:
+                try:
+                    dev1_idx = ip.link_lookup(ifname=dev1)[0]
+                    dummy_idx = ip.link_lookup(ifname=dummy)[0]
+                    ip.link('set', index=dev1_idx, state='up')
+                    ip.link('set', index=dummy_idx, state='up')
+                    break
+                except:
+                    time.sleep(0.1)
+                    continue
+        netns.popns()
+
+        with IPRoute() as ip:
+            while True:
+                try:
+                    dev0_idx = ip.link_lookup(ifname=dev0)[0]
+                    ip.link('set', index=dev0_idx, state='up')
+                    break
+                except:
+                    time.sleep(0.1)
+                    continue
 
     def _ns_create_cmds(self):
         cmds = []
@@ -143,10 +171,13 @@ class SubPlugin(TdcPlugin):
         ns = self.args.NAMES['NS']
 
         cmds.append(self._replace_keywords('netns add {}'.format(ns)))
+        cmds.append(self._replace_keywords('link add $DEV1 type veth peer name $DEV0'))
         cmds.append(self._replace_keywords('link set $DEV1 netns {}'.format(ns)))
+        cmds.append(self._replace_keywords('link add $DUMMY type dummy'.format(ns)))
         cmds.append(self._replace_keywords('link set $DUMMY netns {}'.format(ns)))
         cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV1 up'.format(ns)))
         cmds.append(self._replace_keywords('netns exec {} $IP link set $DUMMY up'.format(ns)))
+        cmds.append(self._replace_keywords('link set $DEV0 up'.format(ns)))
 
         if self.args.device:
             cmds.append(self._replace_keywords('link set $DEV2 netns {}'.format(ns)))
@@ -159,7 +190,6 @@ class SubPlugin(TdcPlugin):
         Create the network namespace in which the tests will be run and set up
         the required network devices for it.
         '''
-        self._ports_create()
         self._exec_cmd_batched('pre', self._ns_create_cmds())
 
     def _ns_destroy_cmd(self):
@@ -171,7 +201,6 @@ class SubPlugin(TdcPlugin):
         devices as well)
         '''
         self._exec_cmd('post', self._ns_destroy_cmd())
-        self._ports_destroy()
 
     @cached_property
     def _proc(self):
-- 
2.40.1


