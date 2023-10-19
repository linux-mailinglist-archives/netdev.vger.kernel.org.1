Return-Path: <netdev+bounces-42742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA77D0085
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3876B281FF5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604B32C9D;
	Thu, 19 Oct 2023 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KXkfpS6N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA732C9E
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:29:57 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65892112
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:29:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577e62e2adfso5484807a12.2
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697736595; x=1698341395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2I5AGOihOvxki/z3pv2dLPdR+UzmorWPLGfrh2vctk=;
        b=KXkfpS6N6ZnarmfbnIoVTlaj96UzZFtAj9NGc13LiRPsTxkXEr3OHLHZklWkMNdeC4
         9ct9ykwA+0MtW2GSwnJRkkuMsteT6Qj2yg4DKW2aFE4UCxx2c/aHD+sBYFaRALXdIwzY
         UMk9gmIx32kpio92BEXgf2KfBQXMdzazcSQkLS8SJUV7MnZQlmjZuZRuZV9HkPCLrQlS
         GM7y1EJLRhOeL5+Jx+XD4TxQvkPx2Y2NEVG/hr7beDT7+79mIG2YUKiCK1qE6GUoQo4N
         g7IJHM2bKJBbl2YBIYcA1sXxZ+i3tY+lnF+EJeiAojO70YfRYwbFkEMvpRtrmekMI/1J
         qqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736595; x=1698341395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2I5AGOihOvxki/z3pv2dLPdR+UzmorWPLGfrh2vctk=;
        b=hWAE9XMHqneoSBVnAq8uZ3Rk0KbMkl/Xb9dJ02cboM0i9+STZFNjXdepWhVQdk1ejC
         uyFJZV/xAKV5lB8t+MfYJc1tMx4t+HvLwo6Acb/NvkIt0PlI4aMV7ICc29+h/XaBm1pJ
         beiJvnAN7cKNPoiqv3Eu46a5ra7rdAJ+jpy2heyQS6SvhbF7AyXt2o/sFxd8XzAAn2Ki
         G262+xOEqkm76lkTBJG2gXlslfzyE249aOYfj4MN/yFz13PxJSCx7lkYkC5Kz1PQrcQ3
         ziIu5BM6ac/htrKOHRrIBLRbsDZAqbpSBZtbLI+Q62j1rbq/LiefF8BYt+RQGXdbbGEU
         babQ==
X-Gm-Message-State: AOJu0YzIPz378McA6xvSCz09OzxuKS88WZLqJX7SnVy8hW/2FAxoqowl
	KyJZP6psZY5T/ZHzqgAs2rau+Pef124yX5Vm1P8=
X-Google-Smtp-Source: AGHT+IEleo5VXr1qwOYa4fFNlL4HujbTGpNxrUNQfgTEqypJ9lIwfFpSB5faQe5sWQrMu2ofJbxsAw==
X-Received: by 2002:a05:6a21:998e:b0:161:3120:e865 with SMTP id ve14-20020a056a21998e00b001613120e865mr3326937pzb.52.1697736594591;
        Thu, 19 Oct 2023 10:29:54 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:2935:4fd5:782f:7398])
        by smtp.gmail.com with ESMTPSA id j6-20020a63ec06000000b0059b782e8541sm19277pgh.28.2023.10.19.10.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:29:54 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next] selftests: tc-testing: add test for 'rt' upgrade on hfsc
Date: Thu, 19 Oct 2023 14:29:44 -0300
Message-Id: <20231019172944.3398419-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to check if inner rt curves are upgraded to sc curves.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/hfsc.json      | 32 +++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
index 0ddb8e1b4369..c98c339424d4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
@@ -9,8 +9,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
-        "setup": [
-        ],
+        "setup": [],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hfsc",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $DUMMY",
@@ -126,8 +125,7 @@
         "verifyCmd": "$TC qdisc show dev $DUMMY",
         "matchPattern": "qdisc hfsc 1: root refcnt [0-9]+",
         "matchCount": "0",
-        "teardown": [
-        ]
+        "teardown": []
     },
     {
         "id": "8436",
@@ -139,8 +137,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
-        "setup": [
-        ],
+        "setup": [],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hfsc",
         "expExitCode": "0",
         "verifyCmd": "$TC class show dev $DUMMY",
@@ -149,5 +146,28 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "bef4",
+        "name": "HFSC rt inner class upgrade to sc",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt rate 8"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent 1:1 classid 1:2 hfsc rt rate 8",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class hfsc 1:1 parent 1: sc m1 0bit d 0us m2 8bit.*rt m1 0bit d 0us m2 8bit",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.39.2


