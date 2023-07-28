Return-Path: <netdev+bounces-22313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6676701D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EC22827FD
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9413FFB;
	Fri, 28 Jul 2023 15:03:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8714A94
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:40 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81935A3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c83284edf0eso2042617276.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556615; x=1691161415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kMCWy1MsJd/kgnuRcotDNw1d9C0JDqEWC/KjN/jm0A=;
        b=payXw/4l7BzXVjjefIfleTidQlw4reOK7ymxrZ7pAtvnRil5wQISbjlvP7wDENaRpc
         3bO0bmccQOxRbQRo53ZvxqLf3oRDVbMbGHCUPyAh/o+b1FqNyTle8QvTtRqg8jz6DYOt
         O5lWvB4yd/BJCe+3TfsEuQQAvVEd/IDxCw2UaBBCMFpHefYV8mp2+U+NPK6qODGLebUi
         rfbMSGeW1bdqZi4AkdMElrUbZDiyNrzULKBRZ9Fd0ckwa+zoBfKQXzbbRSHCJ4u1xxAN
         zq9/LqO7lkzHGRKCoap8YtYfYXvCSbZrAHrZSb9dZji5L6Bymj+ToSO288DYzQguVA7l
         wCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556615; x=1691161415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kMCWy1MsJd/kgnuRcotDNw1d9C0JDqEWC/KjN/jm0A=;
        b=b2gUkb8EYMqH1A9xM4MW3BsXl1/+CfSd1NsGDR7TlZZDEMYETVwP0tcucsQ6jL00KU
         Xf7rS+1+f/hiLGQJXqe/Cp10vEKlG7YGO10isXR8RtC9gkrNMujeXYbNU50676xoIfvE
         E6a+Y+4Gr4r7h2AsDAYubfI4d7suZJl87QXbTkOqjQkhMfWuaiDjDuIC4D9QrE4LOIs6
         k6sVsn+ieBOOPu+U/gfBGpGNoqjjkfW3shiSP2EnWXO11cvYwwY2Dzh/2p1PcsayXyUg
         GRhXVQO49s9uadnICtTzsVY3bRjB4Ohz8pZsjM5/F1s21g+fVXJr780/w6+Rg+yjVi5R
         vrJw==
X-Gm-Message-State: ABy/qLaNZyaDPYW18KXGBY1nZoZ8oF8zN393kDK5Weqj6XFmONG2adB/
	/HrkvhAAZhlVWTItm6RfSyYIY3218uryiA==
X-Google-Smtp-Source: APBJJlHIYEPHxbjcM2PSFmObl4ANY3gwFdXpnFCu5j3fYkZOfL2q0SwYkxgJ5KsGv341SD+zuTeB3jnbMFWIXQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2647:0:b0:d0e:5cb2:8635 with SMTP id
 m68-20020a252647000000b00d0e5cb28635mr10650ybm.11.1690556615422; Fri, 28 Jul
 2023 08:03:35 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:15 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-9-edumazet@google.com>
Subject: [PATCH net 08/11] net: annotate data-races around sk->sk_mark
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk->sk_mark is often read while another thread could change the value.

Fixes: 4a19ec5800fc ("[NET]: Introducing socket mark socket option.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_sock.h    | 7 ++++---
 include/net/ip.h           | 2 +-
 include/net/route.h        | 4 ++--
 net/can/raw.c              | 2 +-
 net/core/sock.c            | 4 ++--
 net/dccp/ipv6.c            | 4 ++--
 net/ipv4/inet_diag.c       | 4 ++--
 net/ipv4/ip_output.c       | 4 ++--
 net/ipv4/route.c           | 4 ++--
 net/ipv4/tcp_ipv4.c        | 2 +-
 net/ipv6/ping.c            | 2 +-
 net/ipv6/raw.c             | 4 ++--
 net/ipv6/route.c           | 7 ++++---
 net/ipv6/tcp_ipv6.c        | 6 +++---
 net/ipv6/udp.c             | 4 ++--
 net/l2tp/l2tp_ip6.c        | 2 +-
 net/mptcp/sockopt.c        | 2 +-
 net/netfilter/nft_socket.c | 2 +-
 net/netfilter/xt_socket.c  | 4 ++--
 net/packet/af_packet.c     | 6 +++---
 net/smc/af_smc.c           | 2 +-
 net/xdp/xsk.c              | 2 +-
 net/xfrm/xfrm_policy.c     | 2 +-
 23 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index caa20a9055310f5ef108f9b1bb43214a3d598b9e..0bb32bfc61832dd787abcb2db3ee85d55c83f2c9 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -107,11 +107,12 @@ static inline struct inet_request_sock *inet_rsk(const struct request_sock *sk)
 
 static inline u32 inet_request_mark(const struct sock *sk, struct sk_buff *skb)
 {
-	if (!sk->sk_mark &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fwmark_accept))
+	u32 mark = READ_ONCE(sk->sk_mark);
+
+	if (!mark && READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fwmark_accept))
 		return skb->mark;
 
-	return sk->sk_mark;
+	return mark;
 }
 
 static inline int inet_request_bound_dev_if(const struct sock *sk,
diff --git a/include/net/ip.h b/include/net/ip.h
index 50d435855ae252e55a6d5bec3bf42e9a5392558d..332521170d9b86ab8cf53e134e199d4312e298cf 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -93,7 +93,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 {
 	ipcm_init(ipcm);
 
-	ipcm->sockc.mark = inet->sk.sk_mark;
+	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
 	ipcm->sockc.tsflags = inet->sk.sk_tsflags;
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
diff --git a/include/net/route.h b/include/net/route.h
index 5a5c726472bd67656c6f66805f956ac99b5fc4ad..8c2a8e7d8f8e6737515efbfbdf1d14ec21ec5e5c 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -168,7 +168,7 @@ static inline struct rtable *ip_route_output_ports(struct net *net, struct flowi
 						   __be16 dport, __be16 sport,
 						   __u8 proto, __u8 tos, int oif)
 {
-	flowi4_init_output(fl4, oif, sk ? sk->sk_mark : 0, tos,
+	flowi4_init_output(fl4, oif, sk ? READ_ONCE(sk->sk_mark) : 0, tos,
 			   RT_SCOPE_UNIVERSE, proto,
 			   sk ? inet_sk_flowi_flags(sk) : 0,
 			   daddr, saddr, dport, sport, sock_net_uid(net, sk));
@@ -301,7 +301,7 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
 	if (inet_sk(sk)->transparent)
 		flow_flags |= FLOWI_FLAG_ANYSRC;
 
-	flowi4_init_output(fl4, oif, sk->sk_mark, ip_sock_rt_tos(sk),
+	flowi4_init_output(fl4, oif, READ_ONCE(sk->sk_mark), ip_sock_rt_tos(sk),
 			   ip_sock_rt_scope(sk), protocol, flow_flags, dst,
 			   src, dport, sport, sk->sk_uid);
 }
diff --git a/net/can/raw.c b/net/can/raw.c
index ba6b52b1d7767fdd7b57d1b8e5519495340c572c..e10f59375659f8342ff7e2d6da834920fd526184 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -865,7 +865,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	skb->dev = dev;
 	skb->priority = sk->sk_priority;
-	skb->mark = sk->sk_mark;
+	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
diff --git a/net/core/sock.c b/net/core/sock.c
index 96616eb3869db6a6c33be34909af017d7dea59b1..d831a3df2cefc9c2c7467b59b044227d16c712b7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -990,7 +990,7 @@ EXPORT_SYMBOL(sock_set_rcvbuf);
 static void __sock_set_mark(struct sock *sk, u32 val)
 {
 	if (val != sk->sk_mark) {
-		sk->sk_mark = val;
+		WRITE_ONCE(sk->sk_mark, val);
 		sk_dst_reset(sk);
 	}
 }
@@ -1851,7 +1851,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 							 optval, optlen, len);
 
 	case SO_MARK:
-		v.val = sk->sk_mark;
+		v.val = READ_ONCE(sk->sk_mark);
 		break;
 
 	case SO_RCVMARK:
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 7249ef218178743ce7936fcf2f605616a419370e..d29d1163203d965361ed9b632321cdfd36f0eb76 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -238,8 +238,8 @@ static int dccp_v6_send_response(const struct sock *sk, struct request_sock *req
 		opt = ireq->ipv6_opt;
 		if (!opt)
 			opt = rcu_dereference(np->opt);
-		err = ip6_xmit(sk, skb, &fl6, sk->sk_mark, opt, np->tclass,
-			       sk->sk_priority);
+		err = ip6_xmit(sk, skb, &fl6, READ_ONCE(sk->sk_mark), opt,
+			       np->tclass, sk->sk_priority);
 		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index b812eb36f0e367b976876c6a9be90babbb6de1f4..f7426926a10413b42ec3b99d97f59445b6d1becc 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -150,7 +150,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	}
 #endif
 
-	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK, sk->sk_mark))
+	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK, READ_ONCE(sk->sk_mark)))
 		goto errout;
 
 	if (ext & (1 << (INET_DIAG_CLASS_ID - 1)) ||
@@ -799,7 +799,7 @@ int inet_diag_bc_sk(const struct nlattr *bc, struct sock *sk)
 	entry.ifindex = sk->sk_bound_dev_if;
 	entry.userlocks = sk_fullsock(sk) ? sk->sk_userlocks : 0;
 	if (sk_fullsock(sk))
-		entry.mark = sk->sk_mark;
+		entry.mark = READ_ONCE(sk->sk_mark);
 	else if (sk->sk_state == TCP_NEW_SYN_RECV)
 		entry.mark = inet_rsk(inet_reqsk(sk))->ir_mark;
 	else if (sk->sk_state == TCP_TIME_WAIT)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6e70839257f74fa3f4019305280022a33ee00240..bcdbf448324a9c28ceff55764c54074763873296 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -186,7 +186,7 @@ int ip_build_and_send_pkt(struct sk_buff *skb, const struct sock *sk,
 
 	skb->priority = sk->sk_priority;
 	if (!skb->mark)
-		skb->mark = sk->sk_mark;
+		skb->mark = READ_ONCE(sk->sk_mark);
 
 	/* Send it out. */
 	return ip_local_out(net, skb->sk, skb);
@@ -529,7 +529,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 
 	/* TODO : should we use skb->sk here instead of sk ? */
 	skb->priority = sk->sk_priority;
-	skb->mark = sk->sk_mark;
+	skb->mark = READ_ONCE(sk->sk_mark);
 
 	res = ip_local_out(net, sk, skb);
 	rcu_read_unlock();
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 98d7e6ba7493be243038433d204f7a4127d2f4f2..92fede388d52052ee3bd2337298b8cb0608dc362 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -518,7 +518,7 @@ static void __build_flow_key(const struct net *net, struct flowi4 *fl4,
 		const struct inet_sock *inet = inet_sk(sk);
 
 		oif = sk->sk_bound_dev_if;
-		mark = sk->sk_mark;
+		mark = READ_ONCE(sk->sk_mark);
 		tos = ip_sock_rt_tos(sk);
 		scope = ip_sock_rt_scope(sk);
 		prot = inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol;
@@ -552,7 +552,7 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 	inet_opt = rcu_dereference(inet->inet_opt);
 	if (inet_opt && inet_opt->opt.srr)
 		daddr = inet_opt->opt.faddr;
-	flowi4_init_output(fl4, sk->sk_bound_dev_if, sk->sk_mark,
+	flowi4_init_output(fl4, sk->sk_bound_dev_if, READ_ONCE(sk->sk_mark),
 			   ip_sock_rt_tos(sk) & IPTOS_RT_MASK,
 			   ip_sock_rt_scope(sk),
 			   inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0696420146369a8786f0dbab142e45aa09fbac00..894653be033a508d2169738ec32831438fbc614f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -931,7 +931,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	ctl_sk = this_cpu_read(ipv4_tcp_sk);
 	sock_net_set(ctl_sk, net);
 	ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
-			   inet_twsk(sk)->tw_mark : sk->sk_mark;
+			   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
 	ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
 			   inet_twsk(sk)->tw_priority : sk->sk_priority;
 	transmit_time = tcp_transmit_time(sk);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index f804c11e2146cba9e9b8c10337341dc3fb4e0143..c2c291827a2ce990a62466ece52ecb7dc9d30490 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -120,7 +120,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipcm6_init_sk(&ipc6, np);
 	ipc6.sockc.tsflags = sk->sk_tsflags;
-	ipc6.sockc.mark = sk->sk_mark;
+	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	fl6.flowi6_oif = oif;
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ac1cef094c5f200d34a45eeb06f2f7356c87ad6d..39b7d727ba40793a61f2e02044666551dd091eda 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -774,12 +774,12 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 */
 	memset(&fl6, 0, sizeof(fl6));
 
-	fl6.flowi6_mark = sk->sk_mark;
+	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
 	ipcm6_init(&ipc6);
 	ipc6.sockc.tsflags = sk->sk_tsflags;
-	ipc6.sockc.mark = sk->sk_mark;
+	ipc6.sockc.mark = fl6.flowi6_mark;
 
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f1907b813d675a9ea46f5db3f429c..56a55585eb798b7885bcc32cc853becd1f120c94 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2951,7 +2951,8 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 	if (!oif && skb->dev)
 		oif = l3mdev_master_ifindex(skb->dev);
 
-	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, sk->sk_mark, sk->sk_uid);
+	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, READ_ONCE(sk->sk_mark),
+			sk->sk_uid);
 
 	dst = __sk_dst_get(sk);
 	if (!dst || !dst->obsolete ||
@@ -3172,8 +3173,8 @@ void ip6_redirect_no_header(struct sk_buff *skb, struct net *net, int oif)
 
 void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 {
-	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if, sk->sk_mark,
-		     sk->sk_uid);
+	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if,
+		     READ_ONCE(sk->sk_mark), sk->sk_uid);
 }
 EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4714eb695913d43f03f533483560ab8cb5bf555d..3ec563742ac4f2c630b961960adc3e5f26976d92 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -564,8 +564,8 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 		opt = ireq->ipv6_opt;
 		if (!opt)
 			opt = rcu_dereference(np->opt);
-		err = ip6_xmit(sk, skb, fl6, skb->mark ? : sk->sk_mark, opt,
-			       tclass, sk->sk_priority);
+		err = ip6_xmit(sk, skb, fl6, skb->mark ? : READ_ONCE(sk->sk_mark),
+			       opt, tclass, sk->sk_priority);
 		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
@@ -939,7 +939,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
 		else
-			mark = sk->sk_mark;
+			mark = READ_ONCE(sk->sk_mark);
 		skb_set_delivery_time(buff, tcp_transmit_time(sk), true);
 	}
 	if (txhash) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index b7c972aa09a75404e0edb33f0354c53702c991f8..635683e3f0613831e26bcf4a9d4bfbd8d1e6fc54 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -624,7 +624,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (type == NDISC_REDIRECT) {
 		if (tunnel) {
 			ip6_redirect(skb, sock_net(sk), inet6_iif(skb),
-				     sk->sk_mark, sk->sk_uid);
+				     READ_ONCE(sk->sk_mark), sk->sk_uid);
 		} else {
 			ip6_sk_redirect(skb, sk);
 		}
@@ -1356,7 +1356,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ipcm6_init(&ipc6);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
 	ipc6.sockc.tsflags = sk->sk_tsflags;
-	ipc6.sockc.mark = sk->sk_mark;
+	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	/* destination address check */
 	if (sin6) {
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index b1623f9c4f921791ab541ecf93695ea19addaa5a..ff78217f0cb1289bdf1022f0414e1188d5e786d1 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -519,7 +519,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* Get and verify the address */
 	memset(&fl6, 0, sizeof(fl6));
 
-	fl6.flowi6_mark = sk->sk_mark;
+	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
 	ipcm6_init(&ipc6);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 63f7a09335c5c9489ce211790502eae9b6894aac..a3f1fe810cc961bf689fe8edda49d227a3170f91 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -103,7 +103,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 			break;
 		case SO_MARK:
 			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
-				ssk->sk_mark = sk->sk_mark;
+				WRITE_ONCE(ssk->sk_mark, sk->sk_mark);
 				sk_dst_reset(ssk);
 			}
 			break;
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 84def74698b78b77bd95dead1b3ee68d48521d45..9ed85be79452d990ad79ad9a0b31a26bb3f4c6a4 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -107,7 +107,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		break;
 	case NFT_SOCKET_MARK:
 		if (sk_fullsock(sk)) {
-			*dest = sk->sk_mark;
+			*dest = READ_ONCE(sk->sk_mark);
 		} else {
 			regs->verdict.code = NFT_BREAK;
 			return;
diff --git a/net/netfilter/xt_socket.c b/net/netfilter/xt_socket.c
index 7013f55f05d1ebca3b13d29934d8f6abc1ef36f0..76e01f292aaff638f8c9c37583bc33b3ea942b65 100644
--- a/net/netfilter/xt_socket.c
+++ b/net/netfilter/xt_socket.c
@@ -77,7 +77,7 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
 
 		if (info->flags & XT_SOCKET_RESTORESKMARK && !wildcard &&
 		    transparent && sk_fullsock(sk))
-			pskb->mark = sk->sk_mark;
+			pskb->mark = READ_ONCE(sk->sk_mark);
 
 		if (sk != skb->sk)
 			sock_gen_put(sk);
@@ -138,7 +138,7 @@ socket_mt6_v1_v2_v3(const struct sk_buff *skb, struct xt_action_param *par)
 
 		if (info->flags & XT_SOCKET_RESTORESKMARK && !wildcard &&
 		    transparent && sk_fullsock(sk))
-			pskb->mark = sk->sk_mark;
+			pskb->mark = READ_ONCE(sk->sk_mark);
 
 		if (sk != skb->sk)
 			sock_gen_put(sk);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e3ddec4c3d57e7492b55404db3119cbba6f6022..d9aa21a2b3a16c96416feca6b195769e6b9a91f7 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2051,7 +2051,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->protocol = proto;
 	skb->dev = dev;
 	skb->priority = sk->sk_priority;
-	skb->mark = sk->sk_mark;
+	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
@@ -2586,7 +2586,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->protocol = proto;
 	skb->dev = dev;
 	skb->priority = po->sk.sk_priority;
-	skb->mark = po->sk.sk_mark;
+	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb->tstamp = sockc->transmit_time;
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
@@ -2988,7 +2988,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	sockcm_init(&sockc, sk);
-	sockc.mark = sk->sk_mark;
+	sockc.mark = READ_ONCE(sk->sk_mark);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index a7f887d91d89b82d9a799907e67b33cadee24523..0c013d2b5d8f4524712ee585bb371c3ce65b1149 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -445,7 +445,7 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 	nsk->sk_rcvbuf = osk->sk_rcvbuf;
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
-	nsk->sk_mark = osk->sk_mark;
+	nsk->sk_mark = READ_ONCE(osk->sk_mark);
 	nsk->sk_priority = osk->sk_priority;
 	nsk->sk_rcvlowat = osk->sk_rcvlowat;
 	nsk->sk_bound_dev_if = osk->sk_bound_dev_if;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 31dca4ecb2c53255063301de141ac1b0189d0244..b89adb52a977e521b628f95ca9fd4fbf33adfa1f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -505,7 +505,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	skb->dev = dev;
 	skb->priority = xs->sk.sk_priority;
-	skb->mark = xs->sk.sk_mark;
+	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
 	skb->destructor = xsk_destruct_skb;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index e7617c9959c311f14e04bfddaa00019df91a812a..d6b405782b6361c4da2e06fae50befbd699aed15 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2250,7 +2250,7 @@ static struct xfrm_policy *xfrm_sk_policy_lookup(const struct sock *sk, int dir,
 
 		match = xfrm_selector_match(&pol->selector, fl, family);
 		if (match) {
-			if ((sk->sk_mark & pol->mark.m) != pol->mark.v ||
+			if ((READ_ONCE(sk->sk_mark) & pol->mark.m) != pol->mark.v ||
 			    pol->if_id != if_id) {
 				pol = NULL;
 				goto out;
-- 
2.41.0.585.gd2178a4bd4-goog


