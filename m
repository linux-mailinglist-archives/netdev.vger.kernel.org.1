Return-Path: <netdev+bounces-268702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NyQHWGYuWn5KwIAu9opvQ
	(envelope-from <netdev+bounces-268702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:07:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5452B0A0E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24C703012D23
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF5E37F73E;
	Tue, 17 Mar 2026 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DoqzXXFV";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="I1B0C5Jx"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA737EFED;
	Tue, 17 Mar 2026 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770847; cv=none; b=LCuOiZKLX8iUOhs5v1rmYXYOlw0abJuk6TJz0Hg/QXMbRPf7Y9vIyMOq2avbWSTfzTEb1Pjj7H2SNZ/uxEu5Jwg+BXaQYo/NqQuzM6neio5pfQ+poERqrE2MXhrAWh9OnT0uV4n+bFzKZB7XweSHLssJCfvukxE8dbly4QngNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770847; c=relaxed/simple;
	bh=BDvwioO8gC1x/W8UZX2A6UuH8D3nEdqWNTqn6htIJP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtwYl8shihmCe3kUpx07d6mdAAU3IlrOz06wrpUPevZJRgNM/DdVxsb+6uWJ8bWRLAp6AkN4PNpTcoFMNPIdNgC/B2OOF55zb8DJHI7cm28I/DslGBmYvAbqlgbpYEMhZkbGJMgr7ov+bgNd+tP7a/K4HBkfXONUJhEaEA6XI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DoqzXXFV; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=I1B0C5Jx; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773770844;
	bh=BDvwioO8gC1x/W8UZX2A6UuH8D3nEdqWNTqn6htIJP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DoqzXXFVYCKkRYwUFubEg0P4UVadDOTTN/c+aZ4nzAT4n9/kbWwuxabN6vTeJ/evG
	 QbdGtb5kPCTuJMQNXW7vAWTByKdurHMW/EBuBe97YYRkPyjqBIGmF05xHcAxu9eZcX
	 EcCsxh8MkKawDQ0q/zqkCwixuUc+rVBsFeyrEBhFso4fiNRGeENRNPaWGdQUP6N451
	 xK+5ZJ1ifFAODwFVJP95H4Nm61j4fxthFm5Txrslm0DK9bO2TcK1jUjYN4CKQBdjdZ
	 80Ph+VKAs+nd1o5Y7eUrsH5KOTSHrSnNt1ropzKqibl8qJAPFvJjeWwtfJS3eho7YM
	 5QXfRt1hpAshw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D65503FE10; Tue, 17 Mar 2026 18:07:24 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773770843;
	bh=BDvwioO8gC1x/W8UZX2A6UuH8D3nEdqWNTqn6htIJP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I1B0C5Jxhfedt9KUhVRCuZdXV8fv6yqgkKiEtaBUnIKEuEokRgXnOdovo5IBn5Ig0
	 osSifaAbUPmLwIG9pna6qZUoA6cxLuhwUXBuYSh0c3qbQX8icdKxWZ5xbNTrEnzGz+
	 9uQ0dDSxLBrFxFl3JyCygxMyXiJlHmDVRrf2Rcqn5xLiVODSS6vcuHGzxcEgf89uoO
	 beCWa1zOteliMtFMm6U9gA0jr+8GOiOTZWL+Cf/zARPrbvXAEJrdsNJ5BqYsjumoPw
	 t+G9B8nLgdUi/2OHyqgbZDE7vkjkfwynmOzeO/ED3j5BVcKItZZkEkEPOFjOEpId6v
	 EML/0BzKgAfRA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 647EF3FDEE;
	Tue, 17 Mar 2026 18:07:23 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 17 Mar 2026 19:07:14 +0100
Subject: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
In-Reply-To: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-268702-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 1E5452B0A0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8157 supports 5GBit Link speeds. Add support for this speed
in the setup and setting/getting through ethool. Also add 5GBit EEE.
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


