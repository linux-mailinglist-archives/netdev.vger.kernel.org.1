Return-Path: <netdev+bounces-144805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD59C872D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F0C1F2345B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB021FBC92;
	Thu, 14 Nov 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VOWcf5a1"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011711F8F1B;
	Thu, 14 Nov 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578904; cv=none; b=fdFp2BmSlJceemf3Wm0HODdTczX5/+BV8IsA8PT1RqDdzT5rP4+/6VBQLxTejSJQBvPnjsG1Ra5Fd24rw2Ol5N2g6XmswJ1DgnuRklssmbXOxiYJ7fcIFnq7f7CIi0KXbHfMtUQ9BSZwt8kOZPIKW+LrcHB/uP98jiUl1Oyp9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578904; c=relaxed/simple;
	bh=4Lglm5d2xxsHsbj3pbQnida7I1cYcwnsAqZ6hL50FYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8/KCtUlQQflZsMCNaMBTdx+GpVI9Z/BOMqpRM2HP5y+mxo5wLw8aPBoWzRBbqmgDiC5pb7orJYShT8+oT72S23laGqtGq4gNsfGdawGnyL0p0Lb5Stl5or9b0CLFt6s7lCoPhJuR5VXikOYyeKYgfIzAo1ixMkT7w85fyCUzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VOWcf5a1; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 582c8150a27011efbd192953cf12861f-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HgxzXXBoyvOV03PMO3sb/CWleSew5G/aZSc/s+MAXMk=;
	b=VOWcf5a1I5Reiu7W6TUCkMZ1X+V42N1Dn6IoNABpcyaXpYid6fpOP/vzsmlc9UU2cLx31pOcBcsBIt8S+Isxc0wYG13y/rptp4bJMnNLSoEJyYwiQJIyt6n5j3RJNfquMW7zzNA/Sw4nKWTGh4de89Xv5UzyGjr20XgWRdx2YO8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:921921d3-862f-4961-8a5f-2082d75fbbae,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:613fa25c-f18b-4d56-b49c-93279ee09144,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 582c8150a27011efbd192953cf12861f-20241114
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1861760093; Thu, 14 Nov 2024 18:08:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:05 +0800
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
Subject: [PATCH v13 17/25] virt: geniezone: Add block-based demand paging support
Date: Thu, 14 Nov 2024 18:07:54 +0800
Message-ID: <20241114100802.4116-18-liju-clr.chen@mediatek.com>
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
Co-developed-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 +
 arch/arm64/geniezone/vm.c               | 47 ++++++++++++-
 drivers/virt/geniezone/gzvm_main.c      | 91 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_mmu.c       | 58 +++++++++++++++-
 drivers/virt/geniezone/gzvm_vm.c        | 56 ++++++++++++++-
 include/linux/soc/mediatek/gzvm_drv.h   | 22 +++++-
 include/uapi/linux/gzvm.h               |  3 +
 7 files changed, 272 insertions(+), 7 deletions(-)

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
index 53e487912d2c..91c6e4e2caf2 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -184,6 +184,35 @@ static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
 				    res);
 }
 
+static int gzvm_arch_enable_cap(struct gzvm_enable_cap *cap,
+				struct arm_smccc_res *res)
+{
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, 0,
+				    cap->cap, cap->args[0], cap->args[1],
+				    cap->args[2], cap->args[3], cap->args[4],
+				    res);
+}
+
+int gzvm_arch_query_hyp_batch_pages(struct gzvm_enable_cap *cap,
+				    void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+	int ret;
+
+	ret = gzvm_arch_enable_cap(cap, &res);
+
+	if (ret)
+		return ret;
+
+	if (res.a1 == 0 ||
+	    GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE % (PAGE_SIZE * res.a1) != 0)
+		return -EFAULT;
+
+	cap->args[0] = res.a1;
+
+	return ret;
+}
+
 /**
  * gzvm_vm_ioctl_get_pvmfw_size() - Get pvmfw size from hypervisor, return
  *				    in x1, and return to userspace in args
@@ -358,10 +387,11 @@ static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
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
@@ -385,7 +415,10 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
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
@@ -403,3 +436,11 @@ int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
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
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index 6142d1d792a4..c975912cd594 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -6,10 +6,12 @@
 #include <linux/device.h>
 #include <linux/file.h>
 #include <linux/kdev_t.h>
+#include <linux/kobject.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/sysfs.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
 
 static struct gzvm_driver gzvm_drv = {
@@ -20,6 +22,64 @@ static struct gzvm_driver gzvm_drv = {
 	},
 };
 
+static ssize_t demand_paging_batch_pages_show(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      char *buf)
+{
+	return sprintf(buf, "%u\n", gzvm_drv.demand_paging_batch_pages);
+}
+
+static ssize_t demand_paging_batch_pages_store(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       const char *buf, size_t count)
+{
+	int ret;
+	u32 temp;
+
+	ret = kstrtoint(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
+
+	if (temp == 0 || (PMD_SIZE % (PAGE_SIZE * temp)) != 0)
+		return -EINVAL;
+
+	gzvm_drv.demand_paging_batch_pages = temp;
+
+	return count;
+}
+
+/* /sys/kernel/gzvm/demand_paging_batch_pages */
+static struct kobj_attribute demand_paging_batch_pages_attr = {
+		.attr = {
+			.name = "demand_paging_batch_pages",
+			.mode = 0660,
+		},
+		.show = demand_paging_batch_pages_show,
+		.store = demand_paging_batch_pages_store,
+};
+
+static int gzvm_drv_sysfs_init(void)
+{
+	int ret = 0;
+
+	gzvm_drv.sysfs_root_dir = kobject_create_and_add("gzvm", kernel_kobj);
+
+	if (!gzvm_drv.sysfs_root_dir)
+		return -ENOMEM;
+
+	ret = sysfs_create_file(gzvm_drv.sysfs_root_dir,
+				&demand_paging_batch_pages_attr.attr);
+	if (ret)
+		pr_debug("failed to create demand_batch_pages in /sys/kernel/gzvm\n");
+
+	return ret;
+}
+
+static void gzvm_drv_sysfs_exit(void)
+{
+	kobject_del(gzvm_drv.sysfs_root_dir);
+}
+
 /**
  * gzvm_err_to_errno() - Convert geniezone return value to standard errno
  *
@@ -119,6 +179,27 @@ static struct miscdevice gzvm_dev = {
 	.fops = &gzvm_chardev_ops,
 };
 
+static int gzvm_query_hyp_batch_pages(void)
+{
+	struct gzvm_enable_cap cap = {0};
+	int ret;
+
+	gzvm_drv.demand_paging_batch_pages = GZVM_DRV_DEMAND_PAGING_BATCH_PAGES;
+	cap.cap = GZVM_CAP_QUERY_HYP_BATCH_PAGES;
+
+	ret = gzvm_arch_query_hyp_batch_pages(&cap, NULL);
+	if (!ret)
+		gzvm_drv.demand_paging_batch_pages = cap.args[0];
+
+	/*
+	 * We have initialized demand_paging_batch_pages, and to maintain
+	 * compatibility with older GZ version, we can ignore the return value.
+	 */
+	if (ret == -EINVAL)
+		return 0;
+	return ret;
+}
+
 static int gzvm_drv_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -139,6 +220,15 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 	ret = gzvm_drv_irqfd_init();
 	if (ret)
 		return ret;
+
+	ret = gzvm_drv_sysfs_init();
+	if (ret)
+		return ret;
+
+	ret = gzvm_query_hyp_batch_pages();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -146,6 +236,7 @@ static void gzvm_drv_remove(struct platform_device *pdev)
 {
 	gzvm_drv_irqfd_exit();
 	misc_deregister(&gzvm_dev);
+	gzvm_drv_sysfs_exit();
 }
 
 static const struct of_device_id gzvm_of_match[] = {
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index dcc8c4d7be83..a5aa296ca790 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -114,6 +114,59 @@ static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
 	if (unlikely(ret))
 		return -EFAULT;
+
+	return ret;
+}
+
+static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
+{
+	u32 nr_entries_all = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE;
+	u32 nr_entries = vm->gzvm_drv->demand_paging_batch_pages;
+	struct gzvm_memslot *memslot = &vm->memslot[memslot_id];
+	u64 start_gfn = ALIGN_DOWN(gfn, nr_entries_all);
+	u32 total_pages = memslot->npages;
+	u64 base_gfn = memslot->base_gfn;
+	u64 pfn, __gfn;
+	int ret, i;
+
+	if (start_gfn < base_gfn)
+		start_gfn = base_gfn;
+
+	u64 end_gfn = start_gfn + nr_entries_all;
+
+	if (start_gfn + nr_entries_all > base_gfn + total_pages)
+		end_gfn = base_gfn + total_pages;
+
+	mutex_lock(&vm->demand_paging_lock);
+	for (; start_gfn < end_gfn; start_gfn += nr_entries)  {
+		/*
+		 * If the start/end gfn of this demand paging block is outside the
+		 * memory region of memslot, adjust the start_gfn/nr_entries.
+		 */
+		if (start_gfn + nr_entries > base_gfn + total_pages)
+			nr_entries = base_gfn + total_pages - start_gfn;
+
+		for (i = 0, __gfn = start_gfn; i < nr_entries; i++, __gfn++) {
+			ret = gzvm_vm_allocate_guest_page(vm, memslot, __gfn,
+							  &pfn);
+			if (unlikely(ret)) {
+				pr_notice("VM-%u failed to allocate page for GFN 0x%llx (%d)\n",
+					  vm->vm_id, __gfn, ret);
+				ret = -ERR_FAULT;
+				goto err_unlock;
+			}
+			vm->demand_page_buffer[i] = pfn;
+		}
+
+		ret = gzvm_arch_map_guest_block(vm->vm_id, memslot_id,
+						start_gfn, nr_entries);
+		if (unlikely(ret)) {
+			ret = -EFAULT;
+			goto err_unlock;
+		}
+	}
+err_unlock:
+	mutex_unlock(&vm->demand_paging_lock);
 	return ret;
 }
 
@@ -140,5 +193,8 @@ int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
 	if (unlikely(vm->mem_alloc_mode == GZVM_FULLY_POPULATED))
 		return -EFAULT;
 
-	return handle_single_demand_page(vm, memslot_id, gfn);
+	if (vm->demand_page_gran == PAGE_SIZE)
+		return handle_single_demand_page(vm, memslot_id, gfn);
+	else
+		return handle_block_demand_page(vm, memslot_id, gfn);
 }
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index f63487809148..e44ee2d04ed8 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -344,6 +344,8 @@ static void gzvm_destroy_all_ppage(struct gzvm *gzvm)
 
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
+	size_t allocated_size;
+
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
 
 	mutex_lock(&gzvm->lock);
@@ -356,6 +358,12 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 	list_del(&gzvm->vm_list);
 	mutex_unlock(&gzvm_list_lock);
 
+	if (gzvm->demand_page_buffer) {
+		allocated_size = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE *
+				 sizeof(u64);
+		free_pages_exact(gzvm->demand_page_buffer, allocated_size);
+	}
+
 	mutex_unlock(&gzvm->lock);
 
 	/* No need to lock here becauese it's single-threaded execution */
@@ -377,6 +385,48 @@ static const struct file_operations gzvm_vm_fops = {
 	.unlocked_ioctl = gzvm_vm_ioctl,
 };
 
+/**
+ * setup_vm_demand_paging() - Query hypervisor suitable demand page size and set
+ * @vm: gzvm instance for setting up demand page size
+ *
+ * Return: void
+ */
+static void setup_vm_demand_paging(struct gzvm *vm)
+{
+	struct gzvm_enable_cap cap = {0};
+	u32 buf_size;
+	void *buffer;
+	int ret;
+
+	buf_size = (GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE) *
+		    sizeof(pte_t);
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
@@ -385,10 +435,12 @@ static int setup_mem_alloc_mode(struct gzvm *vm)
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
index 1a722121ff82..14c1adfbb204 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -27,6 +27,9 @@ struct gzvm_version {
 struct gzvm_driver {
 	struct gzvm_version hyp_version;
 	struct gzvm_version drv_version;
+
+	struct kobject *sysfs_root_dir;
+	u32 demand_paging_batch_pages;
 };
 
 /*
@@ -58,7 +61,11 @@ struct gzvm_driver {
 #define GZVM_MAX_VCPUS		 8
 #define GZVM_MAX_MEM_REGION	10
 
-#define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
+#define GZVM_VCPU_RUN_MAP_SIZE			(PAGE_SIZE * 2)
+
+#define GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE	(PMD_SIZE) /* 2MB */
+#define GZVM_DRV_DEMAND_PAGING_BATCH_PAGES	\
+	(GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE)
 
 enum gzvm_demand_paging_mode {
 	GZVM_FULLY_POPULATED = 0,
@@ -144,6 +151,11 @@ struct gzvm_pinned_page {
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
 	struct gzvm_driver *gzvm_drv;
@@ -172,6 +184,10 @@ struct gzvm {
 
 	struct rb_root pinned_pages;
 	struct mutex mem_lock;
+
+	u32 demand_page_gran;
+	u64 *demand_page_buffer;
+	struct mutex  demand_paging_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -186,6 +202,9 @@ void gzvm_destroy_vcpus(struct gzvm *gzvm);
 /* arch-dependant functions */
 int gzvm_arch_probe(struct gzvm_version drv_version,
 		    struct gzvm_version *hyp_version);
+int gzvm_arch_query_hyp_batch_pages(struct gzvm_enable_cap *cap,
+				    void __user *argp);
+
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 			    phys_addr_t region);
 int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
@@ -193,6 +212,7 @@ int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 			u64 nr_pages);
+int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 61a7a87b3d23..5e21d64a2f4f 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -18,7 +18,10 @@
 
 #define GZVM_CAP_VM_GPA_SIZE	0xa5
 #define GZVM_CAP_PROTECTED_VM	0xffbadab1
+/* query hypervisor supported block-based demand page */
+#define GZVM_CAP_BLOCK_BASED_DEMAND_PAGING	0x9201
 #define GZVM_CAP_ENABLE_DEMAND_PAGING	0x9202
+#define GZVM_CAP_QUERY_HYP_BATCH_PAGES	0x9204
 
 /* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
 #define GZVM_CAP_PVM_SET_PVMFW_GPA		0
-- 
2.18.0


