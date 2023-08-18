Return-Path: <netdev+bounces-28910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D41781234
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65791C214A1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AFD19BCB;
	Fri, 18 Aug 2023 17:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CD19BA1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:41:48 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207372102
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:41:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d746354e0e2so559648276.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692380506; x=1692985306;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJgJ3g3r6GnB9Unce3kjnSwnMLZPOuTU9FgrniFT3bU=;
        b=ZqTjy3yVRCPbdka+ZkFvI+qtdWYeE1CK3ebWdLvaNr09pauqfvV5DdxLBhPJdHMlDt
         2jRWSTHE6p4Cn8xjxf5bsEaWpuavXN+uI3Cb0s/cDEvvw+l42THIcrnine2ffJuyHTdW
         +8nRWQkc6D/eZuRMUjKk1ClegghwUeIda0f7YbDnCXMdjpTEq2703pinsgfwCuogz82A
         5719pzeAuAV8ET6Ce1Qxg+4O/vD/mdiPnIrnfKTSUmlpvDbJ/waPWkSCkiDlJF5bxM3S
         XqmVrhIlso/OZAEuEZ6QtfN0HFfv6aWkC/EBrso6cHfd/rtrOq4IrLelz2iHiOTYQqZl
         zqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380506; x=1692985306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJgJ3g3r6GnB9Unce3kjnSwnMLZPOuTU9FgrniFT3bU=;
        b=BKw8JuPNaDLIq3k460Lbx4edNaSgTAMZgCEOdSV/F/rl4ENjtJCabDAz6EkBKf3Qe/
         0RNSSoP8EIBi3Vgm8ZctonaWqOKpgHik8+l2uGlKqD7M7woifNpxElxeRY/oTnv4IjDM
         9Ku6F9Cvcbj3jNzFqgrn6azaFNrklLD5jIYvemeEdfz/+xnOrkbhZv6KYUVNRbhjldZV
         I3EaNFscHlKOl7tANKw9+smk/7SjHNRAPBi4/bPPgVvDb4VSpR+d+/vsJGflxPkXyoQO
         3U7g59pm5PR2ZfA11MkKoZUmmmeA8OILnYMjbnZKMrOg5tfiepn5/4lwSswZq5YFhAZC
         MRzg==
X-Gm-Message-State: AOJu0YyVYTv9NmtPiBR/OIg76ofzVZEHwIy8dGj0yMwkUz5x3g3caqL3
	A2HfRjvY3Ur3IkRPUClTNgNq2TqjjDBQ2w==
X-Google-Smtp-Source: AGHT+IFPMz8HsjCcY25o1kFx+StHK88eK6esFVTBrg1+QK8FbfGNLeXdsvPWy6fqSEbYkSkwCjD0np665dPwCQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d851:0:b0:d1c:57aa:d267 with SMTP id
 p78-20020a25d851000000b00d1c57aad267mr58050ybg.5.1692380506342; Fri, 18 Aug
 2023 10:41:46 -0700 (PDT)
Date: Fri, 18 Aug 2023 17:41:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818174145.199194-1-edumazet@google.com>
Subject: [PATCH net-next] net: selectively purge error queue in IP_RECVERR / IPV6_RECVERR
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Setting IP_RECVERR and IPV6_RECVERR options to zero currently
purges the socket error queue, which was probably not expected
for zerocopy and tx_timestamp users.

I discovered this issue while preparing commit 6b5f43ea0815
("inet: move inet->recverr to inet->inet_flags"), I presume this
change does not need to be backported to stable kernels.

Add skb_errqueue_purge() helper to purge error messages only.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/linux/skbuff.h   |  1 +
 net/core/skbuff.c        | 21 +++++++++++++++++++++
 net/ipv4/ip_sockglue.c   |  2 +-
 net/ipv6/ipv6_sockglue.c |  2 +-
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index aa57e2eca33be01d6d1d55297a8ffcdb5b6a1f55..9a8200c7a0c3124d78e95f9524b854043a6fd368 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3165,6 +3165,7 @@ static inline void __skb_queue_purge(struct sk_buff_head *list)
 void skb_queue_purge(struct sk_buff_head *list);
 
 unsigned int skb_rbtree_purge(struct rb_root *root);
+void skb_errqueue_purge(struct sk_buff_head *list);
 
 void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 33fdf04d4334dd71481bc1ecf7c131aff8f18826..e2ece6b822f442079c1ea20cdd5f6d0dc27ba8a5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3742,6 +3742,27 @@ unsigned int skb_rbtree_purge(struct rb_root *root)
 	return sum;
 }
 
+void skb_errqueue_purge(struct sk_buff_head *list)
+{
+	struct sk_buff *skb, *next;
+	struct sk_buff_head kill;
+	unsigned long flags;
+
+	__skb_queue_head_init(&kill);
+
+	spin_lock_irqsave(&list->lock, flags);
+	skb_queue_walk_safe(list, skb, next) {
+		if (SKB_EXT_ERR(skb)->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY ||
+		    SKB_EXT_ERR(skb)->ee.ee_origin == SO_EE_ORIGIN_TIMESTAMPING)
+			continue;
+		__skb_unlink(skb, list);
+		__skb_queue_tail(&kill, skb);
+	}
+	spin_unlock_irqrestore(&list->lock, flags);
+	__skb_queue_purge(&kill);
+}
+EXPORT_SYMBOL(skb_errqueue_purge);
+
 /**
  *	skb_queue_head - queue a buffer at the list head
  *	@list: list to use
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 61b2e7bc7031501ff5a3ebeffc3f90be180fa09e..54ad0f0d5c2dd2273f290de5693060a2cb185534 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -976,7 +976,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_RECVERR:
 		inet_assign_bit(RECVERR, sk, val);
 		if (!val)
-			skb_queue_purge(&sk->sk_error_queue);
+			skb_errqueue_purge(&sk->sk_error_queue);
 		return 0;
 	case IP_RECVERR_RFC4884:
 		if (val < 0 || val > 1)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index d19577a94bcc6120e85dafb2768521e6567c0511..0e2a0847b387f0f6f50211b89f92ac1e00a0b07a 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -923,7 +923,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		np->recverr = valbool;
 		if (!val)
-			skb_queue_purge(&sk->sk_error_queue);
+			skb_errqueue_purge(&sk->sk_error_queue);
 		retv = 0;
 		break;
 	case IPV6_FLOWINFO_SEND:
-- 
2.42.0.rc1.204.g551eb34607-goog


