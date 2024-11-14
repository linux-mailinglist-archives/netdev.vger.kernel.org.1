Return-Path: <netdev+bounces-144786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB99C86F2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FE1F21B7E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB91F9434;
	Thu, 14 Nov 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T0ExJK09"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC91F709C;
	Thu, 14 Nov 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578899; cv=none; b=fgaWDwP9FXi8kJg9gaqLBpNc/O8uBJDhDiAYx8DZIqa6f66SQ64cst46KB8t76SbY2uty3j3EbbkM2YJEbX/9ZfFbFBoUBuMWTjqJnu4AMyOoVf7u0BmMoBi0m6gh0skCq9JU+M/xU29MgN+5olwr+0QgwyoaJUFhwg8d4/BNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578899; c=relaxed/simple;
	bh=ppWa141RBzp+4xVKTTHSWtjnUrVY1afE9Qcv3MtiL2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtUds9pAs8KM+UaHmAVZp6GO0LdsRMATzE7A6vlssr4PowCrKwFQ3AB85WwOBNc9hUxO5Dkp71sGd4/lmthaOtLqgR3JaIt+1++8RI0Zp1c1XXNBkYc04t7YswsAhkwL6YjxNexfIaNNBKVvTo12RDTl6ucGQNEBHGfIubzmttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T0ExJK09; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58488954a27011efbd192953cf12861f-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pSFE6NnOIVxS5FA5GGo2UNMU8jZDgYiySjxlzLv3y7c=;
	b=T0ExJK099bBt7JiiAxj15xslb6W+0PDuk8Ki1Sz4cvGPByN97sWPZuaz7aZTN2HvdqlZEuiBXoSsE1q9BfCiPd9q/KlT1erfspX8+SFSiQBJ7fxYj2PR3DoA1Z3pAW6WkcHf+KRPRTCJX4c0VqCqaH9e2y2ioqv0SMnZaxGOOSc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:cf8dac3f-4acf-4b49-bd9c-7f00f873925d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:015f0c4f-a2ae-4b53-acd4-c3dc8f449198,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 58488954a27011efbd192953cf12861f-20241114
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 549886182; Thu, 14 Nov 2024 18:08:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 02:08:06 -0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:06 +0800
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
Subject: [PATCH v13 19/25] virt: geniezone: Provide individual VM memory statistics within debugfs
Date: Thu, 14 Nov 2024 18:07:56 +0800
Message-ID: <20241114100802.4116-20-liju-clr.chen@mediatek.com>
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

From: Jerry Wang <ze-yu.wang@mediatek.com>

Created a dedicated per-VM debugfs folder under gzvm, providing
user-level programs with easy access to per-VM memory statistics for
debugging and profiling purposes. This enables users to effectively
analyze and optimize the memory usage of individual virtual machines.

Two types of information can be obtained:

`cat /sys/kernel/debug/gzvm/<pid>-<vmid>/protected_hyp_mem` shows memory
used by the hypervisor and the size of the stage 2 table in bytes.

`cat /sys/kernel/debug/gzvm/<pid>-<vmid>/protected_shared_mem` gives
memory used by the shared resources of the guest and host in bytes.

For example:
console:/ # cat /sys/kernel/debug/gzvm/3417-15/protected_hyp_mem
180328
console:/ # cat /sys/kernel/debug/gzvm/3417-15/protected_shared_mem
262144
console:/ #

More stats will be added in the future.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               |  13 +++
 drivers/virt/geniezone/gzvm_main.c      |  25 ++++++
 drivers/virt/geniezone/gzvm_vm.c        | 115 ++++++++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  16 ++++
 5 files changed, 171 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 8a082ba808a4..192d023722e5 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -26,6 +26,7 @@ enum {
 	GZVM_FUNC_SET_DTB_CONFIG = 16,
 	GZVM_FUNC_MAP_GUEST = 17,
 	GZVM_FUNC_MAP_GUEST_BLOCK = 18,
+	GZVM_FUNC_GET_STATISTICS = 19,
 	NR_GZVM_FUNC,
 };
 
@@ -52,6 +53,7 @@ enum {
 #define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
 #define MT_HVC_GZVM_MAP_GUEST		GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST)
 #define MT_HVC_GZVM_MAP_GUEST_BLOCK	GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST_BLOCK)
+#define MT_HVC_GZVM_GET_STATISTICS	GZVM_HCALL_ID(GZVM_FUNC_GET_STATISTICS)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 91c6e4e2caf2..0350d9444c18 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -444,3 +444,16 @@ int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages)
 	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST_BLOCK, vm_id,
 				    memslot_id, gfn, nr_pages, 0, 0, 0, &res);
 }
+
+int gzvm_arch_get_statistics(struct gzvm *gzvm)
+{
+	struct arm_smccc_res res;
+	int ret;
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_GET_STATISTICS, gzvm->vm_id,
+				   0, 0, 0, 0, 0, 0, &res);
+
+	gzvm->stat.protected_hyp_mem = ((ret == 0) ? res.a1 : 0);
+	gzvm->stat.protected_shared_mem = ((ret == 0) ? res.a2 : 0);
+	return ret;
+}
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index c975912cd594..1816eecfcefb 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2023 MediaTek Inc.
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/file.h>
 #include <linux/kdev_t.h>
@@ -80,6 +81,25 @@ static void gzvm_drv_sysfs_exit(void)
 	kobject_del(gzvm_drv.sysfs_root_dir);
 }
 
+static int gzvm_drv_debug_init(void)
+{
+	if (!debugfs_initialized()) {
+		pr_warn("debugfs not initialized!\n");
+		return 0;
+	}
+
+	gzvm_drv.gzvm_debugfs_dir = debugfs_create_dir("gzvm", NULL);
+	if (!gzvm_drv.gzvm_debugfs_dir)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void gzvm_drv_debug_exit(void)
+{
+	debugfs_remove_recursive(gzvm_drv.gzvm_debugfs_dir);
+}
+
 /**
  * gzvm_err_to_errno() - Convert geniezone return value to standard errno
  *
@@ -221,6 +241,10 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = gzvm_drv_debug_init();
+	if (ret)
+		return ret;
+
 	ret = gzvm_drv_sysfs_init();
 	if (ret)
 		return ret;
@@ -236,6 +260,7 @@ static void gzvm_drv_remove(struct platform_device *pdev)
 {
 	gzvm_drv_irqfd_exit();
 	misc_deregister(&gzvm_dev);
+	gzvm_drv_debug_exit();
 	gzvm_drv_sysfs_exit();
 }
 
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index e44ee2d04ed8..2ce36ad8791b 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/debugfs.h>
 #include <linux/file.h>
 #include <linux/kdev_t.h>
 #include <linux/mm.h>
@@ -342,6 +343,12 @@ static void gzvm_destroy_all_ppage(struct gzvm *gzvm)
 	}
 }
 
+static int gzvm_destroy_vm_debugfs(struct gzvm *vm)
+{
+	debugfs_remove_recursive(vm->debug_dir);
+	return 0;
+}
+
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
 	size_t allocated_size;
@@ -369,6 +376,8 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 	/* No need to lock here becauese it's single-threaded execution */
 	gzvm_destroy_all_ppage(gzvm);
 
+	gzvm_destroy_vm_debugfs(gzvm);
+
 	kfree(gzvm);
 }
 
@@ -427,6 +436,108 @@ static void setup_vm_demand_paging(struct gzvm *vm)
 	}
 }
 
+/**
+ * hyp_mem_read() - Get size of hypervisor-allocated memory and stage 2 table
+ * @file: Pointer to struct file
+ * @buf: User space buffer for storing the return value
+ * @len: Size of @buf, in bytes
+ * @offset: Pointer to loff_t
+ *
+ * Return: Size of hypervisor-allocated memory and stage 2 table, in bytes
+ */
+static ssize_t hyp_mem_read(struct file *file, char __user *buf, size_t len,
+			    loff_t *offset)
+{
+	char tmp_buffer[GZVM_MAX_DEBUGFS_VALUE_SIZE] = {0};
+	struct gzvm *vm = file->private_data;
+	int ret;
+
+	if (*offset == 0) {
+		ret = gzvm_arch_get_statistics(vm);
+		if (ret)
+			return ret;
+		snprintf(tmp_buffer, sizeof(tmp_buffer), "%llu\n",
+			 vm->stat.protected_hyp_mem);
+		if (copy_to_user(buf, tmp_buffer, sizeof(tmp_buffer)))
+			return -EFAULT;
+		*offset += sizeof(tmp_buffer);
+		return sizeof(tmp_buffer);
+	}
+	return 0;
+}
+
+/**
+ * shared_mem_read() - Get size of memory shared between host and guest
+ * @file: Pointer to struct file
+ * @buf: User space buffer for storing the return value
+ * @len: Size of @buf, in bytes
+ * @offset: Pointer to loff_t
+ *
+ * Return: Size of memory shared between host and guest, in bytes
+ */
+static ssize_t shared_mem_read(struct file *file, char __user *buf, size_t len,
+			       loff_t *offset)
+{
+	char tmp_buffer[GZVM_MAX_DEBUGFS_VALUE_SIZE] = {0};
+	struct gzvm *vm = file->private_data;
+	int ret;
+
+	if (*offset == 0) {
+		ret = gzvm_arch_get_statistics(vm);
+		if (ret)
+			return ret;
+		snprintf(tmp_buffer, sizeof(tmp_buffer), "%llu\n",
+			 vm->stat.protected_shared_mem);
+		if (copy_to_user(buf, tmp_buffer, sizeof(tmp_buffer)))
+			return -EFAULT;
+		*offset += sizeof(tmp_buffer);
+		return sizeof(tmp_buffer);
+	}
+	return 0;
+}
+
+static const struct file_operations hyp_mem_fops = {
+	.open = simple_open,
+	.read = hyp_mem_read,
+};
+
+static const struct file_operations shared_mem_fops = {
+	.open = simple_open,
+	.read = shared_mem_read,
+};
+
+static int gzvm_create_vm_debugfs(struct gzvm *vm)
+{
+	struct dentry *dent;
+	char dir_name[GZVM_MAX_DEBUGFS_DIR_NAME_SIZE];
+
+	if (!vm->gzvm_drv->gzvm_debugfs_dir) {
+		pr_warn("VM debugfs directory is not exist\n");
+		return -EFAULT;
+	}
+
+	if (vm->debug_dir) {
+		pr_warn("VM debugfs directory is duplicated\n");
+		return 0;
+	}
+
+	snprintf(dir_name, sizeof(dir_name), "%d-%d", task_pid_nr(current), vm->vm_id);
+
+	dent = debugfs_lookup(dir_name, vm->gzvm_drv->gzvm_debugfs_dir);
+	if (dent) {
+		pr_warn("Debugfs directory is duplicated\n");
+		dput(dent);
+		return 0;
+	}
+	dent = debugfs_create_dir(dir_name, vm->gzvm_drv->gzvm_debugfs_dir);
+	vm->debug_dir = dent;
+
+	debugfs_create_file("protected_shared_mem", 0444, dent, vm, &shared_mem_fops);
+	debugfs_create_file("protected_hyp_mem", 0444, dent, vm, &hyp_mem_fops);
+
+	return 0;
+}
+
 static int setup_mem_alloc_mode(struct gzvm *vm)
 {
 	int ret;
@@ -487,6 +598,10 @@ static struct gzvm *gzvm_create_vm(struct gzvm_driver *drv, unsigned long vm_typ
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
 
+	ret = gzvm_create_vm_debugfs(gzvm);
+	if (ret)
+		pr_debug("Failed to create debugfs for VM-%u\n", gzvm->vm_id);
+
 	pr_debug("VM-%u is created\n", gzvm->vm_id);
 
 	return gzvm;
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 7065ec36f190..bafdd7c2bdc8 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -30,6 +30,8 @@ struct gzvm_driver {
 
 	struct kobject *sysfs_root_dir;
 	u32 demand_paging_batch_pages;
+
+	struct dentry *gzvm_debugfs_dir;
 };
 
 /*
@@ -67,6 +69,9 @@ struct gzvm_driver {
 #define GZVM_DRV_DEMAND_PAGING_BATCH_PAGES	\
 	(GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE)
 
+#define GZVM_MAX_DEBUGFS_DIR_NAME_SIZE  20
+#define GZVM_MAX_DEBUGFS_VALUE_SIZE	20
+
 enum gzvm_demand_paging_mode {
 	GZVM_FULLY_POPULATED = 0,
 	GZVM_DEMAND_PAGING = 1,
@@ -132,6 +137,11 @@ struct gzvm_pinned_page {
 	u64 ipa;
 };
 
+struct gzvm_vm_stat {
+	u64 protected_hyp_mem;
+	u64 protected_shared_mem;
+};
+
 /**
  * struct gzvm: the following data structures are for data transferring between
  * driver and hypervisor, and they're aligned with hypervisor definitions.
@@ -156,6 +166,8 @@ struct gzvm_pinned_page {
  * @demand_page_buffer: the mailbox for transferring large portion pages
  * @demand_paging_lock: lock for preventing multiple cpu using the same demand
  * page mailbox at the same time
+ * @stat: information for VM memory statistics
+ * @debug_dir: debugfs directory node for VM memory statistics
  */
 struct gzvm {
 	struct gzvm_driver *gzvm_drv;
@@ -188,6 +200,9 @@ struct gzvm {
 	u32 demand_page_gran;
 	u64 *demand_page_buffer;
 	struct mutex  demand_paging_lock;
+
+	struct gzvm_vm_stat stat;
+	struct dentry *debug_dir;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -213,6 +228,7 @@ int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 			u64 nr_pages);
 int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages);
+int gzvm_arch_get_statistics(struct gzvm *gzvm);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
-- 
2.18.0


