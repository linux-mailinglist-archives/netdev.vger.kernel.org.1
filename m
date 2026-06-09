Return-Path: <netdev+bounces-297243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xxu2J6ZkKGrdDAMAu9opvQ
	(envelope-from <netdev+bounces-297243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4D663864
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ji4d56+1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297243-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297243-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E8A303515F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10084CA298;
	Tue,  9 Jun 2026 19:08:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945049250F
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:08:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032091; cv=none; b=f9OG3bVvnuKuaptnwFJ6Hz5XRwO1dhh9zLNZ7ZZF9HLcBAUzqnUKLuzQyUPXXBtZ5gZTWvvaMUMAdUqspM3Qer5SRZBOT4sj5HyiLMk6qSTiBGmg/RkWqf9PNKW5Z4MlsC4REBlmtD742Ic+v/8ik3DhlDYP53osv2T8R1Wlp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032091; c=relaxed/simple;
	bh=j5WMTiKhxhndJMMyS/eRFM/WXiN4R7F9bGqxOF07IIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUt1pKp+iWtWj7EWN74B6OMOtaklLnGWfE5cFQ/LlQJBJzGEN5tOgtp9Si1k9gffYIuP+aJEwNW3eOkT20N6UVkf671FyuctAf9diE4jqOWxUqgOgHVS3nVvU4CNYoj3e1GhXxRGybN0FyZeJld1uqVUgsllYia389NMCe08k0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji4d56+1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BFA1F0089A;
	Tue,  9 Jun 2026 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032090;
	bh=WFy07Js8oj31HoQHmt91qWKBzEudU8JL6WULdyGYn+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ji4d56+1UeJvjK5MJ270Mgc3V2FOWWCXlsXmhZpVk/o9mCvW2pZXCxkG4Y6DD3zTR
	 hbVDBlkFSc/iOEZ1rLP6wlhJ4cT+R9Q5vl4pCct6r9DGUNOJvDGkH17/XKKL2XHv87
	 4Co5iE5CPe8x1vXubW43Q9XJYopqyAdiVmjng2HB14ZXx0F+EX2AB6u3NvyG3EEC31
	 IdnClXrbcGAs+XO2oQ9d7b8BUYUTwvudwDUEQWpJPZihfIJFdExp6XILTKOI2ZVel2
	 G60mGaxMeIRZdVBNlSZSBUgEa3/fQuq7YR3Sa6/k5/fz7GYQvJwbl+bAra+vwIej+a
	 JXY3iE/LFuVIQ==
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
Subject: [PATCH net-next 1/4] netdev: check for nla_put_u32() failures
Date: Tue,  9 Jun 2026 12:08:01 -0700
Message-ID: <20260609190804.1137085-2-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297243-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EE4D663864

Make sure we check if nla_put_u32(id) was successful after creating
objects. This is theoretical today, the skbs are large enough to
always fit the ID.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b4d48f3672a5..a10d353d5eab 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1091,7 +1091,10 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 			goto err_unbind;
 	}
 
-	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	if (err)
+		goto err_unbind;
+
 	genlmsg_end(rsp, hdr);
 
 	err = genlmsg_reply(rsp, info);
@@ -1227,7 +1230,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_bind_dev;
 	}
 
-	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	if (err)
+		goto err_unbind;
+
 	genlmsg_end(rsp, hdr);
 
 	if (bind_dev != netdev)
@@ -1237,6 +1243,8 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	return genlmsg_reply(rsp, info);
 
+err_unbind:
+	net_devmem_unbind_dmabuf(binding);
 err_unlock_bind_dev:
 	if (bind_dev != netdev)
 		netdev_unlock(bind_dev);
@@ -1394,7 +1402,12 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	netdev_rx_queue_lease(rxq, rxq_lease);
 
-	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
+	err = nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
+	if (err) {
+		WARN_ON_ONCE(1); /* we can't delete the queue, ID must fit in */
+		goto err_unlease;
+	}
+
 	genlmsg_end(rsp, hdr);
 
 	netdev_unlock(dev_lease);
@@ -1404,6 +1417,8 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	return genlmsg_reply(rsp, info);
 
+err_unlease:
+	netdev_rx_queue_unlease(rxq, rxq_lease);
 err_unlock_dev_lease:
 	netdev_unlock(dev_lease);
 err_put_netns:
-- 
2.54.0


