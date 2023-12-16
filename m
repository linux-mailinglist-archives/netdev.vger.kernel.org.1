Return-Path: <netdev+bounces-58297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209EE815BBE
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46E6284A56
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11141E490;
	Sat, 16 Dec 2023 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UYEun8hc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502991171F
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28b4a73d3c7so633779a91.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702759494; x=1703364294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VonD+K3QsuKIL2LfV/vmSih0z6Wya+9LrvLgyVP7z6c=;
        b=UYEun8hc4u586RXOzbSU/rUrwwJaoOHGbKdULOnTCH5Etkbsv5TD/wNPGVE67JM2Fc
         ajCKYfNMxwQjI5JFEaaNaarZGEhlmAFDHTHTTYR8lnKmp3IC5IPizpgT/G+P1BNHZxZ0
         izcAWmu/TlGvv0Eo02Syt5TNsUzEmCYz2QvU4FsB8LjYnttsZnXYWLVFr8ry/icEBUDY
         n4OMXyBQpOCoLPqMLuBeMNGprm0tdodFfKqZBUoJaNuQeQN+VDkrp40avlfOBDKCXUMz
         VRwtTxsokYt77t+dJMXbaGOwcM81GIM9OZi7VkOHDs6dF/jkAZz++Hju8rst3xJSLwcC
         BzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702759494; x=1703364294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VonD+K3QsuKIL2LfV/vmSih0z6Wya+9LrvLgyVP7z6c=;
        b=wjJtbg0c+6UCSzbHMC7u416sR4SOjjRRd2RppITI3hldyxDsxi7JEShYZF+ABNEzx4
         dO/pX03F5Lmh5XWHHbkiSHRseRYrnoYg05Fbe3QkwCw4tj0MnDd7zYg0wAzGINRcKfRl
         0hy6f8RdFfsd1HSNWeFBNym1LqpoZwg0wRpVrFIKw+u6bbvwfp787OMn6nM06mq774R4
         HhfMnKxpnpMDnxepotoALOLfAbmGv42YQu8QWK8KOYpxJOoNof5N0QlCb0IYGbLT5XHk
         JJAXyfb7M04W0SiPzjYqJrEwndBamLhO74FWMRlp4kYPnnSoZZCxgBUoqLLJomsqULCW
         m9Uw==
X-Gm-Message-State: AOJu0Yy84MqZSstFnf5dF+Nwqh1hU/NOAgRrgm5rzutv1PZqBT9PZQhi
	X2NzjEdpCGEKCRc9X6BjxD+2TQ==
X-Google-Smtp-Source: AGHT+IHo2fiwdr/Lcyuf6cdS/jNZo7VSqWEUDzkUjEKzq7m6T9GRxc1ivoklEnuVJBaVOJvGbi0Y7g==
X-Received: by 2002:a17:902:ab88:b0:1d3:9486:c222 with SMTP id f8-20020a170902ab8800b001d39486c222mr2216360plr.24.1702759493758;
        Sat, 16 Dec 2023 12:44:53 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b0028b5739c927sm1380343pjb.34.2023.12.16.12.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 12:44:53 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	horms@kernel.org
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v5 3/3] net: sched: Add initial TC error skb drop reasons
Date: Sat, 16 Dec 2023 17:44:36 -0300
Message-ID: <20231216204436.3712716-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216204436.3712716-1-victor@mojatatu.com>
References: <20231216204436.3712716-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continue expanding Daniel's patch by adding new skb drop reasons that
are idiosyncratic to TC.

More specifically:

- SKB_DROP_REASON_TC_COOKIE_ERROR: An error occurred whilst
  processing a tc ext cookie.

- SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed.

- SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
  iterations

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/dropreason-core.h | 18 +++++++++++++++---
 net/sched/act_api.c           |  3 ++-
 net/sched/cls_api.c           | 22 ++++++++++++++--------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 278e4c7d465c..6d3a20163260 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -85,8 +85,10 @@
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
-	FN(TC_ERROR)			\
+	FN(TC_COOKIE_ERROR)		\
 	FN(PACKET_SOCK_ERROR)		\
+	FN(TC_CHAIN_NOTFOUND)		\
+	FN(TC_RECLASSIFY_LOOP)		\
 	FNe(MAX)
 
 /**
@@ -377,13 +379,23 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
 	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
 	SKB_DROP_REASON_QUEUE_PURGE,
-	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
-	SKB_DROP_REASON_TC_ERROR,
+	/**
+	 * @SKB_DROP_REASON_TC_COOKIE_ERROR: An error occurred whilst
+	 * processing a tc ext cookie.
+	 */
+	SKB_DROP_REASON_TC_COOKIE_ERROR,
 	/**
 	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
 	 * after its filter matches an incoming packet.
 	 */
 	SKB_DROP_REASON_PACKET_SOCK_ERROR,
+	/** @SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed. */
+	SKB_DROP_REASON_TC_CHAIN_NOTFOUND,
+	/**
+	 * @SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
+	 * iterations.
+	 */
+	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index db500aa9f841..a44c097a880d 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1119,7 +1119,8 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
 			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
 				return TC_ACT_SHOT;
 			}
 			tcf_action_goto_chain_exec(a, res);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 199406e4bcdd..8978cf5531d0 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1681,13 +1681,15 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
 				     !tp->ops->get_exts)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_COOKIE_ERROR);
 				return TC_ACT_SHOT;
 			}
 
 			exts = tp->ops->get_exts(tp, n->handle);
 			if (unlikely(!exts || n->exts != exts)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_COOKIE_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1716,7 +1718,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 	}
 
 	if (unlikely(n)) {
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_COOKIE_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1728,7 +1731,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
 		return TC_ACT_SHOT;
 	}
 
@@ -1766,7 +1770,8 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb,
+							    SKB_DROP_REASON_TC_COOKIE_ERROR);
 					return TC_ACT_SHOT;
 				}
 
@@ -1777,7 +1782,9 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
+
 				return TC_ACT_SHOT;
 			}
 
@@ -1799,10 +1806,9 @@ int tcf_classify(struct sk_buff *skb,
 
 			ext = tc_skb_ext_alloc(skb);
 			if (WARN_ON_ONCE(!ext)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_NOMEM);
 				return TC_ACT_SHOT;
 			}
-
 			ext->chain = last_executed_chain;
 			ext->mru = cb->mru;
 			ext->post_ct = cb->post_ct;
-- 
2.25.1


