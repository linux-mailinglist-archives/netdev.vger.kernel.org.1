Return-Path: <netdev+bounces-284394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC2/Dunu+WlqFQMAu9opvQ
	(envelope-from <netdev+bounces-284394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B234CE5CB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40A72302DF4F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5D322B87;
	Tue,  5 May 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="ypXl8fOq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AD317170
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987301; cv=none; b=WldRwqj38Gq0QRffLh/rSy+ae74QmGTdVyb4/A0eunbkc2TUPMtHmN2xEOqZBLeCgKQWCFMLTMXBnpsCJ7h2z03jvNSN3/HpeosRcWrws9EyAlg7OX7KlVyxk4/AMCCqXc81vAUwI6+/I6L4XkKC0ZJKoag1f5wKTaoP1Ul+cTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987301; c=relaxed/simple;
	bh=ttOhjfnvWLyJe1mTdC+2qmarG8te2ytuqwJqVRdfvCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXxe8QgZhLA6BH853oUfHSdq5J19ernNYUO5WYh38LduNa4CB0Bjczu9XybIA/RhRZ7lCrhXfw8i8Ui3VW6n/FkKQWqN26VNEdI4IVyIwvC8yjWyM3wOKN5/h1oh6uSRhMcvKRIbSJrZAh3S2faMbZTRXn3krlnPZUIWGuCtblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=ypXl8fOq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d6d5e45c43so568481585a.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777987299; x=1778592099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReApkusaPjWEaTQZ6Am0jC6utCkIeTHP0NXkxkF5d7E=;
        b=ypXl8fOqTkcMYW1kGEMCkgRDxt+BK6RtZBSSrgmc/7ZNly3ZrHCgwccYQwG121ZlIi
         TTg46Zb+16uDP/3TmpIRLUaxOUAv71C6Q2D8adqKG3I7ONhLMyaPzep2Xd27LVHji+RL
         +JHGmffgBFFVxO4IK//T+mRUtt/dDU0NUxxPQIkuCnj1SuXGgey+dtI4aHn9R5WrB3c5
         h1e2dBo1pA4mwBbetzjq0lONC3gpeCaSCajoPKy9sCy7mheCdieGC6JZ1REB37UATE+l
         6eaqmU9WnSbU1YBrBQNccqBOXjLW0szjN5IdYuSXVXWx0bCB/UX/aOK8oDJEDS+nWvOU
         sa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987299; x=1778592099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ReApkusaPjWEaTQZ6Am0jC6utCkIeTHP0NXkxkF5d7E=;
        b=sqzd5LjNLL7z81eDCnDb6nUil9vV22d06yoqsW6dQIudE3hQbMjHRhnkiWQEPBOHGw
         u6zTyERdw40L8b3I9IaDm0JJe3aQ5GOGsDtwV7w1uwtWje0YnqVDN8OKDxIJk4Eu75rm
         E5iB6X4QNj/qCW3Oa1kGASKagdRnbXULHW/XbTbHf2hTJFHg5r7dOGJc/MckPMgmvVRl
         9NXhzPEgzrd+WQTpxKa4AYKB2Xc0WuLdeDMFaj/V1RzcbMeIKKTERXBY7lC2RhmihstP
         WEwEWKnSl1APEfZySDzbIqOdgCOFG1+CABJM2Yo+7cDi5ej3dXxJwvODfRGzGrCGTQCo
         UsnQ==
X-Gm-Message-State: AOJu0Yxa3cG/UhGH2yfRcSs/5e/OxgYEZjEDRMb9LFqtMW9CLP2Y2p8Q
	rF8Ydv+RIEQWuf835fEWsKxCybAt+WSxg5AsNsNjqRPSLHxioX4A9G2iCC24UBMjHbjk/2iCngn
	tbPY=
X-Gm-Gg: AeBDiesLiW3gYLKGaQOkLGSraww0Q1P3C6c/NYwjGduD5rSqcuCa1TrUaB75QGwMBdZ
	wU1mywvcqiM4FMQEK+JHb9gluVU8wHzVBjGGajI1eXZizUmq6KPU6/GECpt7tyc4BShiN3GlipT
	rXgZQ7Rc7HzFTMovr1pdI1dTZ/+9TOqVpq1Y+7ltEc/HefwxaeYil0wKzfau/AuQXR5plHcezjV
	KiJcSDVVhfVIDBu7LsJqYu39P/DCKxoAK0kEE5ZOJYf3/3Z20nYdwFfC5pt3cDT/gBZMUssfCkk
	SqTo9XKesnAnyKSr0rNXwdp5HHo9SRknGMUWiDPYQdXshzpGxStVF+pQwEqFhvxJWJoAZ7VGICz
	S16gswG36HJvu+Ka6qxi7U8KZMwKPqy+vMs24nkuhPk7hsF6UvEzZ7wBnOVThpqSDKBz2WZlhnu
	9huLWYOC9iGmUtRQyUyFhAD21FtagE1GVIlQQPGqSgGGQXhEvo
X-Received: by 2002:a05:620a:2a0c:b0:8cf:c1c2:90f with SMTP id af79cd13be357-8fd158e5b85mr2154466385a.7.1777987298942;
        Tue, 05 May 2026 06:21:38 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253bc9sm1493975285a.27.2026.05.05.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:21:38 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	horms@kernel.org,
	vinicius.gomes@intel.com,
	graypanda.inzag@gmail.com,
	security@kernel.org
Subject: [PATCH net 2/2] selftests/tc-testing: Add QFQ/CBS qlen underflow test
Date: Tue,  5 May 2026 09:21:02 -0400
Message-Id: <20260505132102.128903-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505132102.128903-1-jhs@mojatatu.com>
References: <20260505132102.128903-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5B234CE5CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284394-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,kernel.org,google.com,redhat.com,resnulli.us,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email]

From: Victor Nogueira <victor@mojatatu.com>

Since CBS was not calling reset for its child qdisc, there are scenarios
where it could cause an underflow on its parent's qlen/backlog. When the
parent is QFQ, a null-ptr deref could occur.

Add a test case that reproduces the underflow followed by a null-ptr
deref scenario.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index b1f856cf62c1..848696c373fc 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1284,5 +1284,46 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "3a62",
+        "name": "Try to create a qlen underflow with QFQ/CBS",
+        "category": [
+            "qdisc",
+            "qfq",
+            "cbs"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: qfq",
+            "$TC class add dev $DUMMY classid 1:1 parent 1: qfq",
+            "$TC class add dev $DUMMY classid 1:2 parent 1: qfq",
+            "$TC qdisc add dev $DUMMY handle 2: parent 1:1 cbs",
+            "$TC qdisc add dev $DUMMY handle 3: parent 2: netem delay 5000000000",
+            "$TC filter add dev $DUMMY parent 1: prio 1 u32 match ip dst 10.10.10.1 classid 1:1 action ok",
+            "$TC filter add dev $DUMMY parent 1: prio 2 u32 match ip dst 10.10.10.2 classid 1:2 action ok",
+            "ping -c 1 10.10.10.1 -W0.01 -I$DUMMY || true",
+            "$IP l set $DUMMY down",
+            "$IP l set $DUMMY up",
+            "$TC qdisc replace dev $DUMMY handle 4: parent 2: pfifo"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.10.2 -W0.01 -I$DUMMY",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
+        "matchJSON": [
+            {
+                "kind": "cbs",
+                "handle": "2:",
+                "bytes": 0,
+                "packets": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.34.1


