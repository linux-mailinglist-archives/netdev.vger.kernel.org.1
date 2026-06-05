Return-Path: <netdev+bounces-295497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KJ6BHvsYImraSQEAu9opvQ
	(envelope-from <netdev+bounces-295497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:31:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E16386441F6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:31:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fCiEhRQy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295497-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295497-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B5763073D1A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1C23183C;
	Fri,  5 Jun 2026 00:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F552264C7
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619385; cv=none; b=KtoO8M2h0XQdQ54/TvhagAYlDS72MT8WphzQXzheGkJYlUKroG7PCk7PnOj5Ta3Av5GD0PUEnZJev1LwY3Fo303VtoLodzD5ph0HOLT/j1Z5zfX1S4TRUlhaW6QbfPR9cme6A+DmRudiBOHvqqiRfUtZlH9QmDsAYap8y1qP9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619385; c=relaxed/simple;
	bh=v0AHUVjdQ3xnE+kX4akkAvk+cfvNqacdr1IjByuQCUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5iqZO60Q5PsKh2G7Z9kPXlvQUnEA9qH58ODkwh+eWJWi6ugyKxDJH9ZboLUe3rU89A4lugt14B1qMgEPPVkPvCogBc4E/M8EW0GW7MrMRFOPnoBP3244Z2yTjSwPhFhfHk9TSlee4uytPSlYdnBhB3aSwuWZ7CgIPt6N7oySAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCiEhRQy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E70A1F0089B;
	Fri,  5 Jun 2026 00:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619384;
	bh=Og3Ys3Rb98/rutdlhVH60kIpEyGcQjoMYEplyDyrzIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCiEhRQyrbBHCscoe/9JPHY6VZNrcrBLZhsiuQDk5VML0/CvlS3O/SLKM2pdsceDt
	 w3Tj+d0D8jH4K3WscUNL/X7KjnCRFzGVUlyFqHaTD9PS9ev+2Df2hx3OzTJVtfwj//
	 RLJPYob52hhXy813LouInHxzHVDxKtMX5AUele2DaE4Vl3g59Wu1nUWutynSNYpvtG
	 B4wciAuWREUpCrddrKdE1b2GlSpVaAiob5OVE+jBjiDk4K1yK/oW5HIQK8XRi/LMGM
	 jHeyduCaVhNX4lkSGqrJEfPYOYFSwUhKONlXPwASiKR+7jhzkZF/4L11Q48HpnE/AH
	 RSQRk8vbBnN6g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 09/12] net: ethtool: optionally skip rtnl_lock in RSS context handlers
Date: Thu,  4 Jun 2026 17:29:09 -0700
Message-ID: <20260605002912.3456868-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295497-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E16386441F6

Skip rtnl_lock in RSS context handlers if device is ops-locked.
Fairly trivial conversion. bnxt needed rtnl_lock for changing
the main context but looks like additional contexts are fine
without it.

Note (for review bots?) that ethnl_ops_begin() checks whether
the device is still registered.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 65bad23d5c59..d8adc78e3775 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -2,6 +2,7 @@
 
 #include <net/netdev_lock.h>
 
+#include "../core/dev.h"
 #include "common.h"
 #include "netlink.h"
 
@@ -468,21 +469,16 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
 	struct net *net = sock_net(skb->sk);
-	struct net_device *dev;
 	int ret = 0;
 
-	rtnl_lock();
-	for_each_netdev_dump(net, dev, ctx->ifindex) {
+	for_each_netdev_lock_ops_compat_scoped(net, dev, ctx->ifindex) {
 		if (ctx->match_ifindex && ctx->match_ifindex != ctx->ifindex)
 			break;
 
-		netdev_lock_ops(dev);
 		ret = rss_dump_one_dev(skb, cb, dev);
-		netdev_unlock_ops(dev);
 		if (ret)
 			break;
 	}
-	rtnl_unlock();
 
 	return ret;
 }
@@ -1037,8 +1033,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto exit_free_dev;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -1125,8 +1120,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 exit_ops:
 	ethnl_ops_complete(dev);
 exit_dev_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 exit_free_dev:
 	ethnl_parse_header_dev_put(&req.base);
 exit_free_rsp:
@@ -1179,8 +1173,7 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 		goto exit_free_dev;
 	}
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -1210,8 +1203,7 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&dev->ethtool->rss_lock);
 	ethnl_ops_complete(dev);
 exit_dev_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 exit_free_dev:
 	ethnl_parse_header_dev_put(&req);
 	return ret;
-- 
2.54.0


