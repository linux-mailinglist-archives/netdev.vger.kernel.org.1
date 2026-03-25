Return-Path: <netdev+bounces-271524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAA2Ca3Ww2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:35:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFBE324F70
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68FBD3166DD2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164433DB638;
	Wed, 25 Mar 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HCymKhvu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hILDJom6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HCymKhvu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hILDJom6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFF3DA7E3
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440689; cv=none; b=RSTo0xzsPNWu0Z/rKgE2Ku/Idd6NerBoqS1/nyIPoI0LGvtnb8hk+kCnM4UhK/3gWd16XmU/FYX9nS9cSXKexZ4Sia8KHp1RGQtVWsPTmj+4rKEgV/ojSgd057BrDQ7X2WGVPF4kfuk++NFtQDD+/OAChBNEXtb/u0biMBhul8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440689; c=relaxed/simple;
	bh=uvc/oFHdNoZKiacIaapij73qjvotaDSVAlVkne8H+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3rF5fhNQoBExDZYUeNvrV+3wgbXYdw9G0W+hSy+iNnmNePcZd/g79bPhkCLIkk4sLT55IDZy4ipn+u6JD1TIzCgRnxShuG4sPnbvfmhRSBF3jJ8zTO9C7mbDlw3Cqx4A8xTAnWlfCZNvrZMoZiz01eU+q8uFe1eOMkhJArTr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HCymKhvu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hILDJom6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HCymKhvu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hILDJom6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C336D5BCCF;
	Wed, 25 Mar 2026 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIeqtjPrEfWXXR7DA3h8n7OIs5BFX7/wUbz+m8e3AY0=;
	b=HCymKhvuy8eAv19yTrgOZ95N41HA55Nron2wOqybPHn2IrxTt0oHVAD1HmyAl+PFSAkHBY
	M/8NAMoUzseZrbCEAcr4xdiLru3v2y9X6/0/1jakDZhd9ioP0WV89+NQVTcqX91UQyPTi/
	LUfMS9bCTQAWTwVfCKdwXwjcSWUNuAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIeqtjPrEfWXXR7DA3h8n7OIs5BFX7/wUbz+m8e3AY0=;
	b=hILDJom6CvVrhPtOvTZvfiNV5/4ntxBx/FBS8DQdE1XSYr2DfLpOT66T2uFqPvoZMHfefm
	VjCg5KGXkuMl9cCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIeqtjPrEfWXXR7DA3h8n7OIs5BFX7/wUbz+m8e3AY0=;
	b=HCymKhvuy8eAv19yTrgOZ95N41HA55Nron2wOqybPHn2IrxTt0oHVAD1HmyAl+PFSAkHBY
	M/8NAMoUzseZrbCEAcr4xdiLru3v2y9X6/0/1jakDZhd9ioP0WV89+NQVTcqX91UQyPTi/
	LUfMS9bCTQAWTwVfCKdwXwjcSWUNuAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIeqtjPrEfWXXR7DA3h8n7OIs5BFX7/wUbz+m8e3AY0=;
	b=hILDJom6CvVrhPtOvTZvfiNV5/4ntxBx/FBS8DQdE1XSYr2DfLpOT66T2uFqPvoZMHfefm
	VjCg5KGXkuMl9cCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 277D9443BE;
	Wed, 25 Mar 2026 12:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cKKqBujQw2kbNgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 12:11:20 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11 net-next v5] ipv6: remove ipv6_stub infrastructure completely
Date: Wed, 25 Mar 2026 13:08:51 +0100
Message-ID: <20260325120928.15848-11-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325120928.15848-1-fmancera@suse.de>
References: <20260325120928.15848-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271524-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 2DFBE324F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only and there are no more users of ipv6_stub, the
ipv6_stub is now entirely obsolete.

Remove all the code related to the definition, initialization and usage.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 include/net/ip6_fib.h     |  1 -
 include/net/ipv6_stubs.h  | 80 ----------------------------------
 include/net/ndisc.h       | 25 +----------
 include/net/udp_tunnel.h  |  1 -
 net/ipv6/addrconf_core.c  | 91 ---------------------------------------
 net/ipv6/af_inet6.c       | 40 -----------------
 net/ipv6/ip6_fib.c        |  8 ----
 net/ipv6/ip6_udp_tunnel.c |  3 +-
 8 files changed, 3 insertions(+), 246 deletions(-)
 delete mode 100644 include/net/ipv6_stubs.h

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index f01ef8ffe296..3e72cce4fe0f 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -602,7 +602,6 @@ static inline void fib6_update_sernum_upto_root(struct net *net, struct fib6_inf
 {
 }
 #endif
-void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i);
 
 void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val);
 static inline bool fib6_metric_locked(struct fib6_info *f6i, int metric)
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
deleted file mode 100644
index dc708d9eca7a..000000000000
--- a/include/net/ipv6_stubs.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _IPV6_STUBS_H
-#define _IPV6_STUBS_H
-
-#include <linux/in6.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/neighbour.h>
-#include <net/sock.h>
-#include <net/ipv6.h>
-
-/* structs from net/ip6_fib.h */
-struct fib6_info;
-struct fib6_nh;
-struct fib6_config;
-struct fib6_result;
-
-/* This is ugly, ideally these symbols should be built
- * into the core kernel.
- */
-struct ipv6_stub {
-	int (*ipv6_sock_mc_join)(struct sock *sk, int ifindex,
-				 const struct in6_addr *addr);
-	int (*ipv6_sock_mc_drop)(struct sock *sk, int ifindex,
-				 const struct in6_addr *addr);
-	struct dst_entry *(*ipv6_dst_lookup_flow)(struct net *net,
-						  const struct sock *sk,
-						  struct flowi6 *fl6,
-						  const struct in6_addr *final_dst);
-	int (*ipv6_route_input)(struct sk_buff *skb);
-
-	struct fib6_table *(*fib6_get_table)(struct net *net, u32 id);
-	int (*fib6_lookup)(struct net *net, int oif, struct flowi6 *fl6,
-			   struct fib6_result *res, int flags);
-	int (*fib6_table_lookup)(struct net *net, struct fib6_table *table,
-				 int oif, struct flowi6 *fl6,
-				 struct fib6_result *res, int flags);
-	void (*fib6_select_path)(const struct net *net, struct fib6_result *res,
-				 struct flowi6 *fl6, int oif, bool oif_match,
-				 const struct sk_buff *skb, int strict);
-	u32 (*ip6_mtu_from_fib6)(const struct fib6_result *res,
-				 const struct in6_addr *daddr,
-				 const struct in6_addr *saddr);
-
-	int (*fib6_nh_init)(struct net *net, struct fib6_nh *fib6_nh,
-			    struct fib6_config *cfg, gfp_t gfp_flags,
-			    struct netlink_ext_ack *extack);
-	void (*fib6_nh_release)(struct fib6_nh *fib6_nh);
-	void (*fib6_nh_release_dsts)(struct fib6_nh *fib6_nh);
-	void (*fib6_update_sernum)(struct net *net, struct fib6_info *rt);
-	int (*ip6_del_rt)(struct net *net, struct fib6_info *rt, bool skip_notify);
-	void (*fib6_rt_update)(struct net *net, struct fib6_info *rt,
-			       struct nl_info *info);
-
-	void (*udpv6_encap_enable)(void);
-	void (*ndisc_send_na)(struct net_device *dev, const struct in6_addr *daddr,
-			      const struct in6_addr *solicited_addr,
-			      bool router, bool solicited, bool override, bool inc_opt);
-#if IS_ENABLED(CONFIG_XFRM)
-	void (*xfrm6_local_rxpmtu)(struct sk_buff *skb, u32 mtu);
-	int (*xfrm6_udp_encap_rcv)(struct sock *sk, struct sk_buff *skb);
-	struct sk_buff *(*xfrm6_gro_udp_encap_rcv)(struct sock *sk,
-						   struct list_head *head,
-						   struct sk_buff *skb);
-	int (*xfrm6_rcv_encap)(struct sk_buff *skb, int nexthdr, __be32 spi,
-			       int encap_type);
-#endif
-	struct neigh_table *nd_tbl;
-
-	int (*ipv6_fragment)(struct net *net, struct sock *sk, struct sk_buff *skb,
-			     int (*output)(struct net *, struct sock *, struct sk_buff *));
-	struct net_device *(*ipv6_dev_find)(struct net *net, const struct in6_addr *addr,
-					    struct net_device *dev);
-	int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
-			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
-};
-extern const struct ipv6_stub *ipv6_stub __read_mostly;
-#endif
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 19e2a177bd29..3da1a6f8d3f9 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -2,8 +2,6 @@
 #ifndef _NDISC_H
 #define _NDISC_H
 
-#include <net/ipv6_stubs.h>
-
 /*
  *	ICMP codes for neighbour discovery messages
  */
@@ -359,14 +357,6 @@ static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev
 	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, ndisc_hashfn, pkey, dev);
 }
 
-static inline
-struct neighbour *__ipv6_neigh_lookup_noref_stub(struct net_device *dev,
-						 const void *pkey)
-{
-	return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128,
-				     ndisc_hashfn, pkey, dev);
-}
-
 static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, const void *pkey)
 {
 	struct neighbour *n;
@@ -391,25 +381,13 @@ static inline void __ipv6_confirm_neigh(struct net_device *dev,
 	rcu_read_unlock();
 }
 
-static inline void __ipv6_confirm_neigh_stub(struct net_device *dev,
-					     const void *pkey)
-{
-	struct neighbour *n;
-
-	rcu_read_lock();
-	n = __ipv6_neigh_lookup_noref_stub(dev, pkey);
-	neigh_confirm(n);
-	rcu_read_unlock();
-}
-
-/* uses ipv6_stub and is meant for use outside of IPv6 core */
 static inline struct neighbour *ip_neigh_gw6(struct net_device *dev,
 					     const void *addr)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct neighbour *neigh;
 
-	neigh = __ipv6_neigh_lookup_noref_stub(dev, addr);
+	neigh = __ipv6_neigh_lookup_noref(dev, addr);
 	if (unlikely(!neigh))
 		neigh = __neigh_create(&nd_tbl, addr, dev, false);
 
@@ -438,6 +416,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 void ndisc_send_rs(struct net_device *dev,
 		   const struct in6_addr *saddr, const struct in6_addr *daddr);
+
 void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 		   const struct in6_addr *solicited_addr,
 		   bool router, bool solicited, bool override, bool inc_opt);
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 40089fc4c1ba..47c23d4a1740 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -7,7 +7,6 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
-#include <net/ipv6_stubs.h>
 #endif
 
 #define UDP_TUNNEL_PARTIAL_FEATURES	NETIF_F_GSO_ENCAP_ALL
diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index c008d21925d7..fa27a90ab3cd 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -6,7 +6,6 @@
 
 #include <linux/export.h>
 #include <net/ipv6.h>
-#include <net/ipv6_stubs.h>
 #include <net/addrconf.h>
 #include <net/ip.h>
 
@@ -129,96 +128,6 @@ int inet6addr_validator_notifier_call_chain(unsigned long val, void *v)
 }
 EXPORT_SYMBOL(inet6addr_validator_notifier_call_chain);
 
-static struct dst_entry *eafnosupport_ipv6_dst_lookup_flow(struct net *net,
-							   const struct sock *sk,
-							   struct flowi6 *fl6,
-							   const struct in6_addr *final_dst)
-{
-	return ERR_PTR(-EAFNOSUPPORT);
-}
-
-static int eafnosupport_ipv6_route_input(struct sk_buff *skb)
-{
-	return -EAFNOSUPPORT;
-}
-
-static struct fib6_table *eafnosupport_fib6_get_table(struct net *net, u32 id)
-{
-	return NULL;
-}
-
-static int
-eafnosupport_fib6_table_lookup(struct net *net, struct fib6_table *table,
-			       int oif, struct flowi6 *fl6,
-			       struct fib6_result *res, int flags)
-{
-	return -EAFNOSUPPORT;
-}
-
-static int
-eafnosupport_fib6_lookup(struct net *net, int oif, struct flowi6 *fl6,
-			 struct fib6_result *res, int flags)
-{
-	return -EAFNOSUPPORT;
-}
-
-static void
-eafnosupport_fib6_select_path(const struct net *net, struct fib6_result *res,
-			      struct flowi6 *fl6, int oif, bool have_oif_match,
-			      const struct sk_buff *skb, int strict)
-{
-}
-
-static u32
-eafnosupport_ip6_mtu_from_fib6(const struct fib6_result *res,
-			       const struct in6_addr *daddr,
-			       const struct in6_addr *saddr)
-{
-	return 0;
-}
-
-static int eafnosupport_fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
-				     struct fib6_config *cfg, gfp_t gfp_flags,
-				     struct netlink_ext_ack *extack)
-{
-	NL_SET_ERR_MSG(extack, "IPv6 support not enabled in kernel");
-	return -EAFNOSUPPORT;
-}
-
-static int eafnosupport_ip6_del_rt(struct net *net, struct fib6_info *rt,
-				   bool skip_notify)
-{
-	return -EAFNOSUPPORT;
-}
-
-static int eafnosupport_ipv6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
-				      int (*output)(struct net *, struct sock *, struct sk_buff *))
-{
-	kfree_skb(skb);
-	return -EAFNOSUPPORT;
-}
-
-static struct net_device *eafnosupport_ipv6_dev_find(struct net *net, const struct in6_addr *addr,
-						     struct net_device *dev)
-{
-	return ERR_PTR(-EAFNOSUPPORT);
-}
-
-const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
-	.ipv6_dst_lookup_flow = eafnosupport_ipv6_dst_lookup_flow,
-	.ipv6_route_input  = eafnosupport_ipv6_route_input,
-	.fib6_get_table    = eafnosupport_fib6_get_table,
-	.fib6_table_lookup = eafnosupport_fib6_table_lookup,
-	.fib6_lookup       = eafnosupport_fib6_lookup,
-	.fib6_select_path  = eafnosupport_fib6_select_path,
-	.ip6_mtu_from_fib6 = eafnosupport_ip6_mtu_from_fib6,
-	.fib6_nh_init	   = eafnosupport_fib6_nh_init,
-	.ip6_del_rt	   = eafnosupport_ip6_del_rt,
-	.ipv6_fragment	   = eafnosupport_ipv6_fragment,
-	.ipv6_dev_find     = eafnosupport_ipv6_dev_find,
-};
-EXPORT_SYMBOL_GPL(ipv6_stub);
-
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
 const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
 	= IN6ADDR_LOOPBACK_INIT;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 07ae6ea7743a..33abd8d8cd7d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -51,7 +51,6 @@
 #include <net/transp_v6.h>
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
-#include <net/ipv6_stubs.h>
 #include <net/ndisc.h>
 #ifdef CONFIG_IPV6_TUNNEL
 #include <net/ip6_tunnel.h>
@@ -996,42 +995,6 @@ static struct pernet_operations inet6_net_ops = {
 	.exit = inet6_net_exit,
 };
 
-static int ipv6_route_input(struct sk_buff *skb)
-{
-	ip6_route_input(skb);
-	return skb_dst(skb)->error;
-}
-
-static const struct ipv6_stub ipv6_stub_impl = {
-	.ipv6_sock_mc_join = ipv6_sock_mc_join,
-	.ipv6_sock_mc_drop = ipv6_sock_mc_drop,
-	.ipv6_dst_lookup_flow = ip6_dst_lookup_flow,
-	.ipv6_route_input  = ipv6_route_input,
-	.fib6_get_table	   = fib6_get_table,
-	.fib6_table_lookup = fib6_table_lookup,
-	.fib6_lookup       = fib6_lookup,
-	.fib6_select_path  = fib6_select_path,
-	.ip6_mtu_from_fib6 = ip6_mtu_from_fib6,
-	.fib6_nh_init	   = fib6_nh_init,
-	.fib6_nh_release   = fib6_nh_release,
-	.fib6_nh_release_dsts = fib6_nh_release_dsts,
-	.fib6_update_sernum = fib6_update_sernum_stub,
-	.fib6_rt_update	   = fib6_rt_update,
-	.ip6_del_rt	   = ip6_del_rt,
-	.udpv6_encap_enable = udpv6_encap_enable,
-	.ndisc_send_na = ndisc_send_na,
-#if IS_ENABLED(CONFIG_XFRM)
-	.xfrm6_local_rxpmtu = xfrm6_local_rxpmtu,
-	.xfrm6_udp_encap_rcv = xfrm6_udp_encap_rcv,
-	.xfrm6_gro_udp_encap_rcv = xfrm6_gro_udp_encap_rcv,
-	.xfrm6_rcv_encap = xfrm6_rcv_encap,
-#endif
-	.nd_tbl	= &nd_tbl,
-	.ipv6_fragment = ip6_fragment,
-	.ipv6_dev_find = ipv6_dev_find,
-	.ip6_xmit = ip6_xmit,
-};
-
 static int __init inet6_init(void)
 {
 	struct list_head *r;
@@ -1188,9 +1151,6 @@ static int __init inet6_init(void)
 		goto sysctl_fail;
 #endif
 
-	/* ensure that ipv6 stubs are visible only after ipv6 is ready */
-	wmb();
-	ipv6_stub = &ipv6_stub_impl;
 out:
 	return err;
 
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a935004ec9df..3d52044e0bdb 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1408,14 +1408,6 @@ void fib6_update_sernum_upto_root(struct net *net, struct fib6_info *rt)
 	__fib6_update_sernum_upto_root(rt, fib6_new_sernum(net));
 }
 
-/* allow ipv4 to update sernum via ipv6_stub */
-void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i)
-{
-	spin_lock_bh(&f6i->fib6_table->tb6_lock);
-	fib6_update_sernum_upto_root(net, f6i);
-	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
-}
-
 /*
  *	Add routing information to the routing tree.
  *	<destination addr>/<source addr>
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index cef3e0210744..405ef1cb8864 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -162,8 +162,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	fl6.fl6_dport = dport;
 	fl6.flowlabel = ip6_make_flowinfo(dsfield, key->label);
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sock->sk, &fl6,
-					      NULL);
+	dst = ip6_dst_lookup_flow(net, sock->sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
 		return ERR_PTR(-ENETUNREACH);
-- 
2.53.0


