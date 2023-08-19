Return-Path: <netdev+bounces-29124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A04781A8D
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88944281AE3
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC9174CB;
	Sat, 19 Aug 2023 16:35:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FB19BC7
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 16:35:32 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663DA5FF
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 09:35:31 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a44cccbd96so1409625b6e.3
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692462931; x=1693067731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z29+3z1/4bxUpOu2Gfht98o1ZpOA+SV6U777EguN+1I=;
        b=HTaywKJJf5ZxAO0M5a4+3wIDV8LglRiKguYJhuvJcFszgdWP59rq5eMQVCSujZKCfl
         zwHu9LqgwvO1PYDfqPKKEiIpV9DFN0cQ6TthjF/UE1+OvesaJRVT9C8YAeJC1fgxdOD/
         yI51zRWBlLTA5brGl3nszdv2BNEM565+ZWox/9Umo3JRg492BxtagBvpkfAm9akydyrQ
         JIZsHJC39/rHJA5V9MhDA29dlNyRuY4LtXKecu2cvlCcpED30kry0AE2e5QggBIP0fpe
         yoAWp7tg5rB1vW4Upn+tkSaseyYxY1CTc9bNjhgB8vG9excFxmFxhkpK78uguBbl/nIl
         0J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692462931; x=1693067731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z29+3z1/4bxUpOu2Gfht98o1ZpOA+SV6U777EguN+1I=;
        b=Mxapzg6pa4Lkx5I65Mttv73fqXaYK/KXKEcthGaqhLQVEhqLBmKNR8nULiY8R546r6
         Y8DXdQX/w6Mmf8SNTyRem221YFbJbt8jAsf0OfNENFvWUFEFyOLQaWPD6labdllLshYE
         4YfYbV0zbu6WaU5IVtud8DSSDTEa8S2lyw3E4xhpmW4ydum8IQaApKSRbBCQ57RW95sc
         YVDTXIyuEe1Kx+6uQZCxuA0aCzI2RIcZeV9VfIn7g9y4NKwK12c1gegAbQkJ9MEr0Qur
         s0eam/B9hInNqJ2VxbkbRK56eEkQS9kg6AuIybEvM5wAb/76RBr7pW7Tl35QwwyoeGXI
         Nbjg==
X-Gm-Message-State: AOJu0Yz443TnPn5tl2rJAiPi5bWivVGexZrvfgCj50O89uuwLTcUlIvD
	tseTsLvIA2va0BAEnYa1NgyIYA==
X-Google-Smtp-Source: AGHT+IE1egHbjxj4yYwoaK9mNup9AGch0OnKM0UcbQs7W3RCzy/jOkgqeQ6ARCVQk1aAM8A8icCKuQ==
X-Received: by 2002:a05:6808:3a8e:b0:3a7:7988:9916 with SMTP id fb14-20020a0568083a8e00b003a779889916mr3014221oib.59.1692462930946;
        Sat, 19 Aug 2023 09:35:30 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:d019:34ee:449:f6bb:38e9])
        by smtp.gmail.com with ESMTPSA id p187-20020acaf1c4000000b003a7847cf407sm2098303oih.44.2023.08.19.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 09:35:30 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: [PATCH net-next v2 2/3] net/sched: cls_api: Expose tc block ports to the datapath
Date: Sat, 19 Aug 2023 13:35:13 -0300
Message-ID: <20230819163515.2266246-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819163515.2266246-1-victor@mojatatu.com>
References: <20230819163515.2266246-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The datapath can now find the block of the port in which the packet arrived
at. It can then use it for various activities.

In the next patch we show a simple action that multicasts to all ports
excep for the port in which the packet arrived on.

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
index 824a0ecb5afc..c5defb166ef6 100644
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
index a976792ef02f..00e776cdd3fc 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1011,12 +1011,13 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
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
@@ -1737,9 +1738,13 @@ int tcf_classify(struct sk_buff *skb,
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
@@ -1751,6 +1756,7 @@ int tcf_classify(struct sk_buff *skb,
 	int ret;
 
 	if (block) {
+		qdisc_cb->block_index = block->index;
 		ext = skb_ext_find(skb, TC_SKB_EXT);
 
 		if (ext && (ext->chain || ext->act_miss)) {
@@ -1778,6 +1784,8 @@ int tcf_classify(struct sk_buff *skb,
 			tp = rcu_dereference_bh(fchain->filter_chain);
 			last_executed_chain = fchain->index;
 		}
+	} else {
+		qdisc_cb->block_index = 0;
 	}
 
 	ret = __tcf_classify(skb, tp, orig_tp, res, compat_mode, n, act_index,
-- 
2.25.1


