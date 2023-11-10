Return-Path: <netdev+bounces-46999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7B7E791F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 07:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF7A281766
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4A53AB;
	Fri, 10 Nov 2023 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hg/4hJj5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580C525C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:18:38 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9651A5FFD
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 22:18:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc5b7057d5so15329875ad.2
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699597115; x=1700201915; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UY2V4KB781XJBY0gcAuxuyVl/cjuGIjQ/iARGJ/tjI=;
        b=Hg/4hJj5QNNuzuRv3Ov7/OGPiaHUAJ9hCWpSmqLWbSvtcwgdNc+5z8LdOkkrujpVQw
         TXnqKgWFeGV9Dc3ufJhR9SqyzGNEkUE+8chIaEfrpf3RSWoQhnrrzpvGAWljQnAKrRur
         1vFl24INUVnjuQ3UF10dsLGuXgajFyXJGPPfW9Au0XJGWsm4dWHR9l1ad4XbpkqRk+yq
         9Pevp3sAzEeoQPsM/Jok3ILBlS4pEckp6rTcUs3AzQMCWy8CyCTgLKCWL45qpJbq1ok4
         /582VCDHPLu0Rtj29RMmUqoi3XQ6NQM3e0HrcHAUr8tArExMr/ZU2fc0BUuMb16hZBkt
         pExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597115; x=1700201915;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UY2V4KB781XJBY0gcAuxuyVl/cjuGIjQ/iARGJ/tjI=;
        b=FZO6oHWDJLUdNiyl0uhZ39R7LPtPXqKACjNG+FJ2qW5+bEQ46mZBNSxYVy4LwyWI7O
         uFJ6anGvDv7Qn21CtnYbfCQWcYF9X+W+SALNIR11c8msASMwRQ8wP2QDcPB5Rb02LcHA
         a2UarXfk6DQLYrVr+3PqVtYqRr807KNAegUmtnw8ufRZ3BUop3GDtf8Um3qMmuZ06D/+
         nPbYXNvBUOfBGwCncXiZMlmEezQkESMY8t5+1694NQirduJqQQwXKSzqU5NmzMAuIHgi
         GdqcYP+q1Um6rw03AYjWsKek6z9ybdMu+lUYInqyj9yPoFt/curmEdibkKHcig53O+N+
         EQmQ==
X-Gm-Message-State: AOJu0YzKAPJpQoi436QcVRv41BOhHxIl9e+jT7t4BUsBRSdsv/nr3f0R
	3rQK8OpWAj/bk8sPDYtllZrwparw7h6/1ebsr9asbg==
X-Google-Smtp-Source: AGHT+IGWU16myJ7R/xYuGXrXNuN5gAZCZelV+4O+aHR2KdVzrrm6cHrsV5Oc9A6wX98LyUQch0USsw==
X-Received: by 2002:ad4:4ea1:0:b0:66d:6af7:4571 with SMTP id ed1-20020ad44ea1000000b0066d6af74571mr8513666qvb.17.1699595366906;
        Thu, 09 Nov 2023 21:49:26 -0800 (PST)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id w9-20020ae9e509000000b00765ab6d3e81sm468753qkf.122.2023.11.09.21.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:49:26 -0800 (PST)
Date: Thu, 9 Nov 2023 21:49:24 -0800
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Weongyo Jeong <weongyo.linux@gmail.com>,
	Ivan Babrou <ivan@cloudflare.com>, David Ahern <dsahern@kernel.org>,
	Jesper Brouer <jesper@cloudflare.com>, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [PATCH net-next] packet: add a generic drop reason for receive
Message-ID: <ZU3EZKQ3dyLE6T8z@debian.debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
from consume_skb to kfree_skb to improve error handling. However, this
could bring a lot of noises when we monitor real packet drops in
kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
can be freed, not actual packets.

Adding a generic drop reason to allow distinguish these "clone drops".

[1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/net/dropreason-core.h |  6 ++++++
 net/packet/af_packet.c        | 16 +++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 845dce805de7..6ff543fe8a8b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -81,6 +81,7 @@
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
 	FN(TC_ERROR)			\
+	FN(PACKET_SOCK_ERROR)		\
 	FNe(MAX)
 
 /**
@@ -348,6 +349,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_QUEUE_PURGE,
 	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
 	SKB_DROP_REASON_TC_ERROR,
+	/**
+	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
+	 * after its filter matches an incoming packet.
+	 */
+	SKB_DROP_REASON_PACKET_SOCK_ERROR,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..94b8a9d8e038 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	int skb_len = skb->len;
 	unsigned int snaplen, res;
 	bool is_drop_n_account = false;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (skb->pkt_type == PACKET_LOOPBACK)
 		goto drop;
@@ -2161,6 +2162,10 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
 		goto drop_n_restore;
+
+	/* skb will only be "consumed" not "dropped" before this */
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
+
 	if (snaplen > res)
 		snaplen = res;
 
@@ -2230,7 +2235,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!is_drop_n_account)
 		consume_skb(skb);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, drop_reason);
 	return 0;
 }
 
@@ -2253,6 +2258,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	bool is_drop_n_account = false;
 	unsigned int slot_id = 0;
 	int vnet_hdr_sz = 0;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2355,6 +2361,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			vnet_hdr_sz = 0;
 		}
 	}
+
+	/* skb will only be "consumed" not "dropped" before this */
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
+
 	spin_lock(&sk->sk_receive_queue.lock);
 	h.raw = packet_current_rx_frame(po, skb,
 					TP_STATUS_KERNEL, (macoff+snaplen));
@@ -2501,7 +2511,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!is_drop_n_account)
 		consume_skb(skb);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2510,7 +2520,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	is_drop_n_account = true;
 
 	sk->sk_data_ready(sk);
-	kfree_skb(copy_skb);
+	kfree_skb_reason(copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2


