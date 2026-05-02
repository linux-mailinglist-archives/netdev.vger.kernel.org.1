Return-Path: <netdev+bounces-283369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAiaJreC9WkHMAIAu9opvQ
	(envelope-from <netdev+bounces-283369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:51:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E774B0F1E
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E28A3017C22
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 04:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65929D275;
	Sat,  2 May 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="s7ix8f0l";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="V/w4KC8N"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7C7081E;
	Sat,  2 May 2026 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697459; cv=none; b=bohj+RvOZIHR3ABhhUsKdm6uYojMa8pDa+NVEuNFtMNjQ6DemLuhulTI21ymiZFhryUQ350tPeOHTUIT44I5rmxVFUNdrrUAMubuDdRQC85MHuBtc3mZdfQ52PMzUSrWbLg4o4uyAOEL52LBIvKc6BI2slXJa/stG8oQ86NGxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697459; c=relaxed/simple;
	bh=NzT3APBnqSAwLHn2gideBIQArpEmCV4zmBiX4w9QCPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzOZXtaOVC56GXAqNhd23R/FL/g3tIbNdowKZQnOVuKkApcFll1nogVZdtNfoqjF1RpLZ2nE1IHw9HBEj9UKZO+K6za49geWOWWkgVerqO6f3uLoeiujuw/xOLHplwjnhYzNqzODzBZumpsWJo/tQTJCAfENRzgUTJcILYV/EeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=s7ix8f0l; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=V/w4KC8N; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777697456;
	bh=NzT3APBnqSAwLHn2gideBIQArpEmCV4zmBiX4w9QCPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s7ix8f0lCxZ0YxmqjMr4iQGxypQBHQlji+3+cl7TkMfZU/kLyxJUL0WyA1Kh6KVeI
	 ZbAdfPGI4gFCy/+SgPUDpJX+fSovfBvWt6MExfOQ/kdQAMZKiUjgfFs63T25cO0lVq
	 8FJ/yYDWfwSG6AZ7zuyGYvKElE8emnSoMOHT2SgAKJ9TP3iMPjbwRQlvK65CONKPlr
	 TluPwOe5J8a7CS9z7kvw3UIM2c+WYozZtFs5ThXfrjn24qM0GCq9wBx/ExWs2RK01Y
	 v+pyMrOXGdE54il0EewsQUzOBqR6TPlMwTj7Qnp0InzvTMlZjN4jXD7/aAJLVDTh2S
	 DkE4aw9ftp+fA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3CA72482C3; Sat,  2 May 2026 04:50:56 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777697454;
	bh=NzT3APBnqSAwLHn2gideBIQArpEmCV4zmBiX4w9QCPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V/w4KC8NX7FjyAXMjdniYuUgmOw9KuzQz3D1meQywiJFFukLSVQmU7bHcs88s5kiH
	 Qlz6kJXOZkT6qLhy11BaWnw+7YbkoWb3YMXP+/sNNRWZ0GiObSWiPn+s+7yfWcFmKj
	 nSQowjyaQNudGoICpU7bP+I995aNRcdARl5t7JHcr+NAuN6iiVGhHiV0atL601XGzy
	 pGOStjgoYN8K9YBwrdvELXbaXcz44TRiK1jJnc5Wi2wREVij7LYkbJsy5NHH4jsLD8
	 6lteNMoyGxaPsaonLC/ODSuirmF/9SHAExK8h/638sW50txbMv1/D7/QoQWmJpqyCi
	 oKX+7r25jIaQw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 959C34829E;
	Sat,  2 May 2026 04:50:54 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 02 May 2026 06:50:36 +0200
Subject: [PATCH net-next v3 1/3] r8152: Add support for 10Gbit Link Speeds
 and EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-rtl8159_net_next-v3-1-12c895d46cd6@birger-koblitz.de>
References: <20260502-rtl8159_net_next-v3-0-12c895d46cd6@birger-koblitz.de>
In-Reply-To: <20260502-rtl8159_net_next-v3-0-12c895d46cd6@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 13E774B0F1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,birger-koblitz.de,lunn.ch,wp.pl];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

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


