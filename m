Return-Path: <netdev+bounces-96516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C532E8C64CA
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F4C1F23409
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A595B5B6;
	Wed, 15 May 2024 10:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AC5A0F8
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767751; cv=none; b=G8Xp/RylmDcUODyW+8/WDQNNLI+RVh+rmaDJ6ncvrGqbZWnAXMwhftn7MX6x++/VjrBe3zUJJzuRssjPj0mA6kRwdJCvEGKEhW6bhM76zo+yzjpypcX+3us4NzVio5W4mdPE2StzPMHmNch2L4PHSgkVtZhmu6DnofessUJZ8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767751; c=relaxed/simple;
	bh=5yo6OVv1estZvfaTiJ898X7nfzsC8QtzQYrWaSBMMqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3WQC0yilW/7WtsUBL3MY0nOPmMSnNcULtXjESAs+k3iQyg5YVTneyMljkdF1EGS08lMS0vhhicJ01P1bvMMoy9GL8ib4NqClIxFG6ZRaeiEGQMNb9RVA8naNVPyD6BJPDiXAS89Py0f0ndvWvNBtaVP9hX8DXenhHwYqYSpHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp80t1715767726tgq7xbn3
X-QQ-Originating-IP: O8pDezD814XHH1vW3bCi3yL4JmETrvuqc6PwPdL0q4g=
Received: from localhost.localdomain ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 May 2024 18:08:43 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: KdN0SWBFoH6e17zNBD/6iU5hEs6RrgJICBicvgK+XGcRq89BctfZJcCkTpZZw
	FDIQJvxNRFBBDQtJi8rdRNDacdQfH39HAu69uiRlNIRigweA8dzF4Fl4G3V5qHQV/a5uN5A
	1lEndFgSl90jmcV/FMtd12bI0jmLGrskp5DyeUh5ItnE2FgEo8gC8yMV11sjPKhv+EFIl8E
	MgQaPnENo4miKJyLQENtxp0r2qX0grK9Gu54Ji0/wlRCORDWaMAGSZytHZPQjh1v/OsjktT
	8fO0fZg+LyI1AF55g6om20Kyv9JUfZ1UFJsG//Lzf1kG7+dF6+k69URHc0x4Fwec0vx4Aaq
	bglxmDJWfSUKGx1zLa/NaozLq+htKVw2SxyXV9yJ9RlpsRFl60NeOF+rR3KNyXNdfunTjYy
	FgRISPoxqGxvkdu0kFarB3KX8t0zG/Wj
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8321308435623724875
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 1/6] net: libwx: Add malibox api for wangxun pf drivers
Date: Wed, 15 May 2024 17:50:04 +0800
Message-ID: <E46F2D38B2634039+20240515100830.32920-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515100830.32920-1-mengyuanlou@net-swift.com>
References: <20240515100830.32920-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Implements the mailbox interfaces for wangxun pf drivers
ngbe and txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 191 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   5 +
 4 files changed, 229 insertions(+), 1 deletion(-)
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
index 000000000000..26842043630b
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+#include <linux/pci.h>
+#include "wx_type.h"
+#include "wx_mbx.h"
+
+/**
+ *  wx_obtain_mbx_lock_pf - obtain mailbox lock
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  return SUCCESS if we obtained the mailbox lock
+ **/
+static int wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf)
+{
+	int ret = -EBUSY;
+	int count = 5;
+	u32 mailbox;
+
+	while (count--) {
+		/* Take ownership of the buffer */
+		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
+
+		/* reserve mailbox for vf use */
+		mailbox = rd32(wx, WX_PXMAILBOX(vf));
+		if (mailbox & WX_PXMAILBOX_PFU) {
+			ret = 0;
+			break;
+		}
+		udelay(10);
+	}
+
+	if (ret)
+		wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);
+
+	return ret;
+}
+
+static int wx_check_for_bit_pf(struct wx *wx, u32 mask, int index)
+{
+	u32 mbvficr = rd32(wx, WX_MBVFICR(index));
+	int ret = -EBUSY;
+
+	if (mbvficr & mask) {
+		ret = 0;
+		wr32(wx, WX_MBVFICR(index), mask);
+	}
+
+	return ret;
+}
+
+/**
+ *  wx_check_for_ack_pf - checks to see if the VF has ACKed
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  returns SUCCESS if the VF has set the Status bit or else ERR_MBX
+ **/
+int wx_check_for_ack_pf(struct wx *wx, u16 vf)
+{
+	u32 index = vf / 16, vf_bit = vf % 16;
+
+	return wx_check_for_bit_pf(wx,
+				   FIELD_PREP(WX_MBVFICR_VFACK_MASK, BIT(vf_bit)),
+				   index);
+}
+EXPORT_SYMBOL(wx_check_for_ack_pf);
+
+/**
+ *  wx_check_for_msg_pf - checks to see if the VF has sent mail
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  returns SUCCESS if the VF has set the Status bit or else ERR_MBX
+ **/
+int wx_check_for_msg_pf(struct wx *wx, u16 vf)
+{
+	u32 index = vf / 16, vf_bit = vf % 16;
+
+	return wx_check_for_bit_pf(wx,
+				   FIELD_PREP(WX_MBVFICR_VFREQ_MASK, BIT(vf_bit)),
+				   index);
+}
+EXPORT_SYMBOL(wx_check_for_msg_pf);
+
+/**
+ *  wx_write_mbx_pf - Places a message in the mailbox
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @vf: the VF index
+ *
+ *  returns SUCCESS if it successfully copied message into the buffer
+ **/
+int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	int ret, i;
+
+	if (size > mbx->size) {
+		wx_err(wx, "Invalid mailbox message size %d", size);
+		ret = -EINVAL;
+		goto out_no_write;
+	}
+
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret = wx_obtain_mbx_lock_pf(wx, vf);
+	if (ret)
+		goto out_no_write;
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	wx_check_for_msg_pf(wx, vf);
+	wx_check_for_ack_pf(wx, vf);
+
+	/* copy the caller specified message to the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		wr32a(wx, WX_PXMBMEM(vf), i, msg[i]);
+
+	/* Interrupt VF to tell it a message has been sent and release buffer*/
+	/* set mirrored mailbox flags */
+	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_STS);
+	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_STS);
+
+out_no_write:
+	return ret;
+}
+EXPORT_SYMBOL(wx_write_mbx_pf);
+
+/**
+ *  wx_read_mbx_pf - Read a message from the mailbox
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @vf: the VF index
+ *
+ *  This function copies a message from the mailbox buffer to the caller's
+ *  memory buffer.  The presumption is that the caller knows that there was
+ *  a message due to a VF request so no polling for message is needed.
+ **/
+int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	int ret;
+	u16 i;
+
+	/* limit read to size of mailbox */
+	if (size > mbx->size)
+		size = mbx->size;
+
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret = wx_obtain_mbx_lock_pf(wx, vf);
+	if (ret)
+		goto out_no_read;
+
+	/* copy the message to the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		msg[i] = rd32a(wx, WX_PXMBMEM(vf), i);
+
+	/* Acknowledge the message and release buffer */
+	/* set mirrored mailbox flags */
+	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_ACK);
+	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_ACK);
+out_no_read:
+	return ret;
+}
+EXPORT_SYMBOL(wx_read_mbx_pf);
+
+/**
+ *  wx_check_for_rst_pf - checks to see if the VF has reset
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  returns SUCCESS if the VF has set the Status bit or else ERR_MBX
+ **/
+int wx_check_for_rst_pf(struct wx *wx, u16 vf)
+{
+	u32 reg_offset = vf / 32;
+	u32 vf_shift = vf % 32;
+	int ret = -EBUSY;
+	u32 vflre = 0;
+
+	vflre = rd32(wx, WX_VFLRE(reg_offset));
+
+	if (vflre & BIT(vf_shift)) {
+		ret = 0;
+		wr32(wx, WX_VFLREC(reg_offset), BIT(vf_shift));
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(wx_check_for_rst_pf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
new file mode 100644
index 000000000000..1579096fb6ad
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
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
index 1fdeb464d5f4..f29ac955dc83 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -674,6 +674,10 @@ struct wx_bus_info {
 	u16 device;
 };
 
+struct wx_mbx_info {
+	u16 size;
+};
+
 struct wx_thermal_sensor_data {
 	s16 temp;
 	s16 alarm_thresh;
@@ -990,6 +994,7 @@ struct wx {
 	struct pci_dev *pdev;
 	struct net_device *netdev;
 	struct wx_bus_info bus;
+	struct wx_mbx_info mbx;
 	struct wx_mac_info mac;
 	enum em_mac_type mac_type;
 	enum sp_media_type media_type;
-- 
2.43.2


