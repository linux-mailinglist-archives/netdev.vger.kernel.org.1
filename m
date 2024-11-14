Return-Path: <netdev+bounces-144797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BBE9C874A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4DAB2DC6C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377E1FAC28;
	Thu, 14 Nov 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qEAILsDA"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B81F8186;
	Thu, 14 Nov 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578902; cv=none; b=fTYDWg4lEZydx4n8IPVY017+b4zVVVrE91tiSn+3Cgedmrqt+LmlkUn3ZatxeHBGhrp4E0DFYbQYAkn1Qm59oN23feMZRT8HSxHIpWlvsAWEK6y1p2hcE6/POV57iEFq3E2GiD+c8MMh+I1GwY6M1ypwrRCFiOErq3kddrk2P3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578902; c=relaxed/simple;
	bh=vDrCF1jEyeRoGyWgogrWsoiDlZptE4FguL7PD6asEpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0Ws/oZI/36bQjJZX8au5fpHYtsFusEUU9K0vQagyX73BKo3OEcd3CRr/pRRNS8WTbCxs6rMU5AmARrMS9wqGJAcuulCBORZTPj5QKVsT2hrAt7VFLMvx/Q/2F3AyLwkaZYkh9ivw/l97q2ppKKod1BTv47gpx0jL7dX80X3L58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qEAILsDA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 565b6e90a27011ef99858b75a2457dd9-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u5UgKkLQICznpxBLnHfAmIGMhd7AIetkQb14w1LT4Fw=;
	b=qEAILsDAYS55mjjgi/k/GtGOGimpjge8fQbphqPnx2DBpUZsN55QYWIMo7ug+LN1K1XssQqzqrINS9rBS+jyd9Ho79rss54cg4s+u28y8i/k/chRfKRfgt8P/OXJz+H+w6RtuhApU9jDsYfRbWoPvJ4ELFZ7YXoY+RzfXKOwwjw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:3b66df0d-44b2-4657-9bea-70f04e0eea6f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:183fa25c-f18b-4d56-b49c-93279ee09144,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 565b6e90a27011ef99858b75a2457dd9-20241114
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1802850390; Thu, 14 Nov 2024 18:08:04 +0800
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
Subject: [PATCH v13 06/25] virt: geniezone: Add set_user_memory_region for vm
Date: Thu, 14 Nov 2024 18:07:43 +0800
Message-ID: <20241114100802.4116-7-liju-clr.chen@mediatek.com>
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

Direct use of physical memory from VMs is forbidden and designed to be
dictated to the privilege models managed by GenieZone hypervisor for
security reason. With the help of gzvm-ko, the hypervisor would be able
to manipulate memory as objects. And the memory management is highly
integrated with ARM 2-stage translation tables to convert VA to IPA to
PA under proper security measures required by protected VMs.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Co-developed-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               |   9 ++
 drivers/virt/geniezone/gzvm_vm.c        | 141 ++++++++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  65 +++++++++++
 include/uapi/linux/gzvm.h               |  31 ++++++
 5 files changed, 248 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 60ee5ed2b39f..4250c0f567e7 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -11,6 +11,7 @@
 enum {
 	GZVM_FUNC_CREATE_VM = 0,
 	GZVM_FUNC_DESTROY_VM = 1,
+	GZVM_FUNC_SET_MEMREGION = 4,
 	GZVM_FUNC_PROBE = 12,
 	NR_GZVM_FUNC,
 };
@@ -23,6 +24,7 @@ enum {
 
 #define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
 #define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
+#define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 
 /**
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 8e3c9f872bb1..f15a3ba8e295 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -72,6 +72,15 @@ int gzvm_arch_probe(struct gzvm_version drv_version,
 	return 0;
 }
 
+int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
+			    phys_addr_t region)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_MEMREGION, vm_id,
+				    buf_size, region, 0, 0, 0, 0, &res);
+}
+
 /**
  * gzvm_arch_create_vm() - create vm
  * @vm_type: VM type. Only supports Linux VM now.
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 500bc8276d60..7daa79c16dd1 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -15,6 +15,146 @@
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
 
+int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn,
+			    u64 *hva_memslot)
+{
+	u64 offset;
+
+	if (gfn < memslot->base_gfn)
+		return -EINVAL;
+
+	offset = gfn - memslot->base_gfn;
+	*hva_memslot = memslot->userspace_addr + offset * PAGE_SIZE;
+	return 0;
+}
+
+/**
+ * register_memslot_addr_range() - Register memory region to GenieZone
+ * @gzvm: Pointer to struct gzvm
+ * @memslot: Pointer to struct gzvm_memslot
+ *
+ * Return: 0 for success, negative number for error
+ */
+static int
+register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
+{
+	struct gzvm_memory_region_ranges *region;
+	u32 buf_size = PAGE_SIZE * 2;
+	u64 gfn;
+
+	region = alloc_pages_exact(buf_size, GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->slot = memslot->slot_id;
+	region->total_pages = memslot->npages;
+	gfn = memslot->base_gfn;
+	region->gpa = PFN_PHYS(gfn);
+
+	if (gzvm_arch_set_memregion(gzvm->vm_id, buf_size,
+				    virt_to_phys(region))) {
+		pr_err("Failed to register memregion to hypervisor\n");
+		free_pages_exact(region, buf_size);
+		return -EFAULT;
+	}
+
+	free_pages_exact(region, buf_size);
+	return 0;
+}
+
+/**
+ * memory_region_pre_check() - Preliminary check for userspace memory region
+ * @gzvm: Pointer to struct gzvm.
+ * @mem: Input memory region from user.
+ *
+ * Return: true for check passed, false for invalid input.
+ */
+static bool
+memory_region_pre_check(struct gzvm *gzvm,
+			struct gzvm_userspace_memory_region *mem)
+{
+	if (mem->slot >= GZVM_MAX_MEM_REGION)
+		return false;
+
+	if (!PAGE_ALIGNED(mem->guest_phys_addr) ||
+	    !PAGE_ALIGNED(mem->memory_size))
+		return false;
+
+	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
+		return false;
+
+	if ((mem->memory_size >> PAGE_SHIFT) > GZVM_MEM_MAX_NR_PAGES)
+		return false;
+
+	return true;
+}
+
+/**
+ * gzvm_vm_ioctl_set_memory_region() - Set memory region of guest
+ * @gzvm: Pointer to struct gzvm.
+ * @mem: Input memory region from user.
+ *
+ * Return: 0 for success, negative number for error
+ *
+ * -EXIO		- The memslot is out-of-range
+ * -EFAULT		- Cannot find corresponding vma
+ * -EINVAL		- Region size and VMA size mismatch
+ */
+static int
+gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
+				struct gzvm_userspace_memory_region *mem)
+{
+	struct vm_area_struct *vma;
+	struct gzvm_memslot *memslot;
+	unsigned long size;
+
+	if (memory_region_pre_check(gzvm, mem) != true)
+		return -EINVAL;
+
+	memslot = &gzvm->memslot[mem->slot];
+
+	vma = vma_lookup(gzvm->mm, mem->userspace_addr);
+	if (!vma)
+		return -EFAULT;
+
+	size = vma->vm_end - vma->vm_start;
+	if (size != mem->memory_size)
+		return -EINVAL;
+
+	memslot->base_gfn = __phys_to_pfn(mem->guest_phys_addr);
+	memslot->npages = size >> PAGE_SHIFT;
+	memslot->userspace_addr = mem->userspace_addr;
+	memslot->vma = vma;
+	memslot->flags = mem->flags;
+	memslot->slot_id = mem->slot;
+	return register_memslot_addr_range(gzvm, memslot);
+}
+
+/* gzvm_vm_ioctl() - Ioctl handler of VM FD */
+static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
+			  unsigned long arg)
+{
+	long ret;
+	void __user *argp = (void __user *)arg;
+	struct gzvm *gzvm = filp->private_data;
+
+	switch (ioctl) {
+	case GZVM_SET_USER_MEMORY_REGION: {
+		struct gzvm_userspace_memory_region userspace_mem;
+
+		if (copy_from_user(&userspace_mem, argp, sizeof(userspace_mem)))
+			return -EFAULT;
+
+		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
+		break;
+	}
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
@@ -42,6 +182,7 @@ static int gzvm_vm_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations gzvm_vm_fops = {
 	.release        = gzvm_vm_release,
+	.unlocked_ioctl = gzvm_vm_ioctl,
 };
 
 static struct gzvm *gzvm_create_vm(struct gzvm_driver *drv, unsigned long vm_type)
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 70008afaaf61..e309ad169e34 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -7,6 +7,7 @@
 #define __GZVM_DRV_H__
 
 #include <linux/list.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
 
@@ -25,6 +26,12 @@ struct gzvm_driver {
 	struct gzvm_version drv_version;
 };
 
+/*
+ * For the normal physical address, the highest 12 bits should be zero, so we
+ * can mask bit 62 ~ bit 52 to indicate the error physical address
+ */
+#define GZVM_PA_ERR_BAD (0x7ffULL << 52)
+
 #define INVALID_VM_ID   0xffff
 
 /*
@@ -38,11 +45,63 @@ struct gzvm_driver {
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
 
+/*
+ * The following data structures are for data transferring between driver and
+ * hypervisor, and they're aligned with hypervisor definitions
+ */
+#define GZVM_MAX_MEM_REGION	10
+
+/**
+ * struct mem_region_addr_range: identical to ffa memory constituent
+ * @address: the base IPA of the constituent memory region, aligned to 4 kiB
+ * @pg_cnt: the number of 4 kiB pages in the constituent memory region
+ * @reserved: reserved for 64bit alignment
+ */
+struct mem_region_addr_range {
+	__u64 address;
+	__u32 pg_cnt;
+	__u32 reserved;
+};
+
+struct gzvm_memory_region_ranges {
+	__u32 slot;
+	__u32 constituent_cnt;
+	__u64 total_pages;
+	__u64 gpa;
+	struct mem_region_addr_range constituents[];
+};
+
+/*
+ * A reasonable and large enough limit for the maximum number of pages a
+ * guest can use.
+ */
+#define GZVM_MEM_MAX_NR_PAGES		((1UL << 31) - 1)
+
+/**
+ * struct gzvm_memslot: VM's memory slot descriptor
+ * @base_gfn: begin of guest page frame
+ * @npages: number of pages this slot covers
+ * @userspace_addr: corresponding userspace va
+ * @vma: vma related to this userspace addr
+ * @flags: define the usage of memory region. Ex. guest memory or
+ * firmware protection
+ * @slot_id: the id is used to identify the memory slot
+ */
+struct gzvm_memslot {
+	u64 base_gfn;
+	unsigned long npages;
+	unsigned long userspace_addr;
+	struct vm_area_struct *vma;
+	u32 flags;
+	u32 slot_id;
+};
+
 /**
  * struct gzvm: the following data structures are for data transferring between
  * driver and hypervisor, and they're aligned with hypervisor definitions.
  * @gzvm_drv: the data structure is used to keep driver's information
  * @mm: userspace tied to this vm
+ * @memslot: VM's memory slot descriptor
  * @lock: lock for list_add
  * @vm_list: list head for vm list
  * @vm_id: vm id
@@ -50,6 +109,7 @@ struct gzvm_driver {
 struct gzvm {
 	struct gzvm_driver *gzvm_drv;
 	struct mm_struct *mm;
+	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
 	struct mutex lock;
 	struct list_head vm_list;
 	u16 vm_id;
@@ -64,7 +124,12 @@ void gzvm_destroy_all_vms(void);
 /* arch-dependant functions */
 int gzvm_arch_probe(struct gzvm_version drv_version,
 		    struct gzvm_version *hyp_version);
+int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
+			    phys_addr_t region);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
 
+int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn,
+			    u64 *hva_memslot);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index c26c7720fab7..59c0f790b2e6 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -22,4 +22,35 @@
 /* ioctls for /dev/gzvm fds */
 #define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
 
+/* ioctls for VM fds */
+/* for GZVM_SET_MEMORY_REGION */
+struct gzvm_memory_region {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+};
+
+#define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
+					struct gzvm_memory_region)
+
+/**
+ * struct gzvm_userspace_memory_region: gzvm userspace memory region descriptor
+ * @slot: memory slot
+ * @flags: describe the usage of userspace memory region
+ * @guest_phys_addr: guest vm's physical address
+ * @memory_size: memory size in bytes
+ * @userspace_addr: start of the userspace allocated memory
+ */
+struct gzvm_userspace_memory_region {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+};
+
+#define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
+					 struct gzvm_userspace_memory_region)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0


