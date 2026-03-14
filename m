Return-Path: <netdev+bounces-267690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHi/KQwrtWnNxAAAu9opvQ
	(envelope-from <netdev+bounces-267690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:31:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A22428C5E2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 721BD3015B41
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153CF329371;
	Sat, 14 Mar 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="gD5GNwlN";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NBOQjM5T"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CB54768;
	Sat, 14 Mar 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480714; cv=none; b=ok9AaqvTQt/czx3L4c7Fq1bawRSalHH6JUMfIRl+IkY9CpujR5c463au2VfXa+t8HSp8TNLFON4bjSvjo00rIAuP4L7fvDbJDSH0pWJ7i0m4KPkA5p+RkbdAhuV+xIV7+7aSCp4jJ9E+6hikBALcOSr8rdW4OaB6qIiUo1UbYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480714; c=relaxed/simple;
	bh=kg1M5KLfR5Qb64R4Q4qeIgsFHFjGRkixCYeT1nI+vj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuwIOywMCXp7jEowDkJJUHAbT0W8Rl0PReEhpWLOtNvc67FPW1H0xDO2rtxTapOWwblK5n32aAxMhzWC89TIUj6aAHDoGEqXYb681pzYVg9ScIcChM4j4w9X1wrtIxAEGayVlZqdYaZQDAtv6ElKbc9gmH5UpCbdYxnCRu06ZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=gD5GNwlN; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NBOQjM5T; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480708;
	bh=kg1M5KLfR5Qb64R4Q4qeIgsFHFjGRkixCYeT1nI+vj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gD5GNwlNXXqcTpXRYkq2EQsz6YXshvERChvfGl8buAhaBjIOt5V0uN+tFNUlrFPdL
	 blThdTJeeRdUbTiJrYNMCfXehJI7fVOEGPqLikbleVKO6laLI5R6WxFL8Eazm+GCw1
	 X69B6fHDv4S1D6ZL6yT9jTTlnh5kP1XgL42dwWTo+AWe+uWLTzoGYRBjA2S3MZeq0M
	 bS5Rlc5UHwjPtsMGi5wB/T/00ImSRnQyEvM7bnNyQRceCRQG+xp/IOVht9N0asyUwc
	 6S0YPBJ0wUrBJ4fwRYFsp9janNAkbO09qrSyHJQ107HTds/rHM3b0Xsdl1wMIR3ylZ
	 eRGUMkX4in5mQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 48DCB3FCDC; Sat, 14 Mar 2026 09:31:48 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480703;
	bh=kg1M5KLfR5Qb64R4Q4qeIgsFHFjGRkixCYeT1nI+vj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NBOQjM5Tw2RdJozW1/QWjqX0lQwP+acBgEyl/rOe3PB25G1TiqxtWAd2y6r8nEQ0t
	 JX4hgVXYagIkxQY/Y8TXtoECNS3tXJ9d++agqUfBHhu1ShI5I14G6QaZn8pFXw63mI
	 ou7UGsocvgc7bBNf5+siE+Yn+06TxRa8jU6HVc7WOz6unDPzpzu/yOL1533C/Arno/
	 E1XcC4ZhP0mIvEIvz7dvMOGpuYgg7w95OYNpSRrJ0QWaErVAOkhkO2gNs5+It/PI7l
	 vTb0vgl9hM+3uepUnsChS1nXQQTBIcvqJzsXAQB6JWur5ke8djGBADw0mDdlyfOt68
	 70zVNEwvCcYPw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A38993FCC8;
	Sat, 14 Mar 2026 09:31:43 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:42 +0100
Subject: [PATCH net-next 6/9] r8152: Add support for chip version
 RTL_VER_16
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-6-9ba77b428afd@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-267690-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A22428C5E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8157 uses RTL_VER_16. Add support for this version in all
remaining configuration functions for power management and RX/TX
configuration.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 71 ++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 435ab6bbae6f2f3a5df59d20ba8838217bf0a841..bef38211c3157b5774ceccbfd923b227f285aaaf 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3609,6 +3609,7 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 	case RTL_VER_12:
 	case RTL_VER_13:
 	case RTL_VER_15:
+	case RTL_VER_16:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_TIMEOUT,
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
@@ -3652,6 +3653,10 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
 		break;
+	case RTL_VER_16:
+		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
+			       ocp_data / 16);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -3777,6 +3782,7 @@ static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 	case RTL_VER_12:
 	case RTL_VER_13:
 	case RTL_VER_15:
+	case RTL_VER_16:
 	default:
 		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_RCR1);
 		if (enable)
@@ -4468,6 +4474,14 @@ static void rtl8156_runtime_enable(struct r8152 *tp, bool enable)
 	}
 }
 
+static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
+{
+	r8153_queue_wake(tp, enable);
+	r8153b_u1u2en(tp, false);
+	r8157_u2p3en(tp, false);
+	rtl_runtime_suspend_enable(tp, enable);
+}
+
 static void r8153_teredo_off(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -4495,6 +4509,7 @@ static void r8153_teredo_off(struct r8152 *tp)
 	case RTL_VER_13:
 	case RTL_VER_14:
 	case RTL_VER_15:
+	case RTL_VER_16:
 	default:
 		/* The bit 0 ~ 7 are relative with teredo settings. They are
 		 * W1C (write 1 to clear), so set all 1 to disable it.
@@ -4551,6 +4566,7 @@ static void rtl_clear_bp(struct r8152 *tp, u16 type)
 		bp_num = 8;
 		break;
 	case RTL_VER_14:
+	case RTL_VER_16:
 	default:
 		ocp_write_word(tp, type, USB_BP2_EN, 0);
 		bp_num = 16;
@@ -4666,6 +4682,7 @@ static bool rtl8152_is_fw_phy_speed_up_ok(struct r8152 *tp, struct fw_phy_speed_
 	case RTL_VER_11:
 	case RTL_VER_12:
 	case RTL_VER_14:
+	case RTL_VER_16:
 		goto out;
 	case RTL_VER_13:
 	case RTL_VER_15:
@@ -5831,6 +5848,7 @@ static void rtl_eee_enable(struct r8152 *tp, bool enable)
 	case RTL_VER_12:
 	case RTL_VER_13:
 	case RTL_VER_15:
+	case RTL_VER_16:
 		if (enable) {
 			r8156_eee_en(tp, true);
 			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
@@ -6967,26 +6985,24 @@ static void rtl8156_up(struct r8152 *tp)
 		return;
 
 	r8153b_u1u2en(tp, false);
-	r8153_u2p3en(tp, false);
+	if (tp->version != RTL_VER_16)
+		r8153_u2p3en(tp, false);
 	r8153_aldps_en(tp, false);
 
 	rxdy_gated_en(tp, true);
 	r8153_teredo_off(tp);
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~RCR_ACPT_ALL;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
 
 	rtl8152_nic_reset(tp);
 	rtl_reset_bmu(tp);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data &= ~MCU_BORW_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	if (tp->version == RTL_VER_16)
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
 
@@ -6996,9 +7012,7 @@ static void rtl8156_up(struct r8152 *tp)
 	case RTL_TEST_01:
 	case RTL_VER_10:
 	case RTL_VER_11:
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_BMU_CONFIG);
-		ocp_data |= ACT_ODMA;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
 		break;
 	default:
 		break;
@@ -7010,13 +7024,11 @@ static void rtl8156_up(struct r8152 *tp)
 	ocp_data |= 0x08;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, ocp_data);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION);
-	ocp_data &= ~(RG_PWRDN_EN | ALL_SPEED_OFF);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, ocp_data);
+	if (tp->version != RTL_VER_16)
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+				  RG_PWRDN_EN | ALL_SPEED_OFF);
 
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
 
@@ -7028,7 +7040,7 @@ static void rtl8156_up(struct r8152 *tp)
 	r8153_aldps_en(tp, true);
 	r8153_u2p3en(tp, true);
 
-	if (tp->udev->speed >= USB_SPEED_SUPER)
+	if (tp->version != RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 }
 
@@ -7041,13 +7053,13 @@ static void rtl8156_down(struct r8152 *tp)
 		return;
 	}
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data |= PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
 
 	r8153b_u1u2en(tp, false);
-	r8153_u2p3en(tp, false);
-	r8153b_power_cut_en(tp, false);
+	if (tp->version != RTL_VER_16) {
+		r8153_u2p3en(tp, false);
+		r8153b_power_cut_en(tp, false);
+	}
 	r8153_aldps_en(tp, false);
 
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
@@ -7071,13 +7083,9 @@ static void rtl8156_down(struct r8152 *tp)
 	 */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data |= NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data |= MCU_BORW_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	rtl_rx_vlan_en(tp, true);
 	rxdy_gated_en(tp, false);
@@ -10418,6 +10426,7 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	case RTL_VER_12:
 	case RTL_VER_13:
 	case RTL_VER_15:
+	case RTL_VER_16:
 		netdev->max_mtu = size_to_mtu(16 * 1024);
 		break;
 	case RTL_VER_01:

-- 
2.47.3


