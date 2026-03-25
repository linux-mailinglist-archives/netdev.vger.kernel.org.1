Return-Path: <netdev+bounces-271522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOG8B0jWw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:34:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88855324F03
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23A08318000A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0DA3D348C;
	Wed, 25 Mar 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rliEAYDg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XS6K9T9u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rliEAYDg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XS6K9T9u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D23D891A
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440677; cv=none; b=LvSCC05HM5N7kPmLDliLqn8xJvXp/wuwwbUzxHshLBCOiL2QXIMw3CbyQp5UaqA49PeSwsb/NslEOm0ix735idBqg7YOjFS+eHRz3dKnktl2am9t5imXL89uRdGONJtPZg0N9neWgA9CyHhkTVMPkweEl3Bzxvr63kI6gfTcMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440677; c=relaxed/simple;
	bh=YZ30EUiSvyZn32npch4Omuzp+R16WxZju5lBzueb3Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwJpcFu+FqHDKO84S6fvcZbD/3/8HpXTaFSVZ9TTnIi3z4ARNJIRYU1Lc362gaF8BZxCAAKx1NAwAkrnpqO+G6xXYQaSdjSV+/a6A4xkY80sk2uToYBQWNPX5W8PtUv7wxwZ25l6DInwBZxZgdRho9IpL0ohykimGrMX9sAqOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rliEAYDg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XS6K9T9u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rliEAYDg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XS6K9T9u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DACF5BCD0;
	Wed, 25 Mar 2026 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xGB9DUadFbOfKpSdw2M70Ponh9KjHnghTDfmBqTObs=;
	b=rliEAYDgnSvggG995+4ZPuLWf7SB/0rCmTfrYelPj27DcOyjIOTGAzqq70CROWh67dWGQA
	yEMgOMWL/Y/w7EFZO2Qpe1MdGS3kzzMxR4yhKQlhVyKbPSh982slskIApyxGMq7/M0TGqY
	w6/jl3v9FOb4PGHqC46mG3Px+YuFswU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xGB9DUadFbOfKpSdw2M70Ponh9KjHnghTDfmBqTObs=;
	b=XS6K9T9u2n3FPhLKdace8XYg6VUbvV2yeZeYkipzgKzO3RKfP9/HkkUqPc8uPLTruML7Uy
	iU+aiuUgyDw71PBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xGB9DUadFbOfKpSdw2M70Ponh9KjHnghTDfmBqTObs=;
	b=rliEAYDgnSvggG995+4ZPuLWf7SB/0rCmTfrYelPj27DcOyjIOTGAzqq70CROWh67dWGQA
	yEMgOMWL/Y/w7EFZO2Qpe1MdGS3kzzMxR4yhKQlhVyKbPSh982slskIApyxGMq7/M0TGqY
	w6/jl3v9FOb4PGHqC46mG3Px+YuFswU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xGB9DUadFbOfKpSdw2M70Ponh9KjHnghTDfmBqTObs=;
	b=XS6K9T9u2n3FPhLKdace8XYg6VUbvV2yeZeYkipzgKzO3RKfP9/HkkUqPc8uPLTruML7Uy
	iU+aiuUgyDw71PBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED8AE443BE;
	Wed, 25 Mar 2026 12:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2EMHN9vQw2kbNgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 12:11:07 +0000
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11 net-next v5] ipv4: drop ipv6_stub usage and use direct function calls
Date: Wed, 25 Mar 2026 13:08:48 +0100
Message-ID: <20260325120928.15848-8-fmancera@suse.de>
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
X-Spam-Score: -5.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,suse.com,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271522-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:email]
X-Rspamd-Queue-Id: 88855324F03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only, the ipv6_stub infrastructure is no longer
necessary.

The IPv4 stack interacts with IPv6 mainly to support IPv4 routes with
IPv6 next-hops (RFC 8950). Convert all these cross-family calls from
ipv6_stub to direct function calls. The fallback functions introduced
previously will prevent linkage errors when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/ipv4/fib_semantics.c | 16 ++++++++--------
 net/ipv4/icmp.c          |  2 +-
 net/ipv4/nexthop.c       | 28 +++++++++++++++-------------
 net/ipv4/route.c         |  4 ++--
 net/ipv4/udp.c           |  7 ++-----
 5 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 01cb587866d8..3e8fadc28798 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -585,9 +585,8 @@ static int fib_detect_death(struct fib_info *fi, int order,
 
 	if (likely(nhc->nhc_gw_family == AF_INET))
 		n = neigh_lookup(&arp_tbl, &nhc->nhc_gw.ipv4, nhc->nhc_dev);
-	else if (nhc->nhc_gw_family == AF_INET6)
-		n = neigh_lookup(ipv6_stub->nd_tbl, &nhc->nhc_gw.ipv6,
-				 nhc->nhc_dev);
+	else if (IS_ENABLED(CONFIG_IPV6) && nhc->nhc_gw_family == AF_INET6)
+		n = neigh_lookup(&nd_tbl, &nhc->nhc_gw.ipv6, nhc->nhc_dev);
 	else
 		n = NULL;
 
@@ -1083,7 +1082,7 @@ static int fib_check_nh_v6_gw(struct net *net, struct fib_nh *nh,
 	struct fib6_nh fib6_nh = {};
 	int err;
 
-	err = ipv6_stub->fib6_nh_init(net, &fib6_nh, &cfg, GFP_KERNEL, extack);
+	err = fib6_nh_init(net, &fib6_nh, &cfg, GFP_KERNEL, extack);
 	if (!err) {
 		nh->fib_nh_dev = fib6_nh.fib_nh_dev;
 		netdev_hold(nh->fib_nh_dev, &nh->fib_nh_dev_tracker,
@@ -1091,7 +1090,7 @@ static int fib_check_nh_v6_gw(struct net *net, struct fib_nh *nh,
 		nh->fib_nh_oif = nh->fib_nh_dev->ifindex;
 		nh->fib_nh_scope = RT_SCOPE_LINK;
 
-		ipv6_stub->fib6_nh_release(&fib6_nh);
+		fib6_nh_release(&fib6_nh);
 	}
 
 	return err;
@@ -2147,9 +2146,10 @@ static bool fib_good_nh(const struct fib_nh *nh)
 		if (likely(nh->fib_nh_gw_family == AF_INET))
 			n = __ipv4_neigh_lookup_noref(nh->fib_nh_dev,
 						   (__force u32)nh->fib_nh_gw4);
-		else if (nh->fib_nh_gw_family == AF_INET6)
-			n = __ipv6_neigh_lookup_noref_stub(nh->fib_nh_dev,
-							   &nh->fib_nh_gw6);
+		else if (IS_ENABLED(CONFIG_IPV6) &&
+			 nh->fib_nh_gw_family == AF_INET6)
+			n = __ipv6_neigh_lookup_noref(nh->fib_nh_dev,
+						      &nh->fib_nh_gw6);
 		else
 			n = NULL;
 		if (n)
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 223e5efa5ac7..fb397fbb28fc 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1344,7 +1344,7 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 		case ICMP_AFI_IP6:
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
-			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
 			dev_hold(dev);
 			break;
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c942f1282236..9703e67d552a 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <net/arp.h>
-#include <net/ipv6_stubs.h>
+#include <net/ip6_route.h>
 #include <net/lwtunnel.h>
 #include <net/ndisc.h>
 #include <net/nexthop.h>
@@ -510,7 +510,7 @@ static void nexthop_free_single(struct nexthop *nh)
 		fib_nh_release(nh->net, &nhi->fib_nh);
 		break;
 	case AF_INET6:
-		ipv6_stub->fib6_nh_release(&nhi->fib6_nh);
+		fib6_nh_release(&nhi->fib6_nh);
 		break;
 	}
 	kfree(nhi);
@@ -1367,7 +1367,7 @@ static bool ipv6_good_nh(const struct fib6_nh *nh)
 
 	rcu_read_lock();
 
-	n = __ipv6_neigh_lookup_noref_stub(nh->fib_nh_dev, &nh->fib_nh_gw6);
+	n = __ipv6_neigh_lookup_noref(nh->fib_nh_dev, &nh->fib_nh_gw6);
 	if (n)
 		state = READ_ONCE(n->nud_state);
 
@@ -1401,7 +1401,7 @@ static bool nexthop_is_good_nh(const struct nexthop *nh)
 	case AF_INET:
 		return ipv4_good_nh(&nhi->fib_nh);
 	case AF_INET6:
-		return ipv6_good_nh(&nhi->fib6_nh);
+		return IS_ENABLED(CONFIG_IPV6) && ipv6_good_nh(&nhi->fib6_nh);
 	}
 
 	return false;
@@ -2151,8 +2151,8 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 		fib6_info_hold(f6i);
 
 		spin_unlock_bh(&nh->lock);
-		ipv6_stub->ip6_del_rt(net, f6i,
-				      !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
+		ip6_del_rt(net, f6i,
+			   !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
 
 		spin_lock_bh(&nh->lock);
 	}
@@ -2208,8 +2208,11 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 	if (!list_empty(&nh->fi_list))
 		rt_cache_flush(net);
 
-	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_update_sernum(net, f6i);
+	list_for_each_entry(f6i, &nh->f6i_list, nh_list) {
+		spin_lock_bh(&f6i->fib6_table->tb6_lock);
+		fib6_update_sernum_upto_root(net, f6i);
+		spin_unlock_bh(&f6i->fib6_table->tb6_lock);
+	}
 
 	/* if an IPv6 group was replaced, we have to release all old
 	 * dsts to make sure all refcounts are released
@@ -2223,7 +2226,7 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 		struct nh_info *nhi = rtnl_dereference(nhge->nh->nh_info);
 
 		if (nhi->family == AF_INET6)
-			ipv6_stub->fib6_nh_release_dsts(&nhi->fib6_nh);
+			fib6_nh_release_dsts(&nhi->fib6_nh);
 	}
 }
 
@@ -2504,7 +2507,7 @@ static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
 	}
 
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_rt_update(net, f6i, info);
+		fib6_rt_update(net, f6i, info);
 }
 
 /* send RTM_NEWROUTE with REPLACE flag set for all FIB entries
@@ -2877,13 +2880,12 @@ static int nh_create_ipv6(struct net *net,  struct nexthop *nh,
 		fib6_cfg.fc_flags |= RTF_GATEWAY;
 
 	/* sets nh_dev if successful */
-	err = ipv6_stub->fib6_nh_init(net, fib6_nh, &fib6_cfg, GFP_KERNEL,
-				      extack);
+	err = fib6_nh_init(net, fib6_nh, &fib6_cfg, GFP_KERNEL, extack);
 	if (err) {
 		/* IPv6 is not enabled, don't call fib6_nh_release */
 		if (err == -EAFNOSUPPORT)
 			goto out;
-		ipv6_stub->fib6_nh_release(fib6_nh);
+		fib6_nh_release(fib6_nh);
 	} else {
 		nh->nh_flags = fib6_nh->fib_nh_flags;
 	}
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 463236e0dc2d..bc1296f0ea69 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -446,8 +446,8 @@ static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 
 	if (rt->rt_gw_family == AF_INET) {
 		pkey = (const __be32 *)&rt->rt_gw4;
-	} else if (rt->rt_gw_family == AF_INET6) {
-		return __ipv6_confirm_neigh_stub(dev, &rt->rt_gw6);
+	} else if (IS_ENABLED(CONFIG_IPV6) && rt->rt_gw_family == AF_INET6) {
+		return __ipv6_confirm_neigh(dev, &rt->rt_gw6);
 	} else if (!daddr ||
 		 (rt->rt_flags &
 		  (RTCF_MULTICAST | RTCF_BROADCAST | RTCF_LOCAL))) {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2cc6d059b692..443a1fbb9cc7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -118,9 +118,6 @@
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
 #include <net/gro.h>
-#if IS_ENABLED(CONFIG_IPV6)
-#include <net/ipv6_stubs.h>
-#endif
 #include <net/rps.h>
 
 struct udp_table udp_table __read_mostly;
@@ -2855,7 +2852,7 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
 
 	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
 		if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
-			new_gro_receive = ipv6_stub->xfrm6_gro_udp_encap_rcv;
+			new_gro_receive = xfrm6_gro_udp_encap_rcv;
 		else
 			new_gro_receive = xfrm4_gro_udp_encap_rcv;
 
@@ -2927,7 +2924,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
 				WRITE_ONCE(up->encap_rcv,
-					   ipv6_stub->xfrm6_udp_encap_rcv);
+					   xfrm6_udp_encap_rcv);
 			else
 #endif
 				WRITE_ONCE(up->encap_rcv,
-- 
2.53.0


