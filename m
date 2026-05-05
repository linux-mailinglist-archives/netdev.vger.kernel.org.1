Return-Path: <netdev+bounces-284491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJQxDf0U+mlRJAMAu9opvQ
	(envelope-from <netdev+bounces-284491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:04:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296E4D0D7B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B4C83036D66
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE948AE3C;
	Tue,  5 May 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="wky0/Epm";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="krNJpox/"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF503481FBD;
	Tue,  5 May 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996602; cv=none; b=P9hLywMBjVYsOOow7aHUR7e77kGt2j4kAc6IbU+zDSxeYMy95Rd6gVFK8WMs90GNpXTrDjNs5iPxHc9iKuYZJy9UmmCF9zOR1mD9icjIlaE5rOWyKwR92iREIw+1tG1OFfu6juq0kVXoagErjtcy4ERnliyZgBgauQ36/CeL8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996602; c=relaxed/simple;
	bh=NzT3APBnqSAwLHn2gideBIQArpEmCV4zmBiX4w9QCPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJeExC+o3GKUdY3R5rXioBwjvqQejRLOhzah8W5meBUWVCsjELWtU8laFOjIVuhlzcVIt14RlC2xCNstVjAL0wS8+WnWcYRiCnGfBncB64WExIMojTdWC1oMXIpUChh3QMbMudtloB3ohl48VuQAIVp+oVUH0f92Or2xOS8VQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=wky0/Epm; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=krNJpox/; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996599;
	bh=NzT3APBnqSAwLHn2gideBIQArpEmCV4zmBiX4w9QCPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wky0/EpmyTu2Jrwr3/oP+Hc3pONLGgppm8tTERPOY/0t9DvepJg1oaHib4LzAHmfe
	 yQi9lLy0AvSbzXAgzPsdDjW1JaMHuWJp676T9mZ+43XsSwkhHLzy2abSe0D2m5FeMt
	 7+o/EedwJRjOhPzLGWhMBF2GZXI4hfEsQAmgMwE3kzfDXiVtfpN1gFTT4kJTZcoNod
	 /3wrC5d0KAUc30btqDHVT2X1QmLw1jQ6SCbjhJmpDYY7E/GxNtjLiwFkxr24rKUqsE
	 WWSa+NYsLjcIqDoD8Z/X9LYBl08YlNcZ7rZNN5jFJ/8jt2lYleWpNueqdOKCWJeg4S
	 oW2azmRTz/nHA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2C604425F2; Tue,  5 May 2026 15:56:39 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996597;
	bh=NzT3APBnqSAwLHn2gideBIQArpEmCV4zmBiX4w9QCPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=krNJpox/uXMNdf3Oq+UdPKLq/f6o2lq/soP9JWUkl6ZnyIXLgqAYqzEUJCoLMZaUV
	 fAgMPB1EXE+Yug6z50Et9YAFkTZD+p/8znlrnjGUvLVfqRafbk/fNkvnJ6w0+NOS1x
	 XhBAvbl+6EsEmM4HnOJM+nOFKBjYwKqgCboEtTbatvXA0PIk/E7XBznkQ6E0aRN5jT
	 ebBiPKQjwolX8LdiZ2ewoosm9I/L1AqCoRjcsgL1vFaiMHMRem8qJGYA8NBcWBjbZE
	 A2n6RKfsR6sNKYMdR5sTlC9OLSU8HqILT9KXXZRQNTApQliNMrkvC5vob/Vb8CYWMB
	 L65HJaAt1oFYA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 501E642465;
	Tue,  5 May 2026 15:56:37 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 05 May 2026 17:56:33 +0200
Subject: [PATCH net-next v4 1/3] r8152: Add support for 10Gbit Link Speeds
 and EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rtl8159_net_next-v4-1-1a648a9c4d8d@birger-koblitz.de>
References: <20260505-rtl8159_net_next-v4-0-1a648a9c4d8d@birger-koblitz.de>
In-Reply-To: <20260505-rtl8159_net_next-v4-0-1a648a9c4d8d@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 3296E4D0D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,birger-koblitz.de,lunn.ch,wp.pl];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email]

The RTL8159 supports 10GBit Link speeds. Add support for this speed
in the setup and setting/getting through ethtool. Also add 10GBit EEE.
Add functionality for setup and ethtool get/set methods.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/usb/r8152.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index ae834876aa1acc7a9af08a4c01b7a984c4ab8433..05abfab1df94a571347196bfce7c232865e1058e 100644
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
@@ -6513,6 +6519,9 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 
 			if (tp->support_5000full)
 				support |= RTL_ADVERTISED_5000_FULL;
+
+			if (tp->support_10000full)
+				support |= RTL_ADVERTISED_10000_FULL;
 		}
 
 		advertising &= support;
@@ -6559,9 +6568,10 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
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
@@ -6573,6 +6583,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
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
@@ -8708,7 +8723,10 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
 			 cmd->link_modes.supported, tp->support_5000full);
 
-	if (tp->support_2500full || tp->support_5000full) {
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 cmd->link_modes.supported, tp->support_10000full);
+
+	if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
 		u16 ocp_10gbt_ctrl = ocp_reg_read(tp, OCP_10GBT_CTRL);
 		u16 ocp_10gbt_stat = ocp_reg_read(tp, OCP_10GBT_STAT);
 
@@ -8737,6 +8755,19 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
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
@@ -8790,6 +8821,10 @@ static int rtl8152_set_link_ksettings(struct net_device *dev,
 		     cmd->link_modes.advertising))
 		advertising |= RTL_ADVERTISED_5000_FULL;
 
+	if (test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+		     cmd->link_modes.advertising))
+		advertising |= RTL_ADVERTISED_10000_FULL;
+
 	mutex_lock(&tp->control);
 
 	ret = rtl8152_set_speed(tp, cmd->base.autoneg, cmd->base.speed,
@@ -8953,6 +8988,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
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
@@ -9967,6 +10009,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
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


