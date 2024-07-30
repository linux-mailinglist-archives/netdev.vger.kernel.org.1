Return-Path: <netdev+bounces-114023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDF940B5F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BF51F23F6F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730E194AF4;
	Tue, 30 Jul 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tcbn739B"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935119306A;
	Tue, 30 Jul 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327898; cv=none; b=N0/z5JKk7IV3n9lkpOsiaZscABAMmI1TLJ7vAkfwKSWAzgoRm0UfoIAchKWX4nvbWtdcnt1IB0EEhrABBx/1BdBv0VS6pwwJPJXYM9cQgyKX1C7Nu2U96BJx+lKjQ/fFuCHXY9kiM+447rX/K7ljjYb/48MT1aMBUFX5AJdXOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327898; c=relaxed/simple;
	bh=JFY/ilXsrK5dzX9jG8VO7HDaxX79uQLDrBfsn1epk30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRWp/8IqW1e8H+9jJNKldcyHxjdRS5kmVMImK1+dT9eLyB/q+r7grGfg7vSfS2OVtSv8uw033yxp9Lq3r/XJE1ZTpr3WAq10WPi6bcB+a4aXygoTiBEAC45Fz9qpImhh7OsQsuh+CcAdoN90RECLjlynQxHzo+Xh8IYrAkzWMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tcbn739B; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2a3e5d084e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=K0RC2uaYd0jtlEc1O1ARu9OLVILV/iricAA/jndI/Jg=;
	b=Tcbn739Buw1PqU3hkXadNIiJvv+qMwweYVUOVWwK5JzOCjT5E8/4C4sfvAjbM78t3ab1d0ZvqY62lo/LG10hnSZt3tBm41OcDwnEhOEOKki4PdPDyyTqm8bIisa5ZODChqVbgkqZ8jeLW3NdeDDp7E+khJaWPjtI6aSOXIYH5J4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e9d4ddec-babe-4ec1-afe3-0a318e7071e9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6dc6a47,CLOUDID:c31c11d2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2a3e5d084e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1554808484; Tue, 30 Jul 2024 16:24:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:39 +0800
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
Subject: [PATCH v12 17/24] virt: geniezone: Add block-based demand paging support
Date: Tue, 30 Jul 2024 16:24:29 +0800
Message-ID: <20240730082436.9151-18-liju-clr.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>

To balance memory usage and performance, GenieZone supports larger
granularity demand paging, called block-based demand paging.
Gzvm driver uses enable_cap to query the hypervisor if it supports
block-based demand paging and the given granularity or not. Meanwhile,
the gzvm driver allocates a shared buffer for storing the physical
pages later.

If the hypervisor supports, every time the gzvm driver handles guest
page faults, it allocates more memory in advance (default: 2MB) for
demand paging. And fills those physical pages into the allocated shared
memory, then calls the hypervisor to map to guest's memory.

The physical pages allocated for block-based demand paging is not
necessary to be contiguous because in many cases, 2MB block is not
followed. 1st, the memory is allocated because of VMM's page fault
(VMM loads kernel image to guest memory before running). In this case,
the page is allocated by the host kernel and using PAGE_SIZE. 2nd is
that guest may return memory to host via ballooning and that is still
4KB (or PAGE_SIZE) granularity. Therefore, we do not have to allocate
physically contiguous 2MB pages.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 +
 arch/arm64/geniezone/vm.c               | 18 +++++++--
 drivers/virt/geniezone/gzvm_mmu.c       | 52 +++++++++++++++++++++++-
 drivers/virt/geniezone/gzvm_vm.c        | 53 ++++++++++++++++++++++++-
 include/linux/soc/mediatek/gzvm_drv.h   | 12 ++++++
 include/uapi/linux/gzvm.h               |  2 +
 6 files changed, 133 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 928191e3cdb2..8a082ba808a4 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -25,6 +25,7 @@ enum {
 	GZVM_FUNC_MEMREGION_PURPOSE = 15,
 	GZVM_FUNC_SET_DTB_CONFIG = 16,
 	GZVM_FUNC_MAP_GUEST = 17,
+	GZVM_FUNC_MAP_GUEST_BLOCK = 18,
 	NR_GZVM_FUNC,
 };
 
@@ -50,6 +51,7 @@ enum {
 #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 #define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
 #define MT_HVC_GZVM_MAP_GUEST		GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST)
+#define MT_HVC_GZVM_MAP_GUEST_BLOCK	GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST_BLOCK)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index b8ff974eb502..1334aae87d2d 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -349,10 +349,11 @@ static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
 		fallthrough;
 	case GZVM_CAP_PVM_SET_PROTECTED_VM:
 		/*
-		 * To improve performance for protected VM, we have to populate VM's memory
-		 * before VM booting
+		 * If the hypervisor doesn't support block-based demand paging, we
+		 * populate memory in advance to improve performance for protected VM.
 		 */
-		populate_all_mem_regions(gzvm);
+		if (gzvm->demand_page_gran == PAGE_SIZE)
+			populate_all_mem_regions(gzvm);
 		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
 		return ret;
 	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
@@ -376,7 +377,10 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 	case GZVM_CAP_PROTECTED_VM:
 		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
 		return ret;
+
 	case GZVM_CAP_ENABLE_DEMAND_PAGING:
+		fallthrough;
+	case GZVM_CAP_BLOCK_BASED_DEMAND_PAGING:
 		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
 		return ret;
 	default:
@@ -394,3 +398,11 @@ int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST, vm_id, memslot_id,
 				    pfn, gfn, nr_pages, 0, 0, &res);
 }
+
+int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST_BLOCK, vm_id,
+				    memslot_id, gfn, nr_pages, 0, 0, 0, &res);
+}
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index dcc8c4d7be83..f6e4aca63f86 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -114,6 +114,53 @@ static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
 	if (unlikely(ret))
 		return -EFAULT;
+
+	return ret;
+}
+
+static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
+{
+	u64 pfn, __gfn;
+	int ret, i;
+
+	u32 nr_entries = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE;
+	struct gzvm_memslot *memslot = &vm->memslot[memslot_id];
+	u64 start_gfn = ALIGN_DOWN(gfn, nr_entries);
+	u32 total_pages = memslot->npages;
+	u64 base_gfn = memslot->base_gfn;
+
+	/*
+	 * If the start/end gfn of this demand paging block is outside the
+	 * memory region of memslot, adjust the start_gfn/nr_entries.
+	 */
+	if (start_gfn < base_gfn)
+		start_gfn = base_gfn;
+
+	if (start_gfn + nr_entries > base_gfn + total_pages)
+		nr_entries = base_gfn + total_pages - start_gfn;
+
+	mutex_lock(&vm->demand_paging_lock);
+	for (i = 0, __gfn = start_gfn; i < nr_entries; i++, __gfn++) {
+		ret = gzvm_vm_allocate_guest_page(vm, memslot, __gfn, &pfn);
+		if (unlikely(ret)) {
+			pr_notice("VM-%u failed to allocate page for GFN 0x%llx (%d)\n",
+				  vm->vm_id, __gfn, ret);
+			ret = -ERR_FAULT;
+			goto err_unlock;
+		}
+		vm->demand_page_buffer[i] = pfn;
+	}
+
+	ret = gzvm_arch_map_guest_block(vm->vm_id, memslot_id, start_gfn,
+					nr_entries);
+	if (unlikely(ret)) {
+		ret = -EFAULT;
+		goto err_unlock;
+	}
+
+err_unlock:
+	mutex_unlock(&vm->demand_paging_lock);
+
 	return ret;
 }
 
@@ -140,5 +187,8 @@ int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
 	if (unlikely(vm->mem_alloc_mode == GZVM_FULLY_POPULATED))
 		return -EFAULT;
 
-	return handle_single_demand_page(vm, memslot_id, gfn);
+	if (vm->demand_page_gran == PAGE_SIZE)
+		return handle_single_demand_page(vm, memslot_id, gfn);
+	else
+		return handle_block_demand_page(vm, memslot_id, gfn);
 }
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index e66942854e63..acedb6ed5572 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -344,6 +344,8 @@ static void gzvm_destroy_all_ppage(struct gzvm *gzvm)
 
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
+	size_t allocated_size;
+
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
 
 	mutex_lock(&gzvm->lock);
@@ -356,6 +358,11 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 	list_del(&gzvm->vm_list);
 	mutex_unlock(&gzvm_list_lock);
 
+	if (gzvm->demand_page_buffer) {
+		allocated_size = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE * sizeof(u64);
+		free_pages_exact(gzvm->demand_page_buffer, allocated_size);
+	}
+
 	mutex_unlock(&gzvm->lock);
 
 	/* No need to lock here becauese it's single-threaded execution */
@@ -378,6 +385,46 @@ static const struct file_operations gzvm_vm_fops = {
 	.llseek		= noop_llseek,
 };
 
+/**
+ * setup_vm_demand_paging - Query hypervisor suitable demand page size and set
+ * @vm: gzvm instance for setting up demand page size
+ *
+ * Return: void
+ */
+static void setup_vm_demand_paging(struct gzvm *vm)
+{
+	u32 buf_size = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE * sizeof(u64);
+	struct gzvm_enable_cap cap = {0};
+	void *buffer;
+	int ret;
+
+	mutex_init(&vm->demand_paging_lock);
+	buffer = alloc_pages_exact(buf_size, GFP_KERNEL);
+	if (!buffer) {
+		/* Fall back to use default page size for demand paging */
+		vm->demand_page_gran = PAGE_SIZE;
+		vm->demand_page_buffer = NULL;
+		return;
+	}
+
+	cap.cap = GZVM_CAP_BLOCK_BASED_DEMAND_PAGING;
+	cap.args[0] = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE;
+	cap.args[1] = (__u64)virt_to_phys(buffer);
+	/* demand_page_buffer is freed when destroy VM */
+	vm->demand_page_buffer = buffer;
+
+	ret = gzvm_vm_ioctl_enable_cap(vm, &cap, NULL);
+	if (ret == 0) {
+		vm->demand_page_gran = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE;
+		/* freed when destroy vm */
+		vm->demand_page_buffer = buffer;
+	} else {
+		vm->demand_page_gran = PAGE_SIZE;
+		vm->demand_page_buffer = NULL;
+		free_pages_exact(buffer, buf_size);
+	}
+}
+
 static int setup_mem_alloc_mode(struct gzvm *vm)
 {
 	int ret;
@@ -386,10 +433,12 @@ static int setup_mem_alloc_mode(struct gzvm *vm)
 	cap.cap = GZVM_CAP_ENABLE_DEMAND_PAGING;
 
 	ret = gzvm_vm_ioctl_enable_cap(vm, &cap, NULL);
-	if (!ret)
+	if (!ret) {
 		vm->mem_alloc_mode = GZVM_DEMAND_PAGING;
-	else
+		setup_vm_demand_paging(vm);
+	} else {
 		vm->mem_alloc_mode = GZVM_FULLY_POPULATED;
+	}
 
 	return 0;
 }
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index edd8616a298f..7c6c1cde0d8d 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -45,6 +45,8 @@
 
 #define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
 
+#define GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE	(2 * 1024 * 1024) /* 2MB */
+
 enum gzvm_demand_paging_mode {
 	GZVM_FULLY_POPULATED = 0,
 	GZVM_DEMAND_PAGING = 1,
@@ -128,6 +130,11 @@ struct gzvm_pinned_page {
  * @pinned_pages: use rb-tree to record pin/unpin page
  * @mem_lock: lock for memory operations
  * @mem_alloc_mode: memory allocation mode - fully allocated or demand paging
+ * @demand_page_gran: demand page granularity: how much memory we allocate for
+ * VM in a single page fault
+ * @demand_page_buffer: the mailbox for transferring large portion pages
+ * @demand_paging_lock: lock for preventing multiple cpu using the same demand
+ * page mailbox at the same time
  */
 struct gzvm {
 	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
@@ -155,6 +162,10 @@ struct gzvm {
 
 	struct rb_root pinned_pages;
 	struct mutex mem_lock;
+
+	u32 demand_page_gran;
+	u64 *demand_page_buffer;
+	struct mutex  demand_paging_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -175,6 +186,7 @@ int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 			u64 nr_pages);
+int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 61a7a87b3d23..0d38a0963cb7 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -18,6 +18,8 @@
 
 #define GZVM_CAP_VM_GPA_SIZE	0xa5
 #define GZVM_CAP_PROTECTED_VM	0xffbadab1
+/* query hypervisor supported block-based demand page */
+#define GZVM_CAP_BLOCK_BASED_DEMAND_PAGING	0x9201
 #define GZVM_CAP_ENABLE_DEMAND_PAGING	0x9202
 
 /* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
-- 
2.18.0


