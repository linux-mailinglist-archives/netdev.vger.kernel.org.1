Return-Path: <netdev+bounces-272195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGO5BpZ4xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:19:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDF339F2A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CAE1301670A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789118E02A;
	Thu, 26 Mar 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oEc6WKes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DC3A0E93
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549057; cv=none; b=je3wpRG1PManDRLTdqrU/j/8J5PYCLyUW5ff2DEuvhYHQLYaENAZ9eOsKlfb4ZHwt+NsnDlXVzdMzKx56GQBerDxTI4yqXbqqvM/al8s9On/DDxwnkLmtL7c0NUdTrFkHohAin0bKv/zEjG+Z4Ynzngcj4aZFwN/3h1BRXr23k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549057; c=relaxed/simple;
	bh=8MS4zQtV6FtWj/IUY9YaB2l6wuq7+k0MKb9PmXVy3Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5uE58Bn/+cLB8UQVlMXVs764ltzo7Fr1GZx0zdQSEwahuKO+FODJ1I8Cf1i7fNfts/YpWyCIZTCcRrquIdL4wEblfdXUHgEOlYo5kigBi9RBtdeHICirbgrJdIi/Z/HtAWCO6zAlXJmuDv6lOGBMwr08yEiw4qVtpTOidn3rgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oEc6WKes; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b056b7f783so5919915ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549054; x=1775153854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRx7fHyBau0X1U+PMFN9nDLyGjIHEaCOQWYkJZdn+aM=;
        b=oEc6WKesaeY06bOky/5Q1PiJTY8DWHOEIHM+1jTOV/OcSR0L7xig7s/2bzR445Fl2e
         5H5R9IHXRT47vnhJiOOUopat6hH9lSudpgDsqWUbwDs1QF8wLtjx9ZFEBR7VdFFZ5bC5
         4Cvu+iIsWtzSoCB4pVC0DAxw0EAQzjFj4dFHqNqzNTc33fsDzT6GrnWKfRVxpZER73Yi
         /v6bQy4u8Lq8SYlnFGf+WtlXi1VRoF8HuPHKiV50x6bvfv6aibVVgusvk9zUkuofW4S8
         fb0lKEJ63Whe3eSUR870R6WPX2XpVqrK6GeVOjlShZOV9WAYVjh8g/ylLO0X3Ab1YXeS
         fFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549054; x=1775153854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRx7fHyBau0X1U+PMFN9nDLyGjIHEaCOQWYkJZdn+aM=;
        b=MQoErB2A+WAwTwvqwMspFnGhnbKezJ4A9mK5bGLLnxf5S8An8M3Pfly+SrLsVCVCEG
         HN9Fa8MxfvCH6Q0P+0EQE3UJvJYKR2lUGXAddFefOB9eR2IkvWZuUWEQlkRC6If0vWfG
         CIItqQtWZQi2D3IBSrjJVh+OseStbwnco7RqTEPa8RH/CkOcGyjFcqroMM1dlyDTJP5M
         jvqFDl5V0yV+u1tBTzRbvqSoFFU0JOxMvam2xgwAnc/t3VZzIRDRXlq+IJzq+gQK4JPz
         geFsHqM8Z5vfZJSeOLYaNfPEoW8WgCglr/9gb3XShjBQjya9UA6iyJrMyfhZaLu89x+4
         tYrw==
X-Gm-Message-State: AOJu0YxG5DPZrvf+U42hiMQPV8Kl7oYjZpBx6x/Qz65YQdhnQ5JqJ7pQ
	bKIQ+M8JFhR0vRccXRzsbS/KlfYKaAzxMA9/0BRtEaE10L6y+cnAFZGftqhT9DvPTvoY35+wpBA
	zViMH
X-Gm-Gg: ATEYQzye3I3xP5exQ7dQ7jVLRg9iTFFqJUR2xc4JPFDoHcGYS7e42rewiwivPiS3vtE
	6OkHU28/xov9myRY/nMWDSqBDeexHZwpIEbcSaudoMPev90WV/KwZoDJSiM1VJGlc2D2xd47L7n
	yV4yo1WSllU5uSzZ34YekH09iMauphxRMsHmPzCcz1O4FkfRs9IgZNF2remYBqnM5NsI3EtFwml
	z1vCrV0cAcO6AZDmfcTqGiKDLXelGxCfFm7KaC7CtLVjtdzJNS0sI5n888kYxRhxOCANGJyDP7j
	vI3JuK83JPso7tB2EV0x/78hMV8I85dyxoYdEj5TI2J6QZlWgn/rBipP3TRDtCsRzrfdDAtjhnn
	1MPe0dHRlIrZjyNvUvFfzYlg3XqokinZRVTf8T5LqNRT5rXyo7xfU4tCrb4XHGfOaKF+2oEGrBj
	e1MbfpNG9GzBgTTfHp9dYuJhJDRlITLuZY
X-Received: by 2002:a17:903:32c8:b0:2ae:4ad5:b76c with SMTP id d9443c01a7336-2b0c486bd45mr23970245ad.10.1774549053876;
        Thu, 26 Mar 2026 11:17:33 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	William Liu <will@willsroot.io>,
	Xiang Mei <xmei5@asu.edu>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/7] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Thu, 26 Mar 2026 11:01:02 -0700
Message-ID: <20260326181701.308275-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181701.308275-1-stephen@networkplumber.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272195-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,networkplumber.org,resnulli.us,kernel.org,gmail.com,redhat.com,willsroot.io,asu.edu,syst3mfailure.io,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: E7EDF339F2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jamal Hadi Salim <jhs@mojatatu.com>

This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.

The tests added were related to check_netem_in_tree() which was
just reverted in the previous patch.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     |  5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     | 81 -------------------
 2 files changed, 3 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 6a39640aa2a8..ceb993ed04b2 100644
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
2.53.0


