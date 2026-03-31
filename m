Return-Path: <netdev+bounces-273685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAgEFunvy2m5MgYAu9opvQ
	(envelope-from <netdev+bounces-273685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68536C481
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB271300C580
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42941C2FE;
	Tue, 31 Mar 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QaLa2MUx";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="K4fNkTbG"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D921401496;
	Tue, 31 Mar 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972566; cv=none; b=QxhNMIx7845ro3cziAGhXhs4NUw+PntSrhueJ7ODBiW7kaxyT1frMZSNRmLzqcTUPUDtf9ChKEsFtVU5FBNt/BZU9R8JSZIF2KYyGpTNE7fLxPQUDWXnDEdZ1dQct2JMPU1dL/LMaOMceEKmaY9oGBjKs+RPd3F8R5HMYQ5DPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972566; c=relaxed/simple;
	bh=QIJCZh8XBZo6gyxNCkc3cNYbcWMT3spUB1hYzrQolxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUG+cPPtG/adGdbfBA1Q4n2f9ACMrwSAu/VMhhKbhW4S1cqbcIsxD+Lfh0sTJr0B014Y/9nkdPHhhYuWPSALM74SnvRsNYGbzVTF/c/RGx6z8jBi2xolizxZLIH1G1mP/kAac1wWQWf2GZtU4KbqJ1KxyE8eozEbB8b5uXXxOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QaLa2MUx; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=K4fNkTbG; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774972563;
	bh=QIJCZh8XBZo6gyxNCkc3cNYbcWMT3spUB1hYzrQolxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QaLa2MUx2+VpvmyTxY06HGhnUfRf5Gl0Fmvy+ovX/1C0P5QrRGe36xEaPzxVQYAEc
	 M2dRhB37GSiycBRbqR+ZedLXdmmG2UTqCdbdKkg6t4RfQA1Hfd0z52W5SseWK8FlU3
	 8pKFLZe8hfS9Z5OZAWO5X5gBzM/i9gNj1OmCwck42iVTcCqsGVV2nuYLlpKDd316qW
	 JDogw0/l7Aq+V4+D+Rl+MSKxxCITwM0a9ZcNbdtDnbkzKtheJUc02yEwLQvLg7FOWO
	 B7l9/NqGHEaTkuCdJ8nvSXv0FyZgoN8zw//0DSfFBoDtyyxjnhKvZIB6vuYntylkmW
	 afKmG9ygPE3Kw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EA7BD406EA; Tue, 31 Mar 2026 15:56:03 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774972562;
	bh=QIJCZh8XBZo6gyxNCkc3cNYbcWMT3spUB1hYzrQolxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K4fNkTbGPk2SCz9lVbLrGzYkmxPdAHH4MDJT8pIkmv42u/R7dVGhIx3Vpyx83KVkJ
	 ClQW8xJB4FyaMzW8z9OICVDBKioZNsEWvzcKW4RZ/7HRnr19tlmfGPN+I6ktGvdmgo
	 4LtL789x2ezyZPjW8TlDdo/6wWS71Wk3vZqKWsIQO4vxFHiApYFYV8dbO5Q/3whSQn
	 zFbWHKLmK/gqlZseoVPSEEbh/AgQAOcgDu18yOCVqeFA8BOCLdP0m/BIU7vJIT9+JY
	 1YJ5KdbUX7zDx4k6jQGDO2GSMzlh96l6VeHL1U6befmcZDvT8aKdGUkLagQUOuWRHb
	 31haxmiL/EtOA==
Received: from DebianDesktop.lan (p200300c69f04eb0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5F8B9406E5;
	Tue, 31 Mar 2026 15:56:02 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 31 Mar 2026 17:55:53 +0200
Subject: [PATCH net-next v5 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-rtl8157_next-v5-1-deb3095f8380@birger-koblitz.de>
References: <20260331-rtl8157_next-v5-0-deb3095f8380@birger-koblitz.de>
In-Reply-To: <20260331-rtl8157_next-v5-0-deb3095f8380@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-273685-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB68536C481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8157 supports 5GBit Link speeds. Add support for this speed
in the setup and setting/getting through ethtool. Also add 5GBit EEE.
Add functionality for setup and ethtool get/set methods.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 90 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3b6d4252d34c63ead8f11a120e212325a5f7d505..7dd5fc93c7dd735cdcc802b6c5fb6d296c82e0c6 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -604,6 +604,7 @@ enum spd_duplex {
 	FORCE_100M_FULL,
 	FORCE_1000M_FULL,
 	NWAY_2500M_FULL,
+	NWAY_5000M_FULL,
 };
 
 /* OCP_ALDPS_CONFIG */
@@ -725,6 +726,7 @@ enum spd_duplex {
 #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
 
 enum rtl_register_content {
+	_5000bps	= BIT(12),
 	_2500bps	= BIT(10),
 	_1250bps	= BIT(9),
 	_500bps		= BIT(8),
@@ -738,6 +740,7 @@ enum rtl_register_content {
 };
 
 #define is_speed_2500(_speed)	(((_speed) & (_2500bps | LINK_STATUS)) == (_2500bps | LINK_STATUS))
+#define is_speed_5000(_speed)	(((_speed) & (_5000bps | LINK_STATUS)) == (_5000bps | LINK_STATUS))
 #define is_flow_control(_speed)	(((_speed) & (_tx_flow | _rx_flow)) == (_tx_flow | _rx_flow))
 
 #define RTL8152_MAX_TX		4
@@ -944,6 +947,7 @@ struct r8152 {
 	unsigned int pipe_in, pipe_out, pipe_intr, pipe_ctrl_in, pipe_ctrl_out;
 
 	u32 support_2500full:1;
+	u32 support_5000full:1;
 	u32 lenovo_macpassthru:1;
 	u32 dell_tb_rx_agg_bug:1;
 	u16 ocp_base;
@@ -1194,6 +1198,7 @@ enum tx_csum_stat {
 #define RTL_ADVERTISED_1000_HALF		BIT(4)
 #define RTL_ADVERTISED_1000_FULL		BIT(5)
 #define RTL_ADVERTISED_2500_FULL		BIT(6)
+#define RTL_ADVERTISED_5000_FULL		BIT(7)
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
  * The RTL chips use a 64 element hash table based on the Ethernet CRC.
@@ -5400,6 +5405,11 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
 	else
 		config &= ~MDIO_EEE_2_5GT;
 
+	if (enable && (tp->eee_adv2 & MDIO_EEE_5GT))
+		config |= MDIO_EEE_5GT;
+	else
+		config &= ~MDIO_EEE_5GT;
+
 	ocp_reg_write(tp, OCP_EEE_ADV2, config);
 }
 
@@ -6298,9 +6308,13 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 
 			if (tp->support_2500full)
 				support |= RTL_ADVERTISED_2500_FULL;
+
+			if (tp->support_5000full)
+				support |= RTL_ADVERTISED_5000_FULL;
 		}
 
-		if (!(advertising & support))
+		advertising &= support;
+		if (!advertising)
 			return -EINVAL;
 
 		orig = r8152_mdio_read(tp, MII_ADVERTISE);
@@ -6343,15 +6357,20 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 				r8152_mdio_write(tp, MII_CTRL1000, new1);
 		}
 
-		if (tp->support_2500full) {
+		if (tp->support_2500full || tp->support_5000full) {
 			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
-			new1 = orig & ~MDIO_AN_10GBT_CTRL_ADV2_5G;
+			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G);
 
 			if (advertising & RTL_ADVERTISED_2500_FULL) {
 				new1 |= MDIO_AN_10GBT_CTRL_ADV2_5G;
 				tp->ups_info.speed_duplex = NWAY_2500M_FULL;
 			}
 
+			if (advertising & RTL_ADVERTISED_5000_FULL) {
+				new1 |= MDIO_AN_10GBT_CTRL_ADV5G;
+				tp->ups_info.speed_duplex = NWAY_5000M_FULL;
+			}
+
 			if (orig != new1)
 				ocp_reg_write(tp, OCP_10GBT_CTRL, new1);
 		}
@@ -8780,17 +8799,38 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 			 cmd->link_modes.supported, tp->support_2500full);
 
-	if (tp->support_2500full) {
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-				 cmd->link_modes.advertising,
-				 ocp_reg_read(tp, OCP_10GBT_CTRL) & MDIO_AN_10GBT_CTRL_ADV2_5G);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 cmd->link_modes.supported, tp->support_5000full);
 
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-				 cmd->link_modes.lp_advertising,
-				 ocp_reg_read(tp, OCP_10GBT_STAT) & MDIO_AN_10GBT_STAT_LP2_5G);
+	if (tp->support_2500full || tp->support_5000full) {
+		u16 ocp_10bt_ctrl = ocp_reg_read(tp, OCP_10GBT_CTRL);
+		u16 ocp_10bt_stat = ocp_reg_read(tp, OCP_10GBT_STAT);
 
-		if (is_speed_2500(rtl8152_get_speed(tp)))
-			cmd->base.speed = SPEED_2500;
+		if (tp->support_2500full) {
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					 cmd->link_modes.advertising,
+					 ocp_10bt_ctrl & MDIO_AN_10GBT_CTRL_ADV2_5G);
+
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					 cmd->link_modes.lp_advertising,
+					 ocp_10bt_stat & MDIO_AN_10GBT_STAT_LP2_5G);
+
+			if (is_speed_2500(rtl8152_get_speed(tp)))
+				cmd->base.speed = SPEED_2500;
+		}
+
+		if (tp->support_5000full) {
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+					 cmd->link_modes.advertising,
+					 ocp_10bt_ctrl & MDIO_AN_10GBT_CTRL_ADV5G);
+
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+					 cmd->link_modes.lp_advertising,
+					 ocp_10bt_stat & MDIO_AN_10GBT_STAT_LP5G);
+
+			if (is_speed_5000(rtl8152_get_speed(tp)))
+				cmd->base.speed = SPEED_5000;
+		}
 	}
 
 	mutex_unlock(&tp->control);
@@ -8840,6 +8880,10 @@ static int rtl8152_set_link_ksettings(struct net_device *dev,
 		     cmd->link_modes.advertising))
 		advertising |= RTL_ADVERTISED_2500_FULL;
 
+	if (test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+		     cmd->link_modes.advertising))
+		advertising |= RTL_ADVERTISED_5000_FULL;
+
 	mutex_lock(&tp->control);
 
 	ret = rtl8152_set_speed(tp, cmd->base.autoneg, cmd->base.speed,
@@ -8957,7 +9001,7 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 	tp->eee_en = eee->eee_enabled;
 	tp->eee_adv = val;
-	if (tp->support_2500full) {
+	if (tp->support_2500full || tp->support_5000full) {
 		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
 		tp->eee_adv2 = val;
 	}
@@ -8981,19 +9025,28 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
 	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
 
-	if (tp->support_2500full) {
-		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, eee->supported);
-
+	if (tp->support_2500full || tp->support_5000full) {
 		val = ocp_reg_read(tp, OCP_EEE_ADV2);
 		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);
 
 		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
 		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
+	}
+
+	if (tp->support_2500full) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, eee->supported);
 
 		if (speed & _2500bps)
 			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
 	}
 
+	if (tp->support_5000full) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, eee->supported);
+
+		if (speed & _5000bps)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
+	}
+
 	eee->eee_enabled = tp->eee_en;
 
 	if (speed & _1000bps)
@@ -9934,6 +9987,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 		} else {
 			tp->speed = SPEED_1000;
 		}
+		if (tp->support_5000full &&
+		    tp->udev->speed >= USB_SPEED_SUPER) {
+			tp->speed = SPEED_5000;
+			tp->advertising |= RTL_ADVERTISED_5000_FULL;
+		}
 		tp->advertising |= RTL_ADVERTISED_1000_FULL;
 	}
 	tp->duplex = DUPLEX_FULL;

-- 
2.47.3


