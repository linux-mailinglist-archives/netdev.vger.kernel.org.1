Return-Path: <netdev+bounces-295495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x5o+GpwYImrKSQEAu9opvQ
	(envelope-from <netdev+bounces-295495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC66441DA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hUSpwn6P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295495-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295495-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FDB0301B302
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84DF2580F3;
	Fri,  5 Jun 2026 00:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838423AE62
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619383; cv=none; b=ff/qX+RhjYWsV6CnCLuS520nlwRqgzkLPlf6BaW76z8JbcvSAZM+69oTMvtAbXBwUrWlSOLt0O3pXhNdCkcaucYhFGy7/ST39AV77nP6m18g5/klqJcHad1t0qk7FHoYFhSmK/RIu2T6S2lsjwHkTJEdvY5hAHrZIkrpsXqeDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619383; c=relaxed/simple;
	bh=0wid0A1WEddsxRmojrquvMvKMMDVKTOnKlJaFTHZbSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACB3je6RrS2HK5WnM1ayfMeng7H/coBjTLyMclTZEt7J/XKP3dhH5EAsRIudhwAI8/VuaBmKvQgnKua4g4TinLSrzGJ9QrmILRUXFNWTnnQE8/t3Qb1LJVMrqDVl/tdI/cfp/QyfqmA6K1lHHvMfeTDM8FBUWzVLuqIwek8uFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUSpwn6P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59651F00899;
	Fri,  5 Jun 2026 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619382;
	bh=Am0LcCQo3hex/flMBZ8cx5LktRiogWaGlPeQ36V8VDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hUSpwn6PJV85g9X6n1G0ab26EfS6eH7JLUxkBysXu3BfUVvJkXJm65CrkLMfvZuSo
	 PEvgmaqma2m409zvquKfQY20fXs/8JnZPZ+tr1FGhUjcO7cqodmrmbqn8A0aN1FDE+
	 3jA9MS0r+Ed9j3nLEPBmcprAvP8CtSz6GcMaGQyYJZvd/R4xqUtUPA9efOL7wXGEyi
	 kg0ssJCSoR9X9wm7jbXhQw5dHP4svPoUrXC4IZVaOeV3lFGXxcvzEcRaYjXS6VQhb0
	 vJSwihpIMo+zxk/XRWNXXwdWAHUOPxhQOzwF71NbKfPCNUrWmwyIFy/rtZwru33+XF
	 9BFdwcCWy5KrQ==
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
Subject: [PATCH net-next v2 07/12] net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
Date: Thu,  4 Jun 2026 17:29:07 -0700
Message-ID: <20260605002912.3456868-8-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46FC66441DA

ethnl_tsinfo_dumpit() iterates netdevs and per-netdev PHY topology
calling ops->get_ts_info(). Switch to the "ops compat locking"
helpers which take either rtnl_lock or instance lock, depending
on what the device needs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/tsinfo.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 14bf01e3b55c..c9b680a9cc3f 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -6,6 +6,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <net/netdev_lock.h>
 
+#include "../core/dev.h"
 #include "bitset.h"
 #include "common.h"
 #include "netlink.h"
@@ -473,28 +474,25 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
-	struct net_device *dev;
 	int ret = 0;
 
-	rtnl_lock();
 	if (ctx->req_info->base.dev) {
-		dev = ctx->req_info->base.dev;
-		netdev_lock_ops(dev);
+		struct net_device *dev = ctx->req_info->base.dev;
+
+		netdev_lock_ops_compat(dev);
 		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
-		netdev_unlock_ops(dev);
-	} else {
-		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
-			netdev_lock_ops(dev);
-			ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
-			netdev_unlock_ops(dev);
-			if (ret < 0 && ret != -EOPNOTSUPP)
-				break;
-			ctx->pos_phyindex = 0;
-			ctx->netdev_dump_done = false;
-			ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
-		}
+		netdev_unlock_ops_compat(dev);
+		return ret;
+	}
+
+	for_each_netdev_lock_ops_compat_scoped(net, dev, ctx->pos_ifindex) {
+		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			break;
+		ctx->pos_phyindex = 0;
+		ctx->netdev_dump_done = false;
+		ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
 	}
-	rtnl_unlock();
 
 	return ret;
 }
-- 
2.54.0


