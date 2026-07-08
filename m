Return-Path: <netdev+bounces-305955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /LBgLO2ZTmpyQQIAu9opvQ
	(envelope-from <netdev+bounces-305955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EDF7299F6
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:41:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=h1UcJBR9;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="ya9V/IU3";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305955-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305955-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD25830393BF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B224C9015;
	Wed,  8 Jul 2026 18:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670B4CA27E;
	Wed,  8 Jul 2026 18:40:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536018; cv=none; b=JX25uYmQRLkRg+ER2l1BAnsoU+pwW8qhV9B6PkL9DwpvRZGDwFLn6z2KBoLTXcR0ZnVs4Dh2hAbNKvP5krpLpAPd9VNR8d3fv2ttkgjprRr136XN/Bsgtsk8mcz17mgAGclGpTraY9cYYE8FQ7rVcNxBoERasNssQQGCY6HKPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536018; c=relaxed/simple;
	bh=XWnSmpL8oHrAf5oCNAJBmVBIHfSqqNjo9SXstWqcK6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrsjPwfMXxm/ziZXdn0owYKajNZtSeX0a1mcn9E9ipkIZpZ7/zid/gZbT87PZZWnmWASA/l+gkyNAtfCkD/Ig1v5Rgy5KPyQRk3plYRCcPDOuP0KkBrvP62HKSwSSw2DFYHV0oHimJfXwxdJdSJ8Uhy7FW/0l1Vbl3N8FEIuvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=h1UcJBR9; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ya9V/IU3; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536010;
	bh=XWnSmpL8oHrAf5oCNAJBmVBIHfSqqNjo9SXstWqcK6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h1UcJBR9JOG4BYwutLQI1IDxYn7Hp7FI8AjHP0yyRBRHN5lvGYfNrmWXvaaJr9aiL
	 zOIhJ3QPwm2J0mh0tPsgp5eaGmUJPumh9yBQBXYehQ/UDMn0mIQnZjfz8+zw0R1Bi4
	 toImvprI31VpvF9Hem91S94rXS16/XnR6kxwkWg/Re7HUOAueZE/hRLb5opFBNY65O
	 Ih4vVrWUmZuisY27hlJ1P14IMXq7tI72LFc3lsJjHd8COhD3X3hK5roGObPBor993c
	 og6qEIf8LPw16YmHa4UVv+SfAlUnYpj3gV9PwmWrCctZw31cuZ27glQ8L/GotCXlCP
	 6pBHajikJJPaw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 026BF49440; Wed,  8 Jul 2026 18:40:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536005;
	bh=XWnSmpL8oHrAf5oCNAJBmVBIHfSqqNjo9SXstWqcK6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ya9V/IU3VZ2HJfjp2qWvl99enysVT1UG38sg/jYfJ+lEM12yWxc6Ep2acXTi4tHxv
	 aEuNwLWOFWTtuNGttKPeB5EgC3y1+xgB3clE6J9kLFScxxRO5TEfC7ReJ2Tunw/ijH
	 DbqEzaizcUfNRPmE4OIbIikMB9ob4VIgkjtDV4k58QsICV1O+FXzt49ptbdxSztXRw
	 vn7It8SKzvLiCRW1UQUHx+1Uzs1vlRi9380mDhJJkbp48dpKPLb9boiAPTSEX6tDxm
	 4tIPg8D37k+S/vQ8rglotZwW0bVuTym7npANoYBHreklLmHR8KnbNb4N/TB/gebM1R
	 7QYdiCQduNaxg==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4B7DC493EB;
	Wed,  8 Jul 2026 18:40:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:09 +0200
Subject: [PATCH net-next v2 03/12] ax88179_178a: Add MMD accessor function
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-3-0800fedb2e16@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305955-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08EDF7299F6

The AX88179A uses a much simpler Clause-45 MMD access interface,
make use of this interface and abstract MMD read/write operations
for the AX88179 and AX88179A architecture by introducing
ax_read_mmd() and ax_write_mmd(), which in turn call the chips'
respective implementation.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 66 ++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 3aad69b5d4f8ad43527fa7cf51304af9a926ea78..c483b7b636e37d45455d46e1b0354fd63e0ef100 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -37,6 +37,7 @@
 #define AX_FW_MODE				0x08
 #define AX88179A_FLASH_READ			0x21
 #define AX88179A_FLASH_WRITE			0x24
+#define AX88179A_PHY_CLAUSE45			0x27
 #define AX88179A_ACCESS_BL			0x2A
 #define AX88179A_PHY_POWER			0x31
 #define AX88179A_AUTODETACH			0xC0
@@ -575,6 +576,32 @@ ax88179_phy_write_mmd_indirect(struct usbnet *dev, u16 prtad, u16 devad,
 	return 0;
 }
 
+static int ax_read_mmd(struct usbnet *dev, u16 dev_addr, u16 reg)
+{
+	struct ax88179_data *priv = dev->driver_priv;
+	u16 res;
+	int ret;
+
+	if (priv->chip_version >= AX_VERSION_AX88179A) {
+		ret = ax88179_read_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &res);
+		if (ret < 0)
+			return ret;
+		return res;
+	}
+
+	return ax88179_phy_read_mmd_indirect(dev, reg, dev_addr);
+}
+
+static int ax_write_mmd(struct usbnet *dev, u16 dev_addr, u16 reg, u16 data)
+{
+	struct ax88179_data *priv = dev->driver_priv;
+
+	if (priv->chip_version >= AX_VERSION_AX88179A)
+		return ax88179_write_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &data);
+
+	return ax88179_phy_write_mmd_indirect(dev, reg, dev_addr, data);
+}
+
 static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
@@ -892,22 +919,19 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 	int val;
 
 	/* Get Supported EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_PCS_EEE_ABLE,
-					    MDIO_MMD_PCS);
+	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->supported, val);
 
 	/* Get advertisement EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
-					    MDIO_MMD_AN);
+	val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->advertised, val);
 
 	/* Get LP advertisement EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
-					    MDIO_MMD_AN);
+	val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
@@ -920,8 +944,7 @@ ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
 	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
 
-	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
-					      MDIO_MMD_AN, tmp16);
+	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, tmp16);
 }
 
 static int ax88179_chk_eee(struct usbnet *dev)
@@ -935,32 +958,19 @@ static int ax88179_chk_eee(struct usbnet *dev)
 		int eee_lp, eee_cap, eee_adv;
 		u32 lp, cap, adv, supported = 0;
 
-		eee_cap = ax88179_phy_read_mmd_indirect(dev,
-							MDIO_PCS_EEE_ABLE,
-							MDIO_MMD_PCS);
-		if (eee_cap < 0) {
-			priv->eee_active = 0;
+		eee_cap = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
+		if (eee_cap < 0)
 			return false;
-		}
 
 		cap = mmd_eee_cap_to_ethtool_sup_t(eee_cap);
-		if (!cap) {
-			priv->eee_active = 0;
-			return false;
-		}
-
-		eee_lp = ax88179_phy_read_mmd_indirect(dev,
-						       MDIO_AN_EEE_LPABLE,
-						       MDIO_MMD_AN);
-		if (eee_lp < 0) {
-			priv->eee_active = 0;
+		if (!cap)
 			return false;
-		}
 
-		eee_adv = ax88179_phy_read_mmd_indirect(dev,
-							MDIO_AN_EEE_ADV,
-							MDIO_MMD_AN);
+		eee_lp = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
+		if (eee_lp < 0)
+			return true;
 
+		eee_adv = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
 		if (eee_adv < 0) {
 			priv->eee_active = 0;
 			return false;

-- 
2.47.3


