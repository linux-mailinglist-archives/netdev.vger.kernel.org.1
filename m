Return-Path: <netdev+bounces-301047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4FEzC4wSOWpbmQcAu9opvQ
	(envelope-from <netdev+bounces-301047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:46:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D16AED15
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:46:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="iBnP2/gy";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301047-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301047-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE42D303DD2D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC442C08BB;
	Mon, 22 Jun 2026 10:45:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249A29DB9A;
	Mon, 22 Jun 2026 10:45:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125117; cv=none; b=Y/lOpIC/JyIeg3hj6lHYgNMBp+damIKkHDY0t9j2dvz9QlRlCogPwrdCgQt7qWMABVobKwUO/H5z+7jnybB0vZd7UqAfXjGwmt0nMSdlCjA9xuVLm2xkiQWRcEoEbVvvXLZwZgPM/cJv0YxEmuj6H6W3ZTHauczZX2b5uitwQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125117; c=relaxed/simple;
	bh=Tr4oW7UO0sW/fQVPPy0YeoSrDki/XK4SVSEqmGO2sUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p81DINzXdYwDhnk7mZqZIhjRQETrQ72jxnkYblBebwR63pOIHTz4LSPFNlMblmcfs4IFhWKJguKOnuGeNsUQaL17lTwTm54l29IGelSXlPzjRpGwSy1O++jv4ksn+sxTq4iDq7f2PxOOEG40VzE/ol+A1jeqXfbVfzRj1d6DPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBnP2/gy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E201F00A3D;
	Mon, 22 Jun 2026 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125116;
	bh=3bBqNZaZV2OEMX+X5K6tu2Jo8UwlRKjp7hC3OW6PrVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBnP2/gyXY7PXgc62No3bnpCdLP8wv2BFAJhAMQjvtbHTZuI8krG3fQaXJ2SM0ikg
	 usenvIfRfEjJE7MuVo34hChVPsBeVQl9UpnWpg8A0bFsh7MtSk0bYbPj/FarzG3/PZ
	 KgVNsUjmECUlvl0o31jR060S8FD7lFqXKWoTipnaiD2XAE7AupUV4ME+t78GvYjBP6
	 5K8MEG38Udrekgnf4Ubi/4qvMhjLrBTJ8ko+oR1vTNmJVIcXqDes7HfkL78Z7WtDND
	 VWcuSpa6l3qvr6lETY5mEXbbKKaks9nKyKUaidAgDqvxkCpyThpcTeb+zrPGu1QvMQ
	 NFPcJVNWCMy3A==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 11/17] mptcp: implement mptcp-specific tls protocol ops
Date: Mon, 22 Jun 2026 18:43:31 +0800
Message-ID: <447fc4384ba0d4b0f78c452239dbb3e87e021578.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301047-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B88D16AED15

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements the MPTCP-specific struct tls_prot_ops, named
'tls_mptcp_ops'.

Passing an MPTCP socket to tcp_sock_rate_check_app_limited() can
trigger a crash. Here, an MPTCP version of check_app_limited() is
implemented, which calls tcp_sock_rate_check_app_limited() for each
subflow.

When MPTCP implements lock_is_held interface, it not only checks
sock_owned_by_user_nocheck(sk) as TCP does, but also needs to check
whether the MPTCP data lock is held. This is required because TLS
may call lock_is_held from softirq context with bh_lock_sock held.
Checking both conditions ensures TLS always defers to workqueue when
the MPTCP data lock is held, avoiding deadlock.

Implement mptcp_skb_get_header() to handle fragmented MPTCP skbs when
copying TLS record headers.

In tls_strp_read_sock(), tls_strp_load_anchor_with_queue() first
attaches the skbs from TCP/MPTCP to the frag_list of strp->anchor.
In TCP, this is fine because the skb data is contiguous; however,
in MPTCP, each skb has its own offset, causing the data to be
non-contiguous. As a result, during the subsequent tls_rx_msg_size()
process, skb_copy_bits() may access across skbs. In MPTCP, the offset
of the second skb is ignored, leading to data access errors.
Therefore, mptcp_skb_get_header() can effectively handle this
problem and obtain the correct TLS header.

In the later process, tls_strp_check_queue_ok() handles the copy_mode
scenario. When an MPTCP skb has a non-zero offset, it falls back to
copy_mode, copying the valid data from each skb one by one into
anchor->frag_list, thus resolving the offset issue. Hence, the impact
of the offset within the TLS module is completely eliminated.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |   2 +
 include/net/tcp.h    |   1 +
 net/ipv4/tcp.c       |   9 +++-
 net/mptcp/protocol.c | 113 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |   1 +
 net/tls/tls_main.c   |  13 +++++
 6 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 333bde2a0b76..ba2257986b13 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,8 @@ struct mptcp_pm_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+extern struct tls_prot_ops tls_mptcp_ops;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d1c0..ac823492d3e4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -849,6 +849,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b427f924608c..b875be6ae5bc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1096,9 +1096,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 }
 
 /* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
+	struct sock *sk = (struct sock *)tp;
 
 	if (/* We have less than one packet to send. */
 	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
@@ -1111,6 +1111,11 @@ void tcp_rate_check_app_limited(struct sock *sk)
 		tp->app_limited =
 			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
 }
+
+void tcp_rate_check_app_limited(struct sock *sk)
+{
+	tcp_sock_rate_check_app_limited(tcp_sk(sk));
+}
 EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
 
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 18c8b6c64c3f..f4cd7a6e5770 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,6 +24,7 @@
 #include <net/mptcp.h>
 #include <net/hotdata.h>
 #include <net/xfrm.h>
+#include <net/tls.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
@@ -4894,3 +4895,115 @@ int __init mptcp_proto_v6_init(void)
 	return err;
 }
 #endif
+
+static bool mptcp_lock_is_held(struct sock *sk)
+{
+	return sock_owned_by_user_nocheck(sk) ||
+	       mptcp_data_is_locked(sk);
+}
+
+static void mptcp_read_done(struct sock *sk, size_t len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	size_t left;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
+	left = len;
+	while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		int used;
+
+		used = min_t(size_t, skb->len - offset, left);
+		msk->bytes_consumed += used;
+		MPTCP_SKB_CB(skb)->offset += used;
+		MPTCP_SKB_CB(skb)->map_seq += used;
+		left -= used;
+
+		if (skb->len > offset + used)
+			break;
+
+		mptcp_eat_recv_skb(sk, skb);
+	}
+
+	mptcp_rcv_space_adjust(msk, len - left);
+
+	/* Clean up data we have read: This will do ACK frames. */
+	if (left != len)
+		mptcp_cleanup_rbuf(msk, len - left);
+}
+
+static u32 mptcp_get_skb_seq(struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)->offset;
+}
+
+static int mptcp_skb_get_header(const struct sk_buff *skb, int off,
+				void *buf, int len)
+{
+	const struct sk_buff *iter = skb_shinfo(skb)->frag_list;
+	int copied = 0;
+	int ret = 0;
+
+	if (!iter)
+		return skb_copy_bits(skb, off, buf, len);
+
+	/* Make absolute to positive */
+	off -= MPTCP_SKB_CB(iter)->offset;
+
+	while (iter && copied < len) {
+		int skb_off  = MPTCP_SKB_CB(iter)->offset;
+		int data_len = iter->len - skb_off;
+		int count;
+
+		if (off >= data_len) {
+			off -= data_len; /* MPTCP skb avail data */
+			iter = iter->next;
+			continue;
+		}
+
+		count = min((int)(data_len - off), len - copied);
+		ret = skb_copy_bits(iter, skb_off + off, buf + copied, count);
+		if (ret)
+			break;
+		copied += count;
+		off = 0;
+		iter = iter->next;
+	}
+
+	if (copied < len && !ret)
+		ret = -EFAULT;
+	return ret;
+}
+
+static void mptcp_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_sock_rate_check_app_limited(tcp_sk(ssk));
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
+struct tls_prot_ops tls_mptcp_ops = {
+	.owner			= THIS_MODULE,
+	.protocol		= IPPROTO_MPTCP,
+	.recv_skb		= mptcp_recv_skb,
+	.lock_is_held		= mptcp_lock_is_held,
+	.read_done		= mptcp_read_done,
+	.get_skb_seq		= mptcp_get_skb_seq,
+	.skb_get_header		= mptcp_skb_get_header,
+	.epollin_ready		= mptcp_epollin_ready,
+	.check_app_limited	= mptcp_check_app_limited,
+};
+EXPORT_SYMBOL(tls_mptcp_ops);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..6dea626348d9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -380,6 +380,7 @@ struct mptcp_sock {
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
 #define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
+#define mptcp_data_is_locked(sk) spin_is_locked(&(sk)->sk_lock.slock)
 
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b45890e75c9e..170ccbb9d36d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1366,6 +1366,12 @@ static int __init tls_register(void)
 	if (err)
 		goto err_strp;
 
+#ifdef CONFIG_MPTCP
+	err = tls_register_prot_ops(&tls_mptcp_ops);
+	if (err)
+		goto err_tcp;
+#endif
+
 	err = tls_device_init();
 	if (err)
 		goto err_ops;
@@ -1374,6 +1380,10 @@ static int __init tls_register(void)
 
 	return 0;
 err_ops:
+#ifdef CONFIG_MPTCP
+	tls_unregister_prot_ops(&tls_mptcp_ops);
+err_tcp:
+#endif
 	tls_unregister_prot_ops(&tls_tcp_ops);
 err_strp:
 	tls_strp_dev_exit();
@@ -1385,6 +1395,9 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+#ifdef CONFIG_MPTCP
+	tls_unregister_prot_ops(&tls_mptcp_ops);
+#endif
 	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.53.0


