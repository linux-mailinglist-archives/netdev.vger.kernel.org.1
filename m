Return-Path: <netdev+bounces-144799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BEC9C8712
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DC52824D0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85F1FAEFB;
	Thu, 14 Nov 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U5dWbKxG"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A31F8F1D;
	Thu, 14 Nov 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578902; cv=none; b=XzNJbqfeR7LZ7LSXVzf5NL/+BvpWPWZsDXFaT0Rq5cbQl6b70/Zc80FcT1Bocdkqq9S7f+ChiUFLzT75uNliQbv1maXEH7JgcPGtWUshBb+sr38dlXJ3i8GX8qDz9OjMpIzuaX2hZSdNawwxglEuP5HdaTbc64hAE/KdXw3J8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578902; c=relaxed/simple;
	bh=8NKuoOg75JhwHkLKnxA1sr9ZsZYcDBPVWjHlfiLi0rE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXUijFVwTwBood87wqInWPFhMMHrHtx8kOes6baVml3q4mBrA6VrpyqpNT38Z09xJULdJgwBb/b0MmPqLis8qq6X4TfpiTqkc9hCOLK6iUSdKzyynfcil66C0PpTIHTm+86xfI/iMVmfxNck0a4RFNDysqboe87cnZ1TeM+fJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U5dWbKxG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 590c1deca27011ef99858b75a2457dd9-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kJib80vtMQ+j8z3Fr/DFzZp66roaGSj4aK6eGZ/xOt0=;
	b=U5dWbKxGD9R61cqlMsTR5Q/JPSz7YTafL6r+hIezdZAJypDUrT21tFDT4m0Nfon/c1mn9JP0T0Ov9BrEqPDSrsMgJl5RvFWjE6u8BUXWGsPxPg+1dIcrdHpk8e8fh096cFscYgpFbdqQn9PotaT7iBrYhQOcz0pUtrGoYAKK/50=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:95cc1b4a-5f90-49d2-a999-43f096e58e85,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:156c1307-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 590c1deca27011ef99858b75a2457dd9-20241114
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 778533351; Thu, 14 Nov 2024 18:08:08 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 02:08:07 -0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:07 +0800
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
Subject: [PATCH v13 25/25] virt: geniezone: Reduce blocked duration in hypervisor when destroying a VM
Date: Thu, 14 Nov 2024 18:08:02 +0800
Message-ID: <20241114100802.4116-26-liju-clr.chen@mediatek.com>
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

Reduce the blocked duration in the hypervisor when destroying a VM
by splitting a single hypercall into multiple calls. Previously, the
hypervisor could be blocked for an extended period when destroying a VM, as
the entire process was handled in a single hypercall. This could lead to
performance degradation because the scheduler does not have chances to
schedule other tasks when the hypercall is processing by the hypervisor.

By splitting the destruction process into multiple smaller hypercalls,
significantly reduce the blocked duration in the hypervisor. Additionally,
making the amount of each call adjustable provides flexibility to optimize
the process based on different workloads and system configurations.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/vm.c             | 27 ++++++++++--
 drivers/virt/geniezone/gzvm_main.c    | 62 +++++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vm.c      |  2 +-
 include/linux/soc/mediatek/gzvm_drv.h |  7 ++-
 include/uapi/linux/gzvm.h             |  1 +
 5 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index cfd0aeb865e5..fb4e5dd41002 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -175,12 +175,18 @@ int gzvm_arch_create_vm(unsigned long vm_type)
 	return ret ? ret : res.a1;
 }
 
-int gzvm_arch_destroy_vm(u16 vm_id)
+int gzvm_arch_destroy_vm(u16 vm_id, u64 destroy_page_gran)
 {
 	struct arm_smccc_res res;
+	int ret;
+
+	do {
+		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id,
+					   destroy_page_gran, 0, 0,
+					   0, 0, 0, &res);
+	} while (ret == -EAGAIN);
 
-	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0,
-				    0, 0, &res);
+	return ret;
 }
 
 int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
@@ -241,6 +247,21 @@ int gzvm_arch_query_hyp_batch_pages(struct gzvm_enable_cap *cap,
 	return ret;
 }
 
+int gzvm_arch_query_destroy_batch_pages(struct gzvm_enable_cap *cap,
+					void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+	int ret;
+
+	ret = gzvm_arch_enable_cap(cap, &res);
+	// destroy page batch size should be power of 2
+	if (ret || ((res.a1 & (res.a1 - 1)) != 0))
+		return -EINVAL;
+
+	cap->args[0] = res.a1;
+	return ret;
+}
+
 /**
  * gzvm_vm_ioctl_get_pvmfw_size() - Get pvmfw size from hypervisor, return
  *				    in x1, and return to userspace in args
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index 0ec15c33111e..38a2406a16bd 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -49,6 +49,33 @@ static ssize_t demand_paging_batch_pages_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t destroy_batch_pages_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf)
+{
+	return sprintf(buf, "%u\n", gzvm_drv.destroy_batch_pages);
+}
+
+static ssize_t destroy_batch_pages_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	int ret;
+	u32 temp;
+
+	ret = kstrtoint(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
+
+	// destroy page batch size should be power of 2
+	if ((temp & (temp - 1)) != 0)
+		return -EINVAL;
+
+	gzvm_drv.destroy_batch_pages = temp;
+
+	return count;
+}
+
 /* /sys/kernel/gzvm/demand_paging_batch_pages */
 static struct kobj_attribute demand_paging_batch_pages_attr = {
 		.attr = {
@@ -59,6 +86,16 @@ static struct kobj_attribute demand_paging_batch_pages_attr = {
 		.store = demand_paging_batch_pages_store,
 };
 
+/* /sys/kernel/gzvm/destroy_batch_pages */
+static struct kobj_attribute destroy_batch_pages_attr = {
+		.attr = {
+			.name = "destroy_batch_pages",
+			.mode = 0660,
+		},
+		.show = destroy_batch_pages_show,
+		.store = destroy_batch_pages_store,
+};
+
 static int gzvm_drv_sysfs_init(void)
 {
 	int ret = 0;
@@ -73,6 +110,11 @@ static int gzvm_drv_sysfs_init(void)
 	if (ret)
 		pr_debug("failed to create demand_batch_pages in /sys/kernel/gzvm\n");
 
+	ret = sysfs_create_file(gzvm_drv.sysfs_root_dir,
+				&destroy_batch_pages_attr.attr);
+	if (ret)
+		pr_debug("failed to create destroy_batch_pages in /sys/kernel/gzvm\n");
+
 	return ret;
 }
 
@@ -124,6 +166,8 @@ int gzvm_err_to_errno(unsigned long err)
 		return -EOPNOTSUPP;
 	case ERR_FAULT:
 		return -EFAULT;
+	case ERR_BUSY:
+		return -EAGAIN;
 	default:
 		break;
 	}
@@ -220,6 +264,20 @@ static int gzvm_query_hyp_batch_pages(void)
 	return ret;
 }
 
+static int gzvm_query_destroy_batch_pages(void)
+{
+	int ret;
+	struct gzvm_enable_cap cap = {0};
+
+	gzvm_drv.destroy_batch_pages = GZVM_DRV_DESTROY_PAGING_BATCH_PAGES;
+	cap.cap = GZVM_CAP_QUERY_DESTROY_BATCH_PAGES;
+
+	ret = gzvm_arch_query_destroy_batch_pages(&cap, NULL);
+	if (!ret)
+		gzvm_drv.destroy_batch_pages = cap.args[0];
+	return ret;
+}
+
 static int gzvm_drv_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -257,6 +315,10 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = gzvm_query_destroy_batch_pages();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 999c8c586d7b..43b6cf8b7d3f 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -360,7 +360,7 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	gzvm_vm_irqfd_release(gzvm);
 	gzvm_destroy_vcpus(gzvm);
-	gzvm_arch_destroy_vm(gzvm->vm_id);
+	gzvm_arch_destroy_vm(gzvm->vm_id, gzvm->gzvm_drv->destroy_batch_pages);
 
 	mutex_lock(&gzvm_list_lock);
 	list_del(&gzvm->vm_list);
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 8fc6c6f54227..b234edb3b9f3 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -30,6 +30,7 @@ struct gzvm_driver {
 
 	struct kobject *sysfs_root_dir;
 	u32 demand_paging_batch_pages;
+	u32 destroy_batch_pages;
 
 	struct dentry *gzvm_debugfs_dir;
 };
@@ -53,6 +54,7 @@ struct gzvm_driver {
 #define ERR_INVALID_ARGS        (-8)
 #define ERR_NOT_SUPPORTED       (-24)
 #define ERR_NOT_IMPLEMENTED     (-27)
+#define ERR_BUSY                (-33)
 #define ERR_FAULT               (-40)
 #define GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID       1
 
@@ -68,6 +70,7 @@ struct gzvm_driver {
 #define GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE	(PMD_SIZE) /* 2MB */
 #define GZVM_DRV_DEMAND_PAGING_BATCH_PAGES	\
 	(GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE)
+#define GZVM_DRV_DESTROY_PAGING_BATCH_PAGES	(128)
 
 #define GZVM_MAX_DEBUGFS_DIR_NAME_SIZE  20
 #define GZVM_MAX_DEBUGFS_VALUE_SIZE	20
@@ -225,12 +228,14 @@ int gzvm_arch_probe(struct gzvm_version drv_version,
 		    struct gzvm_version *hyp_version);
 int gzvm_arch_query_hyp_batch_pages(struct gzvm_enable_cap *cap,
 				    void __user *argp);
+int gzvm_arch_query_destroy_batch_pages(struct gzvm_enable_cap *cap,
+					void __user *argp);
 
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 			    phys_addr_t region);
 int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
 int gzvm_arch_create_vm(unsigned long vm_type);
-int gzvm_arch_destroy_vm(u16 vm_id);
+int gzvm_arch_destroy_vm(u16 vm_id, u64 destroy_page_gran);
 int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 			u64 nr_pages);
 int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index d69e1abb21a0..87574bdc5c48 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -23,6 +23,7 @@
 #define GZVM_CAP_ENABLE_DEMAND_PAGING	0x9202
 #define GZVM_CAP_ENABLE_IDLE		0x9203
 #define GZVM_CAP_QUERY_HYP_BATCH_PAGES	0x9204
+#define GZVM_CAP_QUERY_DESTROY_BATCH_PAGES	0x9205
 
 /* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
 #define GZVM_CAP_PVM_SET_PVMFW_GPA		0
-- 
2.18.0


