Return-Path: <netdev+bounces-267692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDEfDU8rtWnNxAAAu9opvQ
	(envelope-from <netdev+bounces-267692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:33:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7F28C62B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C94230620F6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750234EEF3;
	Sat, 14 Mar 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0UbRGwfp";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KJwFy/8I"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6F33BBD7;
	Sat, 14 Mar 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480715; cv=none; b=R1LI3BWowWMh9Q42xi+4TRsZFoUBr82HlHxfIYut1hzU5bVwhJ4qIBsSg+uYnG1pJ2PpKTAOK6WcLK6AdE5rRIezntcv+IXP0LlNpdXdEnZJrDc3ftJo/8cVTddUG4/YnC6UuMYfJ03aUljCPSGyPN0GmFMsO1KMx9Ai9dQLuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480715; c=relaxed/simple;
	bh=7ahNTLag8CqBDyorUoSHN0rIlNE+4LrcQBoVWiPbrfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYglxPqHdE5BEY8CidbTCWu46MSekgN4+5TPh6Y7UGpiBYFH9baX691bAUaBjwebE5P02AfbovdQYINqHeO7YQNwSKRWqNkGRqtrISNbf3rOVzetQOdVmW4A8NGRKZ4B72VBtEyDtnLGd69/NLkzjyHRa8H7IpTESFEM3l4Hjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0UbRGwfp; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KJwFy/8I; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480709;
	bh=7ahNTLag8CqBDyorUoSHN0rIlNE+4LrcQBoVWiPbrfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0UbRGwfp4FdBg3EeozogzobI0ftBhSbCWVY4SqlaOKJB4r3nhT2/OfN+q5n/H/8Ro
	 +XdPmVlYRpd6QB5J62I5EfZthMbWXbEvz4Q5kJO/0HRFu9K3+zBH9AUIFyCwlq/SLb
	 Hpx/Hl/WKgHpRdpBuX3bY4ZysHbBVBnz/tLKTiC4lpD+QfSivU0kQFu2NvT1RvfZjY
	 bn6SdBYxXb8utJoGWAdzS/FDm1RVXiPB5XQQ2j5i9tbrbRgb4nlI9wDq+nCfGHezr5
	 ouyR+udS4sdyKFfnRQwsXOkPISFXgOTFpFZ7LQJ3f1Ep65LK6R/5oUewZhN9VW5+H1
	 /2nTZTvIhZvHA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 682CB3FCDA; Sat, 14 Mar 2026 09:31:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480704;
	bh=7ahNTLag8CqBDyorUoSHN0rIlNE+4LrcQBoVWiPbrfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KJwFy/8IkG8qF2B6vz7TvW8XgCabaxLwBIHKFfZI7BGZ1pJWsZ9RfsiH3pi46gmho
	 dttR+vCbCg8+LgWG+cPBEEIrDn6wC43LSAi1UH94QNjCOTMG9A8SBKMKyOJphbp2cV
	 4Ddwbqua7UUM6MtGKcHuCJ/oVNd1AVEs/Jdc7kcEL0OSOPR57L8kbPsoudsKIsHy1t
	 n1/uRRig9nmpAXIU3KmCuHWRlPiOwVRcSQ2XNukn0GWV/zMjezNMeMQpRdEKzeWz2F
	 XWAaqrZYyy7XybPULwsWB0rckVwpFPEXpWmxosmvqhC7Le+DiXM2W2MActsTtRxX/m
	 c04zdwioLiTOA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E14093FCCB;
	Sat, 14 Mar 2026 09:31:43 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:43 +0100
Subject: [PATCH net-next 7/9] r8152: Add support for 5Gbit Link Speeds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-7-9ba77b428afd@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
In-Reply-To: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-267692-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: BBA7F28C62B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8157 supports 5GBit Link speeds. Add support for this speed
in the setup and setting/getting through ethool.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index bef38211c3157b5774ceccbfd923b227f285aaaf..f9498c39dc6ec8bf4605b17e2c81bbe180b1b2d3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -620,6 +620,7 @@ enum spd_duplex {
 	FORCE_100M_FULL,
 	FORCE_1000M_FULL,
 	NWAY_2500M_FULL,
+	NWAY_5000M_FULL,
 };
 
 /* OCP_ALDPS_CONFIG */
@@ -741,6 +742,7 @@ enum spd_duplex {
 #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
 
 enum rtl_register_content {
+	_5000bps	= BIT(12),
 	_2500bps	= BIT(10),
 	_1250bps	= BIT(9),
 	_500bps		= BIT(8),
@@ -754,6 +756,7 @@ enum rtl_register_content {
 };
 
 #define is_speed_2500(_speed)	(((_speed) & (_2500bps | LINK_STATUS)) == (_2500bps | LINK_STATUS))
+#define is_speed_5000(_speed)	(((_speed) & (_5000bps | LINK_STATUS)) == (_5000bps | LINK_STATUS))
 #define is_flow_control(_speed)	(((_speed) & (_tx_flow | _rx_flow)) == (_tx_flow | _rx_flow))
 
 #define RTL8152_MAX_TX		4
@@ -1004,6 +1007,7 @@ struct r8152 {
 	unsigned int pipe_in, pipe_out, pipe_intr, pipe_ctrl_in, pipe_ctrl_out;
 
 	u32 support_2500full:1;
+	u32 support_5000full:1;
 	u32 lenovo_macpassthru:1;
 	u32 dell_tb_rx_agg_bug:1;
 	u16 ocp_base;
@@ -1255,6 +1259,7 @@ enum tx_csum_stat {
 #define RTL_ADVERTISED_1000_HALF		BIT(4)
 #define RTL_ADVERTISED_1000_FULL		BIT(5)
 #define RTL_ADVERTISED_2500_FULL		BIT(6)
+#define RTL_ADVERTISED_5000_FULL		BIT(7)
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
  * The RTL chips use a 64 element hash table based on the Ethernet CRC.
@@ -6669,6 +6674,9 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 
 			if (tp->support_2500full)
 				support |= RTL_ADVERTISED_2500_FULL;
+
+			if (tp->support_5000full)
+				support |= RTL_ADVERTISED_5000_FULL;
 		}
 
 		if (!(advertising & support))
@@ -6714,15 +6722,20 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
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
@@ -9263,6 +9276,9 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 			 cmd->link_modes.supported, tp->support_2500full);
 
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 cmd->link_modes.supported, tp->support_5000full);
+
 	if (tp->support_2500full) {
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 				 cmd->link_modes.advertising,
@@ -9276,6 +9292,19 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
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
@@ -9323,6 +9352,10 @@ static int rtl8152_set_link_ksettings(struct net_device *dev,
 		     cmd->link_modes.advertising))
 		advertising |= RTL_ADVERTISED_2500_FULL;
 
+	if (test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+		     cmd->link_modes.advertising))
+		advertising |= RTL_ADVERTISED_5000_FULL;
+
 	mutex_lock(&tp->control);
 
 	ret = rtl8152_set_speed(tp, cmd->base.autoneg, cmd->base.speed,
@@ -10456,6 +10489,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
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


