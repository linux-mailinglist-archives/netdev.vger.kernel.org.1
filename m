Return-Path: <netdev+bounces-272200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iINKNjV7xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:30:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346933A18A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2ED316E82F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0AE425CD0;
	Thu, 26 Mar 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GvlHPH3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8657421F0F
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549089; cv=none; b=KsRXIF1lMmtdoWNVF0Ogdee/U1xu6AQfA8ypYxsdbWH1Inwzd2CxMqRZbfDyKwgGpfv5xYcqU5thzTQtl4nc8GxEjVKtqJX8Wo0YQgKg49K/gwKTtQq7J1Qz9PCiWVoAilI80mzaDmm6OU+6rg1QSduiGUAcdJxZMgyHVe71vBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549089; c=relaxed/simple;
	bh=xdUhF/KwIaxp28zFidG8j9PibEk6X7fY9j02u2I9ywU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDkSvK0L7OJbyo/xnlH6/hJBBmWEjERBoSRiesKfhDs4mFjcCZfAp57WVAVn9KJbT6cDqy8J2O+zf7YTTntOb5cXftbMe6Q+r7M9ZSXIJH5T+ZCmy51P3t63AQ+x6Sm8MAWwaQ3Ho8hgsAJinEjtMTx0DaTULQ2nFizPbmI5H+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=GvlHPH3V; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so825175a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549083; x=1775153883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh1r6Pvg7BKd1OpHUecM5F37Mt8FqKX1fTxba/c1k+E=;
        b=GvlHPH3VS2eK6FMcRfsBctB8QtRxpXMNencF/+xB2IqcVHnr3i8tdWFwlhKDq1hftd
         KxoD8wtwHrUhS4zbqrd9J/sQbp/kXERVwE7bAoAmLyd/ckrGdP1SRrPT2JhaV9B6Pib3
         +Utf1vooiwFnCiKVPZ+FfSBvoX6ftZXtQajkZsXgMbLjhLM1uTP94zs9MCA8CA9Q2YNL
         mDygCVsXJpy+jdPZcwWxbbRL5ONPHI32J3ggP6gSS7Bm3oxSpq/e8qT1YcNNSKu7Tmiy
         IPpTos3xhP4w5m9Lq451yiaMSHg6PiYpIlFgnYkI4t2HYHRHiCwPf+lIoAZY/pR2BdlG
         3pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549083; x=1775153883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dh1r6Pvg7BKd1OpHUecM5F37Mt8FqKX1fTxba/c1k+E=;
        b=qtgDBFwld+g5XgUwFQxGIK7ikki9QdlSpabp9Id2BWVzo6qw/U7fgP9YOlTF8bjI9O
         r66hLfBTiDxjb5CHuJl/KaKn+hMPa631xKLOig+OGOyHBWF2uJWFJR0cwoXx6acwcNe0
         cThwTzGW1M91DK95a+3uUkY76AAFml7E2mh86RrC2+hVwc7ZMahZln6bY22HS5L8koMm
         yia6K4lpLU//izlwclSQvEQJncugpckck/F808ACMu9ZjYyRSMREWSzDkf9JkXBcC6KC
         k09rYLSzy7zeMtQD+0yByVwE9n/qnArShzw1bKEhhiQqHerukfflX8nG6vjWVCOoklB+
         limg==
X-Gm-Message-State: AOJu0YzIxe2qMGxIr12dKAYGUI5FtbNBVTNKFpcqmbLiLppKN15y891O
	8Aj3/3XvzCuOvX76DqxVqfhw5vHZVmOKknxvog0jVF+LyT08NQ75yUI+0VnYe7+HusTFkeHd2EF
	hE1V/
X-Gm-Gg: ATEYQzyaUAz0l0L7paA1WETecG0zNBAKebtSPdId3IJpTM3Z1tU4PTxYoy1cPRzVQYD
	4omeennxDUE6LQas1u/pcqBq/Tl8wSXoksX/ziIROHvEPGPTiAo94nCxJH9IqDBX14kFeCp5Dmc
	xzYhhJkd0ud6mKznBfzCK8BUUrrlClN5J6q0SaW4goWYchkl3v7nUd2vApHQjnCvQhINTlzBHDT
	zUXGawkO+9depPtXWA2WS8L9OIWM3gNqdx/01HWW9Ehi5qolqbZrPQdXerL74CbeBIOrmckTCCJ
	j9OXYZkI9yCEx9IihFWTKGHTnDknskmJ7jZxGBoZPl0D3UMI6M1DfFp88XYkmQ+ucgmoLpZqo22
	RdQBiE70X/dxMszoA19i58h7OOXs+zjZVrR82PON6KVt1ebNKrmd5nsgQFqdPzsaAd9yOr0BN5v
	glwZgu/47V0sZlTBvxmjjuZhfvCSUeZVvh
X-Received: by 2002:a17:903:32cd:b0:2b0:c59f:3b58 with SMTP id d9443c01a7336-2b0c59f3e05mr23546195ad.9.1774549083508;
        Thu, 26 Mar 2026 11:18:03 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	William Liu <will@willsroot.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 7/7] selftests/tc-testing: Add netem test case exercising loops
Date: Thu, 26 Mar 2026 11:01:06 -0700
Message-ID: <20260326181701.308275-8-stephen@networkplumber.org>
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
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272200-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7346933A18A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.53.0


