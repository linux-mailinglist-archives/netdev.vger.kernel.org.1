Return-Path: <netdev+bounces-32985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4C79C1C9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 03:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73E31C20A21
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DDE17F4;
	Tue, 12 Sep 2023 01:42:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6411385
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:42:21 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97ED567A3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:42:18 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5733bcf6eb6so2849556eaf.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694482938; x=1695087738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPgJx67hOSwuZN1fgj+5ME2A187O+0SAMN+I5zz9zuU=;
        b=o+phgkhbfwXZ+7NayYf4Xx1TkIkXOoByTFHpT/RkDMdt3kuUhyk12id8JcnXmGgUBt
         Jlo1V9dW/lSXmDwlpWvgssqoNOUcAWwxWKwtwau1cxZRTYzfNZ0aB5wWPmfyV6L2jOFB
         IX0z7ySN78oHleGY3VLdSYyenolcRcY9lZL7az4r6pCs3BBoql5hbzoBvpNffLtuAJu6
         UwFFeotQ1f8niEAImDb6qkIez1aP4RJl1qBJUlJxd9UKHQ/stjAB7a/swm6I2wYSgt9g
         fKmN/siBIH5V9iddxP1Nx/9u2tbJ2YJsUH48sTkPoimwbUqeYnVAXX4+Ij39BarqWVuR
         aF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694482938; x=1695087738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPgJx67hOSwuZN1fgj+5ME2A187O+0SAMN+I5zz9zuU=;
        b=JJvhhBtcz03+9PI6YwphJKQhITCSCd0UsQ6XSEURfhOObIGIZj2CYWGAgFFE+RBOne
         qjRH5xgzVCBeB1hsyo1pUfYVzzgmlotOXf2XehztyvRW8arxE6iEHo095COk2PYDlwHj
         evwY+/DjFL9QkMkbFI0SgfvA3OJEc5stnIO6ojVwY51ADEHG89xZNhHwYxYixaZ6FJJc
         HKppvtmw/IEwKF+k/bO+gvXZRjd4C5c4yCd+wkssc6NHcxtfdm8EcADRtwbtAIC6Rf0v
         JwvAvpHMIApZazrsysd2TvGc/X2W+bRZPDyIZd17A7Y2Ih226BmAOUw3Qd0K/q5t7Qe0
         XnUQ==
X-Gm-Message-State: AOJu0YyYGPXocVcLj5qPyC+1RZ2wEsYWtWkKqTLfGM/r2oLRjTG5Y6uQ
	dFZQ8koI+c8OVCnkx0GepOfa84lqdorfcPPI1Nc=
X-Google-Smtp-Source: AGHT+IEtUnbXeAtJPJUkX98cW2sV+ZeIvVbdarE/y7tMw7shargT1ayC8q41vTRw/SNztMzrYt/qww==
X-Received: by 2002:a05:6830:14ce:b0:6b9:c7de:68e0 with SMTP id t14-20020a05683014ce00b006b9c7de68e0mr10382298otq.29.1694474894864;
        Mon, 11 Sep 2023 16:28:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:424f:fdef:90d5:8e0:d9])
        by smtp.gmail.com with ESMTPSA id l10-20020a9d7a8a000000b006b8c87551e8sm3534293otn.35.2023.09.11.16.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:28:14 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v3 2/3] net/sched: cls_api: Expose tc block to the datapath
Date: Mon, 11 Sep 2023 20:27:48 -0300
Message-ID: <20230911232749.14959-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911232749.14959-1-victor@mojatatu.com>
References: <20230911232749.14959-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index f002b0423efc..a99ac60426b3 100644
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


