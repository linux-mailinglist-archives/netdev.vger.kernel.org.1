Return-Path: <netdev+bounces-269884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEWHBEssvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:15:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6283C2D9604
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A8B3060BD6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818839FCC4;
	Fri, 20 Mar 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="n9pS0yJo";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Zx+JM8za"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B38E10A;
	Fri, 20 Mar 2026 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005282; cv=none; b=fRqLuFqOfVHrGPCF+LFc/bcRTrdpISrtMJl0XWUadVsx9JMPeDrbl9bHYegPEGIn28JoGCz4v7J2D0GLMvvDuab7QbsgqbpsPAv2z1Ob1vjGG+mz+sJXxERsaSIDkpmI+sp185XuYlPe1myZ/bsiUrFxAz6ZtzgtuGw/jCtsvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005282; c=relaxed/simple;
	bh=zYG+DNXtZTJSJDC9VkUwz6Zvm//1RbqAy4kXWUEhwNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3wIGJelPBwIthBHSEqBrqFRPIjo10xBst73B5sDxCZrXEl1QOZqC81nnKP4oqh6QxNS8XSQyHY0Fj/wjMiawNBdXyYCpts5Ca8kEOT8Am1kGcBcffSwiewhkDjuirQv3O8B/5g2kZ2Sm/sN6VoLPRrTzoBt1LiM9TI0ZQ7PuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=n9pS0yJo; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Zx+JM8za; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774005279;
	bh=zYG+DNXtZTJSJDC9VkUwz6Zvm//1RbqAy4kXWUEhwNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n9pS0yJoxZQ7HaGwwm/gnqR2FrIoIFGsbG18LzLBVKDTr7TD2ZbvQTZUeOQKnabaI
	 cLjgPtqrjHb1CMDQ26FffPMxPXHd62zZZvdwTkupcOyfXt/cmn8BHy/ee4VSXHjwfh
	 0v9zJr7oB6MlTXarZSF3uMorhMk+YstkAC/qWnSEg59APtZaOLAVopDoshQi7AsZjE
	 ZF8Dj8suPW69WwF+HycPOcbIDgEqaZnKumEm2XWUe4pABGMPIO8zFFQZdU2r2jrlB3
	 Ckd84YEUjOJfEb0pjxEjybNkB9pfxfAgy9eNDjndOm7NotvXIPyrGiJoarD3bOjMua
	 Ay0nqt+CqFL+w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C2F7F3FF14; Fri, 20 Mar 2026 11:14:39 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774005278;
	bh=zYG+DNXtZTJSJDC9VkUwz6Zvm//1RbqAy4kXWUEhwNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zx+JM8zaoNh3rcOyQvS7UqeRILVSQUpa4TSbE9Z63Y44FSUf2fHX01fqFBWIwEOVI
	 AigPZ6iQ6FntRyuPMfbySuHCx8Hso0suNra2MVyrI9q9a/nuJeMpiOF2uJAS9FSUXx
	 kHZwG1iagWjJKOKRgYyooGBxlg0x88k0YaZs8mhxxdtjkbiA+vXQWB8URNcsUFKlOS
	 aPkI9m33BaE0nbmh0r3Z5qHqm0vUcIqQOZASpXPaqyo3k/ozrdsusP+TIpNScvGjyP
	 bUcZL1orvl79evx1A9XTC1d+Bfu9XT55hDU3hE3GpF6Ii/hsLGdTQ1Gdb7HoQJDNaf
	 rD5BQW4kq6hrg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6E2323FEF0;
	Fri, 20 Mar 2026 11:14:38 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 20 Mar 2026 12:14:37 +0100
Subject: [PATCH net-next v3 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-rtl8157_next-v3-1-1aefeca7fda7@birger-koblitz.de>
References: <20260320-rtl8157_next-v3-0-1aefeca7fda7@birger-koblitz.de>
In-Reply-To: <20260320-rtl8157_next-v3-0-1aefeca7fda7@birger-koblitz.de>
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
	TAGGED_FROM(0.00)[bounces-269884-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6283C2D9604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8157 supports 5GBit Link speeds. Add support for this speed
in the setup and setting/getting through ethtool. Also add 5GBit EEE.
Add functionality for setup and ethtool get/set methods.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3b6d4252d34c63ead8f11a120e212325a5f7d505..bab8e10e5f99afcb332e333c2739ed7509b03419 100644
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
 
@@ -6298,6 +6308,9 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 
 			if (tp->support_2500full)
 				support |= RTL_ADVERTISED_2500_FULL;
+
+			if (tp->support_5000full)
+				support |= RTL_ADVERTISED_5000_FULL;
 		}
 
 		if (!(advertising & support))
@@ -6343,15 +6356,20 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
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
@@ -8780,6 +8798,9 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 			 cmd->link_modes.supported, tp->support_2500full);
 
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 cmd->link_modes.supported, tp->support_5000full);
+
 	if (tp->support_2500full) {
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 				 cmd->link_modes.advertising,
@@ -8793,6 +8814,19 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 			cmd->base.speed = SPEED_2500;
 	}
 
+	if (tp->support_5000full) {
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				 cmd->link_modes.advertising,
+				 ocp_reg_read(tp, OCP_10GBT_CTRL) & MDIO_AN_10GBT_CTRL_ADV5G);
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				 cmd->link_modes.lp_advertising,
+				 ocp_reg_read(tp, OCP_10GBT_STAT) & MDIO_AN_10GBT_STAT_LP5G);
+
+		if (is_speed_5000(rtl8152_get_speed(tp)))
+			cmd->base.speed = SPEED_5000;
+	}
+
 	mutex_unlock(&tp->control);
 
 	usb_autopm_put_interface(tp->intf);
@@ -8840,6 +8874,10 @@ static int rtl8152_set_link_ksettings(struct net_device *dev,
 		     cmd->link_modes.advertising))
 		advertising |= RTL_ADVERTISED_2500_FULL;
 
+	if (test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+		     cmd->link_modes.advertising))
+		advertising |= RTL_ADVERTISED_5000_FULL;
+
 	mutex_lock(&tp->control);
 
 	ret = rtl8152_set_speed(tp, cmd->base.autoneg, cmd->base.speed,
@@ -8957,7 +8995,7 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 	tp->eee_en = eee->eee_enabled;
 	tp->eee_adv = val;
-	if (tp->support_2500full) {
+	if (tp->support_2500full || tp->support_5000full) {
 		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
 		tp->eee_adv2 = val;
 	}
@@ -8994,6 +9032,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
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
@@ -9934,6 +9979,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
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


