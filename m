Return-Path: <netdev+bounces-291309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDO4GAlAFGoXLQcAu9opvQ
	(envelope-from <netdev+bounces-291309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 801775CA75B
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CDA23008696
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4738237C;
	Mon, 25 May 2026 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="k4t0lYPV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61F3822A4
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711978; cv=none; b=aU/EruN6y4QOzmLYxX8UHF+o9k/hxH6SSWJ66hTDwd4c/7+23VVJBjVa39r6bI08m2xAuTT1igs3Nob/K1WAqwcP4X//+0S17hb8vmh7536B75bZtxt6SrpbQC8OGLMMlLDqzx9huYsjJZk7x5sPluwwDnogaRm+8YXat5lqin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711978; c=relaxed/simple;
	bh=MIryUfqmEisKk64IGPQDKj+pNKxCFCakwhYR+MRlWQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSAEFDoHF7JfAD5wacZ2ZxXY52fFKt+7Yi2Gqn4FrXQoLav9pWG/lTFeUfX5ULDCbCeBTAf5dgg7u26y/iZ1Bz0ltzQPBCEtrU21eQu9sn82XR4uEs/kYluMRcE/v9s5NKxKkcLANJiCYw3elymccbsam+WczmMZl1BnCzmm84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=k4t0lYPV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516df7b256bso11374551cf.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711976; x=1780316776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hw0PaqUb6D92m6jOeB4yxRfJnZN5mLWZEqvpR8kuyZU=;
        b=k4t0lYPVw8PmsoM1FJTi4ipAHhVqlmp60WZrX1aZN20rbVsvR28ELS/nmM4rHWWUR5
         dQqDhYguGTGULOPijZcdVxLHOs81dJ9bNWZetfiISaSBAlJdOwrp1+qdwbqiMZEIfVaw
         X6BE1gy2mPA/uRuAzbzhhXbp2/Bllhjf6EoIlLJx5p4ho8VsEsBLH5zX6/YwLDNG/v2X
         Gb5SlJVT5z+1y99IBjofsAMUzfp7YbmaAj2y7SQgK4Aw8tM2pbwQp3XK7BVxCOEXNfWM
         sWEJNoq5Aw/VUULEsDew+Cot+M8ulHWmDJX47PwppE63Gkui+2pPsAbGKSuyiZVQQb9K
         +9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711976; x=1780316776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hw0PaqUb6D92m6jOeB4yxRfJnZN5mLWZEqvpR8kuyZU=;
        b=TEiVoh395kyGeW78IBuaNsp1ohXXfXqfxtefW1hU6CS8wyVCeqH3otvQlLfvc4Pzx3
         xZXJsJFdLzyZkL3eQ43rRmWTvNVt+/7VZtOOSFqzO9ckVMCtd4dtdYILW5SiastJ8dSS
         WhKIK0fnlY0inGfHVwwk7Q1aGmv9SqoqQ/87P0F/N+YCpqUr6WZ3GU2S+zZohXn8Vs+U
         vT5rFlfJX4PYYzfJOVGB+uG7tHgKYWFEEOWdOw/LDFifxsma7+txlO3U9ewlcFR3zSes
         hu/VE9fvH5OcFfbROc/3Y4Sli5iAR3uDvUtVbtHKQadVIr3QD4VUZm+FaosgiUfse4Kk
         dHsg==
X-Gm-Message-State: AOJu0YwldyI3nqdeVvmB5h9TeTn+tgegmrLkJy6llLNnrUKMQJEF6t52
	7HxSU0pGBClvYaaICAz3w0OQvDOoO/9fqCzBdJG4aF4guO8yx6M8zE/0ZDhVB1Y26KAQe2JNof4
	ebD+qYg==
X-Gm-Gg: Acq92OHLZ0U/qMAjsA78MLYxgODcQtiLckNuaiKeP5k3S2ceyyDLcuKupeHt5bMwXVb
	89pIDtyklq70DsXDKW/PKXWMtyFhT+dB51dEzIuISQZKtqkDOpYkCR9Ibb64U2I9kIGhiIZTGO6
	UMM5Mgv+RLuu3DttyJZZy4CCsNnx6hdOYh+vCfeRhYrn0TV5jN7gq6Bi220BZCgyR4AkXQG2OdE
	DeB6ooPp1sdwvqQ8Xcv6EW6vZsuJtqv3REcYE/yBhYAGR4yLAqCLwb93wMFPJesWrwV4KLazSQy
	eSkATWkQByS9+cFxVxsPqxcDFwq6XRuBU9Tr+0xFK9+PDyPH6B6YFl33iehbtaC/M+S95Ka754x
	fefbxtJfbsNXjTyPXrwZV5VzVRrfoifH12UZQEsUtEEt3tnC0Jz4U1L3F/R8e2Ij7WdsZFgsYju
	lpeG0w002Tl/WnQ/1/rjoF/AuO/02pxg+xrQoxRA==
X-Received: by 2002:a05:622a:4207:b0:516:d15c:7d10 with SMTP id d75a77b69052e-516d4293932mr224716851cf.6.1779711975833;
        Mon, 25 May 2026 05:26:15 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:15 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v6 3/9] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Mon, 25 May 2026 08:25:50 -0400
Message-Id: <20260525122556.973584-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
References: <20260525122556.973584-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291309-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,networkplumber.org:email]
X-Rspamd-Queue-Id: 801775CA75B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.

The tests added were related to check_netem_in_tree() which was
just reverted in the previous patch.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     |  5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     | 81 -------------------
 2 files changed, 3 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 848696c373fc..82c38a13dfbf 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -702,6 +702,7 @@
             "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicate 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip dst 10.10.10.1/32 flowid 1:1",
             "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc ls m2 10Mbit",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 2 u32 match ip dst 10.10.10.2/32 flowid 1:2",
             "ping -c 1 10.10.10.1 -I$DUMMY > /dev/null || true",
             "$TC filter del dev $DUMMY parent 1:0 protocol ip prio 1",
@@ -714,8 +715,8 @@
             {
                 "kind": "hfsc",
                 "handle": "1:",
-                "bytes": 294,
-                "packets": 3
+                "bytes": 392,
+                "packets": 4
             }
         ],
         "matchCount": "1",
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 718d2df2aafa..3c4444961488 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,86 +336,5 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
-    },
-    {
-        "id": "d34d",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change root",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
-            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
-        ],
-        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: netem duplicate 50%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "2",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "b33f",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
-            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
-        ],
-        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: netem duplicate 50%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "2",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "cafe",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1 duplicate 100%"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1: handle 2: netem duplicate 100%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "1337",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree across branches",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY parent root handle 1:0 hfsc",
-            "$TC class add dev $DUMMY parent 1:0 classid 1:1 hfsc rt m2 10Mbit",
-            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem",
-            "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc rt m2 10Mbit"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
     }
 ]
-- 
2.54.0


