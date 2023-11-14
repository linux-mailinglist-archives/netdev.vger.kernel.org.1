Return-Path: <netdev+bounces-47747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D17EB203
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423EBB20A88
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21474121B;
	Tue, 14 Nov 2023 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pGUgQG9O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341D405ED
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 14:21:08 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A4CA
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:21:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce28faa92dso17687835ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699971666; x=1700576466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG7hVa4WuDtW/3xCESvUWYe+wgHngB6WJU7jqWOsCYU=;
        b=pGUgQG9Okmsb6HfqwApEQCoCWbpxMDpEBiAKa8ziaICyUG9vDts940CAjwDLm15vm8
         zhf/BWGP5wTfxjp4UkDAuiUMkc4yPkLbgTjRm4qaKn1RdTtX42lYCP20XaGlXeeqI4Y5
         WwBsf+x1f7hSqBXjSuWjccHbHVzLNv6LCpo4HAvdNcSOfMH3KZEk0JdZGtYrDPw4zTPI
         ZQZQRUPF5JYEUAd/srwoBMaXpu++tIEjVyHfYM00p9nxhLxCKYRGS2qEAbHstDkakZj5
         g7h58DWYsT5C7+awY9GpmNy+5Tujh0jwWkJVa5X89fKataCMZnUogcse05QiJSzcvP83
         aGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971666; x=1700576466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG7hVa4WuDtW/3xCESvUWYe+wgHngB6WJU7jqWOsCYU=;
        b=CiDIfCdy9WOZynEpn25cJMKsY7hCcDM/k0LkMQiNmfKgLGwjazRp84axwbuNBsrO9t
         opB9H12pj124Dk4+9ShKsmfgkMPDVKyDvADEupvmcuU4j5AY7BnO6Uftox2mVv51ICxp
         n7GEq5GHa4ISByh5UPao/JMLUEG2fO07R605LRbgLfuqrTqFeMLmnvRUHovFgnxAK3HF
         wZfkSf3GRTAtQje7i3GDM1qbIeeTQg+WXL+j0KwTCBcBL2Lm3esJaDZKYTIGfzkE+aL7
         Uc6bBi+DvONash4HVuOYZ67Rl2SLWP4OiqAZH7ZfTlXpleL3Do8pahkNbmZgLIoLQpz5
         EmrQ==
X-Gm-Message-State: AOJu0YymQb8Vo77SLKDm24K1GNemOs/hV8/Q4JPSIhGjIfiQ+brCNTGA
	a2SOGpMXwhjP6rHH0Le2+mifeEUMhsDe4NpQoI0=
X-Google-Smtp-Source: AGHT+IHLZMMfkCbkMcfeB2c65yPPHmDdvwZFsr2if8TrWWgUpV9oOh3GvFmgjkhvlE8fMLZbaxOsfQ==
X-Received: by 2002:a17:903:244d:b0:1cc:50ad:58 with SMTP id l13-20020a170903244d00b001cc50ad0058mr2227412pls.42.1699971665873;
        Tue, 14 Nov 2023 06:21:05 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:70a4:6f84:7ab8:14d8])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001c8a0879805sm5687608pli.206.2023.11.14.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:21:05 -0800 (PST)
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
Subject: [PATCH net-next 2/2] selftests/tc-testing: add hashtable tests for u32
Date: Tue, 14 Nov 2023 11:18:56 -0300
Message-Id: <20231114141856.974326-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114141856.974326-1-pctammela@mojatatu.com>
References: <20231114141856.974326-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to specifically check for the refcount interactions of
hashtables created by u32. These tables should not be deleted when
referenced and the flush order should respect a tree like composition.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/u32.json      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index ddc7c355be0a..24bd0c2a3014 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -272,5 +272,62 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "bd32",
+        "name": "Try to delete hashtable referenced by another u32 filter",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 handle 1: u32 divisor 1",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 800: match ip src any link 1:"
+        ],
+        "cmdUnderTest": "$TC filter delete dev $DEV1 parent 10: prio 2 handle 1: u32",
+        "expExitCode": "2",
+        "verifyCmd": "$TC filter show dev $DEV1",
+        "matchPattern": "protocol ip pref 2 u32 chain 0 fh 1:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
+    },
+    {
+        "id": "4585",
+        "name": "Delete small tree of u32 hashtables and filters",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 handle 1: u32 divisor 1",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 handle 2: u32 divisor 1",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 handle 3: u32 divisor 2",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 handle 4: u32 divisor 1",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 1: match ip src any action drop",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 2: match ip src any action drop",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 3: match ip src any link 2:",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 3: match ip src any link 1:",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 4: match ip src any action drop",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 800: match ip src any link 3:",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 ht 800: match ip src any link 4:"
+        ],
+        "cmdUnderTest": "$TC filter delete dev $DEV1 parent 10:",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1",
+        "matchPattern": "protocol ip pref 2 u32",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
     }
 ]
-- 
2.40.1


