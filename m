Return-Path: <netdev+bounces-271519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEY7Gefcw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:02:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE77132559F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6353C32C3C93
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316F3D5656;
	Wed, 25 Mar 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xwaTEKu6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X/ygdzVo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xwaTEKu6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X/ygdzVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C23D3D00
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440653; cv=none; b=gmLn9Yuj/UnAObi2XStKBr3DzbVeFGUM4xDEXhfEIKx2S2W20j9gzkLctUqSwWTUL4/eEzUzezwqqTy+26n0uL78taH5Ua6o8IvAgdBeStCKTQr5FNL66y/DUvTfAimznDWVfls2obTzXozcmeTnBEqc6RPl6mWkvQYPRBixlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440653; c=relaxed/simple;
	bh=bpejGpnRoLh47BtBTYYgAjLWe/KAWahAqx+N+kr+Wuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4dbae/CaDWPAyQrt9lz+dlTXx8nq6fBl7y3yFjL2ZkNcU8wRVylFhjI7pc0/zcl2M9ASwnpHG4v89IzwxHKNEmDkyLcyYM/e2mqDKDF3QD48SzrbRDIUMesN1P9FGZai7hTav+3ma8Jsf0jV+wudLU5jNwNAb/p0nIxLRn6ZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xwaTEKu6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X/ygdzVo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xwaTEKu6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X/ygdzVo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96E715BCCF;
	Wed, 25 Mar 2026 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPBhNbx59XmxgmAW+4smkMBq9yTZr8g+X+CR1QXB2+c=;
	b=xwaTEKu6BLORdXxcsFaxf9nbCMO10TY0ybE/ySCPODIhzYXw9Fo5kRQzCanB+QA8HCk/z7
	8+eJtKFnD8ML+MX5X6+ovIOChnnXONEzHtXvQc/FKCUvxxJHQWpz87g6uERdhzzQstLC32
	rVn7ry6sxknfftvR65HMhSkETMErvic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPBhNbx59XmxgmAW+4smkMBq9yTZr8g+X+CR1QXB2+c=;
	b=X/ygdzVoA6NsUkq9e8PhGwk+LhiHxuJ9h669XYHxU/y3Wa9nVr++V+94gvqbVe+ujn4boF
	F5kqP2rNS7hVmLCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPBhNbx59XmxgmAW+4smkMBq9yTZr8g+X+CR1QXB2+c=;
	b=xwaTEKu6BLORdXxcsFaxf9nbCMO10TY0ybE/ySCPODIhzYXw9Fo5kRQzCanB+QA8HCk/z7
	8+eJtKFnD8ML+MX5X6+ovIOChnnXONEzHtXvQc/FKCUvxxJHQWpz87g6uERdhzzQstLC32
	rVn7ry6sxknfftvR65HMhSkETMErvic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPBhNbx59XmxgmAW+4smkMBq9yTZr8g+X+CR1QXB2+c=;
	b=X/ygdzVoA6NsUkq9e8PhGwk+LhiHxuJ9h669XYHxU/y3Wa9nVr++V+94gvqbVe+ujn4boF
	F5kqP2rNS7hVmLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2504443BE;
	Wed, 25 Mar 2026 12:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kNEVOMXQw2kbNgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 12:10:45 +0000
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
Subject: [PATCH 05/11 net-next v5] ipv6: prepare headers for ipv6_stub removal
Date: Wed, 25 Mar 2026 13:08:46 +0100
Message-ID: <20260325120928.15848-6-fmancera@suse.de>
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
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271519-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: DE77132559F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for dropping ipv6_stub and converting its users to direct
function calls, introduce static inline dummy functions and fallback
macros in the IPv6 networking headers. In addition, introduce checks on
fib6_nh_init(), ip6_dst_lookup_flow() and ip6_fragment() to avoid a
crash due to ipv6.disable=1 set during booting. The other functions are
safe as they cannot be called with ipv6.disable=1 set.

These fallbacks ensure that when CONFIG_IPV6 is completely disabled,
there are no compiling or linking errors due to code paths not guarded
by preprocessor macro IS_ENABLED(CONFIG_IPV6).

In addition, export ndisc_send_na(), ip6_route_input() and
ip6_fragment().

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 include/net/ip6_fib.h   | 32 ++++++++++++++++++++++++++++++++
 include/net/ip6_route.h | 26 ++++++++++++++++++++++++++
 include/net/ipv6.h      | 10 ++++++++++
 include/net/ndisc.h     |  6 +++++-
 net/ipv6/ip6_output.c   |  8 ++++++++
 net/ipv6/ndisc.c        |  1 +
 net/ipv6/route.c        |  6 ++++++
 7 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 39c98c3d8ac5..f01ef8ffe296 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -486,11 +486,30 @@ void rt6_get_prefsrc(const struct rt6_info *rt, struct in6_addr *addr)
 	rcu_read_unlock();
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		 struct fib6_config *cfg, gfp_t gfp_flags,
 		 struct netlink_ext_ack *extack);
 void fib6_nh_release(struct fib6_nh *fib6_nh);
 void fib6_nh_release_dsts(struct fib6_nh *fib6_nh);
+#else
+static inline int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
+			       struct fib6_config *cfg, gfp_t gfp_flags,
+			       struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG(extack, "IPv6 support not enabled in kernel");
+	return -EAFNOSUPPORT;
+}
+
+static inline void fib6_nh_release(struct fib6_nh *fib6_nh)
+{
+}
+
+static inline void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
+{
+}
+#endif
+
 
 int call_fib6_entry_notifiers(struct net *net,
 			      enum fib_event_type event_type,
@@ -502,8 +521,15 @@ int call_fib6_multipath_entry_notifiers(struct net *net,
 					unsigned int nsiblings,
 					struct netlink_ext_ack *extack);
 int call_fib6_entry_notifiers_replace(struct net *net, struct fib6_info *rt);
+#if IS_ENABLED(CONFIG_IPV6)
 void fib6_rt_update(struct net *net, struct fib6_info *rt,
 		    struct nl_info *info);
+#else
+static inline void fib6_rt_update(struct net *net, struct fib6_info *rt,
+				  struct nl_info *info)
+{
+}
+#endif
 void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		     unsigned int flags);
 
@@ -569,7 +595,13 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
 		     struct netlink_ext_ack *extack);
 
 void fib6_update_sernum(struct net *net, struct fib6_info *rt);
+#if IS_ENABLED(CONFIG_IPV6)
 void fib6_update_sernum_upto_root(struct net *net, struct fib6_info *rt);
+#else
+static inline void fib6_update_sernum_upto_root(struct net *net, struct fib6_info *rt)
+{
+}
+#endif
 void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i);
 
 void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val);
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 0c8eeb6abe7a..09ffe0f13ce7 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -77,7 +77,14 @@ static inline bool rt6_qualify_for_ecmp(const struct fib6_info *f6i)
 		f6i->fib6_nh->fib_nh_gw_family;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 void ip6_route_input(struct sk_buff *skb);
+#else
+static inline void ip6_route_input(struct sk_buff *skb)
+{
+}
+#endif
+
 struct dst_entry *ip6_route_input_lookup(struct net *net,
 					 struct net_device *dev,
 					 struct flowi6 *fl6,
@@ -119,7 +126,15 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd,
 int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 		  struct netlink_ext_ack *extack);
 int ip6_ins_rt(struct net *net, struct fib6_info *f6i);
+#if IS_ENABLED(CONFIG_IPV6)
 int ip6_del_rt(struct net *net, struct fib6_info *f6i, bool skip_notify);
+#else
+static inline int ip6_del_rt(struct net *net, struct fib6_info *f6i,
+			     bool skip_notify)
+{
+	return -EAFNOSUPPORT;
+}
+#endif
 
 void rt6_flush_exceptions(struct fib6_info *f6i);
 void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
@@ -270,8 +285,19 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 	return __ipv6_anycast_destination(&rt->rt6i_dst, rt->rt6i_flags, daddr);
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
+#else
+static inline int ip6_fragment(struct net *net, struct sock *sk,
+			       struct sk_buff *skb,
+			       int (*output)(struct net *, struct sock *,
+					     struct sk_buff *))
+{
+	kfree_skb(skb);
+	return -EAFNOSUPPORT;
+}
+#endif
 
 /* Variant of dst_mtu() for IPv6 users */
 static inline u32 dst6_mtu(const struct dst_entry *dst)
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0958cc5c6ec3..f99f273341f0 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1044,8 +1044,18 @@ static inline struct sk_buff *ip6_finish_skb(struct sock *sk)
 
 int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
 		   struct flowi6 *fl6);
+#if IS_ENABLED(CONFIG_IPV6)
 struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, struct flowi6 *fl6,
 				      const struct in6_addr *final_dst);
+#else
+static inline struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk,
+						    struct flowi6 *fl6,
+						    const struct in6_addr *final_dst)
+{
+	return ERR_PTR(-EAFNOSUPPORT);
+}
+#endif
+
 struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
 					 const struct in6_addr *final_dst,
 					 bool connected);
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index d38783a2ce57..19e2a177bd29 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -406,13 +406,17 @@ static inline void __ipv6_confirm_neigh_stub(struct net_device *dev,
 static inline struct neighbour *ip_neigh_gw6(struct net_device *dev,
 					     const void *addr)
 {
+#if IS_ENABLED(CONFIG_IPV6)
 	struct neighbour *neigh;
 
 	neigh = __ipv6_neigh_lookup_noref_stub(dev, addr);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(ipv6_stub->nd_tbl, addr, dev, false);
+		neigh = __neigh_create(&nd_tbl, addr, dev, false);
 
 	return neigh;
+#else
+	return ERR_PTR(-EAFNOSUPPORT);
+#endif
 }
 
 int ndisc_init(void);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8e2a6b28cea7..63abc4fddaee 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -873,6 +873,11 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	__be32 frag_id;
 	u8 *prevhdr, nexthdr = 0;
 
+	if (!ipv6_mod_enabled()) {
+		kfree_skb(skb);
+		return -EAFNOSUPPORT;
+	}
+
 	err = ip6_find_1stfragopt(skb, &prevhdr);
 	if (err < 0)
 		goto fail;
@@ -1045,6 +1050,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	kfree_skb(skb);
 	return err;
 }
+EXPORT_SYMBOL_GPL(ip6_fragment);
 
 static inline int ip6_rt_check(const struct rt6key *rt_key,
 			       const struct in6_addr *fl_addr,
@@ -1256,6 +1262,8 @@ struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, st
 	struct dst_entry *dst = NULL;
 	int err;
 
+	if (!ipv6_mod_enabled())
+		return ERR_PTR(-EAFNOSUPPORT);
 	err = ip6_dst_lookup_tail(net, sk, &dst, fl6);
 	if (err)
 		return ERR_PTR(err);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6a5d8c73af9..f76fb8a85452 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -576,6 +576,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 
 	ndisc_send_skb(skb, daddr, src_addr);
 }
+EXPORT_SYMBOL_GPL(ndisc_send_na);
 
 static void ndisc_send_unsol_na(struct net_device *dev)
 {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 781b43c54932..844a70ea3567 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2655,6 +2655,7 @@ void ip6_route_input(struct sk_buff *skb)
 	skb_dst_set_noref(skb, ip6_route_input_lookup(net, skb->dev,
 						      &fl6, skb, flags));
 }
+EXPORT_SYMBOL_GPL(ip6_route_input);
 
 INDIRECT_CALLABLE_SCOPE struct rt6_info *ip6_pol_route_output(struct net *net,
 					     struct fib6_table *table,
@@ -3585,6 +3586,11 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	struct inet6_dev *idev = NULL;
 	int err;
 
+	if (!ipv6_mod_enabled()) {
+		NL_SET_ERR_MSG(extack, "IPv6 support not enabled in kernel");
+		return -EAFNOSUPPORT;
+	}
+
 	fib6_nh->fib_nh_family = AF_INET6;
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	fib6_nh->last_probe = jiffies;
-- 
2.53.0


