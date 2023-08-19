Return-Path: <netdev+bounces-29040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972667816FA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71951C20D20
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E981107;
	Sat, 19 Aug 2023 03:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C016634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:17:11 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7F4216
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:17:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c583f885cso21687267b3.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692415028; x=1693019828;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGESir/hMjk6nqkalikZKnE56N/E5TVwD+e9p9Ltx7Q=;
        b=M8cK9wg+DKXGKGJtKL2McPoz4PAAMR8mgHVov9wvV/c03kPzEoZ8g8ByvaPm3VQoiT
         PBP9cSv/2fujfk36e7pYn7fF1NXoCDsB4BF0ugiGJI8024T1CKRRDmshXPpx0S8UGk5J
         tIg1tnzOlzUthVPr+xIHUo9Ahgqgu9LrLvJPOTc7+GyVInVpOXjGTg5iEAlX4Ppuuw/u
         RG06AHUNLdjVBxb7+BDuRi7bQEMN7C+kGukuJf+bh+t5aQtJItg+qX9XuZS5HpraQ766
         NnvCpIP8DJ+bVCZiBYNhEdQ9Qsxr2TTtWqWReU/ZeKE+S7U4ECl2nrZ1GE92+rvu1Z5s
         mrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415028; x=1693019828;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGESir/hMjk6nqkalikZKnE56N/E5TVwD+e9p9Ltx7Q=;
        b=Df8SlejFtmc3b40YYf5nlLH22Y4FzJEYYIr5UWIhoOxrGjYwft/M+L1Zomacp78JwV
         MhOjcEuFuUxsmlrdid5xJ/Xzq30kqaaKXsoOs9tGdzsbn6ANxKRGWxl6U6b/GAfAkvLS
         Oz8UNDOL5nspqicSrVp8QDtri+EC1YDfnNsKIiY0efjM3vRKY+BGvrsGseEJ5MLclhPc
         svCdOyVsJwYsE2hN0EYyRgzRjDOsRQuNE76vByhOXce19rrcXXg18yygSUqnc5rs+k9y
         gU5fHKBGJ5lPRVkX3CN21rmJAbcVBBbN1YWy5IOWKY9wxTq1Jk9D5y1moHG+RNDSHd3n
         qDcw==
X-Gm-Message-State: AOJu0Yw9CugzKFg0tJDZYrGSCcYIhW2iG/7cBgZm8/yw54iXhwyQODXr
	ww0/fHO+GB9AFL0dJcF9R/1nGo4eGZnCxQ==
X-Google-Smtp-Source: AGHT+IG7m+f6+8sfh2M93Gql7Ra5Or9wg5LJPL7HEo5VAWXuPIugg+hHQPPKT30Awr9BL0OpcmWB5yYERBduyw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:709:b0:589:a855:7af with SMTP id
 bs9-20020a05690c070900b00589a85507afmr9133ywb.7.1692415028555; Fri, 18 Aug
 2023 20:17:08 -0700 (PDT)
Date: Sat, 19 Aug 2023 03:17:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819031707.312225-1-edumazet@google.com>
Subject: [PATCH v2 net] ipv4: fix data-races around inet->inet_id
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

UDP sendmsg() is lockless, so ip_select_ident_segs()
can very well be run from multiple cpus [1]

Convert inet->inet_id to an atomic_t, but implement
a dedicated path for TCP, avoiding cost of a locked
instruction (atomic_add_return())

Note that this patch will cause a trivial merge conflict
because we added inet->flags in net-next tree.

v2: added missing change in
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
(David Ahern)

[1]

BUG: KCSAN: data-race in __ip_make_skb / __ip_make_skb

read-write to 0xffff888145af952a of 2 bytes by task 7803 on cpu 1:
ip_select_ident_segs include/net/ip.h:542 [inline]
ip_select_ident include/net/ip.h:556 [inline]
__ip_make_skb+0x844/0xc70 net/ipv4/ip_output.c:1446
ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
___sys_sendmsg net/socket.c:2548 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2634
__do_sys_sendmmsg net/socket.c:2663 [inline]
__se_sys_sendmmsg net/socket.c:2660 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888145af952a of 2 bytes by task 7804 on cpu 0:
ip_select_ident_segs include/net/ip.h:541 [inline]
ip_select_ident include/net/ip.h:556 [inline]
__ip_make_skb+0x817/0xc70 net/ipv4/ip_output.c:1446
ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
___sys_sendmsg net/socket.c:2548 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2634
__do_sys_sendmmsg net/socket.c:2663 [inline]
__se_sys_sendmmsg net/socket.c:2660 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x184d -> 0x184e

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 7804 Comm: syz-executor.1 Not tainted 6.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
==================================================================

Fixes: 23f57406b82d ("ipv4: avoid using shared IP generator for connected sockets")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../chelsio/inline_crypto/chtls/chtls_cm.c        |  2 +-
 include/net/inet_sock.h                           |  2 +-
 include/net/ip.h                                  | 15 +++++++++++++--
 net/dccp/ipv4.c                                   |  4 ++--
 net/ipv4/af_inet.c                                |  2 +-
 net/ipv4/datagram.c                               |  2 +-
 net/ipv4/tcp_ipv4.c                               |  4 ++--
 net/sctp/socket.c                                 |  2 +-
 8 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index c2e7037c7ba1c40bd41e9d6a8d5f252cee761485..7750702900fa60b3405992e6c6c465b43abff116 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1466,7 +1466,7 @@ static void make_established(struct sock *sk, u32 snd_isn, unsigned int opt)
 	tp->write_seq = snd_isn;
 	tp->snd_nxt = snd_isn;
 	tp->snd_una = snd_isn;
-	inet_sk(sk)->inet_id = get_random_u16();
+	atomic_set(&inet_sk(sk)->inet_id, get_random_u16());
 	assign_rxopt(sk, opt);
 
 	if (tp->rcv_wnd > (RCV_BUFSIZ_M << 10))
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 0bb32bfc61832dd787abcb2db3ee85d55c83f2c9..491ceb7ebe5d1c6cb502fbcae46c3369f4cb2681 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -222,8 +222,8 @@ struct inet_sock {
 	__s16			uc_ttl;
 	__u16			cmsg_flags;
 	struct ip_options_rcu __rcu	*inet_opt;
+	atomic_t		inet_id;
 	__be16			inet_sport;
-	__u16			inet_id;
 
 	__u8			tos;
 	__u8			min_ttl;
diff --git a/include/net/ip.h b/include/net/ip.h
index 332521170d9b86ab8cf53e134e199d4312e298cf..19adacd5ece031547e3ad70d524e89d8a6301a55 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -538,8 +538,19 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
 	 * generator as much as we can.
 	 */
 	if (sk && inet_sk(sk)->inet_daddr) {
-		iph->id = htons(inet_sk(sk)->inet_id);
-		inet_sk(sk)->inet_id += segs;
+		int val;
+
+		/* avoid atomic operations for TCP,
+		 * as we hold socket lock at this point.
+		 */
+		if (sk_is_tcp(sk)) {
+			sock_owned_by_me(sk);
+			val = atomic_read(&inet_sk(sk)->inet_id);
+			atomic_set(&inet_sk(sk)->inet_id, val + segs);
+		} else {
+			val = atomic_add_return(segs, &inet_sk(sk)->inet_id);
+		}
+		iph->id = htons(val);
 		return;
 	}
 	if ((iph->frag_off & htons(IP_DF)) && !skb->ignore_df) {
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index fa8079303cb060aadb50ec1ae822876198c4ef4a..a545ad71201c87e5a1744c3d6ff8a25e621bca24 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -130,7 +130,7 @@ int dccp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 						    inet->inet_daddr,
 						    inet->inet_sport,
 						    inet->inet_dport);
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	err = dccp_connect(sk);
 	rt = NULL;
@@ -432,7 +432,7 @@ struct sock *dccp_v4_request_recv_sock(const struct sock *sk,
 	RCU_INIT_POINTER(newinet->inet_opt, rcu_dereference(ireq->ireq_opt));
 	newinet->mc_index  = inet_iif(skb);
 	newinet->mc_ttl	   = ip_hdr(skb)->ttl;
-	newinet->inet_id   = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	if (dst == NULL && (dst = inet_csk_route_child_sock(sk, newsk, req)) == NULL)
 		goto put_and_exit;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 9b2ca2fcc5a1176ffcaab4abee1492c6466ce5ca..02736b83c30320124cf64721fbe60bb29084e109 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -340,7 +340,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	else
 		inet->pmtudisc = IP_PMTUDISC_WANT;
 
-	inet->inet_id = 0;
+	atomic_set(&inet->inet_id, 0);
 
 	sock_init_data(sock, sk);
 
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 4d1af0cd7d99e3f76a4202a91e2a4f5869e9aa2f..cb5dbee9e018fbba1bc1e5705e8bec6c4203af56 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -73,7 +73,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 	reuseport_has_conns_set(sk);
 	sk->sk_state = TCP_ESTABLISHED;
 	sk_set_txhash(sk);
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	sk_dst_set(sk, &rt->dst);
 	err = 0;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a59cc4b8386113577d966a3efce53a13f51e8b06..2dbdc26da86e4389e0debdc46fe4d3acb3df8873 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -312,7 +312,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 					     inet->inet_daddr));
 	}
 
-	inet->inet_id = get_random_u16();
+	atomic_set(&inet->inet_id, get_random_u16());
 
 	if (tcp_fastopen_defer_connect(sk, &err))
 		return err;
@@ -1596,7 +1596,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	inet_csk(newsk)->icsk_ext_hdr_len = 0;
 	if (inet_opt)
 		inet_csk(newsk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
-	newinet->inet_id = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	/* Set ToS of the new socket based upon the value of incoming SYN.
 	 * ECT bits are set later in tcp_init_transfer().
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 6da738f60f4b534d12245455c39bf4db18d8cb5a..76f1bce49a8e7b3eabfc53c66eaf6f68d41cfb77 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9479,7 +9479,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newinet->inet_rcv_saddr = inet->inet_rcv_saddr;
 	newinet->inet_dport = htons(asoc->peer.port);
 	newinet->pmtudisc = inet->pmtudisc;
-	newinet->inet_id = get_random_u16();
+	atomic_set(&newinet->inet_id, get_random_u16());
 
 	newinet->uc_ttl = inet->uc_ttl;
 	newinet->mc_loop = 1;
-- 
2.42.0.rc1.204.g551eb34607-goog


