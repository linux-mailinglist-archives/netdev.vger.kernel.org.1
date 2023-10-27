Return-Path: <netdev+bounces-44791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C427D9D72
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA471C210F3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38138BB9;
	Fri, 27 Oct 2023 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QuDaISih"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFA381DA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 15:50:50 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DE18F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc2f17ab26so1052245ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698421849; x=1699026649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0pSkMSNd3yr4gDCagmxvXuObuROrvOCy0S8y6P2g/g=;
        b=QuDaISihA7OGSAdng6Xb508ql+VFRgDV7XbaiQvc3eCv8wLr6j7ffmbB78oTQSQJ9V
         Kcr/o1aMPW5x1pR1vh52qImRvcQNeSG3XFvKllx3waFB/mQ4t4+6zt46EHxIB6Ixe6eM
         PimivoMNfOKpPueNWkyx36Ye8ZrLU1LdNpsjEyTzx2ykM/Ow6YeFA+SUP27sVXdEsOdR
         reK+rQLwCQ1Hx3svdCJtLKu7jpSMUXI4yJVJ1d6nCEFCUSgLfmukk4RLGC0UGHSrdbrA
         48NkAdAy8t8OX3WyWWupAt9ZyV4yJPN73cSlOtTuucZSImLtL/rzH8vOSJyAXGMd9IYF
         xwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421849; x=1699026649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0pSkMSNd3yr4gDCagmxvXuObuROrvOCy0S8y6P2g/g=;
        b=iEJFzO/D/xvYBRiDbinWteHon8hroaj+7LMtyngDFQ2B6rp9pRVEWoFPN8c2TxmuZb
         zapXJBiPAnrf0o0TNXSrR950thVP5f0bbQEb9mfxJDjZnMoI1Vl1+F+CrveKokHE/k8J
         ZU2tuqg33aJTvqIBOEIpUia2qHjfCucqjJiPkRrfbsKjW7nP7hW5TrqO0dyJ5IKoyV/t
         uRokfN/PsiaeOEA26KYSmAXBmywYnaNpRhQFMWsfCRWaNEW4HgYGA1RPqTAGQhRUeXIE
         KJ6/BQRStCxZeT2KsgwU3DrxWN2VxYBZxnYoAPO44hB5TA+fcPaZBvpAHbj7N85mpNDZ
         CJzQ==
X-Gm-Message-State: AOJu0YzLC38VBISyol9SB35lzkPXKR48X9GhBvUtGFlwC9FGxRHPy/er
	284pTqhQ9MLUwAT64QZ7fZoAug==
X-Google-Smtp-Source: AGHT+IGLGDAjTu/99QOysbY0efEulBHQ2dXmEgPZyB15vLlui95qLvGhGi5zYQJRRN6aafGiwbAbQw==
X-Received: by 2002:a17:902:e887:b0:1c3:bc2a:f6b4 with SMTP id w7-20020a170902e88700b001c3bc2af6b4mr3540118plg.42.1698421849220;
        Fri, 27 Oct 2023 08:50:49 -0700 (PDT)
Received: from localhost.localdomain (S0106e0553d2d6601.vc.shawcable.net. [24.86.212.220])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b001c726147a45sm1730224plf.190.2023.10.27.08.50.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:50:48 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vinicius.gomes@intel.com,
	stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next 2/3] net: sched: Fill in missing MODULE_DESCRIPTION for classifiers
Date: Fri, 27 Oct 2023 08:50:44 -0700
Message-Id: <20231027155045.46291-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027155045.46291-1-victor@mojatatu.com>
References: <20231027155045.46291-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Fill in missing MODULE_DESCRIPTIONs for TC classifiers.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com> 
---
 net/sched/cls_basic.c  | 1 +
 net/sched/cls_cgroup.c | 1 +
 net/sched/cls_fw.c     | 1 +
 net/sched/cls_route.c  | 1 +
 net/sched/cls_u32.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index 1b92c33b5f81..a1f56931330c 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -341,4 +341,5 @@ static void __exit exit_basic(void)
 
 module_init(init_basic)
 module_exit(exit_basic)
+MODULE_DESCRIPTION("TC basic classifier");
 MODULE_LICENSE("GPL");
diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
index bd9322d71910..7ee8dbf49ed0 100644
--- a/net/sched/cls_cgroup.c
+++ b/net/sched/cls_cgroup.c
@@ -222,4 +222,5 @@ static void __exit exit_cgroup_cls(void)
 
 module_init(init_cgroup_cls);
 module_exit(exit_cgroup_cls);
+MODULE_DESCRIPTION("TC cgroup classifier");
 MODULE_LICENSE("GPL");
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index c49d6af0e048..afc534ee0a18 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -446,4 +446,5 @@ static void __exit exit_fw(void)
 
 module_init(init_fw)
 module_exit(exit_fw)
+MODULE_DESCRIPTION("SKB mark based TC classifier");
 MODULE_LICENSE("GPL");
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 1424bfeaca73..12a505db4183 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -684,4 +684,5 @@ static void __exit exit_route4(void)
 
 module_init(init_route4)
 module_exit(exit_route4)
+MODULE_DESCRIPTION("Routing table realm based TC classifier");
 MODULE_LICENSE("GPL");
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 6663e971a13e..d5bdfd4a7655 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1489,4 +1489,5 @@ static void __exit exit_u32(void)
 
 module_init(init_u32)
 module_exit(exit_u32)
+MODULE_DESCRIPTION("Universal 32bit based TC Classifier");
 MODULE_LICENSE("GPL");
-- 
2.25.1


