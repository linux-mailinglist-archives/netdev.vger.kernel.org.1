Return-Path: <netdev+bounces-28762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB257808CF
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7A32822FD
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC03118005;
	Fri, 18 Aug 2023 09:40:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91E4689
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:40:48 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6BB30C2
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:40:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so1592139276.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692351643; x=1692956443;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+n/gEVftHB6AZ6fIxTeModVsP9eriq2hkYc3g1NvFg=;
        b=sKR0KWxPkcaq7fYrCFFXioQ14YrMXu7dnGUb+1tsCG42qoMlNtpDbB2zmTOcek3gBf
         7t337NJp/AYff46Fv0T7p8dlKdq40/ZfYFfHrY9mTG19grXCdeXYxgyXwurTIYb4K8Wn
         BiBjXKg+Q0HvsMdw6Kbj15xUPyfi3GIfUOb03kiylcI5oGNL5geqBqmTJPDSxaFzH5c4
         ANKyd/+CoiZnHikcFcKmc8JiWegAXqBMuI/npliUqB0xuw6Xg8ULJH588qQWIjnJoiDl
         mmELP11U6uE+L4nmN/QxsNr/fsaOio1wSa+nmPl6G7N3wQClNGzQrqZL1eAZ/O6FeBec
         cTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351643; x=1692956443;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+n/gEVftHB6AZ6fIxTeModVsP9eriq2hkYc3g1NvFg=;
        b=UL7GhqjMInId6DSSbu8W4zHwCRHUVIXBQGrDgQd7fYV3I0m5//e3r5n0MGiU1rwWEk
         KvAj1kQQBfqD7gwNVxr6MMzWy6LxWGwjtk21NM/V0TjOZejWmAgWvHsWgPEe93lUvkjC
         AagaOf787ZlfMcheCTFrnB+Gvz/EKv+4D3loKrli0mnHj7KnLNOVEbGB/ialDjKil+83
         n/6j8+J7ZLShUqcdpT1034hEYVsppLPCO2EuyNchCGyR7kfwVh+BV2gcrMyx19SzyUDz
         XaxGwrtsG8vZpMVxnWPjKy63vdmfQSfTnPQLLMwBhg/wH8VakB9WAQTWDcd6OZ2XQ5jZ
         K7vA==
X-Gm-Message-State: AOJu0Yy57NZ6oP2/2Es5FkErRUHLEZHV0NJofcYa7IVZb0f7ixXNmw91
	YMQm+81kl8Aeln88ZfJkN8aE76BNh7OXfw==
X-Google-Smtp-Source: AGHT+IH/gewBgSI6tJAfrkkdhVTqHANXQlcp3mfb+fzRQ+fuy/j9XFSWPvwvfhRBIf3Xh2pCaPnn+xNB59aG5Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c50d:0:b0:d2c:649:f848 with SMTP id
 v13-20020a25c50d000000b00d2c0649f848mr29072ybe.1.1692351643092; Fri, 18 Aug
 2023 02:40:43 -0700 (PDT)
Date: Fri, 18 Aug 2023 09:40:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818094039.3630187-1-edumazet@google.com>
Subject: [PATCH net-next] net: add skb_queue_purge_reason and __skb_queue_purge_reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

skb_queue_purge() and __skb_queue_purge() become wrappers
around the new generic functions.

New SKB_DROP_REASON_QUEUE_PURGE drop reason is added,
but users can start adding more specific reasons.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h        | 23 +++++++++++++++++++----
 include/net/dropreason-core.h |  3 +++
 net/core/skbuff.c             | 11 +++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index aa57e2eca33be01d6d1d55297a8ffcdb5b6a1f55..9aec136bc6901ee4f99b7af7cd126a57babd0cb8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3149,20 +3149,35 @@ static inline int skb_orphan_frags_rx(struct sk_buff *skb, gfp_t gfp_mask)
 }
 
 /**
- *	__skb_queue_purge - empty a list
+ *	__skb_queue_purge_reason - empty a list
  *	@list: list to empty
+ *	@reason: drop reason
  *
  *	Delete all buffers on an &sk_buff list. Each buffer is removed from
  *	the list and one reference dropped. This function does not take the
  *	list lock and the caller must hold the relevant locks to use it.
  */
-static inline void __skb_queue_purge(struct sk_buff_head *list)
+static inline void __skb_queue_purge_reason(struct sk_buff_head *list,
+					    enum skb_drop_reason reason)
 {
 	struct sk_buff *skb;
+
 	while ((skb = __skb_dequeue(list)) != NULL)
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
+}
+
+static inline void __skb_queue_purge(struct sk_buff_head *list)
+{
+	__skb_queue_purge_reason(list, SKB_DROP_REASON_QUEUE_PURGE);
+}
+
+void skb_queue_purge_reason(struct sk_buff_head *list,
+			    enum skb_drop_reason reason);
+
+static inline void skb_queue_purge(struct sk_buff_head *list)
+{
+	skb_queue_purge_reason(list, SKB_DROP_REASON_QUEUE_PURGE);
 }
-void skb_queue_purge(struct sk_buff_head *list);
 
 unsigned int skb_rbtree_purge(struct rb_root *root);
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index f291a3b0f9e512bd933b961caa4368367c3c5c6c..a587e83fc1694100a2357f81e999d7810b0d1ff7 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -79,6 +79,7 @@
 	FN(IPV6_NDISC_BAD_CODE)		\
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
+	FN(QUEUE_PURGE)			\
 	FNe(MAX)
 
 /**
@@ -342,6 +343,8 @@ enum skb_drop_reason {
 	 * for another host.
 	 */
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
+	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
+	SKB_DROP_REASON_QUEUE_PURGE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 33fdf04d4334dd71481bc1ecf7c131aff8f18826..061caf2a3021483bb859ee31c9b19291180e0f7f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3701,20 +3701,23 @@ struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list)
 EXPORT_SYMBOL(skb_dequeue_tail);
 
 /**
- *	skb_queue_purge - empty a list
+ *	skb_queue_purge_reason - empty a list
  *	@list: list to empty
+ *	@reason: drop reason
  *
  *	Delete all buffers on an &sk_buff list. Each buffer is removed from
  *	the list and one reference dropped. This function takes the list
  *	lock and is atomic with respect to other list locking functions.
  */
-void skb_queue_purge(struct sk_buff_head *list)
+void skb_queue_purge_reason(struct sk_buff_head *list,
+			    enum skb_drop_reason reason)
 {
 	struct sk_buff *skb;
+
 	while ((skb = skb_dequeue(list)) != NULL)
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
 }
-EXPORT_SYMBOL(skb_queue_purge);
+EXPORT_SYMBOL(skb_queue_purge_reason);
 
 /**
  *	skb_rbtree_purge - empty a skb rbtree
-- 
2.42.0.rc1.204.g551eb34607-goog


