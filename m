Return-Path: <netdev+bounces-286791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GoMJjEhAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:34:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C28514820
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7F183083A93
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3747CC91;
	Mon, 11 May 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="mRpCnhZk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05917555
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524283; cv=none; b=EtNhfx9w7M9FP1J1kMK1BO5kYrC/8zBmptGMKbTB1CqIvnoz9rll+kuv4hn2O5C1eUrSeSFrByP1wmjGLT5NbYQHFe3d7z4d644bnbnoJejZLAJC1gO8i3y/+8Kwh4HWTlxnuQGecY/etre3yIEFiYxVB9Lyaju6zNTdxUpc5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524283; c=relaxed/simple;
	bh=+QlL6iyz7/CLjt3x3DSP4yFtXPXod3gdJe7u8Dlp6Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hq49EgIfCkONGC+R/refS8QRHoqT9iIrYvZfiZuL1UHgYkW2NAaWflz/vnb63dFzeInl0RgayL7rq36Z/kFRujR1nvM76sx/jttAIgJUF8ViEyLrfSKcRpagNHOlGQd41r+omu4/wh/Irsl2N+G0eb4KknL92ly04ftJML/Kapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=mRpCnhZk; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd89701acso4336476a34.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778524280; x=1779129080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNCTDpez++Hkz88EBoEm17saO+9kg7PD5O1BYUAn9BY=;
        b=mRpCnhZk5lEaZetaaGjEvOOQzpop3vaTqDH+ueV3sPZx3mxanOyPwRCrDROo+oRVuB
         Uk9jRIH7SZEGypLe+TnWH7NCsZbv8rN2mivtELhAaZCmXbg1B3CE8Bmk6w4toXJy1sS4
         viHuycsLxNX5ewuUIQIW7R6YgZb+A6yxxzZVPjmVJEpUyp0pNuxVtv5cSMKio7/5xwCy
         st50BH/egFRGYJUcd+ZRp30tfB5KuUq8u9Arhif8rXYpejsBHKjc9CHBeCvv1zQ8PQkX
         BY9giFEKymTiJpnyuC8IbJGzpwQscZfmXZDaitRnUdu+zuL8oBSnSXbu+0GzsFv3tM0h
         A0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524280; x=1779129080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eNCTDpez++Hkz88EBoEm17saO+9kg7PD5O1BYUAn9BY=;
        b=hB1UT93BfkVxtLocKuTSqhZFvcImI3bz6kATqe1WOcEqqBzfweVSEWVOX+KV3Je/EB
         cCwLY45Gdg5PYSRFY8Zk2IkD2CPV2+Jt/2jVftyOpSAHVJDvb0WG7w9JmmdS0XFgcVL3
         pUT6DkAaYTdgz4tmIazj9MnUIXDzX68PEu1mJcz6l6zor4picc7FmhChyXIjv2Hv3LhR
         2Vk0ftsKrGtO1t6y5iAEBa1ppb1IVXt6riTZGEjQ0/h6/xW6PlfQ6y1qepyQ4w0QKfAd
         XBLjy3s+jUrICkrAQa0aCuZeUPWwpy/tFfL1kFmvuP3rMWBNfywL7En6hH/ONFZbIErL
         4NQg==
X-Gm-Message-State: AOJu0YyuMB7T43nqa1kE52+GclME7j3UiW16eIJR6kmkd8umIbjx5Fmg
	kAakHtRLPqXNnn+uGwY00Tp6qgQuw2mOWPo8uFZpZIaipV1l8m3r/8UrOG4rfFm7P4dzK7ztulz
	aA5Y=
X-Gm-Gg: Acq92OFjwMb82H83y75aFWq1hbtc+mILA4KTYNFZhHDcOzgLpZf4F7TTA+dGW9UjwZ7
	XRG5+wUcaMX2aqZiw72rYgIKk+4hNL7EjEvfQHiCbJBD2JPMs1bUaHpNjM8gS9q9wUL+OTo6fY6
	Q5aKjtXXqWWCQaWEgvqNfpOJCbPCqla9sOghPXGLqgP4mknh8i0sbtn0mM8ZhXz/85LnOQE+aLE
	bCadv7aqz2h7QF/1gANe9iA7YwasnuY3FRZZ/Npz1K+TsH4TID8Cy/GbUrbWgkFijwogb45X8pN
	/sChBXn2okYAoDs1WGMAtmDGet0ZC172h4Fz+kwS5WRGc1Aqgi8gkk74/4sC2Qf7T4ZiqQ+I0Dw
	BEYMIJ9en6W0BjM+YsJqWTIPaeGTtuKkXl9kbOJK1o3/shM9Jx6fSTFMKzBc+uZJnNe5pSjFSEH
	Z/q4dwcZUg3I+oMVUDnInXyckr7vN05+mI7rSDYQ==
X-Received: by 2002:a05:6820:1510:b0:691:f0b8:fd99 with SMTP id 006d021491bc7-69998d320e6mr13622801eaf.45.1778524280548;
        Mon, 11 May 2026 11:31:20 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e675b9csm94339741cf.11.2026.05.11.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:31:19 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: vinicius.gomes@intel.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	graypanda.inzag@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 2/2] selftests/tc-testing: Add QFQ/CBS qlen underflow test
Date: Mon, 11 May 2026 14:30:58 -0400
Message-Id: <20260511183058.422998-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511183058.422998-1-jhs@mojatatu.com>
References: <20260511183058.422998-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17C28514820
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-286791-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Victor Nogueira <victor@mojatatu.com>

Since CBS was not calling reset for its child qdisc, there are scenarios
where it could cause an underflow on its parent's qlen/backlog. When the
parent is QFQ, a null-ptr deref could occur.

Add a test case that reproduces the underflow followed by a null-ptr
deref scenario.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
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
2.54.0


