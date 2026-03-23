Return-Path: <netdev+bounces-270350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPANI6mlwGlRJgQAu9opvQ
	(envelope-from <netdev+bounces-270350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:30:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8692EBEBE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8577300A624
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41622B8AB;
	Mon, 23 Mar 2026 02:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334522A4E9;
	Mon, 23 Mar 2026 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232996; cv=none; b=S0r+m2FjUaOshstLSoL1h2dxPfh8x3ned0q5AoFCQybM0b39TU/LbBDjpotHjETg2eL1j9K8pJZ+3zRPHQV47oRjZZn7thoIflPzbpbB+gtVSiJd0kuKON93gAO8Fm90tza/3AFfuwMMnmEyA84h4VNEY7+W/rfBVp4pyNTXgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232996; c=relaxed/simple;
	bh=ihtkEUiOdCaC+V5d+FLXjPvgY+A59gk2spRXkET4HFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVI9KgXpITjT1msCmJsWOqKl0CCZ0mkE4i7ct1NzB5GO0BTrhC1n6UXzn/O+A0ONaTYg0XGmXlroQI7cCiCUuURMmdKlT+TGBMkNUbo0gsG8FetAbz0w0C0wPK8NeZIUcGh/4wxj+MMIGQ9CuAWcUL0WGHxZoxMKgSX/dqRjM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w4V33-000000005Cf-1R1b;
	Mon, 23 Mar 2026 02:29:45 +0000
Date: Mon, 23 Mar 2026 02:29:41 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v6 2/4] net: dsa: add bridge member iteration
 macro and port mask helper
Message-ID: <acCllYmKczZrDgv9@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270350-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 3B8692EBEBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:19:06AM +0000, Daniel Golle wrote:
> Drivers that offload bridges need to iterate over the ports that are
> members of a given bridge, for example to rebuild per-port forwarding
> bitmaps when membership changes. Currently each driver must open-code
> this by combining dsa_switch_for_each_user_port() with a
> dsa_port_offloads_bridge() check, or cache bridge membership within
> the driver.
> 
> Add dsa_bridge_for_each_member() to express this pattern directly, and
> a dsa_bridge_ports() helper that returns a bitmask of member ports,
> matching the existing dsa_user_ports() and dsa_cpu_ports() helpers.
> [...]
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 1c6f6c3b88e86..4f43d518f3de3 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -838,6 +838,22 @@ static inline bool dsa_port_tree_same(const struct dsa_port *a,
>  	return a->ds->dst == b->ds->dst;
>  }
>  
> +#define dsa_bridge_for_each_member(_dp, _ds, _bridge) \
> +	dsa_switch_for_each_user_port((_dp), (_ds)) \
> +		if (dsa_port_offloads_bridge((_dp), (_bridge)))
> +
> +static inline u32 dsa_bridge_ports(struct dsa_switch *ds,
> +				   const struct dsa_bridge *bridge)
> +{

I wasn't aware of the similar and equally named function in
yt921x.c[1]

Patchwork CI has loudly uncovered it and I've learned my lesson to
always test an all-y build when changing even the most innocent
looking things which technically may affect other drivers.

I'll move that function as-is, in a dedicated commit, to
include/net/dsa.h as an inline function instead of the helper
suggested here.

A second commit will introduce the new helper macro
dsa_switch_for_each_bridge_member (modified to use (struct net_device
*) as parameter instead of (struct dsa_bridge *), and make use of it
in dsa_bridge_ports().

I'm also planning to introduce dsa_bridge_for_each_member macro in
addition to that which works on (struct dsa_bridge *) and uses
dsa_switch_for_each_bridge_member.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/dsa/yt921x.c?id=fb78a629b4f0eb399b413f6c093a3da177b3a4eb#n2158

In code, it's going to look like this:
diff --git a/include/net/dsa.h b/include/net/dsa.h
index b43fa7a708c72..c10f05f3e96ed 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -832,15 +832,21 @@ dsa_tree_offloads_bridge_dev(struct dsa_switch_tree *dst,
 	return false;
 }
 
+#define dsa_switch_for_each_bridge_member(_dp, _ds, _bdev) \
+	dsa_switch_for_each_user_port(_dp, _ds) \
+		if (dsa_port_offloads_bridge_dev(_dp, _bdev))
+
+#define dsa_bridge_for_each_member(_dp, _ds, _db) \
+	dsa_switch_for_each_bridge_member(_dp, _ds, (_db)->dev)
+
 static inline u32
 dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
 {
 	struct dsa_port *dp;
 	u32 mask = 0;
 
-	dsa_switch_for_each_user_port(dp, ds)
-		if (dsa_port_offloads_bridge_dev(dp, bdev))
-			mask |= BIT(dp->index);
+	dsa_switch_for_each_bridge_member(dp, ds, bdev)
+		mask |= BIT(dp->index);
 
 	return mask;
 }

Please let me know if any objections you may have.

