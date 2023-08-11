Return-Path: <netdev+bounces-26650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F1778814
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD70282029
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C781FBA;
	Fri, 11 Aug 2023 07:22:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C8187A
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:22:31 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36CC2738
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:22:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58667d06607so20942337b3.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691738549; x=1692343349;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++ZbRS7aRhMxRirefWbhbLCyimdq6GpdGfSJaOoJqZA=;
        b=wNcvnedKBsrSnl6qwJaoecrsImYm02L5EXtNQURxeEEFcUzmJAG7e/5SvkDUm8frlS
         LkNMycf08Anbl4B7yMGNfyXipZCzS6mg0Vrh5RVTtiVVGcNC0/DGic+OiH2+ATZMKe+C
         Jv8AdhLv9cnGkDjrII690JAsZINk9k8426Gm9SC6OZC16Faq1Z+/YxiA/Vk5P7P45FIL
         LZBkt5WMJMGSHiN+E5EYNpOflTswRMX7lHDH5z6eUOwo6HZ7RD0WOdkGYmyapDYXVQnY
         hYcNp0Cg5byPAvoyyQKVRgrqk4XRRce5QOjpUu873IhILJv0kSoj2fOij7pqmNHq6x4f
         ZA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691738549; x=1692343349;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++ZbRS7aRhMxRirefWbhbLCyimdq6GpdGfSJaOoJqZA=;
        b=ajeQCe6lHV58KJW7c5OnJU3Uu3JYgaM4zNQbGwlVksESXcNBMtBw2HksQcDFtfR63r
         hl//oWzqOdZLzN2135aKltDsqON6gWmZFXN6ik3vMbEchFhjgjaCDyJghsCfRwq1OUuK
         w2cgPpESbwkeDoSjytArHxPmqsIqTWvpzOrv+rtx+S9YZUF+dlmLcpiFYjY3KIuKKtM6
         rvfureUEwIhrujMmBN6u76TeJIzIHD1cPPlqKSw8KjafbjUka4qj2XAmlzOsDWl+NGWa
         eq1qiv1vZF++K3gpVAhPxFSaL8BzyvCHV+7teRVNj2u4fCBMZ8UflnrntYjaj1w5iHuQ
         zbuw==
X-Gm-Message-State: AOJu0YwghkRbspEk4lEfPEsvoeKp2xwPINXuLIVtLH7714x+bp5lAoau
	Spv5Cd8m1wrGBg9jcRTzMTBA4pcrgIKXTg==
X-Google-Smtp-Source: AGHT+IEHP20h3a895EFCF2sXKYicuKWZuvoeOUvu7wtSz5OIS4V15SiDZuFKgVohS3obxhYyJotpHNhF5gLmKg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6854:0:b0:d13:856b:c10a with SMTP id
 d81-20020a256854000000b00d13856bc10amr11745ybc.3.1691738549152; Fri, 11 Aug
 2023 00:22:29 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:22:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811072226.2777425-1-edumazet@google.com>
Subject: [PATCH net-next] netlink: convert nlk->flags to atomic flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_diag_put_flags(), netlink_setsockopt(), netlink_getsockopt()
and others use nlk->flags without correct locking.

Use set_bit(), clear_bit(), test_bit(), assign_bit() to remove
data-races.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/af_netlink.c | 90 ++++++++++++++--------------------------
 net/netlink/af_netlink.h | 22 ++++++----
 net/netlink/diag.c       | 10 ++---
 3 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 96c605e45235815a273784302d45fa7ff88e6d62..642b9d382fb46ddbc3523584c98e07da6860951a 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -84,7 +84,7 @@ struct listeners {
 
 static inline int netlink_is_kernel(struct sock *sk)
 {
-	return nlk_sk(sk)->flags & NETLINK_F_KERNEL_SOCKET;
+	return nlk_test_bit(KERNEL_SOCKET, sk);
 }
 
 struct netlink_table *nl_table __read_mostly;
@@ -349,9 +349,7 @@ static void netlink_deliver_tap_kernel(struct sock *dst, struct sock *src,
 
 static void netlink_overrun(struct sock *sk)
 {
-	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (!(nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)) {
+	if (!nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		if (!test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
 			sk->sk_err = ENOBUFS;
@@ -1407,9 +1405,7 @@ EXPORT_SYMBOL_GPL(netlink_has_listeners);
 
 bool netlink_strict_get_check(struct sk_buff *skb)
 {
-	const struct netlink_sock *nlk = nlk_sk(NETLINK_CB(skb).sk);
-
-	return nlk->flags & NETLINK_F_STRICT_CHK;
+	return nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 }
 EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 
@@ -1455,7 +1451,7 @@ static void do_one_broadcast(struct sock *sk,
 		return;
 
 	if (!net_eq(sock_net(sk), p->net)) {
-		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
+		if (!nlk_test_bit(LISTEN_ALL_NSID, sk))
 			return;
 
 		if (!peernet_has_id(sock_net(sk), p->net))
@@ -1488,7 +1484,7 @@ static void do_one_broadcast(struct sock *sk,
 		netlink_overrun(sk);
 		/* Clone failed. Notify ALL listeners. */
 		p->failure = 1;
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 		goto out;
 	}
@@ -1510,7 +1506,7 @@ static void do_one_broadcast(struct sock *sk,
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 	} else {
 		p->congested |= val;
@@ -1604,7 +1600,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 	    !test_bit(p->group - 1, nlk->groups))
 		goto out;
 
-	if (p->code == ENOBUFS && nlk->flags & NETLINK_F_RECV_NO_ENOBUFS) {
+	if (p->code == ENOBUFS && nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		ret = 1;
 		goto out;
 	}
@@ -1668,7 +1664,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	unsigned int val = 0;
-	int err;
+	int nr = -1;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1679,14 +1675,12 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (val)
-			nlk->flags |= NETLINK_F_RECV_PKTINFO;
-		else
-			nlk->flags &= ~NETLINK_F_RECV_PKTINFO;
-		err = 0;
+		nr = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_ADD_MEMBERSHIP:
 	case NETLINK_DROP_MEMBERSHIP: {
+		int err;
+
 		if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
 			return -EPERM;
 		err = netlink_realloc_groups(sk);
@@ -1706,61 +1700,38 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
 			nlk->netlink_unbind(sock_net(sk), val);
 
-		err = 0;
 		break;
 	}
 	case NETLINK_BROADCAST_ERROR:
-		if (val)
-			nlk->flags |= NETLINK_F_BROADCAST_SEND_ERROR;
-		else
-			nlk->flags &= ~NETLINK_F_BROADCAST_SEND_ERROR;
-		err = 0;
+		nr = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
+		assign_bit(NETLINK_F_RECV_NO_ENOBUFS, &nlk->flags, val);
 		if (val) {
-			nlk->flags |= NETLINK_F_RECV_NO_ENOBUFS;
 			clear_bit(NETLINK_S_CONGESTED, &nlk->state);
 			wake_up_interruptible(&nlk->wait);
-		} else {
-			nlk->flags &= ~NETLINK_F_RECV_NO_ENOBUFS;
 		}
-		err = 0;
 		break;
 	case NETLINK_LISTEN_ALL_NSID:
 		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_BROADCAST))
 			return -EPERM;
-
-		if (val)
-			nlk->flags |= NETLINK_F_LISTEN_ALL_NSID;
-		else
-			nlk->flags &= ~NETLINK_F_LISTEN_ALL_NSID;
-		err = 0;
+		nr = NETLINK_F_LISTEN_ALL_NSID;
 		break;
 	case NETLINK_CAP_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_CAP_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_CAP_ACK;
-		err = 0;
+		nr = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_EXT_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_EXT_ACK;
-		err = 0;
+		nr = NETLINK_F_EXT_ACK;
 		break;
 	case NETLINK_GET_STRICT_CHK:
-		if (val)
-			nlk->flags |= NETLINK_F_STRICT_CHK;
-		else
-			nlk->flags &= ~NETLINK_F_STRICT_CHK;
-		err = 0;
+		nr = NETLINK_F_STRICT_CHK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+	if (nr >= 0)
+		assign_bit(nr, &nlk->flags, val);
+	return 0;
 }
 
 static int netlink_getsockopt(struct socket *sock, int level, int optname,
@@ -1827,7 +1798,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	len = sizeof(int);
-	val = nlk->flags & flag ? 1 : 0;
+	val = test_bit(flag, &nlk->flags);
 
 	if (put_user(len, optlen) ||
 	    copy_to_user(optval, &val, len))
@@ -2004,9 +1975,9 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		msg->msg_namelen = sizeof(*addr);
 	}
 
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		netlink_cmsg_recv_pktinfo(msg, skb);
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		netlink_cmsg_listen_all_nsid(sk, msg, skb);
 
 	memset(&scm, 0, sizeof(scm));
@@ -2083,7 +2054,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		goto out_sock_release;
 
 	nlk = nlk_sk(sk);
-	nlk->flags |= NETLINK_F_KERNEL_SOCKET;
+	set_bit(NETLINK_F_KERNEL_SOCKET, &nlk->flags);
 
 	netlink_table_grab();
 	if (!nl_table[unit].registered) {
@@ -2218,7 +2189,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	nl_dump_check_consistent(cb, nlh);
 	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno, sizeof(nlk->dump_done_errno));
 
-	if (extack->_msg && nlk->flags & NETLINK_F_EXT_ACK) {
+	if (extack->_msg && test_bit(NETLINK_F_EXT_ACK, &nlk->flags)) {
 		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
 		if (!nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg))
 			nlmsg_end(skb, nlh);
@@ -2347,8 +2318,8 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			 const struct nlmsghdr *nlh,
 			 struct netlink_dump_control *control)
 {
-	struct netlink_sock *nlk, *nlk2;
 	struct netlink_callback *cb;
+	struct netlink_sock *nlk;
 	struct sock *sk;
 	int ret;
 
@@ -2383,8 +2354,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	cb->min_dump_alloc = control->min_dump_alloc;
 	cb->skb = skb;
 
-	nlk2 = nlk_sk(NETLINK_CB(skb).sk);
-	cb->strict_check = !!(nlk2->flags & NETLINK_F_STRICT_CHK);
+	cb->strict_check = nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 
 	if (control->start) {
 		cb->extack = control->extack;
@@ -2428,7 +2398,7 @@ netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
 {
 	size_t tlvlen;
 
-	if (!extack || !(nlk->flags & NETLINK_F_EXT_ACK))
+	if (!extack || !test_bit(NETLINK_F_EXT_ACK, &nlk->flags))
 		return 0;
 
 	tlvlen = 0;
@@ -2500,7 +2470,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	 * requests to cap the error message, and get extra error data if
 	 * requested.
 	 */
-	if (err && !(nlk->flags & NETLINK_F_CAP_ACK))
+	if (err && !test_bit(NETLINK_F_CAP_ACK, &nlk->flags))
 		payload += nlmsg_len(nlh);
 	else
 		flags |= NLM_F_CAPPED;
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index fd424cd63f31cf09b00398a1ca92c0e0600ac7bb..2145979b9986a0331b34b6ba2fda867f23d0d71c 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -8,14 +8,16 @@
 #include <net/sock.h>
 
 /* flags */
-#define NETLINK_F_KERNEL_SOCKET		0x1
-#define NETLINK_F_RECV_PKTINFO		0x2
-#define NETLINK_F_BROADCAST_SEND_ERROR	0x4
-#define NETLINK_F_RECV_NO_ENOBUFS	0x8
-#define NETLINK_F_LISTEN_ALL_NSID	0x10
-#define NETLINK_F_CAP_ACK		0x20
-#define NETLINK_F_EXT_ACK		0x40
-#define NETLINK_F_STRICT_CHK		0x80
+enum {
+	NETLINK_F_KERNEL_SOCKET,
+	NETLINK_F_RECV_PKTINFO,
+	NETLINK_F_BROADCAST_SEND_ERROR,
+	NETLINK_F_RECV_NO_ENOBUFS,
+	NETLINK_F_LISTEN_ALL_NSID,
+	NETLINK_F_CAP_ACK,
+	NETLINK_F_EXT_ACK,
+	NETLINK_F_STRICT_CHK,
+};
 
 #define NLGRPSZ(x)	(ALIGN(x, sizeof(unsigned long) * 8) / 8)
 #define NLGRPLONGS(x)	(NLGRPSZ(x)/sizeof(unsigned long))
@@ -23,10 +25,10 @@
 struct netlink_sock {
 	/* struct sock has to be the first member of netlink_sock */
 	struct sock		sk;
+	unsigned long		flags;
 	u32			portid;
 	u32			dst_portid;
 	u32			dst_group;
-	u32			flags;
 	u32			subscriptions;
 	u32			ngroups;
 	unsigned long		*groups;
@@ -56,6 +58,8 @@ static inline struct netlink_sock *nlk_sk(struct sock *sk)
 	return container_of(sk, struct netlink_sock, sk);
 }
 
+#define nlk_test_bit(nr, sk) test_bit(NETLINK_F_##nr, &nlk_sk(sk)->flags)
+
 struct netlink_table {
 	struct rhashtable	hash;
 	struct hlist_head	mc_list;
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index e4f21b1067bccacc86811bd240056de65c470ad9..9c4f231be27572f9d889248c33a04868f22e44de 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -27,15 +27,15 @@ static int sk_diag_put_flags(struct sock *sk, struct sk_buff *skb)
 
 	if (nlk->cb_running)
 		flags |= NDIAG_FLAG_CB_RUNNING;
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		flags |= NDIAG_FLAG_PKTINFO;
-	if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+	if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 		flags |= NDIAG_FLAG_BROADCAST_ERROR;
-	if (nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)
+	if (nlk_test_bit(RECV_NO_ENOBUFS, sk))
 		flags |= NDIAG_FLAG_NO_ENOBUFS;
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		flags |= NDIAG_FLAG_LISTEN_ALL_NSID;
-	if (nlk->flags & NETLINK_F_CAP_ACK)
+	if (nlk_test_bit(CAP_ACK, sk))
 		flags |= NDIAG_FLAG_CAP_ACK;
 
 	return nla_put_u32(skb, NETLINK_DIAG_FLAGS, flags);
-- 
2.41.0.640.ga95def55d0-goog


