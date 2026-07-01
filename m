Return-Path: <netdev+bounces-303468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KQItAwCpRGplygoAu9opvQ
	(envelope-from <netdev+bounces-303468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DC6E9E6E
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=lZ3p43k3;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=AzcOo9CG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303468-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303468-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5E8F3014123
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA938F620;
	Wed,  1 Jul 2026 05:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6786370AE5;
	Wed,  1 Jul 2026 05:43:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884581; cv=none; b=gf2QB7qPCi7Apf5vQQvtEYzHKtbx/XWDvo05qXm7kEu7HzpF5FycmmLLzHjQiyV2yL/oqho8oEnroj2Pwp4GM8SNLjO9ZKMXE2iVWRecYAtyo404tgsiF1yOqIUkpCqm5DLi3nyIUIDm2gVnv73gXQAzJ+A8GN/tPY7nBGrU92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884581; c=relaxed/simple;
	bh=TgCrp6HpTZUr8v23z17ZA8xkBRhAvSC2Xx1dLNOpdCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9CngxePsHIZXLTm3TncE5dGIrWg5T0zv96U+4y3raJPiRxeRsdo9F1r9qJYnKo0ggdXKs9j7+11hcXyXcXtbnK+BREfjnAYQU2mXEkb0BoTmoJxtr0v0rmklTFnP0sbkgTwOGeoEiTwaPmybxoEdUW2ByNW5QNSf53PqTJPxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=lZ3p43k3; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=AzcOo9CG; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884576;
	bh=TgCrp6HpTZUr8v23z17ZA8xkBRhAvSC2Xx1dLNOpdCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lZ3p43k3s5LGPA8MlFEbbObpNqOUWH5Zzty2/Wt+yc1g5BiSTpvDJANFu8Bk2OmYJ
	 BxNC1256atR+iyA8mIEzQ/mcghuoZo1cGeOr9gH7JHIaonEnpGFFBmGPo0/u/VgEmm
	 Jjf6y8uWK+PJOcMo29iGG5i9u+z0rWIXvGP85937jF1v7L+YH/osMhHL4dk4Xvd/ov
	 eiTUK57r2PQSjjvo2hwsI8hSXAgeKSlKXhhsz+Ca475fDHq8298ZxLyaphXqIFNlCJ
	 tDwvOam34dtkMdyx4XtEQ4lyosnTFDPRvNY0YeGYpAM/6kZ6j/cgSGnAk2KEVEowpH
	 urZdmhV/Bj8TQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 27C9549362; Wed,  1 Jul 2026 05:42:56 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884571;
	bh=TgCrp6HpTZUr8v23z17ZA8xkBRhAvSC2Xx1dLNOpdCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AzcOo9CGzcL922VHy3hCiWQvieVZqk5fMwkN+eNAxZJ8H30v3HXYQ1du9Ffyou4uR
	 Gt48lYBCDDZCrgxOj5D//cygFa5Mp78NNGJTRz/VwlKVsk3CXpq14LSh36gHKspaYO
	 cPWb2wBQ3W7dU5VKcXJCiyzOmKCkoLuorJKsIEJDr0y3E/3Ae36U+v0jEV4/Cw5mtj
	 esj5Rp5+K8NZJNcg6jcmu7mvy3vNGs7uL+TlNcOBXetQDD8vcrBkRp7rT+5bxuCa3Q
	 rz70lE8kQlXIWvOm+DQfAq/IehM2DdhIUCcievRXCq7dCpUglfvkbeEFqGa2NNAFfD
	 0Fr4bElP0ZD4A==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 857CA492B4;
	Wed,  1 Jul 2026 05:42:51 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 01 Jul 2026 07:42:51 +0200
Subject: [PATCH 5/9] ax88179_178a: Add support for ethtool pause parameter
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
In-Reply-To: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303468-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A6DC6E9E6E

The AX179A-based chips support pause parameter configuration.
Make it available through ethtool ops.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 16528d873e804fde5dcc27659048882eee1c3eaa..586c049c6f7422a853aeae5e9372ead3a6d106c5 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -956,6 +956,71 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 	return mii_ethtool_set_link_ksettings(&dev->mii, cmd);
 }
 
+static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	u16 bmcr, lcladv, rmtadv;
+	u8 cap;
+
+	data = dev->driver_priv;
+
+	if (data->chip_version < AX_VERSION_AX88179A)
+		return;
+
+	bmcr = ax88179_mdio_read(net, dev->mii.phy_id, MII_BMCR);
+	lcladv = ax88179_mdio_read(net, dev->mii.phy_id, MII_ADVERTISE);
+	rmtadv = ax88179_mdio_read(net, dev->mii.phy_id, MII_LPA);
+
+	if (!(bmcr & BMCR_ANENABLE)) {
+		pause->autoneg = 0;
+		pause->rx_pause = 0;
+		pause->tx_pause = 0;
+		return;
+	}
+
+	pause->autoneg = 1;
+
+	cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
+
+	if (cap & FLOW_CTRL_RX)
+		pause->rx_pause = 1;
+
+	if (cap & FLOW_CTRL_TX)
+		pause->tx_pause = 1;
+}
+
+static int ax88179a_set_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	u16 old, new1, bmcr;
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
+	if (pause->rx_pause)
+		cap |= FLOW_CTRL_RX;
+
+	if (pause->tx_pause)
+		cap |= FLOW_CTRL_TX;
+
+	old = ax88179_mdio_read(net, dev->mii.phy_id, MII_ADVERTISE);
+	new1 = (old & ~(ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM)) |
+		mii_advertise_flowctrl(cap);
+	if (old != new1)
+		ax88179_mdio_write(net, dev->mii.phy_id, MII_ADVERTISE, new1);
+
+	return mii_nway_restart(&dev->mii);
+}
+
 static int
 ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
@@ -1130,6 +1195,8 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= ax88179_get_link_ksettings,
 	.set_link_ksettings	= ax88179_set_link_ksettings,
+	.get_pauseparam		= ax88179a_get_pauseparam,
+	.set_pauseparam		= ax88179a_set_pauseparam,
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 

-- 
2.47.3


