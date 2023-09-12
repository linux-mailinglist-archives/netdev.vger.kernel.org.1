Return-Path: <netdev+bounces-33087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD42C79CB6E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA351C20BC2
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F51642A;
	Tue, 12 Sep 2023 09:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C32716404
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:52 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EC5A9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d801e758765so3735039276.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510270; x=1695115070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gsfuG+Fk7l389KpgUPI4XAj+tfnIQpR4Y0z+loi1P4=;
        b=DW0mUIsh/j4DGqxGNKzfLBh9eHeHf4Ben1q0kpFvYa6QDSJjhnrrv3w63tDyetG7Ii
         0zl0+auuX4CW4d79RfI03yQQSTKUp/Uwmikv1Lcf+1+EwmxkQxP67JXUw+sgmVCQk69b
         xRHFlVlYkNYKGKfpz3YsoPp70p4udu7NRIVb5AqgMHAUHI9lUB2ymaE6x3u3zw+C2YxS
         uHPU2mSSjxNxoAGf5g5JkSVbxc9YohvVMnNzaL5Gt5aYXzveGRb7+9VLi04aGBlqYNnR
         2xkP9a5A92flSRxndMMOXEx3xz/SDysr1UoNrdtTamZVse+MEppzoBqtn9UKtz2+Ew1p
         vVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510270; x=1695115070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gsfuG+Fk7l389KpgUPI4XAj+tfnIQpR4Y0z+loi1P4=;
        b=oUyE9NQI+5NNVnjx4QD/wts0/nRbzqlt7aRIOQiwIjbc9dUc5W3gp/QTGoGAX1JuXj
         mXl1TmBatfEYCAAhA4pddqMHy6JHZdGZwamP+fQczMymi7mdlzOndHc+JcANsNYDCgAn
         fh/lkp0fpfiKpDckaSnupKR26mquJM+Zn+7cx1WQnBJJhKpOqoQRt7DNkYn5tk6EYQ7o
         QyDirTC9sK/raW5S8xeMXGjR+zOdMreM4rnj9U0mOFa9De74pDkFobT5bFYYTxv316/i
         5jo0kSuz5xR85FtVtpBpIIN434unEKLFN60/5JWmSGjFaSshroDQPBdu8x3vqEhInjEJ
         lLyA==
X-Gm-Message-State: AOJu0Yyql4ewVu70GAEA/J0uMmkJAb8p+6j/01ew3I6HE3kXBAjGDIc5
	VOGeN726cZAKDn1PR+N22SvyWsC1yu3V6Q==
X-Google-Smtp-Source: AGHT+IFo/P25y0b/5nRj49NZ/GUsgFlEj0T7R8sBk/N2jYJEzuqL9VIbx2QYTd+txshVpjCETz88pGjYbflRFg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2d08:0:b0:d80:12c:d49b with SMTP id
 t8-20020a252d08000000b00d80012cd49bmr294426ybt.8.1694510270714; Tue, 12 Sep
 2023 02:17:50 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:24 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-5-edumazet@google.com>
Subject: [PATCH net-next 04/10] udp: move udp->gro_enabled to udp->udp_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported that udp->gro_enabled can be read locklessly.
Use one atomic bit from udp->udp_flags.

Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h    | 2 +-
 net/ipv4/udp.c         | 6 +++---
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp.c         | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 8d4c3835b1b219da9c830f53f09aa0511840a1d4..b344bd2e41fc9f4abf953c29c644b11438b0057d 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -36,6 +36,7 @@ enum {
 	UDP_FLAGS_CORK,		/* Cork is required */
 	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
 	UDP_FLAGS_NO_CHECK6_RX, /* Allow zero UDP6 checksums on RX? */
+	UDP_FLAGS_GRO_ENABLED,	/* Request GRO aggregation */
 };
 
 struct udp_sock {
@@ -54,7 +55,6 @@ struct udp_sock {
 					   * different encapsulation layer set
 					   * this
 					   */
-			 gro_enabled:1,	/* Request GRO aggregation */
 			 accept_udp_l4:1,
 			 accept_udp_fraglist:1;
 /* indicator bits used by pcflag: */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cb32826a1db20006ce9c21e66a9347f41b228da2..1debc10a0f029e47ffe90aaff60727b6bb7309cc 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1868,7 +1868,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 						      (struct sockaddr *)sin);
 	}
 
-	if (udp_sk(sk)->gro_enabled)
+	if (udp_test_bit(GRO_ENABLED, sk))
 		udp_cmsg_recv(msg, sk, skb);
 
 	if (inet_cmsg_flags(inet))
@@ -2713,7 +2713,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		/* when enabling GRO, accept the related GSO packet type */
 		if (valbool)
 			udp_tunnel_encap_enable(sk->sk_socket);
-		up->gro_enabled = valbool;
+		udp_assign_bit(GRO_ENABLED, sk, valbool);
 		up->accept_udp_l4 = valbool;
 		release_sock(sk);
 		break;
@@ -2803,7 +2803,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_GRO:
-		val = up->gro_enabled;
+		val = udp_test_bit(GRO_ENABLED, sk);
 		break;
 
 	/* The following two cannot be changed on UDP sockets, the return is
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 0f46b3c2e4ac5427a5d39586086048afe22f34f1..6c95d28d0c4a7e56d587a986113b3711f8de964c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -557,10 +557,10 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	NAPI_GRO_CB(skb)->is_flist = 0;
 	if (!sk || !udp_sk(sk)->gro_receive) {
 		if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
-			NAPI_GRO_CB(skb)->is_flist = sk ? !udp_sk(sk)->gro_enabled : 1;
+			NAPI_GRO_CB(skb)->is_flist = sk ? !udp_test_bit(GRO_ENABLED, sk) : 1;
 
 		if ((!sk && (skb->dev->features & NETIF_F_GRO_UDP_FWD)) ||
-		    (sk && udp_sk(sk)->gro_enabled) || NAPI_GRO_CB(skb)->is_flist)
+		    (sk && udp_test_bit(GRO_ENABLED, sk)) || NAPI_GRO_CB(skb)->is_flist)
 			return call_gro_receive(udp_gro_receive_segment, head, skb);
 
 		/* no GRO, be sure flush the current packet */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6e1ea3029260ec6e4992cf7e01c0202fabd94017..2c3281879b6dfdf04bf219cf9b13c1c59f732a0d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -413,7 +413,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 						      (struct sockaddr *)sin6);
 	}
 
-	if (udp_sk(sk)->gro_enabled)
+	if (udp_test_bit(GRO_ENABLED, sk))
 		udp_cmsg_recv(msg, sk, skb);
 
 	if (np->rxopt.all)
-- 
2.42.0.283.g2d96d420d3-goog


