Return-Path: <netdev+bounces-22336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08F7670CD
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21E12827D1
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697EE14266;
	Fri, 28 Jul 2023 15:41:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2014262
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:41:22 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB41BD1
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:41:17 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9cf17f69cso1403254a34.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558877; x=1691163677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2Cp1o994NWKStZhqhECOM5u+fDWUeWPNV7fEwrAwI=;
        b=vjpUYBsdte1gJke8C0SUYdPtBes4kD4C5KZdPtSXDW7TdUocjDOKt7kAQ5zoeGsMaj
         am1o4EY2HdztGzLfzw12gZoviGEUa58Rk+0pJps41cgA/eq7MJEjfsGNSzdbnhuIKYPR
         j95eYhNGmywVhJckAxhWNrFXJBVUWKgJMcrLut2E4pKuhwqPamntiXabGdOsyxQ92P6j
         R776wi44tLXBhaQRWtmucIrNL0z2ZXPuqefLkBBAXv6di1nNZF3WlIaV6AZvwjz59XFK
         NZO/VOi+OelEG15MDWxAePJtKXp2Hn5UyJcFiLCD7fpCt6FPUn802e+g4NT5vCnedKHB
         ETyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558877; x=1691163677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2Cp1o994NWKStZhqhECOM5u+fDWUeWPNV7fEwrAwI=;
        b=Hb3Xac0P4T8mD2XIguKkXk7cWF9uLiWoe8jy6QBF6MxGwqAf/L7SnpFB47wCnfbmfw
         2vdxc9qdUrAcjkRKBCHKStKLnu8S60BZtHPMKCv4aCGH2eEw+2m3ieOX0lTj46xwWH1A
         fMM6aWqzAN4np/XcfHwiTn9LCMu45735jR8+94Y8lHSzemrNJG5SBR6Z2Pkw4eGfWh8j
         0EVlqD8RhDND7GsmkRrsyr/n71mNGXWjoSz/NCQEXoxyNcWX3gMjok2CSzONfRkhtmHV
         0gyXSLC9ejXQhWNsSZukIubv6LEQkUhZcPDUVgIU3GLW8Gl/sQe6zj79mf8XUEvCmp+b
         /LPA==
X-Gm-Message-State: ABy/qLbrwV3Eu2fA1/IiO9pUhVQCoVuyrL3shY+5jPuaKTLnsPdDrDMa
	RJHpYkNQGEBbSki7rXSmtLgJSerbOr/SGvUVxfI=
X-Google-Smtp-Source: APBJJlEzKUm0/KnqIHaj+vAUKKofOKX45Sp/ofMwZhpmpjR46tUYI5KiVbDIDkUSyeHBtP5WCmVAaw==
X-Received: by 2002:a05:6830:10d6:b0:6b9:b931:55ec with SMTP id z22-20020a05683010d600b006b9b93155ecmr2380897oto.7.1690558875210;
        Fri, 28 Jul 2023 08:41:15 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id d7-20020a05683018e700b006b9ad7d0046sm1691173otf.57.2023.07.28.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:41:14 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	dcaratti@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [RFC PATCH net-next 2/2] selftests/tc-testing: update test definitions for local resources
Date: Fri, 28 Jul 2023 12:40:59 -0300
Message-Id: <20230728154059.1866057-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728154059.1866057-1-pctammela@mojatatu.com>
References: <20230728154059.1866057-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With resources localized on a per test basis, some tests definitions
either contain redundant commands, were wrong or could be simplified.
Update all of them to match the new requirements.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/bpf.json      |  10 +-
 .../tc-testing/tc-tests/filters/fw.json       | 266 ++++++++--------
 .../tc-testing/tc-tests/filters/matchall.json | 141 +++++----
 .../tc-testing/tc-tests/infra/actions.json    | 144 ++++-----
 .../tc-testing/tc-tests/infra/filter.json     |   9 +-
 .../tc-testing/tc-tests/qdiscs/cake.json      |  82 ++---
 .../tc-testing/tc-tests/qdiscs/cbs.json       |  38 +--
 .../tc-testing/tc-tests/qdiscs/choke.json     |  30 +-
 .../tc-testing/tc-tests/qdiscs/codel.json     |  34 +--
 .../tc-testing/tc-tests/qdiscs/drr.json       |  10 +-
 .../tc-testing/tc-tests/qdiscs/etf.json       |  18 +-
 .../tc-testing/tc-tests/qdiscs/ets.json       | 284 ++++++++++--------
 .../tc-testing/tc-tests/qdiscs/fifo.json      |  98 +++---
 .../tc-testing/tc-tests/qdiscs/fq.json        |  68 +----
 .../tc-testing/tc-tests/qdiscs/fq_codel.json  |  54 +---
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    |   5 +-
 .../tc-testing/tc-tests/qdiscs/gred.json      |  28 +-
 .../tc-testing/tc-tests/qdiscs/hfsc.json      |  26 +-
 .../tc-testing/tc-tests/qdiscs/hhf.json       |  36 +--
 .../tc-testing/tc-tests/qdiscs/htb.json       |  46 +--
 .../tc-testing/tc-tests/qdiscs/ingress.json   |  36 ++-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  62 +---
 .../tc-tests/qdiscs/pfifo_fast.json           |  18 +-
 .../tc-testing/tc-tests/qdiscs/plug.json      |  30 +-
 .../tc-testing/tc-tests/qdiscs/prio.json      |  85 +++---
 .../tc-testing/tc-tests/qdiscs/qfq.json       |  39 +--
 .../tc-testing/tc-tests/qdiscs/red.json       |  34 +--
 .../tc-testing/tc-tests/qdiscs/sfb.json       |  48 +--
 .../tc-testing/tc-tests/qdiscs/sfq.json       |  40 +--
 .../tc-testing/tc-tests/qdiscs/skbprio.json   |  16 +-
 .../tc-testing/tc-tests/qdiscs/tbf.json       |  36 +--
 .../tc-testing/tc-tests/qdiscs/teql.json      |  14 +-
 32 files changed, 783 insertions(+), 1102 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json b/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json
index 1f0cae474db2..013fb983bc3f 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json
@@ -51,7 +51,10 @@
             "bpf-filter"
         ],
         "plugins": {
-            "requires": "buildebpfPlugin"
+            "requires": [
+               "buildebpfPlugin",
+               "nsPlugin"
+            ]
         },
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
@@ -73,7 +76,10 @@
             "bpf-filter"
         ],
         "plugins": {
-            "requires": "buildebpfPlugin"
+            "requires": [
+               "buildebpfPlugin",
+               "nsPlugin"
+            ]
         },
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json b/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json
index 5272049566d6..742ebc34e15c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json
@@ -53,111 +53,6 @@
 	"plugins": {
 		"requires": "nsPlugin"
 	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
-	"plugins": {
-		"requires": "nsPlugin"
-	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -173,14 +68,15 @@
     {
         "id": "c591",
         "name": "Add fw filter with action ok by reference",
-        "__comment": "We add sleep here because action might have not been deleted by workqueue just yet. Remove this when the behaviour is fixed.",
         "category": [
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress",
-            "/bin/sleep 1",
             "$TC actions add action gact ok index 1"
         ],
         "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 fw action gact index 1",
@@ -189,9 +85,7 @@
         "matchPattern": "handle 0x1.*gact action pass.*index 1 ref 2 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DEV1 ingress",
-            "/bin/sleep 1",
-            "$TC actions del action gact index 1"
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -201,6 +95,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -216,14 +113,15 @@
     {
         "id": "38b3",
         "name": "Add fw filter with action continue by reference",
-        "__comment": "We add sleep here because action might have not been deleted by workqueue just yet. Remove this when the behaviour is fixed.",
         "category": [
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress",
-            "/bin/sleep 1",
             "$TC actions add action gact continue index 1"
         ],
         "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 fw action gact index 1",
@@ -232,9 +130,7 @@
         "matchPattern": "handle 0x1.*gact action continue.*index 1 ref 2 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DEV1 ingress",
-            "/bin/sleep 1",
-            "$TC actions del action gact index 1"
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -244,6 +140,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -259,14 +158,15 @@
     {
         "id": "6753",
         "name": "Add fw filter with action pipe by reference",
-        "__comment": "We add sleep here because action might have not been deleted by workqueue just yet.",
         "category": [
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress",
-            "/bin/sleep 1",
             "$TC actions add action gact pipe index 1"
         ],
         "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 fw action gact index 1",
@@ -275,9 +175,7 @@
         "matchPattern": "handle 0x1.*gact action pipe.*index 1 ref 2 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DEV1 ingress",
-            "/bin/sleep 1",
-            "$TC actions del action gact index 1"
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -287,6 +185,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -302,14 +203,15 @@
     {
         "id": "6dc6",
         "name": "Add fw filter with action drop by reference",
-        "__comment": "We add sleep here because action might have not been deleted by workqueue just yet.",
         "category": [
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress",
-            "/bin/sleep 1",
             "$TC actions add action gact drop index 1"
         ],
         "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 fw action gact index 1",
@@ -318,9 +220,7 @@
         "matchPattern": "handle 0x1.*gact action drop.*index 1 ref 2 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DEV1 ingress",
-            "/bin/sleep 1",
-            "$TC actions del action gact index 1"
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -330,6 +230,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -345,14 +248,15 @@
     {
         "id": "3bc2",
         "name": "Add fw filter with action reclassify by reference",
-        "__comment": "We add sleep here because action might have not been deleted by workqueue just yet.",
         "category": [
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress",
-            "/bin/sleep 1",
             "$TC actions add action gact reclassify index 1"
         ],
         "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 fw action gact index 1",
@@ -361,9 +265,7 @@
         "matchPattern": "handle 0x1.*gact action reclassify.*index 1 ref 2 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DEV1 ingress",
-            "/bin/sleep 1",
-            "$TC actions del action gact index 1"
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -373,6 +275,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -388,14 +293,15 @@
     {
         "id": "36f7",
         "name": "Add fw filter with action jump 10 by reference",
-        "__comment": "We add sleep here because action might have not been deleted by workqueue just yet.",
         "category": [
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress",
-            "/bin/sleep 1",
             "$TC actions add action gact jump 10 index 1"
         ],
         "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 fw action gact index 1",
@@ -404,9 +310,7 @@
         "matchPattern": "handle 0x1.*gact action jump 10.*index 1 ref 2 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DEV1 ingress",
-            "/bin/sleep 1",
-            "$TC actions del action gact index 1"
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -416,6 +320,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -435,6 +342,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -454,6 +364,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -473,6 +386,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -492,6 +408,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -511,6 +430,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -530,6 +452,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -549,6 +474,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -568,6 +496,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -587,6 +518,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -606,6 +540,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -625,6 +562,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -644,6 +584,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -663,6 +606,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -682,6 +628,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -701,6 +650,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -720,6 +672,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -739,6 +694,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -758,6 +716,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -777,6 +738,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -796,6 +760,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -815,6 +782,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -834,6 +804,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -853,6 +826,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -872,6 +848,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -891,6 +870,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -910,6 +892,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -929,6 +914,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -948,6 +936,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -967,6 +958,9 @@
             "filter",
             "fw"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
@@ -1096,7 +1090,6 @@
     {
         "id": "0e99",
         "name": "Del single fw filter x1",
-        "__comment__": "First of two tests to check that one filter is there and the other isn't",
         "category": [
             "filter",
             "fw"
@@ -1121,7 +1114,6 @@
     {
         "id": "f54c",
         "name": "Del single fw filter x2",
-        "__comment__": "Second of two tests to check that one filter is there and the other isn't",
         "category": [
             "filter",
             "fw"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json b/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json
index 2df68017dfb8..afa1b9b0c856 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json
@@ -6,8 +6,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol ip matchall action ok",
@@ -16,8 +18,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*gact action pass.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -27,8 +28,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: prio"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: handle 0x1 prio 1 protocol ip matchall action ok",
@@ -37,8 +40,7 @@
         "matchPattern": "^filter parent 1: protocol ip pref 1 matchall.*handle 0x1.*gact action pass.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1: prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
@@ -48,8 +50,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol ipv6 matchall action drop",
@@ -58,8 +62,7 @@
         "matchPattern": "^filter parent ffff: protocol ipv6 pref 1 matchall.*handle 0x1.*gact action drop.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -69,8 +72,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: prio"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: handle 0x1 prio 1 protocol ipv6 matchall action drop",
@@ -79,8 +84,7 @@
         "matchPattern": "^filter parent 1: protocol ipv6 pref 1 matchall.*handle 0x1.*gact action drop.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1: prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
@@ -90,8 +94,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 65535 protocol ipv4 matchall action pass",
@@ -100,8 +106,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 65535 matchall.*handle 0x1.*gact action pass.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -111,8 +116,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: prio"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: handle 0x1 prio 65535 protocol ipv4 matchall action pass",
@@ -121,8 +128,7 @@
         "matchPattern": "^filter parent 1: protocol ip pref 65535 matchall.*handle 0x1.*gact action pass.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1: prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
@@ -132,8 +138,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 655355 protocol ipv4 matchall action pass",
@@ -142,8 +150,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 655355 matchall.*handle 0x1.*gact action pass.*ref 1 bind 1",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -153,8 +160,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: prio"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: handle 0x1 prio 655355 protocol ipv4 matchall action pass",
@@ -163,8 +172,7 @@
         "matchPattern": "^filter parent 1: protocol ip pref 655355 matchall.*handle 0x1.*gact action pass.*ref 1 bind 1",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1: prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
@@ -174,8 +182,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0xffffffff prio 1 protocol all matchall action continue",
@@ -184,8 +194,7 @@
         "matchPattern": "^filter parent ffff: protocol all pref 1 matchall.*handle 0xffffffff.*gact action continue.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -195,8 +204,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: prio"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: handle 0xffffffff prio 1 protocol all matchall action continue",
@@ -205,8 +216,7 @@
         "matchPattern": "^filter parent 1: protocol all pref 1 matchall.*handle 0xffffffff.*gact action continue.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1: prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
@@ -216,8 +226,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol all matchall skip_hw action reclassify",
@@ -226,8 +238,7 @@
         "matchPattern": "^filter parent ffff: protocol all pref 1 matchall.*handle 0x1.*skip_hw.*not_in_hw.*gact action reclassify.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -237,8 +248,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: prio"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: handle 0x1 prio 1 protocol all matchall skip_hw action reclassify",
@@ -247,8 +260,7 @@
         "matchPattern": "^filter parent 1: protocol all pref 1 matchall.*handle 0x1.*skip_hw.*not_in_hw.*gact action reclassify.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1: prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
@@ -258,8 +270,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol ipv6 matchall classid 1:1 action pass",
@@ -268,8 +282,7 @@
         "matchPattern": "^filter parent ffff: protocol ipv6 pref 1 matchall.*handle 0x1.*flowid 1:1.*gact action pass.*ref 1 bind 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -279,8 +292,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol ipv6 matchall classid 6789defg action pass",
@@ -289,8 +304,7 @@
         "matchPattern": "^filter protocol ipv6 pref 1 matchall.*handle 0x1.*flowid 6789defg.*gact action pass.*ref 1 bind 1",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -300,8 +314,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol ipv6 matchall classid 1:2 action pass"
         ],
@@ -311,8 +327,7 @@
         "matchPattern": "^filter protocol ipv6 pref 1 matchall.*handle 0x1.*flowid 1:2.*gact action pass.*ref 1 bind 1",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -322,8 +337,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol all matchall classid 1:2 action pass",
             "$TC filter add dev $DUMMY parent ffff: handle 0x2 prio 2 protocol all matchall classid 1:3 action pass",
@@ -336,8 +353,7 @@
         "matchPattern": "^filter protocol all pref.*matchall.*handle.*flowid.*gact action pass",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -347,8 +363,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol all matchall classid 1:2 action pass",
             "$TC filter add dev $DUMMY parent ffff: handle 0x2 prio 2 protocol all matchall classid 1:3 action pass",
@@ -361,8 +379,7 @@
         "matchPattern": "^filter protocol all pref 2 matchall.*handle 0x2 flowid 1:2.*gact action pass",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -372,8 +389,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol all chain 1 matchall classid 1:1 action pass",
             "$TC filter add dev $DUMMY parent ffff: handle 0x1 prio 1 protocol ipv4 chain 2 matchall classid 1:3 action continue"
@@ -384,8 +403,7 @@
         "matchPattern": "^filter protocol all pref 1 matchall chain 1 handle 0x1 flowid 1:1.*gact action pass",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -395,8 +413,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions flush action police",
             "$TC actions add action police rate 1mbit burst 100k index 199 skip_hw"
@@ -408,7 +428,6 @@
         "matchCount": "0",
         "teardown": [
             "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
             "$TC actions del action police index 199"
         ]
     },
@@ -419,8 +438,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions flush action police",
             "$TC actions add action police rate 1mbit burst 100k index 199"
@@ -432,7 +453,6 @@
         "matchCount": "0",
         "teardown": [
             "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
             "$TC actions del action police index 199"
         ]
     },
@@ -443,8 +463,10 @@
             "filter",
             "matchall"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions flush action police",
             "$TC actions add action police rate 1mbit burst 100k index 199"
@@ -456,7 +478,6 @@
         "matchCount": "0",
         "teardown": [
             "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
             "$TC actions del action police index 199"
         ]
     }
diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/actions.json b/tools/testing/selftests/tc-testing/tc-tests/infra/actions.json
index 16f3a83605e4..1ba96c467754 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/actions.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/actions.json
@@ -6,8 +6,10 @@
             "infra",
             "pedit"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC action add action pedit munge offset 0 u8 clear index 1"
         ],
@@ -17,9 +19,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action pedit"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -29,8 +29,10 @@
             "infra",
             "mpls"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC action add action mpls pop protocol ipv4 index 1"
         ],
@@ -40,9 +42,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action mpls"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -52,8 +52,10 @@
             "infra",
             "bpf"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC action add action bpf bytecode '4,40 0 0 12,21 0 1 2048,6 0 0 262144,6 0 0 0' index 1"
         ],
@@ -63,9 +65,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action bpf"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -75,8 +75,10 @@
             "infra",
             "connmark"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action connmark"
         ],
@@ -86,9 +88,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action connmark"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -98,8 +98,10 @@
             "infra",
             "csum"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action csum ip4h index 1"
         ],
@@ -109,9 +111,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action csum"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -121,8 +121,10 @@
             "infra",
             "ct"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action ct index 1"
         ],
@@ -132,9 +134,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action ct"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -144,8 +144,10 @@
             "infra",
             "ctinfo"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC action add action ctinfo index 1"
         ],
@@ -155,9 +157,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action ctinfo"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -167,8 +167,10 @@
             "infra",
             "gact"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action pass index 1"
         ],
@@ -178,9 +180,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action gact"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -190,8 +190,10 @@
             "infra",
             "gate"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC action add action gate priority 1 sched-entry close 100000000ns index 1"
         ],
@@ -201,9 +203,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action gate"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -213,8 +213,10 @@
             "infra",
             "ife"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action ife encode allow mark pass index 1"
         ],
@@ -224,9 +226,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action ife"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -236,8 +236,10 @@
             "infra",
             "mirred"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action mirred egress mirror index 1 dev lo"
         ],
@@ -247,9 +249,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action mirred"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -259,8 +259,10 @@
             "infra",
             "nat"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action nat ingress 192.168.1.1 200.200.200.1"
         ],
@@ -270,9 +272,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action nat"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -282,8 +282,10 @@
             "infra",
             "police"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action police rate 1kbit burst 10k index 1"
         ],
@@ -293,9 +295,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action police"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -305,8 +305,10 @@
             "infra",
             "sample"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action sample rate 10 group 1 index 1"
         ],
@@ -316,9 +318,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action sample"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -328,8 +328,10 @@
             "infra",
             "skbedit"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action skbedit mark 1"
         ],
@@ -339,9 +341,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action skbedit"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -351,8 +351,10 @@
             "infra",
             "skbmod"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action skbmod set dmac 11:22:33:44:55:66 index 1"
         ],
@@ -362,9 +364,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action skbmod"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -374,8 +374,10 @@
             "infra",
             "tunnel_key"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action tunnel_key set src_ip 10.10.10.1 dst_ip 20.20.20.2 id 1 index 1"
         ],
@@ -385,9 +387,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action tunnel_key"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -397,8 +397,10 @@
             "infra",
             "tunnel_key"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC actions add action vlan pop pipe index 1"
         ],
@@ -408,9 +410,7 @@
         "matchPattern": "^filter parent ffff: protocol ip pref 1 matchall.*handle 0x1.*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy",
-            "$TC actions flush action vlan"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
index c4c778e83da2..8d10042b489b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
@@ -1,13 +1,15 @@
 [
     {
         "id": "c2b4",
-        "name": "soft lockup alarm will be not generated after delete the prio 0 filter of the chain",
+        "name": "Soft lockup alarm will be not generated after delete the prio 0 filter of the chain",
         "category": [
             "filter",
             "chain"
         ],
+	"plugins": {
+		"requires": "nsPlugin"
+	},
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: htb default 1",
             "$TC chain add dev $DUMMY",
             "$TC filter del dev $DUMMY chain 0 parent 1: prio 0"
@@ -18,8 +20,7 @@
         "matchPattern": "chain parent 1: chain 0",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1: htb default 1",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY root handle 1: htb default 1"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
index 1134b72d281d..c4c5f7ba0e0f 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake bandwidth 1000",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth 1Kbit diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake autorate-ingress",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited autorate-ingress diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake rtt 200",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 200us raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake besteffort",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited besteffort triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake diffserv8",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv8 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake diffserv4",
         "expExitCode": "0",
@@ -156,8 +143,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv4 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -171,7 +157,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake flowblind",
         "expExitCode": "0",
@@ -179,8 +164,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 flowblind nonat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -194,7 +178,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake dsthost nat",
         "expExitCode": "0",
@@ -202,8 +185,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 dsthost nat nowash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -217,7 +199,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake hosts wash",
         "expExitCode": "0",
@@ -225,8 +206,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 hosts nonat wash no-ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -240,7 +220,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake flowblind no-split-gso",
         "expExitCode": "0",
@@ -248,8 +227,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 flowblind nonat nowash no-ack-filter no-split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -263,7 +241,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake dual-srchost ack-filter",
         "expExitCode": "0",
@@ -271,8 +248,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 dual-srchost nonat nowash ack-filter split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -286,7 +262,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake dual-dsthost ack-filter-aggressive",
         "expExitCode": "0",
@@ -294,8 +269,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 dual-dsthost nonat nowash ack-filter-aggressive split-gso rtt 100ms raw overhead",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -309,7 +283,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake memlimit 10000 ptm",
         "expExitCode": "0",
@@ -317,8 +290,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw ptm overhead 0 memlimit 10000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -332,7 +304,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake fwmark 8 atm",
         "expExitCode": "0",
@@ -340,8 +311,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw atm overhead 0 fwmark 0x8",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -355,7 +325,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake overhead 128 mpu 256",
         "expExitCode": "0",
@@ -363,8 +332,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms noatm overhead 128 mpu 256",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -378,7 +346,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake conservative ingress",
         "expExitCode": "0",
@@ -386,8 +353,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash ingress no-ack-filter split-gso rtt 100ms atm overhead 48",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -401,7 +367,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root cake conservative ingress"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -410,7 +375,6 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash ingress no-ack-filter split-gso rtt 100ms atm overhead 48",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -424,7 +388,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root cake overhead 128 mpu 256"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root cake mpu 128",
@@ -433,8 +396,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms noatm overhead 128 mpu 128",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -448,7 +410,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root cake overhead 128 mpu 256"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root cake mpu 128",
@@ -457,8 +418,7 @@
         "matchPattern": "qdisc cake 1: root refcnt [0-9]+ bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms noatm overhead 128 mpu 128",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -472,7 +432,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cake",
         "expExitCode": "0",
@@ -480,8 +439,7 @@
         "matchPattern": "class cake",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cbs.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cbs.json
index a46bf5ff8277..33ea986176d9 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cbs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cbs.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cbs",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 0 locredit 0 sendslope 0 idleslope 0 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cbs hicredit 64",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 64 locredit 0 sendslope 0 idleslope 0 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cbs locredit 10",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 0 locredit 10 sendslope 0 idleslope 0 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cbs sendslope 888",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 0 locredit 0 sendslope 888 idleslope 0 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cbs idleslope 666",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 0 locredit 0 sendslope 0 idleslope 666 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cbs hicredit 10 locredit 75 sendslope 2 idleslope 666",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 10 locredit 75 sendslope 2 idleslope 666 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root cbs idleslope 666"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root cbs sendslope 10",
@@ -157,8 +144,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 0 locredit 0 sendslope 10 idleslope 0 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -172,7 +158,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root cbs idleslope 666"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root cbs idleslope 1",
@@ -181,8 +166,7 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 0 locredit 0 sendslope 0 idleslope 1 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -196,7 +180,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root cbs idleslope 666"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -205,7 +188,6 @@
         "matchPattern": "qdisc cbs 1: root refcnt [0-9]+ hicredit 0 locredit 0 sendslope 0 idleslope 1 offload 0.*qdisc pfifo 0: parent 1: limit 1000p",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -219,7 +201,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root cbs",
         "expExitCode": "0",
@@ -227,8 +208,7 @@
         "matchPattern": "class cbs 1:[0-9]+ parent 1:",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/choke.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/choke.json
index 31b7775d25fc..d46e5e2c9430 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/choke.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/choke.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min 83p max 250p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000 min 100",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min 100p max 250p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000 max 900",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min.*max 900p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000 ecn",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min 83p max 250p ecn",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000 burst 100",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min 83p max 250p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -134,7 +123,6 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min 83p max 250p",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000 min 100",
@@ -157,8 +144,7 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min 100p max 250p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -172,7 +158,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000 min 100",
@@ -181,8 +166,7 @@
         "matchPattern": "qdisc choke 1: root refcnt [0-9]+ limit 1000p min 100p max 250p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
index ea38099d48e5..e9469ee71e6f 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms interval 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel limit 1500",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1500p target 5ms interval 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel target 100ms",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 100ms interval 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel interval 20ms",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms interval 20ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel ecn",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms interval 100ms ecn",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel ce_threshold 20ms",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms ce_threshold 20ms interval 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root codel"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -157,7 +144,6 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms interval 100ms",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -171,7 +157,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root codel"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root codel limit 5000",
@@ -180,8 +165,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 5000p target 5ms interval 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -195,7 +179,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root codel"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root codel limit 100",
@@ -204,8 +187,7 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 100p target 5ms interval 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
index 486a425b3c1c..7126ec3485cb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root drr",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc drr 1: root refcnt [0-9]+",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root drr"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -42,7 +39,6 @@
         "matchPattern": "qdisc drr 1: root refcnt [0-9]+",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root drr",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "class drr 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/etf.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/etf.json
index 0046d44bcd93..2c73ee47bf58 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/etf.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/etf.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root etf clockid CLOCK_TAI",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc etf 1: root refcnt [0-9]+ clockid TAI delta 0 offload off deadline_mode off skip_sock_check off",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root etf delta 100 clockid CLOCK_TAI",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc etf 1: root refcnt [0-9]+ clockid TAI delta 100 offload off deadline_mode off skip_sock_check off",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root etf clockid CLOCK_TAI deadline_mode",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc etf 1: root refcnt [0-9]+ clockid TAI delta 0 offload off deadline_mode on skip_sock_check off",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root etf clockid CLOCK_TAI skip_sock_check",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc etf 1: root refcnt [0-9]+ clockid TAI delta 0 offload off deadline_mode off skip_sock_check on",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root etf clockid CLOCK_TAI"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -111,7 +102,6 @@
         "matchPattern": "qdisc etf 1: root refcnt [0-9]+ clockid TAI delta 0 offload off deadline_mode off skip_sock_check off",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index 180593010675..a5d94cdec605 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
@@ -6,8 +6,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 2",
         "expExitCode": "0",
@@ -15,8 +17,7 @@
         "matchPattern": "qdisc ets 1: root .* bands 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -26,8 +27,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1000 900 800 700",
         "expExitCode": "0",
@@ -35,8 +38,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 4 quanta 1000 900 800 700",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -46,8 +48,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 3",
         "expExitCode": "0",
@@ -55,8 +59,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 3 strict 3",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -66,8 +69,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 4 quanta 1000 900 800 700",
         "expExitCode": "0",
@@ -75,8 +80,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 4 quanta 1000 900 800 700 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -86,8 +90,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 3 strict 3",
         "expExitCode": "0",
@@ -95,8 +101,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 3 strict 3 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -106,8 +111,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 3 quanta 1500 750",
         "expExitCode": "0",
@@ -115,8 +122,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 5 strict 3 quanta 1500 750 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -126,8 +132,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 0 quanta 1500 750",
         "expExitCode": "0",
@@ -135,8 +143,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 2 quanta 1500 750 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -146,8 +153,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 5 strict 3 quanta 1500 750",
         "expExitCode": "0",
@@ -155,8 +164,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 5 .*strict 3 quanta 1500 750 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -166,8 +174,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 2 quanta 1000",
         "expExitCode": "0",
@@ -175,8 +185,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 2 .*quanta 1000 [1-9][0-9]* priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -186,8 +195,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 3 strict 1",
         "expExitCode": "0",
@@ -195,8 +206,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 3 strict 1 quanta ([1-9][0-9]* ){2}priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -206,8 +216,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 3 strict 1 quanta 1000",
         "expExitCode": "0",
@@ -215,8 +227,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 3 strict 1 quanta 1000 [1-9][0-9]* priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -226,8 +237,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 16",
         "expExitCode": "0",
@@ -235,8 +248,7 @@
         "matchPattern": "qdisc ets 1: root .* bands 16",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -246,8 +258,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 17",
         "expExitCode": "1",
@@ -255,7 +269,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -265,8 +278,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 17",
         "expExitCode": "1",
@@ -274,7 +289,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -284,8 +298,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
         "expExitCode": "0",
@@ -293,8 +309,7 @@
         "matchPattern": "qdisc ets 1: root .* bands 16",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -304,8 +319,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17",
         "expExitCode": "2",
@@ -313,7 +330,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -323,8 +339,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 8 quanta 1 2 3 4 5 6 7 8",
         "expExitCode": "0",
@@ -332,8 +350,7 @@
         "matchPattern": "qdisc ets 1: root .* bands 16",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -343,8 +360,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 9 quanta 1 2 3 4 5 6 7 8",
         "expExitCode": "2",
@@ -352,7 +371,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -362,8 +380,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 5 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "expExitCode": "0",
@@ -371,8 +391,7 @@
         "matchPattern": "qdisc ets 1: root .*priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -382,8 +401,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1000 2000 3000 4000 5000 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "expExitCode": "0",
@@ -391,8 +412,7 @@
         "matchPattern": "qdisc ets 1: root .*quanta 1000 2000 3000 4000 5000 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -402,8 +422,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 5 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "expExitCode": "0",
@@ -411,8 +433,7 @@
         "matchPattern": "qdisc ets 1: root .*bands 5 strict 5 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -422,8 +443,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 2 quanta 1000 2000 3000 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "expExitCode": "0",
@@ -431,8 +454,7 @@
         "matchPattern": "qdisc ets 1: root .*strict 2 quanta 1000 2000 3000 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -442,8 +464,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 4000 3000 2000",
         "expExitCode": "0",
@@ -451,8 +475,7 @@
         "matchPattern": "class ets 1:1 root quantum 4000",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -462,8 +485,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 4000 3000 2000",
         "expExitCode": "0",
@@ -471,8 +496,7 @@
         "matchPattern": "class ets 1:2 root quantum 3000",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -482,8 +506,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 4000 3000 2000",
         "expExitCode": "0",
@@ -491,8 +517,7 @@
         "matchPattern": "class ets 1:3 root quantum 2000",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -502,8 +527,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 3",
         "expExitCode": "0",
@@ -511,8 +538,7 @@
         "matchPattern": "class ets 1:1 root $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -522,8 +548,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 2 quanta 1000 2000 3000",
         "expExitCode": "1",
@@ -531,7 +559,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -541,8 +568,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 2 strict 3",
         "expExitCode": "1",
@@ -550,7 +579,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -560,8 +588,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 4 strict 2 quanta 1000 2000 3000",
         "expExitCode": "1",
@@ -569,7 +599,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -579,8 +608,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 5 priomap 0 0 1 0 1 2 0 1 2 3 0 1 2 3 4 0 1 2",
         "expExitCode": "1",
@@ -588,7 +619,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -598,8 +628,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 2 priomap 0 1 2",
         "expExitCode": "1",
@@ -607,7 +639,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -617,8 +648,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1000 500 priomap 0 1 2",
         "expExitCode": "1",
@@ -626,7 +659,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -636,8 +668,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 2 priomap 0 1 2",
         "expExitCode": "1",
@@ -645,7 +679,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -655,8 +688,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets strict 1 quanta 1000 500 priomap 0 1 2 3",
         "expExitCode": "1",
@@ -664,7 +699,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -674,8 +708,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 4 strict 1 quanta 1000 500 priomap 0 1 2 3",
         "expExitCode": "0",
@@ -683,7 +719,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -693,8 +728,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 4 strict 1 quanta 1000 500 priomap 0 1 2 3 4",
         "expExitCode": "1",
@@ -702,7 +739,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -712,8 +748,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 4 priomap 0 0 0 0",
         "expExitCode": "0",
@@ -721,7 +759,6 @@
         "matchPattern": "qdisc ets .*priomap 0 0 0 0 3 3 3 3 3 3 3 3 3 3 3 3",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -731,8 +768,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 4",
         "expExitCode": "0",
@@ -740,7 +779,6 @@
         "matchPattern": "qdisc ets .*priomap 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -750,8 +788,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 0",
         "expExitCode": "1",
@@ -759,7 +799,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -769,8 +808,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets bands 17",
         "expExitCode": "1",
@@ -778,7 +819,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -788,8 +828,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets",
         "expExitCode": "1",
@@ -797,7 +839,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -807,8 +848,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1000 0 800 700",
         "expExitCode": "1",
@@ -816,7 +859,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -826,8 +868,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta 0",
         "expExitCode": "1",
@@ -835,7 +879,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -845,8 +888,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root ets quanta",
         "expExitCode": "255",
@@ -854,7 +899,6 @@
         "matchPattern": "qdisc ets",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -864,8 +908,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1000 2000 3000"
         ],
         "cmdUnderTest": "$TC class change dev $DUMMY classid 1:1 ets quantum 1500",
@@ -874,7 +920,6 @@
         "matchPattern": "qdisc ets 1: root .*quanta 1500 2000 3000 priomap ",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -884,8 +929,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root ets quanta 1000 2000 3000"
         ],
         "cmdUnderTest": "$TC class change dev $DUMMY classid 1:1 ets",
@@ -894,7 +941,6 @@
         "matchPattern": "qdisc ets 1: root .*quanta 1000 2000 3000 priomap ",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -904,8 +950,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root ets strict 5"
         ],
         "cmdUnderTest": "$TC class change dev $DUMMY classid 1:2 ets quantum 1500",
@@ -914,7 +962,6 @@
         "matchPattern": "qdisc ets .*bands 5 .*strict 5",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -924,8 +971,10 @@
             "qdisc",
             "ets"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root ets strict 5"
         ],
         "cmdUnderTest": "$TC class change dev $DUMMY classid 1:2 ets",
@@ -934,7 +983,6 @@
         "matchPattern": "qdisc ets .*bands 5 .*strict 5",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
index 5ecd93b4c473..ae3d286a32b2 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
@@ -2,13 +2,14 @@
     {
         "id": "a519",
         "name": "Add bfifo qdisc with system default parameters on egress",
-        "__comment": "When omitted, queue size in bfifo is calculated as: txqueuelen * (MTU + LinkLayerHdrSize), where LinkLayerHdrSize=14 for Ethernet",
         "category": [
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root bfifo",
         "expExitCode": "0",
@@ -16,20 +17,20 @@
         "matchPattern": "qdisc bfifo 1: root.*limit [0-9]+b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root bfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root bfifo"
         ]
     },
     {
         "id": "585c",
         "name": "Add pfifo qdisc with system default parameters on egress",
-        "__comment": "When omitted, queue size in pfifo is defaulted to the interface's txqueuelen value.",
         "category": [
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo",
         "expExitCode": "0",
@@ -37,8 +38,7 @@
         "matchPattern": "qdisc pfifo 1: root.*limit [0-9]+p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root pfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root pfifo"
         ]
     },
     {
@@ -48,8 +48,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle ffff: bfifo",
         "expExitCode": "0",
@@ -57,8 +59,7 @@
         "matchPattern": "qdisc bfifo ffff: root.*limit [0-9]+b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle ffff: root bfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle ffff: root bfifo"
         ]
     },
     {
@@ -68,8 +69,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root bfifo limit 3000b",
         "expExitCode": "0",
@@ -77,8 +80,7 @@
         "matchPattern": "qdisc bfifo 1: root.*limit 3000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root bfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root bfifo"
         ]
     },
     {
@@ -88,8 +90,11 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY txqueuelen 3000 type dummy || /bin/true"
+            "$IP link set dev $DUMMY txqueuelen 3000"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo limit 3000",
         "expExitCode": "0",
@@ -97,8 +102,7 @@
         "matchPattern": "qdisc pfifo 1: root.*limit 3000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root pfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root pfifo"
         ]
     },
     {
@@ -108,8 +112,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 10000: bfifo",
         "expExitCode": "255",
@@ -117,7 +123,6 @@
         "matchPattern": "qdisc bfifo 10000: root.*limit [0-9]+b",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -127,8 +132,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root bfifo foorbar",
         "expExitCode": "1",
@@ -136,7 +143,6 @@
         "matchPattern": "qdisc bfifo 1: root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -146,8 +152,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo foorbar",
         "expExitCode": "1",
@@ -155,7 +163,6 @@
         "matchPattern": "qdisc pfifo 1: root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -165,9 +172,11 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link del dev $DUMMY type dummy || /bin/true",
-            "$IP link add dev $DUMMY txqueuelen 1000 type dummy",
+            "$IP link set dev $DUMMY txqueuelen 1000",
             "$TC qdisc add dev $DUMMY handle 1: root bfifo"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root bfifo limit 3000b",
@@ -176,8 +185,7 @@
         "matchPattern": "qdisc bfifo 1: root.*limit 3000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root bfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root bfifo"
         ]
     },
     {
@@ -187,9 +195,11 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link del dev $DUMMY type dummy || /bin/true",
-            "$IP link add dev $DUMMY txqueuelen 1000 type dummy",
+            "$IP link set dev $DUMMY txqueuelen 1000",
             "$TC qdisc add dev $DUMMY handle 1: root pfifo"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root pfifo limit 30",
@@ -198,8 +208,7 @@
         "matchPattern": "qdisc pfifo 1: root.*limit 30p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root pfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root pfifo"
         ]
     },
     {
@@ -209,8 +218,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root bfifo limit foo-bar",
         "expExitCode": "1",
@@ -218,7 +229,6 @@
         "matchPattern": "qdisc bfifo 1: root.*limit foo-bar",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -228,8 +238,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root bfifo"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root bfifo",
@@ -238,8 +250,7 @@
         "matchPattern": "qdisc bfifo 1: root",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root bfifo",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root bfifo"
         ]
     },
     {
@@ -249,8 +260,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY root handle 1: bfifo",
         "expExitCode": "2",
@@ -258,7 +271,6 @@
         "matchPattern": "qdisc bfifo 1: root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -268,8 +280,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 123^ bfifo limit 100b",
         "expExitCode": "255",
@@ -277,7 +291,6 @@
         "matchPattern": "qdisc bfifo 123 root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -287,8 +300,10 @@
             "qdisc",
             "fifo"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: bfifo",
             "$TC qdisc del dev $DUMMY root handle 1: bfifo"
         ],
@@ -298,7 +313,6 @@
         "matchPattern": "qdisc bfifo 1: root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
index 3593fb8f79ad..be293e7c6d18 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq limit 3000",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 3000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq flow_limit 300",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 300p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq quantum 9000",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p buckets.*orphan_mask 1023 quantum 9000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq initial_quantum 900000",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p buckets.*initial_quantum 900000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq initial_quantum 0x80000000",
         "expExitCode": "2",
@@ -133,7 +122,6 @@
         "matchPattern": "qdisc fq 1: root.*initial_quantum 2048Mb",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -147,7 +135,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq maxrate 100000",
         "expExitCode": "0",
@@ -155,8 +142,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p buckets.*maxrate 100Kbit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -170,7 +156,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq nopacing",
         "expExitCode": "0",
@@ -178,8 +163,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*nopacing",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -193,7 +177,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq refill_delay 100ms",
         "expExitCode": "0",
@@ -201,8 +184,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*refill_delay 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -216,7 +198,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq low_rate_threshold 10000",
         "expExitCode": "0",
@@ -224,8 +205,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*low_rate_threshold 10Kbit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -239,7 +219,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq orphan_mask 255",
         "expExitCode": "0",
@@ -247,8 +226,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*orphan_mask 255",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -262,7 +240,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq timer_slack 100",
         "expExitCode": "0",
@@ -270,8 +247,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*timer_slack 100ns",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -285,7 +261,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq ce_threshold 100",
         "expExitCode": "0",
@@ -293,8 +268,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -308,7 +282,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq horizon 100",
         "expExitCode": "0",
@@ -316,8 +289,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*horizon 100us",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -331,7 +303,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq horizon_cap",
         "expExitCode": "0",
@@ -339,8 +310,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*horizon_cap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -354,7 +324,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root fq"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -363,7 +332,6 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -377,7 +345,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root fq"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root fq limit 5000",
@@ -386,8 +353,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 5000p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -401,7 +367,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root fq"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root fq limit 100",
@@ -410,8 +375,7 @@
         "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 100p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
index a65266357a9a..9774b1e8801b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum.*target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel limit 1000",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 1000p flows 1024 quantum.*target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel memory_limit 100000",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum.*target 5ms interval 100ms memory_limit 100000b ecn drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel target 2000",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum.*target 2ms interval 100ms memory_limit 32Mb ecn drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel interval 5000",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum.*target 5ms interval 5ms memory_limit 32Mb ecn drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel quantum 9000",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum 9000 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel noecn",
         "expExitCode": "0",
@@ -156,8 +143,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum.*target 5ms interval 100ms memory_limit 32Mb drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -171,7 +157,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel ce_threshold 1024000",
         "expExitCode": "0",
@@ -179,8 +164,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum.*target 5ms ce_threshold 1.02s interval 100ms memory_limit 32Mb ecn drop_batch 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -194,7 +178,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel drop_batch 100",
         "expExitCode": "0",
@@ -202,8 +185,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum.*target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 100",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -217,7 +199,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel limit 1000 flows 256 drop_batch 100",
         "expExitCode": "0",
@@ -225,8 +206,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 1000p flows 256 quantum.*target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 100",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -240,7 +220,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root fq_codel limit 1000 flows 256 drop_batch 100"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root fq_codel noecn",
@@ -249,8 +228,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 1000p flows 256 quantum.*target 5ms interval 100ms memory_limit 32Mb drop_batch 100",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -264,7 +242,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root fq_codel limit 1000 flows 256 drop_batch 100"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root fq_codel limit 2000",
@@ -273,8 +250,7 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 2000p flows 256 quantum.*target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 100",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -288,7 +264,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root fq_codel limit 1000 flows 256 drop_batch 100"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -297,7 +272,6 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 1000p flows 256 quantum.*target 5ms interval 100ms memory_limit 32Mb noecn drop_batch 100",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -311,7 +285,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel",
         "expExitCode": "0",
@@ -319,8 +292,7 @@
         "matchPattern": "class fq_codel 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
index 773c5027553d..d012d88d67fe 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
@@ -6,8 +6,10 @@
             "qdisc",
             "fq_pie"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_pie flows 65536",
         "expExitCode": "0",
@@ -15,7 +17,6 @@
         "matchPattern": "qdisc fq_pie 1: root refcnt 2 limit 10240p flows 65536",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/gred.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/gred.json
index 013c8ee037a4..df07fe318de9 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/gred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/gred.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root gred setup vqs 10 default 1",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc gred 1: root refcnt [0-9]+ vqs 10 default 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root gred setup vqs 10 default 1 grio",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc gred 1: root refcnt [0-9]+ vqs 10 default 1.*grio",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root gred setup vqs 10 default 1 limit 1000",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc gred 1: root refcnt [0-9]+ vqs 10 default 1 limit 1000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root gred setup vqs 10 default 2 ecn",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc gred 1: root refcnt [0-9]+ vqs 10 default 2.*ecn",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root gred setup vqs 10 default 2 harddrop",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc gred 1: root refcnt [0-9]+ vqs 10 default 2.*harddrop",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root gred setup vqs 10 default 1"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root gred limit 60KB min 15K max 25K burst 64 avpkt 1500 bandwidth 10Mbit DP 1 probability 0.1",
@@ -134,8 +123,7 @@
         "matchPattern": "qdisc gred 1: root refcnt [0-9]+ vqs 10 default 1 limit.*vq 1 prio [0-9]+ limit 60Kb min 15Kb max 25Kb",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -149,7 +137,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root gred setup vqs 10 default 1",
         "expExitCode": "0",
@@ -157,8 +144,7 @@
         "matchPattern": "class gred 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
index af27b2c20e17..0ddb8e1b4369 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hfsc",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc hfsc 1: root refcnt [0-9]+",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc sc rate 20000 ul rate 10000",
@@ -42,8 +39,7 @@
         "matchPattern": "class hfsc 1:1 parent 1: sc m1 0bit d 0us m2 20Kbit ul m1 0bit d 0us m2 10Kbit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -57,7 +53,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc sc umax 1540 dmax 5ms rate 10000 ul rate 10000",
@@ -66,8 +61,7 @@
         "matchPattern": "class hfsc 1:1 parent 1: sc m1 2464Kbit d 5ms m2 10Kbit ul m1 0bit d 0us m2 10Kbit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -81,7 +75,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt rate 20000 ls rate 10000",
@@ -90,8 +83,7 @@
         "matchPattern": "class hfsc 1:1 parent 1: rt m1 0bit d 0us m2 20Kbit ls m1 0bit d 0us m2 10Kbit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -105,7 +97,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt umax 1540 dmax 5ms rate 10000 ls rate 10000",
@@ -114,8 +105,7 @@
         "matchPattern": "class hfsc 1:1 parent 1: rt m1 2464Kbit d 5ms m2 10Kbit ls m1 0bit d 0us m2 10Kbit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -129,7 +119,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -138,7 +127,6 @@
         "matchPattern": "qdisc hfsc 1: root refcnt [0-9]+",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -152,7 +140,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hfsc",
         "expExitCode": "0",
@@ -160,8 +147,7 @@
         "matchPattern": "class hfsc 1: root",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json
index 949f6e5de902..dbef5474b26b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048 reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf limit 1500",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+ limit 1500p.*hh_limit 2048 reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf quantum 9000",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*quantum 9000b hh_limit 2048 reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf reset_timeout 100ms",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048 reset_timeout 100ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf admit_bytes 100000",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048 reset_timeout 40ms admit_bytes 100000b evict_timeout 1s non_hh_weight 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf evict_timeout 0.5s",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048 reset_timeout 40ms admit_bytes 128Kb evict_timeout 500ms non_hh_weight 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf non_hh_weight 10",
         "expExitCode": "0",
@@ -156,8 +143,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048 reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 10",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -171,7 +157,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root hhf"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root hhf limit 1500",
@@ -180,8 +165,7 @@
         "matchPattern": "qdisc hhf 1: root refcnt [0-9]+ limit 1500p.*hh_limit 2048 reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -195,7 +179,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf",
         "expExitCode": "0",
@@ -203,8 +186,7 @@
         "matchPattern": "class hhf 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/htb.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/htb.json
index 9529899482e0..cab745f9a83c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/htb.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/htb.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root htb",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc htb 1: root refcnt [0-9]+ r2q 10 default 0 direct_packets_stat.*direct_qlen",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root htb default 10",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc htb 1: root refcnt [0-9]+ r2q 10 default 0x10 direct_packets_stat.* direct_qlen",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root htb r2q 5",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc htb 1: root refcnt [0-9]+ r2q 5 default 0 direct_packets_stat.*direct_qlen",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root htb direct_qlen 1024",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc htb 1: root refcnt [0-9]+ r2q 10 default 0 direct_packets_stat.*direct_qlen 1024",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 20kbit burst 1000",
@@ -111,8 +102,7 @@
         "matchPattern": "class htb 1:1 root prio 0 rate 20Kbit ceil 20Kbit burst 1000b cburst 1600b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -126,7 +116,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 20Kbit mpu 64",
@@ -135,8 +124,7 @@
         "matchPattern": "class htb 1:1 root prio 0 rate 20Kbit ceil 20Kbit burst 1600b cburst 1600b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -150,7 +138,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 20Kbit prio 1",
@@ -159,8 +146,7 @@
         "matchPattern": "class htb 1:1 root prio 1 rate 20Kbit ceil 20Kbit burst 1600b cburst 1600b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -174,7 +160,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 20Kbit ceil 10Kbit",
@@ -183,8 +168,7 @@
         "matchPattern": "class htb 1:1 root prio 0 rate 20Kbit ceil 10Kbit burst 1600b cburst 1600b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -198,7 +182,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 20Kbit cburst 2000",
@@ -207,8 +190,7 @@
         "matchPattern": "class htb 1:1 root prio 0 rate 20Kbit ceil 20Kbit burst 1600b cburst 2000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -222,7 +204,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 20Kbit mtu 2048",
@@ -231,8 +212,7 @@
         "matchPattern": "class htb 1:1 root prio 0 rate 20Kbit ceil 20Kbit burst 2Kb cburst 2Kb",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -246,7 +226,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 20Kbit quantum 2048",
@@ -255,8 +234,7 @@
         "matchPattern": "class htb 1:1 root prio 0 rate 20Kbit ceil 20Kbit burst 1600b cburst 1600b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -270,7 +248,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root htb r2q 5"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -279,7 +256,6 @@
         "matchPattern": "qdisc htb 1: root refcnt [0-9]+",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json
index 11d33362408c..57bddc1212d8 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json
@@ -7,16 +7,17 @@
             "ingress"
         ],
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "cmdUnderTest": "$TC qdisc add dev $DUMMY ingress",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $DUMMY",
         "matchPattern": "qdisc ingress ffff:",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -26,8 +27,10 @@
             "qdisc",
             "ingress"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY ingress foorbar",
         "expExitCode": "1",
@@ -35,7 +38,6 @@
         "matchPattern": "qdisc ingress ffff:",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -45,8 +47,10 @@
             "qdisc",
             "ingress"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY ingress",
@@ -55,8 +59,7 @@
         "matchPattern": "qdisc ingress ffff:",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     },
     {
@@ -66,8 +69,10 @@
             "qdisc",
             "ingress"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY ingress",
         "expExitCode": "2",
@@ -75,7 +80,6 @@
         "matchPattern": "qdisc ingress ffff:",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -85,8 +89,10 @@
             "qdisc",
             "ingress"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY ingress",
             "$TC qdisc del dev $DUMMY ingress"
         ],
@@ -96,7 +102,6 @@
         "matchPattern": "qdisc ingress ffff:",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -106,8 +111,10 @@
             "qdisc",
             "ingress"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY ingress",
         "expExitCode": "0",
@@ -115,8 +122,7 @@
         "matchPattern": "class ingress",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY ingress",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY ingress"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 7e41f548f8e8..3c4444961488 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ limit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem limit 200",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ limit 200",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms distribution normal corrupt 1%",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 100ms  10ms corrupt 1%",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms distribution normal duplicate 1%",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 100ms  10ms duplicate 1%",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms distribution pareto loss 1%",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 100ms  10ms loss 1%",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms distribution paretonormal loss state 1",
         "expExitCode": "0",
@@ -156,8 +143,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 100ms  10ms loss state p13 1% p31 99% p32 0% p23 100% p14 0%",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -171,7 +157,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem loss gemodel 1%",
         "expExitCode": "0",
@@ -179,8 +164,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*loss gemodel p 1%",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -194,7 +178,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms reorder 2% gap 100",
         "expExitCode": "0",
@@ -202,8 +185,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*reorder 2%",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -217,7 +199,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem rate 20000",
         "expExitCode": "0",
@@ -225,8 +206,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*rate 20Kbit",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -240,7 +220,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem slot 10 200 packets 2000 bytes 9000",
         "expExitCode": "0",
@@ -248,8 +227,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*slot 10ns 200ns packets 2000 bytes 9000",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -263,7 +241,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem slot distribution pareto 1ms 0.1ms",
         "expExitCode": "0",
@@ -271,8 +248,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*slot distribution 1ms 100us",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -286,7 +262,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms distribution normal loss 1%"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root netem delay 100ms 10ms distribution normal loss 2%",
@@ -295,8 +270,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*loss 2%",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -310,7 +284,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms distribution normal loss 1%"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root netem delay 200ms 10ms",
@@ -319,8 +292,7 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 200ms  10ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -334,7 +306,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root netem delay 100ms 10ms distribution normal"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -343,7 +314,6 @@
         "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 100ms  10ms",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -357,7 +327,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem",
         "expExitCode": "0",
@@ -365,8 +334,7 @@
         "matchPattern": "class netem 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
index ab53238f4c5a..30da27fe8806 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc pfifo_fast 1: root refcnt [0-9]+ bands 3 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "Sent.*bytes.*pkt \\(dropped.*overlimits.*requeues .*\\)",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 2: root pfifo_fast",
@@ -65,8 +60,7 @@
         "matchPattern": "qdisc pfifo_fast 2: root refcnt [0-9]+ bands 3 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 2: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 2: root"
         ]
     },
     {
@@ -80,7 +74,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -89,7 +82,6 @@
         "matchPattern": "qdisc pfifo_fast 1: root refcnt [0-9]+ bands 3 priomap",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -103,7 +95,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 2: root",
@@ -112,8 +103,7 @@
         "matchPattern": "qdisc pfifo_fast 1: root refcnt [0-9]+ bands 3 priomap",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/plug.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/plug.json
index 6454518af178..6ec7e0a01265 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/plug.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/plug.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root plug",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root plug block",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root plug release",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root plug release_indefinite",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root plug limit 100",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root plug"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -134,7 +123,6 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root plug"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root plug limit 1000",
@@ -157,8 +144,7 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -172,7 +158,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root plug"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root plug limit 1000",
@@ -181,8 +166,7 @@
         "matchPattern": "qdisc plug 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/prio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/prio.json
index 8186de2f0dcf..69abf041c799 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/prio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/prio.json
@@ -6,8 +6,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio",
         "expExitCode": "0",
@@ -15,8 +17,7 @@
         "matchPattern": "qdisc prio 1: root",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root prio"
         ]
     },
     {
@@ -26,8 +27,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle ffff: prio",
         "expExitCode": "0",
@@ -35,7 +38,6 @@
         "matchPattern": "qdisc prio ffff: root",
         "matchCount": "1",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -45,8 +47,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 10000: prio",
         "expExitCode": "255",
@@ -54,7 +58,6 @@
         "matchPattern": "qdisc prio 10000: root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -64,8 +67,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio foorbar",
         "expExitCode": "1",
@@ -73,7 +78,6 @@
         "matchPattern": "qdisc prio 1: root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -83,8 +87,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio bands 4 priomap 1 1 2 2 3 3 0 0 1 2 3 0 0 0 0 0",
         "expExitCode": "0",
@@ -92,8 +98,7 @@
         "matchPattern": "qdisc prio 1: root.*bands 4 priomap.*1 1 2 2 3 3 0 0 1 2 3 0 0 0 0 0",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root prio"
         ]
     },
     {
@@ -103,8 +108,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio bands 4 priomap 1 1 2 2 3 3 0 0 1 2 3 0 0 0 0 0 1 1",
         "expExitCode": "1",
@@ -112,7 +119,6 @@
         "matchPattern": "qdisc prio 1: root.*bands 4 priomap.*1 1 2 2 3 3 0 0 1 2 3 0 0 0 0 0 1 1",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -122,8 +128,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio bands 4 priomap 1 1 2 2 7 5 0 0 1 2 3 0 0 0 0 0",
         "expExitCode": "1",
@@ -131,7 +139,6 @@
         "matchPattern": "qdisc prio 1: root.*bands 4 priomap.*1 1 2 2 7 5 0 0 1 2 3 0 0 0 0 0",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -141,8 +148,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio bands 1 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0",
         "expExitCode": "2",
@@ -150,7 +159,6 @@
         "matchPattern": "qdisc prio 1: root.*bands 1 priomap.*0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -160,8 +168,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio bands 1024 priomap 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
         "expExitCode": "2",
@@ -169,7 +179,6 @@
         "matchPattern": "qdisc prio 1: root.*bands 1024 priomap.*1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -179,8 +188,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root prio"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root prio bands 8 priomap 1 1 2 2 3 3 4 4 5 5 6 6 7 7 0 0",
@@ -189,8 +200,7 @@
         "matchPattern": "qdisc prio 1: root.*bands 8 priomap.*1 1 2 2 3 3 4 4 5 5 6 6 7 7 0 0",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root prio"
         ]
     },
     {
@@ -200,8 +210,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root prio"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio",
@@ -210,8 +222,7 @@
         "matchPattern": "qdisc prio 1: root",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root prio"
         ]
     },
     {
@@ -221,8 +232,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY root handle 1: prio",
         "expExitCode": "2",
@@ -230,7 +243,6 @@
         "matchPattern": "qdisc prio 1: root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -240,8 +252,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 123^ prio",
         "expExitCode": "255",
@@ -249,7 +263,6 @@
         "matchPattern": "qdisc prio 123 root",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -259,8 +272,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY root handle 1: prio",
             "$TC qdisc del dev $DUMMY root handle 1: prio"
         ],
@@ -270,7 +285,6 @@
         "matchPattern": "qdisc ingress ffff:",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -280,8 +294,10 @@
             "qdisc",
             "prio"
         ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root prio",
         "expExitCode": "0",
@@ -289,8 +305,7 @@
         "matchPattern": "class prio 1:[0-9]+ parent 1:",
         "matchCount": "3",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root prio",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root prio"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
index 976dffda4654..c95643929841 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root qfq",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc qfq 1: root refcnt [0-9]+",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
@@ -42,8 +39,7 @@
         "matchPattern": "class qfq 1:1 root weight 100 maxpkt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -57,7 +53,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 9999",
@@ -66,8 +61,7 @@
         "matchPattern": "class qfq 1:1 root weight 9999 maxpkt",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -81,7 +75,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq maxpkt 2000",
@@ -90,8 +83,7 @@
         "matchPattern": "class qfq 1:1 root weight 1 maxpkt 2000",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -105,7 +97,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq maxpkt 128",
@@ -114,8 +105,7 @@
         "matchPattern": "class qfq 1:1 root weight 1 maxpkt 128",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -129,7 +119,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq"
         ],
         "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq maxpkt 99999",
@@ -138,8 +127,7 @@
         "matchPattern": "class qfq 1:1 root weight 1 maxpkt 99999",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -153,7 +141,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq",
             "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100"
         ],
@@ -163,8 +150,7 @@
         "matchPattern": "class qfq 1:[0-9]+ root weight [0-9]+00 maxpkt",
         "matchCount": "2",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -178,7 +164,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq",
             "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100"
         ],
@@ -188,7 +173,6 @@
         "matchPattern": "qdisc qfq 1: root refcnt [0-9]+",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -202,7 +186,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root qfq",
         "expExitCode": "0",
@@ -210,8 +193,7 @@
         "matchPattern": "class qfq 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -225,7 +207,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$IP link set dev $DUMMY mtu 2147483647 || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq"
         ],
@@ -235,7 +216,6 @@
         "matchPattern": "class qfq 1:",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -249,7 +229,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$IP link set dev $DUMMY mtu 256 || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root qfq"
         ],
@@ -259,7 +238,6 @@
         "matchPattern": "class qfq 1:",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -277,7 +255,6 @@
             ]
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$IP link set dev $DUMMY up || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: stab mtu 2048 tsize 512 mpu 0 overhead 999999999 linklayer ethernet root qfq",
             "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/red.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/red.json
index 4b3e449857f2..eec73fda6c80 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/red.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/red.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc red 1: root .* limit 1Mb min 100Kb max 300Kb $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red adaptive limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc red 1: root .* limit 1Mb min 100Kb max 300Kb adaptive $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red ecn limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc red 1: root .* limit 1Mb min 100Kb max 300Kb ecn $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red ecn adaptive limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc red 1: root .* limit 1Mb min 100Kb max 300Kb ecn adaptive $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red ecn harddrop limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc red 1: root .* limit 1Mb min 100Kb max 300Kb ecn harddrop $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red ecn nodrop limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc red 1: root .* limit 1Mb min 100Kb max 300Kb ecn nodrop $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red nodrop limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "2",
@@ -156,7 +143,6 @@
         "matchPattern": "qdisc red",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -170,7 +156,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red ecn harddrop nodrop limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -178,8 +163,7 @@
         "matchPattern": "qdisc red 1: root .* limit 1Mb min 100Kb max 300Kb ecn harddrop nodrop $",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -193,7 +177,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root red limit 1M avpkt 1500 min 100K max 300K",
         "expExitCode": "0",
@@ -201,8 +184,7 @@
         "matchPattern": "class red 1:[0-9]+ parent 1:",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
index e21c7f22c6d4..aa7914c441ea 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 600s db 60s",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb rehash 60",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 60ms db 60s",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb db 100",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 600s db 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb limit 100",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 600s db 60s limit 100p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb max 100",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt 2 rehash 600s db 60s.*max 100p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb target 100",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt 2 rehash 600s db 60s.*target 100p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb increment 0.1",
         "expExitCode": "0",
@@ -156,8 +143,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt 2 rehash 600s db 60s.*increment 0.1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -171,7 +157,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb decrement 0.1",
         "expExitCode": "0",
@@ -179,8 +164,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt 2 rehash 600s db 60s.*decrement 0.1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -194,7 +178,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb penalty_rate 4000",
         "expExitCode": "0",
@@ -202,8 +185,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt 2 rehash 600s db 60s.*penalty_rate 4000pps",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -217,7 +199,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb penalty_burst 64",
         "expExitCode": "0",
@@ -225,8 +206,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt 2 rehash 600s db 60s.*penalty_burst 64p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -240,7 +220,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root sfb penalty_burst 64"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root sfb rehash 100",
@@ -249,8 +228,7 @@
         "matchPattern": "qdisc sfb 1: root refcnt 2 rehash 100ms db 60s",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -264,7 +242,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb",
         "expExitCode": "0",
@@ -272,8 +249,7 @@
         "matchPattern": "class sfb 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
index b6be718a174a..16d51936b385 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt [0-9]+ limit 127p quantum.*depth 127 divisor 1024",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq limit 8",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt [0-9]+ limit 8p",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq perturb 10",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "depth 127 divisor 1024 perturb 10sec",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq quantum 9000",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt [0-9]+ limit 127p quantum 9000b depth 127 divisor 1024",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq divisor 512",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt [0-9]+ limit 127p quantum 1514b depth 127 divisor 512",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq flows 20",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq depth 64",
         "expExitCode": "0",
@@ -156,8 +143,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt [0-9]+ limit 127p quantum 1514b depth 64 divisor 1024",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -171,7 +157,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq headdrop",
         "expExitCode": "0",
@@ -179,8 +164,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt [0-9]+ limit 127p quantum 1514b depth 127 headdrop divisor 1024",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -194,7 +178,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq redflowlimit 100000 min 8000 max 60000 probability 0.20 ecn headdrop",
         "expExitCode": "0",
@@ -202,8 +185,7 @@
         "matchPattern": "qdisc sfq 1: root refcnt [0-9]+ limit 127p quantum 1514b depth 127 headdrop divisor 1024 ewma 6 min 8000b max 60000b probability 0.2 ecn",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -217,7 +199,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq",
         "expExitCode": "0",
@@ -225,8 +206,7 @@
         "matchPattern": "class sfq 1:",
         "matchCount": "0",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/skbprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/skbprio.json
index 5766045c9d33..076d1d69a3a4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/skbprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/skbprio.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root skbprio",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc skbprio 1: root refcnt [0-9]+ limit 64",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root skbprio limit 1",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc skbprio 1: root refcnt [0-9]+ limit 1",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root skbprio"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root skbprio limit 32",
@@ -65,8 +60,7 @@
         "matchPattern": "qdisc skbprio 1: root refcnt [0-9]+ limit 32",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -80,7 +74,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root skbprio",
         "expExitCode": "0",
@@ -88,8 +81,7 @@
         "matchPattern": "class skbprio 1:",
         "matchCount": "64",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/tbf.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/tbf.json
index a4b3dfe51ff5..547a44910041 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/tbf.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/tbf.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 10000",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 10Kbit burst 1500b limit 1000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 20000 mtu 2048",
         "expExitCode": "0",
@@ -41,8 +38,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 20Kbit burst 1500b limit 1000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -56,7 +52,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 20000 mtu 1510 peakrate 30000",
         "expExitCode": "0",
@@ -64,8 +59,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 20Kbit burst 1500b peakrate 30Kbit minburst.*limit 1000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -79,7 +73,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root tbf burst 1500 rate 20000 latency 100ms",
         "expExitCode": "0",
@@ -87,8 +80,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 20Kbit burst 1500b lat 100ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -102,7 +94,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 20000 overhead 300",
         "expExitCode": "0",
@@ -110,8 +101,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 20Kbit burst 1800b limit 1000b overhead 300",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -125,7 +115,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 20000 linklayer atm",
         "expExitCode": "0",
@@ -133,8 +122,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 20Kbit burst 1696b limit 1000b linklayer atm",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -148,7 +136,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 20000 linklayer atm"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 20000 linklayer ethernet",
@@ -157,8 +144,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 20Kbit burst 1500b limit 1000b",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -172,7 +158,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root tbf burst 1500 rate 20000 latency 10ms"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root tbf burst 1500 rate 20000 latency 200ms",
@@ -181,8 +166,7 @@
         "matchPattern": "qdisc tbf 1: root refcnt [0-9]+ rate 20Kbit burst 1500b lat 200ms",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -196,7 +180,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root tbf limit 1000 burst 1500 rate 10000",
         "expExitCode": "0",
@@ -204,8 +187,7 @@
         "matchPattern": "class tbf.*parent 1:",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
index 0082be0e93ac..654479932438 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
@@ -10,7 +10,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root teql0",
         "expExitCode": "0",
@@ -18,8 +17,7 @@
         "matchPattern": "qdisc teql0 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     },
     {
@@ -33,7 +31,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
             "$TC qdisc add dev $ETH root handle 1: teql0"
         ],
@@ -44,8 +41,7 @@
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root",
-            "echo \"1\" > /sys/bus/netdevsim/del_device",
-            "$IP link del dev $DUMMY type dummy"
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
     },
     {
@@ -59,7 +55,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
             "$TC qdisc add dev $DUMMY handle 1: root teql0"
         ],
         "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
@@ -68,7 +63,6 @@
         "matchPattern": "qdisc teql0 1: root refcnt",
         "matchCount": "0",
         "teardown": [
-            "$IP link del dev $DUMMY type dummy"
         ]
     },
     {
@@ -82,7 +76,6 @@
             "requires": "nsPlugin"
         },
         "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root teql0",
         "expExitCode": "0",
@@ -90,8 +83,7 @@
         "matchPattern": "qdisc teql0 1: root refcnt",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
+            "$TC qdisc del dev $DUMMY handle 1: root"
         ]
     }
 ]
-- 
2.39.2


