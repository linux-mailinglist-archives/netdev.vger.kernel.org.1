Return-Path: <netdev+bounces-288013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OvVAlPiBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:55:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 580CF5438E3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F1A3103F42
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18F426D3C;
	Thu, 14 May 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="T8nxgny9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD57423A8C
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770098; cv=none; b=uRXF3f1YMiXTrrAiKxqbYISau/a/J0XIa8R8m20IjVz2h6HUD78NLaeVEEIxbMlZRQZ1ZOVyQUOmq7gS/JAlmg0jDt6ImTYaf3VuKb6uXAIEuhjMvSTP753Nd8tVS9YpI3VOohMsQCkCg4PK71VaBwAhDteHresDYEi1PMahaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770098; c=relaxed/simple;
	bh=GGnsOngtYsNL8PvXlOM6kpuD0nfEwzYqtYtxO717D9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZT4jPXyuUY9U4R3MXO9iu8b7+FhE6giLmw1MvdbQO2dRM8Ns3t7BP75n+4GnTQH0QrsAz6VCCi4gzGIUdzCmUl4X9W3OJHSXPnrLJN1eQh26nQC1mFsX4Cr33wmpvjnUCDholWbxgFcLkmN0eddx7vxAOTqnaBDNux84VaAvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=T8nxgny9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b4298d271fso126978816d6.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770095; x=1779374895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFYthfVWB66dFenrA+rsCMrgxtWnGXQ0VnKrRyQwRG4=;
        b=T8nxgny9ByIfPQCwfYCs4V+1RSQ7xiXzyVK5FAegy8p137ulW369eMKtvnEnth7nIZ
         rjPIjVReQlytoD6mS9Z2cNswFgAhtRZQ8wSDKJasFwjIsCXYzEXdH/F0QRRersbXO6d8
         WHyVIIuTwD59bbmmcnuCSzDYsgkW7KdfGxK1XiiFGb25MJRIh15HKFKzQDxbH2AJcMO8
         beS5Xp/Nq+3lSQVZwgZBkI9zdl6mFYwLsH/GKxW65DHiMPs0Q+7Oku3efLogBnhrSOgM
         P6OrXngKqus90aIwBhTcHRSPnEDKt+VR+6KnbIGDdJyjzJP54pebx8e3EgeiLmTf6fpa
         YBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770095; x=1779374895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFYthfVWB66dFenrA+rsCMrgxtWnGXQ0VnKrRyQwRG4=;
        b=CvC9b47n/WDCfaxwgf7O6ouSDVKY+kdHNbxALVM23950yhWEkTCVJnvpCeFV1g44l1
         UmU5qS83k7vK+zOeaSnk7iVKaxZ+RWE+ivcKl9eGCSGxg/Qogcu3ZeNNDQI54YPTIwif
         x/gajL47wLX55UaS24emCg/T+jOOr6P/bNwucoE7k8/KkKYUJDLRxPSC4jqUATONhToH
         eAq7rhaxY6Fy6E98Ng6fsLyEVGZT7U1KLpRjieiByUISZnY8YklCg7/bYSLX5Bl9bjzx
         wGW4jip4IqPhViZ17RgVrZqOo9AEd6kQT7mvJpylIrOK9a3dHVm53k5fYKD1lUV0cr7b
         7FLA==
X-Gm-Message-State: AOJu0Yz75h7jeeatRWxm2SWEJHwQbnAwzaHQM3Xu22HuejiT67EvUCzV
	lWlgDNPx1U3zyeYHRtFMWOBzxCI48gde2vVHD/NlpS83lxyqOvaVLgNi0DSVmc1x6cnKwtH2gGv
	GkeYAlQ==
X-Gm-Gg: Acq92OEGLYtmijjVyuAyooNi256cFr+jjLr7CXVwMkRIscuWo6SpDjDW97TQfpBjBH+
	6pkq+2UytmIle8Row4VcGpCLVQ6JIOLhYP0GD4bYqhR0tbiT2ZeQ8y5y2P2ExwTr+VOHZ25eukH
	jngI4xeUbvWDdMtc5vLa3rmYI9mikmlnVZKH1D5Q8weaXQrsFGri5g2pjZgaMc/itO1SbVKE633
	aIgusFDLRHRotSh+AKrOCZRA/hXATNsg5sgz4SpgfqWewQhabwjyG8EHTnjMAKFzhPDnc03c9zz
	g1cvtbTtuGduDICPkQEBoHijqeTCLGwP99ZMrMzadQjbNM1WyBiA20KX0lDI3RLhfjRWUmMEXgP
	VT27/1Lw80CAWMYBlPEY3Q+MGgAwS/yD03MoHG36MzZMsbNDQhijkU5IZxnj2Xm7KwdmtjJ0xsW
	f2EdG9uTRh92Z6SynWd7WIbj74zUeWm20gNcl5oA==
X-Received: by 2002:a05:622a:544d:b0:514:5d88:8296 with SMTP id d75a77b69052e-5162f6475e0mr109811711cf.52.1778770094596;
        Thu, 14 May 2026 07:48:14 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:14 -0700 (PDT)
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
Subject: [PATCH net v5 9/9] selftests/tc-testing: Add netem test case exercising loops
Date: Thu, 14 May 2026 10:47:47 -0400
Message-Id: <20260514144747.527175-10-jhs@mojatatu.com>
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
X-Rspamd-Queue-Id: 580CF5438E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288013-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim,networkplumber.org:email]
X-Rspamd-Action: no action

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
2.34.1


