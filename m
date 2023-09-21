Return-Path: <netdev+bounces-35511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FB57A9BA6
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B936AB2115D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347141E3B;
	Thu, 21 Sep 2023 18:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B141E27
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:10:31 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73445573EB
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:51:44 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-690f7d73c68so1114718b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318704; x=1695923504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ehDEDGhw48PrEN2Ouyog/QCY7tpvOcsudDyi1Cod9s=;
        b=F2xhwRi2cigHfTOxd62oBU7e/mE315xuj3vnkARXpjMD/6X/ggujjEkFpDyQmF6Eci
         sNY0L8KJDBvvu8IVxXhMiNYj2x++qYt0Bb4vBo1m1UufL+FF7y694nALK1yoiouIHEkz
         YMhwODrazq6cZQIbUwpBmwmcQP2NzzDTluuufFzLYXXyhNFW0dXW/V6KkFW61/6VYN4h
         JKZ1Hls8Ik9o05BYEl/DC0m9T1tLyVrZOr1DHCbyRQnkCPPbM5dhBDUgPtnART4EStAd
         PkGC2C4rFG8vlfdHE9Iuc2QVr50Wt1FVPqI3RScKZ3uhBQvAzxbNklnUwJ0m7FR0u2sk
         Jyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318704; x=1695923504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ehDEDGhw48PrEN2Ouyog/QCY7tpvOcsudDyi1Cod9s=;
        b=V5OA6DbPFGhYqSmGDRFUHIx3dzAQzUDRgxlpgOCfQIpi7t9I/zvfNDE22BTC+ZGidm
         wYSFLYXxjvjVUc81TfTNrZ7Tq+lNaRk2gZwAic4uf33FeH+C4AgBUnz/50r7kUtoMW/w
         w8s0yE6n3+QfJNtwDrttn2mvXNg9IESiFfKZjDlcNogL5+Yv3JrTt96Iq3LGiBODwR+v
         oKPCeAnyi4AmEbyItKtBg7vcW+mbPZhuolwnukb45YtnHtAyidnnhrXnUlDsRQUqBt7V
         DxlglEYuvwqa3RRTPpH2LJpkkkVkeJ2mPRhhScTHxt1iZ7e3zHzE+CtlMvqPitnIMyoT
         Cm5g==
X-Gm-Message-State: AOJu0YwGxILCEzKSg1BR84e0vbcsdkODdI1HpfLq6jkXdB49prQQVDTE
	nr7YNDnRApGz+IaA5EGo8FHdcYga14N8nw==
X-Google-Smtp-Source: AGHT+IHdaoM6gtBZ+Z1mavJ0pxGGGF4jc890UfethZyLPNSw9g3uR6biVHUieE5lUdKEtbrlWG/XvYnj4gwIcQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:e08b:0:b0:d80:bea:ca87 with SMTP id
 x133-20020a25e08b000000b00d800beaca87mr80421ybg.1.1695303031272; Thu, 21 Sep
 2023 06:30:31 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:16 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] inet: implement lockless IP_TOS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some reads of inet->tos are racy.

Add needed READ_ONCE() annotations and convert IP_TOS option lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h                              |  1 -
 net/dccp/ipv4.c                               |  2 +-
 net/ipv4/inet_diag.c                          |  2 +-
 net/ipv4/ip_output.c                          |  4 +--
 net/ipv4/ip_sockglue.c                        | 29 ++++++++-----------
 net/ipv4/tcp_ipv4.c                           |  9 +++---
 net/mptcp/sockopt.c                           |  8 ++---
 net/sctp/protocol.c                           |  4 +--
 .../selftests/net/mptcp/mptcp_connect.sh      |  2 +-
 9 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 46933a0d98eac2db40c2e88006125588b8f8143e..8836ee5502669f6d3a5fc35a045695bac1c3b1a9 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -810,6 +810,5 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
 void ip_sock_set_pktinfo(struct sock *sk);
 void ip_sock_set_recverr(struct sock *sk);
 void ip_sock_set_tos(struct sock *sk, int val);
-void  __ip_sock_set_tos(struct sock *sk, int val);
 
 #endif	/* _IP_H */
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 8f56e8723c7386c9f9344f1376823bfd0077c8c2..ef55e4c99e5109d68da5016e5c30e01fa50722be 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -516,7 +516,7 @@ static int dccp_v4_send_response(const struct sock *sk, struct request_sock *req
 		err = ip_build_and_send_pkt(skb, sk, ireq->ir_loc_addr,
 					    ireq->ir_rmt_addr,
 					    rcu_dereference(ireq->ireq_opt),
-					    inet_sk(sk)->tos);
+					    READ_ONCE(inet_sk(sk)->tos));
 		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e13a84433413ed88088435ff8e11efeb30fc3cca..1f2d7a8bd060e59baeb00fcb1c6aabfcb3bb213d 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -134,7 +134,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	 * hence this needs to be included regardless of socket family.
 	 */
 	if (ext & (1 << (INET_DIAG_TOS - 1)))
-		if (nla_put_u8(skb, INET_DIAG_TOS, inet->tos) < 0)
+		if (nla_put_u8(skb, INET_DIAG_TOS, READ_ONCE(inet->tos)) < 0)
 			goto errout;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 2be281f184a5fe5a695ccd51fabe69fa45bea0b8..85320f92e8363d59e92c54139044cbab7e0561fa 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -544,7 +544,7 @@ EXPORT_SYMBOL(__ip_queue_xmit);
 
 int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl)
 {
-	return __ip_queue_xmit(sk, skb, fl, inet_sk(sk)->tos);
+	return __ip_queue_xmit(sk, skb, fl, READ_ONCE(inet_sk(sk)->tos));
 }
 EXPORT_SYMBOL(ip_queue_xmit);
 
@@ -1438,7 +1438,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	iph = ip_hdr(skb);
 	iph->version = 4;
 	iph->ihl = 5;
-	iph->tos = (cork->tos != -1) ? cork->tos : inet->tos;
+	iph->tos = (cork->tos != -1) ? cork->tos : READ_ONCE(inet->tos);
 	iph->frag_off = df;
 	iph->ttl = ttl;
 	iph->protocol = sk->sk_protocol;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6d874cc03c8b4e88d79ebc50a6db105606b6ae60..50c008efbb6de7303621dd30b178c90cb3f5a2fc 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -585,25 +585,20 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 	return err;
 }
 
-void __ip_sock_set_tos(struct sock *sk, int val)
+void ip_sock_set_tos(struct sock *sk, int val)
 {
+	u8 old_tos = READ_ONCE(inet_sk(sk)->tos);
+
 	if (sk->sk_type == SOCK_STREAM) {
 		val &= ~INET_ECN_MASK;
-		val |= inet_sk(sk)->tos & INET_ECN_MASK;
+		val |= old_tos & INET_ECN_MASK;
 	}
-	if (inet_sk(sk)->tos != val) {
-		inet_sk(sk)->tos = val;
+	if (old_tos != val) {
+		WRITE_ONCE(inet_sk(sk)->tos, val);
 		WRITE_ONCE(sk->sk_priority, rt_tos2priority(val));
 		sk_dst_reset(sk);
 	}
 }
-
-void ip_sock_set_tos(struct sock *sk, int val)
-{
-	lock_sock(sk);
-	__ip_sock_set_tos(sk, val);
-	release_sock(sk);
-}
 EXPORT_SYMBOL(ip_sock_set_tos);
 
 void ip_sock_set_freebind(struct sock *sk)
@@ -1050,6 +1045,9 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 	case IP_MTU_DISCOVER:
 		return ip_sock_set_mtu_discover(sk, val);
+	case IP_TOS:	/* This sets both TOS and Precedence */
+		ip_sock_set_tos(sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1104,9 +1102,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			}
 		}
 		break;
-	case IP_TOS:	/* This sets both TOS and Precedence */
-		__ip_sock_set_tos(sk, val);
-		break;
 	case IP_UNICAST_IF:
 	{
 		struct net_device *dev = NULL;
@@ -1593,6 +1588,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MTU_DISCOVER:
 		val = READ_ONCE(inet->pmtudisc);
 		goto copyval;
+	case IP_TOS:
+		val = READ_ONCE(inet->tos);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1629,9 +1627,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -EFAULT;
 		return 0;
 	}
-	case IP_TOS:
-		val = inet->tos;
-		break;
 	case IP_MTU:
 	{
 		struct dst_entry *dst;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f13eb7e23d03f3681055257e6ebea0612ae3f9b3..1f89ba58e71eff74d8ed75019de9e70d2f4d5926 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1024,10 +1024,11 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 	if (skb) {
 		__tcp_v4_send_check(skb, ireq->ir_loc_addr, ireq->ir_rmt_addr);
 
-		tos = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos) ?
-				(tcp_rsk(req)->syn_tos & ~INET_ECN_MASK) |
-				(inet_sk(sk)->tos & INET_ECN_MASK) :
-				inet_sk(sk)->tos;
+		tos = READ_ONCE(inet_sk(sk)->tos);
+
+		if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos))
+			tos = (tcp_rsk(req)->syn_tos & ~INET_ECN_MASK) |
+			      (tos & INET_ECN_MASK);
 
 		if (!INET_ECN_is_capable(tos) &&
 		    tcp_bpf_ca_needs_ecn((struct sock *)req))
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c00669fd7d2eed2f94a3c2cf225a0d89c..155e8472ba9b83c35c6f827b2bb35c0be4127917 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -734,11 +734,11 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
-	val = inet_sk(sk)->tos;
+	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		__ip_sock_set_tos(ssk, val);
+		ip_sock_set_tos(ssk, val);
 	}
 	release_sock(sk);
 
@@ -1343,7 +1343,7 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case IP_TOS:
-		return mptcp_put_int_option(msk, optval, optlen, inet_sk(sk)->tos);
+		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
 	}
 
 	return -EOPNOTSUPP;
@@ -1411,7 +1411,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
 	ssk->sk_ipv6only = sk->sk_ipv6only;
-	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
+	ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 2185f44198deb002bc8ed7f1b0f3fe02d6bb9f09..94c6dd53cd62d1fa6236d07946e8d5ff68eb587d 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -426,7 +426,7 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	struct dst_entry *dst = NULL;
 	union sctp_addr *daddr = &t->ipaddr;
 	union sctp_addr dst_saddr;
-	__u8 tos = inet_sk(sk)->tos;
+	u8 tos = READ_ONCE(inet_sk(sk)->tos);
 
 	if (t->dscp & SCTP_DSCP_SET_MASK)
 		tos = t->dscp & SCTP_DSCP_VAL_MASK;
@@ -1057,7 +1057,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	struct flowi4 *fl4 = &t->fl.u.ip4;
 	struct sock *sk = skb->sk;
 	struct inet_sock *inet = inet_sk(sk);
-	__u8 dscp = inet->tos;
+	__u8 dscp = READ_ONCE(inet->tos);
 	__be16 df = 0;
 
 	pr_debug("%s: skb:%p, len:%d, src:%pI4, dst:%pI4\n", __func__, skb,
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b1fc8afd072dc6ddde8d561a675a5549a9a37dba..61a2a1988ce69ffa17e0dd8e629eac550f4f7d99 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -716,7 +716,7 @@ run_test_transparent()
 	# the required infrastructure in MPTCP sockopt code. To support TOS, the
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
-	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
+	if ! mptcp_lib_kallsyms_has "T ip_sock_set_tos$"; then
 		echo "INFO: ${msg} not supported by the kernel: SKIP"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
-- 
2.42.0.459.ge4e396fd5e-goog


