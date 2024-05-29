Return-Path: <netdev+bounces-98911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C888D31E8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6582849B9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC8E17108D;
	Wed, 29 May 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Idk7nm3E"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2F168C3B;
	Wed, 29 May 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972176; cv=none; b=KzIlKh+JTnXEhsWDgKT4OWG6HAC03KIZw5ABKIHCMH2gWXAvTiSnbB1AwH4XxIyaGcZiMbIQibXcVgQlIJEM7AU2y5WJKbI5H484GI0EDSvuwAYziX111TwtP/OsIqdrt5+dhU28Jh9yBApjOjxL/srDirmeka/3K8UBnlSku+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972176; c=relaxed/simple;
	bh=lmQNyju1MdRJn6gsKcH010bY80d0L/HYp58oN/9cEM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5q88de+IbE6shxAmIx56BckvTBGF6wgu9rAsd7WlBVfH2eqYii9yb0iwpiLWCZPqc4wJKR6NJy89Fn46JIt5bV2DC4UuNrRuwuBSq8a73w4zx5GNVUdBpTrg4cbKK9Z9bn1fdUiAtvPI2n39d+7C01jB0moYwlK9hLKktAaTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Idk7nm3E; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6ac7e02e1d9711efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zutLqdxhHEf3awr2ED7Hzd1AOyt5H3UV0Q9m643dWW8=;
	b=Idk7nm3EpKNQhVe23SBvofsE9lymf9wGqVKL36p2cYhf+oHvNo7v3EnAitcd3qnNt2b1qyP0Ya0U+YexMg/zUOIeaGGft7K5X25iQGW/c55EXVNtPsUtOa8ZtuahTQZebYThXaHVfVHSzDqf7L7FD/10lULCoiJCsBWwUnmeM0I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:16e51e17-7223-4f5f-ae16-a0d97f51f6cf,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:393d96e,CLOUDID:7877f243-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6ac7e02e1d9711efbfff99f2466cf0b4-20240529
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 354462791; Wed, 29 May 2024 16:42:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 01:42:42 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 16:42:42 +0800
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
	<linux-mediatek@lists.infradead.org>, David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>, Chi-shen Yeh
	<Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: [PATCH v11 19/21] virt: geniezone: Provide individual VM memory statistics within debugfs
Date: Wed, 29 May 2024 16:42:37 +0800
Message-ID: <20240529084239.11478-20-liju-clr.chen@mediatek.com>
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
X-MTK: N

From: Yi-De Wu <yi-de.wu@mediatek.com>

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

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
Signed-off-by: Liju-Clr Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               |  13 +++
 drivers/virt/geniezone/gzvm_main.c      |   6 ++
 drivers/virt/geniezone/gzvm_vm.c        | 134 ++++++++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  17 +++
 5 files changed, 172 insertions(+)

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
index 1334aae87d2d..62ffb415354c 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -406,3 +406,16 @@ int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages)
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
index f5aae2d121f2..09e303df1f85 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -109,6 +109,11 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 	ret = gzvm_drv_irqfd_init();
 	if (ret)
 		return ret;
+
+	ret = gzvm_drv_debug_init();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -117,6 +122,7 @@ static int gzvm_drv_remove(struct platform_device *pdev)
 	gzvm_drv_irqfd_exit();
 	gzvm_destroy_all_vms();
 	misc_deregister(&gzvm_dev);
+	gzvm_drv_debug_exit();
 	return 0;
 }
 
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 4bfa56ef5b8b..3fb212143686 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -11,11 +11,14 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
+#include <linux/debugfs.h>
 #include "gzvm_common.h"
 
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
 
+static struct dentry *gzvm_debugfs_dir;
+
 int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn,
 			    u64 *hva_memslot)
 {
@@ -342,6 +345,12 @@ static void gzvm_destroy_all_ppage(struct gzvm *gzvm)
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
@@ -368,6 +377,8 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 	/* No need to lock here becauese it's single-threaded execution */
 	gzvm_destroy_all_ppage(gzvm);
 
+	gzvm_destroy_vm_debugfs(gzvm);
+
 	kfree(gzvm);
 }
 
@@ -425,6 +436,108 @@ static void setup_vm_demand_paging(struct gzvm *vm)
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
+	.llseek = no_llseek,
+};
+
+static const struct file_operations shared_mem_fops = {
+	.open = simple_open,
+	.read = shared_mem_read,
+	.llseek = no_llseek,
+};
+
+static int gzvm_create_vm_debugfs(struct gzvm *vm)
+{
+	struct dentry *dent;
+	char dir_name[GZVM_MAX_DEBUGFS_DIR_NAME_SIZE];
+
+	if (!gzvm_debugfs_dir)
+		return -EFAULT;
+
+	if (vm->debug_dir) {
+		pr_warn("VM debugfs directory is duplicated\n");
+		return 0;
+	}
+
+	snprintf(dir_name, sizeof(dir_name), "%d-%d", task_pid_nr(current), vm->vm_id);
+
+	dent = debugfs_lookup(dir_name, gzvm_debugfs_dir);
+	if (dent) {
+		pr_warn("Debugfs directory is duplicated\n");
+		dput(dent);
+		return 0;
+	}
+	dent = debugfs_create_dir(dir_name, gzvm_debugfs_dir);
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
@@ -484,6 +597,10 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
 
+	ret = gzvm_create_vm_debugfs(gzvm);
+	if (ret)
+		pr_debug("Failed to create debugfs for VM-%u\n", gzvm->vm_id);
+
 	pr_debug("VM-%u is created\n", gzvm->vm_id);
 
 	return gzvm;
@@ -521,3 +638,20 @@ void gzvm_destroy_all_vms(void)
 out:
 	mutex_unlock(&gzvm_list_lock);
 }
+
+int gzvm_drv_debug_init(void)
+{
+	if (!debugfs_initialized())
+		return 0;
+
+	if (!gzvm_debugfs_dir && !debugfs_lookup("gzvm", gzvm_debugfs_dir))
+		gzvm_debugfs_dir = debugfs_create_dir("gzvm", NULL);
+
+	return 0;
+}
+
+void gzvm_drv_debug_exit(void)
+{
+	if (gzvm_debugfs_dir && debugfs_lookup("gzvm", gzvm_debugfs_dir))
+		debugfs_remove_recursive(gzvm_debugfs_dir);
+}
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index b8cec9717606..7c0ccbcd114f 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -47,6 +47,9 @@
 
 #define GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE	(2 * 1024 * 1024) /* 2MB */
 
+#define GZVM_MAX_DEBUGFS_DIR_NAME_SIZE  20
+#define GZVM_MAX_DEBUGFS_VALUE_SIZE	20
+
 enum gzvm_demand_paging_mode {
 	GZVM_FULLY_POPULATED = 0,
 	GZVM_DEMAND_PAGING = 1,
@@ -112,6 +115,11 @@ struct gzvm_pinned_page {
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
@@ -135,6 +143,8 @@ struct gzvm_pinned_page {
  * @demand_page_buffer: the mailbox for transferring large portion pages
  * @demand_paging_lock: lock for preventing multiple cpu using the same demand
  * page mailbox at the same time
+ * @stat: information for VM memory statistics
+ * @debug_dir: debugfs directory node for VM memory statistics
  */
 struct gzvm {
 	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
@@ -166,6 +176,9 @@ struct gzvm {
 	u32 demand_page_gran;
 	u64 *demand_page_buffer;
 	struct mutex  demand_paging_lock;
+
+	struct gzvm_vm_stat stat;
+	struct dentry *debug_dir;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -187,6 +200,7 @@ int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 			u64 nr_pages);
 int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages);
+int gzvm_arch_get_statistics(struct gzvm *gzvm);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
@@ -205,6 +219,9 @@ int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
 int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
 int gzvm_arch_inform_exit(u16 vm_id);
 
+int gzvm_drv_debug_init(void);
+void gzvm_drv_debug_exit(void);
+
 int gzvm_find_memslot(struct gzvm *vm, u64 gpa);
 int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu);
 bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
-- 
2.18.0


