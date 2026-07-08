Return-Path: <netdev+bounces-305957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W+WJCG6aTmqwQQIAu9opvQ
	(envelope-from <netdev+bounces-305957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:43:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943E729A62
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:43:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="UKLp/AzP";
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=VKtvjLeX;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305957-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305957-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30EB0301C5C9
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC74C9573;
	Wed,  8 Jul 2026 18:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A44C9006;
	Wed,  8 Jul 2026 18:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536019; cv=none; b=XvglfbRcCq6SgevixiUb/vR3uzu5GRfY0ydBX5t63EMq2Lg3J5PBMVA0SYnWf2iLGf019nJFKoYOoHscEiPrds1qyaB2NTHOAxZIP8QXVBc6Tk4nBUqnYPoYXt0EYCyGalCqaBOrCoH0t1qWxp45AhdwknXlBJQT83EuLXCERog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536019; c=relaxed/simple;
	bh=82ZUC9xydqxgpX5yxF3JqvVGKm1cffgqt61nF5ytU24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3+r5Nb9aQi2YKbboyz0v2SIHxXnZgSxbSYh8lxqkDynxnjTZasPu470ndPE6ZkdYrp6TEejoTK3uFvL2HqG0hkI5OD9hDeDVU2O7zu7vNovy+jnMPHrkIuf+aAB8WiMH8cj9yrkcaHeWc3zUwtbEftZyTksl6Mn4Mzq+gqmNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=UKLp/AzP; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VKtvjLeX; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536011;
	bh=82ZUC9xydqxgpX5yxF3JqvVGKm1cffgqt61nF5ytU24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UKLp/AzP+4zuHVOVShc0TwJmk1r5g5akyCkGdSBunFUoAvfnLxp1jSC2FQ0+vKYEi
	 gIwphljMKFkpmMm9/UxIyOYgN3Lzhv4BG83cPHJ2MVgSwOogdmTV1HDRoPZaGTNUQ4
	 /JVo7Ec11YMi09CJVyuI1mrRNELkQwx6f1luM09jVhlnG5NeqR82AWs2sgh0OneU3W
	 HfwBesdjjbhdca2VNvpWAjcsnDQJzKICM+LTeD5TKn4EUMYeva5/pwgBzZyBarJCeG
	 5Ss6nywRtAFlom9T19TgzQ4ZBfrl2hsGmU/7OjdBhsz174rciXydL6xfQDiKK9JZWz
	 O9j3dDddVjWtQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 4066D4944D; Wed,  8 Jul 2026 18:40:11 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536005;
	bh=82ZUC9xydqxgpX5yxF3JqvVGKm1cffgqt61nF5ytU24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VKtvjLeX8Rojq25+kKtqOx0Mx6cGFGPNsyt0MtBl3/ER4Nk5FvX4N0cpRX/NCCuFX
	 sIwOF32jVYYZzqHdpe32P1/+0aoszmkRBMOrTsBwVsfmsVUtBMy/vEI3NVtxM0K4a8
	 hA6j4YwVxR2531aBnyq4p8YRn2TYKNbEM8Q6ejMoWq1C92KakWmZutKS7j+jbzwcpJ
	 nqHYchxdn+AQ24k4c/DUQgbYPFPIXb/zipQwlSkaFiCwzjcjACGb/lTvmX/XzR9SwV
	 5Y4np00KtX3I+Hh5ncxeJwcuuA5um1PPffwhwmMjg/pcFFUBYG8l9fWJaqE9CQXqN5
	 FI4CtpkXVHqIw==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B7E5D4943C;
	Wed,  8 Jul 2026 18:40:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:11 +0200
Subject: [PATCH net-next v2 05/12] ax88179_178a: Add support for 2500 link
 speed of AX88279
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-5-0800fedb2e16@birger-koblitz.de>
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
	TAGGED_FROM(0.00)[bounces-305957-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1943E729A62

Tha AX88279 support a link speed of 2500Mbit/s. Add support for
configuring this link speed in the ethtool link status getter/setter
functions.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c2ebc8ae8d4ce72cbd04c2c16b9940416e9f427b..7d1d75d570a3de013b5eda11e0ce0eac988eab49 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -904,9 +904,36 @@ static int ax88179_get_link_ksettings(struct net_device *net,
 				      struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	int v;
+
+	data = dev->driver_priv;
 
 	mii_ethtool_get_link_ksettings(&dev->mii, cmd);
 
+	if (data->chip_version >= AX_VERSION_AX88279) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 cmd->link_modes.supported);
+
+		v = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_ADVERTISE);
+		if (v >= 0 && v & AX_ADVERTISE_2500)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					 cmd->link_modes.advertising);
+
+		v = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+		if (data->speed == ETHER_LINK_2500) {
+			cmd->base.speed = SPEED_2500;
+			/* MDIO_AN_10GBT_STAT_LP2_5G is broken, but we can deduce that
+			 * the link-partner advertised 2500M if remotely AN succceded
+			 * for link speed > 1000M and we locally have a link speed of
+			 * 2500M
+			 */
+			if (v >= 0 && v & MDIO_AN_10GBT_STAT_REMOK)
+				linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+						 cmd->link_modes.lp_advertising);
+		}
+	}
+
 	return 0;
 }
 
@@ -914,6 +941,31 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 				      const struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	int v;
+
+	data = dev->driver_priv;
+
+	/* mii_ethtool_set_link_ksettings handles unknown bits in MII_ADVERTISE
+	 * transparently, so for the 2.5GBit link speed of the AX_VERSION_AX88279
+	 * we just set up AX_ADVERTISE_2500 before calling mii_ethtool_set_link_ksettings
+	 * at least for speeds < 2500
+	 */
+	if (data->chip_version == AX_VERSION_AX88279) {
+		v = ax88179_mdio_read(net, dev->mii.phy_id, MII_ADVERTISE);
+		if (v < 0)
+			return v;
+
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				      cmd->link_modes.advertising))
+			v |= AX_ADVERTISE_2500;
+		else
+			v &= ~AX_ADVERTISE_2500;
+		ax88179_mdio_write(net, dev->mii.phy_id, MII_ADVERTISE, v);
+		if (cmd->base.speed == SPEED_2500)
+			return mii_nway_restart(&dev->mii);
+	}
+
 	return mii_ethtool_set_link_ksettings(&dev->mii, cmd);
 }
 

-- 
2.47.3


