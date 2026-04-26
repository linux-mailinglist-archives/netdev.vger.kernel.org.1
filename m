Return-Path: <netdev+bounces-281189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFyaMjJj7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:10:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2246ADD3
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B534B300D4CA
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21A37C0F5;
	Sun, 26 Apr 2026 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="flcd82gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6637C913
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230593; cv=none; b=iXMCqpZR7OinNaISiKu8f/r894VfSjayNNHe92cWEL+2aaufXrTCKpwGZmPHcFdsity9aqnOzcaHGqn45Rs44ysNotcn1PYJDtdoe08hn+l8Bwq2UeH38FFdH6DbmS8yyJiO1HB6JROQRuY2fioXTtLVBxxxAHNcBlgDlQZEQec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230593; c=relaxed/simple;
	bh=wUXliTN2E2x9ck8w4vVU7oddLzSo5hx9SnQnmzMCMt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYbEyPkb8Y7GRCEfpa5MKxRMbhug2KVFm48Mh4pyC46gVsRKEmVj7f0043FSC9bUx6ge8xa2+LbPppnU9uqvET4Zicce5ejV7lNJg1WOAxslnwE6Q4pzWWrBukmeHXZNw4+gGnlYYFlVhNB7/vSNtSMdw3zh69ouU8QUzl2R+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=flcd82gd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb856a674so116475186d6.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230577; x=1777835377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GbPTfhY/2MoHVhDmFwLVf4JVyDoSz7O3110ce/sylM=;
        b=flcd82gdKEjJ6E4ddt9ygAK1mzsjSngnVIZgO7MM9DxHLzGHCrYy0JhNJVfUqD/hgp
         Pl+45v4YahxEUzpYngRjMNJcNKsW63P7f07jojNTOV91NfAg/noxy7Ie0NdTvpHYaTQ9
         oS8ZRDRoqZTfhAZZs1MHbbF0n0rwGg3ZfFea6bxdP7LQMsUIrqVGoUNA2BUGlQsHRmox
         vGc5Z649Z71MlAy1tIZLDO2b9rNLHdWACYT7J1mCrST9sdLu9z2d3hahOUJL3zNkSn3G
         84hV7e2O64zEPF2ExD7FBHBc7ctLcLA/tVRcdK56UpKJMSd+dJ9x16KBL1+o/qlmewyG
         rHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230577; x=1777835377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GbPTfhY/2MoHVhDmFwLVf4JVyDoSz7O3110ce/sylM=;
        b=p5rP360UnF53d6/LAAmbYIIpiMREauPEtZWGXNyq7Cvlk+yqexk5qT3fMPYmU5ChLn
         /qMW/8ZSwddDIFzKAX8o2pciHrnONnLgC9OOSSuiDjcrA5vmivhp+G2feGRyxdZ1gfMP
         blWUAF035dMGwRJzMN4y1KS369m82G3ge0pusMPu6QgLhqtHeiUNWGUIZJFkPDKMo6F7
         X7AOfG9rOz3vtBOmJRmHyj2VhLkLenKj5k4g9HPgQ0neLcsbKatnwfAbQ/DPgdnt1sIi
         EBk88P7poqAwk+aT9DldnhbBtWCQk+Z1UirI9UGG8wav6bp4YCuyG+pMwxrPuw/8nw0s
         x3sw==
X-Gm-Message-State: AOJu0Yz5LVa1lZlXt6RYZwIC6y9g/cYN8otmcQMGmNSZAOvoOziQLtEN
	TrN5EKLdPxMGkWSnKGfZTFDrCrP5cHkoQyuXDPJOqoxal25qlqq+SfaaOXNCfLnV9FcwQTu9LgA
	eZuI=
X-Gm-Gg: AeBDiesk0SufAqyJupcuMToStXCvaFxN2B2UHFHABlB2qD83e109Cf8XjjvVinbHFir
	eDYK7A8H7u1pwz+LwrLs7tupVkwMosKBwusEji3wV3UXLnoP7qa/L7PJvO7K2d3zu4DNaDYCb3e
	3D5zZiDTeRJ4RkCtic1vNhZjIT3BF3ieh3Nj5yCE3K7st+dxdXCMyzyG0S24QQ7fNaNyQsbi2gC
	0PNsX/krs9YBvt1QDXfLNJUlYhr2r/7doZ1exEiz9EYV4ayd045ZOqhlgjMsrk0QHngcyqDUpN0
	aAiCrHX4K6RDUz1Ji/WBfnMlygQD/iKKD0dVZbHvD5dyR3JegthFSzxkBIh7dtzvBQ5ZOrtj7C5
	ch9eM4z5SHcqvM6TZ1DVC3JmIC6xtXWzAeIUd2YwNeI2XFi9Edg7L87F0gAGtIwC5AXYr+lVE31
	/SmM2WKcQvwdarHOMgfmdDNRmVIai+uvOn7QmFVRV80+gn7FTdkQ1B+Aea5VGiagLcmdrjyxjL5
	Y+iUPVhNzgODFSSfcZemw+N9cjkdtg=
X-Received: by 2002:a05:6214:411a:b0:899:fdeb:6ace with SMTP id 6a1803df08f44-8b02873ad2dmr540290036d6.23.1777230576819;
        Sun, 26 Apr 2026 12:09:36 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:36 -0700 (PDT)
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
Subject: [PATCH net 9/9] selftests/tc-testing: Add netem test case exercising loops
Date: Sun, 26 Apr 2026 15:09:16 -0400
Message-Id: <20260426190916.128489-10-jhs@mojatatu.com>
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
X-Rspamd-Queue-Id: 6DF2246ADD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281189-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,mojatatu.com:mid,mojatatu.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Victor Nogueira <victor@mojatatu.com>

Add a netem nested duplicate test case to validate that it won't
cause an infinite loop

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 3c4444961488..7c954989069d 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,5 +336,36 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
-    }
+    },
+    {
+        "id": "8c17",
+        "name": "Test netem's recursive duplicate",
+        "category": [
+            "qdisc",
+            "netem"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1 duplicate 100%",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem duplicate 100%"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.11.11 -W 0.01",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY root",
+        "matchJSON": [
+            {
+                "kind": "netem",
+                "handle": "1:",
+                "bytes": 294,
+                "packets": 3
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+     }
 ]
-- 
2.34.1


