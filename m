Return-Path: <netdev+bounces-98918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBC8D3200
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C101F28D52
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8917B407;
	Wed, 29 May 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TUyrrAND"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25E16A373;
	Wed, 29 May 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972177; cv=none; b=CCH9AZWPVs5BKT2YzGsknreoGVwibRI0kzMZD7S7UdLisOTbHS1Zh6WlRoli5T4vdeIRqWWtmc3VBtQJBsyLdBbQKrk7NaW0jtLy6554Fagh16+CywPjgm6mZQaJg6qKM2wZadHndIrnCb38vNc+w2tG4Pw9GvF5zFl/wsRPc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972177; c=relaxed/simple;
	bh=UttgDv4ZvHmM/LW7Dna1NBBwdOyajLEoGI2LDKlrcDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGofrwmA6QHEjrb9WMiGb6unQQDif7i3DclBZKCg+172HfHiYNzyPYUpaoB8x7AiUBTVHUNqh6EnmNrzh10K5t/9/oTQiRw35sPUTLqF/N7UBRPhE7qV8LAGV7sZCTwq8/Ry45o61eg13Wes26iSnNbm+Lr+Y2qH3uC7zMBnmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TUyrrAND; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 69e15b401d9711ef8c37dd7afa272265-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L5mnDnxKJTtj3CGwQCmR4dTFQpwgrDUEnU07dWK/S6I=;
	b=TUyrrANDiVkKdSiXTMbQYLoWcd0/ZUc2UtRCGiH/g4ctsPUIiB1A30HA//5Fu/ie8LAoLVmBTnwIKT/8YO1emmTN76i/O+Vw0HgFmygGfrK90/jRJ9x+GEHCWjKWlGIxOwhV8gr2u9orbzsgH64fTl0wCmFvJsDk1J48u7aCHxk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:39fcab0d-7aad-4e7b-9443-6a68b60c1c89,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:393d96e,CLOUDID:071cf587-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 69e15b401d9711ef8c37dd7afa272265-20240529
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 676104047; Wed, 29 May 2024 16:42:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 16:42:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 16:42:40 +0800
From: Liju-clr Chen <liju-clr.chen@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Catalin Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Richard Cochran <richardcochran@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liju-clr Chen
	<Liju-clr.Chen@mediatek.com>, Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>,
	Ze-yu Wang <Ze-yu.Wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>, Chi-shen Yeh
	<Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: [PATCH v11 05/21] virt: geniezone: Add vm support
Date: Wed, 29 May 2024 16:42:23 +0800
Message-ID: <20240529084239.11478-6-liju-clr.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240529084239.11478-1-liju-clr.chen@mediatek.com>
References: <20240529084239.11478-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.523800-8.000000
X-TMASE-MatchedRID: Jz4HHHAzncYlUAqjdiICKBn0UD4GU5IqQBnqdxuJ5SCY5NBG7YIbVw2C
	UGzZxN2d8AyWk2NFMNbVL7DIQyVd754dOTBCL+zXA9lly13c/gEW40XiUkbrGz/90OQ2nJ+7a9e
	9JE2KBN0Z7JX1lkS/Bd9D3868BaEcIiy3Pxq6O+FHQFjzAbvJEPi4nVERfgwdNa1ImygeaAtVJ0
	ADqZV4huT03QcW1KNjgmX+NobYg68I1Z5Xryf06B3EEAbn+GRbvJ9Xvh5CmT5UjspoiX02FwaTa
	lM8C773wvUxdKBGcQx+QQJwTYOt8oALX2fTNBeIGVyS87Wb4lzylcnpAborusOtrkhuZC9Wmzbo
	lkqUskbUfMJPpS3KKKCX8ek9LY/nuyXwa/V5eQrYxkZC4pzxSA1D0DXwcgIhycmFNidOeD2RbGV
	jAxwIe8R8uH5v1UzhgDLqnrRlXrZ8nn9tnqel2MprJP8FBOIaA/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.523800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6FC205CBFE095F2539E8505C476D863CB304EE2DE94366D53E8DEA33D67ED5732000:8
X-MTK: N

From: Yi-De Wu <yi-de.wu@mediatek.com>

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

The VM component is responsible for setting up the capability and memory
management for the protected VMs. The capability is mainly about the
lifecycle control and boot context initialization.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 MAINTAINERS                             |   1 +
 arch/arm64/geniezone/gzvm_arch_common.h |   4 +
 arch/arm64/geniezone/vm.c               |  27 ++++++
 drivers/virt/geniezone/Makefile         |   2 +-
 drivers/virt/geniezone/gzvm_main.c      |  16 ++++
 drivers/virt/geniezone/gzvm_vm.c        | 107 ++++++++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  27 ++++++
 include/uapi/linux/gzvm.h               |  25 ++++++
 8 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/geniezone/gzvm_vm.c
 create mode 100644 include/uapi/linux/gzvm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index db6ba2f1e3ba..671b09087b90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9279,6 +9279,7 @@ F:	Documentation/virt/geniezone/
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
index dce933f0c122..8ee5490d604a 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
+#include <linux/gzvm.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
 #include "gzvm_arch_common.h"
 
@@ -61,3 +62,29 @@ int gzvm_arch_probe(void)
 
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
index efd42b5ab871..8704549c5956 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/file.h>
 #include <linux/kdev_t.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -40,7 +41,21 @@ int gzvm_err_to_errno(unsigned long err)
 	return -EINVAL;
 }
 
+static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long user_args)
+{
+	switch (cmd) {
+	case GZVM_CREATE_VM:
+		return gzvm_dev_ioctl_create_vm(user_args);
+	default:
+		break;
+	}
+
+	return -ENOTTY;
+}
+
 static const struct file_operations gzvm_chardev_ops = {
+	.unlocked_ioctl = gzvm_dev_ioctl,
 	.llseek		= noop_llseek,
 };
 
@@ -62,6 +77,7 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 
 static int gzvm_drv_remove(struct platform_device *pdev)
 {
+	gzvm_destroy_all_vms();
 	misc_deregister(&gzvm_dev);
 	return 0;
 }
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
new file mode 100644
index 000000000000..76722dba6b1f
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -0,0 +1,107 @@
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
+	.llseek		= noop_llseek,
+};
+
+static struct gzvm *gzvm_create_vm(unsigned long vm_type)
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
+ * @vm_type: VM type. Only supports Linux VM now.
+ *
+ * Return: fd of vm, negative if error
+ */
+int gzvm_dev_ioctl_create_vm(unsigned long vm_type)
+{
+	struct gzvm *gzvm;
+
+	gzvm = gzvm_create_vm(vm_type);
+	if (IS_ERR(gzvm))
+		return PTR_ERR(gzvm);
+
+	return anon_inode_getfd("gzvm-vm", &gzvm_vm_fops, gzvm,
+			       O_RDWR | O_CLOEXEC);
+}
+
+void gzvm_destroy_all_vms(void)
+{
+	struct gzvm *gzvm, *tmp;
+
+	mutex_lock(&gzvm_list_lock);
+	if (list_empty(&gzvm_list))
+		goto out;
+
+	list_for_each_entry_safe(gzvm, tmp, &gzvm_list, vm_list)
+		gzvm_destroy_vm(gzvm);
+
+out:
+	mutex_unlock(&gzvm_list_lock);
+}
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 907f2f984de9..e7c29c826a7c 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -6,6 +6,12 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/gzvm.h>
+
+#define INVALID_VM_ID   0xffff
+
 /*
  * These are the definitions of APIs between GenieZone hypervisor and driver,
  * there's no need to be visible to uapi. Furthermore, we need GenieZone
@@ -17,9 +23,30 @@
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
 
+/**
+ * struct gzvm: the following data structures are for data transferring between
+ * driver and hypervisor, and they're aligned with hypervisor definitions.
+ * @mm: userspace tied to this vm
+ * @lock: lock for list_add
+ * @vm_list: list head for vm list
+ * @vm_id: vm id
+ */
+struct gzvm {
+	struct mm_struct *mm;
+	struct mutex lock;
+	struct list_head vm_list;
+	u16 vm_id;
+};
+
+int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
+
 int gzvm_err_to_errno(unsigned long err);
 
+void gzvm_destroy_all_vms(void);
+
 /* arch-dependant functions */
 int gzvm_arch_probe(void);
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


