Return-Path: <netdev+bounces-286334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILT6Egu2AGplLwEAu9opvQ
	(envelope-from <netdev+bounces-286334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:44:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B11345052A9
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD88301DCFB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108AC3B2FE5;
	Sun, 10 May 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="l54nS5wC"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DB3B27F5;
	Sun, 10 May 2026 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431451; cv=none; b=rOVemD8/KchZqVqNDBCh9YSRN/GIanFafrRT0RVPmUClUpJNSEW3MkJsTNznTA5Z9v+iahzQsbV+x5QEroXYlfbUjGmsW3bAv6wvWPJ6oKUNd9CyIvanlnx2PTyhDEclXqz2FhHb0NBUaZB1CSRhlVoOr1Xnj2v3AC/m0Ed+C8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431451; c=relaxed/simple;
	bh=4/+8QLEncpuEUOX7PYCCSu0mx8Wt5d/8m7jFzOWwAyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLr3msNx0jwCsRjiloyISx1c4lR9a3obpfI57FLdYIjPyTxPG6vx7t6masBwdIBxjStDgsOD9YfJUpia5CqqMKOpvz7MYh9kXHeW10CyNSkux74B8Sisc1k1jopdDG6xpQH86MFAcw9sMzqq+DMdI9lOWF1sq+4bU7grxqE6cbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=l54nS5wC; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gD7wm6V7GzDqRS;
	Sun, 10 May 2026 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778431449; bh=9Dfuf2Fb5LqtwjiOhAGj85YmoBeMhXw0q2RtB+ZpCP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l54nS5wCwgV5uREiqWzT2M+LghiaxH7VYvxLsvCx+/mrq343BcDUR93VV7umlLIIL
	 YFsDDKY0XaP5EIEaYfYGHv30dR5CwgMGSp/UlWrVcPI3Uc2L57MNy2fwVi8Vo/UC8o
	 hwZPbnQAnt+FAB/TfJ3DZLlF/19pZMGhKnLD9o9s=
X-Riseup-User-ID: BEE4564464BC4EADF34C685272FF5A21964A9420FB28BA70DD76A19C63D9ABD3
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4gD7wj11dfz1yDs;
	Sun, 10 May 2026 16:44:04 +0000 (UTC)
From: =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Filip Pokryvka <fpokryvk@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
Subject: [PATCH net-next 2/5] netdevsim: allow changing carrier state via sysfs
Date: Sun, 10 May 2026 18:43:34 +0200
Message-ID: <20260510164337.7611-3-ihuguet@riseup.net>
In-Reply-To: <20260510164337.7611-1-ihuguet@riseup.net>
References: <20260510164337.7611-1-ihuguet@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B11345052A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@riseup.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riseup.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:email,riseup.net:mid,riseup.net:dkim]
X-Rspamd-Action: no action

Currently it is only possible to change it by linking a peer netdevsim
and setting the peer's state to down.

Allow to change the carrier state when having a single netdevsim device
without any peer, by writing to it's carrier attribute in sysfs:
/sys/bus/netdevsim/devices/netdevsimX/net/eniYynpZ/carrier. This might
be useful for carrier related tests where a peer device is not needed
for anything else.

If it's linked with a peer, change the carrier of both, while they stay
administratively up. The alternative would be to return EOPNOTSUPP, but
that doesn't seem very intuitive. Also, there is no reason why it should
not be supported, it simulates the cable being cut or disconnected, for
example.

Signed-off-by: Íñigo Huguet <ihuguet@riseup.net>
---
 drivers/net/netdevsim/netdev.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a750768912b5..4f77c9171b06 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -616,6 +616,28 @@ static void nsim_shaper_cap(struct net_shaper_binding *binding,
 	*flags = ULONG_MAX;
 }
 
+static int nsim_change_carrier(struct net_device *dev, bool new_carrier)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer;
+
+	netdev_assert_locked(dev);
+
+	peer = rtnl_dereference(ns->peer);
+
+	if (new_carrier) {
+		netif_carrier_on(dev);
+		if (peer)
+			netif_carrier_on(peer->netdev);
+	} else {
+		netif_carrier_off(dev);
+		if (peer)
+			netif_carrier_off(peer->netdev);
+	}
+
+	return 0;
+}
+
 static const struct net_shaper_ops nsim_shaper_ops = {
 	.set			= nsim_shaper_set,
 	.delete			= nsim_shaper_del,
@@ -645,6 +667,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_stop		= nsim_stop,
 	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
+	.ndo_change_carrier     = nsim_change_carrier,
 	.net_shaper_ops		= &nsim_shaper_ops,
 };
 
-- 
2.53.0


