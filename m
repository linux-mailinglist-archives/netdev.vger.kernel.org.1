Return-Path: <netdev+bounces-260611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLMWFI/inWnpSQQAu9opvQ
	(envelope-from <netdev+bounces-260611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:40:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF218AA43
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 916DE3045032
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCC3A9DB9;
	Tue, 24 Feb 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="s/LD93QS";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="upcCt8d7"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A453A9DA8;
	Tue, 24 Feb 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954825; cv=none; b=JbKhozHZLbaMInU77mKLbVXGaRFZiwwzJFBWO9/YWi+K+UftPjB7VC9TzSdTOH7zOQWGVwxr62qvuzaj6hJVqRrBdv45gz8Kw4ZG0HaGmNBNDLuH4/RZNASV0ehVevIjSKUHUSysR4X8quIuqMroz4Na345fQkVqEc322Si9jhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954825; c=relaxed/simple;
	bh=gafguLWGAKOX4VUzLMafkbmBpanv93EoncmEBXY8a+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mk3cQFZC0dzTKfLWNbwm5XixQZcqSYr5ZslwvC9JUxrn8dIiwv783egpvgbasJhvnJquLRAQC/N0qPCksrTTpjBx6c+7BEcrR539kNOp+nB3KXR/0vIAy5Vs8l/x0YvOWK/fRBCxqiw3JiC1CKXOGOKYdNgGISRn46OShRG+vP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=s/LD93QS; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=upcCt8d7; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771954822;
	bh=gafguLWGAKOX4VUzLMafkbmBpanv93EoncmEBXY8a+8=;
	h=From:Date:Subject:To:Cc:From;
	b=s/LD93QS80RK8SLUK67hHTAlYK9JUMIE9rTyBTmnOouUlK0nS9qwE1yziJMtsu7eZ
	 ayMngrWq5EM1n9o6Gr1To5KedGHyg/kliSlSs5GgTR1c8+hwWvizy1RUDtSN/1pggh
	 S9+SsOCUqcgzRvyi118YFUV/U4TycnMiDzzIl4h0IQgPriIDIZe9B2CMgGgqaXjjCa
	 IziHsWROw4TkeofSZboDqQ6FF4grZp7Cfl1UeOJSuq96FJGDUoPhjwQg1HtnZtj0mY
	 Ufch//B9F60HDpa5WuNjRUu+Kvb5cHpzU8l9iyMjXXp8lKpGE9iFflw2UKd34gboQP
	 zZq1Ls+pp0QsA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id DCC203F779; Tue, 24 Feb 2026 17:40:22 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771954818;
	bh=gafguLWGAKOX4VUzLMafkbmBpanv93EoncmEBXY8a+8=;
	h=From:Date:Subject:To:Cc:From;
	b=upcCt8d7eiJM40aibFEhXBGtGRFAWNpSChLFbaWRDs/CM9y2Ro6BB75RWyoB6ic6g
	 kLougdr8GVlEKfHeD/llg67+E6UzKA0HG6NZMIkEz4dL1ytkeQfmunmFGQjBI08eN7
	 cm7EYtOD/uG35aWE266ix1NP8gytlAWQ3IE8COAHrvMvudnQxebcY/b4b47DRnHgWD
	 rnBfEqM6hG5yWUidbEwkuTmywDVcs8rHaePMjT68igG1qA1BiQ6PSqSj1urnrIl51j
	 AW9bkTQw2TjwlhSIZNDdXg2E6rM9eqn+Ulj9UCW+5QN7tJ9DLO/XVT5AgnuC6uOcAh
	 BiaGNhUa7JL1g==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 894BE3F0B3;
	Tue, 24 Feb 2026 17:40:18 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 24 Feb 2026 18:40:14 +0100
Subject: [PATCH net-next v2] r8152: Add 2500baseT EEE status/configuration
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-eee2g5-v2-1-cf5c83df036e@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIAH3inWkC/22NywqDMBBFf0Vm3SnJGB901f8oLowZdWiJJQliK
 /57g+suD+dy7g6Rg3CEW7FD4FWiLD4DXQoY5t5PjOIyAymqFVGJ1iAz01QhKdcM9ehM37aQ9+/
 Ao2xn6wGeE3reEnTZzBLTEj7nyapP/6e3atTYKFXbqmysNuZuJUwc8LnYl6Tv1TF0x3H8AFWXq
 mm0AAAA
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-260611-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:mid,birger-koblitz.de:dkim,birger-koblitz.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4AF218AA43
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
Changes in v2:
- Added forgotten writing of tp->eee_adv2 into OCP_EEE_ADV2 
- Initialize common link mode mask to 0 on declaration
- Link to v1: https://lore.kernel.org/r/20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de
---
 drivers/net/usb/r8152.c | 50 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 49433301e7b1d5c98fc32c72f821e31335bc3527..ca65bf450c89a05313474fbaa4350b375a1a171d 100644
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
@@ -5397,7 +5399,7 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
 
 	config = ocp_reg_read(tp, OCP_EEE_ADV2);
 
-	if (enable)
+	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
 		config |= MDIO_EEE_2_5GT;
 	else
 		config &= ~MDIO_EEE_2_5GT;
@@ -8927,7 +8929,8 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
+	u16 speed = rtl8152_get_speed(tp);
 	u16 val;
 
 	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
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
@@ -8961,7 +8973,8 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
+	u16 speed = rtl8152_get_speed(tp);
 	u16 val;
 
 	val = ocp_reg_read(tp, OCP_EEE_ABLE);
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
@@ -9517,6 +9549,7 @@ static int rtl_ops_init(struct r8152 *tp)
 	case RTL_VER_11:
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
+		tp->eee_adv2		= MDIO_EEE_2_5GT;
 		fallthrough;
 	case RTL_VER_10:
 		ops->init		= r8156_init;
@@ -9542,6 +9575,7 @@ static int rtl_ops_init(struct r8152 *tp)
 	case RTL_VER_15:
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
+		tp->eee_adv2		= MDIO_EEE_2_5GT;
 		ops->init		= r8156b_init;
 		ops->enable		= rtl8156b_enable;
 		ops->disable		= rtl8153_disable;

---
base-commit: 89ed47f863c259e0c639d3b8c62cde2c30485c6b
change-id: 20260223-b4-eee2g5-20d7c6fd4a88

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


