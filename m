Return-Path: <netdev+bounces-33091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6725D79CB81
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0221C2097C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76FA1640C;
	Tue, 12 Sep 2023 09:17:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7E171BA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:58 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32EAA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e79ec07b4so5302473276.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510277; x=1695115077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhEIi8SxOv3oRqpp9vS1Cj0NmJH10TsvyewsmLKOPqY=;
        b=qn/h2dtgQJUJ1EyyJ0p3Ocy8AxTH2qHG3Yi4tDWrSIBH+87MjAQlfZT+/kITtxOiU9
         4rS4OFwpdtM/Qx2dC5Fb9mzCshcYMv6DmM8oa0twZNSErlivrJsBhqv1z9NEy8ofWDFp
         AUQ1EwMswctHhsTKq//qHuso/1lNrZXtGvYg8vflVNunORyK1U7BBjNxg0R8aW3yI+DF
         Y4SuGiWwuzQlHcWM9Qi+xnfmGKRNG1S2w52aziiG/c2PPldpeAQrPPfESE0QKCDsnIA6
         ecX6MNWXsMwLSeEcRhZ50KlhJfcRJwmwZb2NI2ESS60mVONsSrZ+nkCZid/j0/2wXW9z
         +crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510277; x=1695115077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhEIi8SxOv3oRqpp9vS1Cj0NmJH10TsvyewsmLKOPqY=;
        b=ivxBP+pjNedqzcyea9rqpcPu2MT7d1M0Na8C5Be7kyLlaRCoETq+ZHpAIdKGpWrJM+
         jamxR1qnBNzA70FyYAqHRtaPuVyxGnb0M6eKIsukeYzedyUgklc1CJVxm/WLBKe4uum7
         nfrHn45Rax8JrCrckcnoH0/SOsYWqwmI6RGZDWg5xky4VU5z0ioj9ZRiX/dnDbxcRgdm
         azE5qpJsYpUR3Bv6xq2AI1woeVF8f2QSB0aCAWojnpVuMmedd6lyA84OnCh/blnD0Kzu
         GefbhOyDqgh2hZseQIlt57OZhpW6q7w9FJcFe2iSpYLg7U/8wCCt5zqp086CC06VjQnS
         Ap1g==
X-Gm-Message-State: AOJu0YxWGkxYTr2cWIH3aSedw//CKhhr489hiOU94KiToFh/5g06YK8M
	PU3mvdB5Ju/gpMFy0L6hmND1Tsgiw9Bckg==
X-Google-Smtp-Source: AGHT+IEkk6jdlfzsTeM2PuXn9j8Q0+Y9K0k1eiaVMCdJQWbrc/s0Rx85lO5hNiM3m1s6uFRVKO/A0YoLmQuIlg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:adc3:0:b0:d01:60ec:d0e with SMTP id
 d3-20020a25adc3000000b00d0160ec0d0emr278567ybe.9.1694510277361; Tue, 12 Sep
 2023 02:17:57 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:28 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-9-edumazet@google.com>
Subject: [PATCH net-next 08/10] udp: annotate data-races around udp->encap_type
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot/KCSAN complained about UDP_ENCAP_L2TPINUDP setsockopt() racing.

Add READ_ONCE()/WRITE_ONCE() to document races on this lockless field.

syzbot report was:
BUG: KCSAN: data-race in udp_lib_setsockopt / udp_lib_setsockopt

read-write to 0xffff8881083603fa of 1 bytes by task 16557 on cpu 0:
udp_lib_setsockopt+0x682/0x6c0
udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2779
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
__sys_setsockopt+0x1c9/0x230 net/socket.c:2263
__do_sys_setsockopt net/socket.c:2274 [inline]
__se_sys_setsockopt net/socket.c:2271 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff8881083603fa of 1 bytes by task 16554 on cpu 1:
udp_lib_setsockopt+0x682/0x6c0
udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2779
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
__sys_setsockopt+0x1c9/0x230 net/socket.c:2263
__do_sys_setsockopt net/socket.c:2274 [inline]
__se_sys_setsockopt net/socket.c:2271 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x01 -> 0x05

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 16554 Comm: syz-executor.5 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/gtp.c      | 4 ++--
 net/ipv4/udp.c         | 9 +++++----
 net/ipv4/xfrm4_input.c | 4 ++--
 net/ipv6/udp.c         | 5 +++--
 net/ipv6/xfrm6_input.c | 4 ++--
 net/l2tp/l2tp_core.c   | 6 +++---
 6 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 144ec626230d6b0c4b60e9404d985aa569839309..b3aa0c3d58260c6b4b3cad09ac2678489f11e764 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -630,7 +630,7 @@ static void __gtp_encap_destroy(struct sock *sk)
 			gtp->sk0 = NULL;
 		else
 			gtp->sk1u = NULL;
-		udp_sk(sk)->encap_type = 0;
+		WRITE_ONCE(udp_sk(sk)->encap_type, 0);
 		rcu_assign_sk_user_data(sk, NULL);
 		release_sock(sk);
 		sock_put(sk);
@@ -682,7 +682,7 @@ static int gtp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	netdev_dbg(gtp->dev, "encap_recv sk=%p\n", sk);
 
-	switch (udp_sk(sk)->encap_type) {
+	switch (READ_ONCE(udp_sk(sk)->encap_type)) {
 	case UDP_ENCAP_GTP0:
 		netdev_dbg(gtp->dev, "received GTP0 packet\n");
 		ret = gtp0_udp_encap_recv(gtp, skb);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 637a4faf9aff6389274bfb5ace1fc81dcb2db13f..2eeab4af17a13de5a25a2da64259b8dc2fe3d047 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -714,7 +714,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 			       iph->saddr, uh->source, skb->dev->ifindex,
 			       inet_sdif(skb), udptable, NULL);
 
-	if (!sk || udp_sk(sk)->encap_type) {
+	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udp_encap_needed_key)) {
 			sk = __udp4_lib_err_encap(net, iph, uh, udptable, sk, skb,
@@ -2081,7 +2081,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	}
 	nf_reset_ct(skb);
 
-	if (static_branch_unlikely(&udp_encap_needed_key) && up->encap_type) {
+	if (static_branch_unlikely(&udp_encap_needed_key) &&
+	    READ_ONCE(up->encap_type)) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
 
 		/*
@@ -2684,7 +2685,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #endif
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
-			up->encap_type = val;
+			WRITE_ONCE(up->encap_type, val);
 			udp_tunnel_encap_enable(sk);
 			break;
 		default:
@@ -2785,7 +2786,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_ENCAP:
-		val = up->encap_type;
+		val = READ_ONCE(up->encap_type);
 		break;
 
 	case UDP_NO_CHECK6_TX:
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index eac206a290d05930c97f572e55ec0c26f3fefad0..183f6dc3724293f60c05aac630347405344c5010 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -85,11 +85,11 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	struct udphdr *uh;
 	struct iphdr *iph;
 	int iphlen, len;
-
 	__u8 *udpdata;
 	__be32 *udpdata32;
-	__u16 encap_type = up->encap_type;
+	u16 encap_type;
 
+	encap_type = READ_ONCE(up->encap_type);
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 90688877e90049e45a164322119b2d411dd3e65e..0e79d189613bef41e3ba39c463b19761d2fa3d34 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -571,7 +571,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
 			       inet6_iif(skb), inet6_sdif(skb), udptable, NULL);
 
-	if (!sk || udp_sk(sk)->encap_type) {
+	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udpv6_encap_needed_key)) {
 			sk = __udp6_lib_err_encap(net, hdr, offset, uh,
@@ -688,7 +688,8 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	}
 	nf_reset_ct(skb);
 
-	if (static_branch_unlikely(&udpv6_encap_needed_key) && up->encap_type) {
+	if (static_branch_unlikely(&udpv6_encap_needed_key) &&
+	    READ_ONCE(up->encap_type)) {
 		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
 
 		/*
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 4907ab241d6bedf9ecfaa02017178e13fef4b980..4156387248e40e15b0dd10ccfa89cee5dd7e7534 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -81,14 +81,14 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	struct ipv6hdr *ip6h;
 	int len;
 	int ip6hlen = sizeof(struct ipv6hdr);
-
 	__u8 *udpdata;
 	__be32 *udpdata32;
-	__u16 encap_type = up->encap_type;
+	u16 encap_type;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return xfrm4_udp_encap_rcv(sk, skb);
 
+	encap_type = READ_ONCE(up->encap_type);
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 03608d3ded4b83d1e59e064e482f54cffcdf5240..8d21ff25f1602f5389bed092cee92e9c4eebed3d 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1139,9 +1139,9 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 	switch (tunnel->encap) {
 	case L2TP_ENCAPTYPE_UDP:
 		/* No longer an encapsulation socket. See net/ipv4/udp.c */
-		(udp_sk(sk))->encap_type = 0;
-		(udp_sk(sk))->encap_rcv = NULL;
-		(udp_sk(sk))->encap_destroy = NULL;
+		WRITE_ONCE(udp_sk(sk)->encap_type, 0);
+		udp_sk(sk)->encap_rcv = NULL;
+		udp_sk(sk)->encap_destroy = NULL;
 		break;
 	case L2TP_ENCAPTYPE_IP:
 		break;
-- 
2.42.0.283.g2d96d420d3-goog


