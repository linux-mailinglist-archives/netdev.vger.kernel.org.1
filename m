Return-Path: <netdev+bounces-267689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBrnLAwrtWnNxAAAu9opvQ
	(envelope-from <netdev+bounces-267689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:31:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F21828C5E1
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97788301AB94
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035CD3101D2;
	Sat, 14 Mar 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Jpl+hP7r";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pxGlYGWz"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850B14B977;
	Sat, 14 Mar 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480713; cv=none; b=cz0+vAgxbeDJOPDgY5ggUOnATXDKO9LYguq47OoGCLQzGhqG2hThyDC/e2uqVR2G+1hkvlGieGwh+zZj6C8PwON8p9p6r91EUgmcpAx4JCAhSdLuTZPAUJ2D9Clt/U1h9Nn0lZylpEb2+ZZITv2eg78wj8LqS0NrmuTp+xYUu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480713; c=relaxed/simple;
	bh=/apAhyWlx1BRp3H7HaqwvkLDFiJEWN4GwXhfZCBX31c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXuWpo+XxnM+RS+QMRgm0jikqU4me0o/NkQbKYieV+jMPjHHH6ds+hgrZ9kVPrt5cJ7BqV9UrVZsuij5p4vpGYs7ZAyaRv3NktJiX/8cvXDvKNTMiq2KWCiKDCTzJEvd0d9Fi+WgN0AH0eDuaWfDEDXSoMkvzuz3R6XZ99VCtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Jpl+hP7r; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pxGlYGWz; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480707;
	bh=/apAhyWlx1BRp3H7HaqwvkLDFiJEWN4GwXhfZCBX31c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jpl+hP7rwh4qwu5WXtVWxLavHO4HzM5BN5IIg9OVjfTE1XxgG0m6SgBJO1M/PVdKr
	 dumEpxB6ts9ZQ+xxmZSC//EcQbM69tC5agt0Av2XrP0EhqYQxhpo5zxPGHDvxWcO+f
	 gxJipAia4TWuCQ4c3AaZ/ESvBVk1wZSd0fHyhsnK9Fk1lx0gca2XAGH8iIuAWb7zi6
	 KspbvQ9bbklupsHBZHjJKMQZAygAJo/kzb7hw2G5l8euoWzB/eQjTFx56wmdIAbayK
	 HFfSVx4ItF8JMAx0PfmRdE66A4KzL/+x9tUmhz70kwjZc4nw19mqi++uCrJ+VkomIs
	 jd7OK5EQDBTnQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 932153FCBB; Sat, 14 Mar 2026 09:31:47 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480703;
	bh=/apAhyWlx1BRp3H7HaqwvkLDFiJEWN4GwXhfZCBX31c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pxGlYGWzW7j6zeVA24M4V4n5oNQt1C91L8edFUWVHINLSh46uk014HWCg19JrfDUS
	 lJkrf+WzL39zO/a4gswFgRFvRzDk+3GZ/ZNxlluxJvtF7M6tfK86HDopS+iJCa54gE
	 IuIYWIutziix3k7MaiS0WSVDoIvS+mYjJ3mT1y6TNghfckRMX1pu8p1ctwq6ddnLZb
	 IBqWcG8atw1VI3XnAxddT5MAFwbhhIBaKk489VShcAGHpPbDdJ56EzVZrRgMosQNRm
	 O3qpKzDAvfVBKWDrwKMK5Fr3liiQtL9+03eJTFxI6ebUEOD1b8T9Q38LV0cyL5pGLA
	 bsJsi85gRkEWA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6730A3FCC3;
	Sat, 14 Mar 2026 09:31:43 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:41 +0100
Subject: [PATCH net-next 5/9] r8152: Add RTL8157 startup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-5-9ba77b428afd@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	TAGGED_FROM(0.00)[bounces-267689-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1F21828C5E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add RTL8157 support by combining the existing RTL8156B and RTL8156 enable
functions and add RTL8157-specific functinality in order to improve code readability
and maintainability.
r8156_enable() is now called with RTL_VER_10 and RTL_VER_11 for the RTL8156,
with RTL_VER_12, RTL_VER_13 and RTL_VER_15 for the RTL8156B and with
RTL_VER_16 for the RTL8157. The function checks the version for chip-specific code.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 78 ++++++++++++-------------------------------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d3943cde53d309adec1a4a3c1cb4a2cf63617eea..435ab6bbae6f2f3a5df59d20ba8838217bf0a841 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6534,15 +6534,24 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
-	r8156_fc_parameter(tp);
+	if (tp->version < RTL_VER_12)
+		r8156_fc_parameter(tp);
+
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
+
+	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_16)
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
+
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
 
 	speed = rtl8152_get_speed(tp);
 	rtl_set_ifg(tp, speed);
 
+	if (tp->version <= RTL_VER_16)
+		return rtl_enable(tp);
+
 	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
 	if (speed & _2500bps)
 		ocp_data &= ~IDLE_SPDWN_EN;
@@ -6550,10 +6559,12 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_data |= IDLE_SPDWN_EN;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
 
-	if (speed & _1000bps)
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
-	else if (speed & _500bps)
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x3d);
+	if (tp->version < RTL_VER_12) {
+		if (speed & _1000bps)
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
+		else if (speed & _500bps)
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x3d);
+	}
 
 	if (tp->udev->speed == USB_SPEED_HIGH) {
 		/* USB 0xb45e[3:0] l1_nyet_hird */
@@ -6566,12 +6577,9 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
 	}
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
-	ocp_data &= ~FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 	usleep_range(1000, 2000);
-	ocp_data |= FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 
 	return rtl_enable(tp);
 }
@@ -6584,54 +6592,6 @@ static void rtl8156_disable(struct r8152 *tp)
 	rtl8153_disable(tp);
 }
 
-static int rtl8156b_enable(struct r8152 *tp)
-{
-	u32 ocp_data;
-	u16 speed;
-
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		return -ENODEV;
-
-	set_tx_qlen(tp);
-	rtl_set_eee_plus(tp);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM);
-	ocp_data &= ~RX_AGGR_NUM_MASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, ocp_data);
-
-	r8153_set_rx_early_timeout(tp);
-	r8153_set_rx_early_size(tp);
-
-	speed = rtl8152_get_speed(tp);
-	rtl_set_ifg(tp, speed);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
-	if (speed & _2500bps)
-		ocp_data &= ~IDLE_SPDWN_EN;
-	else
-		ocp_data |= IDLE_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
-
-	if (tp->udev->speed == USB_SPEED_HIGH) {
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_L1_CTRL);
-		ocp_data &= ~0xf;
-		if (is_flow_control(speed))
-			ocp_data |= 0xf;
-		else
-			ocp_data |= 0x1;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
-	}
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
-	ocp_data &= ~FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
-	usleep_range(1000, 2000);
-	ocp_data |= FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
-
-	return rtl_enable(tp);
-}
-
 static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 			     u32 advertising)
 {
@@ -10123,7 +10083,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT;
 		ops->init		= r8156_init;
-		ops->enable		= rtl8156b_enable;
+		ops->enable		= rtl8156_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;

-- 
2.47.3


