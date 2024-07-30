Return-Path: <netdev+bounces-114017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB075940B47
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1996F1C22EC2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBE194099;
	Tue, 30 Jul 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fDZSq16f"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879411922F3;
	Tue, 30 Jul 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327895; cv=none; b=M5FLBfLKPLNeB5xQIq/S0XKbIpB9lID4eNuXxzRuNe9fo/EkUat8qTAsRWwTLlAHB6YZ7zRXX9TQ/wlSxJ7nAeAAehM7Ocp2WEv358uKUVQYQbZ/38REbkcLxU2lar688XLBNZ0KyWxrz3un1yIMPtMTNocVF3nVV76zNyFlxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327895; c=relaxed/simple;
	bh=OXcceCo0ff7jLhilVxpJCUR3cX1T/rY48d1q+qS+cS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wjmxq1wODoYKB+299tlHZ7KKTEx60PXedFvqImoJE2/8jMbEY0Y1yrE2J7625OjFf8m1Sy+TVMr8oxH00qfyoj/YYcKRmNeoY2a9YWkVRl5CMpdegiMMu8PRJJ4+VEBZ9nBcqNgbHCK446ys9n9Q7zGAoDzISP7Tsrj0yphIWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fDZSq16f; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 297415024e4d11ef87684b57767b52b1-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FXPpwQ2vjJvNjtU6FTHBdIGUQHwc9Q+WOjEwsJk40HU=;
	b=fDZSq16f7waO6FU4t/O+isLl6skYk9NY3tUGTF+mNou5qWzp+SkMOjn84O4Pa1tlDptly60Oy1KPxbtZi9nUr1avBn/APdcrAazbzfcSYg7NdX59OlitzVBk0Z7JDX6gebrs5rrvPkb17JHmqQfhgl6E2H97q/YnIsqSCNxondQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0d3002b1-5880-4720-b684-76ca74c46786,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6dc6a47,CLOUDID:67970a0e-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 297415024e4d11ef87684b57767b52b1-20240730
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 507580728; Tue, 30 Jul 2024 16:24:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:38 +0800
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
	<linux-mediatek@lists.infradead.org>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>, Chi-shen Yeh
	<Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: [PATCH v12 15/24] virt: geniezone: Add memory pin/unpin support
Date: Tue, 30 Jul 2024 16:24:27 +0800
Message-ID: <20240730082436.9151-16-liju-clr.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.665300-8.000000
X-TMASE-MatchedRID: Iv14ABKclhg/TqR73SoO885Scd0yVs+bbd6rGhWOAwQCSZrAnTS0Brps
	GokK+C//AuwgUdYPZkXW0e5KCL9fbo0GdWKgGbBhMIiU395I8H3QeN4A2h64ncA5YKm8dwM63AG
	yPNT+2THhlCpgdm2rGFijcb6u/Gs1qjvsBy5CHDsD2WXLXdz+Ae3+iQEtoSj4FLXUWU5hGiF0Pi
	IFfRms6CFGk2ccyuPFSJ1jQcCKXwZPDPfmo+ftx8Ed6AVHFtpjK5Mx6KzrJcNKb99LaADG+tzuz
	yvdSEu2w3bvXc5S63u0rE5AMK32BLSYnj+K473ZyeVujmXuYYXzWEMQjooUzQZbeEWcL03VnvoH
	IZ6bqqQpFI+5rucNwRcDcEF6XUZOHyzWFbk8FLXDa1qWPNOExoED+PNzPecBCAfRfqq1Gm6fWSI
	EJ+NgXTH5/F/NumlT/4RBY1ijhrC491OKWTeIToxVBvj1jbcj1VbeL5WocX+48McbajxWsOLSdV
	P2tZn5acNSxwfY1qesJ2NEVUY7679ZdlL8eonaC24oEZ6SpSmcfuxsiY4QFNdblQqooXxgBBRku
	ai0b1fsT05LAFRv2DD1sl5SpFm6M+hzE/YoLpmtvlgDjR7qkAIw3xAS16lq29irEiOAsG87xYCA
	Pzt1r2/H7LhIKjO20bWl8H0Q2RO0ML47Km+X9EYOAQXCbpqgPpCuffGH9zI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.665300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 975F109DB836ED24E5D3523B5A918B80F9A4BF60A15647365EABD73C935CC5AA2000:8
X-MTK: N

From: Jerry Wang <ze-yu.wang@mediatek.com>

Protected VM's memory cannot be swapped out because the memory pages are
protected from host access.

Once host accesses to those protected pages, the hardware exception is
triggered and may crash the host. So, we have to make those protected
pages be ineligible for swapping or merging by the host kernel to avoid
host access. To do so, we pin the page when it is assigned (donated) to
VM and unpin when VM relinquish the pages or is destroyed. Besides, the
protected VM’s memory requires hypervisor to clear the content before
returning to host, but VMM may free those memory before clearing, it
will result in those memory pages are reclaimed and reused before
totally clearing. Using pin/unpin can also avoid the above problems.

The implementation is described as follows.
- Use rb_tree to store pinned memory pages.
- Pin the page when handling page fault.
- Unpin the pages when VM relinquish the pages or is destroyed.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Co-developed-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/vm.c             |   8 +-
 drivers/virt/geniezone/Makefile       |   2 +-
 drivers/virt/geniezone/gzvm_mmu.c     | 103 ++++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vm.c      |  21 ++++++
 include/linux/soc/mediatek/gzvm_drv.h |  14 ++++
 5 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_mmu.c

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index db16716f5b8d..109e4125739a 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -211,12 +211,14 @@ static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
  * @gfn: Guest frame number.
  * @total_pages: Total page numbers.
  * @slot: Pointer to struct gzvm_memslot.
+ * @gzvm: Pointer to struct gzvm.
  *
  * Return: how many pages we've fill in, negative if error
  */
 static int fill_constituents(struct mem_region_addr_range *consti,
 			     int *consti_cnt, int max_nr_consti, u64 gfn,
-			     u32 total_pages, struct gzvm_memslot *slot)
+			     u32 total_pages, struct gzvm_memslot *slot,
+			     struct gzvm *gzvm)
 {
 	u64 pfn = 0, prev_pfn = 0, gfn_end = 0;
 	int nr_pages = 0;
@@ -227,6 +229,8 @@ static int fill_constituents(struct mem_region_addr_range *consti,
 	gfn_end = gfn + total_pages;
 
 	while (i < max_nr_consti && gfn < gfn_end) {
+		if (gzvm_vm_allocate_guest_page(gzvm, slot, gfn, &pfn) != 0)
+			return -EFAULT;
 		if (pfn == (prev_pfn + 1)) {
 			consti[i].pg_cnt++;
 		} else {
@@ -282,7 +286,7 @@ int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id)
 		nr_pages = fill_constituents(region->constituents,
 					     &region->constituent_cnt,
 					     max_nr_consti, gfn,
-					     remain_pages, memslot);
+					     remain_pages, memslot, gzvm);
 
 		if (nr_pages < 0) {
 			pr_err("Failed to fill constituents\n");
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index bc5ae49f2407..e0451145215d 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -8,4 +8,4 @@ GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
 	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o \
-	  $(GZVM_DIR)/gzvm_ioeventfd.o
+	  $(GZVM_DIR)/gzvm_ioeventfd.o $(GZVM_DIR)/gzvm_mmu.o
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
new file mode 100644
index 000000000000..743df8976dfd
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/soc/mediatek/gzvm_drv.h>
+
+static int cmp_ppages(struct rb_node *node, const struct rb_node *parent)
+{
+	struct gzvm_pinned_page *a = container_of(node,
+						  struct gzvm_pinned_page,
+						  node);
+	struct gzvm_pinned_page *b = container_of(parent,
+						  struct gzvm_pinned_page,
+						  node);
+
+	if (a->ipa < b->ipa)
+		return -1;
+	if (a->ipa > b->ipa)
+		return 1;
+	return 0;
+}
+
+/* Invoker of this function is responsible for locking */
+static int gzvm_insert_ppage(struct gzvm *vm, struct gzvm_pinned_page *ppage)
+{
+	if (rb_find_add(&ppage->node, &vm->pinned_pages, cmp_ppages))
+		return -EEXIST;
+	return 0;
+}
+
+static int pin_one_page(struct gzvm *vm, unsigned long hva, u64 gpa,
+			struct page **out_page)
+{
+	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
+	struct gzvm_pinned_page *ppage = NULL;
+	struct mm_struct *mm = current->mm;
+	struct page *page = NULL;
+	int ret;
+
+	ppage = kmalloc(sizeof(*ppage), GFP_KERNEL_ACCOUNT);
+	if (!ppage)
+		return -ENOMEM;
+
+	mmap_read_lock(mm);
+	ret = pin_user_pages(hva, 1, flags, &page);
+	mmap_read_unlock(mm);
+
+	if (ret != 1 || !page) {
+		kfree(ppage);
+		return -EFAULT;
+	}
+
+	ppage->page = page;
+	ppage->ipa = gpa;
+
+	mutex_lock(&vm->mem_lock);
+	ret = gzvm_insert_ppage(vm, ppage);
+
+	/**
+	 * The return of -EEXIST from gzvm_insert_ppage is considered an
+	 * expected behavior in this context.
+	 * This situation arises when two or more VCPUs are concurrently
+	 * engaged in demand paging handling. The initial VCPU has already
+	 * allocated and pinned a page, while the subsequent VCPU attempts
+	 * to pin the same page again. As a result, we prompt the unpinning
+	 * and release of the allocated structure, followed by a return 0.
+	 */
+	if (ret == -EEXIST) {
+		kfree(ppage);
+		unpin_user_pages(&page, 1);
+		ret = 0;
+	}
+	mutex_unlock(&vm->mem_lock);
+	*out_page = page;
+
+	return ret;
+}
+
+int gzvm_vm_allocate_guest_page(struct gzvm *vm, struct gzvm_memslot *slot,
+				u64 gfn, u64 *pfn)
+{
+	struct page *page = NULL;
+	unsigned long hva;
+	int ret;
+
+	if (gzvm_gfn_to_hva_memslot(slot, gfn, (u64 *)&hva) != 0)
+		return -EINVAL;
+
+	ret = pin_one_page(vm, hva, PFN_PHYS(gfn), &page);
+	if (ret != 0)
+		return ret;
+
+	if (page == NULL)
+		return -EFAULT;
+	/**
+	 * As `pin_user_pages` already gets the page struct, we don't need to
+	 * call other APIs to reduce function call overhead.
+	 */
+	*pfn = page_to_pfn(page);
+
+	return 0;
+}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 5ae5abff2955..b4a68ba905b1 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -298,6 +298,22 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	return ret;
 }
 
+/* Invoker of this function is responsible for locking */
+static void gzvm_destroy_all_ppage(struct gzvm *gzvm)
+{
+	struct gzvm_pinned_page *ppage;
+	struct rb_node *node;
+
+	node = rb_first(&gzvm->pinned_pages);
+	while (node) {
+		ppage = rb_entry(node, struct gzvm_pinned_page, node);
+		unpin_user_pages_dirty_lock(&ppage->page, 1, true);
+		node = rb_next(node);
+		rb_erase(&ppage->node, &gzvm->pinned_pages);
+		kfree(ppage);
+	}
+}
+
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
@@ -314,6 +330,9 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_unlock(&gzvm->lock);
 
+	/* No need to lock here becauese it's single-threaded execution */
+	gzvm_destroy_all_ppage(gzvm);
+
 	kfree(gzvm);
 }
 
@@ -349,6 +368,8 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	gzvm->vm_id = ret;
 	gzvm->mm = current->mm;
 	mutex_init(&gzvm->lock);
+	mutex_init(&gzvm->mem_lock);
+	gzvm->pinned_pages = RB_ROOT;
 
 	ret = gzvm_vm_irqfd_init(gzvm);
 	if (ret) {
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 54ac91670611..7d2f0b07ad84 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
 #include <linux/srcu.h>
+#include <linux/rbtree.h>
 
 /*
  * For the normal physical address, the highest 12 bits should be zero, so we
@@ -97,6 +98,12 @@ struct gzvm_vcpu {
 	struct gzvm_vcpu_hwstate *hwstate;
 };
 
+struct gzvm_pinned_page {
+	struct rb_node node;
+	struct page *page;
+	u64 ipa;
+};
+
 /**
  * struct gzvm: the following data structures are for data transferring between
  * driver and hypervisor, and they're aligned with hypervisor definitions.
@@ -112,6 +119,8 @@ struct gzvm_vcpu {
  * @irq_ack_notifier_list: list head for irq ack notifier
  * @irq_srcu: structure data for SRCU(sleepable rcu)
  * @irq_lock: lock for irq injection
+ * @pinned_pages: use rb-tree to record pin/unpin page
+ * @mem_lock: lock for memory operations
  */
 struct gzvm {
 	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
@@ -135,6 +144,9 @@ struct gzvm {
 	struct hlist_head irq_ack_notifier_list;
 	struct srcu_struct irq_srcu;
 	struct mutex irq_lock;
+
+	struct rb_root pinned_pages;
+	struct mutex mem_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -160,6 +172,8 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn,
 			    u64 *hva_memslot);
 int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id);
+int gzvm_vm_allocate_guest_page(struct gzvm *gzvm, struct gzvm_memslot *slot,
+				u64 gfn, u64 *pfn);
 
 int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
 int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
-- 
2.18.0


