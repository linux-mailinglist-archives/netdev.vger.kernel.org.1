Return-Path: <netdev+bounces-260173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lsScCZWqnGldJwQAu9opvQ
	(envelope-from <netdev+bounces-260173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538817C61F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98A693026B45
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7969B36A023;
	Mon, 23 Feb 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="TA46UPa0";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RJyeDbDW"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC81E834B;
	Mon, 23 Feb 2026 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874956; cv=none; b=ewIXmRigtN2e+ltxdczGdxfrNajWD1rQh8xHP5cRTMqvRHmzYfOQQf7Z9QEDYhzqnU1pTYML45xIU7iY1AV99HoTSj5srWSsRE5ST4j5Got25s+HtbgxqshbjkHky8hoGthTXsA9BPf59JVa9JamUdPtG1KDRy1rh9I7M7qYMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874956; c=relaxed/simple;
	bh=3MA3bbhwetR2X3uYjy4BFrqzdWakVvc4DI2/YXAy/vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g9BAxLXjWdN93ybhWrLnySLW73xV3XLweAg3f7sWlgWwEujLXpZxoXnTVWNRbNLIlCecOp29o6eTdUKOOXZyz5Kp2fqVgcmXb8RFNvSW4ivPX+CwmPaBVfJFYjL3S+F7LJNz126hiw4klnbYclGLjfuXJ79zk/DrxxyFrIvD9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=TA46UPa0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RJyeDbDW; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771874456;
	bh=3MA3bbhwetR2X3uYjy4BFrqzdWakVvc4DI2/YXAy/vY=;
	h=From:Date:Subject:To:Cc:From;
	b=TA46UPa072snvW/IGatzC/1Ek/C72zSOcu5lXp8eMubpmAkpeN9WbAzvS2VqJjOJd
	 +7aa9lSDKjrdJgNAlGGEkU4vRBpMFsO167Q+Lp5tIDuScePEGnnEcAOe8ezZ2lzfGj
	 jmmpbxwDkonEnMXAmTiXA0P+49085EtXBj7Cpw/uQLBnFIQEKkpZsIxtAG5UzTuXTh
	 pR7AvA9gL7JwsF9WWzonee8tYHXGuAifaWGBvnRjjf1sv1CZtXK9MYmsAoVhPDdSCV
	 eFGVj/i/BqhGFxJVI2k0IvQdyAJk7qhp+t5BqZFxEATGAu0y9mbfxKHNEDHD+kwMVL
	 D0HH5PCBib+Mg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D611F3F760; Mon, 23 Feb 2026 19:20:56 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771874455;
	bh=3MA3bbhwetR2X3uYjy4BFrqzdWakVvc4DI2/YXAy/vY=;
	h=From:Date:Subject:To:Cc:From;
	b=RJyeDbDWgPFRNRBhckqw1ARiSW01+P9l1a1iPdwB9R+PNj9/QHFZsa/tLhfKUkeqI
	 0X6wAhsD1CSPmIwyIa2AfbBYbKVjru6NRPWxGnrAC883HNhYEUt+rtZlxQ0Up+1/s8
	 meLCFSYTmTVLrm7zpSd3y8fdp0/+KPyjJfnJrCDZZkJZ8srAICiWOAt1XESo6bTEVF
	 6EmT9UUNsl7nWTm2hT4BU7X5A5+E5sMolvzIStvoNqPmQRBp69DXRuiuB1saaBz8W9
	 frmTELfPgyxGGdjpsJo9JO9Ir19/aPedge9eaz+/o3aHUDuqPqMWn6Tqn6oOtXGR7Q
	 iI+ORJQtFXKXw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B31803F757;
	Mon, 23 Feb 2026 19:20:55 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 23 Feb 2026 20:20:35 +0100
Subject: [PATCH net-next] r8152: Add 2500baseT EEE status/configuration
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIAIKonGkC/x3MSwqAMAxF0a1IxgZq/OJWxIHap2ZSpRUpiHu3O
 DxwuQ8FeEWgPnvI49agh0so8oyWfXIbWG0yiZHGiJQ8VwxAtprF2HZpVltNXUepPz1Wjf9rIIe
 LHeJF4/t+o9+l5WUAAAA=
X-Change-ID: 20260223-b4-eee2g5-20d7c6fd4a88
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-260173-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2538817C61F
X-Rspamd-Action: no action

The r8152 driver supports the RTL8156, which is a 2.5Gbit Ethernet controller for
USB 3.0, for which support is added for configuring and displaying the EEE
advertisement status for 2.5GBit connections.

The patch also corrects the determination of whether EEE is active to include
the 2.5GBit connection status and make the determination dependent not on the
desired speed configuration (tp->speed), but on the actual speed used by
the controller. For consistency, this is corrected also for the RTL8152/3.

This was tested on an Edimax EU-4307 V1.0 USB-Ethernet adapter with RTL8156,
and a SECOMP Value 12.99.1115 USB-C 3.1 Ethernet converter with RTL8153.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 49433301e7b1d5c98fc32c72f821e31335bc3527..0bc3b1b93017c80e1761b00767904ff1c2e6ac87 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -213,6 +213,7 @@
 #define OCP_EEE_LPABLE		0xa5d2
 #define OCP_10GBT_CTRL		0xa5d4
 #define OCP_10GBT_STAT		0xa5d6
+#define OCP_EEE_LPABLE2		0xa6d0
 #define OCP_EEE_ADV2		0xa6d4
 #define OCP_PHY_STATE		0xa708		/* nway state for 8153 */
 #define OCP_PHY_PATCH_STAT	0xb800
@@ -954,6 +955,7 @@ struct r8152 {
 	u16 ocp_base;
 	u16 speed;
 	u16 eee_adv;
+	u16 eee_adv2;
 	u8 *intr_buff;
 	u8 version;
 	u8 duplex;
@@ -8929,6 +8931,7 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	u16 val;
+	u16 speed = rtl8152_get_speed(tp);
 
 	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
 	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
@@ -8941,8 +8944,14 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 	eee->eee_enabled = tp->eee_en;
 
-	linkmode_and(common, eee->advertised, eee->lp_advertised);
-	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
+	if (speed & _1000bps)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, common);
+	if (speed & _100bps)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
+
+	linkmode_and(common, common, eee->advertised);
+	linkmode_and(common, common, eee->lp_advertised);
+	eee->eee_active = !linkmode_empty(common);
 
 	return 0;
 }
@@ -8953,7 +8962,10 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 	tp->eee_en = eee->eee_enabled;
 	tp->eee_adv = val;
-
+	if (tp->support_2500full) {
+		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
+		tp->eee_adv2 = val;
+	}
 	rtl_eee_enable(tp, tp->eee_en);
 
 	return 0;
@@ -8963,6 +8975,7 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	u16 val;
+	u16 speed = rtl8152_get_speed(tp);
 
 	val = ocp_reg_read(tp, OCP_EEE_ABLE);
 	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
@@ -8973,10 +8986,29 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
 	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
 
+	if (tp->support_2500full) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, eee->supported);
+
+		val = ocp_reg_read(tp, OCP_EEE_ADV2);
+		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);
+
+		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
+		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
+
+		if (speed & _2500bps)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
+	}
+
 	eee->eee_enabled = tp->eee_en;
 
-	linkmode_and(common, eee->advertised, eee->lp_advertised);
-	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
+	if (speed & _1000bps)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, common);
+	if (speed & _100bps)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
+
+	linkmode_and(common, common, eee->advertised);
+	linkmode_and(common, common, eee->lp_advertised);
+	eee->eee_active = !linkmode_empty(common);
 
 	return 0;
 }

---
base-commit: 89ed47f863c259e0c639d3b8c62cde2c30485c6b
change-id: 20260223-b4-eee2g5-20d7c6fd4a88

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


