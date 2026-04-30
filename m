Return-Path: <netdev+bounces-282906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEEZLmR382mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D76944A4EA2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44E5E3003722
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CF313522;
	Thu, 30 Apr 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="OkVwkwul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284829D294
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563045; cv=none; b=erpqhIU3xtVGe+cf6fidIB196DeWGJVIMCeU0HNQb7sLmSuqQMVTEjPS7MQQIfJUFBoRuSgHsyuxJLmANoIdCuy/94icbJxfiB7HYpr0NuJrHuJIU9blJjQ+J1kELf7pEFgv04XzMgAEXxQvpe74gtliH+YtrPf3r6d1fh+uSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563045; c=relaxed/simple;
	bh=sXOsgeDI/hNqdHSq0P3ZIRfeUXfKjCkhEuj4k3MAmcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H82yliKh+VqoOFXJSBGzaHd4ArXkZFzFYXU2BTfpQDLLEm+xqZ239BtUxRj1wR7yNqm2XewDwDIktCxT7Hm7mY4xXzOWPg9W9IJkJHZOZh9qKyeTwrC7pEhi5FnQjU75NQZ67EFKAApb5UOBs/P/46GGp+OH5Xx3hmZTTUnDCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=OkVwkwul; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a6cf8242so6623551cf.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777563043; x=1778167843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0JVO2SpMx/4Aui8gI0QAkkD4prhpett9Sp8rs058FM=;
        b=OkVwkwulUDievAjfqkqaGLKHqm8RXrgM63g9EnASOxpW80i9qZROFi/hx5awQ65D2Z
         uHQf6YDokAtOnv8TwzYQFtrjvNC5AeHailjQejEkoFh35oJzpACS/Y/JbcWdNhKq0RRi
         NYzkMf+qSfLdorNzOUdzWI9NEdgv28jvthGPfEw8o785ZRRJeBfeyNjV5wiVPGKXeUz6
         JrmuB3JVBmkB17iNR4D/x+TyE315H5HWr2/WsBdVT/9ceep766lry+RJLpaNRoBK/nm4
         hCtm2Qbt50wiZg1Itq/1myVl+e8QagGjG8BuDeCMOU+TGoKkhnYCr5FrE5gq36T0ck1m
         NwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563043; x=1778167843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0JVO2SpMx/4Aui8gI0QAkkD4prhpett9Sp8rs058FM=;
        b=Z0G1a+/jqQfNzX3RLRM/tK+kpE1eg7VugadFY/Zq2cmETAv5lNzr3vmb9ZTW8mgiB3
         jmMCKZ+ZG3nAmPCjbM4jGsvYWIM0r/oPA4uXzli9e+SI8ePEedbOO6ZI5VfZ7TQBHmk0
         QeyT96GZ+MJlQ0b/H3riJ4iX9HdJbbFaT3oIjXKvfB+j6jmz5/REKft8y0MWNz3TVtpm
         bkhGCfE+e6tk6JK4cQ0T81MDc37Dm7aHzoLZ2X1+WCMyY0w4vMKGByfwHL5qHvA63uIa
         Gr2eODJHdlEiowc7+I9AKoK+j9qHl5pV7m830n//yMM5+RKxsnYDWGcCL3X+NxLgMfB1
         TJmg==
X-Gm-Message-State: AOJu0YzrKn33fiXXnByPz1jLPEI0t4sMe+LuXPn1bhJnPvVuatD4KZNz
	5oSK4zD8RY6EbuE348+MC5xQZLLwnhuvaZWZ41n9M6we5zx/KPKu+1sl5tyhPC4Ns15xY/B24Wi
	RDSQ=
X-Gm-Gg: AeBDieuYRmpl+GBKfohUQ8+JvBTUncQcQ/bjf47ThLNpOAVS0Ya9XXOJRJ52hlUjBm8
	+gxURcVCUBHBAGb8qh9BUCsJFuuKoiIeTSfcgjFMIdxNH0UhquQs0hratITnDpWFib8IkFgKBr+
	FJjRousFiDHwidor/GRWvGUoNNGGVpJLhR2pZ8IPceXRcQzdRC/wdNG5/Kw1ZTXdquynCJysY5S
	OwsH+exyxFBgwz7p8NahWzfXVLerUASsLQTynFFIPhcVla55y303C+mWl3K7KPcjOrK+3tgUW+9
	4Cw+X5+f53CTWOT7HXAEtXX8hGIOtdpRk0JEYnQbdWLGuK5LrS5iKh+kAE5sCq4X3st209/Y4nV
	RpgWuPD4NdN1TPOCtGcJr462JBHoVj2DouRuFDGtjfA1wqg3i7GdxQoUvAAkAHJOvyW5PVjBoxv
	qEWl818yY1ulWBdBZXhxDSq20S23y9C+QM2L9XjQ==
X-Received: by 2002:ac8:7f94:0:b0:50f:ae44:515b with SMTP id d75a77b69052e-5102adba973mr47296941cf.37.1777563034019;
        Thu, 30 Apr 2026 08:30:34 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b398312sm876591cf.10.2026.04.30.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:30:32 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	pctammela@mojatatu.com,
	ghandatmanas@gmail.com,
	rakshitawasthi17@gmail.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 3/3] selftests/tc-testing: Add tests that force red and sfb to dequeue from child's gso_skb
Date: Thu, 30 Apr 2026 11:29:57 -0400
Message-Id: <20260430152957.194015-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430152957.194015-1-jhs@mojatatu.com>
References: <20260430152957.194015-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D76944A4EA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282906-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,kernel.org,google.com,redhat.com,resnulli.us,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim]

From: Victor Nogueira <victor@mojatatu.com>

Create 4 test cases:
- Force red to dequeue from its child's gso_skb with qfq leaf
- Force sfb to dequeue from its child's gso_skb with qfq leaf
- Force red to dequeue from its child's gso_skb with dualpi2 leaf
- Force sfb to dequeue from its child's gso_skb with dualpi2 leaf

All of them have tbf followed by red (or sfb) followed by qfq (or
dualpi2). Since tbf calls its child's peek followed by
qdisc_dequeue_peeked, it will force red/sfb to call their child's peek.
In this case, since the child (qfq/dualpi2) has qdisc_peek_dequeued as
its peek callback, the packet will be stored in its gso_skb queue. During
the subsequent call to qdisc_dequeue_peeked, red/sfb will have to dequeue
from the child's gso_skb to retrieve the packet.
Not doing so will cause a NULL ptr deref which was happening before a
recent fix.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index eefadd0546d3..b1f856cf62c1 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1136,5 +1136,153 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "7a5f",
+        "name": "Force red to dequeue from its child's gso_skb with qfq leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "red",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: red limit 757 min 16 max 24 avpkt 16",
+            "$TC qdisc add dev $DUMMY parent 2: handle 3: qfq",
+            "$TC class add dev $DUMMY classid 3:1 parent 3: qfq maxpkt 512 weight 1",
+            "$TC filter add dev $DUMMY parent 3: protocol ip prio 1 matchall classid 3:1 action ok"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.10.1 -W0.01 -I$DUMMY || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:",
+        "matchJSON": [
+            {
+                "kind": "red",
+                "handle": "2:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "cdae",
+        "name": "Force sfb to dequeue from its child's gso_skb with qfq leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "sfb",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: sfb",
+            "$TC qdisc add dev $DUMMY parent 2: handle 3: qfq",
+            "$TC class add dev $DUMMY classid 3:1 parent 3: qfq maxpkt 512 weight 1",
+            "$TC filter add dev $DUMMY parent 3: protocol ip prio 1 matchall classid 3:1 action ok"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.10.1 -W0.01 -I$DUMMY || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:",
+        "matchJSON": [
+            {
+                "kind": "sfb",
+                "handle": "2:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "291d",
+        "name": "Force red to dequeue from its child's gso_skb with dualpi2 leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "red",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: red limit 757 min 16 max 24 avpkt 16",
+            "$TC qdisc add dev $DUMMY parent 2: handle 3: dualpi2"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.10.1 -W0.01 -I$DUMMY || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:",
+        "matchJSON": [
+            {
+                "kind": "red",
+                "handle": "2:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "9c6d",
+        "name": "Force sfb to dequeue from its child's gso_skb with dualpi2 leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "sfb",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: sfb",
+            "$TC qdisc add dev $DUMMY parent 2: handle 3: dualpi2"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.10.1 -W0.01 -I$DUMMY || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:",
+        "matchJSON": [
+            {
+                "kind": "sfb",
+                "handle": "2:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.34.1


