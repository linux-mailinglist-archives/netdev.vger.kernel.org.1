Return-Path: <netdev+bounces-78339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6713874BBB
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD46284CF2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772912E1CE;
	Thu,  7 Mar 2024 09:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3D12DDBA
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805502; cv=none; b=pvYVnUIZVdJI5LX9Sb0WpeLifTZ+Y0UjI88sfsDXjJJgJsBghShGwJmnKN39cjPIEl4gAPsp23JC8XqfSQ8nSDLFiz1/5l0R/wfAG1HCHu7rJxe6AL0AR69ZpNF6o84jZC1TaBGoFQK+XSF6ua2y5PCmY9JSshv4XUPfmJjfgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805502; c=relaxed/simple;
	bh=V9Rr6Gc2pbbT5zxly+s8wTRJCd2KQ605pkUrv4ZHcXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPX+ISPPGjGebBtmPN4dhFowqMwGT/g/9rdnm8eVNxb2ZYgR0PsdWbTygJ0z+iQkBYugIdneMrYlED2bBuGm0zDwRm3+PtW2dpD+aPMDl4hA0AdqGx8b2IEst8bczLoMoiTIeYfPTbtGGFb2yfmdfXS+Ner96CWEZbfQkQN3Wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp87t1709805490tyjc4amb
X-QQ-Originating-IP: IxSdGpTnimiEyeqxDzkKC+VzmZ0hsBZ4eO3CU0CaV2U=
Received: from localhost.localdomain ( [220.184.149.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Mar 2024 17:58:07 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3iYAbLwN9Dh+4Nj3puEZb1QjwYl0rOnr4AM6vXh3ukFH8rkLKjJl
	3Wyl11N1YNQaZ5/kIpFjDry9JApEoT+89N4vCeWc4HGoMGoAFOQ2aK4u86+lOSZgwwQgiu1
	VrLD7Q0tvoghuAcLEeLB4dNtD8qlrPk5yKywW+guRI9WJxFvWZWVVWdIbZX9TF8O+o8TRsB
	sGGd0XVpSP+lW3H++6yRKeoQeuWU0qw5CJsERObs9gMiF7Lne3CUk+o+7+GrgCU3hbVSqLn
	YdDSpV3D4nN3X1KGXAko15e2D2+Vc7RUvpmp0jEMUABgPeo3NoTj9twvhAD5V4LSwSkxKEU
	EhrH33QYPX6qJcM0BZz6qIQrhUugs1211pR3USz2x62avRk7z3bbKj79uF4WO3uiswrBsWA
	a4aPNTmNg3JZ2oKg9+evSg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7220772377016688785
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 1/5] net: libwx: Add malibox api for wangxun pf drivers
Date: Thu,  7 Mar 2024 17:54:56 +0800
Message-ID: <0402EBB760793D47+20240307095755.7130-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307095755.7130-1-mengyuanlou@net-swift.com>
References: <20240307095755.7130-1-mengyuanlou@net-swift.com>
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
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 190 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   5 +
 4 files changed, 228 insertions(+), 1 deletion(-)
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
index 000000000000..5fbde79a5937
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
@@ -0,0 +1,190 @@
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
+	int count = 10;
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


