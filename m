Return-Path: <netdev+bounces-281183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIoeNRRj7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:10:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2418346ADA8
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2094A300CE71
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB627E045;
	Sun, 26 Apr 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="LmhCWDXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BE37BE89
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230571; cv=none; b=opdT0LIWs56Rs7ZbODRCF4TCzz6CZ03X9EmyfN+jH0DgsVjl9D09WEnrf9JCWNPcE56sgszmrhF/wumULVs+Mb+lqM4Zk5eU6r8aFUgvnezjut+W+Ngz0ziz2le8uGjWPCGmKsoS2s8M5ldwkfPg5bYPRQiJElfqaaxYuTEbgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230571; c=relaxed/simple;
	bh=zyXesspMfCB/4wfDiJszI/r8V3ou4eFmegKirL5oVBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zh/doobN9KuRQiHBJIHqOQ3KO9G5+Mb9w56x3817AZwZ4YI8fncNzZYMzZwrz8uOxYq1B8OfR13ckcvWL7iIzoM0Uk/1j3FTSeauj2Gg1HHEFs52vaHMS5uywLUr/0mUPPymd6haa7Ot6xaI0r5KihmcJXNrCEyLV/Qmn0XxcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=LmhCWDXf; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acb856a674so116474306d6.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230567; x=1777835367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppaTxpWEXEPnzcRosom+AAjIfpVNmAUWL4sBo9livos=;
        b=LmhCWDXfQL/H+iZgt28oYnC2Z3pHZ5p82OGGZMV6kzMwwSDmyF9S7tSfYHjp5JzSC+
         E4jPb9CAAGjQasLJ2KCurSF3dHtMDdhEJWkN05y0ppEs4CtZCKeXmXZUrBvmKWahBNTJ
         it1OAWtKB9gGs4hcwQYB/10sXeb4nvxvP3MG9i16S4BRbLehWhFHa1uzlVgvtK30Tc60
         Qh6B56vH1CXrwjxPbSDKCeFOZuQeU+lxwmRR/OGUEf3jAbQPkOkFK1/hN7fbaZ0NIzaX
         N58bXKBkiFBcd8eEQbNcP+ptPN477NuTZdQlQx0QpO2MX4ZE8kiF9pv+BWh353M/GyZ1
         w2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230567; x=1777835367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppaTxpWEXEPnzcRosom+AAjIfpVNmAUWL4sBo9livos=;
        b=bYn6PR852aw4Pmvhq7nc5FDBPU/hGTR7LEWGWYrezqvx///LhZNkYWb8fu+1nN7SY4
         I1GmQHFJHER0TTK6aXSnGL5svPop/WalVZwGrInugWQcWxR3WZyeaRnPi9Gp+qgQUe1R
         TC0YBSB8sFzvTIBUO25aYICeYvSLlYZ1B86C62TRto3AiLK1mED9XZ5dK/6Ge4qzGU7U
         r+gM6g902+k6Q5FZzasLTiPoQrrbgW5E1cGtu13xLS+m+1RCRhZFKN0NcLtcm32/gPJH
         dMUwhZp6bElYqnmETOxmEk5uRSkcI27Gag9ruYD+8a7WRb1bQAUq0xlQWx66N6AH5ly2
         3yCg==
X-Gm-Message-State: AOJu0Yxdojl8Ne+3zlVXmhM/gaogocezaPPW4x36ztWYOKEP93oR/pjM
	07jTfPGRHVUpCvs3DyGd+L/SqcFHgYRq+A2pup9nPgE/Hgm2iC5gmmEd7un/N4rt2ro5TCUpu5X
	AG7U=
X-Gm-Gg: AeBDieuZbtKYMO7MMkzVWGiX/9koyzwdcPXxIZH/LlEbdNXbcu5Ig3IO06ucTGEB9uh
	Vk6J7PJaiM6IxhJohyS+yT9fwWIuU6OICR5jTU6vQpiECuN3ED2PBTm2nK0OttZNjdlF00ZYTSu
	O3Jzns9u0CjFxIgV/5a9HmONT9UmGbajMYhERjcQFKPYneEiFfZOZw/yMZp4u3l7REPV2fmCRXx
	AB3uJRJtnh3ArUwxTl9pLBQspwyvGe0ucFNRPoBqovuVvO8ZNCFXXsW4yXhiYOOz6wXy7y0SHy2
	9awCe3irWcKsgugch122CbbVki8tTzSExhaWA8A/e2fsoE5b+ebr63IjspusI+UtgecZ9GRUiX+
	RHfX7o8wuf+8o21PNTsCg+zPO81bZT+2/FHwnYse09YcDKGVB4djHqLq12KEoVS+FWrmz/E/rBp
	F1juZVMByjzhS2TxvzxzkoCJSR8BUg6xNz/gawxikL/oviqrIfON1vMb3mXJomz9XpH4+SJmikW
	2v6NtW5b3Cd6s7RePPZWaJVj+KGdoA=
X-Received: by 2002:a05:6214:5193:b0:8ac:aa89:6bb0 with SMTP id 6a1803df08f44-8b0284715bfmr546811866d6.11.1777230567106;
        Sun, 26 Apr 2026 12:09:27 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 3/9] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Sun, 26 Apr 2026 15:09:10 -0400
Message-Id: <20260426190916.128489-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426190916.128489-1-jhs@mojatatu.com>
References: <20260426190916.128489-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2418346ADA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281183-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email,networkplumber.org:email]

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
index eefadd0546d3..d32616a46a71 100644
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
2.34.1


