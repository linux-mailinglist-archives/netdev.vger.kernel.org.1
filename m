Return-Path: <netdev+bounces-291315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP14FnlAFGo3LQcAu9opvQ
	(envelope-from <netdev+bounces-291315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:28:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF045CA7D4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBD5F30347CE
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0303839B5;
	Mon, 25 May 2026 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="zOyoQIkO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1D383989
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711986; cv=none; b=bocUFvJeM0WdX3DTXLb3V2xNLigSSpakcxFGLir2AIt+uK1pAOJZmuEamH7Yy2yVfwtwtO9vZFQ6WtfsrPc48Ti0o4tfFSEgaIzo+wZpYVLyFq6zJrYuSkuF/3Kfr0Bvc8ECogqnmcyptFkT3YDz0IQvyRn7qNIq0QY3Tz5sgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711986; c=relaxed/simple;
	bh=AyTAHjPt8hP7O6LWsilvDYe7PpDW+okVJOL9O0GSeuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7kiKS7VJRai1hsWdtnX7JvAE3U3VmKeqW8Nf9zOWOmUCEHvdub2Bw58bamvO16p0rg2zLKCUSdNrSUP4qjvluUY9ptRCJE39He6oaVJVLFJoZXhJagB99Nb6EssJDTHj39Hhqqpu7OEJC9rghg1o+76Cv3rT4cK4lk5F5uV7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=zOyoQIkO; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-512f09ecc67so65927711cf.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711983; x=1780316783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXlpBejPW0q1+BEKZD4Ba4Zs48PsVlxHtyWQqPh2PHw=;
        b=zOyoQIkOgyIb9eixuEC4CfGYJqspaL2Y597y2Q8aZck2Y/67XFhWMYsu/0wlgyrZjq
         zxIzAGc0ifH04v0EEaJP8hEciS+hAseeSm3a5SKx57oSyqUPni92nZQVKlylx2deMCiQ
         JIcF7CU86XOErRGv2axLwI9qmw+OKv3fywJL2exWVkyaJxYz/JxlHAyySz/o3L+MBYgM
         SNY99DkKVu8B5jwhu0mXLmPl6gFftJVxjQHN4lkuQJOGoq19Vkrzkz6ASorR2c5rqZA2
         5qJFth5XrOXE/5CWf5NlogY9NYwmJN7H3f+w2JkmguPTp578fwuYwtMLhwVAxqql3AUn
         N4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711983; x=1780316783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXlpBejPW0q1+BEKZD4Ba4Zs48PsVlxHtyWQqPh2PHw=;
        b=a7U2rpFW4Xjw4qDs6u9BHXrxiRTWi0hK5XIWGhaeZ4+6CInomxK8pAyKH6u+9+qpwU
         pUESOu+/zVtC8voBHaullkSZzOdSf78BOudz0hkr2OSTtzYOn/VMu2F3twby09OV8G4o
         i6sp8p3Uv3EUb1PZJK/zyVSpPbN5Cwxr2SgnMAqR63JClk4y2kysjXA5pDNlkP/CR1rO
         kUzpmvWnGG4et4eshKfepXI9Eopj8k6aMuGNeLBzwrjgTrNyYczoCziThmmqvooeK2YG
         8qI5kIOLw/+rLGLPK/3KTKsGN98AoNqaowkIQCMLyGZ9YJSoV2ijJysXmAaua62g+XiN
         d8hg==
X-Gm-Message-State: AOJu0YzOPc9bjsEsm+HniEmrAuJFj4/I2OJZthhfB83hoIkNaDX4zaX3
	UpF1CXYGz7W//TEoutF4R0Ut5llx14b5RO9IDQAXhtSf+dtlvyd/9HM2XpbuWKY/6B+7QAW7Zq5
	eDUT5Wg==
X-Gm-Gg: Acq92OGSap5Z+JZ3uu7IUROVAhaxlmmOsJa16kJ1fLI3L/MsEp5zYmCpOO8ME5MpWGP
	4yQ6RuKlpSrJ+cWeEOvmoJ7t6sLDgQIA7iNjH3YAT2jc9/WR2P0ZmIxWQYIcEeQC8gpQx3H0T89
	J8DsJcbfACuHdAP+IjrsZohX1iVU2l9pzCy0vETg5pnk5cXN+ZFXCePxkbYL1pREr8+PbDkMILg
	8QJaTBtAIH8mtAg7keDHdTLMLXShJ0BdVThAcP/PtYyCc90nZcn6FtvE10Lecpo4jAGs2Hv2S0t
	fbFDu9shXgS3DwHRlB3ebnkaoyiei+h9HvxgzXr4366aHJg+U0GH2DsH0vI4pIp+NdY6/6TvZAg
	CM9B6arkpYkT8IQX9euz29eHU+I1+vKfM1C2uRX6hHpgcGU/pAeh1sno13ZR2KDJ/r7Lgx7sEFP
	7sxt/rZGjvLxbHCmXLcDcn3r/SST9+hCITtiM2Xw==
X-Received: by 2002:a05:622a:a0b:b0:50d:83a4:2995 with SMTP id d75a77b69052e-516d42e2faamr201579881cf.21.1779711983517;
        Mon, 25 May 2026 05:26:23 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:22 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v6 9/9] selftests/tc-testing: Add netem test case exercising loops
Date: Mon, 25 May 2026 08:25:56 -0400
Message-Id: <20260525122556.973584-10-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
References: <20260525122556.973584-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291315-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BFF045CA7D4
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
index 3c4444961488..472b672a600d 100644
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
+            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1000 duplicate 100%",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1000 duplicate 100%"
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
2.54.0


