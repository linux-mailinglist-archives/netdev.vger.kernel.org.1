Return-Path: <netdev+bounces-270428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KZHJov8wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:40:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8222EE5FD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89F273005AA6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4294371880;
	Mon, 23 Mar 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UwmE5f5w"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E83803C8;
	Mon, 23 Mar 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255238; cv=none; b=KO6SI0M9NbcTn73P4o5+7NyaypANSEbdGSJhE6o2Y7BRJjqDlV3uEYy3f5D7RL1Sgf5KmdfyF4hFSGQ9pPEQvbdygPo0u8lB50NF1rb7DH0Zo0jZpfKxJmcJ/2Wc9wY7Vt8AOyQG37mVR+RjL8qmiWgibuRLdFmAX4yWbLAF+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255238; c=relaxed/simple;
	bh=85Vin4DQCr/ySsnd8XMOvwVHwtB+7i8oAobg12pFtQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jdcc7koSz+2ADda1+1rBrYGj56Z1wo5aBlz+sBTQ4gZyi4ad8a3MdIJ6TLlzuu1PF9VN2TrtUYyxbvBBrBebtraMJ2YhDrG5EBeT3vKpKNjmPktoDSYOz2ZQlANMEPoPv9bqyxlSE7FTSss1rBlqNAmjOFk/3hgfPUad17TbjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UwmE5f5w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N8e5pQ52802685, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774255205; bh=yDTLBgUBfkEr3EoqLIV89ZrV5ojF5Fl3vMnsqarfAR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UwmE5f5wMW3+OMg3n15nLFWgOmvZMB6GMEHpiVyTJPbJ4c5GFEes0IMZgJSWaGTqC
	 3zV1NgCUqRSLi0J9HPxMEPsnX+gLanlDPLfcvjyMR8e5mRXUUBsuToDp4t338ia8Zb
	 LrDKYbzMiSZDAzZjS8bh50bYNzRpjREk9Hv5kDdFUtYQ65L40oUAPLxCQAe+frNL9J
	 6IpYXCIYe4WL1iXhS+3iL1sXXDHft/cnzUWJiQuUtOSfTV0mcu8T9CSLQshgsM+VEv
	 WY0xeF+iJQ/wp3k+oIflmSbrFdcRifQGTLteyuKlctyXxvcdi+fqKNOlSSdVTgdUUv
	 WywzfkUNRqSGA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N8e5pQ52802685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 16:40:05 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 16:23:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 16:23:37 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Mon, 23 Mar 2026 16:23:37 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Chih Kai Hsu
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next v3 2/2] r8152: add helper functions for PHY OCP registers
Date: Mon, 23 Mar 2026 16:22:26 +0800
Message-ID: <20260323082226.2601-452-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323082226.2601-450-nic_swsd@realtek.com>
References: <20260323082226.2601-450-nic_swsd@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270428-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A8222EE5FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the following bitwise operation functions for PHY OCP registers to
simplify the code.

- ocp_reg_w0w1()
- ocp_reg_clr_bits()
- ocp_reg_set_bits()
- sram_write_w0w1()
- sram clr_bits()
- sram_set_bits()
- r8152_mdio_clr_bit()
- r8152_mdio_set_bit()
- r8152_mdio_test_and_clr_bit()

In addition, remove variable set but not used from r8153_init(),
r8153b_init() and r8153c_init().

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 697 +++++++++++++---------------------------
 1 file changed, 226 insertions(+), 471 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index ba6dc4dbfd80..caeed74c497e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1726,6 +1726,71 @@ static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)
 	ocp_byte_w0w1(tp, type, index, 0, set);
 }
 
+static void ocp_reg_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data;
+
+	data = ocp_reg_read(tp, addr);
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, addr, data);
+}
+
+static void ocp_reg_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+{
+	ocp_reg_w0w1(tp, addr, clear, 0);
+}
+
+static void ocp_reg_set_bits(struct r8152 *tp, u16 addr, u16 set)
+{
+	ocp_reg_w0w1(tp, addr, 0, set);
+}
+
+static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data;
+
+	data = sram_read(tp, addr);
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, OCP_SRAM_DATA, data);
+}
+
+static void sram_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+{
+	sram_write_w0w1(tp, addr, clear, 0);
+}
+
+static void sram_set_bits(struct r8152 *tp, u16 addr, u16 set)
+{
+	sram_write_w0w1(tp, addr, 0, set);
+}
+
+static void r8152_mdio_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
+{
+	int data;
+
+	data = r8152_mdio_read(tp, addr);
+	r8152_mdio_write(tp, addr, data & ~clear);
+}
+
+static void r8152_mdio_set_bit(struct r8152 *tp, u16 addr, u16 set)
+{
+	int data;
+
+	data = r8152_mdio_read(tp, addr);
+	r8152_mdio_write(tp, addr, data | set);
+}
+
+static int r8152_mdio_test_and_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
+{
+	int data;
+
+	data = r8152_mdio_read(tp, addr);
+	if (data & clear)
+		r8152_mdio_write(tp, addr, data & ~clear);
+
+	return data & clear;
+}
+
 static int
 r8152_submit_rx(struct r8152 *tp, struct rx_agg *agg, gfp_t mem_flags);
 
@@ -3740,14 +3805,10 @@ static void r8156_ups_flags(struct r8152 *tp)
 
 static void rtl_green_en(struct r8152 *tp, bool enable)
 {
-	u16 data;
-
-	data = sram_read(tp, SRAM_GREEN_CFG);
 	if (enable)
-		data |= GREEN_ETH_EN;
+		sram_set_bits(tp, SRAM_GREEN_CFG, GREEN_ETH_EN);
 	else
-		data &= ~GREEN_ETH_EN;
-	sram_write(tp, SRAM_GREEN_CFG, data);
+		sram_clr_bits(tp, SRAM_GREEN_CFG, GREEN_ETH_EN);
 
 	tp->ups_info.green = enable;
 }
@@ -4143,18 +4204,16 @@ static inline void rtl_reset_ocp_base(struct r8152 *tp)
 
 static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 {
-	u16 data, check;
+	u16 check;
 	int i;
 
-	data = ocp_reg_read(tp, OCP_PHY_PATCH_CMD);
 	if (request) {
-		data |= PATCH_REQUEST;
+		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
 		check = 0;
 	} else {
-		data &= ~PATCH_REQUEST;
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
 		check = PATCH_READY;
 	}
-	ocp_reg_write(tp, OCP_PHY_PATCH_CMD, data);
 
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
@@ -4184,14 +4243,8 @@ static void rtl_patch_key_set(struct r8152 *tp, u16 key_addr, u16 patch_key)
 		sram_write(tp, key_addr, patch_key);
 		sram_write(tp, SRAM_PHY_LOCK, PHY_PATCH_LOCK);
 	} else if (key_addr) {
-		u16 data;
-
 		sram_write(tp, 0x0000, 0x0000);
-
-		data = ocp_reg_read(tp, OCP_PHY_LOCK);
-		data &= ~PATCH_LOCK;
-		ocp_reg_write(tp, OCP_PHY_LOCK, data);
-
+		ocp_reg_clr_bits(tp, OCP_PHY_LOCK, PATCH_LOCK);
 		sram_write(tp, key_addr, 0x0000);
 	} else {
 		WARN_ON_ONCE(1);
@@ -5299,69 +5352,58 @@ static void r8152_mmd_write(struct r8152 *tp, u16 dev, u16 reg, u16 data)
 
 static void r8152_eee_en(struct r8152 *tp, bool enable)
 {
-	u16 config1, config2, config3;
-
-	config1 = ocp_reg_read(tp, OCP_EEE_CONFIG1) & ~sd_rise_time_mask;
-	config2 = ocp_reg_read(tp, OCP_EEE_CONFIG2);
-	config3 = ocp_reg_read(tp, OCP_EEE_CONFIG3) & ~fast_snr_mask;
-
 	if (enable) {
 		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
 				  EEE_RX_EN | EEE_TX_EN);
-		config1 |= EEE_10_CAP | EEE_NWAY_EN | TX_QUIET_EN | RX_QUIET_EN;
-		config1 |= sd_rise_time(1);
-		config2 |= RG_DACQUIET_EN | RG_LDVQUIET_EN;
-		config3 |= fast_snr(42);
+
+		ocp_reg_w0w1(tp, OCP_EEE_CONFIG1, sd_rise_time_mask,
+			     EEE_10_CAP | EEE_NWAY_EN | TX_QUIET_EN |
+			     RX_QUIET_EN | sd_rise_time(1));
+
+		ocp_reg_set_bits(tp, OCP_EEE_CONFIG2,
+				 RG_DACQUIET_EN | RG_LDVQUIET_EN);
+
+		ocp_reg_w0w1(tp, OCP_EEE_CONFIG3, fast_snr_mask, fast_snr(42));
 	} else {
 		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
 				  EEE_RX_EN | EEE_TX_EN);
-		config1 &= ~(EEE_10_CAP | EEE_NWAY_EN | TX_QUIET_EN |
-			     RX_QUIET_EN);
-		config1 |= sd_rise_time(7);
-		config2 &= ~(RG_DACQUIET_EN | RG_LDVQUIET_EN);
-		config3 |= fast_snr(511);
-	}
 
-	ocp_reg_write(tp, OCP_EEE_CONFIG1, config1);
-	ocp_reg_write(tp, OCP_EEE_CONFIG2, config2);
-	ocp_reg_write(tp, OCP_EEE_CONFIG3, config3);
+		ocp_reg_w0w1(tp, OCP_EEE_CONFIG1, sd_rise_time_mask |
+			     EEE_10_CAP | EEE_NWAY_EN | TX_QUIET_EN |
+			     RX_QUIET_EN, sd_rise_time(7));
+
+		ocp_reg_clr_bits(tp, OCP_EEE_CONFIG2,
+				 RG_DACQUIET_EN | RG_LDVQUIET_EN);
+
+		ocp_reg_w0w1(tp, OCP_EEE_CONFIG3, fast_snr_mask, fast_snr(511));
+	}
 }
 
 static void r8153_eee_en(struct r8152 *tp, bool enable)
 {
-	u16 config;
-
-	config = ocp_reg_read(tp, OCP_EEE_CFG);
-
 	if (enable) {
 		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
 				  EEE_RX_EN | EEE_TX_EN);
-		config |= EEE10_EN;
+
+		ocp_reg_set_bits(tp, OCP_EEE_CFG, EEE10_EN);
 	} else {
 		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_EEE_CR,
 				  EEE_RX_EN | EEE_TX_EN);
-		config &= ~EEE10_EN;
-	}
 
-	ocp_reg_write(tp, OCP_EEE_CFG, config);
+		ocp_reg_clr_bits(tp, OCP_EEE_CFG, EEE10_EN);
+	}
 
 	tp->ups_info.eee = enable;
 }
 
 static void r8156_eee_en(struct r8152 *tp, bool enable)
 {
-	u16 config;
-
 	r8153_eee_en(tp, enable);
 
-	config = ocp_reg_read(tp, OCP_EEE_ADV2);
-
 	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
-		config |= MDIO_EEE_2_5GT;
+		ocp_reg_set_bits(tp, OCP_EEE_ADV2, MDIO_EEE_2_5GT);
 	else
-		config &= ~MDIO_EEE_2_5GT;
-
-	ocp_reg_write(tp, OCP_EEE_ADV2, config);
+		ocp_reg_clr_bits(tp, OCP_EEE_ADV2, MDIO_EEE_2_5GT);
 }
 
 static void rtl_eee_enable(struct r8152 *tp, bool enable)
@@ -5414,11 +5456,8 @@ static void rtl_eee_enable(struct r8152 *tp, bool enable)
 
 static void r8152b_enable_fc(struct r8152 *tp)
 {
-	u16 anar;
-
-	anar = r8152_mdio_read(tp, MII_ADVERTISE);
-	anar |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
-	r8152_mdio_write(tp, MII_ADVERTISE, anar);
+	r8152_mdio_set_bit(tp, MII_ADVERTISE,
+			   ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM);
 
 	tp->ups_info.flow_control = true;
 }
@@ -5674,17 +5713,12 @@ static int r8156a_post_firmware_1(struct r8152 *tp)
 
 static void r8153_aldps_en(struct r8152 *tp, bool enable)
 {
-	u16 data;
-
-	data = ocp_reg_read(tp, OCP_POWER_CFG);
 	if (enable) {
-		data |= EN_ALDPS;
-		ocp_reg_write(tp, OCP_POWER_CFG, data);
+		ocp_reg_set_bits(tp, OCP_POWER_CFG, EN_ALDPS);
 	} else {
 		int i;
 
-		data &= ~EN_ALDPS;
-		ocp_reg_write(tp, OCP_POWER_CFG, data);
+		ocp_reg_clr_bits(tp, OCP_POWER_CFG, EN_ALDPS);
 		for (i = 0; i < 20; i++) {
 			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 				return;
@@ -5699,8 +5733,6 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 
 static void r8153_hw_phy_cfg(struct r8152 *tp)
 {
-	u16 data;
-
 	/* disable ALDPS before updating the PHY parameters */
 	r8153_aldps_en(tp, false);
 
@@ -5709,22 +5741,14 @@ static void r8153_hw_phy_cfg(struct r8152 *tp)
 
 	rtl8152_apply_firmware(tp, false);
 
-	if (tp->version == RTL_VER_03) {
-		data = ocp_reg_read(tp, OCP_EEE_CFG);
-		data &= ~CTAP_SHORT_EN;
-		ocp_reg_write(tp, OCP_EEE_CFG, data);
-	}
+	if (tp->version == RTL_VER_03)
+		ocp_reg_clr_bits(tp, OCP_EEE_CFG, CTAP_SHORT_EN);
+
+	ocp_reg_set_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
 
-	data = ocp_reg_read(tp, OCP_POWER_CFG);
-	data |= EEE_CLKDIV_EN;
-	ocp_reg_write(tp, OCP_POWER_CFG, data);
+	ocp_reg_set_bits(tp, OCP_DOWN_SPEED, EN_10M_BGOFF);
 
-	data = ocp_reg_read(tp, OCP_DOWN_SPEED);
-	data |= EN_10M_BGOFF;
-	ocp_reg_write(tp, OCP_DOWN_SPEED, data);
-	data = ocp_reg_read(tp, OCP_POWER_CFG);
-	data |= EN_10M_PLLOFF;
-	ocp_reg_write(tp, OCP_POWER_CFG, data);
+	ocp_reg_set_bits(tp, OCP_POWER_CFG, EN_10M_PLLOFF);
 
 	sram_write(tp, SRAM_IMPEDANCE, 0x0b13);
 
@@ -5792,9 +5816,7 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 	case PHY_STAT_EXT_INIT:
 		rtl8152_apply_firmware(tp, true);
 
-		data = r8152_mdio_read(tp, MII_BMCR);
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
+		r8152_mdio_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 		break;
 	case PHY_STAT_LAN_ON:
 	default:
@@ -5804,12 +5826,9 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 
 	r8153b_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
 
-	data = sram_read(tp, SRAM_GREEN_CFG);
-	data |= R_TUNE_EN;
-	sram_write(tp, SRAM_GREEN_CFG, data);
-	data = ocp_reg_read(tp, OCP_NCTL_CFG);
-	data |= PGA_RETURN_EN;
-	ocp_reg_write(tp, OCP_NCTL_CFG, data);
+	sram_set_bits(tp, SRAM_GREEN_CFG, R_TUNE_EN);
+
+	ocp_reg_set_bits(tp, OCP_NCTL_CFG, PGA_RETURN_EN);
 
 	/* ADC Bias Calibration:
 	 * read efuse offset 0x7d to get a 17-bit data. Remove the dummy/fake
@@ -5839,14 +5858,11 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 
 	/* Advnace EEE */
 	if (!rtl_phy_patch_request(tp, true, true)) {
-		data = ocp_reg_read(tp, OCP_POWER_CFG);
-		data |= EEE_CLKDIV_EN;
-		ocp_reg_write(tp, OCP_POWER_CFG, data);
+		ocp_reg_set_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
 		tp->ups_info.eee_ckdiv = true;
 
-		data = ocp_reg_read(tp, OCP_DOWN_SPEED);
-		data |= EN_EEE_CMODE | EN_EEE_1000 | EN_10M_CLKDIV;
-		ocp_reg_write(tp, OCP_DOWN_SPEED, data);
+		ocp_reg_set_bits(tp, OCP_DOWN_SPEED,
+				 EN_EEE_CMODE | EN_EEE_1000 | EN_10M_CLKDIV);
 		tp->ups_info.eee_cmod_lv = true;
 		tp->ups_info._10m_ckdiv = true;
 		tp->ups_info.eee_plloff_giga = true;
@@ -6812,16 +6828,11 @@ static void rtl_tally_reset(struct r8152 *tp)
 static void r8152b_init(struct r8152 *tp)
 {
 	u32 ocp_data;
-	u16 data;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
 	r8152_aldps_en(tp, false);
 
@@ -6851,7 +6862,6 @@ static void r8152b_init(struct r8152 *tp)
 static void r8153_init(struct r8152 *tp)
 {
 	u32 ocp_data;
-	u16 data;
 	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -6869,19 +6879,15 @@ static void r8153_init(struct r8152 *tp)
 			break;
 	}
 
-	data = r8153_phy_status(tp, 0);
+	r8153_phy_status(tp, 0);
 
 	if (tp->version == RTL_VER_03 || tp->version == RTL_VER_04 ||
 	    tp->version == RTL_VER_05)
 		ocp_reg_write(tp, OCP_ADC_CFG, CKADSEL_L | ADC_EN | EN_EMI_L);
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
-	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+	r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
 	r8153_u2p3en(tp, false);
 
@@ -6972,7 +6978,6 @@ static void r8153_init(struct r8152 *tp)
 
 static void r8153b_init(struct r8152 *tp)
 {
-	u16 data;
 	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -6990,15 +6995,11 @@ static void r8153b_init(struct r8152 *tp)
 			break;
 	}
 
-	data = r8153_phy_status(tp, 0);
+	r8153_phy_status(tp, 0);
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
-	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+	r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
 	r8153_u2p3en(tp, false);
 
@@ -7047,7 +7048,6 @@ static void r8153b_init(struct r8152 *tp)
 
 static void r8153c_init(struct r8152 *tp)
 {
-	u16 data;
 	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -7072,15 +7072,11 @@ static void r8153c_init(struct r8152 *tp)
 			return;
 	}
 
-	data = r8153_phy_status(tp, 0);
+	r8153_phy_status(tp, 0);
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
-	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+	r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
 	r8153_u2p3en(tp, false);
 
@@ -7130,9 +7126,7 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 	case PHY_STAT_EXT_INIT:
 		rtl8152_apply_firmware(tp, true);
 
-		data = ocp_reg_read(tp, 0xa468);
-		data &= ~(BIT(3) | BIT(1));
-		ocp_reg_write(tp, 0xa468, data);
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
 		break;
 	case PHY_STAT_LAN_ON:
 	case PHY_STAT_PWRDN:
@@ -7154,153 +7148,57 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 
 	switch (tp->version) {
 	case RTL_VER_10:
-		data = ocp_reg_read(tp, 0xad40);
-		data &= ~0x3ff;
-		data |= BIT(7) | BIT(2);
-		ocp_reg_write(tp, 0xad40, data);
-
-		data = ocp_reg_read(tp, 0xad4e);
-		data |= BIT(4);
-		ocp_reg_write(tp, 0xad4e, data);
-		data = ocp_reg_read(tp, 0xad16);
-		data &= ~0x3ff;
-		data |= 0x6;
-		ocp_reg_write(tp, 0xad16, data);
-		data = ocp_reg_read(tp, 0xad32);
-		data &= ~0x3f;
-		data |= 6;
-		ocp_reg_write(tp, 0xad32, data);
-		data = ocp_reg_read(tp, 0xac08);
-		data &= ~(BIT(12) | BIT(8));
-		ocp_reg_write(tp, 0xac08, data);
-		data = ocp_reg_read(tp, 0xac8a);
-		data |= BIT(12) | BIT(13) | BIT(14);
-		data &= ~BIT(15);
-		ocp_reg_write(tp, 0xac8a, data);
-		data = ocp_reg_read(tp, 0xad18);
-		data |= BIT(10);
-		ocp_reg_write(tp, 0xad18, data);
-		data = ocp_reg_read(tp, 0xad1a);
-		data |= 0x3ff;
-		ocp_reg_write(tp, 0xad1a, data);
-		data = ocp_reg_read(tp, 0xad1c);
-		data |= 0x3ff;
-		ocp_reg_write(tp, 0xad1c, data);
-
-		data = sram_read(tp, 0x80ea);
-		data &= ~0xff00;
-		data |= 0xc400;
-		sram_write(tp, 0x80ea, data);
-		data = sram_read(tp, 0x80eb);
-		data &= ~0x0700;
-		data |= 0x0300;
-		sram_write(tp, 0x80eb, data);
-		data = sram_read(tp, 0x80f8);
-		data &= ~0xff00;
-		data |= 0x1c00;
-		sram_write(tp, 0x80f8, data);
-		data = sram_read(tp, 0x80f1);
-		data &= ~0xff00;
-		data |= 0x3000;
-		sram_write(tp, 0x80f1, data);
-
-		data = sram_read(tp, 0x80fe);
-		data &= ~0xff00;
-		data |= 0xa500;
-		sram_write(tp, 0x80fe, data);
-		data = sram_read(tp, 0x8102);
-		data &= ~0xff00;
-		data |= 0x5000;
-		sram_write(tp, 0x8102, data);
-		data = sram_read(tp, 0x8015);
-		data &= ~0xff00;
-		data |= 0x3300;
-		sram_write(tp, 0x8015, data);
-		data = sram_read(tp, 0x8100);
-		data &= ~0xff00;
-		data |= 0x7000;
-		sram_write(tp, 0x8100, data);
-		data = sram_read(tp, 0x8014);
-		data &= ~0xff00;
-		data |= 0xf000;
-		sram_write(tp, 0x8014, data);
-		data = sram_read(tp, 0x8016);
-		data &= ~0xff00;
-		data |= 0x6500;
-		sram_write(tp, 0x8016, data);
-		data = sram_read(tp, 0x80dc);
-		data &= ~0xff00;
-		data |= 0xed00;
-		sram_write(tp, 0x80dc, data);
-		data = sram_read(tp, 0x80df);
-		data |= BIT(8);
-		sram_write(tp, 0x80df, data);
-		data = sram_read(tp, 0x80e1);
-		data &= ~BIT(8);
-		sram_write(tp, 0x80e1, data);
-
-		data = ocp_reg_read(tp, 0xbf06);
-		data &= ~0x003f;
-		data |= 0x0038;
-		ocp_reg_write(tp, 0xbf06, data);
+		ocp_reg_w0w1(tp, 0xad40, 0x3ff, BIT(7) | BIT(2));
+
+		ocp_reg_set_bits(tp, 0xad4e, BIT(4));
+		ocp_reg_w0w1(tp, 0xad16, 0x3ff, 0x6);
+		ocp_reg_w0w1(tp, 0xad32, 0x3f, 0x6);
+		ocp_reg_clr_bits(tp, 0xac08, BIT(12) | BIT(8));
+		ocp_reg_w0w1(tp, 0xac8a, BIT(15), BIT(12) | BIT(13) | BIT(14));
+		ocp_reg_set_bits(tp, 0xad18, BIT(10));
+		ocp_reg_set_bits(tp, 0xad1a, 0x3ff);
+		ocp_reg_set_bits(tp, 0xad1c, 0x3ff);
+
+		sram_write_w0w1(tp, 0x80ea, 0xff00, 0xc400);
+		sram_write_w0w1(tp, 0x80eb, 0x0700, 0x0300);
+		sram_write_w0w1(tp, 0x80f8, 0xff00, 0x1c00);
+		sram_write_w0w1(tp, 0x80f1, 0xff00, 0x3000);
+
+		sram_write_w0w1(tp, 0x80fe, 0xff00, 0xa500);
+		sram_write_w0w1(tp, 0x8102, 0xff00, 0x5000);
+		sram_write_w0w1(tp, 0x8015, 0xff00, 0x3300);
+		sram_write_w0w1(tp, 0x8100, 0xff00, 0x7000);
+		sram_write_w0w1(tp, 0x8014, 0xff00, 0xf000);
+		sram_write_w0w1(tp, 0x8016, 0xff00, 0x6500);
+		sram_write_w0w1(tp, 0x80dc, 0xff00, 0xed00);
+		sram_set_bits(tp, 0x80df, BIT(8));
+		sram_clr_bits(tp, 0x80e1, BIT(8));
+
+		ocp_reg_w0w1(tp, 0xbf06, 0x003f, 0x0038);
 
 		sram_write(tp, 0x819f, 0xddb6);
 
 		ocp_reg_write(tp, 0xbc34, 0x5555);
-		data = ocp_reg_read(tp, 0xbf0a);
-		data &= ~0x0e00;
-		data |= 0x0a00;
-		ocp_reg_write(tp, 0xbf0a, data);
+		ocp_reg_w0w1(tp, 0xbf0a, 0x0e00, 0x0a00);
 
-		data = ocp_reg_read(tp, 0xbd2c);
-		data &= ~BIT(13);
-		ocp_reg_write(tp, 0xbd2c, data);
+		ocp_reg_clr_bits(tp, 0xbd2c, BIT(13));
 		break;
 	case RTL_VER_11:
-		data = ocp_reg_read(tp, 0xad16);
-		data |= 0x3ff;
-		ocp_reg_write(tp, 0xad16, data);
-		data = ocp_reg_read(tp, 0xad32);
-		data &= ~0x3f;
-		data |= 6;
-		ocp_reg_write(tp, 0xad32, data);
-		data = ocp_reg_read(tp, 0xac08);
-		data &= ~(BIT(12) | BIT(8));
-		ocp_reg_write(tp, 0xac08, data);
-		data = ocp_reg_read(tp, 0xacc0);
-		data &= ~0x3;
-		data |= BIT(1);
-		ocp_reg_write(tp, 0xacc0, data);
-		data = ocp_reg_read(tp, 0xad40);
-		data &= ~0xe7;
-		data |= BIT(6) | BIT(2);
-		ocp_reg_write(tp, 0xad40, data);
-		data = ocp_reg_read(tp, 0xac14);
-		data &= ~BIT(7);
-		ocp_reg_write(tp, 0xac14, data);
-		data = ocp_reg_read(tp, 0xac80);
-		data &= ~(BIT(8) | BIT(9));
-		ocp_reg_write(tp, 0xac80, data);
-		data = ocp_reg_read(tp, 0xac5e);
-		data &= ~0x7;
-		data |= BIT(1);
-		ocp_reg_write(tp, 0xac5e, data);
+		ocp_reg_set_bits(tp, 0xad16, 0x3ff);
+		ocp_reg_w0w1(tp, 0xad32, 0x3f, 0x6);
+		ocp_reg_clr_bits(tp, 0xac08, BIT(12) | BIT(8));
+		ocp_reg_w0w1(tp, 0xacc0, 0x3, BIT(1));
+		ocp_reg_w0w1(tp, 0xad40, 0xe7, BIT(6) | BIT(2));
+		ocp_reg_clr_bits(tp, 0xac14, BIT(7));
+		ocp_reg_clr_bits(tp, 0xac80, BIT(8) | BIT(9));
+		ocp_reg_w0w1(tp, 0xac5e, 0x7, BIT(1));
 		ocp_reg_write(tp, 0xad4c, 0x00a8);
 		ocp_reg_write(tp, 0xac5c, 0x01ff);
-		data = ocp_reg_read(tp, 0xac8a);
-		data &= ~0xf0;
-		data |= BIT(4) | BIT(5);
-		ocp_reg_write(tp, 0xac8a, data);
+		ocp_reg_w0w1(tp, 0xac8a, 0xf0, BIT(4) | BIT(5));
 		ocp_reg_write(tp, 0xb87c, 0x8157);
-		data = ocp_reg_read(tp, 0xb87e);
-		data &= ~0xff00;
-		data |= 0x0500;
-		ocp_reg_write(tp, 0xb87e, data);
+		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0500);
 		ocp_reg_write(tp, 0xb87c, 0x8159);
-		data = ocp_reg_read(tp, 0xb87e);
-		data &= ~0xff00;
-		data |= 0x0700;
-		ocp_reg_write(tp, 0xb87e, data);
+		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0700);
 
 		/* AAGC */
 		ocp_reg_write(tp, 0xb87c, 0x80a2);
@@ -7324,17 +7222,13 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
 				  EEE_SPDWN_EN);
 
-		data = ocp_reg_read(tp, OCP_DOWN_SPEED);
-		data &= ~(EN_EEE_100 | EN_EEE_1000);
-		data |= EN_10M_CLKDIV;
-		ocp_reg_write(tp, OCP_DOWN_SPEED, data);
+		ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000,
+			     EN_10M_CLKDIV);
 		tp->ups_info._10m_ckdiv = true;
 		tp->ups_info.eee_plloff_100 = false;
 		tp->ups_info.eee_plloff_giga = false;
 
-		data = ocp_reg_read(tp, OCP_POWER_CFG);
-		data &= ~EEE_CLKDIV_EN;
-		ocp_reg_write(tp, OCP_POWER_CFG, data);
+		ocp_reg_clr_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
 		tp->ups_info.eee_ckdiv = false;
 
 		ocp_reg_write(tp, OCP_SYSCLK_CFG, 0);
@@ -7344,34 +7238,19 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 		rtl_phy_patch_request(tp, false, true);
 
 		/* enable ADC Ibias Cal */
-		data = ocp_reg_read(tp, 0xd068);
-		data |= BIT(13);
-		ocp_reg_write(tp, 0xd068, data);
+		ocp_reg_set_bits(tp, 0xd068, BIT(13));
 
 		/* enable Thermal Sensor */
-		data = sram_read(tp, 0x81a2);
-		data &= ~BIT(8);
-		sram_write(tp, 0x81a2, data);
-		data = ocp_reg_read(tp, 0xb54c);
-		data &= ~0xff00;
-		data |= 0xdb00;
-		ocp_reg_write(tp, 0xb54c, data);
+		sram_clr_bits(tp, 0x81a2, BIT(8));
+		ocp_reg_w0w1(tp, 0xb54c, 0xff00, 0xdb00);
 
 		/* Nway 2.5G Lite */
-		data = ocp_reg_read(tp, 0xa454);
-		data &= ~BIT(0);
-		ocp_reg_write(tp, 0xa454, data);
+		ocp_reg_clr_bits(tp, 0xa454, BIT(0));
 
 		/* CS DSP solution */
-		data = ocp_reg_read(tp, OCP_10GBT_CTRL);
-		data |= RTL_ADV2_5G_F_R;
-		ocp_reg_write(tp, OCP_10GBT_CTRL, data);
-		data = ocp_reg_read(tp, 0xad4e);
-		data &= ~BIT(4);
-		ocp_reg_write(tp, 0xad4e, data);
-		data = ocp_reg_read(tp, 0xa86a);
-		data &= ~BIT(0);
-		ocp_reg_write(tp, 0xa86a, data);
+		ocp_reg_set_bits(tp, OCP_10GBT_CTRL, RTL_ADV2_5G_F_R);
+		ocp_reg_clr_bits(tp, 0xad4e, BIT(4));
+		ocp_reg_clr_bits(tp, 0xa86a, BIT(0));
 
 		/* MDI SWAP */
 		if ((ocp_read_word(tp, MCU_TYPE_USB, USB_UPS_CFG) & MID_REVERSE) &&
@@ -7432,9 +7311,7 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 		}
 
 		/* Notify the MAC when the speed is changed to force mode. */
-		data = ocp_reg_read(tp, OCP_INTR_EN);
-		data |= INTR_SPEED_FORCE;
-		ocp_reg_write(tp, OCP_INTR_EN, data);
+		ocp_reg_set_bits(tp, OCP_INTR_EN, INTR_SPEED_FORCE);
 		break;
 	default:
 		break;
@@ -7442,12 +7319,8 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 
 	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
 
-	data = ocp_reg_read(tp, 0xa428);
-	data &= ~BIT(9);
-	ocp_reg_write(tp, 0xa428, data);
-	data = ocp_reg_read(tp, 0xa5ea);
-	data &= ~BIT(0);
-	ocp_reg_write(tp, 0xa5ea, data);
+	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0));
 	tp->ups_info.lite_mode = 0;
 
 	if (tp->eee_en)
@@ -7467,21 +7340,12 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 	switch (tp->version) {
 	case RTL_VER_12:
 		ocp_reg_write(tp, 0xbf86, 0x9000);
-		data = ocp_reg_read(tp, 0xc402);
-		data |= BIT(10);
-		ocp_reg_write(tp, 0xc402, data);
-		data &= ~BIT(10);
-		ocp_reg_write(tp, 0xc402, data);
+		ocp_reg_set_bits(tp, 0xc402, BIT(10));
+		ocp_reg_clr_bits(tp, 0xc402, BIT(10));
 		ocp_reg_write(tp, 0xbd86, 0x1010);
 		ocp_reg_write(tp, 0xbd88, 0x1010);
-		data = ocp_reg_read(tp, 0xbd4e);
-		data &= ~(BIT(10) | BIT(11));
-		data |= BIT(11);
-		ocp_reg_write(tp, 0xbd4e, data);
-		data = ocp_reg_read(tp, 0xbf46);
-		data &= ~0xf00;
-		data |= 0x700;
-		ocp_reg_write(tp, 0xbf46, data);
+		ocp_reg_w0w1(tp, 0xbd4e, BIT(10) | BIT(11), BIT(11));
+		ocp_reg_w0w1(tp, 0xbf46, 0xf00, 0x700);
 		break;
 	case RTL_VER_13:
 	case RTL_VER_15:
@@ -7498,13 +7362,8 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 	case PHY_STAT_EXT_INIT:
 		rtl8152_apply_firmware(tp, true);
 
-		data = ocp_reg_read(tp, 0xa466);
-		data &= ~BIT(0);
-		ocp_reg_write(tp, 0xa466, data);
-
-		data = ocp_reg_read(tp, 0xa468);
-		data &= ~(BIT(3) | BIT(1));
-		ocp_reg_write(tp, 0xa468, data);
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
 		break;
 	case PHY_STAT_LAN_ON:
 	case PHY_STAT_PWRDN:
@@ -7513,11 +7372,7 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		break;
 	}
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
 	/* disable ALDPS before updating the PHY parameters */
 	r8153_aldps_en(tp, false);
@@ -7532,21 +7387,12 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 
 	switch (tp->version) {
 	case RTL_VER_12:
-		data = ocp_reg_read(tp, 0xbc08);
-		data |= BIT(3) | BIT(2);
-		ocp_reg_write(tp, 0xbc08, data);
-
-		data = sram_read(tp, 0x8fff);
-		data &= ~0xff00;
-		data |= 0x0400;
-		sram_write(tp, 0x8fff, data);
-
-		data = ocp_reg_read(tp, 0xacda);
-		data |= 0xff00;
-		ocp_reg_write(tp, 0xacda, data);
-		data = ocp_reg_read(tp, 0xacde);
-		data |= 0xf000;
-		ocp_reg_write(tp, 0xacde, data);
+		ocp_reg_set_bits(tp, 0xbc08, BIT(3) | BIT(2));
+
+		sram_write_w0w1(tp, 0x8fff, 0xff00, 0x0400);
+
+		ocp_reg_set_bits(tp, 0xacda, 0xff00);
+		ocp_reg_set_bits(tp, 0xacde, 0xf000);
 		ocp_reg_write(tp, 0xac8c, 0x0ffc);
 		ocp_reg_write(tp, 0xac46, 0xb7b4);
 		ocp_reg_write(tp, 0xac50, 0x0fbc);
@@ -7624,21 +7470,15 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_write(tp, 0xb87e, 0x790e);
 		ocp_reg_write(tp, 0xb87c, 0x80b0);
 		ocp_reg_write(tp, 0xb87e, 0x0f31);
-		data = ocp_reg_read(tp, 0xbf4c);
-		data |= BIT(1);
-		ocp_reg_write(tp, 0xbf4c, data);
-		data = ocp_reg_read(tp, 0xbcca);
-		data |= BIT(9) | BIT(8);
-		ocp_reg_write(tp, 0xbcca, data);
+		ocp_reg_set_bits(tp, 0xbf4c, BIT(1));
+		ocp_reg_set_bits(tp, 0xbcca, BIT(9) | BIT(8));
 		ocp_reg_write(tp, 0xb87c, 0x8141);
 		ocp_reg_write(tp, 0xb87e, 0x320e);
 		ocp_reg_write(tp, 0xb87c, 0x8153);
 		ocp_reg_write(tp, 0xb87e, 0x720e);
 		ocp_reg_write(tp, 0xb87c, 0x8529);
 		ocp_reg_write(tp, 0xb87e, 0x050e);
-		data = ocp_reg_read(tp, OCP_EEE_CFG);
-		data &= ~CTAP_SHORT_EN;
-		ocp_reg_write(tp, OCP_EEE_CFG, data);
+		ocp_reg_clr_bits(tp, OCP_EEE_CFG, CTAP_SHORT_EN);
 
 		sram_write(tp, 0x816c, 0xc4a0);
 		sram_write(tp, 0x8170, 0xc4a0);
@@ -7671,64 +7511,33 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_write(tp, 0xb87c, 0x817b);
 		ocp_reg_write(tp, 0xb87e, 0x1d0a);
 
-		data = sram_read(tp, 0x8217);
-		data &= ~0xff00;
-		data |= 0x5000;
-		sram_write(tp, 0x8217, data);
-		data = sram_read(tp, 0x821a);
-		data &= ~0xff00;
-		data |= 0x5000;
-		sram_write(tp, 0x821a, data);
+		sram_write_w0w1(tp, 0x8217, 0xff00, 0x5000);
+		sram_write_w0w1(tp, 0x821a, 0xff00, 0x5000);
 		sram_write(tp, 0x80da, 0x0403);
-		data = sram_read(tp, 0x80dc);
-		data &= ~0xff00;
-		data |= 0x1000;
-		sram_write(tp, 0x80dc, data);
+		sram_write_w0w1(tp, 0x80dc, 0xff00, 0x1000);
 		sram_write(tp, 0x80b3, 0x0384);
 		sram_write(tp, 0x80b7, 0x2007);
-		data = sram_read(tp, 0x80ba);
-		data &= ~0xff00;
-		data |= 0x6c00;
-		sram_write(tp, 0x80ba, data);
+		sram_write_w0w1(tp, 0x80ba, 0xff00, 0x6c00);
 		sram_write(tp, 0x80b5, 0xf009);
-		data = sram_read(tp, 0x80bd);
-		data &= ~0xff00;
-		data |= 0x9f00;
-		sram_write(tp, 0x80bd, data);
+		sram_write_w0w1(tp, 0x80bd, 0xff00, 0x9f00);
 		sram_write(tp, 0x80c7, 0xf083);
 		sram_write(tp, 0x80dd, 0x03f0);
-		data = sram_read(tp, 0x80df);
-		data &= ~0xff00;
-		data |= 0x1000;
-		sram_write(tp, 0x80df, data);
+		sram_write_w0w1(tp, 0x80df, 0xff00, 0x1000);
 		sram_write(tp, 0x80cb, 0x2007);
-		data = sram_read(tp, 0x80ce);
-		data &= ~0xff00;
-		data |= 0x6c00;
-		sram_write(tp, 0x80ce, data);
+		sram_write_w0w1(tp, 0x80ce, 0xff00, 0x6c00);
 		sram_write(tp, 0x80c9, 0x8009);
-		data = sram_read(tp, 0x80d1);
-		data &= ~0xff00;
-		data |= 0x8000;
-		sram_write(tp, 0x80d1, data);
+		sram_write_w0w1(tp, 0x80d1, 0xff00, 0x8000);
 		sram_write(tp, 0x80a3, 0x200a);
 		sram_write(tp, 0x80a5, 0xf0ad);
 		sram_write(tp, 0x809f, 0x6073);
 		sram_write(tp, 0x80a1, 0x000b);
-		data = sram_read(tp, 0x80a9);
-		data &= ~0xff00;
-		data |= 0xc000;
-		sram_write(tp, 0x80a9, data);
+		sram_write_w0w1(tp, 0x80a9, 0xff00, 0xc000);
 
 		if (rtl_phy_patch_request(tp, true, true))
 			return;
 
-		data = ocp_reg_read(tp, 0xb896);
-		data &= ~BIT(0);
-		ocp_reg_write(tp, 0xb896, data);
-		data = ocp_reg_read(tp, 0xb892);
-		data &= ~0xff00;
-		ocp_reg_write(tp, 0xb892, data);
+		ocp_reg_clr_bits(tp, 0xb896, BIT(0));
+		ocp_reg_clr_bits(tp, 0xb892, 0xff00);
 		ocp_reg_write(tp, 0xb88e, 0xc23e);
 		ocp_reg_write(tp, 0xb890, 0x0000);
 		ocp_reg_write(tp, 0xb88e, 0xc240);
@@ -7743,41 +7552,25 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_write(tp, 0xb890, 0x1012);
 		ocp_reg_write(tp, 0xb88e, 0xc24a);
 		ocp_reg_write(tp, 0xb890, 0x1416);
-		data = ocp_reg_read(tp, 0xb896);
-		data |= BIT(0);
-		ocp_reg_write(tp, 0xb896, data);
+		ocp_reg_set_bits(tp, 0xb896, BIT(0));
 
 		rtl_phy_patch_request(tp, false, true);
 
-		data = ocp_reg_read(tp, 0xa86a);
-		data |= BIT(0);
-		ocp_reg_write(tp, 0xa86a, data);
-		data = ocp_reg_read(tp, 0xa6f0);
-		data |= BIT(0);
-		ocp_reg_write(tp, 0xa6f0, data);
+		ocp_reg_set_bits(tp, 0xa86a, BIT(0));
+		ocp_reg_set_bits(tp, 0xa6f0, BIT(0));
 
 		ocp_reg_write(tp, 0xbfa0, 0xd70d);
 		ocp_reg_write(tp, 0xbfa2, 0x4100);
 		ocp_reg_write(tp, 0xbfa4, 0xe868);
 		ocp_reg_write(tp, 0xbfa6, 0xdc59);
 		ocp_reg_write(tp, 0xb54c, 0x3c18);
-		data = ocp_reg_read(tp, 0xbfa4);
-		data &= ~BIT(5);
-		ocp_reg_write(tp, 0xbfa4, data);
-		data = sram_read(tp, 0x817d);
-		data |= BIT(12);
-		sram_write(tp, 0x817d, data);
+		ocp_reg_clr_bits(tp, 0xbfa4, BIT(5));
+		sram_set_bits(tp, 0x817d, BIT(12));
 		break;
 	case RTL_VER_13:
 		/* 2.5G INRX */
-		data = ocp_reg_read(tp, 0xac46);
-		data &= ~0x00f0;
-		data |= 0x0090;
-		ocp_reg_write(tp, 0xac46, data);
-		data = ocp_reg_read(tp, 0xad30);
-		data &= ~0x0003;
-		data |= 0x0001;
-		ocp_reg_write(tp, 0xad30, data);
+		ocp_reg_w0w1(tp, 0xac46, 0x00f0, 0x0090);
+		ocp_reg_w0w1(tp, 0xad30, 0x0003, 0x0001);
 		fallthrough;
 	case RTL_VER_15:
 		/* EEE parameter */
@@ -7786,20 +7579,11 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_write(tp, 0xb87c, 0x8107);
 		ocp_reg_write(tp, 0xb87e, 0x360e);
 		ocp_reg_write(tp, 0xb87c, 0x8551);
-		data = ocp_reg_read(tp, 0xb87e);
-		data &= ~0xff00;
-		data |= 0x0800;
-		ocp_reg_write(tp, 0xb87e, data);
+		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0800);
 
 		/* ADC_PGA parameter */
-		data = ocp_reg_read(tp, 0xbf00);
-		data &= ~0xe000;
-		data |= 0xa000;
-		ocp_reg_write(tp, 0xbf00, data);
-		data = ocp_reg_read(tp, 0xbf46);
-		data &= ~0x0f00;
-		data |= 0x0300;
-		ocp_reg_write(tp, 0xbf46, data);
+		ocp_reg_w0w1(tp, 0xbf00, 0xe000, 0xa000);
+		ocp_reg_w0w1(tp, 0xbf46, 0x0f00, 0x0300);
 
 		/* Green Table-PGA, 1G full viterbi */
 		sram_write(tp, 0x8044, 0x2417);
@@ -7814,48 +7598,35 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		sram_write(tp, 0x807a, 0x2417);
 
 		/* XG PLL */
-		data = ocp_reg_read(tp, 0xbf84);
-		data &= ~0xe000;
-		data |= 0xa000;
-		ocp_reg_write(tp, 0xbf84, data);
+		ocp_reg_w0w1(tp, 0xbf84, 0xe000, 0xa000);
 		break;
 	default:
 		break;
 	}
 
 	/* Notify the MAC when the speed is changed to force mode. */
-	data = ocp_reg_read(tp, OCP_INTR_EN);
-	data |= INTR_SPEED_FORCE;
-	ocp_reg_write(tp, OCP_INTR_EN, data);
+	ocp_reg_set_bits(tp, OCP_INTR_EN, INTR_SPEED_FORCE);
 
 	if (rtl_phy_patch_request(tp, true, true))
 		return;
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
 
-	data = ocp_reg_read(tp, OCP_DOWN_SPEED);
-	data &= ~(EN_EEE_100 | EN_EEE_1000);
-	data |= EN_10M_CLKDIV;
-	ocp_reg_write(tp, OCP_DOWN_SPEED, data);
+	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000,
+		     EN_10M_CLKDIV);
 	tp->ups_info._10m_ckdiv = true;
 	tp->ups_info.eee_plloff_100 = false;
 	tp->ups_info.eee_plloff_giga = false;
 
-	data = ocp_reg_read(tp, OCP_POWER_CFG);
-	data &= ~EEE_CLKDIV_EN;
-	ocp_reg_write(tp, OCP_POWER_CFG, data);
+	ocp_reg_clr_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
 	tp->ups_info.eee_ckdiv = false;
 
 	rtl_phy_patch_request(tp, false, true);
 
 	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
 
-	data = ocp_reg_read(tp, 0xa428);
-	data &= ~BIT(9);
-	ocp_reg_write(tp, 0xa428, data);
-	data = ocp_reg_read(tp, 0xa5ea);
-	data &= ~BIT(0);
-	ocp_reg_write(tp, 0xa5ea, data);
+	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0));
 	tp->ups_info.lite_mode = 0;
 
 	if (tp->eee_en)
@@ -7895,17 +7666,10 @@ static void r8156_init(struct r8152 *tp)
 	}
 
 	data = r8153_phy_status(tp, 0);
-	if (data == PHY_STAT_EXT_INIT) {
-		data = ocp_reg_read(tp, 0xa468);
-		data &= ~(BIT(3) | BIT(1));
-		ocp_reg_write(tp, 0xa468, data);
-	}
+	if (data == PHY_STAT_EXT_INIT)
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
@@ -7993,20 +7757,11 @@ static void r8156b_init(struct r8152 *tp)
 
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
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
 	}
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
-- 
2.34.1


