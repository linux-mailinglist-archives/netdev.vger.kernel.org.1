Return-Path: <netdev+bounces-144784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3749C8762
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8122B2664A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D551F8F04;
	Thu, 14 Nov 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QWl/y8gX"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBCD1F708C;
	Thu, 14 Nov 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578898; cv=none; b=cGn8SDp0NAN/g0ERtBPbR419yznuyj7r39SV1I+AnktgvqKFXyrLKLBJVWoOmBpMY0CvC0ZoGan2T4rwoG4n9QjNp2reqDv5eNeayuxtPjy8zLf85L7PqUgx3gTfZ4xa5mLxLgYSK4Jlcqfu8r5FM7yAffnyThU3BmPFdQkxMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578898; c=relaxed/simple;
	bh=vBEw1tJsCF2b9Wp56GZyAuzgdD628y71avP43YUkkEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2J7yepbiI0WpDEClrK5Ha0bHNCOc3wMQVIRrLYCRkB95AmV8nu1PdY01AlezDHtEqn7G+zCH24PNlZF862ExNIWL3ppAOWYba0PDmg4Zd9AON595yMwb04aEQKrhFjGda0psC/dby1PF0/6OlxNmSg/kU2ck7cLx4pB7P5UVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QWl/y8gX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 565805aca27011ef99858b75a2457dd9-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GONwmY7pvPVHwGJga8ZRaLBO74qwe7MnnfV4NItAYII=;
	b=QWl/y8gXzIZDYfxtdF5TZNO8MBozI+m2ne4xZxkuvvSlbNcJuL0vn3DwVoJ1aWeI1JFV6kE0777QiaaXTqNpt0LrJmiCX2babYbHcVh1lAAJcDmJaIQuyk71HPHYznFb7WLMPTRaIes/uZ9PegKBfxOAsfj80G7/E2Sn98yYt1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:0ad5a781-e0d3-4141-a329-d4941aa45d75,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:bf6b1307-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 565805aca27011ef99858b75a2457dd9-20241114
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 195652705; Thu, 14 Nov 2024 18:08:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:03 +0800
From: Liju-clr Chen <liju-clr.chen@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Richard Cochran
	<richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liju-clr Chen <Liju-clr.Chen@mediatek.com>, Yingshiuan Pan
	<Yingshiuan.Pan@mediatek.com>, Ze-yu Wang <Ze-yu.Wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>, Chi-shen Yeh
	<Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: [PATCH v13 05/25] virt: geniezone: Add vm support
Date: Thu, 14 Nov 2024 18:07:42 +0800
Message-ID: <20241114100802.4116-6-liju-clr.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
References: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>

The VM component is responsible for setting up the capability and memory
management for the protected VMs. The capability is mainly about the
lifecycle control and boot context initialization.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Co-developed-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 MAINTAINERS                             |  1 +
 arch/arm64/geniezone/gzvm_arch_common.h |  4 ++
 arch/arm64/geniezone/vm.c               | 27 +++++++
 drivers/virt/geniezone/Makefile         |  2 +-
 drivers/virt/geniezone/gzvm_main.c      | 15 ++++
 drivers/virt/geniezone/gzvm_vm.c        | 93 +++++++++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   | 29 ++++++++
 include/uapi/linux/gzvm.h               | 25 +++++++
 8 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/geniezone/gzvm_vm.c
 create mode 100644 include/uapi/linux/gzvm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 708c13103ec5..e7fd6f6a4350 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9680,6 +9680,7 @@ F:	Documentation/virt/geniezone/
 F:	arch/arm64/geniezone/
 F:	drivers/virt/geniezone/
 F:	include/linux/soc/mediatek/gzvm_drv.h
+F:	include/uapi/linux/gzvm.h
 
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 660c7cf3fc18..60ee5ed2b39f 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -9,6 +9,8 @@
 #include <linux/arm-smccc.h>
 
 enum {
+	GZVM_FUNC_CREATE_VM = 0,
+	GZVM_FUNC_DESTROY_VM = 1,
 	GZVM_FUNC_PROBE = 12,
 	NR_GZVM_FUNC,
 };
@@ -19,6 +21,8 @@ enum {
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,	\
 			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
 
+#define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
+#define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 
 /**
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index daad21b28f6f..8e3c9f872bb1 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
+#include <linux/gzvm.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
 #include "gzvm_arch_common.h"
 
@@ -70,3 +71,29 @@ int gzvm_arch_probe(struct gzvm_version drv_version,
 
 	return 0;
 }
+
+/**
+ * gzvm_arch_create_vm() - create vm
+ * @vm_type: VM type. Only supports Linux VM now.
+ *
+ * Return:
+ * * positive value	- VM ID
+ * * -ENOMEM		- Memory not enough for storing VM data
+ */
+int gzvm_arch_create_vm(unsigned long vm_type)
+{
+	struct arm_smccc_res res;
+	int ret;
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VM, vm_type, 0, 0, 0, 0,
+				   0, 0, &res);
+	return ret ? ret : res.a1;
+}
+
+int gzvm_arch_destroy_vm(u16 vm_id)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0,
+				    0, 0, &res);
+}
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 3a82e5fddf90..25614ea3dea2 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -6,4 +6,4 @@
 
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
-gzvm-y := $(GZVM_DIR)/gzvm_main.o
+gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index dc91fd61ba75..02dec63ce48f 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/file.h>
 #include <linux/kdev_t.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -48,6 +49,19 @@ int gzvm_err_to_errno(unsigned long err)
 	return -EINVAL;
 }
 
+static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long user_args)
+{
+	switch (cmd) {
+	case GZVM_CREATE_VM:
+		return gzvm_dev_ioctl_create_vm(&gzvm_drv, user_args);
+	default:
+		break;
+	}
+
+	return -ENOTTY;
+}
+
 static int gzvm_dev_open(struct inode *inode, struct file *file)
 {
 	/*
@@ -65,6 +79,7 @@ static int gzvm_dev_release(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations gzvm_chardev_ops = {
+	.unlocked_ioctl = gzvm_dev_ioctl,
 	.llseek		= noop_llseek,
 	.open		= gzvm_dev_open,
 	.release	= gzvm_dev_release,
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
new file mode 100644
index 000000000000..500bc8276d60
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/kdev_t.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/soc/mediatek/gzvm_drv.h>
+
+static DEFINE_MUTEX(gzvm_list_lock);
+static LIST_HEAD(gzvm_list);
+
+static void gzvm_destroy_vm(struct gzvm *gzvm)
+{
+	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
+
+	mutex_lock(&gzvm->lock);
+
+	gzvm_arch_destroy_vm(gzvm->vm_id);
+
+	mutex_lock(&gzvm_list_lock);
+	list_del(&gzvm->vm_list);
+	mutex_unlock(&gzvm_list_lock);
+
+	mutex_unlock(&gzvm->lock);
+
+	kfree(gzvm);
+}
+
+static int gzvm_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gzvm *gzvm = filp->private_data;
+
+	gzvm_destroy_vm(gzvm);
+	return 0;
+}
+
+static const struct file_operations gzvm_vm_fops = {
+	.release        = gzvm_vm_release,
+};
+
+static struct gzvm *gzvm_create_vm(struct gzvm_driver *drv, unsigned long vm_type)
+{
+	int ret;
+	struct gzvm *gzvm;
+
+	gzvm = kzalloc(sizeof(*gzvm), GFP_KERNEL);
+	if (!gzvm)
+		return ERR_PTR(-ENOMEM);
+
+	ret = gzvm_arch_create_vm(vm_type);
+	if (ret < 0) {
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
+
+	gzvm->gzvm_drv = drv;
+	gzvm->vm_id = ret;
+	gzvm->mm = current->mm;
+	mutex_init(&gzvm->lock);
+
+	mutex_lock(&gzvm_list_lock);
+	list_add(&gzvm->vm_list, &gzvm_list);
+	mutex_unlock(&gzvm_list_lock);
+
+	pr_debug("VM-%u is created\n", gzvm->vm_id);
+
+	return gzvm;
+}
+
+/**
+ * gzvm_dev_ioctl_create_vm - Create vm fd
+ * @vm_type: VM type. Only supports Linux VM now
+ * @drv: GenieZone driver info to be stored in struct gzvm for future usage
+ *
+ * Return: fd of vm, negative if error
+ */
+int gzvm_dev_ioctl_create_vm(struct gzvm_driver *drv, unsigned long vm_type)
+{
+	struct gzvm *gzvm;
+
+	gzvm = gzvm_create_vm(drv, vm_type);
+	if (IS_ERR(gzvm))
+		return PTR_ERR(gzvm);
+
+	return anon_inode_getfd("gzvm-vm", &gzvm_vm_fops, gzvm,
+			       O_RDWR | O_CLOEXEC);
+}
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 495bf5b8b8e0..70008afaaf61 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -6,6 +6,10 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/gzvm.h>
+
 /* GZVM version encode */
 #define GZVM_DRV_MAJOR_VERSION		16
 #define GZVM_DRV_MINOR_VERSION		0
@@ -21,6 +25,8 @@ struct gzvm_driver {
 	struct gzvm_version drv_version;
 };
 
+#define INVALID_VM_ID   0xffff
+
 /*
  * These are the definitions of APIs between GenieZone hypervisor and driver,
  * there's no need to be visible to uapi. Furthermore, we need GenieZone
@@ -32,10 +38,33 @@ struct gzvm_driver {
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
 
+/**
+ * struct gzvm: the following data structures are for data transferring between
+ * driver and hypervisor, and they're aligned with hypervisor definitions.
+ * @gzvm_drv: the data structure is used to keep driver's information
+ * @mm: userspace tied to this vm
+ * @lock: lock for list_add
+ * @vm_list: list head for vm list
+ * @vm_id: vm id
+ */
+struct gzvm {
+	struct gzvm_driver *gzvm_drv;
+	struct mm_struct *mm;
+	struct mutex lock;
+	struct list_head vm_list;
+	u16 vm_id;
+};
+
+int gzvm_dev_ioctl_create_vm(struct gzvm_driver *drv, unsigned long vm_type);
+
 int gzvm_err_to_errno(unsigned long err);
 
+void gzvm_destroy_all_vms(void);
+
 /* arch-dependant functions */
 int gzvm_arch_probe(struct gzvm_version drv_version,
 		    struct gzvm_version *hyp_version);
+int gzvm_arch_create_vm(unsigned long vm_type);
+int gzvm_arch_destroy_vm(u16 vm_id);
 
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
new file mode 100644
index 000000000000..c26c7720fab7
--- /dev/null
+++ b/include/uapi/linux/gzvm.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+/**
+ * DOC: UAPI of GenieZone Hypervisor
+ *
+ * This file declares common data structure shared among user space,
+ * kernel space, and GenieZone hypervisor.
+ */
+#ifndef __GZVM_H__
+#define __GZVM_H__
+
+#include <linux/const.h>
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* GZVM ioctls */
+#define GZVM_IOC_MAGIC			0x92	/* gz */
+
+/* ioctls for /dev/gzvm fds */
+#define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
+
+#endif /* __GZVM_H__ */
-- 
2.18.0


