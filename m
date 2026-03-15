Return-Path: <netdev+bounces-267879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKB6KKn6tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BAA28FA0F
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3AA3059A8E
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595018BC3B;
	Sun, 15 Mar 2026 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="amVN9IhC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A11D5AD4
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533829; cv=none; b=hjV/QeHkCj6aWLGlw3wOxPWXrLAdf/0wgpVNILJBUGqmRdmMiQ3c9lRW03+mjMr+i8M3prZJW/JCdzGifltDJzPqmnQqrgrwiISfSLKyJ45bc2KDx5PDqyOFhWZQY+YWqWbQjkjSZN5jtCQBXNEuxt/dmr5QWt65KT813/zaeQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533829; c=relaxed/simple;
	bh=UCQZn7UXAbrlUO+Cx93WCPi+t6JCBS3HMJ1r05rfNTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRvEArTWWhxkvAM78BSXSc7DGqD1kno1Z5m5q/WUHnWOeFf+YcsPSN2Ud5te6wttsYR9b5tAF4dgFVv+zreniUwxFBTrCG/Eck2euf2oCdGmiUAZO8wdoy7preKCYC7n9axMQQRRdTn7Cfv6RxlA4658QNUGsxm+rT/ttKeDa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=amVN9IhC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab077e3f32so15665495ad.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533827; x=1774138627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bo0TR8waqdr7ufcHa494El7b5wfTgOIREX8N7jlXmY=;
        b=amVN9IhCnEt02zG1HoU7gIAHlXNOz51CH+xSF2FWIEbqUC/UEE+lKhoGAiJ6yDB+pV
         2AW3PxdMbh6SNsDfas7CoRKHg27IKob3hgAKNKNqjfX+sbv/6lWMFlFPWgPAkom1CT43
         0DgR15ZVSIaJOvXqcbnWBuEI8Tx6nT19sqcJakNMSPrGycMQbGVkgXLEI3c8gHfHgW3i
         nydmERFcp8b+/DlZ3DViZg8X77u5B6fUuQthI30qTHQqdKe733Tqt2RJ+pkJAz12HYXv
         Hh7KUoUE8yF+UwVs5krN3bTsO4G1EeYmqDqeEElv52RbvFVGUtsGBpSzsnM2PrOySMXx
         L4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533827; x=1774138627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Bo0TR8waqdr7ufcHa494El7b5wfTgOIREX8N7jlXmY=;
        b=hzE0gVw4uZ5Idz9Q749b7mmiEoqYhS75s4er3XiJgPSe44bgGfrqAzwSsIrLThoQW8
         dDLlw8sE3iBGZror4vUnWzsM/FrnRt+cPHg42TXHqD3bC0nJhWZuaZIqDFBkiVLS5f8S
         0dr4ijbZIhbpbYXxT/z8QLs51h6IuF91PBO0UycZpNpTiQWxjO1YcmlIaDZCg7bKsGVD
         DZ3SLPIZuw2GRYJLTdR8aeyYb1gaJ061b3wbpTEgd5MGQ+yFKqniTbwgTT78O88actrA
         qHbJpNQAe9Qo/aqbeG8BM9Lgg+JC5bNZ3VQJ+bHvGMXRDAH5lcq9lDpZ54zTRTDpaM8v
         /+0Q==
X-Gm-Message-State: AOJu0YzF/zYSajKNeup7K+PpxN2c7TPAXSFsDj9WD3Orsyzc1CoawQOK
	8r20vSwN0cqMkszqRPx9yVu0OiTIBb/a3xbj4LJdNr2/RRYNz/67b68e9cuvTsXuiXoQR45BJhA
	c9QH+
X-Gm-Gg: ATEYQzwCTnGSg2vMNIwj7ajWs43kQdCpe6iscp3VMzDPdE4BvgmKxNSDKve9Wh0oou6
	nNpoxbA/HrUJ6quYZvkPl0nqTEVydF9fNo42O89y+YK/rKD30S2P6DsNCqtxax9T0EypmNz8kez
	c++jbh7fmx8dMxoUi44udX480imik3dMNhuWvbkKna7kv8tgfp8Fde9++9QUtS1+kvO0GuFflMZ
	BzmBtsFLTOGC2eTY/jxm6i2a6PgZp0mGc7ziE4kbO6x9MOGv/V36QTiWwZzhIhDtSw7agDVjEJV
	dWTsq+mo7XkpOTJ+USlyJ3oC7+Yz9gJ/734iBrDWq0LjBSt5Ps2Hsa300AqfYqns+DVpjBOQgeX
	t8nCfWD2aLJnwwPU8A2oY0UUEbeN6XFWDIesD6FB7RDbPVcC1Ymvz6XKKoPCWDwtWT8Qq2Mxjrc
	w7l7E4jXUIK3xNZJurGNjPZgJVBH3v0ZZlpiTWKXmALSE=
X-Received: by 2002:a17:902:f54c:b0:2b0:4b3a:9b49 with SMTP id d9443c01a7336-2b04b3aa307mr18256485ad.51.1773533827249;
        Sat, 14 Mar 2026 17:17:07 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@kernel.org
Subject: [PATCH net v2 03/10] selftests/tc-testing: update netem tests after check_netem_in_tree revert
Date: Sat, 14 Mar 2026 17:14:07 -0700
Message-ID: <20260315001649.23931-4-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267879-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 42BAA28FA0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update four tdc tests (d34d, b33f, cafe, 1337) to reflect that
nested/sibling netem configurations are no longer rejected.
Adjust expected exit codes and match counts accordingly.

Fixes: ecdec65ec78d ("selftests/tc-testing: Add tests for restrictions on netem duplication")
Cc: stable@kernel.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 718d2df2aafa..7985b5215853 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -339,7 +339,7 @@
     },
     {
         "id": "d34d",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change root",
+        "name": "NETEM allow duplication with nested netem via change",
         "category": ["qdisc", "netem"],
         "plugins": {
             "requires": "nsPlugin"
@@ -349,7 +349,7 @@
             "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: netem duplicate 50%",
-        "expExitCode": "2",
+        "expExitCode": "0",
         "verifyCmd": "$TC -s qdisc show dev $DUMMY",
         "matchPattern": "qdisc netem",
         "matchCount": "2",
@@ -359,7 +359,7 @@
     },
     {
         "id": "b33f",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root",
+        "name": "NETEM allow duplication on child netem via change",
         "category": ["qdisc", "netem"],
         "plugins": {
             "requires": "nsPlugin"
@@ -369,7 +369,7 @@
             "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
         ],
         "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: netem duplicate 50%",
-        "expExitCode": "2",
+        "expExitCode": "0",
         "verifyCmd": "$TC -s qdisc show dev $DUMMY",
         "matchPattern": "qdisc netem",
         "matchCount": "2",
@@ -379,7 +379,7 @@
     },
     {
         "id": "cafe",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree",
+        "name": "NETEM allow adding child netem when parent duplicates",
         "category": ["qdisc", "netem"],
         "plugins": {
             "requires": "nsPlugin"
@@ -388,17 +388,17 @@
             "$TC qdisc add dev $DUMMY root handle 1: netem limit 1 duplicate 100%"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1: handle 2: netem duplicate 100%",
-        "expExitCode": "2",
+        "expExitCode": "0",
         "verifyCmd": "$TC -s qdisc show dev $DUMMY",
         "matchPattern": "qdisc netem",
-        "matchCount": "1",
+        "matchCount": "2",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1:0 root"
         ]
     },
     {
         "id": "1337",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree across branches",
+        "name": "NETEM allow duplicating netem on separate HFSC branches",
         "category": ["qdisc", "netem"],
         "plugins": {
             "requires": "nsPlugin"
@@ -410,10 +410,10 @@
             "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc rt m2 10Mbit"
         ],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
-        "expExitCode": "2",
+        "expExitCode": "0",
         "verifyCmd": "$TC -s qdisc show dev $DUMMY",
         "matchPattern": "qdisc netem",
-        "matchCount": "1",
+        "matchCount": "2",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1:0 root"
         ]
-- 
2.51.0


