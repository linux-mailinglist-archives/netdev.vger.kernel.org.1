Return-Path: <netdev+bounces-267697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBG2F1QttWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328928C6F1
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 020E83045231
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5287B34B426;
	Sat, 14 Mar 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fNK++MXc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="YKvmhYLy"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2C314D18;
	Sat, 14 Mar 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481268; cv=none; b=CCPW3LT9/qI/wwN3Wn17uojnTkAS0oqW30zp9KLIexiV58lvjtNZADHYkm2bASBPE+EsSr/64MDHD86ftEMYVRZgNenL11+Cym2OOn6b4kzzVwZXbWM+e7KKzOTE7EX0k2dmRCDgJYZYz1bENj/hTsWVk/Tyjd9v/HjyhKxE2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481268; c=relaxed/simple;
	bh=qZul5VwJ7fo3tUtCo7/cVtxNgXfnshbnUs49IGVBbe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljPW8ouXnTvxJbAsishSqzX+Ift/asHwAd6oMOgL+xpfIZuWESoF4AHl0kRfVPToKyqntWxRalg5q7P1VGqKKd/y+GS0ztW3SAaF/Mn4t9LdyphmclBxhxwX181N19P7oppjCOqQNFt6ynxvrFHPWAe2LMreGEKZdcOdPYh9jZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fNK++MXc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=YKvmhYLy; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480706;
	bh=qZul5VwJ7fo3tUtCo7/cVtxNgXfnshbnUs49IGVBbe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fNK++MXcSG6O0PDVVID/AxsUwvud+AUAEdNQiRh+vh/eN7aM0V86JwhYcpIjYtP5p
	 qiAWUkJz0no25Qtc1G1dqdu8LGRyuYt+xOC9y2jKT0XTTb2+SqfsQErErheiULqkSR
	 vom9bfHvmw0t42xp0Xmfu0gF4+o7NJL6hQeCLpQcBTqfe8eZUVAqsXN/8s5ohfNfcI
	 U3YOYYbmpYM3jBAlO/0YH1qpRFFbx9gBI87vIbBlDtL+GoDVkaNI4GYkYfZQzwL0Ox
	 OGTsY2WnGR3zwK0hpp8cVLwWBHwlXv2scvu055hf48sUs5mXqhDBplGkxPTULH1QB9
	 pHUscXiQhJvsg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1E6C23FCEE; Sat, 14 Mar 2026 09:31:46 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480703;
	bh=qZul5VwJ7fo3tUtCo7/cVtxNgXfnshbnUs49IGVBbe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YKvmhYLywUtSN7n3hcGlZCMdMqqdLtRNDhtVlJivLRLjVKd9v/hQHfDoI/Iyzd15s
	 We4lTFlj0clDMkIEdQZqKkwG1E8aamHVqWFFU9RAbnQWL+ZmDtWRyYTF+Hmp7cZ1ul
	 o/w9afeCDyNsccM0+OkNtouhFppsWTDYOkjoYJ30dXNYD4m35a7HpwnjEpbTCbaJ/Z
	 BVhTrqUgmHCsBOFy4Utq0wwUy9no2JFV1fE4s6tqAw/b8BsoEDjnP6P9D7X+vCxjsn
	 U/BW1SfpZsmmseku1C29efG76rguDNR+xq1327ATvJ7hdG6ohzx1EttJzvjbvV0ph2
	 tm8Yuaq2O/s5A==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DF45F3FCB1;
	Sat, 14 Mar 2026 09:31:42 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:39 +0100
Subject: [PATCH net-next 3/9] r8152: Add support for configuring the PHY of
 the RTL8157
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-3-9ba77b428afd@birger-koblitz.de>
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
	TAGGED_FROM(0.00)[bounces-267697-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 8328928C6F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add configuration support for the initial configuration of the
PHY of the RTL8157 at startup.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 249 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 45b79a0138f0440a8cb0b2124b2b71b85a319b6b..c7f6566e87cfab2efa7c580ed71f0d708b3cf85d 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1232,6 +1232,7 @@ enum rtl_version {
 	RTL_VER_13,
 	RTL_VER_14,
 	RTL_VER_15,
+	RTL_VER_16,
 
 	RTL_VER_MAX
 };
@@ -1591,6 +1592,22 @@ static void ocp_write_word(struct r8152 *tp, u16 type, u16 index, u32 data)
 	generic_ocp_write(tp, index, byen, sizeof(tmp), &tmp, type);
 }
 
+static void ocp_word_set_bits(struct r8152 *tp, u16 type, u16 index, u32 bits)
+{
+	u32 ocp_data = ocp_read_word(tp, type, index);
+
+	ocp_data |= bits;
+	ocp_write_word(tp, type, index, ocp_data);
+}
+
+static void ocp_word_clr_bits(struct r8152 *tp, u16 type, u16 index, u32 bits)
+{
+	u32 ocp_data = ocp_read_word(tp, type, index);
+
+	ocp_data &= ~bits;
+	ocp_write_word(tp, type, index, ocp_data);
+}
+
 static u8 ocp_read_byte(struct r8152 *tp, u16 type, u16 index)
 {
 	u32 data;
@@ -1657,6 +1674,30 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
 	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
 }
 
+static void ocp_reg_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data = ocp_reg_read(tp, addr);
+
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, addr, data);
+}
+
+static void ocp_reg_clr_bits(struct r8152 *tp, u16 addr, u16 bits)
+{
+	u16 data = ocp_reg_read(tp, addr);
+
+	data &= ~bits;
+	ocp_reg_write(tp, addr, data);
+}
+
+static void ocp_reg_set_bits(struct r8152 *tp, u16 addr, u16 bits)
+{
+	u16 data = ocp_reg_read(tp, addr);
+
+	data |= bits;
+	ocp_reg_write(tp, addr, data);
+}
+
 static inline void r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
 {
 	ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
@@ -8444,6 +8485,214 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 	set_bit(PHY_RESET, &tp->flags);
 }
 
+static void r8157_hw_phy_cfg(struct r8152 *tp)
+{
+	u32 ocp_data;
+	u16 data;
+	int ret;
+
+	r8156b_wait_loading_flash(tp);
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
+	if (ocp_data & PCUT_STATUS) {
+		ocp_data &= ~PCUT_STATUS;
+		ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
+	}
+
+	ret = r8153_phy_status(tp, 0);
+	if (ret < 0)
+		return;
+
+	switch (ret) {
+	case PHY_STAT_EXT_INIT:
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		break;
+	case PHY_STAT_LAN_ON:
+	case PHY_STAT_PWRDN:
+	default:
+		break;
+	}
+
+	data = r8152_mdio_read(tp, MII_BMCR);
+	if (data & BMCR_PDOWN) {
+		data &= ~BMCR_PDOWN;
+		r8152_mdio_write(tp, MII_BMCR, data);
+	}
+
+	r8153_aldps_en(tp, false);
+	rtl_eee_enable(tp, false);
+
+	ret = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+	if (ret < 0)
+		return;
+	WARN_ON_ONCE(ret != PHY_STAT_LAN_ON);
+
+	/* PFM mode */
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
+
+	/* Advanced Power Saving parameter */
+	ocp_reg_set_bits(tp, 0xa430, BIT(0) | BIT(1));
+
+	/* aldpsce force mode */
+	ocp_reg_clr_bits(tp, 0xa44a, BIT(2));
+
+	switch (tp->version) {
+	case RTL_VER_16:
+		/* XG_INRX parameter */
+		sram_write_w0w1(tp, 0x8183, 0xff00, 0x5900);
+		ocp_reg_set_bits(tp, 0xa654, BIT(11));
+		ocp_reg_set_bits(tp, 0xb648, BIT(14));
+		ocp_reg_clr_bits(tp, 0xad2c, BIT(15));
+		ocp_reg_set_bits(tp, 0xad94, BIT(5));
+		ocp_reg_set_bits(tp, 0xada0, BIT(1));
+		ocp_reg_w0w1(tp, 0xae06, 0xfc00, 0x7c00);
+		sram2_write_w0w1(tp, 0x8647, 0xff00, 0xe600);
+		sram2_write_w0w1(tp, 0x8036, 0xff00, 0x3000);
+		sram2_write_w0w1(tp, 0x8078, 0xff00, 0x3000);
+
+		/* green mode */
+		sram2_write_w0w1(tp, 0x89e9, 0xff00, 0);
+		sram2_write_w0w1(tp, 0x8ffd, 0xff00, 0x0100);
+		sram2_write_w0w1(tp, 0x8ffe, 0xff00, 0x0200);
+		sram2_write_w0w1(tp, 0x8fff, 0xff00, 0x0400);
+
+		/* recognize AQC/Bcom function */
+		sram_write_w0w1(tp, 0x8018, 0xff00, 0x7700);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0x8f9c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0005);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00ed);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd401);
+		sram_write_w0w1(tp, 0x8fa8, 0xff00, 0x2900);
+
+		/* RFI_corr_thd 5g */
+		sram2_write_w0w1(tp, 0x814b, 0xff00, 0x1100);
+		sram2_write_w0w1(tp, 0x814d, 0xff00, 0x1100);
+		sram2_write_w0w1(tp, 0x814f, 0xff00, 0x0b00);
+		sram2_write_w0w1(tp, 0x8142, 0xff00, 0x0100);
+		sram2_write_w0w1(tp, 0x8144, 0xff00, 0x0100);
+		sram2_write_w0w1(tp, 0x8150, 0xff00, 0x0100);
+
+		/* RFI_corr_thd 2p5g */
+		sram2_write_w0w1(tp, 0x8118, 0xff00, 0x0700);
+		sram2_write_w0w1(tp, 0x811a, 0xff00, 0x0700);
+		sram2_write_w0w1(tp, 0x811c, 0xff00, 0x0500);
+		sram2_write_w0w1(tp, 0x810f, 0xff00, 0x0100);
+		sram2_write_w0w1(tp, 0x8111, 0xff00, 0x0100);
+		sram2_write_w0w1(tp, 0x811d, 0xff00, 0x0100);
+
+		/* RFI parameter */
+		ocp_reg_clr_bits(tp, 0xad1c, BIT(8));
+		ocp_reg_w0w1(tp, 0xade8, 0xffc0, 0x1400);
+		sram2_write_w0w1(tp, 0x864b, 0xff00, 0x9d00);
+		sram2_write_w0w1(tp, 0x862c, 0xff00, 0x1200);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0x8566);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x003f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3f02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x023c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3b0a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1c00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+
+		/* RFI-color noise gen parameter 5g */
+		ocp_reg_set_bits(tp, 0xad9c, BIT(5));
+		sram2_write_w0w1(tp, 0x8122, 0xff00, 0x0c00);
+		ocp_reg_write(tp, OCP_SRAM2_ADDR, 0x82c8);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03ed);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03ff);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0009);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03fe);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x000b);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0021);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03f7);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03b8);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03e0);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0049);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0049);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03e0);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03b8);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03f7);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0021);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x000b);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03fe);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0009);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03ff);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03ed);
+
+		/* RFI-color noise gen parameter 2p5g */
+		sram2_write_w0w1(tp, 0x80ef, 0xff00, 0x0c00);
+		ocp_reg_write(tp, OCP_SRAM2_ADDR, 0x82a0);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x000e);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03fe);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03ed);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0006);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x001a);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03f1);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03d8);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0023);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0054);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0322);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x00dd);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03ab);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03dc);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0027);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x000e);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03e5);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03f9);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0012);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x0001);
+		ocp_reg_write(tp, OCP_SRAM2_DATA, 0x03f1);
+
+		/* modify thermal speed down threshold */
+		ocp_reg_w0w1(tp, 0xb54c, 0xffc0, 0x3700);
+
+		/* XG compatibility modification */
+		ocp_reg_set_bits(tp, 0xb648, BIT(6));
+		sram2_write_w0w1(tp, 0x8082, 0xff00, 0x5d00);
+		sram2_write_w0w1(tp, 0x807c, 0xff00, 0x5000);
+		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
+		break;
+	default:
+		break;
+	}
+
+	if (rtl_phy_patch_request(tp, true, true))
+		return;
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
+
+	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000, EN_10M_CLKDIV);
+
+	tp->ups_info._10m_ckdiv = true;
+	tp->ups_info.eee_plloff_100 = false;
+	tp->ups_info.eee_plloff_giga = false;
+
+	ocp_reg_set_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
+	tp->ups_info.eee_ckdiv = true;
+
+	rtl_phy_patch_request(tp, false, true);
+
+	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
+
+	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1));
+	tp->ups_info.lite_mode = 0;
+
+	if (tp->eee_en)
+		rtl_eee_enable(tp, true);
+
+	r8153_aldps_en(tp, true);
+	r8152b_enable_fc(tp);
+
+	set_bit(PHY_RESET, &tp->flags);
+}
+
 static void r8156_init(struct r8152 *tp)
 {
 	u32 ocp_data;

-- 
2.47.3


