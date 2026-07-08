Return-Path: <netdev+bounces-305961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fN7hD6SaTmrEQQIAu9opvQ
	(envelope-from <netdev+bounces-305961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:44:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972C729A76
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:44:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=IE2a027U;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=gGffsM8U;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305961-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305961-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9919C302AA54
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8D4D90B8;
	Wed,  8 Jul 2026 18:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A34C8FF3;
	Wed,  8 Jul 2026 18:40:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536022; cv=none; b=tv2ZuCMd+SgBwbrl/hRRzTogp3L4wxfsNJ0tNlSsIp4i8tlrh5gkK4TLAtV12VaasrmmKv65NG1eCC79tcH0ksfJof1bMWAZRh1XcpNVUDWe3EiFNrsXiSsdBZil8bjud0yKKRqFakkzvX8XrObuE2MUqcaVe5f+i6Lg3xsWZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536022; c=relaxed/simple;
	bh=obt54fPgdLi3KjKXUE0BNPJu/tu7RmtcNQLTOwpe7as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BrikjJqM1pdCafs3BURzzDBs1Sf3ZaqJVrXruzKUTIwIqTHU8Fst38pO363xvgsEtZw5NVVY+6XV9pYUMdd6XnR1lC1oY0BjtI8BjLQlCBIpWiWxpuFwgMqK41BV7t/yAr/mbZLbPAUsftYpgi6aZlEFCxq4AssURtFEwj5Pxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=IE2a027U; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=gGffsM8U; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536012;
	bh=obt54fPgdLi3KjKXUE0BNPJu/tu7RmtcNQLTOwpe7as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IE2a027UwND8OIZndIA1yorV6jZLj9jencRtgMllpEGi+EMWpouRY4wdutPi0QInH
	 +jGulHd6H7i4kLfqjf3bt/U1H+wt+ZPi2QDDlD9UEQe7N7+OLiCHtPAOgk3Zt4nu5Y
	 pk4pbnrb3M1QOfk+pH3GA0WEvGz/zm1rhESAVgtaQXk9CJjXTIG0ZlEof5zWQepQdq
	 ltIAYHq2x5JGhlGca+RvN9XCsVzCMFpyn5zmdnfnvVp8sAf8YQ+Wc0XDL1PBYGdq2W
	 VDsP7fNXPBdGeciLkJrsbKTmhL7rZ3Kf+3EGnlPyoyTI18e1tifbIDDZ8m/QMkbLzZ
	 pN9FIARKlyaeQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D777549442; Wed,  8 Jul 2026 18:40:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536006;
	bh=obt54fPgdLi3KjKXUE0BNPJu/tu7RmtcNQLTOwpe7as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gGffsM8UkJSIviUg7cy+LeXF8Z/RxwsP8LpVzKFpA3yFLuY8Qzer9b/HTaHVQSGvC
	 C25BjRcknEq08C4M+qy/O5ojs0csoakSXy9hhyOmbTsPNGoNHSwOVR1B9iFvNjZTUV
	 IQ/iEBm8ExH84KF8MUY6OBpfryRszyAgO9itccl/wqhz83g9pRAGi3CbJwmUqG8m7M
	 25AdQq9biyoYSakIyWJ10dDcNMlSKFiANuviuTRTe4Fdf+lEsncf89y+ezWMUvetGw
	 Nt9PJe4qpmE3l7aFwZcv830oQexLTsBBLivuDeSHtDuahsD1m21ZkFohkxGeABeLXR
	 hHGo2K0aWrj7w==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 647E7493E3;
	Wed,  8 Jul 2026 18:40:06 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:14 +0200
Subject: [PATCH net-next v2 08/12] ax88179_178a: Add support for ethtool
 pause parameter configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-8-0800fedb2e16@birger-koblitz.de>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
In-Reply-To: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@birger-koblitz.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3972C729A76

The AX179A-based chips support pause parameter configuration.
Make it available through ethtool ops.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 5f3a6d85cc4054e43e085531fcd715a990d87c6a..925b66f8b8fff10578056bb13e15dc4ba0f88ecc 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -973,6 +973,52 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 	return mii_ethtool_set_link_ksettings(&dev->mii, cmd);
 }
 
+static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
+	pause->autoneg = data->pause_autoneg;
+	pause->tx_pause = data->pause_tx;
+	pause->rx_pause = data->pause_rx;
+}
+
+static int ax88179a_set_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	u16 old, new, bmcr;
+	u8 cap = 0;
+
+	data = dev->driver_priv;
+
+	if (data->chip_version < AX_VERSION_AX88179A)
+		return -EOPNOTSUPP;
+
+	bmcr = ax88179_mdio_read(net, dev->mii.phy_id, MII_BMCR);
+	if (pause->autoneg && !(bmcr & BMCR_ANENABLE))
+		return -EINVAL;
+
+	data->pause_autoneg = pause->autoneg;
+	data->pause_tx = pause->tx_pause;
+	data->pause_rx = pause->rx_pause;
+
+	if (pause->rx_pause)
+		cap |= FLOW_CTRL_RX;
+
+	if (pause->tx_pause)
+		cap |= FLOW_CTRL_TX;
+
+	old = ax88179_mdio_read(net, dev->mii.phy_id, MII_ADVERTISE);
+	new = (old & ~(ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM)) |
+		mii_advertise_flowctrl(cap);
+	if (old != new)
+		ax88179_mdio_write(net, dev->mii.phy_id, MII_ADVERTISE, new);
+
+	return mii_nway_restart(&dev->mii);
+}
+
 static int
 ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
@@ -1144,6 +1190,8 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= ax88179_get_link_ksettings,
 	.set_link_ksettings	= ax88179_set_link_ksettings,
+	.get_pauseparam		= ax88179a_get_pauseparam,
+	.set_pauseparam		= ax88179a_set_pauseparam,
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 

-- 
2.47.3


