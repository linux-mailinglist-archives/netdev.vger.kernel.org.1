Return-Path: <netdev+bounces-47758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D77EB464
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977C22812CF
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834341A8D;
	Tue, 14 Nov 2023 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fTZhr45d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DF41A8A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:05:38 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AA1130
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ce28faa92dso18802425ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699977935; x=1700582735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHrdXDFfscyFpONrVdySqTIzV7FdjofUrEPw5mpTz68=;
        b=fTZhr45dQ5WEWlGF3pumK35igSV0yHto6Evz+jOFE3+gRK6YPJuTkGp5JFlJEPpvXn
         QSSCWtYiBcEua4GzYHhq+trNhZ8bw/MmFx7RprsncJuetDGbbf+3HvPrkZStHOheLcVN
         sjCUS5mN/OOZuisphDD/1CeLzvk6da3ZkL7w2a3J3X0Jlzvfvdiqzpfa5TJEYEdVBSM2
         CCoItK8nKW+ZO4KSuWwYxaSN+uxNZi38MT9ct3IIgg2A2KLn2u466SZEK8QNEB/qC14e
         HCC7cVsJRPlsz8dzseg3BffNkhD8WInEf3zJVH/9vRy2VQ7IOtOzkRyVwqqv/PWEA1TJ
         vl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977935; x=1700582735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHrdXDFfscyFpONrVdySqTIzV7FdjofUrEPw5mpTz68=;
        b=XscNd4YnpkZP/fxf8YBoaFSOlYUHAkIA4mtwzRXlNgbmU07LOL1mTKGdhgcncgneuK
         3cLjIGt8O6NQj4k0EgOwZPW9ypTd3RAxKYoLgRlvzFF103pMK0ZgKZg3OOmjLj7x5w52
         0uh2YfkBv6wdOrOv9x0ct3bjs8p1MXZLlPkpuZfPOUv2NPN1MDxJ8bJ9RiqG6ms5ZYgN
         UUayGNrU1OtgJtzA8cBjV0AIu4TYH4VB2JDhRwJP3NYrdjZ9q+ILgz4BDOSvqhd6xpG4
         WdDVwyVu0/xsu7rPd8tIlPeWiQG3lbIgv9xJIJtOtJRxiWEkxfbRLG1l3CxCaMZyQ2LV
         4+VQ==
X-Gm-Message-State: AOJu0Ywu5hrB5SZgkJIINwnBbH3LSdZLLtU1ABRDBhVGM1FNxR6E4Q7A
	+8cYsVZQ68gepJZu50mPkaSL1d4lMQo5c5AOPIU=
X-Google-Smtp-Source: AGHT+IFTRchxdTp7Iwe2c/CyehJowEuuBYe6EGowewzANTEbwkqSUbUOyvE2L85jLtkNtYIGp1WPHg==
X-Received: by 2002:a17:902:a407:b0:1cc:3a8a:f19b with SMTP id p7-20020a170902a40700b001cc3a8af19bmr2465360plq.14.1699977935393;
        Tue, 14 Nov 2023 08:05:35 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:fa3f:3165:385:80b3])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c46d04d001sm5833048plg.87.2023.11.14.08.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:05:35 -0800 (PST)
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
Subject: [PATCH net-next 1/4] selftests: tc-testing: drop '-N' argument from nsPlugin
Date: Tue, 14 Nov 2023 13:04:39 -0300
Message-Id: <20231114160442.1023815-2-pctammela@mojatatu.com>
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

This argument would bypass the net namespace creation and run the test in
the root namespace, even if nsPlugin was specified.
Drop it as it's the same as commenting out the nsPlugin from a test and adds
additional complexity to the plugin code.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/plugin-lib/nsPlugin.py         | 49 +++++--------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index b62429b0fcdb..2297b4568ca9 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -28,10 +28,7 @@ def prepare_suite(obj, test):
     shadow['DEV2'] = original['DEV2']
     obj.args.NAMES = shadow
 
-    if obj.args.namespace:
-        obj._ns_create()
-    else:
-        obj._ports_create()
+    obj._ns_create()
 
     # Make sure the netns is visible in the fs
     while True:
@@ -75,10 +72,7 @@ class SubPlugin(TdcPlugin):
         if self.args.verbose:
             print('{}.post_case'.format(self.sub_class))
 
-        if self.args.namespace:
-            self._ns_destroy()
-        else:
-            self._ports_destroy()
+        self._ns_destroy()
 
     def post_suite(self, index):
         if self.args.verbose:
@@ -93,24 +87,11 @@ class SubPlugin(TdcPlugin):
 
             subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
 
-    def add_args(self, parser):
-        super().add_args(parser)
-        self.argparser_group = self.argparser.add_argument_group(
-            'netns',
-            'options for nsPlugin(run commands in net namespace)')
-        self.argparser_group.add_argument(
-            '-N', '--no-namespace', action='store_false', default=True,
-            dest='namespace', help='Don\'t run commands in namespace')
-        return self.argparser
-
     def adjust_command(self, stage, command):
         super().adjust_command(stage, command)
         cmdform = 'list'
         cmdlist = list()
 
-        if not self.args.namespace:
-            return command
-
         if self.args.verbose:
             print('{}.adjust_command'.format(self.sub_class))
 
@@ -144,8 +125,6 @@ class SubPlugin(TdcPlugin):
         cmds.append(self._replace_keywords('link add $DEV0 type veth peer name $DEV1'))
         cmds.append(self._replace_keywords('link set $DEV0 up'))
         cmds.append(self._replace_keywords('link add $DUMMY type dummy'))
-        if not self.args.namespace:
-            cmds.append(self._replace_keywords('link set $DEV1 up'))
 
         return cmds
 
@@ -161,18 +140,17 @@ class SubPlugin(TdcPlugin):
     def _ns_create_cmds(self):
         cmds = []
 
-        if self.args.namespace:
-            ns = self.args.NAMES['NS']
+        ns = self.args.NAMES['NS']
 
-            cmds.append(self._replace_keywords('netns add {}'.format(ns)))
-            cmds.append(self._replace_keywords('link set $DEV1 netns {}'.format(ns)))
-            cmds.append(self._replace_keywords('link set $DUMMY netns {}'.format(ns)))
-            cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV1 up'.format(ns)))
-            cmds.append(self._replace_keywords('netns exec {} $IP link set $DUMMY up'.format(ns)))
+        cmds.append(self._replace_keywords('netns add {}'.format(ns)))
+        cmds.append(self._replace_keywords('link set $DEV1 netns {}'.format(ns)))
+        cmds.append(self._replace_keywords('link set $DUMMY netns {}'.format(ns)))
+        cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV1 up'.format(ns)))
+        cmds.append(self._replace_keywords('netns exec {} $IP link set $DUMMY up'.format(ns)))
 
-            if self.args.device:
-                cmds.append(self._replace_keywords('link set $DEV2 netns {}'.format(ns)))
-                cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV2 up'.format(ns)))
+        if self.args.device:
+            cmds.append(self._replace_keywords('link set $DEV2 netns {}'.format(ns)))
+            cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV2 up'.format(ns)))
 
         return cmds
 
@@ -192,9 +170,8 @@ class SubPlugin(TdcPlugin):
         Destroy the network namespace for testing (and any associated network
         devices as well)
         '''
-        if self.args.namespace:
-            self._exec_cmd('post', self._ns_destroy_cmd())
-            self._ports_destroy()
+        self._exec_cmd('post', self._ns_destroy_cmd())
+        self._ports_destroy()
 
     @cached_property
     def _proc(self):
-- 
2.40.1


