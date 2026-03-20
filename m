Return-Path: <netdev+bounces-269843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GXjNDYHvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:37:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7762D7481
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF9330EB246
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A849366067;
	Fri, 20 Mar 2026 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UwgPNaL/"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294A344031;
	Fri, 20 Mar 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995736; cv=none; b=tO1UxXXqfGLny9k7EgJo3NkhREsi9xYgiwf0MWoqSPaqtU+K3Gpp5izQMvCo49ICNnmXLnZIKtq0CdSO5e/B6UKmVVPA5IR8lejE63ufhV2BP8D886ELrZRGme0TB5w5z2IeGj0qh0zwDWZZUdlWJa9Y4CuZb3JcCAB0dmcPRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995736; c=relaxed/simple;
	bh=GIb+hfAEDYirbvLt5cy7lgfB+CFD+Fz9H2U0CCugCNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx5GkYU5isXAbgE1furMpTHF6IrVXyqMmpQ4JHgMbgiol99sMn3DhDRWmUnM/E9SKr+Xfky/LjxfYmgHjzzMQboLIGOdqzRLDFj/rAaefyGC2hz2fHkUHEPdoqBNbDQY3M1KGV8ii6cTO7TZkmQUT2XpBmYagTF9c0HnDqfItn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UwgPNaL/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62K8Yx4D21191263, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773995699; bh=UM5vL7NKyWSgkXkmnGfgzHyjzWUSmw6tqY7yreA+hsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UwgPNaL/5LlvGri7U8p1+mf7XQ8X/UhgkiA2bbwAA8fXwWLWMK+Gb4ltHW8DMf8me
	 Q+8btvWkSqHXGjcAGVolNckfy8zxg12Hyj/SzH+Br2OMgX8+ol45W8/QbZA43LY625
	 EeaSTPaPgcfqpX3Z9Y8evL4/frLKEdwj2qF19dYqq3esSMlU08weYgV3wVOZ7BBgOy
	 OqhFo5bBVui4s30bT9HXxjoqt3IjbajNZF/YH5YGsfLTkMM2hER+JQpEzsHd2SbcpV
	 IYDdFD3ZW0TtE42qMSW379/xXGaQigwZJKOURewONY6QH6hdyAT2MaOC+R8Ior7Xx1
	 p9/MUAWC4JVJg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62K8Yx4D21191263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:34:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 20 Mar 2026 16:34:58 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 20 Mar 2026 16:34:58 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Chih Kai Hsu
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next v2 1/2] r8152: add helper functions for PLA/USB OCP registers
Date: Fri, 20 Mar 2026 16:34:37 +0800
Message-ID: <20260320083438.6295-448-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320083438.6295-447-nic_swsd@realtek.com>
References: <20260320083438.6295-447-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269843-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A7762D7481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the following bitwise operaion functions for PLA/USB OCP registers
to simplify the code.

- ocp_dword_w0w1()
- ocp_word_w0w1()
- ocp_byte_w0w1()
- ocp_dword_clr_bits()
- ocp_dword_set_bits()
- ocp_word_clr_bits()
- ocp_word_set_bits()
- ocp_word_test_and_clr_bits()
- ocp_byte_clr_bits()
- ocp_byte_set_bits()

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 1114 +++++++++++++++------------------------
 1 file changed, 414 insertions(+), 700 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3b6d4252d34c..da9a93d5a733 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1654,6 +1654,78 @@ void write_mii_word(struct net_device *netdev, int phy_id, int reg, int val)
 	r8152_mdio_write(tp, reg, val);
 }
 
+static void
+ocp_dword_w0w1(struct r8152 *tp, u16 type, u16 index, u32 clear, u32 set)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_dword(tp, type, index);
+	ocp_data = (ocp_data & ~clear) | set;
+	ocp_write_dword(tp, type, index, ocp_data);
+}
+
+static void
+ocp_word_w0w1(struct r8152 *tp, u16 type, u16 index, u16 clear, u16 set)
+{
+	u16 ocp_data;
+
+	ocp_data = ocp_read_word(tp, type, index);
+	ocp_data = (ocp_data & ~clear) | set;
+	ocp_write_word(tp, type, index, ocp_data);
+}
+
+static void
+ocp_byte_w0w1(struct r8152 *tp, u16 type, u16 index, u8 clear, u8 set)
+{
+	u8 ocp_data;
+
+	ocp_data = ocp_read_byte(tp, type, index);
+	ocp_data = (ocp_data & ~clear) | set;
+	ocp_write_byte(tp, type, index, ocp_data);
+}
+
+static void ocp_dword_clr_bits(struct r8152 *tp, u16 type, u16 index, u32 clear)
+{
+	ocp_dword_w0w1(tp, type, index, clear, 0);
+}
+
+static void ocp_dword_set_bits(struct r8152 *tp, u16 type, u16 index, u32 set)
+{
+	ocp_dword_w0w1(tp, type, index, 0, set);
+}
+
+static void ocp_word_clr_bits(struct r8152 *tp, u16 type, u16 index, u16 clear)
+{
+	ocp_word_w0w1(tp, type, index, clear, 0);
+}
+
+static void ocp_word_set_bits(struct r8152 *tp, u16 type, u16 index, u16 set)
+{
+	ocp_word_w0w1(tp, type, index, 0, set);
+}
+
+static int
+ocp_word_test_and_clr_bits(struct r8152 *tp, u16 type, u16 index, u16 clear)
+{
+	u16 ocp_data;
+
+	ocp_data = ocp_read_word(tp, type, index);
+	if (ocp_data & clear)
+		ocp_write_word(tp, type, index, ocp_data & ~clear);
+
+	return ocp_data & clear;
+}
+
+static void ocp_byte_clr_bits(struct r8152 *tp, u16 type, u16 index, u8 clear)
+{
+	ocp_byte_w0w1(tp, type, index, clear, 0);
+}
+
+static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)
+{
+	ocp_byte_w0w1(tp, type, index, 0, set);
+}
+
 static int
 r8152_submit_rx(struct r8152 *tp, struct rx_agg *agg, gfp_t mem_flags);
 
@@ -2956,47 +3028,31 @@ static netdev_tx_t rtl8152_start_xmit(struct sk_buff *skb,
 
 static void r8152b_reset_packet_filter(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_FMC);
-	ocp_data &= ~FMC_FCR_MCU_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_FMC, ocp_data);
-	ocp_data |= FMC_FCR_MCU_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_FMC, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_FMC, FMC_FCR_MCU_EN);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_FMC, FMC_FCR_MCU_EN);
 }
 
 static void rtl8152_nic_reset(struct r8152 *tp)
 {
-	u32 ocp_data;
 	int i;
 
 	switch (tp->version) {
 	case RTL_TEST_01:
 	case RTL_VER_10:
 	case RTL_VER_11:
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR);
-		ocp_data &= ~CR_TE;
-		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_TE);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_BMU_RESET);
-		ocp_data &= ~BMU_RESET_EP_IN;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_BMU_RESET, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_BMU_RESET,
+				  BMU_RESET_EP_IN);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-		ocp_data |= CDC_ECM_EN;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, CDC_ECM_EN);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR);
-		ocp_data &= ~CR_RE;
-		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_RE);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_BMU_RESET);
-		ocp_data |= BMU_RESET_EP_IN;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_BMU_RESET, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_BMU_RESET,
+				  BMU_RESET_EP_IN);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-		ocp_data &= ~CDC_ECM_EN;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, CDC_ECM_EN);
 		break;
 
 	default:
@@ -3025,14 +3081,12 @@ static inline u16 rtl8152_get_speed(struct r8152 *tp)
 
 static void rtl_eee_plus_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EEEP_CR);
 	if (enable)
-		ocp_data |= EEEP_CR_EEEP_TX;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EEEP_CR,
+				  EEEP_CR_EEEP_TX);
 	else
-		ocp_data &= ~EEEP_CR_EEEP_TX;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEEP_CR, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_EEEP_CR,
+				  EEEP_CR_EEEP_TX);
 }
 
 static void rtl_set_eee_plus(struct r8152 *tp)
@@ -3045,14 +3099,10 @@ static void rtl_set_eee_plus(struct r8152 *tp)
 
 static void rxdy_gated_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MISC_1);
 	if (enable)
-		ocp_data |= RXDY_GATED_EN;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MISC_1, RXDY_GATED_EN);
 	else
-		ocp_data &= ~RXDY_GATED_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MISC_1, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MISC_1, RXDY_GATED_EN);
 }
 
 static int rtl_start_rx(struct r8152 *tp)
@@ -3140,24 +3190,16 @@ static int rtl_stop_rx(struct r8152 *tp)
 
 static void rtl_set_ifg(struct r8152 *tp, u16 speed)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR1);
-	ocp_data &= ~IFG_MASK;
 	if ((speed & (_10bps | _100bps)) && !(speed & FULL_DUP)) {
-		ocp_data |= IFG_144NS;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_TCR1, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_TCR1, IFG_MASK, IFG_144NS);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
-		ocp_data &= ~TX10MIDLE_EN;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  TX10MIDLE_EN);
 	} else {
-		ocp_data |= IFG_96NS;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_TCR1, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_TCR1, IFG_MASK, IFG_96NS);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
-		ocp_data |= TX10MIDLE_EN;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  TX10MIDLE_EN);
 	}
 }
 
@@ -3169,13 +3211,9 @@ static inline void r8153b_rx_agg_chg_indicate(struct r8152 *tp)
 
 static int rtl_enable(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	r8152b_reset_packet_filter(tp);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR);
-	ocp_data |= CR_RE | CR_TE;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_RE | CR_TE);
 
 	switch (tp->version) {
 	case RTL_VER_01:
@@ -3283,8 +3321,6 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 
 static int rtl8153_enable(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
@@ -3298,12 +3334,9 @@ static int rtl8153_enable(struct r8152 *tp)
 	switch (tp->version) {
 	case RTL_VER_09:
 	case RTL_VER_14:
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
-		ocp_data &= ~FC_PATCH_TASK;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 		usleep_range(1000, 2000);
-		ocp_data |= FC_PATCH_TASK;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 		break;
 	default:
 		break;
@@ -3322,9 +3355,7 @@ static void rtl_disable(struct r8152 *tp)
 		return;
 	}
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~RCR_ACPT_ALL;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
 
 	rtl_drop_queued_tx(tp);
 
@@ -3357,24 +3388,17 @@ static void rtl_disable(struct r8152 *tp)
 
 static void r8152_power_cut_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_UPS_CTRL);
 	if (enable)
-		ocp_data |= POWER_CUT;
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_UPS_CTRL, POWER_CUT);
 	else
-		ocp_data &= ~POWER_CUT;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_UPS_CTRL, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_UPS_CTRL, POWER_CUT);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_PM_CTRL_STATUS);
-	ocp_data &= ~RESUME_INDICATE;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_PM_CTRL_STATUS, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_PM_CTRL_STATUS,
+			  RESUME_INDICATE);
 }
 
 static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
 	switch (tp->version) {
 	case RTL_VER_01:
 	case RTL_VER_02:
@@ -3386,12 +3410,12 @@ static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 	case RTL_VER_08:
 	case RTL_VER_09:
 	case RTL_VER_14:
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CPCR);
 		if (enable)
-			ocp_data |= CPCR_RX_VLAN;
+			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR,
+					  CPCR_RX_VLAN);
 		else
-			ocp_data &= ~CPCR_RX_VLAN;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_CPCR, ocp_data);
+			ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_CPCR,
+					  CPCR_RX_VLAN);
 		break;
 
 	case RTL_TEST_01:
@@ -3401,12 +3425,12 @@ static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	default:
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_RCR1);
 		if (enable)
-			ocp_data |= OUTER_VLAN | INNER_VLAN;
+			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_RCR1,
+					  OUTER_VLAN | INNER_VLAN);
 		else
-			ocp_data &= ~(OUTER_VLAN | INNER_VLAN);
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RCR1, ocp_data);
+			ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1,
+					  OUTER_VLAN | INNER_VLAN);
 		break;
 	}
 }
@@ -3467,33 +3491,33 @@ static u32 __rtl_get_wol(struct r8152 *tp)
 
 static void __rtl_set_wol(struct r8152 *tp, u32 wolopts)
 {
-	u32 ocp_data;
+	u16 ocp_data;
 
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CONFIG34);
-	ocp_data &= ~LINK_ON_WAKE_EN;
 	if (wolopts & WAKE_PHY)
-		ocp_data |= LINK_ON_WAKE_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CONFIG34, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG34,
+				  LINK_ON_WAKE_EN);
+	else
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_CONFIG34,
+				  LINK_ON_WAKE_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CONFIG5);
-	ocp_data &= ~(UWF_EN | BWF_EN | MWF_EN);
+	ocp_data = 0;
 	if (wolopts & WAKE_UCAST)
 		ocp_data |= UWF_EN;
 	if (wolopts & WAKE_BCAST)
 		ocp_data |= BWF_EN;
 	if (wolopts & WAKE_MCAST)
 		ocp_data |= MWF_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CONFIG5, ocp_data);
+	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_CONFIG5, UWF_EN | BWF_EN | MWF_EN,
+		      ocp_data);
 
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CFG_WOL);
-	ocp_data &= ~MAGIC_EN;
 	if (wolopts & WAKE_MAGIC)
-		ocp_data |= MAGIC_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CFG_WOL, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CFG_WOL, MAGIC_EN);
+	else
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_CFG_WOL, MAGIC_EN);
 
 	if (wolopts & WAKE_ANY)
 		device_set_wakeup_enable(&tp->udev->dev, true);
@@ -3503,35 +3527,27 @@ static void __rtl_set_wol(struct r8152 *tp, u32 wolopts)
 
 static void r8153_mac_clk_speed_down(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2);
-
 	/* MAC clock speed down */
 	if (enable)
-		ocp_data |= MAC_CLK_SPDWN_EN;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+				  MAC_CLK_SPDWN_EN);
 	else
-		ocp_data &= ~MAC_CLK_SPDWN_EN;
-
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+				  MAC_CLK_SPDWN_EN);
 }
 
 static void r8156_mac_clk_spd(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
 	/* MAC clock speed down */
 	if (enable) {
 		/* aldps_spdwn_ratio, tp10_spdwn_ratio */
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL,
-			       0x0403);
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL, 0x0403);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2);
-		ocp_data &= ~EEE_SPDWN_RATIO_MASK;
-		ocp_data |= MAC_CLK_SPDWN_EN | 0x03; /* eee_spdwn_ratio */
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+			      EEE_SPDWN_RATIO_MASK, MAC_CLK_SPDWN_EN | 0x03);
 	} else {
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2);
-		ocp_data &= ~MAC_CLK_SPDWN_EN;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+				  MAC_CLK_SPDWN_EN);
 	}
 }
 
@@ -3549,27 +3565,20 @@ static void r8153_u1u2en(struct r8152 *tp, bool enable)
 
 static void r8153b_u1u2en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_LPM_CONFIG);
 	if (enable)
-		ocp_data |= LPM_U1U2_EN;
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_LPM_CONFIG,
+				  LPM_U1U2_EN);
 	else
-		ocp_data &= ~LPM_U1U2_EN;
-
-	ocp_write_word(tp, MCU_TYPE_USB, USB_LPM_CONFIG, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_LPM_CONFIG,
+				  LPM_U1U2_EN);
 }
 
 static void r8153_u2p3en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL);
 	if (enable)
-		ocp_data |= U2P3_ENABLE;
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, U2P3_ENABLE);
 	else
-		ocp_data &= ~U2P3_ENABLE;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, U2P3_ENABLE);
 }
 
 static void r8153b_ups_flags(struct r8152 *tp)
@@ -3784,24 +3793,20 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
 
 static void r8153b_ups_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_POWER_CUT);
-
 	if (enable) {
 		r8153b_ups_flags(tp);
 
-		ocp_data |= UPS_EN | USP_PREWAKE | PHASE2_EN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE | PHASE2_EN);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
-		ocp_data |= UPS_FORCE_PWR_DOWN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
+				  UPS_FORCE_PWR_DOWN);
 	} else {
-		ocp_data &= ~(UPS_EN | USP_PREWAKE);
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
-		ocp_data &= ~UPS_FORCE_PWR_DOWN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
+				  UPS_FORCE_PWR_DOWN);
 
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
 			int i;
@@ -3825,25 +3830,20 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 
 static void r8153c_ups_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_POWER_CUT);
-
 	if (enable) {
 		r8153b_ups_flags(tp);
 
-		ocp_data |= UPS_EN | USP_PREWAKE | PHASE2_EN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE | PHASE2_EN);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
-		ocp_data |= UPS_FORCE_PWR_DOWN;
-		ocp_data &= ~BIT(7);
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
+		ocp_byte_w0w1(tp, MCU_TYPE_USB, USB_MISC_2, BIT(7),
+			      UPS_FORCE_PWR_DOWN);
 	} else {
-		ocp_data &= ~(UPS_EN | USP_PREWAKE);
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
-		ocp_data &= ~UPS_FORCE_PWR_DOWN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
+				  UPS_FORCE_PWR_DOWN);
 
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
 			int i;
@@ -3865,9 +3865,7 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CONFIG34);
-		ocp_data |= BIT(8);
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_CONFIG34, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG34, BIT(8));
 
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 	}
@@ -3875,35 +3873,30 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 
 static void r8156_ups_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_POWER_CUT);
-
 	if (enable) {
 		r8156_ups_flags(tp);
 
-		ocp_data |= UPS_EN | USP_PREWAKE | PHASE2_EN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE | PHASE2_EN);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
-		ocp_data |= UPS_FORCE_PWR_DOWN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
+				  UPS_FORCE_PWR_DOWN);
 
 		switch (tp->version) {
 		case RTL_VER_13:
 		case RTL_VER_15:
-			ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_UPHY_XTAL);
-			ocp_data &= ~OOBS_POLLING;
-			ocp_write_byte(tp, MCU_TYPE_USB, USB_UPHY_XTAL, ocp_data);
+			ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_UPHY_XTAL,
+					  OOBS_POLLING);
 			break;
 		default:
 			break;
 		}
 	} else {
-		ocp_data &= ~(UPS_EN | USP_PREWAKE);
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
-		ocp_data &= ~UPS_FORCE_PWR_DOWN;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
+				  UPS_FORCE_PWR_DOWN);
 
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
 			tp->rtl_ops.hw_phy_cfg(tp);
@@ -3916,54 +3909,38 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
 
 static void r8153_power_cut_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_POWER_CUT);
 	if (enable)
-		ocp_data |= PWR_EN | PHASE2_EN;
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  PWR_EN | PHASE2_EN);
 	else
-		ocp_data &= ~(PWR_EN | PHASE2_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  PWR_EN | PHASE2_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	ocp_data &= ~PCUT_STATUS;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
 }
 
 static void r8153b_power_cut_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_POWER_CUT);
 	if (enable)
-		ocp_data |= PWR_EN | PHASE2_EN;
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  PWR_EN | PHASE2_EN);
 	else
-		ocp_data &= ~PWR_EN;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	ocp_data &= ~PCUT_STATUS;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
 }
 
 static void r8153_queue_wake(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG);
 	if (enable)
-		ocp_data |= UPCOMING_RUNTIME_D3;
+		ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG,
+				  UPCOMING_RUNTIME_D3);
 	else
-		ocp_data &= ~UPCOMING_RUNTIME_D3;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG,
+				  UPCOMING_RUNTIME_D3);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_SUSPEND_FLAG);
-	ocp_data &= ~LINK_CHG_EVENT;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_SUSPEND_FLAG, ocp_data);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
-	ocp_data &= ~LINK_CHANGE_FLAG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_SUSPEND_FLAG, LINK_CHG_EVENT);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, LINK_CHANGE_FLAG);
 }
 
 static bool rtl_can_wakeup(struct r8152 *tp)
@@ -3976,27 +3953,21 @@ static bool rtl_can_wakeup(struct r8152 *tp)
 static void rtl_runtime_suspend_enable(struct r8152 *tp, bool enable)
 {
 	if (enable) {
-		u32 ocp_data;
-
 		__rtl_set_wol(tp, WAKE_ANY);
 
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CONFIG34);
-		ocp_data |= LINK_OFF_WAKE_EN;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_CONFIG34, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG34,
+				  LINK_OFF_WAKE_EN);
 
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 	} else {
-		u32 ocp_data;
-
 		__rtl_set_wol(tp, tp->saved_wolopts);
 
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CONFIG34);
-		ocp_data &= ~LINK_OFF_WAKE_EN;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_CONFIG34, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_CONFIG34,
+				  LINK_OFF_WAKE_EN);
 
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 	}
@@ -4077,8 +4048,6 @@ static void rtl8156_runtime_enable(struct r8152 *tp, bool enable)
 
 static void r8153_teredo_off(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	switch (tp->version) {
 	case RTL_VER_01:
 	case RTL_VER_02:
@@ -4087,10 +4056,9 @@ static void r8153_teredo_off(struct r8152 *tp)
 	case RTL_VER_05:
 	case RTL_VER_06:
 	case RTL_VER_07:
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG);
-		ocp_data &= ~(TEREDO_SEL | TEREDO_RS_EVENT_MASK |
-			      OOB_TEREDO_EN);
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG,
+				  TEREDO_SEL | TEREDO_RS_EVENT_MASK |
+				  OOB_TEREDO_EN);
 		break;
 
 	case RTL_VER_08:
@@ -4117,13 +4085,10 @@ static void r8153_teredo_off(struct r8152 *tp)
 
 static void rtl_reset_bmu(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_BMU_RESET);
-	ocp_data &= ~(BMU_RESET_EP_IN | BMU_RESET_EP_OUT);
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_BMU_RESET, ocp_data);
-	ocp_data |= BMU_RESET_EP_IN | BMU_RESET_EP_OUT;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_BMU_RESET, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_BMU_RESET,
+			  BMU_RESET_EP_IN | BMU_RESET_EP_OUT);
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_RESET,
+			  BMU_RESET_EP_IN | BMU_RESET_EP_OUT);
 }
 
 /* Clear the bp to stop the firmware before loading a new one */
@@ -4944,7 +4909,7 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 		return;
 
 	while (len) {
-		u32 ocp_data, size;
+		u32 size;
 		int i;
 
 		if (len < 2048)
@@ -4952,18 +4917,16 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 		else
 			size = 2048;
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL);
-		ocp_data |= GPHY_PATCH_DONE | BACKUP_RESTRORE;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_GPHY_CTRL,
+				  GPHY_PATCH_DONE | BACKUP_RESTRORE);
 
 		generic_ocp_write(tp, __le16_to_cpu(phy->fw_reg), 0xff, size, data, MCU_TYPE_USB);
 
 		data += size;
 		len -= size;
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL);
-		ocp_data |= POL_GPHY_PATCH;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL,
+				  POL_GPHY_PATCH);
 
 		for (i = 0; i < 1000; i++) {
 			if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & POL_GPHY_PATCH))
@@ -5337,21 +5300,21 @@ static void r8152_mmd_write(struct r8152 *tp, u16 dev, u16 reg, u16 data)
 static void r8152_eee_en(struct r8152 *tp, bool enable)
 {
 	u16 config1, config2, config3;
-	u32 ocp_data;
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EEE_CR);
 	config1 = ocp_reg_read(tp, OCP_EEE_CONFIG1) & ~sd_rise_time_mask;
 	config2 = ocp_reg_read(tp, OCP_EEE_CONFIG2);
 	config3 = ocp_reg_read(tp, OCP_EEE_CONFIG3) & ~fast_snr_mask;
 
 	if (enable) {
-		ocp_data |= EEE_RX_EN | EEE_TX_EN;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
+				  EEE_RX_EN | EEE_TX_EN);
 		config1 |= EEE_10_CAP | EEE_NWAY_EN | TX_QUIET_EN | RX_QUIET_EN;
 		config1 |= sd_rise_time(1);
 		config2 |= RG_DACQUIET_EN | RG_LDVQUIET_EN;
 		config3 |= fast_snr(42);
 	} else {
-		ocp_data &= ~(EEE_RX_EN | EEE_TX_EN);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
+				  EEE_RX_EN | EEE_TX_EN);
 		config1 &= ~(EEE_10_CAP | EEE_NWAY_EN | TX_QUIET_EN |
 			     RX_QUIET_EN);
 		config1 |= sd_rise_time(7);
@@ -5359,7 +5322,6 @@ static void r8152_eee_en(struct r8152 *tp, bool enable)
 		config3 |= fast_snr(511);
 	}
 
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_CR, ocp_data);
 	ocp_reg_write(tp, OCP_EEE_CONFIG1, config1);
 	ocp_reg_write(tp, OCP_EEE_CONFIG2, config2);
 	ocp_reg_write(tp, OCP_EEE_CONFIG3, config3);
@@ -5367,21 +5329,20 @@ static void r8152_eee_en(struct r8152 *tp, bool enable)
 
 static void r8153_eee_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
 	u16 config;
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EEE_CR);
 	config = ocp_reg_read(tp, OCP_EEE_CFG);
 
 	if (enable) {
-		ocp_data |= EEE_RX_EN | EEE_TX_EN;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
+				  EEE_RX_EN | EEE_TX_EN);
 		config |= EEE10_EN;
 	} else {
-		ocp_data &= ~(EEE_RX_EN | EEE_TX_EN);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
+				  EEE_RX_EN | EEE_TX_EN);
 		config &= ~EEE10_EN;
 	}
 
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_CR, ocp_data);
 	ocp_reg_write(tp, OCP_EEE_CFG, config);
 
 	tp->ups_info.eee = enable;
@@ -5512,30 +5473,20 @@ static void r8156b_wait_loading_flash(struct r8152 *tp)
 
 static void r8152b_exit_oob(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~RCR_ACPT_ALL;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
 
 	rxdy_gated_en(tp, true);
 	r8153_teredo_off(tp);
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, 0x00);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data &= ~MCU_BORW_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	wait_oob_link_list_ready(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data |= RE_INIT_LL;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, RE_INIT_LL);
 
 	wait_oob_link_list_ready(tp);
 
@@ -5571,18 +5522,12 @@ static void r8152b_exit_oob(struct r8152 *tp)
 
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, RTL8152_RMS);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR0);
-	ocp_data |= TCR0_AUTO_FIFO;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TCR0, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_TCR0, TCR0_AUTO_FIFO);
 }
 
 static void r8152b_enter_oob(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
 	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL0, RXFIFO_THR1_OOB);
 	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL1, RXFIFO_THR2_OOB);
@@ -5592,9 +5537,7 @@ static void r8152b_enter_oob(struct r8152 *tp)
 
 	wait_oob_link_list_ready(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data |= RE_INIT_LL;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, RE_INIT_LL);
 
 	wait_oob_link_list_ready(tp);
 
@@ -5602,19 +5545,15 @@ static void r8152b_enter_oob(struct r8152 *tp)
 
 	rtl_rx_vlan_en(tp, true);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_BDC_CR);
-	ocp_data |= ALDPS_PROXY_MODE;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_BDC_CR, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data |= NOW_IS_OOB | DIS_MCU_CLROOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			  NOW_IS_OOB | DIS_MCU_CLROOB);
 
 	rxdy_gated_en(tp, false);
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data |= RCR_APM | RCR_AM | RCR_AB;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
+			   RCR_APM | RCR_AM | RCR_AB);
 }
 
 static int r8153_pre_firmware_1(struct r8152 *tp)
@@ -5649,27 +5588,18 @@ static int r8153_post_firmware_1(struct r8152 *tp)
 
 static int r8153_pre_firmware_2(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	r8153_pre_firmware_1(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN0);
-	ocp_data &= ~FW_FIX_SUSPEND;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN0, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_FIX_EN0, FW_FIX_SUSPEND);
 
 	return 0;
 }
 
 static int r8153_post_firmware_2(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	/* enable bp0 if support USB_SPEED_SUPER only */
-	if (ocp_read_byte(tp, MCU_TYPE_USB, USB_CSTMR) & FORCE_SUPER) {
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_BP_EN);
-		ocp_data |= BIT(0);
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_EN, ocp_data);
-	}
+	if (ocp_read_byte(tp, MCU_TYPE_USB, USB_CSTMR) & FORCE_SUPER)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BP_EN, BIT(0));
 
 	/* reset UPHY timer to 36 ms */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_UPHY_TIMER, 36000 / 16);
@@ -5677,28 +5607,20 @@ static int r8153_post_firmware_2(struct r8152 *tp)
 	/* enable U3P3 check, set the counter to 4 */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, U3P3_CHECK_EN | 4);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN0);
-	ocp_data |= FW_FIX_SUSPEND;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN0, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_FIX_EN0, FW_FIX_SUSPEND);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_USB2PHY);
-	ocp_data |= USB2PHY_L1 | USB2PHY_SUSPEND;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_USB2PHY, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_USB2PHY,
+			  USB2PHY_L1 | USB2PHY_SUSPEND);
 
 	return 0;
 }
 
 static int r8153_post_firmware_3(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_USB2PHY);
-	ocp_data |= USB2PHY_L1 | USB2PHY_SUSPEND;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_USB2PHY, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_USB2PHY,
+			  USB2PHY_L1 | USB2PHY_SUSPEND);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1);
-	ocp_data |= FW_IP_RESET_EN;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, FW_IP_RESET_EN);
 
 	return 0;
 }
@@ -5718,49 +5640,30 @@ static int r8153b_post_firmware_1(struct r8152 *tp)
 
 	/* enable bp0 for RTL8153-BND */
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
-	if (ocp_data & BND_MASK) {
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_BP_EN);
-		ocp_data |= BIT(0);
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_EN, ocp_data);
-	}
+	if (ocp_data & BND_MASK)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BP_EN, BIT(0));
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
-	ocp_data |= FLOW_CTRL_PATCH_OPT;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, FLOW_CTRL_PATCH_OPT);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
-	ocp_data |= FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1);
-	ocp_data |= FW_IP_RESET_EN;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, FW_IP_RESET_EN);
 
 	return 0;
 }
 
 static int r8153c_post_firmware_1(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
-	ocp_data |= FLOW_CTRL_PATCH_2;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, FLOW_CTRL_PATCH_2);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
-	ocp_data |= FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 
 	return 0;
 }
 
 static int r8156a_post_firmware_1(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1);
-	ocp_data |= FW_IP_RESET_EN;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, FW_IP_RESET_EN);
 
 	/* Modify U3PHY parameter for compatibility issue */
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_UPHY3_MDCMDIO, 0x4026840e);
@@ -5796,7 +5699,6 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 
 static void r8153_hw_phy_cfg(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 
 	/* disable ALDPS before updating the PHY parameters */
@@ -5823,11 +5725,10 @@ static void r8153_hw_phy_cfg(struct r8152 *tp)
 	data = ocp_reg_read(tp, OCP_POWER_CFG);
 	data |= EN_10M_PLLOFF;
 	ocp_reg_write(tp, OCP_POWER_CFG, data);
+
 	sram_write(tp, SRAM_IMPEDANCE, 0x0b13);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR);
-	ocp_data |= PFM_PWM_SWITCH;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
 
 	/* Enable LPF corner auto tune */
 	sram_write(tp, SRAM_LPF_CFG, 0xf70f);
@@ -5873,11 +5774,7 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 	u32 ocp_data;
 	u16 data;
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	if (ocp_data & PCUT_STATUS) {
-		ocp_data &= ~PCUT_STATUS;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
-	}
+	ocp_word_test_and_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
 
 	/* disable ALDPS before updating the PHY parameters */
 	r8153_aldps_en(tp, false);
@@ -5934,14 +5831,11 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 		u32 swr_cnt_1ms_ini;
 
 		swr_cnt_1ms_ini = (16000000 / ocp_data) & SAW_CNT_1MS_MASK;
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_UPS_CFG);
-		ocp_data = (ocp_data & ~SAW_CNT_1MS_MASK) | swr_cnt_1ms_ini;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_UPS_CFG, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_UPS_CFG, SAW_CNT_1MS_MASK,
+			      swr_cnt_1ms_ini);
 	}
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR);
-	ocp_data |= PFM_PWM_SWITCH;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
 
 	/* Advnace EEE */
 	if (!rtl_phy_patch_request(tp, true, true)) {
@@ -5988,31 +5882,21 @@ static void rtl8153_change_mtu(struct r8152 *tp)
 
 static void r8153_first_init(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	rxdy_gated_en(tp, true);
 	r8153_teredo_off(tp);
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~RCR_ACPT_ALL;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
 
 	rtl8152_nic_reset(tp);
 	rtl_reset_bmu(tp);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data &= ~MCU_BORW_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	wait_oob_link_list_ready(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data |= RE_INIT_LL;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, RE_INIT_LL);
 
 	wait_oob_link_list_ready(tp);
 
@@ -6020,9 +5904,7 @@ static void r8153_first_init(struct r8152 *tp)
 
 	rtl8153_change_mtu(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR0);
-	ocp_data |= TCR0_AUTO_FIFO;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TCR0, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_TCR0, TCR0_AUTO_FIFO);
 
 	rtl8152_nic_reset(tp);
 
@@ -6036,11 +5918,7 @@ static void r8153_first_init(struct r8152 *tp)
 
 static void r8153_enter_oob(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
 	/* RX FIFO settings for OOB */
 	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL0, RXFIFO_THR1_OOB);
@@ -6052,9 +5930,7 @@ static void r8153_enter_oob(struct r8152 *tp)
 
 	wait_oob_link_list_ready(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data |= RE_INIT_LL;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, RE_INIT_LL);
 
 	wait_oob_link_list_ready(tp);
 
@@ -6066,9 +5942,8 @@ static void r8153_enter_oob(struct r8152 *tp)
 	case RTL_VER_04:
 	case RTL_VER_05:
 	case RTL_VER_06:
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG);
-		ocp_data &= ~TEREDO_WAKE_MASK;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG,
+				  TEREDO_WAKE_MASK);
 		break;
 
 	case RTL_VER_08:
@@ -6087,23 +5962,17 @@ static void r8153_enter_oob(struct r8152 *tp)
 
 	rtl_rx_vlan_en(tp, true);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_BDC_CR);
-	ocp_data |= ALDPS_PROXY_MODE;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_BDC_CR, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data |= NOW_IS_OOB | DIS_MCU_CLROOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			  NOW_IS_OOB | DIS_MCU_CLROOB);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data |= MCU_BORW_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	rxdy_gated_en(tp, false);
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data |= RCR_APM | RCR_AM | RCR_AB;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
+			   RCR_APM | RCR_AM | RCR_AB);
 }
 
 static void rtl8153_disable(struct r8152 *tp)
@@ -6135,7 +6004,6 @@ static void r8156_fc_parameter(struct r8152 *tp)
 
 static int rtl8156_enable(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 speed;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -6150,12 +6018,12 @@ static int rtl8156_enable(struct r8152 *tp)
 	speed = rtl8152_get_speed(tp);
 	rtl_set_ifg(tp, speed);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
 	if (speed & _2500bps)
-		ocp_data &= ~IDLE_SPDWN_EN;
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  IDLE_SPDWN_EN);
 	else
-		ocp_data |= IDLE_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  IDLE_SPDWN_EN);
 
 	if (speed & _1000bps)
 		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
@@ -6164,21 +6032,15 @@ static int rtl8156_enable(struct r8152 *tp)
 
 	if (tp->udev->speed == USB_SPEED_HIGH) {
 		/* USB 0xb45e[3:0] l1_nyet_hird */
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_L1_CTRL);
-		ocp_data &= ~0xf;
 		if (is_flow_control(speed))
-			ocp_data |= 0xf;
+			ocp_word_w0w1(tp, MCU_TYPE_USB, USB_L1_CTRL, 0xf, 0xf);
 		else
-			ocp_data |= 0x1;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
+			ocp_word_w0w1(tp, MCU_TYPE_USB, USB_L1_CTRL, 0xf, 0x1);
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
@@ -6193,7 +6055,6 @@ static void rtl8156_disable(struct r8152 *tp)
 
 static int rtl8156b_enable(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 speed;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -6202,9 +6063,7 @@ static int rtl8156b_enable(struct r8152 *tp)
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM);
-	ocp_data &= ~RX_AGGR_NUM_MASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
 
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
@@ -6212,29 +6071,23 @@ static int rtl8156b_enable(struct r8152 *tp)
 	speed = rtl8152_get_speed(tp);
 	rtl_set_ifg(tp, speed);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
 	if (speed & _2500bps)
-		ocp_data &= ~IDLE_SPDWN_EN;
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  IDLE_SPDWN_EN);
 	else
-		ocp_data |= IDLE_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  IDLE_SPDWN_EN);
 
 	if (tp->udev->speed == USB_SPEED_HIGH) {
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_L1_CTRL);
-		ocp_data &= ~0xf;
 		if (is_flow_control(speed))
-			ocp_data |= 0xf;
+			ocp_word_w0w1(tp, MCU_TYPE_USB, USB_L1_CTRL, 0xf, 0xf);
 		else
-			ocp_data |= 0x1;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
+			ocp_word_w0w1(tp, MCU_TYPE_USB, USB_L1_CTRL, 0xf, 0x1);
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
@@ -6405,8 +6258,6 @@ static void rtl8152_down(struct r8152 *tp)
 
 static void rtl8153_up(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
@@ -6415,17 +6266,11 @@ static void rtl8153_up(struct r8152 *tp)
 	r8153_aldps_en(tp, false);
 	r8153_first_init(tp);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6);
-	ocp_data |= LANWAKE_CLR_EN;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG6, LANWAKE_CLR_EN);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG);
-	ocp_data &= ~LANWAKE_PIN;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, LANWAKE_PIN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1);
-	ocp_data &= ~DELAY_PHY_PWR_CHG;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SSPHYLINK1, DELAY_PHY_PWR_CHG);
 
 	r8153_aldps_en(tp, true);
 
@@ -6445,16 +6290,12 @@ static void rtl8153_up(struct r8152 *tp)
 
 static void rtl8153_down(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6);
-	ocp_data &= ~LANWAKE_CLR_EN;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CONFIG6, LANWAKE_CLR_EN);
 
 	r8153_u1u2en(tp, false);
 	r8153_u2p3en(tp, false);
@@ -6466,8 +6307,6 @@ static void rtl8153_down(struct r8152 *tp)
 
 static void rtl8153b_up(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
@@ -6478,9 +6317,8 @@ static void rtl8153b_up(struct r8152 *tp)
 	r8153_first_init(tp);
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, RX_THR_B);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
 	r8153_aldps_en(tp, true);
 
@@ -6490,16 +6328,13 @@ static void rtl8153b_up(struct r8152 *tp)
 
 static void rtl8153b_down(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data |= PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
 	r8153b_u1u2en(tp, false);
 	r8153_u2p3en(tp, false);
@@ -6527,8 +6362,6 @@ static void rtl8153c_change_mtu(struct r8152 *tp)
 
 static void rtl8153c_up(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
@@ -6539,26 +6372,18 @@ static void rtl8153c_up(struct r8152 *tp)
 	rxdy_gated_en(tp, true);
 	r8153_teredo_off(tp);
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~RCR_ACPT_ALL;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
 
 	rtl8152_nic_reset(tp);
 	rtl_reset_bmu(tp);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data &= ~MCU_BORW_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	wait_oob_link_list_ready(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data |= RE_INIT_LL;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, RE_INIT_LL);
 
 	wait_oob_link_list_ready(tp);
 
@@ -6578,15 +6403,12 @@ static void rtl8153c_up(struct r8152 *tp)
 
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CONFIG34);
-	ocp_data |= BIT(8);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CONFIG34, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG34, BIT(8));
 
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
 	r8153_aldps_en(tp, true);
 	r8153b_u1u2en(tp, true);
@@ -6608,8 +6430,6 @@ static void rtl8156_change_mtu(struct r8152 *tp)
 
 static void rtl8156_up(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
@@ -6620,20 +6440,14 @@ static void rtl8156_up(struct r8152 *tp)
 	rxdy_gated_en(tp, true);
 	r8153_teredo_off(tp);
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~RCR_ACPT_ALL;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
 
 	rtl8152_nic_reset(tp);
 	rtl_reset_bmu(tp);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
-	ocp_data &= ~MCU_BORW_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
 
@@ -6643,27 +6457,21 @@ static void rtl8156_up(struct r8152 *tp)
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
 	}
 
 	/* share FIFO settings */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL);
-	ocp_data &= ~RXFIFO_FULL_MASK;
-	ocp_data |= 0x08;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, ocp_data);
+	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
+		      0x08);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION);
-	ocp_data &= ~(RG_PWRDN_EN | ALL_SPEED_OFF);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			  RG_PWRDN_EN | ALL_SPEED_OFF);
 
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
 
@@ -6681,25 +6489,20 @@ static void rtl8156_up(struct r8152 *tp)
 
 static void rtl8156_down(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data |= PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
 	r8153b_u1u2en(tp, false);
 	r8153_u2p3en(tp, false);
 	r8153b_power_cut_en(tp, false);
 	r8153_aldps_en(tp, false);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-	ocp_data &= ~NOW_IS_OOB;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
 	/* RX FIFO settings for OOB */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, 64 / 16);
@@ -6718,20 +6521,15 @@ static void rtl8156_down(struct r8152 *tp)
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
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data |= RCR_APM | RCR_AM | RCR_AB;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
+			   RCR_APM | RCR_AM | RCR_AB);
 
 	r8153_aldps_en(tp, true);
 }
@@ -7008,11 +6806,7 @@ static int rtl8152_close(struct net_device *netdev)
 
 static void rtl_tally_reset(struct r8152 *tp)
 {
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_RSTTALLY);
-	ocp_data |= TALLY_RESET;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RSTTALLY, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_RSTTALLY, TALLY_RESET);
 }
 
 static void r8152b_init(struct r8152 *tp)
@@ -7031,21 +6825,18 @@ static void r8152b_init(struct r8152 *tp)
 
 	r8152_aldps_en(tp, false);
 
-	if (tp->version == RTL_VER_01) {
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_LED_FEATURE);
-		ocp_data &= ~LED_MODE_MASK;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_LED_FEATURE, ocp_data);
-	}
+	if (tp->version == RTL_VER_01)
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_LED_FEATURE,
+				  LED_MODE_MASK);
 
 	r8152_power_cut_en(tp, false);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR);
-	ocp_data |= TX_10M_IDLE_EN | PFM_PWM_SWITCH;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL);
-	ocp_data &= ~MCU_CLK_RATIO_MASK;
-	ocp_data |= MCU_CLK_RATIO | D3_CLK_GATED_EN;
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR,
+			  TX_10M_IDLE_EN | PFM_PWM_SWITCH);
+
+	ocp_dword_w0w1(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL, MCU_CLK_RATIO_MASK,
+		       MCU_CLK_RATIO | D3_CLK_GATED_EN);
+
 	ocp_data = GPHY_STS_MSK | SPEED_DOWN_MSK |
 		   SPDWN_RXDV_MSK | SPDWN_LINKCHG_MSK;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_GPHY_INTR_IMR, ocp_data);
@@ -7053,14 +6844,12 @@ static void r8152b_init(struct r8152 *tp)
 	rtl_tally_reset(tp);
 
 	/* enable rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
 }
 
 static void r8153_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 	int i;
 
@@ -7096,67 +6885,55 @@ static void r8153_init(struct r8152 *tp)
 	r8153_u2p3en(tp, false);
 
 	if (tp->version == RTL_VER_04) {
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_SSPHYLINK2);
-		ocp_data &= ~pwd_dn_scale_mask;
-		ocp_data |= pwd_dn_scale(96);
-		ocp_write_word(tp, MCU_TYPE_USB, USB_SSPHYLINK2, ocp_data);
-
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_USB2PHY);
-		ocp_data |= USB2PHY_L1 | USB2PHY_SUSPEND;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_USB2PHY, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_SSPHYLINK2,
+			      pwd_dn_scale_mask, pwd_dn_scale(96));
+
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_USB2PHY,
+				  USB2PHY_L1 | USB2PHY_SUSPEND);
 	} else if (tp->version == RTL_VER_05) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_DMY_REG0);
-		ocp_data &= ~ECM_ALDPS;
-		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_DMY_REG0, ocp_data);
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_DMY_REG0, ECM_ALDPS);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_CSR_DUMMY1);
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_BURST_SIZE) == 0)
-			ocp_data &= ~DYNAMIC_BURST;
+			ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
+					  DYNAMIC_BURST);
 		else
-			ocp_data |= DYNAMIC_BURST;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_CSR_DUMMY1, ocp_data);
+			ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
+					  DYNAMIC_BURST);
 	} else if (tp->version == RTL_VER_06) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_CSR_DUMMY1);
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_BURST_SIZE) == 0)
-			ocp_data &= ~DYNAMIC_BURST;
+			ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
+					  DYNAMIC_BURST);
 		else
-			ocp_data |= DYNAMIC_BURST;
-		ocp_write_byte(tp, MCU_TYPE_USB, USB_CSR_DUMMY1, ocp_data);
+			ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
+					  DYNAMIC_BURST);
 
 		r8153_queue_wake(tp, false);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 		if (rtl8152_get_speed(tp) & LINK_STATUS)
-			ocp_data |= CUR_LINK_OK;
+			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+					  CUR_LINK_OK | POLL_LINK_CHG);
 		else
-			ocp_data &= ~CUR_LINK_OK;
-		ocp_data |= POLL_LINK_CHG;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+			ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				      CUR_LINK_OK, POLL_LINK_CHG);
 	}
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_CSR_DUMMY2);
-	ocp_data |= EP4_FULL_FC;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_CSR_DUMMY2, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY2, EP4_FULL_FC);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_WDT11_CTRL);
-	ocp_data &= ~TIMER11_EN;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_WDT11_CTRL, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_WDT11_CTRL, TIMER11_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_LED_FEATURE);
-	ocp_data &= ~LED_MODE_MASK;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_LED_FEATURE, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_LED_FEATURE, LED_MODE_MASK);
 
-	ocp_data = FIFO_EMPTY_1FB | ROK_EXIT_LPM;
 	if (tp->version == RTL_VER_04 && tp->udev->speed < USB_SPEED_SUPER)
-		ocp_data |= LPM_TIMER_500MS;
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_LPM_CTRL,
+				  FIFO_EMPTY_1FB | ROK_EXIT_LPM |
+				  LPM_TIMER_500MS);
 	else
-		ocp_data |= LPM_TIMER_500US;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_LPM_CTRL, ocp_data);
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_LPM_CTRL,
+				  FIFO_EMPTY_1FB | ROK_EXIT_LPM |
+				  LPM_TIMER_500US);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_AFE_CTRL2);
-	ocp_data &= ~SEN_VAL_MASK;
-	ocp_data |= SEN_VAL_NORMAL | SEL_RXIDLE;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_AFE_CTRL2, ocp_data);
+	ocp_word_w0w1(tp, MCU_TYPE_USB, USB_AFE_CTRL2, SEN_VAL_MASK,
+		      SEN_VAL_NORMAL | SEL_RXIDLE);
 
 	ocp_write_word(tp, MCU_TYPE_USB, USB_CONNECT_TIMER, 0x0001);
 
@@ -7166,21 +6943,17 @@ static void r8153_init(struct r8152 *tp)
 	r8153_u1u2en(tp, true);
 	usb_enable_lpm(tp->udev);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6);
-	ocp_data |= LANWAKE_CLR_EN;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG6, LANWAKE_CLR_EN);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG);
-	ocp_data &= ~LANWAKE_PIN;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, LANWAKE_PIN);
 
 	/* rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	if (tp->dell_tb_rx_agg_bug)
-		ocp_data |= RX_AGG_DISABLE;
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
 
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+	if (tp->dell_tb_rx_agg_bug)
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+				  RX_AGG_DISABLE);
 
 	rtl_tally_reset(tp);
 
@@ -7200,7 +6973,6 @@ static void r8153_init(struct r8152 *tp)
 
 static void r8153b_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 	int i;
 
@@ -7239,13 +7011,12 @@ static void r8153b_init(struct r8152 *tp)
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
-		ocp_data |= CUR_LINK_OK;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
 	else
-		ocp_data &= ~CUR_LINK_OK;
-	ocp_data |= POLL_LINK_CHG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, CUR_LINK_OK,
+			      POLL_LINK_CHG);
 
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
@@ -7255,25 +7026,20 @@ static void r8153b_init(struct r8152 *tp)
 	/* MAC clock speed down */
 	r8153_mac_clk_speed_down(tp, true);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
-	if (tp->version == RTL_VER_09) {
+	if (tp->version == RTL_VER_09)
 		/* Disable Test IO for 32QFN */
-		if (ocp_read_byte(tp, MCU_TYPE_PLA, 0xdc00) & BIT(5)) {
-			ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR);
-			ocp_data |= TEST_IO_OFF;
-			ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
-		}
-	}
+		if (ocp_read_byte(tp, MCU_TYPE_PLA, 0xdc00) & BIT(5))
+			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR,
+					  TEST_IO_OFF);
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
 	/* rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
 
 	rtl_tally_reset(tp);
 
@@ -7282,7 +7048,6 @@ static void r8153b_init(struct r8152 *tp)
 
 static void r8153c_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 	int i;
 
@@ -7293,12 +7058,10 @@ static void r8153c_init(struct r8152 *tp)
 
 	/* Disable spi_en */
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CONFIG5);
-	ocp_data &= ~BIT(3);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CONFIG5, ocp_data);
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, 0xcbf0);
-	ocp_data |= BIT(1);
-	ocp_write_word(tp, MCU_TYPE_USB, 0xcbf0, ocp_data);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_CONFIG5, BIT(3));
+
+	ocp_word_set_bits(tp, MCU_TYPE_USB, 0xcbf0, BIT(1));
 
 	for (i = 0; i < 500; i++) {
 		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
@@ -7330,14 +7093,12 @@ static void r8153c_init(struct r8152 *tp)
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
-		ocp_data |= CUR_LINK_OK;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
 	else
-		ocp_data &= ~CUR_LINK_OK;
-
-	ocp_data |= POLL_LINK_CHG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, CUR_LINK_OK,
+			      POLL_LINK_CHG);
 
 	r8153b_u1u2en(tp, true);
 
@@ -7346,16 +7107,13 @@ static void r8153c_init(struct r8152 *tp)
 	/* MAC clock speed down */
 	r8153_mac_clk_speed_down(tp, true);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
-	ocp_data &= ~BIT(7);
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(7));
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
 	/* rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
 
 	rtl_tally_reset(tp);
 
@@ -7364,14 +7122,9 @@ static void r8153c_init(struct r8152 *tp)
 
 static void r8156_hw_phy_cfg(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	if (ocp_data & PCUT_STATUS) {
-		ocp_data &= ~PCUT_STATUS;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
-	}
+	ocp_word_test_and_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
 
 	data = r8153_phy_status(tp, 0);
 	switch (data) {
@@ -7398,9 +7151,7 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR);
-	ocp_data |= PFM_PWM_SWITCH;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
 
 	switch (tp->version) {
 	case RTL_VER_10:
@@ -7561,9 +7312,8 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 		/* EEE parameter */
 		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS_2P5G, 0x0056);
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_USB_CFG);
-		ocp_data |= EN_XG_LIP | EN_G_LIP;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_USB_CFG, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_USB_CFG,
+				  EN_XG_LIP | EN_G_LIP);
 
 		sram_write(tp, 0x8257, 0x020f); /*  XG PLL */
 		sram_write(tp, 0x80ea, 0x7843); /* GIGA Master */
@@ -7572,9 +7322,8 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 			return;
 
 		/* Advance EEE */
-		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
-		ocp_data |= EEE_SPDWN_EN;
-		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  EEE_SPDWN_EN);
 
 		data = ocp_reg_read(tp, OCP_DOWN_SPEED);
 		data &= ~(EN_EEE_100 | EN_EEE_1000);
@@ -7714,7 +7463,6 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 
 static void r8156b_hw_phy_cfg(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 
 	switch (tp->version) {
@@ -7744,11 +7492,7 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		break;
 	}
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	if (ocp_data & PCUT_STATUS) {
-		ocp_data &= ~PCUT_STATUS;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
-	}
+	ocp_word_test_and_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
 
 	data = r8153_phy_status(tp, 0);
 	switch (data) {
@@ -7785,9 +7529,7 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR);
-	ocp_data |= PFM_PWM_SWITCH;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
 
 	switch (tp->version) {
 	case RTL_VER_12:
@@ -7874,9 +7616,9 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_write(tp, 0xb87c, 0x8fd8);
 		ocp_reg_write(tp, 0xb87e, 0xf600);
 
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_USB_CFG);
-		ocp_data |= EN_XG_LIP | EN_G_LIP;
-		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_USB_CFG, ocp_data);
+		ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_USB_CFG,
+				  EN_XG_LIP | EN_G_LIP);
+
 		ocp_reg_write(tp, 0xb87c, 0x813d);
 		ocp_reg_write(tp, 0xb87e, 0x390e);
 		ocp_reg_write(tp, 0xb87c, 0x814f);
@@ -8090,9 +7832,7 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 	if (rtl_phy_patch_request(tp, true, true))
 		return;
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
-	ocp_data |= EEE_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
 
 	data = ocp_reg_read(tp, OCP_DOWN_SPEED);
 	data &= ~(EN_EEE_100 | EN_EEE_1000);
@@ -8131,22 +7871,17 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 
 static void r8156_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
-	ocp_data &= ~EN_ALL_SPEED;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_ECM_OP, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
 
 	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_ECM_OPTION);
-	ocp_data |= BYPASS_MAC_RESET;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_ECM_OPTION, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
 
 	r8153b_u1u2en(tp, false);
 
@@ -8196,28 +7931,23 @@ static void r8156_init(struct r8152 *tp)
 
 	r8156_mac_clk_spd(tp, true);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
-		ocp_data |= CUR_LINK_OK;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
 	else
-		ocp_data &= ~CUR_LINK_OK;
-	ocp_data |= POLL_LINK_CHG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, CUR_LINK_OK,
+			      POLL_LINK_CHG);
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
 	/* rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_BMU_CONFIG);
-	ocp_data |= ACT_ODMA;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
 
 	r8156_mdio_force_mode(tp);
 	rtl_tally_reset(tp);
@@ -8227,26 +7957,19 @@ static void r8156_init(struct r8152 *tp)
 
 static void r8156b_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
-	ocp_data &= ~EN_ALL_SPEED;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_ECM_OP, ocp_data);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
 
 	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_ECM_OPTION);
-	ocp_data |= BYPASS_MAC_RESET;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_ECM_OPTION, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL);
-	ocp_data |= RX_DETECT8;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);
 
 	r8153b_u1u2en(tp, false);
 
@@ -8306,48 +8029,39 @@ static void r8156b_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~SLOT_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CPCR);
-	ocp_data |= FLOW_CTRL_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CPCR, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
 
 	/* enable fc timer and set timer to 600 ms. */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
 		       CTRL_TIMER_EN | (600 / 8));
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
 	if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & DACK_DET_EN))
-		ocp_data |= FLOW_CTRL_PATCH_2;
-	ocp_data &= ~AUTO_SPEEDUP;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
+				  FLOW_CTRL_PATCH_2);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
-	ocp_data |= FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 
 	r8156_mac_clk_spd(tp, true);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
-		ocp_data |= CUR_LINK_OK;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
 	else
-		ocp_data &= ~CUR_LINK_OK;
-	ocp_data |= POLL_LINK_CHG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, CUR_LINK_OK,
+			      POLL_LINK_CHG);
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
 	/* rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
 
 	r8156_mdio_force_mode(tp);
 	rtl_tally_reset(tp);
-- 
2.34.1


