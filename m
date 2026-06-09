Return-Path: <netdev+bounces-297245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JK0MNcJkKGrsDAMAu9opvQ
	(envelope-from <netdev+bounces-297245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9504663875
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kWkL45w/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297245-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297245-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EA1230190B7
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E534D8D96;
	Tue,  9 Jun 2026 19:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B84CA29C
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:08:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032092; cv=none; b=jcygVxuJE2G7IemxxbBWInUIjv2CTKaAi+FKIFDDlsh951tL9ASdM0/pPPhJzSNU5hFMUIDCVRiI/qD5FmIlQBa8feE3d/jChXEnXmFXBarGPNztwAzLQTzXU8w7fEbUrffHGJn+AURjGe4Z5Jt5y32fLKaqsoeikcgV3JWc4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032092; c=relaxed/simple;
	bh=nlwtcxXtdlWDBQvHdYCXl5s0p6C3lur+YjX93OBYcm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q835pO1pHgi4oYgPq25+sjGZ2IOVeiy/MWHrX2VLM7a0LWPrTK7KDU7ZBU7WqbQm9XfaJwbFsz6d5xP+rLn2ldT9cPrCxUmhtcYAnQsSD5UCXcmjFgmZiQSI3WpczeeMqED4UH7fASCXujbWZdinVo5Y1aBCl6fQHm1LnJOQVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWkL45w/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14A51F00893;
	Tue,  9 Jun 2026 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032091;
	bh=GVxi1mVoUgaSl/yFAFc3UoriW9Jty4zjW3nu+EeuZAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWkL45w/LS+d4cCnm93KwM3U4rc4Eemm9laE+ZkAcbKlJdz0MQ/wKy/Gqs/KP/ol/
	 8Dh/ceL7nM7cc7+lfmA41NdBLsi3QeZdJfP8jgMxoFXPr1tJaRckqLCSDMQ3ahm6eY
	 1B28eGoaTKlp1o9cS24aIoEJkgML/MKo5jFqqVT/X+M9td44nAwqwd7oWBUTHkAY2M
	 jtV6AHBTi/KTWmzrJhtQyLZgmt5ZNK0+4xX/J8wRf7WxOXZA5rA7M94rOYoCj5zsH/
	 rpTcvILLj4vpeio+NYYgU/3JTnTq7Y4h4sMtHCkY3eB5UwLBtzHbXuJuOJfzya8T2M
	 JXbX5FGvx7CXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	razor@blackwall.org,
	sdf@fomichev.me,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] netdev: avoid skipping objects on race with device disappearance
Date: Tue,  9 Jun 2026 12:08:03 -0700
Message-ID: <20260609190804.1137085-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609190804.1137085-1-kuba@kernel.org>
References: <20260609190804.1137085-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9504663875

If the currently dumped device disappears while we were mid-dump
we will get the next device without resetting the sub-object ID.
This is quite unlikely, it was reported by an AI tool not a real
user. Let's fix it for better dump consistency.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index d35af460e886..18046ad0f883 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -310,11 +310,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			err = -ENODEV;
 		}
 	} else {
+		unsigned long start_ifindex = ctx->ifindex;
+
 		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
+			if (ctx->ifindex != start_ifindex)
+				ctx->napi_id = 0;
 			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
-			ctx->napi_id = 0;
 		}
 	}
 
@@ -634,13 +637,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			err = -ENODEV;
 		}
 	} else {
+		unsigned long start_ifindex = ctx->ifindex;
+
 		for_each_netdev_lock_ops_compat_scoped(net, netdev,
 						       ctx->ifindex) {
+			if (ctx->ifindex != start_ifindex) {
+				ctx->rxq_idx = 0;
+				ctx->txq_idx = 0;
+			}
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
-			ctx->rxq_idx = 0;
-			ctx->txq_idx = 0;
 		}
 	}
 
@@ -786,8 +793,6 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 		ctx->txq_idx = ++i;
 	}
 
-	ctx->rxq_idx = 0;
-	ctx->txq_idx = 0;
 	return 0;
 }
 
@@ -902,6 +907,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
 	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(skb->sk);
+	unsigned long start_ifindex;
 	struct net_device *netdev;
 	unsigned int ifindex;
 	unsigned int scope;
@@ -934,7 +940,13 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 		return err;
 	}
 
+	start_ifindex = ctx->ifindex;
+
 	for_each_netdev_lock_ops_compat_scoped(net, netdev, ctx->ifindex) {
+		if (ctx->ifindex != start_ifindex) {
+			ctx->rxq_idx = 0;
+			ctx->txq_idx = 0;
+		}
 		err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
 						    info, ctx);
 		if (err < 0)
-- 
2.54.0


