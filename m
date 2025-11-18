Return-Path: <netdev+bounces-239425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 722FEC681F1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 71DA32A128
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16326ED4D;
	Tue, 18 Nov 2025 08:06:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD752EAB64
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453178; cv=none; b=ErbG0yZqrKZKt1whNpUSOB2teAw+1yEZAhRFA9w1C7/BX0DCN7l/oEHtVwXCuPru6ZfZ0nxJANSEoOzl6dXHirrdsVTQD6ASBxASnoWJl2Ueoc+RrItb3+wU5SWda6ZDBBcJPgtQCwfhy5g7F24u0GvPvXUCzKoyK8YM+gxMHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453178; c=relaxed/simple;
	bh=AN4QvZgdnSi/Y0ZTZszrq7i6ollT2s7f/d5LA7zuY2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSAGgeNIofJYUhlrs/p1Wd3R/mY2heXCoGebDwjbqgnD9v9CLPz550oDrZwShgCyS3SZUW7SkzH0DzCUJVj8y+ZujyrTOcy588pGhJoMGNnYg2BieQ6cl8TaeL+Z6MzZbTXiioT8XlyxS/ijabxAe8bZXWz6i5LudYzuN+bCJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1763453000t20907abc
X-QQ-Originating-IP: BAQgNe8UcrP9D9e+8czKd5uXU3XjO9EqIqnn5XMvMK8=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.152.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 16:03:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9038855050498999249
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 2/5] net: txgbe: rename the SFP related
Date: Tue, 18 Nov 2025 16:02:56 +0800
Message-Id: <20251118080259.24676-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251118080259.24676-1-jiawenwu@trustnetic.com>
References: <20251118080259.24676-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M+0YV038q5N1cPv5/MlhYo7hvaGzi420iT3MgaO4MwunzbC3UK9NP5Ud
	bxEB7zXs5Pjc2gGaG7Vcji4niiA9iPQqxAJxe9slQBZ5J5ChLrbTGzluHYAH4Fwz5ijo/Ah
	tFjhtLfParAEddbfh4fXCdRYjRxCUIJyL3fcrd6VT8dBSXMAhbBYTIIBeApYAulaDwynin1
	brLMMp/fji0gUON7FwUZmYnDfsfdXwi0YZaN9gVcawu9Kj4znrTUKPM7dZNJ/xfQ0eIcpfn
	LMJVW7v+mfbuTDJgwZuBcbLIA0Rdaqn3DA5D/9w/TTeuHh8hLx9EYlmYxdzpdbQaox6p4V2
	P8WLwPpvUtNRsXplj5oGzU8vVugIN2I+p3coJCbnSnoaUxA2KM8ML9UnwXcHEWnLaXR3tYc
	9HDidwHxx8cAWcbpy6uU04JgVDZrEMSwZ8n/K6KWUA5SHoHI2C15mBGOgRoidgLC6MeLo6n
	ehEaFGmYzqqtbYQfGaaWu+A4GUuSehvnK8KCJIpgKsBYLXDDBqjk/+EerE+HaeV3DkpDBXw
	fU8nLYI+mAg5xEAw1gtnyLwZBgojI83D+hjGbGspoSQX54kQEizeA75DkilrnK5R3QDtUHj
	b2hosah35NDPWgUAmUYZsJf3qBt4lS3P4xffBw+xmaHqsloaIzmsaLcvivLyp1h5AKrRgK8
	i4c7WrZtOUdTmwUwvzGm70mJlnGy4cTL11HxZnHG2WgYqu6W9FX1JbfFZYSavWzyftLfl9n
	8LiVt0tcQ4GofmoSn5vkjZ/55J13pSMwnwsvKYz6gbbOgWeBe+gqxgfTFmtqlRR+Ior3CYO
	tte73hX9gIiQsVfvCOeo3J7Dr1FkIiv/mpBDNZ2IUThVPszjU00OPY9yNyuZuw9scuee9HE
	WpvugcXVljzUezqkGdNeR1bbUKOEqGbHQUUQ/Tt1peZ5Q3P9jCOdwFQ/Oxw+XWaB+eveBM1
	LLN7R9P2wHk5xZRGHm8IFMQY0VLmWRwLPhKFlcGSBh4RUgOsFiTFrAfdNG9xNHng6/0JXFM
	ltaVVBcqfzau6M0qUOnGDQGXANim7tuAwID6nDWLEZpiv8bg1i
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

QSFP supported will be introduced for AML 40G devices, the code related
to identify various modules should be renamed to more appropriate names.

And struct txgbe_hic_i2c_read used to get module information is renamed
as struct txgbe_hic_get_module_info, because another SW-FW command to
read I2C will be added later.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 39 ++++++++++---------
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  2 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 12 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 12 +++---
 6 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b1a6ef5709a9..29e5c5470c94 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1249,7 +1249,7 @@ enum wx_pf_flags {
 	WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
 	WX_FLAG_PTP_PPS_ENABLED,
 	WX_FLAG_NEED_LINK_CONFIG,
-	WX_FLAG_NEED_SFP_RESET,
+	WX_FLAG_NEED_MODULE_RESET,
 	WX_FLAG_NEED_UPDATE_LINK,
 	WX_FLAG_NEED_DO_RESET,
 	WX_FLAG_RX_MERGE_ENABLED,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index a7650f548fa4..432880ccc640 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -38,7 +38,7 @@ irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data)
 	wr32(wx, WX_GPIO_INTMASK, 0xFF);
 	status = rd32(wx, WX_GPIO_INTSTATUS);
 	if (status & TXGBE_GPIOBIT_2) {
-		set_bit(WX_FLAG_NEED_SFP_RESET, wx->flags);
+		set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
 		wr32(wx, WX_GPIO_EOI, TXGBE_GPIOBIT_2);
 		wx_service_event_schedule(wx);
 	}
@@ -63,15 +63,16 @@ int txgbe_test_hostif(struct wx *wx)
 					WX_HI_COMMAND_TIMEOUT, true);
 }
 
-static int txgbe_identify_sfp_hostif(struct wx *wx, struct txgbe_hic_i2c_read *buffer)
+static int txgbe_identify_module_hostif(struct wx *wx,
+					struct txgbe_hic_get_module_info *buffer)
 {
-	buffer->hdr.cmd = FW_READ_SFP_INFO_CMD;
-	buffer->hdr.buf_len = sizeof(struct txgbe_hic_i2c_read) -
+	buffer->hdr.cmd = FW_GET_MODULE_INFO_CMD;
+	buffer->hdr.buf_len = sizeof(struct txgbe_hic_get_module_info) -
 			      sizeof(struct wx_hic_hdr);
 	buffer->hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
 
 	return wx_host_interface_command(wx, (u32 *)buffer,
-					 sizeof(struct txgbe_hic_i2c_read),
+					 sizeof(struct txgbe_hic_get_module_info),
 					 WX_HI_COMMAND_TIMEOUT, true);
 }
 
@@ -109,9 +110,9 @@ static void txgbe_get_link_capabilities(struct wx *wx, int *speed,
 {
 	struct txgbe *txgbe = wx->priv;
 
-	if (test_bit(PHY_INTERFACE_MODE_25GBASER, txgbe->sfp_interfaces))
+	if (test_bit(PHY_INTERFACE_MODE_25GBASER, txgbe->link_interfaces))
 		*speed = SPEED_25000;
-	else if (test_bit(PHY_INTERFACE_MODE_10GBASER, txgbe->sfp_interfaces))
+	else if (test_bit(PHY_INTERFACE_MODE_10GBASER, txgbe->link_interfaces))
 		*speed = SPEED_10000;
 	else
 		*speed = SPEED_UNKNOWN;
@@ -150,7 +151,7 @@ int txgbe_set_phy_link(struct wx *wx)
 	return 0;
 }
 
-static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sfp_id *id)
+static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
 	DECLARE_PHY_INTERFACE_MASK(interfaces);
@@ -204,9 +205,9 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sfp_id *id)
 	phylink_set(modes, Asym_Pause);
 	phylink_set(modes, FIBRE);
 
-	if (!linkmode_equal(txgbe->sfp_support, modes)) {
-		linkmode_copy(txgbe->sfp_support, modes);
-		phy_interface_and(txgbe->sfp_interfaces,
+	if (!linkmode_equal(txgbe->link_support, modes)) {
+		linkmode_copy(txgbe->link_support, modes);
+		phy_interface_and(txgbe->link_interfaces,
 				  wx->phylink_config.supported_interfaces,
 				  interfaces);
 		linkmode_copy(txgbe->advertising, modes);
@@ -217,10 +218,10 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sfp_id *id)
 	return 0;
 }
 
-int txgbe_identify_sfp(struct wx *wx)
+int txgbe_identify_module(struct wx *wx)
 {
-	struct txgbe_hic_i2c_read buffer;
-	struct txgbe_sfp_id *id;
+	struct txgbe_hic_get_module_info buffer;
+	struct txgbe_sff_id *id;
 	int err = 0;
 	u32 gpio;
 
@@ -228,9 +229,9 @@ int txgbe_identify_sfp(struct wx *wx)
 	if (gpio & TXGBE_GPIOBIT_2)
 		return -ENODEV;
 
-	err = txgbe_identify_sfp_hostif(wx, &buffer);
+	err = txgbe_identify_module_hostif(wx, &buffer);
 	if (err) {
-		wx_err(wx, "Failed to identify SFP module\n");
+		wx_err(wx, "Failed to identify module\n");
 		return err;
 	}
 
@@ -247,10 +248,10 @@ void txgbe_setup_link(struct wx *wx)
 {
 	struct txgbe *txgbe = wx->priv;
 
-	phy_interface_zero(txgbe->sfp_interfaces);
-	linkmode_zero(txgbe->sfp_support);
+	phy_interface_zero(txgbe->link_interfaces);
+	linkmode_zero(txgbe->link_support);
 
-	txgbe_identify_sfp(wx);
+	txgbe_identify_module(wx);
 }
 
 static void txgbe_get_link_state(struct phylink_config *config,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
index 25d4971ca0d9..7c8fa48e68d3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
@@ -8,7 +8,7 @@ void txgbe_gpio_init_aml(struct wx *wx);
 irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data);
 int txgbe_test_hostif(struct wx *wx);
 int txgbe_set_phy_link(struct wx *wx);
-int txgbe_identify_sfp(struct wx *wx);
+int txgbe_identify_module(struct wx *wx);
 void txgbe_setup_link(struct wx *wx);
 int txgbe_phylink_init_aml(struct txgbe *txgbe);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index e8dd277a35c7..d7f905359458 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -32,7 +32,7 @@ int txgbe_get_link_ksettings(struct net_device *netdev,
 	cmd->base.port = txgbe->link_port;
 	cmd->base.autoneg = phylink_test(txgbe->advertising, Autoneg) ?
 			    AUTONEG_ENABLE : AUTONEG_DISABLE;
-	linkmode_copy(cmd->link_modes.supported, txgbe->sfp_support);
+	linkmode_copy(cmd->link_modes.supported, txgbe->link_support);
 	linkmode_copy(cmd->link_modes.advertising, txgbe->advertising);
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index daa761e48f9d..91d1b4e68126 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -89,21 +89,21 @@ static int txgbe_enumerate_functions(struct wx *wx)
 	return physfns;
 }
 
-static void txgbe_sfp_detection_subtask(struct wx *wx)
+static void txgbe_module_detection_subtask(struct wx *wx)
 {
 	int err;
 
-	if (!test_bit(WX_FLAG_NEED_SFP_RESET, wx->flags))
+	if (!test_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
 		return;
 
-	/* wait for SFP module ready */
+	/* wait for SFF module ready */
 	msleep(200);
 
-	err = txgbe_identify_sfp(wx);
+	err = txgbe_identify_module(wx);
 	if (err)
 		return;
 
-	clear_bit(WX_FLAG_NEED_SFP_RESET, wx->flags);
+	clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
 }
 
 static void txgbe_link_config_subtask(struct wx *wx)
@@ -128,7 +128,7 @@ static void txgbe_service_task(struct work_struct *work)
 {
 	struct wx *wx = container_of(work, struct wx, service_task);
 
-	txgbe_sfp_detection_subtask(wx);
+	txgbe_module_detection_subtask(wx);
 	txgbe_link_config_subtask(wx);
 
 	wx_service_event_complete(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index b9a4ba48f5b9..c115ed659544 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -341,9 +341,9 @@ void txgbe_do_reset(struct net_device *netdev);
 
 #define FW_PHY_GET_LINK_CMD             0xC0
 #define FW_PHY_SET_LINK_CMD             0xC1
-#define FW_READ_SFP_INFO_CMD            0xC5
+#define FW_GET_MODULE_INFO_CMD          0xC5
 
-struct txgbe_sfp_id {
+struct txgbe_sff_id {
 	u8 identifier;		/* A0H 0x00 */
 	u8 com_1g_code;		/* A0H 0x06 */
 	u8 com_10g_code;	/* A0H 0x03 */
@@ -358,9 +358,9 @@ struct txgbe_sfp_id {
 	u8 reserved[5];
 };
 
-struct txgbe_hic_i2c_read {
+struct txgbe_hic_get_module_info {
 	struct wx_hic_hdr hdr;
-	struct txgbe_sfp_id id;
+	struct txgbe_sff_id id;
 };
 
 struct txgbe_hic_ephy_setlink {
@@ -451,8 +451,8 @@ struct txgbe {
 	int fdir_filter_count;
 	spinlock_t fdir_perfect_lock; /* spinlock for FDIR */
 
-	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
+	DECLARE_PHY_INTERFACE_MASK(link_interfaces);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(link_support);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
 	u8 link_port;
 };
-- 
2.48.1


