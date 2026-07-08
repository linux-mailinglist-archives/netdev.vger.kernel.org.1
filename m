Return-Path: <netdev+bounces-305956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5fhbGUCaTmqbQQIAu9opvQ
	(envelope-from <netdev+bounces-305956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:43:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC18729A3E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:43:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=LnqnjwKl;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=VoWqbxTN;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305956-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305956-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A0B4304B367
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A84C955D;
	Wed,  8 Jul 2026 18:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C844C77AD;
	Wed,  8 Jul 2026 18:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536018; cv=none; b=YLqNJWFsxSb61lpD43xqCs7eB7v5NYwkbQRMLSsvQV4xXqPOzOU24avdOc6pKvyGl/i83wAc6B2WB1mxF7LA5jyDcYACEtPfz8fkztBUirIKQvHX+SQi43jQXcVzpi7DNvN7/SZzVYliAg+CHZaiAfPjBpCBMZdLDDEeBOrplpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536018; c=relaxed/simple;
	bh=bfp4eOtiExj+gQ6wq2k3CS9I+tKgJt5UY3aD15ndef8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLNro6dZIzVlHJueKq4tR3W2tYHw29Z+/MmsVxKmyv2LQsDJEOykkecikvcYSEJMrpg2bluV13PYs1XiO41AVi2lpfjRmrcKfj3KD5nJXZ8/T2FC+JOIsNglJnM/8JZkP4mAIZVDQrMmDKaRVniO0s3vk6gcqlnaUYcGjZGca/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=LnqnjwKl; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VoWqbxTN; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536010;
	bh=bfp4eOtiExj+gQ6wq2k3CS9I+tKgJt5UY3aD15ndef8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LnqnjwKl5PvqUtyoheYvu0FQg/Gsj93FPWWCdfpSc/V/OYMH1Mg1a9bsdAWLAwru3
	 vhrralwe+FgaFAXt3kV3bgSIPKBR1j6YW92jPI47E6TbtaDgeeT334hz3p/LHlaIlv
	 fRTzwnE894xQx4ioTH/49vhqAqX7MBNdlRxrpQ6DDXs+uAm+tqKQP/Tmtb+GVOl0iE
	 hUowbUFEzyvsXh3nplz3tPFzxoo7wK/IpJ53BxwBVN9RlKpwDCcKXVQWyI5uyIabWt
	 qzFvFjNFPJbsr2YEbHHDDfL6X1x11kjPfAn2eLlt+uFroi9CFafKpFaCPXreeA26l5
	 wA51oXtoens0g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C6EC14943D; Wed,  8 Jul 2026 18:40:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536005;
	bh=bfp4eOtiExj+gQ6wq2k3CS9I+tKgJt5UY3aD15ndef8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VoWqbxTNbnGzcbFecDYdHlYcNIYy9EmoFuUKeN8J4SEMZhoWjZdpKydMnzwaeqHuS
	 wvbmGePIsXR8N46nvslBK523eFxyWPcmRVq+s2lmjDkZSBAXGsDc6yrLVCJ8NhlFSe
	 2L/MkAIQt894zbUo+7utYmqwrDFxewThkUYB02LYea7oh1q7ulgV4kkWMERZlrun6f
	 t2y8DlUL6sd/qWKhdTmhPKw7mbdnjMSQIOOK/sG/C+RcMA7gerqVkKTYZUi9YncF50
	 FzhM0fPtFAoedEs5Qyl+pzUmXlMdEKTXo8fPeBwVcIP3Gd+xCrkpiqOEmV075Rv8S6
	 D5/mgtZV9iJpg==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 81B564943B;
	Wed,  8 Jul 2026 18:40:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:10 +0200
Subject: [PATCH net-next v2 04/12] ax88179_178a: Add EEE HW configuration
 support for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-4-0800fedb2e16@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305956-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBC18729A3E

The AX88179A uses a much simpler HW configuration for EEE
via a single EEE configuration register. Add support for
this register and replace the EEE enable/disable functions
with a single EEE configuration function which enables/disables
EEE in the hardware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 71 +++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c483b7b636e37d45455d46e1b0354fd63e0ef100..c2ebc8ae8d4ce72cbd04c2c16b9940416e9f427b 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -35,6 +35,7 @@
 #define AX_RELOAD_EEPROM_EFUSE			0x06
 #define AX88179A_WAKEUP_SETTING			0x07
 #define AX_FW_MODE				0x08
+#define AX_GPHY_CTL				0x0F
 #define AX88179A_FLASH_READ			0x21
 #define AX88179A_FLASH_WRITE			0x24
 #define AX88179A_PHY_CLAUSE45			0x27
@@ -125,6 +126,9 @@
 #define AX88179A_VLAN_ID_DATA1			0x2D
 
 #define AX_RX_BULKIN_QCTRL			0x2e
+
+#define AX_GPHY_EEE_CTRL			0x01
+
 #define AX_CLK_SELECT				0x33
 	#define AX_CLK_SELECT_BCS	0x01
 	#define AX_CLK_SELECT_ACS	0x02
@@ -995,46 +999,35 @@ static int ax88179_chk_eee(struct usbnet *dev)
 	return false;
 }
 
-static void ax88179_disable_eee(struct usbnet *dev)
-{
-	u16 tmp16;
-
-	tmp16 = GMII_PHY_PGSEL_PAGE3;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x3246;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_PHYADDR, 2, &tmp16);
-
-	tmp16 = GMII_PHY_PGSEL_PAGE0;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-}
-
-static void ax88179_enable_eee(struct usbnet *dev)
+static void ax88179_eee_config(struct usbnet *dev, bool enable)
 {
+	struct ax88179_data *priv = dev->driver_priv;
 	u16 tmp16;
 
-	tmp16 = GMII_PHY_PGSEL_PAGE3;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x3247;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_PHYADDR, 2, &tmp16);
-
-	tmp16 = GMII_PHY_PGSEL_PAGE5;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x0680;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_BMSR, 2, &tmp16);
+	if (priv->chip_version < AX_VERSION_AX88179A) {
+		tmp16 = GMII_PHY_PGSEL_PAGE3;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+
+		tmp16 = enable ? 0x3247 : 0x3246;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  MII_PHYADDR, 2, &tmp16);
+		if (enable) {
+			tmp16 = GMII_PHY_PGSEL_PAGE5;
+			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+					  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+
+			tmp16 = 0x0680;
+			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+					  MII_BMSR, 2, &tmp16);
+		}
 
-	tmp16 = GMII_PHY_PGSEL_PAGE0;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+		tmp16 = GMII_PHY_PGSEL_PAGE0;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+	} else {
+		ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, enable, 0, NULL);
+	}
 }
 
 static int ax88179_get_eee(struct net_device *net, struct ethtool_keee *edata)
@@ -1056,13 +1049,13 @@ static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 
 	priv->eee_enabled = edata->eee_enabled;
 	if (!priv->eee_enabled) {
-		ax88179_disable_eee(dev);
+		ax88179_eee_config(dev, false);
 	} else {
 		priv->eee_enabled = ax88179_chk_eee(dev);
 		if (!priv->eee_enabled)
 			return -EOPNOTSUPP;
 
-		ax88179_enable_eee(dev);
+		ax88179_eee_config(dev, true);
 	}
 
 	ret = ax88179_ethtool_set_eee(dev, edata);
@@ -2490,7 +2483,7 @@ static int ax88179_reset(struct usbnet *dev)
 	ax179_data->eee_enabled = 0;
 	ax179_data->eee_active = 0;
 
-	ax88179_disable_eee(dev);
+	ax88179_eee_config(dev, false);
 
 	ax88179_ethtool_get_eee(dev, &eee_data);
 	linkmode_zero(eee_data.advertised);

-- 
2.47.3


