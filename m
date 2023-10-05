Return-Path: <netdev+bounces-38368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9C27BA955
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4DD3B282216
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1D43FB3C;
	Thu,  5 Oct 2023 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fEeUPq7+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833F3C68A
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:42:59 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2DFBD
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:42:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-578d0d94986so927202a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696531377; x=1697136177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3O/ERWJdSwPkhO1vOSMkjoPltWYfQOcrySKZI1D6E8=;
        b=fEeUPq7+RNEBV2yKwOIyu0N//IWOrCjTPEKMqxvuN8PezKB/3ia3JH1FwFBVaBQsz0
         kQvsDCNDt9YXdDBSMNDPP4xgacUMuiAkfMoTHVZyPqTL01sVrkCwAt5HBaoyJNue2nJd
         ADfXX6WY/jraqEr2/XamwruRSZdr4y7+gsFCQtiChNmVRsXx8S77M6g4GEoYLjKtwCuD
         dcksnJfisV5ehOzpHWaRB2FQ3BgrCE3g9Jn10nxDIJg+HIwajBm79TOwmfvnHHD8mNa2
         imFUvEuMcqlIf/Q4u+tSIsFllAsdPsMWd94tVU53GbeuUUvnXn6SQuRjrO5iZcjRGxaj
         ufUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531377; x=1697136177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3O/ERWJdSwPkhO1vOSMkjoPltWYfQOcrySKZI1D6E8=;
        b=TJusriEVQxr1/2isdNfaeAWJc95XkJ9VHlF5mekzZGEby//tSeOEDUhAYtR5ekTkE6
         WVeRqFE1xLDI9PENaHN9KM/vUdHRbw71a+gAK1frcwmBqj3ng+3RnGT9SeyEv38+JbJN
         tbfyT7L4i/Cb34oZtDX40aIjgZe9VINTJ/8m8Z8Rlr2Kl4PueClN0Ewhk8srA0j4NS1F
         0j3Nx3DmYIzReSV72K2JXEsQCyg3bftIxceDpgYo/u9pTR9sie0zL8v2JEjjK+wQa3Wx
         KsA9HDtjbV5d7vSv/35Bf0WGfmFNGQXHW7RlmwXU9UvzSosyIfo8eQpRTJv6E6bhnitc
         rm5Q==
X-Gm-Message-State: AOJu0YxSfjRth0QBs34B0yX5dDpS9Bg7bYyDd+v/EsySrGqd2kCsZ94Q
	dHCCDxQlHjYmKqKJMhshEkgX6Q==
X-Google-Smtp-Source: AGHT+IEJXiQ6ybNJz/HqHWi4aT24Jx1PNg3ECmGtniOswyJbELYi85ubyqEZ/Qx/bH0+2dxEgxBEXw==
X-Received: by 2002:a05:6a20:1007:b0:169:cd02:65ed with SMTP id gs7-20020a056a20100700b00169cd0265edmr3132550pzc.34.1696531377123;
        Thu, 05 Oct 2023 11:42:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:b6b7:54d9:6465:eb2f:5366])
        by smtp.gmail.com with ESMTPSA id x28-20020aa793bc000000b00690d4c16296sm1725831pff.154.2023.10.05.11.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:42:56 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 2/3] net/sched: cls_api: Expose tc block to the datapath
Date: Thu,  5 Oct 2023 15:42:27 -0300
Message-ID: <20231005184228.467845-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005184228.467845-1-victor@mojatatu.com>
References: <20231005184228.467845-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The datapath can now find the block of the port in which the packet arrived
at. It can then use it for various activities.

In the next patch we show a simple action that multicasts to all ports
except for the port in which the packet arrived on.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h |  4 ++++
 net/sched/cls_api.c       | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index a01979b0a2a1..03ab3730ba09 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -440,6 +440,8 @@ struct qdisc_skb_cb {
 	};
 #define QDISC_CB_PRIV_LEN 20
 	unsigned char		data[QDISC_CB_PRIV_LEN];
+	/* This should allow eBPF to continue to align */
+	u32                     block_index;
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -488,6 +490,8 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index);
+
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 06b55344a948..c102fe26ac5e 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1012,12 +1012,13 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	return block;
 }
 
-static struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
 {
 	struct tcf_net *tn = net_generic(net, tcf_net_id);
 
 	return idr_find(&tn->idr, block_index);
 }
+EXPORT_SYMBOL(tcf_block_lookup);
 
 static struct tcf_block *tcf_block_refcnt_get(struct net *net, u32 block_index)
 {
@@ -1738,9 +1739,13 @@ int tcf_classify(struct sk_buff *skb,
 		 const struct tcf_proto *tp,
 		 struct tcf_result *res, bool compat_mode)
 {
+	struct qdisc_skb_cb *qdisc_cb = qdisc_skb_cb(skb);
+
 #if !IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 	u32 last_executed_chain = 0;
 
+	qdisc_cb->block_index = block ? block->index : 0;
+
 	return __tcf_classify(skb, tp, tp, res, compat_mode, NULL, 0,
 			      &last_executed_chain);
 #else
@@ -1752,6 +1757,7 @@ int tcf_classify(struct sk_buff *skb,
 	int ret;
 
 	if (block) {
+		qdisc_cb->block_index = block->index;
 		ext = skb_ext_find(skb, TC_SKB_EXT);
 
 		if (ext && (ext->chain || ext->act_miss)) {
@@ -1779,6 +1785,8 @@ int tcf_classify(struct sk_buff *skb,
 			tp = rcu_dereference_bh(fchain->filter_chain);
 			last_executed_chain = fchain->index;
 		}
+	} else {
+		qdisc_cb->block_index = 0;
 	}
 
 	ret = __tcf_classify(skb, tp, orig_tp, res, compat_mode, n, act_index,
-- 
2.25.1


