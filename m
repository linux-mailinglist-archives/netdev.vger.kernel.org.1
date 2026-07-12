Return-Path: <netdev+bounces-306911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gMKRJ57xUmqFVgMAu9opvQ
	(envelope-from <netdev+bounces-306911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:45:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 141CE743703
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306911-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306911-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E19A5302ACFE
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389023393C;
	Sun, 12 Jul 2026 01:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F925233923
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:41:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820484; cv=none; b=KFV+UFD5Nq4deORLNuaLGQXYLcJi0K7Xpe2S9qArPubbjOZuWi9oz9DIuXFqI2sxkAGWx2hsXhT6SdG5nCZHsaev1EHsQix+jnmFuLp8aJRZZfhIvWTsIo+G5+6h14sk2C0EYOXFzaSFLcP1CVUDbqLg3WZqYM5Lbl820CChMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820484; c=relaxed/simple;
	bh=y8w8fLA6JG3lOrwyyFfB2u+PLm0xp0XTnmk55mKB6i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqBMfvTyjrCTVqWkrne5Blc/MGhbibjbIHzlVLLx3bKbjDJK8/kgmPP+KCzJPtGxbnbzMbb5tI1rRIG+eAwY2VLv9SortmRArYljKD30vWGGv5akWSZRR5O3UJlaVW3+6rXyoXqHBa5KYUT5GP3Vx26lAl49tMG4eGe9eS2tAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2372E76D91;
	Sun, 12 Jul 2026 01:41:12 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D557D779B5;
	Sun, 12 Jul 2026 01:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8DDvMLbwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:10 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Florian Westphal <fw@strlen.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/13 RFC net-next] net: icmp: split IPv4 specific logic into icmp_ipv4.c
Date: Sun, 12 Jul 2026 03:39:05 +0200
Message-ID: <20260712013941.4570-8-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306911-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,suse.de,strlen.de,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:ardb@kernel.org,m:ncardwell@google.com,m:fw@strlen.de,m:ebiggers@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:brauner@kernel.org,m:jlayton@kernel.org,m:kees@kernel.org,m:tpluszz77@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:email,suse.de:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 141CE743703

To enable compiling INET subsystem withot IPv4, ICMP protocol IPv4
specific functions must be isolated from the generic ICMP protocol
infrastructure.

This patch creates icmp_ipv4.c and move all the functions for packet
processing, error handling, and other from icmp.c to a new file. The
Makefile is updated to compile icmp_ipv4.c only when CONFIG_IPV4 is
enabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/net/icmp.h   |    1 +
 net/ipv4/Makefile    |    9 +-
 net/ipv4/icmp.c      | 1407 +----------------------------------------
 net/ipv4/icmp_ipv4.c | 1425 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/datagram.c  |    2 +
 5 files changed, 1441 insertions(+), 1403 deletions(-)
 create mode 100644 net/ipv4/icmp_ipv4.c

diff --git a/include/net/icmp.h b/include/net/icmp.h
index 935ee13d9ae9..85ad655aea5f 100644
--- a/include/net/icmp.h
+++ b/include/net/icmp.h
@@ -57,6 +57,7 @@ static inline void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __b
 
 int icmp_rcv(struct sk_buff *skb);
 int icmp_err(struct sk_buff *skb, u32 info);
+int icmp_init_ipv4(void);
 int icmp_init(void);
 void icmp_out_count(struct net *net, unsigned char type);
 bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr);
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 48ef3fb3b164..651835073a29 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -8,12 +8,13 @@ obj-y     := inetpeer.o protocol.o inet_hashtables.o inet_timewait_sock.o \
 	     tcp_minisocks.o tcp_cong.o tcp_metrics.o tcp_fastopen.o \
 	     tcp_recovery.o tcp_ulp.o tcp_offload.o tcp_plb.o raw.o udp.o \
 	     udp_offload.o af_inet.o inet_fragment.o ping.o ip_tunnel_core.o \
-	     gre_offload.o metrics.o netlink.o nexthop.o udp_tunnel_stub.o
+	     gre_offload.o metrics.o netlink.o nexthop.o udp_tunnel_stub.o \
+	     icmp.o
 
 obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o \
-		      ip_sockglue.o tcp_ipv4.o datagram.o icmp.o arp.o devinet.o \
-		      igmp.o fib_notifier.o ip_output.o fib_frontend.o \
-		      fib_semantics.o fib_trie.o raw_ipv4.o udp_ipv4.o
+		      ip_sockglue.o tcp_ipv4.o datagram.o arp.o devinet.o igmp.o \
+		      fib_notifier.o ip_output.o fib_frontend.o fib_semantics.o \
+		      fib_trie.o raw_ipv4.o udp_ipv4.o icmp_ipv4.o
 
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b3..3c777f6af276 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -96,134 +96,6 @@
 #include <net/l3mdev.h>
 #include <net/addrconf.h>
 #include <net/inet_dscp.h>
-#define CREATE_TRACE_POINTS
-#include <trace/events/icmp.h>
-
-/*
- *	Build xmit assembly blocks
- */
-
-struct icmp_bxm {
-	struct sk_buff *skb;
-	int offset;
-	int data_len;
-
-	struct {
-		struct icmphdr icmph;
-		__be32	       times[3];
-	} data;
-	int head_len;
-
-	/* Must be last as it ends in a flexible-array member. */
-	struct ip_options_rcu replyopts;
-};
-
-/* An array of errno for error messages from dest unreach. */
-/* RFC 1122: 3.2.2.1 States that NET_UNREACH, HOST_UNREACH and SR_FAILED MUST be considered 'transient errs'. */
-
-const struct icmp_err icmp_err_convert[] = {
-	{
-		.errno = ENETUNREACH,	/* ICMP_NET_UNREACH */
-		.fatal = 0,
-	},
-	{
-		.errno = EHOSTUNREACH,	/* ICMP_HOST_UNREACH */
-		.fatal = 0,
-	},
-	{
-		.errno = ENOPROTOOPT	/* ICMP_PROT_UNREACH */,
-		.fatal = 1,
-	},
-	{
-		.errno = ECONNREFUSED,	/* ICMP_PORT_UNREACH */
-		.fatal = 1,
-	},
-	{
-		.errno = EMSGSIZE,	/* ICMP_FRAG_NEEDED */
-		.fatal = 0,
-	},
-	{
-		.errno = EOPNOTSUPP,	/* ICMP_SR_FAILED */
-		.fatal = 0,
-	},
-	{
-		.errno = ENETUNREACH,	/* ICMP_NET_UNKNOWN */
-		.fatal = 1,
-	},
-	{
-		.errno = EHOSTDOWN,	/* ICMP_HOST_UNKNOWN */
-		.fatal = 1,
-	},
-	{
-		.errno = ENONET,	/* ICMP_HOST_ISOLATED */
-		.fatal = 1,
-	},
-	{
-		.errno = ENETUNREACH,	/* ICMP_NET_ANO	*/
-		.fatal = 1,
-	},
-	{
-		.errno = EHOSTUNREACH,	/* ICMP_HOST_ANO */
-		.fatal = 1,
-	},
-	{
-		.errno = ENETUNREACH,	/* ICMP_NET_UNR_TOS */
-		.fatal = 0,
-	},
-	{
-		.errno = EHOSTUNREACH,	/* ICMP_HOST_UNR_TOS */
-		.fatal = 0,
-	},
-	{
-		.errno = EHOSTUNREACH,	/* ICMP_PKT_FILTERED */
-		.fatal = 1,
-	},
-	{
-		.errno = EHOSTUNREACH,	/* ICMP_PREC_VIOLATION */
-		.fatal = 1,
-	},
-	{
-		.errno = EHOSTUNREACH,	/* ICMP_PREC_CUTOFF */
-		.fatal = 1,
-	},
-};
-EXPORT_SYMBOL(icmp_err_convert);
-
-/*
- *	ICMP control array. This specifies what to do with each ICMP.
- */
-
-struct icmp_control {
-	enum skb_drop_reason (*handler)(struct sk_buff *skb);
-	short   error;		/* This ICMP is classed as an error message */
-};
-
-static const struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
-
-static DEFINE_PER_CPU(struct sock *, ipv4_icmp_sk);
-
-/* Called with BH disabled */
-static inline struct sock *icmp_xmit_lock(struct net *net)
-{
-	struct sock *sk;
-
-	sk = this_cpu_read(ipv4_icmp_sk);
-
-	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
-		/* This can happen if the output path signals a
-		 * dst_link_failure() for an outgoing ICMP packet.
-		 */
-		return NULL;
-	}
-	sock_net_set(sk, net);
-	return sk;
-}
-
-static inline void icmp_xmit_unlock(struct sock *sk)
-{
-	sock_net_set(sk, &init_net);
-	spin_unlock(&sk->sk_lock.slock);
-}
 
 /**
  * icmp_global_allow - Are we allowed to send one more ICMP message ?
@@ -274,77 +146,6 @@ void icmp_global_consume(struct net *net)
 		atomic_sub(credits, &net->ipv4.icmp_global_credit);
 }
 
-static bool icmpv4_mask_allow(struct net *net, int type, int code)
-{
-	if (type > NR_ICMP_TYPES)
-		return true;
-
-	/* Don't limit PMTU discovery. */
-	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
-		return true;
-
-	/* Limit if icmp type is enabled in ratemask. */
-	if (!((1 << type) & READ_ONCE(net->ipv4.sysctl_icmp_ratemask)))
-		return true;
-
-	return false;
-}
-
-static bool icmpv4_global_allow(struct net *net, int type, int code,
-				bool *apply_ratelimit)
-{
-	if (icmpv4_mask_allow(net, type, code))
-		return true;
-
-	if (icmp_global_allow(net)) {
-		*apply_ratelimit = true;
-		return true;
-	}
-	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
-	return false;
-}
-
-/*
- *	Send an ICMP frame.
- */
-
-static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
-			       struct flowi4 *fl4, int type, int code,
-			       bool apply_ratelimit)
-{
-	struct dst_entry *dst = &rt->dst;
-	struct inet_peer *peer;
-	struct net_device *dev;
-	int peer_timeout;
-	bool rc = true;
-
-	if (!apply_ratelimit)
-		return true;
-
-	peer_timeout = READ_ONCE(net->ipv4.sysctl_icmp_ratelimit);
-	if (!peer_timeout)
-		goto out;
-
-	/* No rate limit on loopback */
-	rcu_read_lock();
-	dev = dst_dev_rcu(dst);
-	if (dev && (dev->flags & IFF_LOOPBACK))
-		goto out_unlock;
-
-	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
-			       l3mdev_master_ifindex_rcu(dev));
-	rc = inet_peer_xrlim_allow(peer, peer_timeout);
-
-out_unlock:
-	rcu_read_unlock();
-out:
-	if (!rc)
-		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
-	else
-		icmp_global_consume(net);
-	return rc;
-}
-
 /*
  *	Maintain the counters used in the SNMP statistics for outgoing ICMP
  */
@@ -354,921 +155,6 @@ void icmp_out_count(struct net *net, unsigned char type)
 	ICMP_INC_STATS(net, ICMP_MIB_OUTMSGS);
 }
 
-/*
- *	Checksum each fragment, and on the first include the headers and final
- *	checksum.
- */
-static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
-			  struct sk_buff *skb)
-{
-	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	__wsum csum;
-
-	icmp_param = from;
-
-	csum = skb_copy_and_csum_bits(icmp_param->skb,
-				      icmp_param->offset + offset,
-				      to, len);
-
-	skb->csum = csum_block_add(skb->csum, csum, odd);
-	if (icmp_param->data.icmph.type <= NR_ICMP_TYPES &&
-	    icmp_pointers[array_index_nospec(icmp_param->data.icmph.type,
-					     NR_ICMP_TYPES + 1)].error)
-		nf_ct_attach(skb, icmp_param->skb);
-	return 0;
-}
-
-static void icmp_push_reply(struct sock *sk,
-			    struct icmp_bxm *icmp_param,
-			    struct flowi4 *fl4,
-			    struct ipcm_cookie *ipc, struct rtable **rt)
-{
-	struct sk_buff *skb;
-
-	if (ip_append_data(sk, fl4, icmp_glue_bits, icmp_param,
-			   icmp_param->data_len+icmp_param->head_len,
-			   icmp_param->head_len,
-			   ipc, rt, MSG_DONTWAIT) < 0) {
-		__ICMP_INC_STATS(sock_net(sk), ICMP_MIB_OUTERRORS);
-		ip_flush_pending_frames(sk);
-	} else if ((skb = skb_peek(&sk->sk_write_queue)) != NULL) {
-		struct icmphdr *icmph = icmp_hdr(skb);
-		__wsum csum;
-		struct sk_buff *skb1;
-
-		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
-						 (char *)icmph,
-						 icmp_param->head_len);
-		skb_queue_walk(&sk->sk_write_queue, skb1) {
-			csum = csum_add(csum, skb1->csum);
-		}
-		icmph->checksum = csum_fold(csum);
-		skb->ip_summed = CHECKSUM_NONE;
-		ip_push_pending_frames(sk, fl4);
-	}
-}
-
-/*
- *	Driving logic for building and sending ICMP messages.
- */
-
-static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
-{
-	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net_rcu(rt->dst.dev);
-	bool apply_ratelimit = false;
-	struct ipcm_cookie ipc;
-	struct flowi4 fl4;
-	struct sock *sk;
-	__be32 daddr, saddr;
-	u32 mark = IP4_REPLY_MARK(net, skb->mark);
-	int type = icmp_param->data.icmph.type;
-	int code = icmp_param->data.icmph.code;
-
-	if (ip_options_echo(net, &icmp_param->replyopts.opt, skb))
-		return;
-
-	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
-	local_bh_disable();
-
-	/* is global icmp_msgs_per_sec exhausted ? */
-	if (!icmpv4_global_allow(net, type, code, &apply_ratelimit))
-		goto out_bh_enable;
-
-	sk = icmp_xmit_lock(net);
-	if (!sk)
-		goto out_bh_enable;
-
-	icmp_param->data.icmph.checksum = 0;
-
-	ipcm_init(&ipc);
-	ipc.tos = ip_hdr(skb)->tos;
-	ipc.sockc.mark = mark;
-	daddr = ipc.addr = ip_hdr(skb)->saddr;
-	saddr = fib_compute_spec_dst(skb);
-
-	if (icmp_param->replyopts.opt.optlen) {
-		ipc.opt = &icmp_param->replyopts;
-		if (ipc.opt->opt.srr)
-			daddr = icmp_param->replyopts.opt.faddr;
-	}
-	memset(&fl4, 0, sizeof(fl4));
-	fl4.daddr = daddr;
-	fl4.saddr = saddr;
-	fl4.flowi4_mark = mark;
-	fl4.flowi4_uid = sock_net_uid(net, NULL);
-	fl4.flowi4_dscp = ip4h_dscp(ip_hdr(skb));
-	fl4.flowi4_proto = IPPROTO_ICMP;
-	fl4.flowi4_oif = l3mdev_master_ifindex(skb->dev);
-	security_skb_classify_flow(skb, flowi4_to_flowi_common(&fl4));
-	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
-		goto out_unlock;
-	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
-		icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
-	ip_rt_put(rt);
-out_unlock:
-	icmp_xmit_unlock(sk);
-out_bh_enable:
-	local_bh_enable();
-}
-
-/*
- * The device used for looking up which routing table to use for sending an ICMP
- * error is preferably the source whenever it is set, which should ensure the
- * icmp error can be sent to the source host, else lookup using the routing
- * table of the destination device, else use the main routing table (index 0).
- */
-static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
-{
-	struct net_device *dev = skb->dev;
-	const struct dst_entry *dst;
-
-	if (dev)
-		return dev;
-	dst = skb_dst(skb);
-	return dst ? dst_dev(dst) : NULL;
-}
-
-static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
-					struct sk_buff *skb_in,
-					const struct iphdr *iph, __be32 saddr,
-					dscp_t dscp, u32 mark, int type,
-					int code, struct icmp_bxm *param)
-{
-	struct net_device *route_lookup_dev;
-	struct dst_entry *dst, *dst2;
-	struct rtable *rt, *rt2;
-	struct flowi4 fl4_dec;
-	int err;
-
-	memset(fl4, 0, sizeof(*fl4));
-	fl4->daddr = (param->replyopts.opt.srr ?
-		      param->replyopts.opt.faddr : iph->saddr);
-	fl4->saddr = saddr;
-	fl4->flowi4_mark = mark;
-	fl4->flowi4_uid = sock_net_uid(net, NULL);
-	fl4->flowi4_dscp = dscp;
-	fl4->flowi4_proto = IPPROTO_ICMP;
-	fl4->fl4_icmp_type = type;
-	fl4->fl4_icmp_code = code;
-	route_lookup_dev = icmp_get_route_lookup_dev(skb_in);
-	fl4->flowi4_oif = l3mdev_master_ifindex(route_lookup_dev);
-
-	security_skb_classify_flow(skb_in, flowi4_to_flowi_common(fl4));
-	rt = ip_route_output_key_hash(net, fl4, skb_in);
-	if (IS_ERR(rt))
-		return rt;
-
-	/* No need to clone since we're just using its address. */
-	rt2 = rt;
-
-	dst = xfrm_lookup(net, &rt->dst,
-			  flowi4_to_flowi(fl4), NULL, 0);
-	rt = dst_rtable(dst);
-	if (!IS_ERR(dst)) {
-		if (rt != rt2)
-			return rt;
-		if (inet_addr_type_dev_table(net, route_lookup_dev,
-					     fl4->daddr) == RTN_LOCAL)
-			return rt;
-	} else if (PTR_ERR(dst) == -EPERM) {
-		rt = NULL;
-	} else {
-		return rt;
-	}
-	err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
-	if (err)
-		goto relookup_failed;
-
-	if (inet_addr_type_dev_table(net, route_lookup_dev,
-				     fl4_dec.saddr) == RTN_LOCAL) {
-		rt2 = __ip_route_output_key(net, &fl4_dec);
-		if (IS_ERR(rt2))
-			err = PTR_ERR(rt2);
-	} else {
-		struct flowi4 fl4_2 = {};
-		unsigned long orefdst;
-
-		fl4_2.daddr = fl4_dec.saddr;
-		rt2 = ip_route_output_key(net, &fl4_2);
-		if (IS_ERR(rt2)) {
-			err = PTR_ERR(rt2);
-			goto relookup_failed;
-		}
-		/* Ugh! */
-		orefdst = skb_dstref_steal(skb_in);
-		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     dscp, rt2->dst.dev) ? -EINVAL : 0;
-
-		dst_release(&rt2->dst);
-		rt2 = skb_rtable(skb_in);
-		/* steal dst entry from skb_in, don't drop refcnt */
-		skb_dstref_steal(skb_in);
-		skb_dstref_restore(skb_in, orefdst);
-
-		/*
-		 * At this point, fl4_dec.daddr should NOT be local (we
-		 * checked fl4_dec.saddr above). However, a race condition
-		 * may occur if the address is added to the interface
-		 * concurrently. In that case, ip_route_input() returns a
-		 * LOCAL route with dst.output=ip_rt_bug, which must not
-		 * be used for output.
-		 */
-		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
-			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
-					     &fl4_dec.daddr, &fl4_dec.saddr);
-			dst_release(&rt2->dst);
-			err = -EINVAL;
-		}
-	}
-
-	if (err)
-		goto relookup_failed;
-
-	dst2 = xfrm_lookup(net, &rt2->dst, flowi4_to_flowi(&fl4_dec), NULL,
-			   XFRM_LOOKUP_ICMP);
-	rt2 = dst_rtable(dst2);
-	if (!IS_ERR(dst2)) {
-		dst_release(&rt->dst);
-		rt = rt2;
-	} else if (PTR_ERR(dst2) == -EPERM) {
-		if (rt)
-			dst_release(&rt->dst);
-		return rt2;
-	} else {
-		err = PTR_ERR(dst2);
-		goto relookup_failed;
-	}
-	return rt;
-
-relookup_failed:
-	if (rt)
-		return rt;
-	return ERR_PTR(err);
-}
-
-struct icmp_ext_iio_addr4_subobj {
-	__be16 afi;
-	__be16 reserved;
-	__be32 addr4;
-};
-
-static unsigned int icmp_ext_iio_len(void)
-{
-	return sizeof(struct icmp_extobj_hdr) +
-		/* ifIndex */
-		sizeof(__be32) +
-		/* Interface Address Sub-Object */
-		sizeof(struct icmp_ext_iio_addr4_subobj) +
-		/* Interface Name Sub-Object. Length must be a multiple of 4
-		 * bytes.
-		 */
-		ALIGN(sizeof(struct icmp_ext_iio_name_subobj), 4) +
-		/* MTU */
-		sizeof(__be32);
-}
-
-static unsigned int icmp_ext_max_len(u8 ext_objs)
-{
-	unsigned int ext_max_len;
-
-	ext_max_len = sizeof(struct icmp_ext_hdr);
-
-	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
-		ext_max_len += icmp_ext_iio_len();
-
-	return ext_max_len;
-}
-
-static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
-{
-	struct in_device *in_dev;
-	struct in_ifaddr *ifa;
-
-	in_dev = __in_dev_get_rcu(dev);
-	if (!in_dev)
-		return 0;
-
-	/* It is unclear from RFC 5837 which IP address should be chosen, but
-	 * it makes sense to choose a global unicast address.
-	 */
-	in_dev_for_each_ifa_rcu(ifa, in_dev) {
-		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
-			continue;
-		if (ifa->ifa_scope != RT_SCOPE_UNIVERSE ||
-		    ipv4_is_multicast(ifa->ifa_address))
-			continue;
-		return ifa->ifa_address;
-	}
-
-	return 0;
-}
-
-static void icmp_ext_iio_iif_append(struct net *net, struct sk_buff *skb,
-				    int iif)
-{
-	struct icmp_ext_iio_name_subobj *name_subobj;
-	struct icmp_extobj_hdr *objh;
-	struct net_device *dev;
-	__be32 data;
-
-	if (!iif)
-		return;
-
-	/* Add the fields in the order specified by RFC 5837. */
-	objh = skb_put(skb, sizeof(*objh));
-	objh->class_num = ICMP_EXT_OBJ_CLASS_IIO;
-	objh->class_type = ICMP_EXT_CTYPE_IIO_ROLE(ICMP_EXT_CTYPE_IIO_ROLE_IIF);
-
-	data = htonl(iif);
-	skb_put_data(skb, &data, sizeof(__be32));
-	objh->class_type |= ICMP_EXT_CTYPE_IIO_IFINDEX;
-
-	rcu_read_lock();
-
-	dev = dev_get_by_index_rcu(net, iif);
-	if (!dev)
-		goto out;
-
-	data = icmp_ext_iio_addr4_find(dev);
-	if (data) {
-		struct icmp_ext_iio_addr4_subobj *addr4_subobj;
-
-		addr4_subobj = skb_put_zero(skb, sizeof(*addr4_subobj));
-		addr4_subobj->afi = htons(ICMP_AFI_IP);
-		addr4_subobj->addr4 = data;
-		objh->class_type |= ICMP_EXT_CTYPE_IIO_IPADDR;
-	}
-
-	name_subobj = skb_put_zero(skb, ALIGN(sizeof(*name_subobj), 4));
-	name_subobj->len = ALIGN(sizeof(*name_subobj), 4);
-	netdev_copy_name(dev, name_subobj->name);
-	objh->class_type |= ICMP_EXT_CTYPE_IIO_NAME;
-
-	data = htonl(READ_ONCE(dev->mtu));
-	skb_put_data(skb, &data, sizeof(__be32));
-	objh->class_type |= ICMP_EXT_CTYPE_IIO_MTU;
-
-out:
-	rcu_read_unlock();
-	objh->length = htons(skb_tail_pointer(skb) - (unsigned char *)objh);
-}
-
-static void icmp_ext_objs_append(struct net *net, struct sk_buff *skb,
-				 u8 ext_objs, int iif)
-{
-	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
-		icmp_ext_iio_iif_append(net, skb, iif);
-}
-
-static struct sk_buff *
-icmp_ext_append(struct net *net, struct sk_buff *skb_in, struct icmphdr *icmph,
-		unsigned int room, int iif)
-{
-	unsigned int payload_len, ext_max_len, ext_len;
-	struct icmp_ext_hdr *ext_hdr;
-	struct sk_buff *skb;
-	u8 ext_objs;
-	int nhoff;
-
-	switch (icmph->type) {
-	case ICMP_DEST_UNREACH:
-	case ICMP_TIME_EXCEEDED:
-	case ICMP_PARAMETERPROB:
-		break;
-	default:
-		return NULL;
-	}
-
-	ext_objs = READ_ONCE(net->ipv4.sysctl_icmp_errors_extension_mask);
-	if (!ext_objs)
-		return NULL;
-
-	ext_max_len = icmp_ext_max_len(ext_objs);
-	if (ICMP_EXT_ORIG_DGRAM_MIN_LEN + ext_max_len > room)
-		return NULL;
-
-	skb = skb_clone(skb_in, GFP_ATOMIC);
-	if (!skb)
-		return NULL;
-
-	nhoff = skb_network_offset(skb);
-	payload_len = min(skb->len - nhoff, ICMP_EXT_ORIG_DGRAM_MIN_LEN);
-
-	if (!pskb_network_may_pull(skb, payload_len))
-		goto free_skb;
-
-	if (pskb_trim(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN) ||
-	    __skb_put_padto(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN, false))
-		goto free_skb;
-
-	if (pskb_expand_head(skb, 0, ext_max_len, GFP_ATOMIC))
-		goto free_skb;
-
-	ext_hdr = skb_put_zero(skb, sizeof(*ext_hdr));
-	ext_hdr->version = ICMP_EXT_VERSION_2;
-
-	icmp_ext_objs_append(net, skb, ext_objs, iif);
-
-	/* Do not send an empty extension structure. */
-	ext_len = skb_tail_pointer(skb) - (unsigned char *)ext_hdr;
-	if (ext_len == sizeof(*ext_hdr))
-		goto free_skb;
-
-	ext_hdr->checksum = ip_compute_csum(ext_hdr, ext_len);
-	/* The length of the original datagram in 32-bit words (RFC 4884). */
-	icmph->un.reserved[1] = ICMP_EXT_ORIG_DGRAM_MIN_LEN / sizeof(u32);
-
-	return skb;
-
-free_skb:
-	consume_skb(skb);
-	return NULL;
-}
-
-/*
- *	Send an ICMP message in response to a situation
- *
- *	RFC 1122: 3.2.2	MUST send at least the IP header and 8 bytes of header.
- *		  MAY send more (we do).
- *			MUST NOT change this header information.
- *			MUST NOT reply to a multicast/broadcast IP address.
- *			MUST NOT reply to a multicast/broadcast MAC address.
- *			MUST reply to only the first fragment.
- */
-
-void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
-		 const struct inet_skb_parm *parm)
-{
-	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	struct iphdr *iph;
-	int room;
-	struct rtable *rt = skb_rtable(skb_in);
-	bool apply_ratelimit = false;
-	struct sk_buff *ext_skb;
-	struct ipcm_cookie ipc;
-	struct flowi4 fl4;
-	__be32 saddr;
-	u8  tos;
-	u32 mark;
-	struct net *net;
-	struct sock *sk;
-
-	if (!rt)
-		return;
-
-	rcu_read_lock();
-
-	if (rt->dst.dev)
-		net = dev_net_rcu(rt->dst.dev);
-	else if (skb_in->dev)
-		net = dev_net_rcu(skb_in->dev);
-	else
-		goto out;
-
-	/*
-	 *	Find the original header. It is expected to be valid, of course.
-	 *	Check this, icmp_send is called from the most obscure devices
-	 *	sometimes.
-	 */
-	iph = ip_hdr(skb_in);
-
-	if ((u8 *)iph < skb_in->head ||
-	    (skb_network_header(skb_in) + sizeof(*iph)) >
-	    skb_tail_pointer(skb_in))
-		goto out;
-
-	/*
-	 *	No replies to physical multicast/broadcast
-	 */
-	if (skb_in->pkt_type != PACKET_HOST)
-		goto out;
-
-	/*
-	 *	Now check at the protocol level
-	 */
-	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
-		goto out;
-
-	/*
-	 *	Only reply to fragment 0. We byte re-order the constant
-	 *	mask for efficiency.
-	 */
-	if (iph->frag_off & htons(IP_OFFSET))
-		goto out;
-
-	/*
-	 *	If we send an ICMP error to an ICMP error a mess would result..
-	 */
-	if (icmp_pointers[type].error) {
-		/*
-		 *	We are an error, check if we are replying to an
-		 *	ICMP error
-		 */
-		if (iph->protocol == IPPROTO_ICMP) {
-			u8 _inner_type, *itp;
-
-			itp = skb_header_pointer(skb_in,
-						 skb_network_header(skb_in) +
-						 (iph->ihl << 2) +
-						 offsetof(struct icmphdr,
-							  type) -
-						 skb_in->data,
-						 sizeof(_inner_type),
-						 &_inner_type);
-			if (!itp)
-				goto out;
-
-			/*
-			 *	Assume any unknown ICMP type is an error. This
-			 *	isn't specified by the RFC, but think about it..
-			 */
-			if (*itp > NR_ICMP_TYPES ||
-			    icmp_pointers[*itp].error)
-				goto out;
-		}
-	}
-
-	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
-	local_bh_disable();
-
-	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
-	 * incoming dev is loopback.  If outgoing dev change to not be
-	 * loopback, then peer ratelimit still work (in icmpv4_xrlim_allow)
-	 */
-	if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
-	      !icmpv4_global_allow(net, type, code, &apply_ratelimit))
-		goto out_bh_enable;
-
-	sk = icmp_xmit_lock(net);
-	if (!sk)
-		goto out_bh_enable;
-
-	/*
-	 *	Construct source address and options.
-	 */
-
-	saddr = iph->daddr;
-	if (!(rt->rt_flags & RTCF_LOCAL)) {
-		struct net_device *dev = NULL;
-
-		rcu_read_lock();
-		if (rt_is_input_route(rt) &&
-		    READ_ONCE(net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr))
-			dev = dev_get_by_index_rcu(net, parm->iif ? parm->iif :
-						   inet_iif(skb_in));
-
-		if (dev)
-			saddr = inet_select_addr(dev, iph->saddr,
-						 RT_SCOPE_LINK);
-		else
-			saddr = 0;
-		rcu_read_unlock();
-	}
-
-	tos = icmp_pointers[type].error ? (RT_TOS(iph->tos) |
-					   IPTOS_PREC_INTERNETCONTROL) :
-					   iph->tos;
-	mark = IP4_REPLY_MARK(net, skb_in->mark);
-
-	if (__ip_options_echo(net, &icmp_param->replyopts.opt, skb_in,
-			      &parm->opt))
-		goto out_unlock;
-
-
-	/*
-	 *	Prepare data for ICMP header.
-	 */
-
-	icmp_param->data.icmph.type	 = type;
-	icmp_param->data.icmph.code	 = code;
-	icmp_param->data.icmph.un.gateway = info;
-	icmp_param->data.icmph.checksum	 = 0;
-	icmp_param->skb	  = skb_in;
-	icmp_param->offset = skb_network_offset(skb_in);
-	ipcm_init(&ipc);
-	ipc.tos = tos;
-	ipc.addr = iph->saddr;
-	ipc.opt = &icmp_param->replyopts;
-	ipc.sockc.mark = mark;
-
-	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
-			       inet_dsfield_to_dscp(tos), mark, type, code,
-			       icmp_param);
-	if (IS_ERR(rt))
-		goto out_unlock;
-
-	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
-		goto ende;
-
-	/* peer icmp_ratelimit */
-	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
-		goto ende;
-
-	/* RFC says return as much as we can without exceeding 576 bytes. */
-
-	room = dst4_mtu(&rt->dst);
-	if (room > 576)
-		room = 576;
-	room -= sizeof(struct iphdr) + icmp_param->replyopts.opt.optlen;
-	room -= sizeof(struct icmphdr);
-	/* Guard against tiny mtu. We need to include at least one
-	 * IP network header for this message to make any sense.
-	 */
-	if (room <= (int)sizeof(struct iphdr))
-		goto ende;
-
-	ext_skb = icmp_ext_append(net, skb_in, &icmp_param->data.icmph, room,
-				  parm->iif);
-	if (ext_skb)
-		icmp_param->skb = ext_skb;
-
-	icmp_param->data_len = icmp_param->skb->len - icmp_param->offset;
-	if (icmp_param->data_len > room)
-		icmp_param->data_len = room;
-	icmp_param->head_len = sizeof(struct icmphdr);
-
-	/* if we don't have a source address at this point, fall back to the
-	 * dummy address instead of sending out a packet with a source address
-	 * of 0.0.0.0
-	 */
-	if (!fl4.saddr)
-		fl4.saddr = htonl(INADDR_DUMMY);
-
-	trace_icmp_send(skb_in, type, code);
-
-	icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
-
-	if (ext_skb)
-		consume_skb(ext_skb);
-ende:
-	ip_rt_put(rt);
-out_unlock:
-	icmp_xmit_unlock(sk);
-out_bh_enable:
-	local_bh_enable();
-out:
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(__icmp_send);
-
-#if IS_ENABLED(CONFIG_NF_NAT)
-#include <net/netfilter/nf_conntrack.h>
-void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
-{
-	struct sk_buff *cloned_skb = NULL;
-	enum ip_conntrack_info ctinfo;
-	enum ip_conntrack_dir dir;
-	struct inet_skb_parm parm;
-	struct nf_conn *ct;
-	__be32 orig_ip;
-
-	memset(&parm, 0, sizeof(parm));
-	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
-		__icmp_send(skb_in, type, code, info, &parm);
-		return;
-	}
-
-	if (skb_shared(skb_in))
-		skb_in = cloned_skb = skb_clone(skb_in, GFP_ATOMIC);
-
-	if (unlikely(!skb_in || skb_network_header(skb_in) < skb_in->head ||
-	    (skb_network_header(skb_in) + sizeof(struct iphdr)) >
-	    skb_tail_pointer(skb_in) || skb_ensure_writable(skb_in,
-	    skb_network_offset(skb_in) + sizeof(struct iphdr))))
-		goto out;
-
-	orig_ip = ip_hdr(skb_in)->saddr;
-	dir = CTINFO2DIR(ctinfo);
-	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
-	__icmp_send(skb_in, type, code, info, &parm);
-	ip_hdr(skb_in)->saddr = orig_ip;
-out:
-	consume_skb(cloned_skb);
-}
-EXPORT_SYMBOL(icmp_ndo_send);
-#endif
-
-static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
-{
-	const struct iphdr *iph = (const struct iphdr *)skb->data;
-	const struct net_protocol *ipprot;
-	int protocol = iph->protocol;
-
-	/* Checkin full IP header plus 8 bytes of protocol to
-	 * avoid additional coding at protocol handlers.
-	 */
-	if (!pskb_may_pull(skb, iph->ihl * 4 + 8))
-		goto out;
-
-	/* IPPROTO_RAW sockets are not supposed to receive anything. */
-	if (protocol == IPPROTO_RAW)
-		goto out;
-
-	raw_icmp_error(skb, protocol, info);
-
-	ipprot = rcu_dereference(inet_protos[protocol]);
-	if (ipprot && ipprot->err_handler)
-		ipprot->err_handler(skb, info);
-	return;
-
-out:
-	__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
-}
-
-static bool icmp_tag_validation(int proto)
-{
-	const struct net_protocol *ipprot;
-	bool ok;
-
-	rcu_read_lock();
-	ipprot = rcu_dereference(inet_protos[proto]);
-	ok = ipprot ? ipprot->icmp_strict_tag_validation : false;
-	rcu_read_unlock();
-	return ok;
-}
-
-/*
- *	Handle ICMP_DEST_UNREACH, ICMP_TIME_EXCEEDED, ICMP_QUENCH, and
- *	ICMP_PARAMETERPROB.
- */
-
-static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
-{
-	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
-	const struct iphdr *iph;
-	struct icmphdr *icmph;
-	struct net *net;
-	u32 info = 0;
-
-	net = skb_dst_dev_net_rcu(skb);
-
-	/*
-	 *	Incomplete header ?
-	 * 	Only checks for the IP header, there should be an
-	 *	additional check for longer headers in upper levels.
-	 */
-
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto out_err;
-
-	icmph = icmp_hdr(skb);
-	iph   = (const struct iphdr *)skb->data;
-
-	if (iph->ihl < 5)  { /* Mangled header, drop. */
-		reason = SKB_DROP_REASON_IP_INHDR;
-		goto out_err;
-	}
-
-	switch (icmph->type) {
-	case ICMP_DEST_UNREACH:
-		switch (icmph->code & 15) {
-		case ICMP_NET_UNREACH:
-		case ICMP_HOST_UNREACH:
-		case ICMP_PROT_UNREACH:
-		case ICMP_PORT_UNREACH:
-			break;
-		case ICMP_FRAG_NEEDED:
-			/* for documentation of the ip_no_pmtu_disc
-			 * values please see
-			 * Documentation/networking/ip-sysctl.rst
-			 */
-			switch (READ_ONCE(net->ipv4.sysctl_ip_no_pmtu_disc)) {
-			default:
-				net_dbg_ratelimited("%pI4: fragmentation needed and DF set\n",
-						    &iph->daddr);
-				break;
-			case 2:
-				goto out;
-			case 3:
-				if (!icmp_tag_validation(iph->protocol))
-					goto out;
-				fallthrough;
-			case 0:
-				info = ntohs(icmph->un.frag.mtu);
-			}
-			break;
-		case ICMP_SR_FAILED:
-			net_dbg_ratelimited("%pI4: Source Route Failed\n",
-					    &iph->daddr);
-			break;
-		default:
-			break;
-		}
-		if (icmph->code > NR_ICMP_UNREACH)
-			goto out;
-		break;
-	case ICMP_PARAMETERPROB:
-		info = ntohl(icmph->un.gateway) >> 24;
-		break;
-	case ICMP_TIME_EXCEEDED:
-		__ICMP_INC_STATS(net, ICMP_MIB_INTIMEEXCDS);
-		if (icmph->code == ICMP_EXC_FRAGTIME)
-			goto out;
-		break;
-	}
-
-	/*
-	 *	Throw it at our lower layers
-	 *
-	 *	RFC 1122: 3.2.2 MUST extract the protocol ID from the passed
-	 *		  header.
-	 *	RFC 1122: 3.2.2.1 MUST pass ICMP unreach messages to the
-	 *		  transport layer.
-	 *	RFC 1122: 3.2.2.2 MUST pass ICMP time expired messages to
-	 *		  transport layer.
-	 */
-
-	/*
-	 *	Check the other end isn't violating RFC 1122. Some routers send
-	 *	bogus responses to broadcast frames. If you see this message
-	 *	first check your netmask matches at both ends, if it does then
-	 *	get the other vendor to fix their kit.
-	 */
-
-	if (!READ_ONCE(net->ipv4.sysctl_icmp_ignore_bogus_error_responses) &&
-	    inet_addr_type_dev_table(net, skb->dev, iph->daddr) == RTN_BROADCAST) {
-		net_warn_ratelimited("%pI4 sent an invalid ICMP type %u, code %u error to a broadcast: %pI4 on %s\n",
-				     &ip_hdr(skb)->saddr,
-				     icmph->type, icmph->code,
-				     &iph->daddr, skb->dev->name);
-		goto out;
-	}
-
-	icmp_socket_deliver(skb, info);
-
-out:
-	return reason;
-out_err:
-	__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
-	return reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
-}
-
-
-/*
- *	Handle ICMP_REDIRECT.
- */
-
-static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)
-{
-	if (skb->len < sizeof(struct iphdr)) {
-		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
-		return SKB_DROP_REASON_PKT_TOO_SMALL;
-	}
-
-	if (!pskb_may_pull(skb, sizeof(struct iphdr))) {
-		/* there aught to be a stat */
-		return SKB_DROP_REASON_NOMEM;
-	}
-
-	icmp_socket_deliver(skb, ntohl(icmp_hdr(skb)->un.gateway));
-	return SKB_NOT_DROPPED_YET;
-}
-
-/*
- *	Handle ICMP_ECHO ("ping") and ICMP_EXT_ECHO ("PROBE") requests.
- *
- *	RFC 1122: 3.2.2.6 MUST have an echo server that answers ICMP echo
- *		  requests.
- *	RFC 1122: 3.2.2.6 Data received in the ICMP_ECHO request MUST be
- *		  included in the reply.
- *	RFC 1812: 4.3.3.6 SHOULD have a config option for silently ignoring
- *		  echo requests, MUST have default=NOT.
- *	RFC 8335: 8 MUST have a config option to enable/disable ICMP
- *		  Extended Echo Functionality, MUST be disabled by default
- *	See also WRT handling of options once they are done and working.
- */
-
-static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
-{
-	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	struct net *net;
-
-	net = skb_dst_dev_net_rcu(skb);
-	/* should there be an ICMP stat for ignored echos? */
-	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
-		return SKB_NOT_DROPPED_YET;
-
-	icmp_param->data.icmph	   = *icmp_hdr(skb);
-	icmp_param->skb		   = skb;
-	icmp_param->offset	   = 0;
-	icmp_param->data_len	   = skb->len;
-	icmp_param->head_len	   = sizeof(struct icmphdr);
-
-	if (icmp_param->data.icmph.type == ICMP_ECHO)
-		icmp_param->data.icmph.type = ICMP_ECHOREPLY;
-	else if (!icmp_build_probe(skb, &icmp_param->data.icmph))
-		return SKB_NOT_DROPPED_YET;
-
-	icmp_reply(icmp_param, skb);
-	return SKB_NOT_DROPPED_YET;
-}
-
 /*	Helper for icmp_echo and icmpv6_echo_reply.
  *	Searches for net_device that matches PROBE interface identifier
  *		and builds PROBE reply message in icmphdr.
@@ -1339,11 +225,13 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 				 iio->ident.addr.ctype3_hdr.addrlen)
 			goto send_mal_query;
 		switch (ntohs(iio->ident.addr.ctype3_hdr.afi)) {
+#if IS_ENABLED(CONFIG_IPV4)
 		case ICMP_AFI_IP:
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in_addr))
 				goto send_mal_query;
 			dev = ip_dev_find(net, iio->ident.addr.ip_addr.ipv4_addr);
 			break;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 		case ICMP_AFI_IP6:
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
@@ -1383,169 +271,6 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	return true;
 }
 
-/*
- *	Handle ICMP Timestamp requests.
- *	RFC 1122: 3.2.2.8 MAY implement ICMP timestamp requests.
- *		  SHOULD be in the kernel for minimum random latency.
- *		  MUST be accurate to a few minutes.
- *		  MUST be updated at least at 15Hz.
- */
-static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
-{
-	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	/*
-	 *	Too short.
-	 */
-	if (skb->len < 4)
-		goto out_err;
-
-	/*
-	 *	Fill in the current time as ms since midnight UT:
-	 */
-	icmp_param->data.times[1] = inet_current_timestamp();
-	icmp_param->data.times[2] = icmp_param->data.times[1];
-
-	BUG_ON(skb_copy_bits(skb, 0, &icmp_param->data.times[0], 4));
-
-	icmp_param->data.icmph	   = *icmp_hdr(skb);
-	icmp_param->data.icmph.type = ICMP_TIMESTAMPREPLY;
-	icmp_param->data.icmph.code = 0;
-	icmp_param->skb		   = skb;
-	icmp_param->offset	   = 0;
-	icmp_param->data_len	   = 0;
-	icmp_param->head_len	   = sizeof(struct icmphdr) + 12;
-	icmp_reply(icmp_param, skb);
-	return SKB_NOT_DROPPED_YET;
-
-out_err:
-	__ICMP_INC_STATS(skb_dst_dev_net_rcu(skb), ICMP_MIB_INERRORS);
-	return SKB_DROP_REASON_PKT_TOO_SMALL;
-}
-
-static enum skb_drop_reason icmp_discard(struct sk_buff *skb)
-{
-	/* pretend it was a success */
-	return SKB_NOT_DROPPED_YET;
-}
-
-/*
- *	Deal with incoming ICMP packets.
- */
-int icmp_rcv(struct sk_buff *skb)
-{
-	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net_rcu(rt->dst.dev);
-	struct icmphdr *icmph;
-
-	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
-		struct sec_path *sp = skb_sec_path(skb);
-		int nh;
-
-		if (!(sp && sp->xvec[sp->len - 1]->props.flags &
-				 XFRM_STATE_ICMP)) {
-			reason = SKB_DROP_REASON_XFRM_POLICY;
-			goto drop;
-		}
-
-		if (!pskb_may_pull(skb, sizeof(*icmph) + sizeof(struct iphdr)))
-			goto drop;
-
-		nh = skb_network_offset(skb);
-		skb_set_network_header(skb, sizeof(*icmph));
-
-		if (!xfrm4_policy_check_reverse(NULL, XFRM_POLICY_IN,
-						skb)) {
-			reason = SKB_DROP_REASON_XFRM_POLICY;
-			goto drop;
-		}
-
-		skb_set_network_header(skb, nh);
-	}
-
-	__ICMP_INC_STATS(net, ICMP_MIB_INMSGS);
-
-	if (skb_checksum_simple_validate(skb))
-		goto csum_error;
-
-	if (!pskb_pull(skb, sizeof(*icmph)))
-		goto error;
-
-	icmph = icmp_hdr(skb);
-
-	ICMPMSGIN_INC_STATS(net, icmph->type);
-
-	/* Check for ICMP Extended Echo (PROBE) messages */
-	if (icmph->type == ICMP_EXT_ECHO) {
-		/* We can't use icmp_pointers[].handler() because it is an array of
-		 * size NR_ICMP_TYPES + 1 (19 elements) and PROBE has code 42.
-		 */
-		reason = icmp_echo(skb);
-		goto reason_check;
-	}
-
-	/*
-	 *	Parse the ICMP message
-	 */
-
-	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST)) {
-		/*
-		 *	RFC 1122: 3.2.2.6 An ICMP_ECHO to broadcast MAY be
-		 *	  silently ignored (we let user decide with a sysctl).
-		 *	RFC 1122: 3.2.2.8 An ICMP_TIMESTAMP MAY be silently
-		 *	  discarded if to broadcast/multicast.
-		 */
-		if ((icmph->type == ICMP_ECHO ||
-		     icmph->type == ICMP_TIMESTAMP) &&
-		    READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_broadcasts)) {
-			reason = SKB_DROP_REASON_INVALID_PROTO;
-			goto error;
-		}
-		if (icmph->type != ICMP_ECHO &&
-		    icmph->type != ICMP_TIMESTAMP &&
-		    icmph->type != ICMP_ADDRESS &&
-		    icmph->type != ICMP_ADDRESSREPLY) {
-			reason = SKB_DROP_REASON_INVALID_PROTO;
-			goto error;
-		}
-	}
-
-	if (icmph->type == ICMP_EXT_ECHOREPLY ||
-	    icmph->type == ICMP_ECHOREPLY) {
-		reason = ping_rcv(skb);
-		return reason ? NET_RX_DROP : NET_RX_SUCCESS;
-	}
-
-	/*
-	 *	18 is the highest 'known' ICMP type. Anything else is a mystery
-	 *
-	 *	RFC 1122: 3.2.2  Unknown ICMP messages types MUST be silently
-	 *		  discarded.
-	 */
-	if (icmph->type > NR_ICMP_TYPES) {
-		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
-		goto error;
-	}
-
-	reason = icmp_pointers[icmph->type].handler(skb);
-reason_check:
-	if (!reason)  {
-		consume_skb(skb);
-		return NET_RX_SUCCESS;
-	}
-
-drop:
-	kfree_skb_reason(skb, reason);
-	return NET_RX_DROP;
-csum_error:
-	reason = SKB_DROP_REASON_ICMP_CSUM;
-	__ICMP_INC_STATS(net, ICMP_MIB_CSUMERRORS);
-error:
-	__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
-	goto drop;
-}
-
 static bool ip_icmp_error_rfc4884_validate(const struct sk_buff *skb, int off)
 {
 	struct icmp_extobj_hdr *objh, _objh;
@@ -1604,106 +329,6 @@ void ip_icmp_error_rfc4884(const struct sk_buff *skb,
 		out->flags |= SO_EE_RFC4884_FLAG_INVALID;
 }
 
-int icmp_err(struct sk_buff *skb, u32 info)
-{
-	struct iphdr *iph = (struct iphdr *)skb->data;
-	int offset = iph->ihl<<2;
-	struct icmphdr *icmph = (struct icmphdr *)(skb->data + offset);
-	struct net *net = dev_net_rcu(skb->dev);
-	int type = icmp_hdr(skb)->type;
-	int code = icmp_hdr(skb)->code;
-
-	/*
-	 * Use ping_err to handle all icmp errors except those
-	 * triggered by ICMP_ECHOREPLY which sent from kernel.
-	 */
-	if (icmph->type != ICMP_ECHOREPLY) {
-		ping_err(skb, offset, info);
-		return 0;
-	}
-
-	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
-		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_ICMP);
-	else if (type == ICMP_REDIRECT)
-		ipv4_redirect(skb, net, 0, IPPROTO_ICMP);
-
-	return 0;
-}
-
-/*
- *	This table is the definition of how we handle ICMP.
- */
-static const struct icmp_control icmp_pointers[NR_ICMP_TYPES + 1] = {
-	[ICMP_ECHOREPLY] = {
-		.handler = ping_rcv,
-	},
-	[1] = {
-		.handler = icmp_discard,
-		.error = 1,
-	},
-	[2] = {
-		.handler = icmp_discard,
-		.error = 1,
-	},
-	[ICMP_DEST_UNREACH] = {
-		.handler = icmp_unreach,
-		.error = 1,
-	},
-	[ICMP_SOURCE_QUENCH] = {
-		.handler = icmp_unreach,
-		.error = 1,
-	},
-	[ICMP_REDIRECT] = {
-		.handler = icmp_redirect,
-		.error = 1,
-	},
-	[6] = {
-		.handler = icmp_discard,
-		.error = 1,
-	},
-	[7] = {
-		.handler = icmp_discard,
-		.error = 1,
-	},
-	[ICMP_ECHO] = {
-		.handler = icmp_echo,
-	},
-	[9] = {
-		.handler = icmp_discard,
-		.error = 1,
-	},
-	[10] = {
-		.handler = icmp_discard,
-		.error = 1,
-	},
-	[ICMP_TIME_EXCEEDED] = {
-		.handler = icmp_unreach,
-		.error = 1,
-	},
-	[ICMP_PARAMETERPROB] = {
-		.handler = icmp_unreach,
-		.error = 1,
-	},
-	[ICMP_TIMESTAMP] = {
-		.handler = icmp_timestamp,
-	},
-	[ICMP_TIMESTAMPREPLY] = {
-		.handler = icmp_discard,
-	},
-	[ICMP_INFO_REQUEST] = {
-		.handler = icmp_discard,
-	},
-	[ICMP_INFO_REPLY] = {
-		.handler = icmp_discard,
-	},
-	[ICMP_ADDRESS] = {
-		.handler = icmp_discard,
-	},
-	[ICMP_ADDRESSREPLY] = {
-		.handler = icmp_discard,
-	},
-};
-
 static int __net_init icmp_sk_init(struct net *net)
 {
 	/* Control parameters for ECHO replies. */
@@ -1742,28 +367,12 @@ static struct pernet_operations __net_initdata icmp_sk_ops = {
 
 int __init icmp_init(void)
 {
-	int err, i;
-
-	for_each_possible_cpu(i) {
-		struct sock *sk;
-
-		err = inet_ctl_sock_create(&sk, PF_INET,
-					   SOCK_RAW, IPPROTO_ICMP, &init_net);
-		if (err < 0)
-			return err;
-
-		per_cpu(ipv4_icmp_sk, i) = sk;
-
-		/* Enough space for 2 64K ICMP packets, including
-		 * sk_buff/skb_shared_info struct overhead.
-		 */
-		sk->sk_sndbuf =	2 * SKB_TRUESIZE(64 * 1024);
+#if IS_ENABLED(CONFIG_IPV4)
+	int err;
 
-		/*
-		 * Speedup sock_wfree()
-		 */
-		sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
-		inet_sk(sk)->pmtudisc = IP_PMTUDISC_DONT;
-	}
+	err = icmp_init_ipv4();
+	if (err)
+		return err;
+#endif
 	return register_pernet_subsys(&icmp_sk_ops);
 }
diff --git a/net/ipv4/icmp_ipv4.c b/net/ipv4/icmp_ipv4.c
new file mode 100644
index 000000000000..321b4cc40a17
--- /dev/null
+++ b/net/ipv4/icmp_ipv4.c
@@ -0,0 +1,1425 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *	INET:	Implementation of the ICMP protocol layer.
+ *
+ *	IPv4 specific functions
+ *
+ *	code split from:
+ *	net/ipv4/icmp.c
+ *
+ *	See icmp.c for author information
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/inetdevice.h>
+#include <linux/netfilter_ipv4.h>
+#include <linux/types.h>
+#include <net/icmp.h>
+#include <net/inet_common.h>
+#include <net/ping.h>
+#include <net/protocol.h>
+#include <net/raw.h>
+#include <net/xfrm.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/icmp.h>
+
+/*
+ *	Build xmit assembly blocks
+ */
+
+struct icmp_bxm {
+	struct sk_buff *skb;
+	int offset;
+	int data_len;
+
+	struct {
+		struct icmphdr icmph;
+		__be32	       times[3];
+	} data;
+	int head_len;
+
+	/* Must be last as it ends in a flexible-array member. */
+	struct ip_options_rcu replyopts;
+};
+
+/* An array of errno for error messages from dest unreach. */
+/* RFC 1122: 3.2.2.1 States that NET_UNREACH, HOST_UNREACH and SR_FAILED MUST be considered 'transient errs'. */
+
+const struct icmp_err icmp_err_convert[] = {
+	{
+		.errno = ENETUNREACH,	/* ICMP_NET_UNREACH */
+		.fatal = 0,
+	},
+	{
+		.errno = EHOSTUNREACH,	/* ICMP_HOST_UNREACH */
+		.fatal = 0,
+	},
+	{
+		.errno = ENOPROTOOPT	/* ICMP_PROT_UNREACH */,
+		.fatal = 1,
+	},
+	{
+		.errno = ECONNREFUSED,	/* ICMP_PORT_UNREACH */
+		.fatal = 1,
+	},
+	{
+		.errno = EMSGSIZE,	/* ICMP_FRAG_NEEDED */
+		.fatal = 0,
+	},
+	{
+		.errno = EOPNOTSUPP,	/* ICMP_SR_FAILED */
+		.fatal = 0,
+	},
+	{
+		.errno = ENETUNREACH,	/* ICMP_NET_UNKNOWN */
+		.fatal = 1,
+	},
+	{
+		.errno = EHOSTDOWN,	/* ICMP_HOST_UNKNOWN */
+		.fatal = 1,
+	},
+	{
+		.errno = ENONET,	/* ICMP_HOST_ISOLATED */
+		.fatal = 1,
+	},
+	{
+		.errno = ENETUNREACH,	/* ICMP_NET_ANO	*/
+		.fatal = 1,
+	},
+	{
+		.errno = EHOSTUNREACH,	/* ICMP_HOST_ANO */
+		.fatal = 1,
+	},
+	{
+		.errno = ENETUNREACH,	/* ICMP_NET_UNR_TOS */
+		.fatal = 0,
+	},
+	{
+		.errno = EHOSTUNREACH,	/* ICMP_HOST_UNR_TOS */
+		.fatal = 0,
+	},
+	{
+		.errno = EHOSTUNREACH,	/* ICMP_PKT_FILTERED */
+		.fatal = 1,
+	},
+	{
+		.errno = EHOSTUNREACH,	/* ICMP_PREC_VIOLATION */
+		.fatal = 1,
+	},
+	{
+		.errno = EHOSTUNREACH,	/* ICMP_PREC_CUTOFF */
+		.fatal = 1,
+	},
+};
+EXPORT_SYMBOL(icmp_err_convert);
+
+/*
+ *	ICMP control array. This specifies what to do with each ICMP.
+ */
+
+struct icmp_control {
+	enum skb_drop_reason (*handler)(struct sk_buff *skb);
+	short   error;		/* This ICMP is classed as an error message */
+};
+
+static const struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
+
+static DEFINE_PER_CPU(struct sock *, ipv4_icmp_sk);
+
+/* Called with BH disabled */
+static inline struct sock *icmp_xmit_lock(struct net *net)
+{
+	struct sock *sk;
+
+	sk = this_cpu_read(ipv4_icmp_sk);
+
+	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
+		/* This can happen if the output path signals a
+		 * dst_link_failure() for an outgoing ICMP packet.
+		 */
+		return NULL;
+	}
+	sock_net_set(sk, net);
+	return sk;
+}
+
+static inline void icmp_xmit_unlock(struct sock *sk)
+{
+	sock_net_set(sk, &init_net);
+	spin_unlock(&sk->sk_lock.slock);
+}
+
+/*
+ *	Send an ICMP frame.
+ */
+
+static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
+			       struct flowi4 *fl4, int type, int code,
+			       bool apply_ratelimit)
+{
+	struct dst_entry *dst = &rt->dst;
+	struct inet_peer *peer;
+	struct net_device *dev;
+	int peer_timeout;
+	bool rc = true;
+
+	if (!apply_ratelimit)
+		return true;
+
+	peer_timeout = READ_ONCE(net->ipv4.sysctl_icmp_ratelimit);
+	if (!peer_timeout)
+		goto out;
+
+	/* No rate limit on loopback */
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	if (dev && (dev->flags & IFF_LOOPBACK))
+		goto out_unlock;
+
+	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
+			       l3mdev_master_ifindex_rcu(dev));
+	rc = inet_peer_xrlim_allow(peer, peer_timeout);
+
+out_unlock:
+	rcu_read_unlock();
+out:
+	if (!rc)
+		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume(net);
+	return rc;
+}
+
+/*
+ *	Checksum each fragment, and on the first include the headers and final
+ *	checksum.
+ */
+static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
+			  struct sk_buff *skb)
+{
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	__wsum csum;
+
+	icmp_param = from;
+
+	csum = skb_copy_and_csum_bits(icmp_param->skb,
+				      icmp_param->offset + offset,
+				      to, len);
+
+	skb->csum = csum_block_add(skb->csum, csum, odd);
+	if (icmp_param->data.icmph.type <= NR_ICMP_TYPES &&
+	    icmp_pointers[array_index_nospec(icmp_param->data.icmph.type,
+					     NR_ICMP_TYPES + 1)].error)
+		nf_ct_attach(skb, icmp_param->skb);
+	return 0;
+}
+
+static void icmp_push_reply(struct sock *sk,
+			    struct icmp_bxm *icmp_param,
+			    struct flowi4 *fl4,
+			    struct ipcm_cookie *ipc, struct rtable **rt)
+{
+	struct sk_buff *skb;
+
+	if (ip_append_data(sk, fl4, icmp_glue_bits, icmp_param,
+			   icmp_param->data_len+icmp_param->head_len,
+			   icmp_param->head_len,
+			   ipc, rt, MSG_DONTWAIT) < 0) {
+		__ICMP_INC_STATS(sock_net(sk), ICMP_MIB_OUTERRORS);
+		ip_flush_pending_frames(sk);
+	} else if ((skb = skb_peek(&sk->sk_write_queue)) != NULL) {
+		struct icmphdr *icmph = icmp_hdr(skb);
+		__wsum csum;
+		struct sk_buff *skb1;
+
+		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
+						 (char *)icmph,
+						 icmp_param->head_len);
+		skb_queue_walk(&sk->sk_write_queue, skb1) {
+			csum = csum_add(csum, skb1->csum);
+		}
+		icmph->checksum = csum_fold(csum);
+		skb->ip_summed = CHECKSUM_NONE;
+		ip_push_pending_frames(sk, fl4);
+	}
+}
+
+static bool icmpv4_mask_allow(struct net *net, int type, int code)
+{
+	if (type > NR_ICMP_TYPES)
+		return true;
+
+	/* Don't limit PMTU discovery. */
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		return true;
+
+	/* Limit if icmp type is enabled in ratemask. */
+	if (!((1 << type) & READ_ONCE(net->ipv4.sysctl_icmp_ratemask)))
+		return true;
+
+	return false;
+}
+
+static bool icmpv4_global_allow(struct net *net, int type, int code,
+				bool *apply_ratelimit)
+{
+	if (icmpv4_mask_allow(net, type, code))
+		return true;
+
+	if (icmp_global_allow(net)) {
+		*apply_ratelimit = true;
+		return true;
+	}
+	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
+	return false;
+}
+
+static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
+{
+	struct rtable *rt = skb_rtable(skb);
+	struct net *net = dev_net_rcu(rt->dst.dev);
+	bool apply_ratelimit = false;
+	struct ipcm_cookie ipc;
+	struct flowi4 fl4;
+	struct sock *sk;
+	__be32 daddr, saddr;
+	u32 mark = IP4_REPLY_MARK(net, skb->mark);
+	int type = icmp_param->data.icmph.type;
+	int code = icmp_param->data.icmph.code;
+
+	if (ip_options_echo(net, &icmp_param->replyopts.opt, skb))
+		return;
+
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
+	local_bh_disable();
+
+	/* is global icmp_msgs_per_sec exhausted ? */
+	if (!icmpv4_global_allow(net, type, code, &apply_ratelimit))
+		goto out_bh_enable;
+
+	sk = icmp_xmit_lock(net);
+	if (!sk)
+		goto out_bh_enable;
+
+	icmp_param->data.icmph.checksum = 0;
+
+	ipcm_init(&ipc);
+	ipc.tos = ip_hdr(skb)->tos;
+	ipc.sockc.mark = mark;
+	daddr = ipc.addr = ip_hdr(skb)->saddr;
+	saddr = fib_compute_spec_dst(skb);
+
+	if (icmp_param->replyopts.opt.optlen) {
+		ipc.opt = &icmp_param->replyopts;
+		if (ipc.opt->opt.srr)
+			daddr = icmp_param->replyopts.opt.faddr;
+	}
+	memset(&fl4, 0, sizeof(fl4));
+	fl4.daddr = daddr;
+	fl4.saddr = saddr;
+	fl4.flowi4_mark = mark;
+	fl4.flowi4_uid = sock_net_uid(net, NULL);
+	fl4.flowi4_dscp = ip4h_dscp(ip_hdr(skb));
+	fl4.flowi4_proto = IPPROTO_ICMP;
+	fl4.flowi4_oif = l3mdev_master_ifindex(skb->dev);
+	security_skb_classify_flow(skb, flowi4_to_flowi_common(&fl4));
+	rt = ip_route_output_key(net, &fl4);
+	if (IS_ERR(rt))
+		goto out_unlock;
+	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
+		icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
+	ip_rt_put(rt);
+out_unlock:
+	icmp_xmit_unlock(sk);
+out_bh_enable:
+	local_bh_enable();
+}
+
+/*
+ * The device used for looking up which routing table to use for sending an ICMP
+ * error is preferably the source whenever it is set, which should ensure the
+ * icmp error can be sent to the source host, else lookup using the routing
+ * table of the destination device, else use the main routing table (index 0).
+ */
+static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+	const struct dst_entry *dst;
+
+	if (dev)
+		return dev;
+	dst = skb_dst(skb);
+	return dst ? dst_dev(dst) : NULL;
+}
+
+static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
+					struct sk_buff *skb_in,
+					const struct iphdr *iph, __be32 saddr,
+					dscp_t dscp, u32 mark, int type,
+					int code, struct icmp_bxm *param)
+{
+	struct net_device *route_lookup_dev;
+	struct dst_entry *dst, *dst2;
+	struct rtable *rt, *rt2;
+	struct flowi4 fl4_dec;
+	int err;
+
+	memset(fl4, 0, sizeof(*fl4));
+	fl4->daddr = (param->replyopts.opt.srr ?
+		      param->replyopts.opt.faddr : iph->saddr);
+	fl4->saddr = saddr;
+	fl4->flowi4_mark = mark;
+	fl4->flowi4_uid = sock_net_uid(net, NULL);
+	fl4->flowi4_dscp = dscp;
+	fl4->flowi4_proto = IPPROTO_ICMP;
+	fl4->fl4_icmp_type = type;
+	fl4->fl4_icmp_code = code;
+	route_lookup_dev = icmp_get_route_lookup_dev(skb_in);
+	fl4->flowi4_oif = l3mdev_master_ifindex(route_lookup_dev);
+
+	security_skb_classify_flow(skb_in, flowi4_to_flowi_common(fl4));
+	rt = ip_route_output_key_hash(net, fl4, skb_in);
+	if (IS_ERR(rt))
+		return rt;
+
+	/* No need to clone since we're just using its address. */
+	rt2 = rt;
+
+	dst = xfrm_lookup(net, &rt->dst,
+			  flowi4_to_flowi(fl4), NULL, 0);
+	rt = dst_rtable(dst);
+	if (!IS_ERR(dst)) {
+		if (rt != rt2)
+			return rt;
+		if (inet_addr_type_dev_table(net, route_lookup_dev,
+					     fl4->daddr) == RTN_LOCAL)
+			return rt;
+	} else if (PTR_ERR(dst) == -EPERM) {
+		rt = NULL;
+	} else {
+		return rt;
+	}
+	err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
+	if (err)
+		goto relookup_failed;
+
+	if (inet_addr_type_dev_table(net, route_lookup_dev,
+				     fl4_dec.saddr) == RTN_LOCAL) {
+		rt2 = __ip_route_output_key(net, &fl4_dec);
+		if (IS_ERR(rt2))
+			err = PTR_ERR(rt2);
+	} else {
+		struct flowi4 fl4_2 = {};
+		unsigned long orefdst;
+
+		fl4_2.daddr = fl4_dec.saddr;
+		rt2 = ip_route_output_key(net, &fl4_2);
+		if (IS_ERR(rt2)) {
+			err = PTR_ERR(rt2);
+			goto relookup_failed;
+		}
+		/* Ugh! */
+		orefdst = skb_dstref_steal(skb_in);
+		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
+				     dscp, rt2->dst.dev) ? -EINVAL : 0;
+
+		dst_release(&rt2->dst);
+		rt2 = skb_rtable(skb_in);
+		/* steal dst entry from skb_in, don't drop refcnt */
+		skb_dstref_steal(skb_in);
+		skb_dstref_restore(skb_in, orefdst);
+
+		/*
+		 * At this point, fl4_dec.daddr should NOT be local (we
+		 * checked fl4_dec.saddr above). However, a race condition
+		 * may occur if the address is added to the interface
+		 * concurrently. In that case, ip_route_input() returns a
+		 * LOCAL route with dst.output=ip_rt_bug, which must not
+		 * be used for output.
+		 */
+		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
+			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
+					     &fl4_dec.daddr, &fl4_dec.saddr);
+			dst_release(&rt2->dst);
+			err = -EINVAL;
+		}
+	}
+
+	if (err)
+		goto relookup_failed;
+
+	dst2 = xfrm_lookup(net, &rt2->dst, flowi4_to_flowi(&fl4_dec), NULL,
+			   XFRM_LOOKUP_ICMP);
+	rt2 = dst_rtable(dst2);
+	if (!IS_ERR(dst2)) {
+		dst_release(&rt->dst);
+		rt = rt2;
+	} else if (PTR_ERR(dst2) == -EPERM) {
+		if (rt)
+			dst_release(&rt->dst);
+		return rt2;
+	} else {
+		err = PTR_ERR(dst2);
+		goto relookup_failed;
+	}
+	return rt;
+
+relookup_failed:
+	if (rt)
+		return rt;
+	return ERR_PTR(err);
+}
+
+struct icmp_ext_iio_addr4_subobj {
+	__be16 afi;
+	__be16 reserved;
+	__be32 addr4;
+};
+
+static unsigned int icmp_ext_iio_len(void)
+{
+	return sizeof(struct icmp_extobj_hdr) +
+		/* ifIndex */
+		sizeof(__be32) +
+		/* Interface Address Sub-Object */
+		sizeof(struct icmp_ext_iio_addr4_subobj) +
+		/* Interface Name Sub-Object. Length must be a multiple of 4
+		 * bytes.
+		 */
+		ALIGN(sizeof(struct icmp_ext_iio_name_subobj), 4) +
+		/* MTU */
+		sizeof(__be32);
+}
+
+static unsigned int icmp_ext_max_len(u8 ext_objs)
+{
+	unsigned int ext_max_len;
+
+	ext_max_len = sizeof(struct icmp_ext_hdr);
+
+	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
+		ext_max_len += icmp_ext_iio_len();
+
+	return ext_max_len;
+}
+
+static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
+{
+	struct in_device *in_dev;
+	struct in_ifaddr *ifa;
+
+	in_dev = __in_dev_get_rcu(dev);
+	if (!in_dev)
+		return 0;
+
+	/* It is unclear from RFC 5837 which IP address should be chosen, but
+	 * it makes sense to choose a global unicast address.
+	 */
+	in_dev_for_each_ifa_rcu(ifa, in_dev) {
+		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
+			continue;
+		if (ifa->ifa_scope != RT_SCOPE_UNIVERSE ||
+		    ipv4_is_multicast(ifa->ifa_address))
+			continue;
+		return ifa->ifa_address;
+	}
+
+	return 0;
+}
+
+static void icmp_ext_iio_iif_append(struct net *net, struct sk_buff *skb,
+				    int iif)
+{
+	struct icmp_ext_iio_name_subobj *name_subobj;
+	struct icmp_extobj_hdr *objh;
+	struct net_device *dev;
+	__be32 data;
+
+	if (!iif)
+		return;
+
+	/* Add the fields in the order specified by RFC 5837. */
+	objh = skb_put(skb, sizeof(*objh));
+	objh->class_num = ICMP_EXT_OBJ_CLASS_IIO;
+	objh->class_type = ICMP_EXT_CTYPE_IIO_ROLE(ICMP_EXT_CTYPE_IIO_ROLE_IIF);
+
+	data = htonl(iif);
+	skb_put_data(skb, &data, sizeof(__be32));
+	objh->class_type |= ICMP_EXT_CTYPE_IIO_IFINDEX;
+
+	rcu_read_lock();
+
+	dev = dev_get_by_index_rcu(net, iif);
+	if (!dev)
+		goto out;
+
+	data = icmp_ext_iio_addr4_find(dev);
+	if (data) {
+		struct icmp_ext_iio_addr4_subobj *addr4_subobj;
+
+		addr4_subobj = skb_put_zero(skb, sizeof(*addr4_subobj));
+		addr4_subobj->afi = htons(ICMP_AFI_IP);
+		addr4_subobj->addr4 = data;
+		objh->class_type |= ICMP_EXT_CTYPE_IIO_IPADDR;
+	}
+
+	name_subobj = skb_put_zero(skb, ALIGN(sizeof(*name_subobj), 4));
+	name_subobj->len = ALIGN(sizeof(*name_subobj), 4);
+	netdev_copy_name(dev, name_subobj->name);
+	objh->class_type |= ICMP_EXT_CTYPE_IIO_NAME;
+
+	data = htonl(READ_ONCE(dev->mtu));
+	skb_put_data(skb, &data, sizeof(__be32));
+	objh->class_type |= ICMP_EXT_CTYPE_IIO_MTU;
+
+out:
+	rcu_read_unlock();
+	objh->length = htons(skb_tail_pointer(skb) - (unsigned char *)objh);
+}
+
+static void icmp_ext_objs_append(struct net *net, struct sk_buff *skb,
+				 u8 ext_objs, int iif)
+{
+	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
+		icmp_ext_iio_iif_append(net, skb, iif);
+}
+
+static struct sk_buff *
+icmp_ext_append(struct net *net, struct sk_buff *skb_in, struct icmphdr *icmph,
+		unsigned int room, int iif)
+{
+	unsigned int payload_len, ext_max_len, ext_len;
+	struct icmp_ext_hdr *ext_hdr;
+	struct sk_buff *skb;
+	u8 ext_objs;
+	int nhoff;
+
+	switch (icmph->type) {
+	case ICMP_DEST_UNREACH:
+	case ICMP_TIME_EXCEEDED:
+	case ICMP_PARAMETERPROB:
+		break;
+	default:
+		return NULL;
+	}
+
+	ext_objs = READ_ONCE(net->ipv4.sysctl_icmp_errors_extension_mask);
+	if (!ext_objs)
+		return NULL;
+
+	ext_max_len = icmp_ext_max_len(ext_objs);
+	if (ICMP_EXT_ORIG_DGRAM_MIN_LEN + ext_max_len > room)
+		return NULL;
+
+	skb = skb_clone(skb_in, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	nhoff = skb_network_offset(skb);
+	payload_len = min(skb->len - nhoff, ICMP_EXT_ORIG_DGRAM_MIN_LEN);
+
+	if (!pskb_network_may_pull(skb, payload_len))
+		goto free_skb;
+
+	if (pskb_trim(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN) ||
+	    __skb_put_padto(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN, false))
+		goto free_skb;
+
+	if (pskb_expand_head(skb, 0, ext_max_len, GFP_ATOMIC))
+		goto free_skb;
+
+	ext_hdr = skb_put_zero(skb, sizeof(*ext_hdr));
+	ext_hdr->version = ICMP_EXT_VERSION_2;
+
+	icmp_ext_objs_append(net, skb, ext_objs, iif);
+
+	/* Do not send an empty extension structure. */
+	ext_len = skb_tail_pointer(skb) - (unsigned char *)ext_hdr;
+	if (ext_len == sizeof(*ext_hdr))
+		goto free_skb;
+
+	ext_hdr->checksum = ip_compute_csum(ext_hdr, ext_len);
+	/* The length of the original datagram in 32-bit words (RFC 4884). */
+	icmph->un.reserved[1] = ICMP_EXT_ORIG_DGRAM_MIN_LEN / sizeof(u32);
+
+	return skb;
+
+free_skb:
+	consume_skb(skb);
+	return NULL;
+}
+
+/*
+ *	Send an ICMP message in response to a situation
+ *
+ *	RFC 1122: 3.2.2	MUST send at least the IP header and 8 bytes of header.
+ *		  MAY send more (we do).
+ *			MUST NOT change this header information.
+ *			MUST NOT reply to a multicast/broadcast IP address.
+ *			MUST NOT reply to a multicast/broadcast MAC address.
+ *			MUST reply to only the first fragment.
+ */
+
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct inet_skb_parm *parm)
+{
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	struct iphdr *iph;
+	int room;
+	struct rtable *rt = skb_rtable(skb_in);
+	bool apply_ratelimit = false;
+	struct sk_buff *ext_skb;
+	struct ipcm_cookie ipc;
+	struct flowi4 fl4;
+	__be32 saddr;
+	u8  tos;
+	u32 mark;
+	struct net *net;
+	struct sock *sk;
+
+	if (!rt)
+		return;
+
+	rcu_read_lock();
+
+	if (rt->dst.dev)
+		net = dev_net_rcu(rt->dst.dev);
+	else if (skb_in->dev)
+		net = dev_net_rcu(skb_in->dev);
+	else
+		goto out;
+
+	/*
+	 *	Find the original header. It is expected to be valid, of course.
+	 *	Check this, icmp_send is called from the most obscure devices
+	 *	sometimes.
+	 */
+	iph = ip_hdr(skb_in);
+
+	if ((u8 *)iph < skb_in->head ||
+	    (skb_network_header(skb_in) + sizeof(*iph)) >
+	    skb_tail_pointer(skb_in))
+		goto out;
+
+	/*
+	 *	No replies to physical multicast/broadcast
+	 */
+	if (skb_in->pkt_type != PACKET_HOST)
+		goto out;
+
+	/*
+	 *	Now check at the protocol level
+	 */
+	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+		goto out;
+
+	/*
+	 *	Only reply to fragment 0. We byte re-order the constant
+	 *	mask for efficiency.
+	 */
+	if (iph->frag_off & htons(IP_OFFSET))
+		goto out;
+
+	/*
+	 *	If we send an ICMP error to an ICMP error a mess would result..
+	 */
+	if (icmp_pointers[type].error) {
+		/*
+		 *	We are an error, check if we are replying to an
+		 *	ICMP error
+		 */
+		if (iph->protocol == IPPROTO_ICMP) {
+			u8 _inner_type, *itp;
+
+			itp = skb_header_pointer(skb_in,
+						 skb_network_header(skb_in) +
+						 (iph->ihl << 2) +
+						 offsetof(struct icmphdr,
+							  type) -
+						 skb_in->data,
+						 sizeof(_inner_type),
+						 &_inner_type);
+			if (!itp)
+				goto out;
+
+			/*
+			 *	Assume any unknown ICMP type is an error. This
+			 *	isn't specified by the RFC, but think about it..
+			 */
+			if (*itp > NR_ICMP_TYPES ||
+			    icmp_pointers[*itp].error)
+				goto out;
+		}
+	}
+
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
+	local_bh_disable();
+
+	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
+	 * incoming dev is loopback.  If outgoing dev change to not be
+	 * loopback, then peer ratelimit still work (in icmpv4_xrlim_allow)
+	 */
+	if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
+	      !icmpv4_global_allow(net, type, code, &apply_ratelimit))
+		goto out_bh_enable;
+
+	sk = icmp_xmit_lock(net);
+	if (!sk)
+		goto out_bh_enable;
+
+	/*
+	 *	Construct source address and options.
+	 */
+
+	saddr = iph->daddr;
+	if (!(rt->rt_flags & RTCF_LOCAL)) {
+		struct net_device *dev = NULL;
+
+		rcu_read_lock();
+		if (rt_is_input_route(rt) &&
+		    READ_ONCE(net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr))
+			dev = dev_get_by_index_rcu(net, parm->iif ? parm->iif :
+						   inet_iif(skb_in));
+
+		if (dev)
+			saddr = inet_select_addr(dev, iph->saddr,
+						 RT_SCOPE_LINK);
+		else
+			saddr = 0;
+		rcu_read_unlock();
+	}
+
+	tos = icmp_pointers[type].error ? (RT_TOS(iph->tos) |
+					   IPTOS_PREC_INTERNETCONTROL) :
+					   iph->tos;
+	mark = IP4_REPLY_MARK(net, skb_in->mark);
+
+	if (__ip_options_echo(net, &icmp_param->replyopts.opt, skb_in,
+			      &parm->opt))
+		goto out_unlock;
+
+
+	/*
+	 *	Prepare data for ICMP header.
+	 */
+
+	icmp_param->data.icmph.type	 = type;
+	icmp_param->data.icmph.code	 = code;
+	icmp_param->data.icmph.un.gateway = info;
+	icmp_param->data.icmph.checksum	 = 0;
+	icmp_param->skb	  = skb_in;
+	icmp_param->offset = skb_network_offset(skb_in);
+	ipcm_init(&ipc);
+	ipc.tos = tos;
+	ipc.addr = iph->saddr;
+	ipc.opt = &icmp_param->replyopts;
+	ipc.sockc.mark = mark;
+
+	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
+			       inet_dsfield_to_dscp(tos), mark, type, code,
+			       icmp_param);
+	if (IS_ERR(rt))
+		goto out_unlock;
+
+	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+		goto ende;
+
+	/* peer icmp_ratelimit */
+	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
+		goto ende;
+
+	/* RFC says return as much as we can without exceeding 576 bytes. */
+
+	room = dst4_mtu(&rt->dst);
+	if (room > 576)
+		room = 576;
+	room -= sizeof(struct iphdr) + icmp_param->replyopts.opt.optlen;
+	room -= sizeof(struct icmphdr);
+	/* Guard against tiny mtu. We need to include at least one
+	 * IP network header for this message to make any sense.
+	 */
+	if (room <= (int)sizeof(struct iphdr))
+		goto ende;
+
+	ext_skb = icmp_ext_append(net, skb_in, &icmp_param->data.icmph, room,
+				  parm->iif);
+	if (ext_skb)
+		icmp_param->skb = ext_skb;
+
+	icmp_param->data_len = icmp_param->skb->len - icmp_param->offset;
+	if (icmp_param->data_len > room)
+		icmp_param->data_len = room;
+	icmp_param->head_len = sizeof(struct icmphdr);
+
+	/* if we don't have a source address at this point, fall back to the
+	 * dummy address instead of sending out a packet with a source address
+	 * of 0.0.0.0
+	 */
+	if (!fl4.saddr)
+		fl4.saddr = htonl(INADDR_DUMMY);
+
+	trace_icmp_send(skb_in, type, code);
+
+	icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
+
+	if (ext_skb)
+		consume_skb(ext_skb);
+ende:
+	ip_rt_put(rt);
+out_unlock:
+	icmp_xmit_unlock(sk);
+out_bh_enable:
+	local_bh_enable();
+out:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(__icmp_send);
+
+#if IS_ENABLED(CONFIG_NF_NAT)
+#include <net/netfilter/nf_conntrack.h>
+void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+{
+	struct sk_buff *cloned_skb = NULL;
+	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
+	struct inet_skb_parm parm;
+	struct nf_conn *ct;
+	__be32 orig_ip;
+
+	memset(&parm, 0, sizeof(parm));
+	ct = nf_ct_get(skb_in, &ctinfo);
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
+		__icmp_send(skb_in, type, code, info, &parm);
+		return;
+	}
+
+	if (skb_shared(skb_in))
+		skb_in = cloned_skb = skb_clone(skb_in, GFP_ATOMIC);
+
+	if (unlikely(!skb_in || skb_network_header(skb_in) < skb_in->head ||
+	    (skb_network_header(skb_in) + sizeof(struct iphdr)) >
+	    skb_tail_pointer(skb_in) || skb_ensure_writable(skb_in,
+	    skb_network_offset(skb_in) + sizeof(struct iphdr))))
+		goto out;
+
+	orig_ip = ip_hdr(skb_in)->saddr;
+	dir = CTINFO2DIR(ctinfo);
+	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
+	__icmp_send(skb_in, type, code, info, &parm);
+	ip_hdr(skb_in)->saddr = orig_ip;
+out:
+	consume_skb(cloned_skb);
+}
+EXPORT_SYMBOL(icmp_ndo_send);
+#endif
+
+static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
+{
+	const struct iphdr *iph = (const struct iphdr *)skb->data;
+	const struct net_protocol *ipprot;
+	int protocol = iph->protocol;
+
+	/* Checkin full IP header plus 8 bytes of protocol to
+	 * avoid additional coding at protocol handlers.
+	 */
+	if (!pskb_may_pull(skb, iph->ihl * 4 + 8))
+		goto out;
+
+	/* IPPROTO_RAW sockets are not supposed to receive anything. */
+	if (protocol == IPPROTO_RAW)
+		goto out;
+
+	raw_icmp_error(skb, protocol, info);
+
+	ipprot = rcu_dereference(inet_protos[protocol]);
+	if (ipprot && ipprot->err_handler)
+		ipprot->err_handler(skb, info);
+	return;
+
+out:
+	__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
+}
+
+static bool icmp_tag_validation(int proto)
+{
+	const struct net_protocol *ipprot;
+	bool ok;
+
+	rcu_read_lock();
+	ipprot = rcu_dereference(inet_protos[proto]);
+	ok = ipprot ? ipprot->icmp_strict_tag_validation : false;
+	rcu_read_unlock();
+	return ok;
+}
+
+/*
+ *	Handle ICMP_DEST_UNREACH, ICMP_TIME_EXCEEDED, ICMP_QUENCH, and
+ *	ICMP_PARAMETERPROB.
+ */
+
+static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
+{
+	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
+	const struct iphdr *iph;
+	struct icmphdr *icmph;
+	struct net *net;
+	u32 info = 0;
+
+	net = skb_dst_dev_net_rcu(skb);
+
+	/*
+	 *	Incomplete header ?
+	 * 	Only checks for the IP header, there should be an
+	 *	additional check for longer headers in upper levels.
+	 */
+
+	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		goto out_err;
+
+	icmph = icmp_hdr(skb);
+	iph   = (const struct iphdr *)skb->data;
+
+	if (iph->ihl < 5)  { /* Mangled header, drop. */
+		reason = SKB_DROP_REASON_IP_INHDR;
+		goto out_err;
+	}
+
+	switch (icmph->type) {
+	case ICMP_DEST_UNREACH:
+		switch (icmph->code & 15) {
+		case ICMP_NET_UNREACH:
+		case ICMP_HOST_UNREACH:
+		case ICMP_PROT_UNREACH:
+		case ICMP_PORT_UNREACH:
+			break;
+		case ICMP_FRAG_NEEDED:
+			/* for documentation of the ip_no_pmtu_disc
+			 * values please see
+			 * Documentation/networking/ip-sysctl.rst
+			 */
+			switch (READ_ONCE(net->ipv4.sysctl_ip_no_pmtu_disc)) {
+			default:
+				net_dbg_ratelimited("%pI4: fragmentation needed and DF set\n",
+						    &iph->daddr);
+				break;
+			case 2:
+				goto out;
+			case 3:
+				if (!icmp_tag_validation(iph->protocol))
+					goto out;
+				fallthrough;
+			case 0:
+				info = ntohs(icmph->un.frag.mtu);
+			}
+			break;
+		case ICMP_SR_FAILED:
+			net_dbg_ratelimited("%pI4: Source Route Failed\n",
+					    &iph->daddr);
+			break;
+		default:
+			break;
+		}
+		if (icmph->code > NR_ICMP_UNREACH)
+			goto out;
+		break;
+	case ICMP_PARAMETERPROB:
+		info = ntohl(icmph->un.gateway) >> 24;
+		break;
+	case ICMP_TIME_EXCEEDED:
+		__ICMP_INC_STATS(net, ICMP_MIB_INTIMEEXCDS);
+		if (icmph->code == ICMP_EXC_FRAGTIME)
+			goto out;
+		break;
+	}
+
+	/*
+	 *	Throw it at our lower layers
+	 *
+	 *	RFC 1122: 3.2.2 MUST extract the protocol ID from the passed
+	 *		  header.
+	 *	RFC 1122: 3.2.2.1 MUST pass ICMP unreach messages to the
+	 *		  transport layer.
+	 *	RFC 1122: 3.2.2.2 MUST pass ICMP time expired messages to
+	 *		  transport layer.
+	 */
+
+	/*
+	 *	Check the other end isn't violating RFC 1122. Some routers send
+	 *	bogus responses to broadcast frames. If you see this message
+	 *	first check your netmask matches at both ends, if it does then
+	 *	get the other vendor to fix their kit.
+	 */
+
+	if (!READ_ONCE(net->ipv4.sysctl_icmp_ignore_bogus_error_responses) &&
+	    inet_addr_type_dev_table(net, skb->dev, iph->daddr) == RTN_BROADCAST) {
+		net_warn_ratelimited("%pI4 sent an invalid ICMP type %u, code %u error to a broadcast: %pI4 on %s\n",
+				     &ip_hdr(skb)->saddr,
+				     icmph->type, icmph->code,
+				     &iph->daddr, skb->dev->name);
+		goto out;
+	}
+
+	icmp_socket_deliver(skb, info);
+
+out:
+	return reason;
+out_err:
+	__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
+	return reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
+}
+
+/*
+ *	Handle ICMP_REDIRECT.
+ */
+
+static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)
+{
+	if (skb->len < sizeof(struct iphdr)) {
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
+		return SKB_DROP_REASON_PKT_TOO_SMALL;
+	}
+
+	if (!pskb_may_pull(skb, sizeof(struct iphdr))) {
+		/* there aught to be a stat */
+		return SKB_DROP_REASON_NOMEM;
+	}
+
+	icmp_socket_deliver(skb, ntohl(icmp_hdr(skb)->un.gateway));
+	return SKB_NOT_DROPPED_YET;
+}
+
+/*
+ *	Handle ICMP_ECHO ("ping") and ICMP_EXT_ECHO ("PROBE") requests.
+ *
+ *	RFC 1122: 3.2.2.6 MUST have an echo server that answers ICMP echo
+ *		  requests.
+ *	RFC 1122: 3.2.2.6 Data received in the ICMP_ECHO request MUST be
+ *		  included in the reply.
+ *	RFC 1812: 4.3.3.6 SHOULD have a config option for silently ignoring
+ *		  echo requests, MUST have default=NOT.
+ *	RFC 8335: 8 MUST have a config option to enable/disable ICMP
+ *		  Extended Echo Functionality, MUST be disabled by default
+ *	See also WRT handling of options once they are done and working.
+ */
+
+static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
+{
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	struct net *net;
+
+	net = skb_dst_dev_net_rcu(skb);
+	/* should there be an ICMP stat for ignored echos? */
+	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
+		return SKB_NOT_DROPPED_YET;
+
+	icmp_param->data.icmph	   = *icmp_hdr(skb);
+	icmp_param->skb		   = skb;
+	icmp_param->offset	   = 0;
+	icmp_param->data_len	   = skb->len;
+	icmp_param->head_len	   = sizeof(struct icmphdr);
+
+	if (icmp_param->data.icmph.type == ICMP_ECHO)
+		icmp_param->data.icmph.type = ICMP_ECHOREPLY;
+	else if (!icmp_build_probe(skb, &icmp_param->data.icmph))
+		return SKB_NOT_DROPPED_YET;
+
+	icmp_reply(icmp_param, skb);
+	return SKB_NOT_DROPPED_YET;
+}
+
+/*
+ *	Handle ICMP Timestamp requests.
+ *	RFC 1122: 3.2.2.8 MAY implement ICMP timestamp requests.
+ *		  SHOULD be in the kernel for minimum random latency.
+ *		  MUST be accurate to a few minutes.
+ *		  MUST be updated at least at 15Hz.
+ */
+static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
+{
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	/*
+	 *	Too short.
+	 */
+	if (skb->len < 4)
+		goto out_err;
+
+	/*
+	 *	Fill in the current time as ms since midnight UT:
+	 */
+	icmp_param->data.times[1] = inet_current_timestamp();
+	icmp_param->data.times[2] = icmp_param->data.times[1];
+
+	BUG_ON(skb_copy_bits(skb, 0, &icmp_param->data.times[0], 4));
+
+	icmp_param->data.icmph	   = *icmp_hdr(skb);
+	icmp_param->data.icmph.type = ICMP_TIMESTAMPREPLY;
+	icmp_param->data.icmph.code = 0;
+	icmp_param->skb		   = skb;
+	icmp_param->offset	   = 0;
+	icmp_param->data_len	   = 0;
+	icmp_param->head_len	   = sizeof(struct icmphdr) + 12;
+	icmp_reply(icmp_param, skb);
+	return SKB_NOT_DROPPED_YET;
+
+out_err:
+	__ICMP_INC_STATS(skb_dst_dev_net_rcu(skb), ICMP_MIB_INERRORS);
+	return SKB_DROP_REASON_PKT_TOO_SMALL;
+}
+
+static enum skb_drop_reason icmp_discard(struct sk_buff *skb)
+{
+	/* pretend it was a success */
+	return SKB_NOT_DROPPED_YET;
+}
+
+int icmp_err(struct sk_buff *skb, u32 info)
+{
+	struct iphdr *iph = (struct iphdr *)skb->data;
+	int offset = iph->ihl<<2;
+	struct icmphdr *icmph = (struct icmphdr *)(skb->data + offset);
+	struct net *net = dev_net_rcu(skb->dev);
+	int type = icmp_hdr(skb)->type;
+	int code = icmp_hdr(skb)->code;
+
+	/*
+	 * Use ping_err to handle all icmp errors except those
+	 * triggered by ICMP_ECHOREPLY which sent from kernel.
+	 */
+	if (icmph->type != ICMP_ECHOREPLY) {
+		ping_err(skb, offset, info);
+		return 0;
+	}
+
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_ICMP);
+	else if (type == ICMP_REDIRECT)
+		ipv4_redirect(skb, net, 0, IPPROTO_ICMP);
+
+	return 0;
+}
+
+/*
+ *	Deal with incoming ICMP packets.
+ */
+int icmp_rcv(struct sk_buff *skb)
+{
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	struct rtable *rt = skb_rtable(skb);
+	struct net *net = dev_net_rcu(rt->dst.dev);
+	struct icmphdr *icmph;
+
+	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
+		struct sec_path *sp = skb_sec_path(skb);
+		int nh;
+
+		if (!(sp && sp->xvec[sp->len - 1]->props.flags &
+				 XFRM_STATE_ICMP)) {
+			reason = SKB_DROP_REASON_XFRM_POLICY;
+			goto drop;
+		}
+
+		if (!pskb_may_pull(skb, sizeof(*icmph) + sizeof(struct iphdr)))
+			goto drop;
+
+		nh = skb_network_offset(skb);
+		skb_set_network_header(skb, sizeof(*icmph));
+
+		if (!xfrm4_policy_check_reverse(NULL, XFRM_POLICY_IN,
+						skb)) {
+			reason = SKB_DROP_REASON_XFRM_POLICY;
+			goto drop;
+		}
+
+		skb_set_network_header(skb, nh);
+	}
+
+	__ICMP_INC_STATS(net, ICMP_MIB_INMSGS);
+
+	if (skb_checksum_simple_validate(skb))
+		goto csum_error;
+
+	if (!pskb_pull(skb, sizeof(*icmph)))
+		goto error;
+
+	icmph = icmp_hdr(skb);
+
+	ICMPMSGIN_INC_STATS(net, icmph->type);
+
+	/* Check for ICMP Extended Echo (PROBE) messages */
+	if (icmph->type == ICMP_EXT_ECHO) {
+		/* We can't use icmp_pointers[].handler() because it is an array of
+		 * size NR_ICMP_TYPES + 1 (19 elements) and PROBE has code 42.
+		 */
+		reason = icmp_echo(skb);
+		goto reason_check;
+	}
+
+	/*
+	 *	Parse the ICMP message
+	 */
+
+	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST)) {
+		/*
+		 *	RFC 1122: 3.2.2.6 An ICMP_ECHO to broadcast MAY be
+		 *	  silently ignored (we let user decide with a sysctl).
+		 *	RFC 1122: 3.2.2.8 An ICMP_TIMESTAMP MAY be silently
+		 *	  discarded if to broadcast/multicast.
+		 */
+		if ((icmph->type == ICMP_ECHO ||
+		     icmph->type == ICMP_TIMESTAMP) &&
+		    READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_broadcasts)) {
+			reason = SKB_DROP_REASON_INVALID_PROTO;
+			goto error;
+		}
+		if (icmph->type != ICMP_ECHO &&
+		    icmph->type != ICMP_TIMESTAMP &&
+		    icmph->type != ICMP_ADDRESS &&
+		    icmph->type != ICMP_ADDRESSREPLY) {
+			reason = SKB_DROP_REASON_INVALID_PROTO;
+			goto error;
+		}
+	}
+
+	if (icmph->type == ICMP_EXT_ECHOREPLY ||
+	    icmph->type == ICMP_ECHOREPLY) {
+		reason = ping_rcv(skb);
+		return reason ? NET_RX_DROP : NET_RX_SUCCESS;
+	}
+
+	/*
+	 *	18 is the highest 'known' ICMP type. Anything else is a mystery
+	 *
+	 *	RFC 1122: 3.2.2  Unknown ICMP messages types MUST be silently
+	 *		  discarded.
+	 */
+	if (icmph->type > NR_ICMP_TYPES) {
+		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
+		goto error;
+	}
+
+	reason = icmp_pointers[icmph->type].handler(skb);
+reason_check:
+	if (!reason)  {
+		consume_skb(skb);
+		return NET_RX_SUCCESS;
+	}
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return NET_RX_DROP;
+csum_error:
+	reason = SKB_DROP_REASON_ICMP_CSUM;
+	__ICMP_INC_STATS(net, ICMP_MIB_CSUMERRORS);
+error:
+	__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
+	goto drop;
+}
+
+/*
+ *	This table is the definition of how we handle ICMP.
+ */
+static const struct icmp_control icmp_pointers[NR_ICMP_TYPES + 1] = {
+	[ICMP_ECHOREPLY] = {
+		.handler = ping_rcv,
+	},
+	[1] = {
+		.handler = icmp_discard,
+		.error = 1,
+	},
+	[2] = {
+		.handler = icmp_discard,
+		.error = 1,
+	},
+	[ICMP_DEST_UNREACH] = {
+		.handler = icmp_unreach,
+		.error = 1,
+	},
+	[ICMP_SOURCE_QUENCH] = {
+		.handler = icmp_unreach,
+		.error = 1,
+	},
+	[ICMP_REDIRECT] = {
+		.handler = icmp_redirect,
+		.error = 1,
+	},
+	[6] = {
+		.handler = icmp_discard,
+		.error = 1,
+	},
+	[7] = {
+		.handler = icmp_discard,
+		.error = 1,
+	},
+	[ICMP_ECHO] = {
+		.handler = icmp_echo,
+	},
+	[9] = {
+		.handler = icmp_discard,
+		.error = 1,
+	},
+	[10] = {
+		.handler = icmp_discard,
+		.error = 1,
+	},
+	[ICMP_TIME_EXCEEDED] = {
+		.handler = icmp_unreach,
+		.error = 1,
+	},
+	[ICMP_PARAMETERPROB] = {
+		.handler = icmp_unreach,
+		.error = 1,
+	},
+	[ICMP_TIMESTAMP] = {
+		.handler = icmp_timestamp,
+	},
+	[ICMP_TIMESTAMPREPLY] = {
+		.handler = icmp_discard,
+	},
+	[ICMP_INFO_REQUEST] = {
+		.handler = icmp_discard,
+	},
+	[ICMP_INFO_REPLY] = {
+		.handler = icmp_discard,
+	},
+	[ICMP_ADDRESS] = {
+		.handler = icmp_discard,
+	},
+	[ICMP_ADDRESSREPLY] = {
+		.handler = icmp_discard,
+	},
+};
+
+int icmp_init_ipv4(void)
+{
+	int err, i;
+
+	for_each_possible_cpu(i) {
+		struct sock *sk;
+
+		err = inet_ctl_sock_create(&sk, PF_INET,
+					   SOCK_RAW, IPPROTO_ICMP, &init_net);
+		if (err < 0)
+			return err;
+
+		per_cpu(ipv4_icmp_sk, i) = sk;
+
+		/* Enough space for 2 64K ICMP packets, including
+		 * sk_buff/skb_shared_info struct overhead.
+		 */
+		sk->sk_sndbuf =	2 * SKB_TRUESIZE(64 * 1024);
+
+		/*
+		 * Speedup sock_wfree()
+		 */
+		sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
+		inet_sk(sk)->pmtudisc = IP_PMTUDISC_DONT;
+	}
+
+	return 0;
+}
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 8165277629ad..62007dbadf7a 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -205,7 +205,9 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 					     (struct sockaddr_unsized *)&sin,
 					     sizeof(sin));
 
+#if IS_ENABLED(CONFIG_IPV4)
 ipv4_connected:
+#endif
 		if (err)
 			goto out;
 
-- 
2.54.0


