Return-Path: <netdev+bounces-163480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C119A2A5F2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75332188984D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6922686F;
	Thu,  6 Feb 2025 10:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708722687E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838325; cv=none; b=R87tpIZY8cP3K+luV4CGAgvNWau1dHJMPzxPBNETMKgYKAEqeaPUlAKgmxSgRDfhJe152AeJWqbYKcCrj3nN8Oj1A348pScHNA6RPfX/3TD2GzBoOjqfWeHT2T9hQF1XRm4O5BMdbf48ASeJlJ/hkKEgsWvBoLJDOrCGAozuA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838325; c=relaxed/simple;
	bh=SkbPOsFtvQnZzmKc/hFJiUPhgwwawwbAQ80Gtz5bkT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrDnX5UraLG7ESr4DbBUeWdnzS1Lglb3PrW+wSLMJdZ3hRMZB6iPUcCv4y/wYsftWTxnsY6fSHFc2KKBHHuQVwAneA6qNee/b+pJUI/Doo+sF6WOJtD/H9ZONLO42tUv5iX3wRnvc0wRN/+ICkmWsx7ZRECWmitZ7PhtsZDvutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp78t1738838304t6u5w6cy
X-QQ-Originating-IP: H3o0k05BnX2OJLCsfw47/j+VvR/RcBN4vYmB1w8xmAA=
Received: from localhost.localdomain ( [125.120.70.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Feb 2025 18:38:21 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16183069787602700386
From: mengyuanlou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v7 1/6] net: libwx: Add malibox api for wangxun pf drivers
Date: Thu,  6 Feb 2025 18:37:45 +0800
Message-Id: <20250206103750.36064-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250206103750.36064-1-mengyuanlou@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M5znx2hx04lbFEPyYhiRbQpgPQdw6vXC9FvKcr/9/9Q5EL0G6m2uh2ru
	KiLpjOE14o8JuwCFU+AIVNRnM2C1qJaGtmnpfZwz3RpUW1lEGOpV1WbwmEr5GDxBssa+wh4
	TFvjPW8pPF1719ddSoisiLgrCscx33KqRQHDXeiOcMT9Pz7zwcB206rOMdZKUTr5nyMvFrP
	Qd6ElvdyMArk9azUjj+9dvIvcLooGwZwsozmnnKud2A3OWkjJpLDhGRsooJJFmlFTxCEhkO
	3CmJPcDKr0LcABHQ9mA2icVnaTh6Oi7jstnO+giQF8yRVKOfD/qxFG+Nvc3FisvEf5JwlV1
	aCQN5EkLDagJ6ej2NVoK7GyyF59d42Te0yX59hq7q3QNvZgIuOpsA3OdlGE/nh3H/3fMkmG
	Crz2YGfeRoq2kz7+TiZOjDINqEEPGPcN3o2cqcdftcpGx9AIAW9gUELIJmS5BTdirz1BmmY
	Gc6QQGaq1GPEvAiNXkdSMJ+XSHWOnUsCD0skF1p5XadGFup5fUH1SQxg37fcGYG83Nobttb
	Uh1LM6K+vUaAB4MHG28RRLR/wqyKSStQlsbhP+P9dL+DvZA8AgV4Iz2y9ZYa1cugs0HvznR
	jq5GNnxQLujxaZZnAxTRkPaONujQTDLUMnQjg4PMHL1HaVrxuKNpHQ4IsCcrVULMfNEsElZ
	XqjSRMXeAJwXw/lbq8mHNJIpPPRxCeGU705y6w1gXOEimxzHeenqZYENGp4YmgHlN4LhgWQ
	6yO1+YVvK5Rpi98dnLU/6JdlgOwi9c4jqcuPUMnBfooPeCYLxysSJ0h2Cz3VvEmP2DB9BAQ
	ipWdbMvrP64vLIN1QODL12zFS7c4PcUIwvig41qFD/WmOsZOySPsRbY9rtOA/L+Rr7nROby
	SJWEdZQHHBGum+eZKRiMWEx/5dFSzZfDbcJDriv3HDv1H3erA9ZAzDY9c7C9l8Ufu5//jQj
	Mi+fOKW8yMrC8VbPz11rBTBSSY+8lvfCTs9gt2fjtgo2epMtBQh4kXXmM1RGtEz+QcAFF1a
	dlbJ1WQu26ztpOVfmdBAvz3oQdqYg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

From: Mengyuan Lou <mengyuanlou@net-swift.com>

Implements the mailbox interfaces for wangxun pf drivers
ngbe and txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 176 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   8 +
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 42ccd6e4052e..913a978c9032 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
new file mode 100644
index 000000000000..73af5f11c3bd
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/pci.h>
+#include "wx_type.h"
+#include "wx_mbx.h"
+
+/**
+ *  wx_obtain_mbx_lock_pf - obtain mailbox lock
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+static int wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf)
+{
+	int count = 5;
+	u32 mailbox;
+
+	while (count--) {
+		/* Take ownership of the buffer */
+		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
+
+		/* reserve mailbox for vf use */
+		mailbox = rd32(wx, WX_PXMAILBOX(vf));
+		if (mailbox & WX_PXMAILBOX_PFU)
+			return 0;
+		else if (count)
+			udelay(10);
+	}
+	wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);
+
+	return -EBUSY;
+}
+
+static int wx_check_for_bit_pf(struct wx *wx, u32 mask, int index)
+{
+	u32 mbvficr = rd32(wx, WX_MBVFICR(index));
+
+	if (!(mbvficr & mask))
+		return -EBUSY;
+	wr32(wx, WX_MBVFICR(index), mask);
+
+	return 0;
+}
+
+/**
+ *  wx_check_for_ack_pf - checks to see if the VF has acked
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 if the VF has set the status bit or else -EBUSY
+ **/
+int wx_check_for_ack_pf(struct wx *wx, u16 vf)
+{
+	u32 index = vf / 16, vf_bit = vf % 16;
+
+	return wx_check_for_bit_pf(wx,
+				   FIELD_PREP(WX_MBVFICR_VFACK_MASK,
+					      BIT(vf_bit)),
+				   index);
+}
+
+/**
+ *  wx_check_for_msg_pf - checks to see if the VF has sent mail
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 if the VF has got req bit or else -EBUSY
+ **/
+int wx_check_for_msg_pf(struct wx *wx, u16 vf)
+{
+	u32 index = vf / 16, vf_bit = vf % 16;
+
+	return wx_check_for_bit_pf(wx,
+				   FIELD_PREP(WX_MBVFICR_VFREQ_MASK,
+					      BIT(vf_bit)),
+				   index);
+}
+
+/**
+ *  wx_write_mbx_pf - Places a message in the mailbox
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EINVAL/-EBUSY on failure
+ **/
+int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	int ret, i;
+
+	/* mbx->size is up to 15 */
+	if (size > mbx->size) {
+		wx_err(wx, "Invalid mailbox message size %d", size);
+		return -EINVAL;
+	}
+
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret = wx_obtain_mbx_lock_pf(wx, vf);
+	if (ret)
+		return ret;
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	wx_check_for_msg_pf(wx, vf);
+	wx_check_for_ack_pf(wx, vf);
+
+	/* copy the caller specified message to the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		wr32a(wx, WX_PXMBMEM(vf), i, msg[i]);
+
+	/* Interrupt VF to tell it a message has been sent and release buffer */
+	/* set mirrored mailbox flags */
+	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_STS);
+	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_STS);
+
+	return 0;
+}
+
+/**
+ *  wx_read_mbx_pf - Read a message from the mailbox
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	int ret;
+	u16 i;
+
+	/* limit read to size of mailbox and mbx->size is up to 15 */
+	if (size > mbx->size)
+		size = mbx->size;
+
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret = wx_obtain_mbx_lock_pf(wx, vf);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size; i++)
+		msg[i] = rd32a(wx, WX_PXMBMEM(vf), i);
+
+	/* Acknowledge the message and release buffer */
+	/* set mirrored mailbox flags */
+	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_ACK);
+	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_ACK);
+
+	return 0;
+}
+
+/**
+ *  wx_check_for_rst_pf - checks to see if the VF has reset
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+int wx_check_for_rst_pf(struct wx *wx, u16 vf)
+{
+	u32 reg_offset = WX_VF_REG_OFFSET(vf);
+	u32 vf_shift = WX_VF_IND_SHIFT(vf);
+	u32 vflre = 0;
+
+	vflre = rd32(wx, WX_VFLRE(reg_offset));
+	if (!(vflre & BIT(vf_shift)))
+		return -EBUSY;
+	wr32(wx, WX_VFLREC(reg_offset), BIT(vf_shift));
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
new file mode 100644
index 000000000000..c09b25f3e43d
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+#ifndef _WX_MBX_H_
+#define _WX_MBX_H_
+
+#define WX_VXMAILBOX_SIZE    15
+
+/* PF Registers */
+#define WX_PXMAILBOX(i)      (0x600 + (4 * (i))) /* i=[0,63] */
+#define WX_PXMAILBOX_STS     BIT(0) /* Initiate message send to VF */
+#define WX_PXMAILBOX_ACK     BIT(1) /* Ack message recv'd from VF */
+#define WX_PXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
+
+#define WX_PXMBMEM(i)        (0x5000 + (64 * (i))) /* i=[0,63] */
+
+#define WX_VFLRE(i)          (0x4A0 + (4 * (i))) /* i=[0,1] */
+#define WX_VFLREC(i)         (0x4A8 + (4 * (i))) /* i=[0,1] */
+
+/* SR-IOV specific macros */
+#define WX_MBVFICR(i)         (0x480 + (4 * (i))) /* i=[0,3] */
+#define WX_MBVFICR_VFREQ_MASK GENMASK(15, 0)
+#define WX_MBVFICR_VFACK_MASK GENMASK(31, 16)
+
+#define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
+
+int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
+int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
+int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
+int wx_check_for_msg_pf(struct wx *wx, u16 mbx_id);
+int wx_check_for_ack_pf(struct wx *wx, u16 mbx_id);
+
+#endif /* _WX_MBX_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b54bffda027b..5dce136c98bd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -20,6 +20,9 @@
 #define WX_PCI_LINK_STATUS                      0xB2
 
 /**************** Global Registers ****************************/
+#define WX_VF_REG_OFFSET(_v)         ((_v) >> 5)
+#define WX_VF_IND_SHIFT(_v)          ((_v) & 0x1f)
+
 /* chip control Registers */
 #define WX_MIS_PWR                   0x10000
 #define WX_MIS_RST                   0x1000C
@@ -707,6 +710,10 @@ struct wx_bus_info {
 	u16 device;
 };
 
+struct wx_mbx_info {
+	u16 size;
+};
+
 struct wx_thermal_sensor_data {
 	s16 temp;
 	s16 alarm_thresh;
@@ -1046,6 +1053,7 @@ struct wx {
 	struct pci_dev *pdev;
 	struct net_device *netdev;
 	struct wx_bus_info bus;
+	struct wx_mbx_info mbx;
 	struct wx_mac_info mac;
 	enum em_mac_type mac_type;
 	enum sp_media_type media_type;
-- 
2.30.1 (Apple Git-130)


