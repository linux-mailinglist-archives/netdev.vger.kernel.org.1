Return-Path: <netdev+bounces-288008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK6fHHviBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:55:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1723543904
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA3D30E4E54
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDE41B37F;
	Thu, 14 May 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="lQEn6HWg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B9421A09
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770092; cv=none; b=VHn9CM244yD4B/W1MA8QRsj6iipfgN2jGEegabgkzg7LBNxxjfJ3KlYlM19llpQIHOjkjEEi533Nmp6DbcDeoScomE+oidpz3XZf7mLTzI4ax1rKTYf2iXJt9Cda+1J6zbCqjTNXypXik7S/BxjzLKvt0NBj/MfC4aoGqCzFVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770092; c=relaxed/simple;
	bh=Vb4d3TUErMtmQMYcGq5ciGOBlXqqkFxwYzer2KNW6hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfYy5HqGToNy76Q6d/yOHla3i5gDuuLfYb9XN00K06gEYS5DVe8u5Ivji76G9hfklLrP+yFufQudsV1uR+cj5CC+cDTK6wCTjL0XAm2+JyM6XCCXPXArUf6x77jKswQDshQR1XAfOCfdoZquaS7BXN3FvfsKM5FLOkcL3okfq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=lQEn6HWg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-514ae601e01so50837711cf.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770087; x=1779374887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhArQ/h/bBptoAKrqSJOhCVAcaAYplmEcivVvVCCIGw=;
        b=lQEn6HWg3/VBcKg/K6OXjVxGIb6RGn9StWigaFUUUVUzj7tx36AAlMwt0+T7aWiTaA
         +1sZw50T1AxOzhKSEzrXorBpX54X1CwTb1w6Tp3ZbLoEwQZCMqoy36HLOu+Lf7A0tlse
         lh1IQs5bAuSh3uoKT19L+OM5CzN2NsinfDHNqmAv7nbAF1y7zYrRKuf/ACxSnrHlm5kf
         dnQEexWBqwcle30IPPxOO+VSgF0JZqXvvVv/WtY9UL1+7gZkc6HDJrJcx2YQnyVpmcgz
         smnY51QVDcf3C0DnzxAzaZjitJmWKPC3+cir9Rh+jkIVL/powcgxItfdW46bRBXVKr3i
         1sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770087; x=1779374887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhArQ/h/bBptoAKrqSJOhCVAcaAYplmEcivVvVCCIGw=;
        b=LghI2oODjvPAup0BJ+8tIVb8zPQu7ifIjLlqbSjRsIuHVQZu2FnznVz3QlTQ4Im5IG
         3xmQlMhp1OIaWXw46F2L1g9CdYEEhpcFZ6isQmkcM604jOxhk3BMg+YCeKxTz8YFf9ur
         XDmzbHhT0raEZVtuMZ76QfuKiwATaRBP+qFIyHdfeqqaklA95o8uujI8Zuz5ret4QYhN
         RHd5sbqe8jv/sCX3XaNariAG3vR8qOTMmMC25bH+JrOg6xSKHU1EiuIjNW0Cn/QvqdWg
         i6G9Fpdt9eqZl2I4BiiVUbnrINVfWwEgMI+jxxTjCIvnRRkF1abDiR4fCYcpya2OQ+2X
         mfHw==
X-Gm-Message-State: AOJu0YzCwoyWguSapd4XD4A3/XZtt0oyO5vpkE0gaxuOnU0+6/NKTEls
	yo6W4aIO44NA1OptFGITTsVEjM0/KM05SbkcQd3wJCm777mvNQV3LiBeLRxgPVJa8nAQP0LV3gh
	5sv5VHA==
X-Gm-Gg: Acq92OFSf5r7uA1CVRQBDM2zq8N1swPNPbtbVHqzlZ3rWvNismnhuwzjRJhlvVSvZUk
	HdoJR221i3gjQ4r5bIDL6LdXCmIQ8qnIATiRa88tnZQyoEgFGphvqeYSXnLrjaxvNVwCRnK4ZwV
	e32sjt9hpw17Yupmx7dYi2IXFNTBCnJbr0qEBT6l3eE0E4O2d10D0QwNYZH6GKoMUfbdL3SqHGG
	m3NEoo3hcfVuo2JViyNYy8GoSY4i5itUPS6dukWfxfmQKoONcOVgB1vPhuW63+gMEGF2kil9EW2
	7Jt0W9Ho/0mG6fV2YthWUEtuMhox1CotYypIQ6fuL5pRm2ybO0eQpCpV1HXJJu0fh8+L/T+SNVy
	ypCBdSvG47MxqMDMdFz/fwbmjz3QBHV++NqcRXWmnx25/kd6+Nc2wdDFcki3RZa4b0R96vcWjlK
	/DE0b2UffGgC4tCVuLWuCSZpRVInE=
X-Received: by 2002:a05:622a:2618:b0:50f:b3d2:6edd with SMTP id d75a77b69052e-5162ff42a2amr96080201cf.43.1778770086665;
        Thu, 14 May 2026 07:48:06 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:06 -0700 (PDT)
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
Subject: [PATCH net v5 3/9] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Thu, 14 May 2026 10:47:41 -0400
Message-Id: <20260514144747.527175-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514144747.527175-1-jhs@mojatatu.com>
References: <20260514144747.527175-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1723543904
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288008-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu.com:mid,networkplumber.org:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

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
2.34.1


