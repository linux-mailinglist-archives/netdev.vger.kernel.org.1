Return-Path: <netdev+bounces-281617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MtlA/Qt8GkHPgEAu9opvQ
	(envelope-from <netdev+bounces-281617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:48:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A962E47D289
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B49F33034E21
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18757322A2E;
	Tue, 28 Apr 2026 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0BQVdo7Q";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CIcCEseT"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877042D0610;
	Tue, 28 Apr 2026 03:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348057; cv=none; b=SWcYv5eA7qjDJOOyn0Mtx3NqEuDYbdoPFcnYFwNgQzSf1uy/bqXTCVy8TItt4VWSKvMZHfjbsBEaVqesusLEH79F27bTr64L1ktdlwpaDIG6Ax+UDNleCIZkmGzWaRDMYgdBgItdgSuhDSYLIG1Tk6gEoU3p2spMJF918UKYTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348057; c=relaxed/simple;
	bh=iQ/eoC1GV+1Ova+P8hwer13i+tvxj2gUmoJ1TI22vE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSmBL9RjG2KckkKfTBUkxdxJH3ZIqqayMVt0owuHBsdXoIYk/AQ6zQsWc0MfLNET4WKmfAIXbuF+e1pLscnVPkiF3MoglA8JR1xHfs+FkM/ULLGH2TFB55YJvmO4YhYMF5qdiPf/7K81OK2vkjXNDnOTFjLOGmopR1cwEQCxh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0BQVdo7Q; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CIcCEseT; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777348054;
	bh=iQ/eoC1GV+1Ova+P8hwer13i+tvxj2gUmoJ1TI22vE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0BQVdo7QiFsEKKXtdiwVPE1HfQfZbrWxIxHA7V1SuffZM2gLF5rVfwvBdCuJf6cf2
	 AChp+dmg0SaW7P9K5Q6kY8rawIg8NBmbGbPPiDIm6EHToiQMheSogkKqEP/NzMxFKe
	 U1x9Xgb7APbqJO1noYnl1CQWoNt5jnCwWNpuuDFYblC152lEbilkG8EKD56xb9v1hf
	 oqYA5N+q70HUCnHJ0Bwpt37qtrrbWXlxpd+ppd+z6gj8GMYYzIKwtGLhl7djg4hSMz
	 JoCJ3MCNyxHj5rGSElRqY7rhgsy+f9R4KTg8Xah9WTvS2BA9+qxQJSOKOy1nk28feJ
	 QEjqjY9l/jIog==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1607747DBB; Tue, 28 Apr 2026 03:47:34 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777348052;
	bh=iQ/eoC1GV+1Ova+P8hwer13i+tvxj2gUmoJ1TI22vE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CIcCEseTs+xWYuB0qXpGBuLeKF1qF5bQEPWX06Dfy5JpyOMzWRgpT75MXqEhYFof6
	 IOLabXb9322y3IralaQhAAWDLNQaGPdS1jaeyvl9noUMZEYwJ/9JYBxj4+PxydcgnF
	 msaoHjda0tdDu0R+k4ap8n96bKMv5Mmuknukek3k/I3A5xhLShZbj9jlefLhfOXlj+
	 FSZWb4JuWODCQIJHyw2++jm7p7rMLK04pQNTVLXS3AwGEV7yOZtjM+LooIRZ2bk0m6
	 sRLYYpd7iMHkHv1ZWYt85hAHaTtGg6aX/tXcqykLcGQm9T+SVzlZsrxuNk6XjXAhq7
	 JSWZqUljuHUDQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6DDC64761E;
	Tue, 28 Apr 2026 03:47:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 28 Apr 2026 05:47:21 +0200
Subject: [PATCH net-next 1/4] r8152: Add support for 10Gbit Link Speeds and
 EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-rtl8159_net_next-v1-1-52d03927b46f@birger-koblitz.de>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
In-Reply-To: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: A962E47D289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-281617-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

The RTL8159 supports 10GBit Link speeds. Add support for this speed
in the setup and setting/getting through ethtool. Also add 10GBit EEE.
Add functionality for setup and ethtool get/set methods.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 7337bf1b7d6ad03572edbc492706c07a8f58760f..01e65d845f8732f23427305423e4e270dae775dc 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -621,6 +621,7 @@ enum spd_duplex {
 	FORCE_1000M_FULL,
 	NWAY_2500M_FULL,
 	NWAY_5000M_FULL,
+	NWAY_10000M_FULL,
 };
 
 /* OCP_ALDPS_CONFIG */
@@ -742,6 +743,7 @@ enum spd_duplex {
 #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
 
 enum rtl_register_content {
+	_10000bps	= BIT(14),
 	_5000bps	= BIT(12),
 	_2500bps	= BIT(10),
 	_1250bps	= BIT(9),
@@ -757,6 +759,8 @@ enum rtl_register_content {
 
 #define is_speed_2500(_speed)	(((_speed) & (_2500bps | LINK_STATUS)) == (_2500bps | LINK_STATUS))
 #define is_speed_5000(_speed)	(((_speed) & (_5000bps | LINK_STATUS)) == (_5000bps | LINK_STATUS))
+#define is_speed_10000(_speed)	(((_speed) & (_10000bps | LINK_STATUS)) \
+				 == (_10000bps | LINK_STATUS))
 #define is_flow_control(_speed)	(((_speed) & (_tx_flow | _rx_flow)) == (_tx_flow | _rx_flow))
 
 #define RTL8152_MAX_TX		4
@@ -1008,6 +1012,7 @@ struct r8152 {
 
 	u32 support_2500full:1;
 	u32 support_5000full:1;
+	u32 support_10000full:1;
 	u32 lenovo_macpassthru:1;
 	u32 dell_tb_rx_agg_bug:1;
 	u16 ocp_base;
@@ -1260,6 +1265,7 @@ enum tx_csum_stat {
 #define RTL_ADVERTISED_1000_FULL		BIT(5)
 #define RTL_ADVERTISED_2500_FULL		BIT(6)
 #define RTL_ADVERTISED_5000_FULL		BIT(7)
+#define RTL_ADVERTISED_10000_FULL		BIT(8)
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
  * The RTL chips use a 64 element hash table based on the Ethernet CRC.
@@ -5773,6 +5779,11 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
 	else
 		config &= ~MDIO_EEE_5GT;
 
+	if (enable && (tp->eee_adv2 & MDIO_EEE_10GT))
+		config |= MDIO_EEE_10GT;
+	else
+		config &= ~MDIO_EEE_10GT;
+
 	ocp_reg_write(tp, OCP_EEE_ADV2, config);
 }
 
@@ -6513,6 +6524,9 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 
 			if (tp->support_5000full)
 				support |= RTL_ADVERTISED_5000_FULL;
+
+			if (tp->support_10000full)
+				support |= RTL_ADVERTISED_10000_FULL;
 		}
 
 		advertising &= support;
@@ -6559,9 +6573,10 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 				r8152_mdio_write(tp, MII_CTRL1000, new1);
 		}
 
-		if (tp->support_2500full || tp->support_5000full) {
+		if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
 			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
-			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G);
+			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G
+					| MDIO_AN_10GBT_CTRL_ADV10G);
 
 			if (advertising & RTL_ADVERTISED_2500_FULL) {
 				new1 |= MDIO_AN_10GBT_CTRL_ADV2_5G;
@@ -6573,6 +6588,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 				tp->ups_info.speed_duplex = NWAY_5000M_FULL;
 			}
 
+			if (advertising & RTL_ADVERTISED_10000_FULL) {
+				new1 |= MDIO_AN_10GBT_CTRL_ADV10G;
+				tp->ups_info.speed_duplex = NWAY_10000M_FULL;
+			}
+
 			if (orig != new1)
 				ocp_reg_write(tp, OCP_10GBT_CTRL, new1);
 		}
@@ -8723,7 +8743,10 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
 			 cmd->link_modes.supported, tp->support_5000full);
 
-	if (tp->support_2500full || tp->support_5000full) {
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 cmd->link_modes.supported, tp->support_10000full);
+
+	if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
 		u16 ocp_10gbt_ctrl = ocp_reg_read(tp, OCP_10GBT_CTRL);
 		u16 ocp_10gbt_stat = ocp_reg_read(tp, OCP_10GBT_STAT);
 
@@ -8752,6 +8775,19 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 			if (is_speed_5000(rtl8152_get_speed(tp)))
 				cmd->base.speed = SPEED_5000;
 		}
+
+		if (tp->support_10000full) {
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+					 cmd->link_modes.advertising,
+					 ocp_10gbt_ctrl & MDIO_AN_10GBT_CTRL_ADV10G);
+
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+					 cmd->link_modes.lp_advertising,
+					 ocp_10gbt_stat & MDIO_AN_10GBT_STAT_LP10G);
+
+			if (is_speed_10000(rtl8152_get_speed(tp)))
+				cmd->base.speed = SPEED_10000;
+		}
 	}
 
 	mutex_unlock(&tp->control);
@@ -8805,6 +8841,10 @@ static int rtl8152_set_link_ksettings(struct net_device *dev,
 		     cmd->link_modes.advertising))
 		advertising |= RTL_ADVERTISED_5000_FULL;
 
+	if (test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+		     cmd->link_modes.advertising))
+		advertising |= RTL_ADVERTISED_10000_FULL;
+
 	mutex_lock(&tp->control);
 
 	ret = rtl8152_set_speed(tp, cmd->base.autoneg, cmd->base.speed,
@@ -8968,6 +9008,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
 	}
 
+	if (tp->support_10000full) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, eee->supported);
+
+		if (speed & _10000bps)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, common);
+	}
+
 	eee->eee_enabled = tp->eee_en;
 
 	if (speed & _1000bps)
@@ -9982,6 +10029,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 			tp->speed = SPEED_5000;
 			tp->advertising |= RTL_ADVERTISED_5000_FULL;
 		}
+		if (tp->support_10000full &&
+		    tp->udev->speed >= USB_SPEED_SUPER) {
+			tp->speed = SPEED_10000;
+			tp->advertising |= RTL_ADVERTISED_10000_FULL;
+		}
 		tp->advertising |= RTL_ADVERTISED_1000_FULL;
 	}
 	tp->duplex = DUPLEX_FULL;

-- 
2.47.3


