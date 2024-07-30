Return-Path: <netdev+bounces-114028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA3940B6F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B92285D5C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F6195806;
	Tue, 30 Jul 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QJAy8bWP"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225E1946BB;
	Tue, 30 Jul 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327900; cv=none; b=hm96LmOVrmdmEXEFFVhlZKZtKy5VYtacyeYQbWOFjHuppGIya89hAeLYCI8R8AceWr2LxggQzT9RRil4mmkytoOgNEpQQX451yrpNI4umVCfy4bsDpzPuadOsTgczbMNi2vVpL1bxnDcPFF8FLKgcybpdphYi0m4DvCfv7VwpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327900; c=relaxed/simple;
	bh=hLKwpko3jPmIzn/l+Ob1i/eThxbpO0Q4RmFncjTMSgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHQkfLPQnTmQAfA5C2NBm16b4cIjp3yawAKzmXAjfAggrX8YfOrm/ICx9u96hfCzoj7WTtt0miABQ1sl23KxAjOdDayx598y3Mi93WQehk9pgpAFM23excE1ks2Tg2QbL+jyAig6IFIHCmJAnyL5LqQy+rlRASidgD73belCcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QJAy8bWP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3079a4164e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=929zuzDwqxG/oCm6w+Kj7pkUxYLzT5KMn7vVdKc3GbU=;
	b=QJAy8bWPx1FGogp98YecldoWzuUADCiKDcZ0J0f/jL6gOvw0relWAaoQvjI9GctxZGBkeNWSUuGY3tbZw/gCdtxFWD6vfzQH/tozr249PGiedNaAoHvxS1CmDlJIPPdfVbzzdbnJkNgnN2Sp2SoHb9u/QWfPsXR71qNY/A4Cf3I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d2ade6c8-1594-42c0-a71e-b45d7a90be56,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:6dc6a47,CLOUDID:471d11d2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3079a4164e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2065190672; Tue, 30 Jul 2024 16:24:50 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:40 +0800
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
Subject: [PATCH v12 23/24] virt: geniezone: Add support for guest VM CPU idle
Date: Tue, 30 Jul 2024 16:24:35 +0800
Message-ID: <20240730082436.9151-24-liju-clr.chen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.258700-8.000000
X-TMASE-MatchedRID: J59HFlUPY1+E9zgVMk3pXodlc1JaOB1TBLtx+64GFalPQiQvzFiGeA56
	8AvmKb9qIHkWeMeCpqXVKKZI9j/HpyvIUds2cEsbr51gSC67hpXQpOLaYmAnSOL6Uh7BMDPmYBw
	GXAXM8ZbhCzumAdv1vfdsbxOBLnf/gmtFY9zfhn4D2WXLXdz+ASlayzmQ9QV08cWgFw6wp7M4Bc
	iDm/B72vmUgJ4X8JJcpy5pc9PXgGAQ1Bhu4z110AwfhKwa9GwD3Mb2Iu2/Dne5ZjHyzYrpGitE3
	PqqwdDSdV6D0aRjv349QZ5vTAlfqrewY+nukFuIo65WJt1k1O//lBG+uXYJkEsHGbVW/dGwl124
	J4jWEmuuZ0IQ3OVGYhnlPjt/L4AXZtaV6oGFpg4Cg1rav4R3DRE2nvEP7i9RspC+xydJZuMsc0W
	LCYlGr3CJlOzBcf2ogDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/soA9xnZ1s6ia9awdpEJvNH2VEuj
	pOdvxON2so0yt6SpGD2BNjdQJbfw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.258700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BD8B641614697C78CF0CEC2928BC96B83499E2E1001476EA0DFC71EE934C934C2000:8
X-MTK: N

From: Kevenny Hsieh <kevenny.hsieh@mediatek.com>

Implement CPU idle functionality for guest VMs, allowing the guest
VM's CPU to relinquish control to the host when it enters an idle
state. Enable the host to schedule other processes, thereby reducing
CPU usage and achieving power savings.

Introduce a new capability (`enable_idle_support`) to support the idle
feature. Emulate the WFI (Wait For Interrupt) instruction for the
guest VM when it enters an idle state. Allow the host Linux kernel to
schedule other processes and enable the vCPU to enter the `wait`
state. Ensure that the vCPU can be woken up by interrupts such as the
virtual timer (vtimer) and virtio interrupts.

With the idle feature, the vCPU can efficiently enter a lower power
state, such as decreasing CPU frequency or even entering an idle
state, thereby reducing CPU usage and improving overall system power
efficiency.

Signed-off-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/vm.c               |  3 ++
 drivers/virt/geniezone/gzvm_exception.c | 46 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      | 26 +++++++++++++-
 drivers/virt/geniezone/gzvm_vm.c        | 15 ++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  7 ++++
 include/uapi/linux/gzvm.h               |  2 ++
 6 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 549d8611c8d2..d9129080536e 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -411,6 +411,9 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 	case GZVM_CAP_BLOCK_BASED_DEMAND_PAGING:
 		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
 		return ret;
+	case GZVM_CAP_ENABLE_IDLE:
+		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
+		return ret;
 	default:
 		break;
 	}
diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
index 5ffee863e378..391168a3f737 100644
--- a/drivers/virt/geniezone/gzvm_exception.c
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -5,6 +5,8 @@
 
 #include <linux/device.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
+#include <linux/sched.h>
+#include <linux/rcuwait.h>
 
 /**
  * gzvm_handle_guest_exception() - Handle guest exception
@@ -59,3 +61,47 @@ bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu)
 		return gzvm_arch_handle_guest_hvc(vcpu);
 	}
 }
+
+static void vcpu_block_wait(struct gzvm_vcpu *vcpu)
+{
+	struct rcuwait *wait = &vcpu->wait;
+
+	prepare_to_rcuwait(wait);
+
+	while (true) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (vcpu->idle_events.virtio_irq) {
+			vcpu->idle_events.virtio_irq = 0;
+			break;
+		}
+		if (vcpu->idle_events.vtimer_irq) {
+			vcpu->idle_events.vtimer_irq = 0;
+			break;
+		}
+		if (signal_pending(current))
+			break;
+		schedule();
+	}
+	finish_rcuwait(wait);
+}
+
+/**
+ * gzvm_handle_guest_idle() - Handle guest vm entering idle
+ * @vcpu: Pointer to struct gzvm_vcpu struct
+ * Return:
+ */
+int gzvm_handle_guest_idle(struct gzvm_vcpu *vcpu)
+{
+	int ret = 0;
+	u64 ns = 0;
+
+	ns = gzvm_vcpu_arch_get_timer_delay_ns(vcpu);
+
+	if (ns) {
+		gzvm_vtimer_set(vcpu, ns);
+		vcpu_block_wait(vcpu);
+		gzvm_vtimer_release(vcpu);
+	}
+
+	return ret;
+}
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index ba85a6ae04a0..247848ee126c 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -16,8 +16,29 @@
 /* maximum size needed for holding an integer */
 #define ITOA_MAX_LEN 12
 
+/**
+ * gzvm_vcpu_wakeup_all - wakes up all vCPUs associated with the specified
+ * gzvm.
+ * @gzvm: Pointer to gzvm structure.
+ */
+void gzvm_vcpu_wakeup_all(struct gzvm *gzvm)
+{
+	for (int i = 0; i < GZVM_MAX_VCPUS; i++) {
+		if (gzvm->vcpus[i]) {
+			gzvm->vcpus[i]->idle_events.virtio_irq += 1;
+			rcuwait_wake_up(&gzvm->vcpus[i]->wait);
+		}
+	}
+}
+
 static enum hrtimer_restart gzvm_vtimer_expire(struct hrtimer *hrt)
 {
+	struct gzvm_vcpu *vcpu;
+
+	vcpu = container_of(hrt, struct gzvm_vcpu, gzvm_vtimer);
+
+	gzvm_vcpu_wakeup_all(vcpu->gzvm);
+
 	return HRTIMER_NORESTART;
 }
 
@@ -111,7 +132,7 @@ static bool gzvm_vcpu_handle_mmio(struct gzvm_vcpu *vcpu)
 static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 {
 	bool need_userspace = false;
-	u64 exit_reason = 0;
+	u64 exit_reason;
 
 	if (copy_from_user(vcpu->run, argp, sizeof(struct gzvm_vcpu_run)))
 		return -EFAULT;
@@ -160,6 +181,9 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 			fallthrough;
 		case GZVM_EXIT_GZ:
 			break;
+		case GZVM_EXIT_IDLE:
+			gzvm_handle_guest_idle(vcpu);
+			break;
 		case GZVM_EXIT_UNKNOWN:
 			fallthrough;
 		default:
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index db430e532602..7a5f97e8881c 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -172,6 +172,7 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 int gzvm_irqchip_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
 			    u32 irq, bool level)
 {
+	gzvm_vcpu_wakeup_all(gzvm);
 	return gzvm_arch_inject_irq(gzvm, vcpu_idx, irq, level);
 }
 
@@ -556,6 +557,18 @@ static int setup_mem_alloc_mode(struct gzvm *vm)
 	return 0;
 }
 
+static int enable_idle_support(struct gzvm *vm)
+{
+	int ret;
+	struct gzvm_enable_cap cap = {0};
+
+	cap.cap = GZVM_CAP_ENABLE_IDLE;
+	ret = gzvm_vm_ioctl_enable_cap(vm, &cap, NULL);
+	if (ret)
+		pr_info("Hypervisor doesn't support idle\n");
+	return ret;
+}
+
 static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 {
 	int ret;
@@ -603,6 +616,8 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 
 	pr_debug("VM-%u is created\n", gzvm->vm_id);
 
+	enable_idle_support(gzvm);
+
 	return gzvm;
 }
 
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 3c460281cdd4..61f3ae4ee793 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -108,6 +108,11 @@ struct gzvm_vcpu {
 	struct gzvm_vcpu_run *run;
 	struct gzvm_vcpu_hwstate *hwstate;
 	struct hrtimer gzvm_vtimer;
+	struct {
+		u32 vtimer_irq;
+		u32 virtio_irq;
+	} idle_events;
+	struct rcuwait wait;
 };
 
 struct gzvm_pinned_page {
@@ -235,6 +240,8 @@ bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
 int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa);
 bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 bool gzvm_arch_handle_guest_hvc(struct gzvm_vcpu *vcpu);
+int gzvm_handle_guest_idle(struct gzvm_vcpu *vcpu);
+void gzvm_vcpu_wakeup_all(struct gzvm *gzvm);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 1cf89213a383..1fe483ef2ed5 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -21,6 +21,7 @@
 /* query hypervisor supported block-based demand page */
 #define GZVM_CAP_BLOCK_BASED_DEMAND_PAGING	0x9201
 #define GZVM_CAP_ENABLE_DEMAND_PAGING	0x9202
+#define GZVM_CAP_ENABLE_IDLE		0x9203
 
 /* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
 #define GZVM_CAP_PVM_SET_PVMFW_GPA		0
@@ -187,6 +188,7 @@ enum {
 	GZVM_EXIT_SYSTEM_EVENT = 0x92920008,
 	GZVM_EXIT_SHUTDOWN = 0x92920009,
 	GZVM_EXIT_GZ = 0x9292000a,
+	GZVM_EXIT_IDLE = 0x9292000b,
 };
 
 /* exception definitions of GZVM_EXIT_EXCEPTION */
-- 
2.18.0


