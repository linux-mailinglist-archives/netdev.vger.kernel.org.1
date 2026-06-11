Return-Path: <netdev+bounces-298340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tOveGVYcK2pI2wMAu9opvQ
	(envelope-from <netdev+bounces-298340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D067533F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:36:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=i5RCYL5a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298340-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298340-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E96813396930
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF43AB292;
	Thu, 11 Jun 2026 20:35:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F1366DA3
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:34:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210100; cv=none; b=HhbdiVYH0wwgiWmywZUT84Rgj62BneZ5nUqxSf9bfEhg9J9U5VrTA8NjngxnsJd2oapEV3NKv5Ru7S0HZoO4Z13Hz67iI8QM2pSm5JZr6kapYHRP6GjGtiOPLAUlb5Rw0ua8ytXHDryu4BP1KlAvZsl7qDoooMLPDb8bWi039BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210100; c=relaxed/simple;
	bh=x7a03Gc9vw9i8Ku3llVRmtESmRhe9DOjaGr/3KnfCWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RqBPSEQQtHVQuAU7l+zSgxxPhsnJMWwjE4y3+I1t5G+PCWS10UGiIrTQA8jYCYC8T+bhbKVX1CXAwGCCABwTwbYtFtnZ+ZLH9UbVqCstpEF+1CuRLHkdjYCoU9vFH0x/b8eUmP65tR+Xjj41h5vLTzosjrqvZP3JaUlc87KNca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5RCYL5a; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8cec2c6b821so5646666d6.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210098; x=1781814898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/QFyfjXw3n87JG9bfd2LhPET1TQiuubzBf1WnNtO7o=;
        b=i5RCYL5aHX+Hzpl4LnqbAoCY23aAf1dNJvyU29aHYqyHmss3Qk6UPgFHEiTEKXcxoK
         zsNMSe0bsQuNywv1gJv/Ajr9IXi10nzq3vwXIIakiSGKmeKUkdUPfJPXfTAWKrXdsAOp
         kQkvvzWHco5LnV/h1yOiNGXOJt14Pv3grPGH6fsVyi91ed0EyhNmwH06wuKNLilNQKPH
         T4q1R7UQVJ0Cztfvn2iDkE/bm0jkd8+naKzYKw6YFb35J16L4LVN6W/3L899WLVXM9h1
         OHXUFBIfe+Z5sBZppKpWBjlC1mqUNn8XhfrxY5zo8+yhPNAYDtgxVsS6O/uJ+sO6hzcR
         CCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210098; x=1781814898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/QFyfjXw3n87JG9bfd2LhPET1TQiuubzBf1WnNtO7o=;
        b=opNYljCsKlyAadpycJgpfsd596fBS0D3yMU0Qou5e1L86jesS3tN6cbhPC2M34N8rp
         afKdE5q+jM/M6C/0/1Fact+JJAJGbQWZKT08bXJzpemimeiPnCLJbLO+1CCn4gurypiq
         AOzpX/7HvARPglnfr50Tlyulbn/Sz9K4oF7t7Wn5xVFOXHiFzOKoYwUoZY575kaEG6yJ
         MKLms2V7Jfg3g7g70tEUaxxuGXMIC7m7lMNy7aQP2rMXaF6exFLaBK7uwjBIF0HJMxOi
         yUIUz/gBOsatQKXw2GRz56m06c8eGwcLJX6orjzlq6LbGV3KeHABXniASrrQVTcO/A6W
         eH3w==
X-Forwarded-Encrypted: i=1; AFNElJ8hR9oZefzRcEQG+Lg+WlJnKguHNYCWznTSgbz+4AC8wofLk3Nl5R/lxUq1IR02S1PFFfmg/Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxkIOxU2cw0MblSvqcjfrdNVXDBPKI9ziMS2sYtpIL732ICNr
	wMACoMV1X58NObhz8s7DYDKIjzxj0bAZsAAktlfiPkD8dJ4Wt3/2VKHtrhpZ37E9USQiU4wP0oy
	poxNS98pH7jHxDw==
X-Received: from qvae28.prod.google.com ([2002:a05:6214:621c:b0:8cc:eb4b:3535])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:621:b0:8d1:5830:6666 with SMTP id 6a1803df08f44-8d32b47a72bmr276986d6.1.1781210097845;
 Thu, 11 Jun 2026 13:34:57 -0700 (PDT)
Date: Thu, 11 Jun 2026 20:34:50 +0000
In-Reply-To: <20260611203453.3067462-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611203453.3067462-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611203453.3067462-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/5] bridge: use atomic ops to read/change
 p->flags in br_netlink.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298340-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B59D067533F

Change net/bridge/br_netlink.c to use atomic operations
to read/change bits in p->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_netlink.c | 91 +++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 40 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 7cb24de9c77d3d15892723f77288c27a15a6a0ad..2178eb20475c36acc44890cc8384270d376febc3 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -113,7 +113,7 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 	num_vlan_infos = br_get_num_vlan_infos(vg, filter_mask);
 	rcu_read_unlock();
 
-	if (p && (p->flags & BR_VLAN_TUNNEL))
+	if (p && test_bit(BR_VLAN_TUNNEL_BIT, &p->flags))
 		vinfo_sz += br_get_vlan_tunnel_info_size(vg);
 
 	/* Each VLAN is returned in bridge_vlan_info along with flags */
@@ -823,7 +823,7 @@ static int br_afspec(struct net_bridge *br,
 		err = 0;
 		switch (nla_type(attr)) {
 		case IFLA_BRIDGE_VLAN_TUNNEL_INFO:
-			if (!p || !(p->flags & BR_VLAN_TUNNEL))
+			if (!p || !test_bit(BR_VLAN_TUNNEL_BIT, &p->flags))
 				return -EINVAL;
 			err = br_parse_vlan_tunnel_info(attr, &tinfo_curr);
 			if (err)
@@ -934,58 +934,67 @@ static int br_set_port_state(struct net_bridge_port *p, u8 state)
 }
 
 /* Set/clear or port flags based on attribute */
-static void br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
+static void br_set_port_flag(unsigned long *set_flags,
+			     unsigned long *clear_flags,
+			     struct nlattr *tb[],
 			     int attrtype, unsigned long mask)
 {
-	if (!tb[attrtype])
-		return;
-
-	if (nla_get_u8(tb[attrtype]))
-		p->flags |= mask;
-	else
-		p->flags &= ~mask;
+	if (tb[attrtype]) {
+		if (nla_get_u8(tb[attrtype]))
+			*set_flags |= mask;
+		else
+			*clear_flags |= mask;
+	}
 }
 
 /* Process bridge protocol info on port */
 static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 		      struct netlink_ext_ack *extack)
 {
-	unsigned long old_flags, changed_mask;
+	unsigned long old_flags, flags, changed_mask;
+	unsigned long set = 0, clear = 0;
 	bool br_vlan_tunnel_old;
 	int err;
 
-	old_flags = p->flags;
+	old_flags = READ_ONCE(p->flags);
 	br_vlan_tunnel_old = (old_flags & BR_VLAN_TUNNEL) ? true : false;
 
-	br_set_port_flag(p, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
-	br_set_port_flag(p, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_FAST_LEAVE,
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_FAST_LEAVE,
 			 BR_MULTICAST_FAST_LEAVE);
-	br_set_port_flag(p, tb, IFLA_BRPORT_PROTECT, BR_ROOT_BLOCK);
-	br_set_port_flag(p, tb, IFLA_BRPORT_LEARNING, BR_LEARNING);
-	br_set_port_flag(p, tb, IFLA_BRPORT_UNICAST_FLOOD, BR_FLOOD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_FLOOD, BR_MCAST_FLOOD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_TO_UCAST,
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_PROTECT, BR_ROOT_BLOCK);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_LEARNING, BR_LEARNING);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_UNICAST_FLOOD, BR_FLOOD);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_MCAST_FLOOD,
+			 BR_MCAST_FLOOD);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_MCAST_TO_UCAST,
 			 BR_MULTICAST_TO_UNICAST);
-	br_set_port_flag(p, tb, IFLA_BRPORT_BCAST_FLOOD, BR_BCAST_FLOOD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
-	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP_WIFI, BR_PROXYARP_WIFI);
-	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
-	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
-	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
-	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
-	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
-	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_BCAST_FLOOD,
+			 BR_BCAST_FLOOD);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_PROXYARP_WIFI,
+			 BR_PROXYARP_WIFI);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_VLAN_TUNNEL,
+			 BR_VLAN_TUNNEL);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_NEIGH_SUPPRESS,
+			 BR_NEIGH_SUPPRESS);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
 			 BR_NEIGH_VLAN_SUPPRESS);
-	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
+	br_set_port_flag(&set, &clear, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
 			 BR_NEIGH_FORWARD_GRAT);
 
-	if ((p->flags & BR_PORT_MAB) &&
-	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {
+	flags = (old_flags | set) & ~clear;
+
+	if ((flags & BR_PORT_MAB) &&
+	    (!(flags & BR_PORT_LOCKED) || !(flags & BR_LEARNING))) {
 		NL_SET_ERR_MSG(extack, "Bridge port must be locked and have learning enabled when MAB is enabled");
-		p->flags = old_flags;
 		return -EINVAL;
-	} else if (!(p->flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB)) {
+	}
+	if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB)) {
 		struct net_bridge_fdb_flush_desc desc = {
 			.flags = BIT(BR_FDB_LOCKED),
 			.flags_mask = BIT(BR_FDB_LOCKED),
@@ -995,15 +1004,17 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 		br_fdb_flush(p->br, &desc);
 	}
 
-	changed_mask = old_flags ^ p->flags;
+	changed_mask = old_flags ^ flags;
 
-	err = br_switchdev_set_port_flag(p, p->flags, changed_mask, extack);
-	if (err) {
-		p->flags = old_flags;
+	err = br_switchdev_set_port_flag(p, flags, changed_mask, extack);
+	if (err)
 		return err;
-	}
 
-	if (br_vlan_tunnel_old && !(p->flags & BR_VLAN_TUNNEL))
+	do {
+		flags = (old_flags | set) & ~clear;
+	} while (!try_cmpxchg(&p->flags, &old_flags, flags));
+
+	if (br_vlan_tunnel_old && !(flags & BR_VLAN_TUNNEL))
 		nbp_vlan_tunnel_info_flush(p);
 
 	br_port_flags_change(p, changed_mask);
-- 
2.54.0.1136.gdb2ca164c4-goog


