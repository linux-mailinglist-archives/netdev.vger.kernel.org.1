Return-Path: <netdev+bounces-267886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLWGMqj6tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D8928FA08
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E78A630B3D9D
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4C1C84DE;
	Sun, 15 Mar 2026 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2MYU+j72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A596125A9
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533846; cv=none; b=Y5LkCQgGyVmhQwI9NhFrK6K2i6LU3mO7UH0fHkveYZldbuu89XqfhfR7xkBLjK8BQADSK0+9vAdO1X8rR23yE0RoksZIQWUeCn/zVoCjWOO+A7r8UjqwTn+AjcQ1oGvpTu5iMRaCTb0D2mqksTldCcymCqGroLTnO6CRegbuPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533846; c=relaxed/simple;
	bh=Pu0DV+RAtv7W2yMJZXRrGGU1CSRen4gx87J/6B+NyZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9ZNmjBXOI67gvRsoWp8jDiXM51ckYuQzgjDncUJz55DYXFeOkwZG9z31brbk9ymXkxu5XAlIqjcyer2c87HpylMzmb9uXE/TDXg3gQiMxFPnCuvGU8I2aFzisfrUntmyBb44++I/C2sA0HaKSte6xzef3aZBjE3WNAEKLHvdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2MYU+j72; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1386879a12.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533845; x=1774138645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSz48rc2wqjZK1vW6xKjWjbG9SIsINjU19cxuZCR0+I=;
        b=2MYU+j723YtZn3D4uG0h/Vk+8EVwWuqLPbtbRv2o4+uEYwhT6KntZW7kvsYDCSW0cb
         miY2Z2fUgbKAX5eIfiHPjbUBFMM1DPt4FqckM9wAGdNVSZKnK+TO0H21FyPp2d5g+mmd
         RkZaWdVv3t6JAKKVUn3ruia7DBtYVip+A5eP1vxdSmL2OzlkVYTVMHSa45nJJNaomqQD
         HT+DRW2YmgZN8F6i2rEIbf8i3CqrAolkNf5VheyWGbxAN0lOuMylKZtrD5USASENf0W2
         Dfh7uK7M60CZhLAArYqzOzoc7QQgG6AX8VCTdQIrgD8YvWXmcFkoksDVY7mmVy1GIedo
         8Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533845; x=1774138645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSz48rc2wqjZK1vW6xKjWjbG9SIsINjU19cxuZCR0+I=;
        b=RsTGmgu8BF8RRhp/D/r+BIK+aNVw7PmPH/SXQBwNBlRYGIY1j5aOIFiEEN7kbVbbAB
         cle6yzxnNHO1XhdNk1CJBHW7ZacjSw9sHz5RWYk+YCfMF1MP1ttz0sU7rJGMI3W3YW6I
         hFpLVqLxLNbe6dijvjUfhXyWe2MENvN+z3eMysbzMiA6DNjs6pCTYho8Iq4Sv0aizaqH
         wLMy7UZClM5KMIHNlCABx85ZGqW/VK6OoDVz+YsgP8nugEdDhbWmjhzJFXMvIYSjfHSX
         4g/3BkzfNBCtHNpBhajmVmIvVfMABBWzIT4UCb6uStajIn8qQC//fbO9TiaErjxwVJSs
         /lKg==
X-Gm-Message-State: AOJu0Yyd9hKpAUcgeGaeWEaWA4pJujHUUdiA8vbqZGfNszue2R3WwShC
	ixXjidt3/wtJyjiWNoaJ/n+dx/+hS/ptmtbIYNuWiMOXCFYld7PLkDQpHEh1NCHAkT06D3ObHkl
	oS7R6
X-Gm-Gg: ATEYQzxzYPvZNEDvntzUv5YlLS95j4lbFWPCLc4eWQ6X06YBAdF5596PxPSN3/N1dbZ
	2CQSIDaj3ThJUak71bIDYDzdg1PYUJR9ybeDz491jztKccyBdhsNFmAGdqr633ks7whBPx2sbmT
	HSTkYhPkQ6yIgGUTFniz7WrqTUX9v3R4CYgmMNSe1gQJFpbpR00SU3N7EtGqyZfbffDl2sjSPY2
	PbNi76uoEaCxlD3GLTATbw8FDIoHJwrU+PlPnRxnSoDE2gx108/z0SH0B6YOwrhGLesjXscIuLv
	N3I3x1UCq+ZrGVQhpDrw+8PDhOHpETEkhikZge6a6K242WLawOZonFuXP/8SKoXcSrc9yrKuQON
	Pz3/wuNgQQ/a5uw5Z73qBDMCwPI04JAlsyNbSbKSIXe0asV2bh7Ycuzx5+7guJhRq40n9LT1aNo
	5kNNdv0pVe7macbhIjdFlTADqSz+YACdC9
X-Received: by 2002:a17:903:19e6:b0:2ae:ab2b:bd75 with SMTP id d9443c01a7336-2aeca8ebc52mr79719605ad.3.1773533844586;
        Sat, 14 Mar 2026 17:17:24 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 10/10] selftests/tc-testing: add netem configuration and traffic tests
Date: Sat, 14 Mar 2026 17:14:14 -0700
Message-ID: <20260315001649.23931-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267886-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 41D8928FA08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add tests for netem topologies that were previously untested.

Configuration tests (nsPlugin only) verify tc commands succeed:
  - HTB/HFSC roots with multiple netem leaves
  - netem with pfifo, TBF, SFQ child qdiscs
  - HTB -> netem -> TBF three-level chain
  - netem nested inside netem
  - all impairments combined in a single qdisc

Traffic tests (scapyPlugin) verify packets flow through:
  - basic delay, duplication, loss, corrupt
  - HTB with two duplicating netem leaves
  - HFSC with duplicating netem child
  - nested netem with duplication
  - netem with TBF child
  - all impairments combined

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 590 ++++++++++++++++++
 1 file changed, 590 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 7985b5215853..01011cd05f55 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -417,5 +417,595 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1:0 root"
         ]
+    },
+    {
+        "id": "a1b2",
+        "name": "NETEM with pfifo child qdisc",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: netem delay 10ms"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 10: pfifo limit 50",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo 10:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "c2d3",
+        "name": "NETEM under HTB with two netem leaves",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 10mbit",
+            "$TC class add dev $DUMMY parent 1: classid 1:20 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: netem delay 10ms"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:20 handle 20: netem delay 20ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "d4e5",
+        "name": "NETEM under HTB with duplication on one leaf",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 10mbit",
+            "$TC class add dev $DUMMY parent 1: classid 1:20 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: netem delay 10ms duplicate 25%"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:20 handle 20: netem delay 20ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "e5f6",
+        "name": "NETEM under HTB with duplication on both leaves",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 10mbit",
+            "$TC class add dev $DUMMY parent 1: classid 1:20 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: netem delay 10ms duplicate 25%"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:20 handle 20: netem delay 10ms duplicate 25%",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "f6a7",
+        "name": "NETEM under HFSC class",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: hfsc default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt m2 10mbit"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 10ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem 10:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "a7b8",
+        "name": "NETEM with duplication under HFSC class",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: hfsc default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt m2 10mbit"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 10ms duplicate 50%",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem 10:.*duplicate 50%",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "b8c9",
+        "name": "NETEM under two HFSC classes",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: hfsc default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt m2 10mbit",
+            "$TC class add dev $DUMMY parent 1: classid 1:2 hfsc rt m2 10mbit",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 10ms"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:2 handle 20: netem delay 20ms duplicate 25%",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "c9d0",
+        "name": "NETEM with TBF child qdisc",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: netem delay 10ms"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 10: tbf rate 1mbit burst 10kb latency 50ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc tbf 10:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "d0e1",
+        "name": "NETEM with SFQ child qdisc",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: netem delay 10ms"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 10: sfq perturb 10",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc sfq 10:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "e1f2",
+        "name": "NETEM under HTB with TBF chain",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: netem delay 10ms"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 10:1 handle 100: tbf rate 1mbit burst 10kb latency 50ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc tbf 100:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "f2a3",
+        "name": "NETEM nested inside netem",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: netem delay 10ms"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 5ms duplicate 10%",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "a3b4",
+        "name": "NETEM with all impairments combined",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root netem delay 50ms 10ms distribution normal loss 5% duplicate 10% corrupt 1% reorder 25% 50% gap 5 rate 10mbit",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem 1: root refcnt [0-9]+ .*delay 50ms",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "7a01",
+        "name": "NETEM passes traffic with delay",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 1ms"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7b02",
+        "name": "NETEM passes traffic with duplication",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 1ms duplicate 50%"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7c03",
+        "name": "NETEM passes traffic with loss",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 1ms loss 30%"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7d04",
+        "name": "NETEM passes traffic with corrupt",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 1ms corrupt 10%"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7e05",
+        "name": "NETEM passes traffic under HTB with two netem leaves",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 root handle 1: htb default 10",
+            "$TC class add dev $DEV1 parent 1: classid 1:10 htb rate 10mbit",
+            "$TC class add dev $DEV1 parent 1: classid 1:20 htb rate 10mbit",
+            "$TC qdisc add dev $DEV1 parent 1:10 handle 10: netem delay 1ms duplicate 25%",
+            "$TC qdisc add dev $DEV1 parent 1:20 handle 20: netem delay 1ms duplicate 25%"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7f06",
+        "name": "NETEM passes traffic under HFSC with duplication",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 root handle 1: hfsc default 1",
+            "$TC class add dev $DEV1 parent 1: classid 1:1 hfsc rt m2 10mbit",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: netem delay 1ms duplicate 25%"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7a07",
+        "name": "NETEM passes traffic with nested netem",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 root handle 1: netem delay 1ms",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: netem delay 1ms duplicate 10%"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7b08",
+        "name": "NETEM passes traffic with TBF child",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 root handle 1: netem delay 1ms",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: tbf rate 1mbit burst 10kb latency 50ms"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7c09",
+        "name": "NETEM passes traffic with all impairments",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 1ms 500us distribution normal loss 5% duplicate 10% corrupt 1% reorder 25% 50% gap 5"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 50,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7d0a",
+        "name": "NETEM passes traffic with reorder",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 10ms reorder 25% 50% gap 5"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 30,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7e0b",
+        "name": "NETEM passes traffic with slot pacing",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 1ms slot 20ms 40ms packets 5 bytes 1500"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7f0c",
+        "name": "NETEM passes traffic with rate limiting",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root netem delay 1ms rate 1mbit"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
+    },
+    {
+        "id": "7a0d",
+        "name": "NETEM passes traffic with SFQ child",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 root handle 1: netem delay 1ms",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: sfq perturb 10"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 20,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/UDP(sport=5000,dport=5001)/Raw('X'*64)"
+            }
+        ],
+        "cmdUnderTest": "sleep 0.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
     }
 ]
-- 
2.51.0


