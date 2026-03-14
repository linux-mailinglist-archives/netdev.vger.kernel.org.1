Return-Path: <netdev+bounces-267698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNk1M28ttWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:42:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A528C716
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DC72305375B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700E34EEF0;
	Sat, 14 Mar 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VfBKjdZ5";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="SDMJRamD"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FDA314D35;
	Sat, 14 Mar 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481268; cv=none; b=B/vc13AwjM243Br1WRkWuTgOcixrm/yRa3uoWdBErVqBudISJ9uSNo+sPCviJfiHYn0jIaWqA+dHPEEMdTJI+l+unnEI45tK8eLMROUASaY8vwh2SvyIoMeq+Sf5sjIX1j+CXJJ2wKpD7ax/TBUS4CBedaGKgG4tcn2AuLIUHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481268; c=relaxed/simple;
	bh=pbmbMBdfn5il7owA5VpO2JviffRpIlTN5GCsZTn69mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lzxpc6Tfx5czbY5UVSPqziR2mLTAiHIebmhl7HFVUCtkiAY8YupK24H/HFt2VzJ9Yh57D7ZEWLZdjPKEh/UkGTg3cXkrjnH3NZyKXgSnLcy4nEL3yYfm/3JjeRrhPBguyRXuo5CZu2385PQA+6p2O7HX8/d2iJPI5+6TARqXQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VfBKjdZ5; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=SDMJRamD; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480707;
	bh=pbmbMBdfn5il7owA5VpO2JviffRpIlTN5GCsZTn69mQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VfBKjdZ5BEXcZ1V3ZTASgDlvJwef0fj11uI/o04vz+ID736jeNb1Ur1Fd4RTY+J4E
	 BYfUB1L0im53HcVDBFZ9KIPzfqNTcoKi8oG7JYkYXgF3CXQSSauH79OrZG1wlJg0kt
	 K6ujUlgDFniFyOfvb2vr81fwJcgPgkNtUdjfS2+o20Uv9cjwJFQ1dsKX5UXmv5W9zn
	 /7Oqn//CVZg/QS59CfHE9F0BQHaFNl0LNT9jxtM/umtyA1hHCSB/e6fETny6jqdyeM
	 8AaLM1C6y/32GEdKKiFHuQecXetDtWwCWxyjH+QDD1Sxi+j38GDea+6VISSE2zChWG
	 7+Qevdk1Khnbg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 440B93FCD6; Sat, 14 Mar 2026 09:31:47 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480703;
	bh=pbmbMBdfn5il7owA5VpO2JviffRpIlTN5GCsZTn69mQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SDMJRamDADt95yzZGXitsaPFYNZ+HnVRENLj6nyI0L0xHR5ewISDvmhitNFfKrQS5
	 3bVR20+Xzg6GZom5+zDEvxLnpkFrfu330/xsZIzxVEl22ZzGNJTrPuo9RynJ5Gl2De
	 jOjfbSdgMiLgya2CxZrLgd7xP8B7YUj9dNUWQTsrYUD5q9/Pe807vUGuRUtbBme4af
	 tjTFcIgRGi2jqBuia4LEBm3oHFQVNV2MncPQxb/oGyrPIzQZRmSmczNMTUg9HeGUm1
	 h40ZA4aw13zDOAF/iD6YrIQ4AYCQDJjhl85VrDHZkIwywvqxI9hTEOeNB3JJmyINqS
	 rN6NWVSX8seZg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 291183FCBF;
	Sat, 14 Mar 2026 09:31:43 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:40 +0100
Subject: [PATCH net-next 4/9] r8152: Add RTL8157 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-4-9ba77b428afd@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-267698-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 6A7A528C716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add RTL8157 by combining the existing RTL8156B and RTL8156 init functions
and add RTL8157-specific functinality in order to improve code readability
and maintainability.
r8156_init() is now called with RTL_VER_10 and RTL_VER_11 for the RTL8156,
with RTL_VER_12, RTL_VER_13 and RTL_VER_15 for the RTL8156B and with
RTL_VER_16 for the RTL8157 and checks the version for chip-specific code.
Also add USB power control functions for the RTL8157.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 239 +++++++++++++++++++-----------------------------
 1 file changed, 95 insertions(+), 144 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index c7f6566e87cfab2efa7c580ed71f0d708b3cf85d..d3943cde53d309adec1a4a3c1cb4a2cf63617eea 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -123,6 +123,7 @@
 #define USB_CSR_DUMMY1		0xb464
 #define USB_CSR_DUMMY2		0xb466
 #define USB_DEV_STAT		0xb808
+#define USB_U2P3_V2_CTRL	0xc2c0
 #define USB_CONNECT_TIMER	0xcbf8
 #define USB_MSC_TIMER		0xcbfc
 #define USB_BURST_SIZE		0xcfc0
@@ -540,11 +541,15 @@
 #define CDC_ECM_EN		BIT(3)
 #define RX_AGG_DISABLE		0x0010
 #define RX_ZERO_EN		0x0080
+#define RX_DESC_16B		0x0400
 
 /* USB_U2P3_CTRL */
 #define U2P3_ENABLE		0x0001
 #define RX_DETECT8		BIT(3)
 
+/* USB_U2P3_V2_CTRL */
+#define U2P3_V2_ENABLE		BIT(29)
+
 /* USB_POWER_CUT */
 #define PWR_EN			0x0001
 #define PHASE2_EN		0x0008
@@ -1646,6 +1651,22 @@ static void ocp_write_byte(struct r8152 *tp, u16 type, u16 index, u32 data)
 	generic_ocp_write(tp, index, byen, sizeof(tmp), &tmp, type);
 }
 
+static void ocp_byte_clr_bits(struct r8152 *tp, u16 type, u16 index, u32 bits)
+{
+	u8 ocp_data = ocp_read_byte(tp, type, index);
+
+	ocp_data &= ~bits;
+	ocp_write_byte(tp, type, index, ocp_data);
+}
+
+static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 bits)
+{
+	u8 ocp_data = ocp_read_byte(tp, type, index);
+
+	ocp_data |= bits;
+	ocp_write_byte(tp, type, index, ocp_data);
+}
+
 static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
 {
 	u16 ocp_base, ocp_index;
@@ -3928,6 +3949,14 @@ static void r8153_u2p3en(struct r8152 *tp, bool enable)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL, ocp_data);
 }
 
+static int r8157_u2p3en(struct r8152 *tp, bool enable)
+{
+	if (enable)
+		return rtl_ip_set_bits(tp, USB_U2P3_V2_CTRL, U2P3_V2_ENABLE);
+	else
+		return rtl_ip_clr_bits(tp, USB_U2P3_V2_CTRL, U2P3_V2_ENABLE);
+}
+
 static void r8153b_ups_flags(struct r8152 *tp)
 {
 	u32 ups_flags = 0;
@@ -4281,9 +4310,7 @@ static void r8153_power_cut_en(struct r8152 *tp, bool enable)
 		ocp_data &= ~(PWR_EN | PHASE2_EN);
 	ocp_write_word(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	ocp_data &= ~PCUT_STATUS;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
 }
 
 static void r8153b_power_cut_en(struct r8152 *tp, bool enable)
@@ -4297,9 +4324,19 @@ static void r8153b_power_cut_en(struct r8152 *tp, bool enable)
 		ocp_data &= ~PWR_EN;
 	ocp_write_word(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	ocp_data &= ~PCUT_STATUS;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
+}
+
+static void r8157_power_cut_en(struct r8152 *tp, bool enable)
+{
+	if (enable) {
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN | PHASE2_EN);
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(1));
+	} else {
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(1));
+	}
 }
 
 static void r8153_queue_wake(struct r8152 *tp, bool enable)
@@ -8702,121 +8739,27 @@ static void r8156_init(struct r8152 *tp)
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
-	ocp_data &= ~EN_ALL_SPEED;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_ECM_OP, ocp_data);
-
-	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_ECM_OPTION);
-	ocp_data |= BYPASS_MAC_RESET;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_ECM_OPTION, ocp_data);
-
-	r8153b_u1u2en(tp, false);
-
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			return;
-	}
-
-	data = r8153_phy_status(tp, 0);
-	if (data == PHY_STAT_EXT_INIT) {
-		data = ocp_reg_read(tp, 0xa468);
-		data &= ~(BIT(3) | BIT(1));
-		ocp_reg_write(tp, 0xa468, data);
-	}
-
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
+	if (tp->version == RTL_VER_16) {
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
 	}
 
-	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
-	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
-
-	r8153_u2p3en(tp, false);
-
-	/* MSC timer = 0xfff * 8ms = 32760 ms */
-	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
-
-	/* U1/U2/L1 idle timer. 500 us */
-	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
-
-	r8153b_power_cut_en(tp, false);
-	r8156_ups_en(tp, false);
-	r8153_queue_wake(tp, false);
-	rtl_runtime_suspend_enable(tp, false);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
 
-	if (tp->udev->speed >= USB_SPEED_SUPER)
-		r8153b_u1u2en(tp, true);
+	if (tp->version != RTL_VER_16)
+		ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
 
-	usb_enable_lpm(tp->udev);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
 
-	r8156_mac_clk_spd(tp, true);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
-	if (rtl8152_get_speed(tp) & LINK_STATUS)
-		ocp_data |= CUR_LINK_OK;
-	else
-		ocp_data &= ~CUR_LINK_OK;
-	ocp_data |= POLL_LINK_CHG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
-
-	set_bit(GREEN_ETHERNET, &tp->flags);
-
-	/* rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
-
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_BMU_CONFIG);
-	ocp_data |= ACT_ODMA;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ocp_data);
-
-	r8156_mdio_force_mode(tp);
-	rtl_tally_reset(tp);
-
-	tp->coalesce = 15000;	/* 15 us */
-}
-
-static void r8156b_init(struct r8152 *tp)
-{
-	u32 ocp_data;
-	u16 data;
-	int i;
-
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		return;
-
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
-	ocp_data &= ~EN_ALL_SPEED;
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_ECM_OP, ocp_data);
-
-	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_ECM_OPTION);
-	ocp_data |= BYPASS_MAC_RESET;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_ECM_OPTION, ocp_data);
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL);
-	ocp_data |= RX_DETECT8;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL, ocp_data);
+	if (tp->version >= RTL_VER_13 && tp->version <= RTL_VER_15)
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);
 
 	r8153b_u1u2en(tp, false);
 
 	switch (tp->version) {
 	case RTL_VER_13:
 	case RTL_VER_15:
+	case RTL_VER_16:
 		r8156b_wait_loading_flash(tp);
 		break;
 	default:
@@ -8835,13 +8778,9 @@ static void r8156b_init(struct r8152 *tp)
 
 	data = r8153_phy_status(tp, 0);
 	if (data == PHY_STAT_EXT_INIT) {
-		data = ocp_reg_read(tp, 0xa468);
-		data &= ~(BIT(3) | BIT(1));
-		ocp_reg_write(tp, 0xa468, data);
-
-		data = ocp_reg_read(tp, 0xa466);
-		data &= ~BIT(0);
-		ocp_reg_write(tp, 0xa466, data);
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		if (tp->version >= RTL_VER_13)
+			ocp_reg_clr_bits(tp, 0xa466, BIT(0));
 	}
 
 	data = r8152_mdio_read(tp, MII_BMCR);
@@ -8852,7 +8791,10 @@ static void r8156b_init(struct r8152 *tp)
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
-	r8153_u2p3en(tp, false);
+	if (tp->version == RTL_VER_16)
+		r8157_u2p3en(tp, false);
+	else
+		r8153_u2p3en(tp, false);
 
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
@@ -8860,7 +8802,11 @@ static void r8156b_init(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
-	r8153b_power_cut_en(tp, false);
+	if (tp->version == RTL_VER_16)
+		r8157_power_cut_en(tp, false);
+	else
+		r8153b_power_cut_en(tp, false);
+
 	r8156_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
@@ -8870,33 +8816,27 @@ static void r8156b_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_RCR);
-	ocp_data &= ~SLOT_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
+	if (tp->version >= RTL_VER_13 && tp->version <= RTL_VER_15) {
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CPCR);
-	ocp_data |= FLOW_CTRL_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CPCR, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
 
-	/* enable fc timer and set timer to 600 ms. */
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
-		       CTRL_TIMER_EN | (600 / 8));
+		/* enable fc timer and set timer to 600 ms. */
+		ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER, CTRL_TIMER_EN | (600 / 8));
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
-	if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & DACK_DET_EN))
-		ocp_data |= FLOW_CTRL_PATCH_2;
-	ocp_data &= ~AUTO_SPEEDUP;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
+		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
+		if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & DACK_DET_EN))
+			ocp_data |= FLOW_CTRL_PATCH_2;
+		ocp_data &= ~AUTO_SPEEDUP;
+		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
-	ocp_data |= FC_PATCH_TASK;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+	}
 
 	r8156_mac_clk_spd(tp, true);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	if (tp->version != RTL_VER_16)
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
 
 	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
@@ -8908,10 +8848,21 @@ static void r8156b_init(struct r8152 *tp)
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
-	/* rx aggregation */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
-	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
-	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
+	/* rx aggregation / 16 bytes Rx descriptor */
+	if (tp->version == RTL_VER_16)
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
+	else
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_ZERO_EN);
+
+	if (tp->version < RTL_VER_13)
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
+
+	if (tp->version == RTL_VER_16) {
+		/* Disable Rx Zero Len */
+		rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
+		/* TX descriptor Signature */
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
+	}
 
 	r8156_mdio_force_mode(tp);
 	rtl_tally_reset(tp);
@@ -10171,7 +10122,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT;
-		ops->init		= r8156b_init;
+		ops->init		= r8156_init;
 		ops->enable		= rtl8156b_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;

-- 
2.47.3


