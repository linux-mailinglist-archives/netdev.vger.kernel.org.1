Return-Path: <netdev+bounces-35609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F827AA00D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B18D1C20C9C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783D18C24;
	Thu, 21 Sep 2023 20:31:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0017988
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:31:14 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C465B2
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59beea5ce93so27804337b3.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328114; x=1695932914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1doV0y3T2t0Qynjg1/NAElnJnJ/4setzjesc12Z4yyw=;
        b=xCvjzUIisAgSKobIyrOuJ4bptM2JXOCtKhsQHbOJmFHDmc5z3KC8bsfgItTYB8msSN
         7agwlgU1SEfjhqWLhRv4cpfidAdx/hxlBebGu2P6r/OXbfPpYzwILvt1PFot0NSZW/7p
         yq0Wup3tTA2Me3paU8tRgywSEwNkErkjuGE7i2R1InC3SLPhcbf3O6juoNHBkWB56Xtr
         RxlTuphGsr1ahI+AV+k6h02Rr6IY5Q/huhXTBrxgEcl5Ia0VqajO+Y5p2Tr45lA4GLYH
         VR9c0QwZRFk8mYX9fN+ogn2e7xNex6dUrGXl1nglkS6+GIlfULAptz7KDMPSgRAooOBI
         XDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328114; x=1695932914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1doV0y3T2t0Qynjg1/NAElnJnJ/4setzjesc12Z4yyw=;
        b=JuYZj0rZ483iMszeARq9MPRyNsWuXcXefPLqjQR1zd6FoRRH6tq3apyhBnrjyKGvGm
         tHmFOmxrvxYmOHNLYK7qMfbMQIHiSxUkQ4L7mFWenA1CRCVUJavdDzwmE9uOZ9upZfLb
         J51rPApxuOCmHlHit+tFdlYUe+OOf/S2wFpq2MTrkBtpVoBh3D/Y1QMd/jAUR4QZFgsu
         2HT1eKDMCXbvfg8I3GI/l//qUMmjFQpPL7Dz2JJ7f3WxJUrzzOcUcqb5IfhccNNVGGHR
         xfJqY7SVvexPX7Oc3ghzdtj/axzh94suX11y4hXg5r4vQQ/BCyVBEn5Abglz3KtHpXDf
         yXfQ==
X-Gm-Message-State: AOJu0YwgEjQwGz4flTSmN9iIqqspz/AJpnmDa31RG1j/mDpXDhpITYdH
	S+bpay8EszvYruKbMNNdHj7/uQ0eNDhVcA==
X-Google-Smtp-Source: AGHT+IFR8kfQR00T4D7XymFaHAnl7SX/N4BOC1RZOGd4ClG2lnMN3NETFSymqDH7Jw8mSjb57Ac/qHPPRi70/w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:e703:0:b0:595:8166:7be with SMTP id
 x3-20020a81e703000000b00595816607bemr10744ywl.0.1695328114181; Thu, 21 Sep
 2023 13:28:34 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:18 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] net: annotate data-races around sk->sk_dst_pending_confirm
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This field can be read or written without socket lock being held.

Add annotations to avoid load-store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h    | 6 +++---
 net/core/sock.c       | 2 +-
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f33e733167df8c2da9240f4af5ed7d715f347394..e70afdb4d29b680aa1081f2b57bab60700b56f5f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2182,7 +2182,7 @@ static inline void __dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -2199,7 +2199,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -2212,7 +2212,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
 	dst_release(old_dst);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index f0930f858714b6efdb5b4168d7eb5135f65aded4..290165954379292782a484d378a865cc52ca6753 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -600,7 +600,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
 			       dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 696dfd64c8c5ffaef43f0f33c9402df2f673dcd3..a13779b24a6c18419836651f82352b324f1dec57 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1325,7 +1325,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb->destructor = skb_is_tcp_pure_ack(skb) ? __sock_wfree : tcp_wfree;
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
-- 
2.42.0.515.g380fc7ccd1-goog


