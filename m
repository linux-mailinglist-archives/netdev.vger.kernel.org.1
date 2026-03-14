Return-Path: <netdev+bounces-267696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM1XCEMttWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 732CE28C6EA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8039A301B91D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E36343D91;
	Sat, 14 Mar 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="LdVCMBFu";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1N9Bg0OP"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA23090F5;
	Sat, 14 Mar 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481268; cv=none; b=tzFgp9LKJSEaAw3EVfc5/6SYa3xwhFIOdCSNBKvLwxDPRySgPWg5ayvry5IjvcxB/tdZBzI2jTOEs+lmbrLRh2Htnihi7RbYd8k/d8kS7tAtiNgWnxuhgwzsY4p6+XjhZ+43/AvKoGlnEnAsz+sSj0Pk2A2iPS+cTFOF6p3wH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481268; c=relaxed/simple;
	bh=cNmPnsKqP2KaYH0AL/oFZr4lCyZZpafsyOjdaRm1B9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNCd8jnyZhusemA+HF4WAIJagOnHS3UiN/xwqHkKM8jnxlixc5ns3kOpJrqDBJt4SnAA5nBRgDkFS3fuWr+xdCSQLjhl/PNGd3XijafTbUdkUe7Jbn2QFFpHw/palEDl8AoAm8+TDhRUFGPvVSfS/3x4pCAcC4T9MZ/gvdvx0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=LdVCMBFu; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1N9Bg0OP; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480705;
	bh=cNmPnsKqP2KaYH0AL/oFZr4lCyZZpafsyOjdaRm1B9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LdVCMBFu2m+j6owDXgRMWMtpHKqKnAzz6nJnh31cehELADjm+/cX9J0lU/Yc66LrS
	 Ns4igDjOep+vQ3n2l04M6FX8k5LrJJAozDo3GEOlPgMsKcuYRfQi2Tr+KFBF/rQx7X
	 4DyVCTC8ffIPr+Dmu6QU67HEgTrK1MYdQ39Dr776mkc3JQ06a6vMe1nNrYl/poBEM2
	 gjOQ5yX0cAEDLUT4aaA3zNAp5wo4P0ZUs/fDgr5eDvKxMtTn4HaSISrpuZCO7eaw1L
	 SL0Lexwp+Ia9MQZ//K8M0jKBe4XuRitHcn+tn8jFu6sQ42Qn0MV+AiDP7XaUOeB1CF
	 pTHJWYRck5E3Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 31D3D3FCED; Sat, 14 Mar 2026 09:31:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480702;
	bh=cNmPnsKqP2KaYH0AL/oFZr4lCyZZpafsyOjdaRm1B9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1N9Bg0OPQ8FPFho+55p+Fz9MIYzQltoXvBLtwzFDw5ArL9LAs8QSOoE6mFvU/yYGq
	 3gyBaY8XZ3i5J7vylx5Iww5dHsVlN2AAMFX4/5EKO/u1b9fP3/kNXNMRJTXLcxAmiy
	 GJfGC7AL8XWBieJd67AqIn9efFAdgm5khlPhotVbBLB+Sx1BNGhHRZEBfER7judp4o
	 jO/fmB704muVrt/l33Ucy112wXT5ukDBxjt+3E3KTxHENEX5F9LZ6NdwlKzkUE+Gdi
	 J8tsFXGq4zDTNTEOLbrQS5xGNPgHnNWJp2f9W63XehZ9AUG66bqx5/q0uhPgLB5Ktb
	 WGRbVB6rjwVOg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9FBF73FCAD;
	Sat, 14 Mar 2026 09:31:42 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:38 +0100
Subject: [PATCH net-next 2/9] r8152: Add support for RTL8157 SRAM access
 and ADV indirect access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-2-9ba77b428afd@birger-koblitz.de>
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
	TAGGED_FROM(0.00)[bounces-267696-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 732CE28C6EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the SRAM access interface of the RTL8157 and
the ADV indirect access interface.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index cefc08fd15c824025ae10426dcf41609687a723e..45b79a0138f0440a8cb0b2124b2b71b85a319b6b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -156,6 +156,9 @@
 #define USB_U1U2_TIMER		0xd4da
 #define USB_FW_TASK		0xd4e8	/* RTL8153B */
 #define USB_RX_AGGR_NUM		0xd4ee
+#define USB_ADV_ADDR		0xd5d6
+#define USB_ADV_DATA		0xd5d8
+#define USB_ADV_CMD		0xd5dc
 #define USB_UPS_CTRL		0xd800
 #define USB_POWER_CUT		0xd80a
 #define USB_MISC_0		0xd81a
@@ -213,6 +216,8 @@
 #define OCP_PHY_PATCH_STAT	0xb800
 #define OCP_PHY_PATCH_CMD	0xb820
 #define OCP_PHY_LOCK		0xb82e
+#define OCP_SRAM2_ADDR		0xb87c
+#define OCP_SRAM2_DATA		0xb87e
 #define OCP_ADC_IOFFSET		0xbcfc
 #define OCP_ADC_CFG		0xbc06
 #define OCP_SYSCLK_CFG		0xc416
@@ -490,6 +495,12 @@
 /* USB_RX_AGGR_NUM */
 #define RX_AGGR_NUM_MASK	0x1ff
 
+/* USB_ADV_CMD */
+#define ADV_CMD_BMU		0
+#define ADV_CMD_BUSY		BIT(0)
+#define ADV_CMD_WR		BIT(1)
+#define ADV_CMD_IP		BIT(2)
+
 /* USB_UPS_CTRL */
 #define POWER_CUT		0x0100
 
@@ -1656,6 +1667,134 @@ static inline int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
 	return ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2);
 }
 
+static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
+{
+	int i, ret;
+
+	for (i = 0; i < 10; i++) {
+		u16 ocp_data = ocp_read_word(tp, MCU_TYPE_USB, cmd);
+
+		if (!(ocp_data & ADV_CMD_BUSY))
+			break;
+		usleep_range(1000, 2000);
+	}
+
+	if (i == 10)
+		ret = -ETIMEDOUT;
+
+	return ret;
+}
+
+static u32 ocp_adv_read(struct r8152 *tp, u16 cmd, u16 addr, u32 *data)
+{
+	int ret;
+
+	ret = wait_cmd_ready(tp, USB_ADV_CMD);
+	if (ret < 0)
+		goto out;
+
+	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_ADDR, addr);
+
+	cmd |= ADV_CMD_BUSY;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_CMD, cmd);
+
+	ret = wait_cmd_ready(tp, USB_ADV_CMD);
+	if (ret < 0)
+		goto out;
+
+	*data = ocp_read_dword(tp, MCU_TYPE_USB, USB_ADV_DATA);
+
+out:
+	return ret;
+}
+
+static int ocp_adv_write(struct r8152 *tp, u16 cmd, u16 addr, u32 data)
+{
+	int ret;
+
+	ret = wait_cmd_ready(tp, USB_ADV_CMD);
+	if (ret < 0)
+		goto out;
+
+	cmd |= ADV_CMD_WR;
+	ocp_write_dword(tp, MCU_TYPE_USB, USB_ADV_DATA, data);
+
+	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_ADDR, addr);
+
+	cmd |= ADV_CMD_BUSY;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_CMD, cmd);
+
+out:
+	return ret;
+}
+
+static int rtl_bmu_read(struct r8152 *tp, u16 addr, u32 *data)
+{
+	return ocp_adv_read(tp, ADV_CMD_BMU, addr, data);
+}
+
+static int rtl_bmu_write(struct r8152 *tp, u16 addr, u32 data)
+{
+	return ocp_adv_write(tp, ADV_CMD_BMU, addr, data);
+}
+
+static int rtl_bmu_w0w1(struct r8152 *tp, u16 addr, u32 clear, u32 set)
+{
+	u32 bmu;
+	int ret;
+
+	ret = rtl_bmu_read(tp, addr, &bmu);
+	if (ret < 0)
+		goto out;
+
+	bmu = (bmu & ~clear) | set;
+	ret = rtl_bmu_write(tp, addr, bmu);
+
+out:
+	return ret;
+}
+
+static int rtl_bmu_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
+{
+	return rtl_bmu_w0w1(tp, addr, clear, 0);
+}
+
+static int rtl_ip_read(struct r8152 *tp, u16 addr, u32 *data)
+{
+	return ocp_adv_read(tp, ADV_CMD_IP, addr, data);
+}
+
+static int rtl_ip_write(struct r8152 *tp, u16 addr, u32 data)
+{
+	return ocp_adv_write(tp, ADV_CMD_IP, addr, data);
+}
+
+static int rtl_ip_w0w1(struct r8152 *tp, u16 addr, u32 clear, u32 set)
+{
+	int ret;
+	u32 ip;
+
+	ret = rtl_ip_read(tp, addr, &ip);
+	if (ret < 0)
+		goto out;
+
+	ip = (ip & ~clear) | set;
+	ret = rtl_ip_write(tp, addr, ip);
+
+out:
+	return ret;
+}
+
+static int rtl_ip_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
+{
+	return rtl_ip_w0w1(tp, addr, clear, 0);
+}
+
+static int rtl_ip_set_bits(struct r8152 *tp, u16 addr, u32 set)
+{
+	return rtl_ip_w0w1(tp, addr, 0, set);
+}
+
 static void sram_write(struct r8152 *tp, u16 addr, u16 data)
 {
 	ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
@@ -1668,6 +1807,28 @@ static u16 sram_read(struct r8152 *tp, u16 addr)
 	return ocp_reg_read(tp, OCP_SRAM_DATA);
 }
 
+static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data = sram_read(tp, addr);
+
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, OCP_SRAM_DATA, data);
+}
+
+static u16 sram2_read(struct r8152 *tp, u16 addr)
+{
+	ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
+	return ocp_reg_read(tp, OCP_SRAM2_DATA);
+}
+
+static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data = sram2_read(tp, addr);
+
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, OCP_SRAM2_DATA, data);
+}
+
 static int read_mii_word(struct net_device *netdev, int phy_id, int reg)
 {
 	struct r8152 *tp = netdev_priv(netdev);

-- 
2.47.3


