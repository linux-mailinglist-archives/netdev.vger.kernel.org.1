Return-Path: <netdev+bounces-144782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C39C86E7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108A3287391
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832661F81A6;
	Thu, 14 Nov 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SKeGhNQX"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC721F6669;
	Thu, 14 Nov 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578897; cv=none; b=cgbzwq6LS3DsIF99ZVy6ltdotrmKZaUt7AhZOddliTfkat3udvlO4fMRXPsJNSIJ2EKQa66y5mvLXF9LirLDazE45pnB/LAnyUoaiIBwTO0YsbFxDlyDQJQChiXZCERors6UEM5O+2y4J8U/qWjTkkaPLgXaQGkRL9eFdIkpXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578897; c=relaxed/simple;
	bh=VqcJfXoXXFBv3SqkuzVK7YJDLjCRRhHL433r9h10lg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VD2hwdk4kSs7SMgr2HQCBQT0/Rc+LMsdK3ZZq5TzL2uMlfW473QSvPlnlYXqvZS2FQA8vmfZ6zicyVuYYJxM8S0pZGXDtxWdmoPhGnJz7dTfVdHs7skxKNQWbzaCxQHUkn2PfwMib+7yvSozCFsju/p7W9lqk02V4OMork3ccIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SKeGhNQX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58a48182a27011ef99858b75a2457dd9-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=slipo85jeU4x0/6UQp38NN3nKrQSFTaT3dRImDEbsFI=;
	b=SKeGhNQX8Wh52YyOyWLxO2JQcSdzfnZA7oDOJgxDlYviKQX/ycSuV+/DTtWiFNvkQ3yGAnGOtj/TsP2sgCyxAcyZAkxTcQKt59Bg/9vh/7IjBeY9iTVyGh9aXf/0szEbfhpl+ztMP2zBiLdz0ar6hAm93HijMKGFl6V3WnjwTk8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:319f6a7f-2c6b-47a9-b3cf-8d874c3fed72,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:e56b1307-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 58a48182a27011ef99858b75a2457dd9-20241114
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1720630925; Thu, 14 Nov 2024 18:08:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:06 +0800
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
Subject: [PATCH v13 22/25] virt: geniezone: Add support for virtual timer migration
Date: Thu, 14 Nov 2024 18:07:59 +0800
Message-ID: <20241114100802.4116-23-liju-clr.chen@mediatek.com>
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

From: Willix Yeh <chi-shen.yeh@mediatek.com>

Introduce a mechanism to migrate the ARM64 virtual timer from the
guest VM to the host Linux system when the execution context switches
from the guest VM to the host. Ensure that the guest VM's virtual
timer continues to operate seamlessly after the context switch, given
that ARM64 has only one virtual timer.

Translate the remaining time before the VM timer expires into the host
Linux system by setting the remaining time on an hrtimer. This allows
the guest VM to maintain its timer operations without interruption.

Enable seamless timer operation during idle states. When a VM enters
an idle state and the execution context returns to the host Linux,
ensure that the timer continues to operate seamlessly, preventing
disruption to the guest VM's timing operations.

Signed-off-by: Willix Yeh <chi-shen.yeh@mediatek.com>
Co-developed-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h | 15 +++++++++++++++
 arch/arm64/geniezone/vcpu.c             | 16 ++++++++++++++++
 arch/arm64/geniezone/vm.c               | 24 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |  4 ++++
 drivers/virt/geniezone/gzvm_vcpu.c      | 24 ++++++++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  7 +++++++
 6 files changed, 90 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 8f5d8528ab96..df16e33f6b74 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -7,6 +7,7 @@
 #define __GZVM_ARCH_COMMON_H__
 
 #include <linux/arm-smccc.h>
+#include <linux/clocksource.h>
 
 enum {
 	GZVM_FUNC_CREATE_VM = 0,
@@ -85,6 +86,10 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
  * @lr: The array of LRs(list registers).
  * @vtimer_offset: The offset maintained by hypervisor that is host cycle count
  *                 when guest VM startup.
+ * @vtimer_delay: The remaining time before the next timer tick is triggered
+ *                while the VM is running.
+ * @vtimer_migrate: Indicates whether the guest virtual timer needs to be
+ *                  migrated to the host software timer.
  *
  * - Keep the same layout of hypervisor data struct.
  * - Sync list registers back for acking virtual device interrupt status.
@@ -94,8 +99,18 @@ struct gzvm_vcpu_hwstate {
 	__le32 __pad;
 	__le64 lr[GIC_V3_NR_LRS];
 	__le64 vtimer_offset;
+	__le64 vtimer_delay;
+	__le32 vtimer_migrate;
 };
 
+struct timecycle {
+	u32 mult;
+	u32 shift;
+};
+
+u32 gzvm_vtimer_get_clock_mult(void);
+u32 gzvm_vtimer_get_clock_shift(void);
+
 static inline unsigned int
 assemble_vm_vcpu_tuple(u16 vmid, u16 vcpuid)
 {
diff --git a/arch/arm64/geniezone/vcpu.c b/arch/arm64/geniezone/vcpu.c
index e12ea9cb4941..595f16904b99 100644
--- a/arch/arm64/geniezone/vcpu.c
+++ b/arch/arm64/geniezone/vcpu.c
@@ -11,6 +11,22 @@
 #include <linux/soc/mediatek/gzvm_drv.h>
 #include "gzvm_arch_common.h"
 
+u64 gzvm_vcpu_arch_get_timer_delay_ns(struct gzvm_vcpu *vcpu)
+{
+	u64 ns;
+
+	if (vcpu->hwstate->vtimer_migrate) {
+		ns = clocksource_cyc2ns(le64_to_cpu(vcpu->hwstate->vtimer_delay),
+					gzvm_vtimer_get_clock_mult(),
+					gzvm_vtimer_get_clock_shift());
+	} else {
+		ns = 0;
+	}
+
+	/* 0: no migrate, otherwise: migrate  */
+	return ns;
+}
+
 int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
 				  bool is_write, __u64 *data)
 {
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 026c1980d054..fccdcd5b8c75 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -15,6 +15,18 @@
 
 #define PAR_PA47_MASK GENMASK_ULL(47, 12)
 
+static struct timecycle clock_scale_factor;
+
+u32 gzvm_vtimer_get_clock_mult(void)
+{
+	return clock_scale_factor.mult;
+}
+
+u32 gzvm_vtimer_get_clock_shift(void)
+{
+	return clock_scale_factor.shift;
+}
+
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
  * @a0: arguments passed in registers 0
@@ -90,6 +102,18 @@ int gzvm_arch_probe(struct gzvm_version drv_version,
 	return 0;
 }
 
+int gzvm_arch_drv_init(void)
+{
+	/* timecycle init mult shift */
+	clocks_calc_mult_shift(&clock_scale_factor.mult,
+			       &clock_scale_factor.shift,
+			       arch_timer_get_cntfrq(),
+			       NSEC_PER_SEC,
+			       30);
+
+	return 0;
+}
+
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 			    phys_addr_t region)
 {
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index 1816eecfcefb..0ec15c33111e 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -233,6 +233,10 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 		 gzvm_drv.hyp_version.major, gzvm_drv.hyp_version.minor,
 		 gzvm_drv.hyp_version.sub);
 
+	ret = gzvm_arch_drv_init();
+	if (ret)
+		return ret;
+
 	ret = misc_register(&gzvm_dev);
 	if (ret)
 		return ret;
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 3b146148abf3..ba85a6ae04a0 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -16,6 +16,28 @@
 /* maximum size needed for holding an integer */
 #define ITOA_MAX_LEN 12
 
+static enum hrtimer_restart gzvm_vtimer_expire(struct hrtimer *hrt)
+{
+	return HRTIMER_NORESTART;
+}
+
+static void gzvm_vtimer_init(struct gzvm_vcpu *vcpu)
+{
+	/* gzvm_vtimer init based on hrtimer */
+	hrtimer_init(&vcpu->gzvm_vtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	vcpu->gzvm_vtimer.function = gzvm_vtimer_expire;
+}
+
+void gzvm_vtimer_set(struct gzvm_vcpu *vcpu, u64 ns)
+{
+	hrtimer_start(&vcpu->gzvm_vtimer, ktime_add_ns(ktime_get(), ns), HRTIMER_MODE_ABS_HARD);
+}
+
+void gzvm_vtimer_release(struct gzvm_vcpu *vcpu)
+{
+	hrtimer_cancel(&vcpu->gzvm_vtimer);
+}
+
 static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu,
 				     void __user *argp,
 				     bool is_write)
@@ -193,6 +215,7 @@ static void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
 	if (!vcpu)
 		return;
 
+	hrtimer_cancel(&vcpu->gzvm_vtimer);
 	gzvm_arch_destroy_vcpu(vcpu->gzvm->vm_id, vcpu->vcpuid);
 	/* clean guest's data */
 	memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
@@ -271,6 +294,7 @@ int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
 		goto free_vcpu_run;
 	gzvm->vcpus[cpuid] = vcpu;
 
+	gzvm_vtimer_init(vcpu);
 	return ret;
 
 free_vcpu_run:
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 62e00fb06269..901bc2fe28f1 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -129,6 +129,7 @@ struct gzvm_vcpu {
 	struct mutex lock;
 	struct gzvm_vcpu_run *run;
 	struct gzvm_vcpu_hwstate *hwstate;
+	struct hrtimer gzvm_vtimer;
 };
 
 struct gzvm_pinned_page {
@@ -242,11 +243,17 @@ int gzvm_vm_allocate_guest_page(struct gzvm *gzvm, struct gzvm_memslot *slot,
 int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
 int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
 				  bool is_write, __u64 *data);
+int gzvm_arch_drv_init(void);
 int gzvm_arch_create_vcpu(u16 vm_id, int vcpuid, void *run);
 int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
 int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
 int gzvm_arch_inform_exit(u16 vm_id);
 
+u64 gzvm_vcpu_arch_get_timer_delay_ns(struct gzvm_vcpu *vcpu);
+
+void gzvm_vtimer_set(struct gzvm_vcpu *vcpu, u64 ns);
+void gzvm_vtimer_release(struct gzvm_vcpu *vcpu);
+
 int gzvm_find_memslot(struct gzvm *vm, u64 gpa);
 int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu);
 bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
-- 
2.18.0


