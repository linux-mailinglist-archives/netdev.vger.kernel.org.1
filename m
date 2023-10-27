Return-Path: <netdev+bounces-44788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED17D9D6D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D421C20F80
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31C638BA7;
	Fri, 27 Oct 2023 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1yi8lc1M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5F381A3
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 15:50:54 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96017CC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c8a1541232so19863155ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698421850; x=1699026650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FBoeJJWA4+RBZsPkkQthYm9S/aKJyadKQrs0ijJEew=;
        b=1yi8lc1Mr78GuUH1Xy/PWn9CwJSna4m71yxS/kAe55nECeHWVHTTuI1qZ90GErJWKs
         o03vwlcRUKlv5qRsV4+XvKzRoDNaDP02lV/1iPba9UfanN/GuPTgbapWXbN5CuA2stq/
         nijs1Sda5bMG+RpCENNv5SyXLlK1f90VhAtUfHrE/S0pntU3ve+FDqDvRnBc52zjBIML
         y3IRcNdyuuOp3qFIzj6JATpsrDHZNJvjVt7O5BMirlV4EUMWO1h9ocGoelhYFrBXoZmI
         X9aKBEdQrB2J+qi2LhPRIvzcVuq+ztSRRWxehQUQA+iSJXf9IYNpy7UVNXASKskzwSwN
         nWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421850; x=1699026650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FBoeJJWA4+RBZsPkkQthYm9S/aKJyadKQrs0ijJEew=;
        b=kmehz5epO+4KzMnEZldPMyBhNZxs+a9xkZc5WKse/Ohzny2EOX23WgMMIJsHexYdP3
         ynmYXFkpIFtDTbZwfDIsBD7yMVCLEbQHmR8d7POgPaCjPhb31M8gg0nReKy9RrKDLDWF
         ysfi9Ugv76xPbhZjQ3N5FWWP33epm/Bq8FrnzQ2nDE3ubNzy2YRpi0s2QWt0lw6LuqkO
         kVZXNVucfBCM+sEm94ItG+XcTA/BGzDUmimDr30OVTCqWJ33J5I7uwyYj2UKG/23kzRS
         EIpMKC9rHmZQAfqMYMCPE18blRLm5bogFDvIvK9SAPe8eH4xecVahXi2sD613CZGcyWQ
         XhlQ==
X-Gm-Message-State: AOJu0YyKVyMHtzgQD4Xy7Yq9hqsJ6orAoP/+I46W9xpV/6/GDfSciTOS
	onyk54M08kMlOrWklPrUtuI87w==
X-Google-Smtp-Source: AGHT+IFUDqk1f6SSsH3yy9m/D/NmCd06t2DTNdRzEaJi9Phys+xLK+IxqdIHwK0ERN4ZFzH0yHJ8Rw==
X-Received: by 2002:a17:902:e746:b0:1ca:2caa:aca6 with SMTP id p6-20020a170902e74600b001ca2caaaca6mr2980014plf.68.1698421850056;
        Fri, 27 Oct 2023 08:50:50 -0700 (PDT)
Received: from localhost.localdomain (S0106e0553d2d6601.vc.shawcable.net. [24.86.212.220])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b001c726147a45sm1730224plf.190.2023.10.27.08.50.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:50:49 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net: sched: Fill in missing MODULE_DESCRIPTION for qdiscs
Date: Fri, 27 Oct 2023 08:50:45 -0700
Message-Id: <20231027155045.46291-4-victor@mojatatu.com>
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

Fill in missing MODULE_DESCRIPTIONs for TC qdiscs.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com> 
---
 net/sched/sch_cbs.c        | 1 +
 net/sched/sch_choke.c      | 1 +
 net/sched/sch_drr.c        | 1 +
 net/sched/sch_etf.c        | 1 +
 net/sched/sch_ets.c        | 1 +
 net/sched/sch_fifo.c       | 1 +
 net/sched/sch_gred.c       | 1 +
 net/sched/sch_hfsc.c       | 1 +
 net/sched/sch_htb.c        | 1 +
 net/sched/sch_ingress.c    | 1 +
 net/sched/sch_mqprio.c     | 1 +
 net/sched/sch_mqprio_lib.c | 1 +
 net/sched/sch_multiq.c     | 1 +
 net/sched/sch_netem.c      | 1 +
 net/sched/sch_plug.c       | 1 +
 net/sched/sch_prio.c       | 1 +
 net/sched/sch_qfq.c        | 1 +
 net/sched/sch_red.c        | 1 +
 net/sched/sch_sfq.c        | 1 +
 net/sched/sch_skbprio.c    | 1 +
 net/sched/sch_taprio.c     | 1 +
 net/sched/sch_tbf.c        | 1 +
 net/sched/sch_teql.c       | 1 +
 23 files changed, 23 insertions(+)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index cac870eb7897..9a0b85190a2c 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -574,3 +574,4 @@ static void __exit cbs_module_exit(void)
 module_init(cbs_module_init)
 module_exit(cbs_module_exit)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Credit Based shaper");
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 19c851125901..ae1da08e268f 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -513,3 +513,4 @@ module_init(choke_module_init)
 module_exit(choke_module_exit)
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Choose and keep responsive flows scheduler");
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 19901e77cd3b..097740a9afea 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -495,3 +495,4 @@ static void __exit drr_exit(void)
 module_init(drr_init);
 module_exit(drr_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Deficit Round Robin scheduler");
diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index 61d1f0e32cf3..4808159a5466 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -513,3 +513,4 @@ static void __exit etf_module_exit(void)
 module_init(etf_module_init)
 module_exit(etf_module_exit)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Earliest TxTime First (ETF) qdisc");
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index b10efeaf0629..f7c88495946b 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -826,3 +826,4 @@ static void __exit ets_exit(void)
 module_init(ets_init);
 module_exit(ets_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Enhanced Transmission Selection(ETS) scheduler");
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e1040421b797..450f5c67ac49 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -269,3 +269,4 @@ struct Qdisc *fifo_create_dflt(struct Qdisc *sch, struct Qdisc_ops *ops,
 	return q ? : ERR_PTR(err);
 }
 EXPORT_SYMBOL(fifo_create_dflt);
+MODULE_DESCRIPTION("Single queue packet and byte based First In First Out(P/BFIFO) scheduler");
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 872d127c9db4..8c61eb3dc943 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -945,3 +945,4 @@ module_init(gred_module_init)
 module_exit(gred_module_exit)
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic Random Early Detection qdisc");
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 880c5f16b29c..16c45da4036a 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1693,5 +1693,6 @@ hfsc_cleanup(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hierarchical Fair Service Curve scheduler");
 module_init(hfsc_init);
 module_exit(hfsc_cleanup);
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 0d947414e616..7349233eaa9b 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -2179,3 +2179,4 @@ static void __exit htb_module_exit(void)
 module_init(htb_module_init)
 module_exit(htb_module_exit)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hierarchical Token Bucket scheduler");
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index a463a63192c3..5fa9eaa79bfc 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -370,3 +370,4 @@ module_exit(ingress_module_exit);
 
 MODULE_ALIAS("sch_clsact");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Ingress and clsact based ingress and egress qdiscs");
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 793009f445c0..43e53ee00a56 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -789,3 +789,4 @@ module_init(mqprio_module_init);
 module_exit(mqprio_module_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Classful multiqueue prio qdisc");
diff --git a/net/sched/sch_mqprio_lib.c b/net/sched/sch_mqprio_lib.c
index 83b3793c4012..b3a5572c167b 100644
--- a/net/sched/sch_mqprio_lib.c
+++ b/net/sched/sch_mqprio_lib.c
@@ -129,3 +129,4 @@ void mqprio_fp_to_offload(u32 fp[TC_QOPT_MAX_QUEUE],
 EXPORT_SYMBOL_GPL(mqprio_fp_to_offload);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Shared mqprio qdisc code currently between taprio and mqprio");
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 75c9c860182b..d66d5f0ec080 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -410,3 +410,4 @@ module_init(multiq_module_init)
 module_exit(multiq_module_exit)
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Multi queue to hardware queue mapping qdisc");
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6ba2dc191ed9..fa678eb88528 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1307,3 +1307,4 @@ static void __exit netem_module_exit(void)
 module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Network characteristics emulator qdisc");
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index 35f49edf63db..992f0c8d7988 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -226,3 +226,4 @@ static void __exit plug_module_exit(void)
 module_init(plug_module_init)
 module_exit(plug_module_exit)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qdisc to plug and unplug traffic via netlink control");
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index fdc5ef52c3ee..8ecdd3ef6f8e 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -433,3 +433,4 @@ module_init(prio_module_init)
 module_exit(prio_module_exit)
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simple 3-band priority qdisc");
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 5598f8be18ae..f93c75897b84 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1535,3 +1535,4 @@ static void __exit qfq_exit(void)
 module_init(qfq_init);
 module_exit(qfq_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Quick Fair Queueing Plus qdisc");
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 16277b6a0238..607b6c8b3a9b 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -563,3 +563,4 @@ module_init(red_module_init)
 module_exit(red_module_exit)
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Random Early Detection qdisc");
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 66dcb18638fe..eb77558fa367 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -937,3 +937,4 @@ static void __exit sfq_module_exit(void)
 module_init(sfq_module_init)
 module_exit(sfq_module_exit)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Stochastic Fairness qdisc");
diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index 5df2dacb7b1a..28beb11762d8 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -307,3 +307,4 @@ module_init(skbprio_module_init)
 module_exit(skbprio_module_exit)
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SKB priority based scheduling qdisc");
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1cb5e41c0ec7..99a27a3878b6 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2572,3 +2572,4 @@ static void __exit taprio_module_exit(void)
 module_init(taprio_module_init);
 module_exit(taprio_module_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Time Aware Priority qdisc");
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 17d2d00ddb18..dd6b1a723bf7 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -621,3 +621,4 @@ static void __exit tbf_module_exit(void)
 module_init(tbf_module_init)
 module_exit(tbf_module_exit)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Token Bucket Filter qdisc");
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 7721239c185f..59304611dc00 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -523,3 +523,4 @@ module_init(teql_init);
 module_exit(teql_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("True (or trivial) link equalizer qdisc");
-- 
2.25.1


