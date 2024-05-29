Return-Path: <netdev+bounces-98915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0B8D3242
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D677B29161
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B58177983;
	Wed, 29 May 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oh56RVps"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F924169AD7;
	Wed, 29 May 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972177; cv=none; b=drKVVNVJJGgjZ3ZGnhTY5OReFRTH0ZKJyzB7DLZdwVsqaOZLLcFDraODIAR/66JqTquz58piymvIsr6ZJD9k7kYGIcSJWFhcY4TKwhkqxjmpYpTJVpjOtZDgoEZPCkDc3Gkk1z/xgYJklRFQz69UutcuIF36x5RdD1XcjLTXaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972177; c=relaxed/simple;
	bh=m5v0wlc+z69409+UfsANhJw11e5iBbIOJsr5b/918KA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utMObqZP5INZukp3+wvc4c44eOO76WNDBswsXptnSSDojZV938JMjJyTRkfXx2r5urNUO7afBFIo9sjicA3BMk5vqnCbPO94NBfurSmJCWoEQ/wA/CIclnXvMIxASsG149wiM29H6y3xqvF7qGIJoHGg0T+2EL2VHwA0vtdyQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oh56RVps; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6b2d689a1d9711ef8c37dd7afa272265-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZGP8oELGPcLL2K0/k8Qv5hMob1JHaJDVAJcSoqVgo+Y=;
	b=oh56RVpsgk0kRxwS22BE6exOjXnORnmZw1ET+023wLRs+OJOfxnpm1AEQ58SLmozcN4LiAwzN+JcjilouVotVMP4f1Kl93iVnz3rAQzEPulWdiR2pb7uQtmMkAmXF7Fvvnz4xJjqho+bsW5G+xwj6WC8KrNC2PP/gIxG1EThljo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e172bb7e-2741-470d-8534-68f124b30705,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:393d96e,CLOUDID:daf35b93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6b2d689a1d9711ef8c37dd7afa272265-20240529
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 80889248; Wed, 29 May 2024 16:42:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 16:42:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 16:42:42 +0800
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
Subject: [PATCH v11 21/21] virt: geniezone: Enable PTP for synchronizing time between host and guest VMs
Date: Wed, 29 May 2024 16:42:39 +0800
Message-ID: <20240529084239.11478-22-liju-clr.chen@mediatek.com>
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
X-TM-AS-Result: No-10--10.205400-8.000000
X-TMASE-MatchedRID: y128Pza/oi5PB4rXagQZ+5LPLrFS265P4Ob1SHQRSIgNqAa+u3rIYNwB
	sjzU/tkx4ZQqYHZtqxhYo3G+rvxrNao77AcuQhw7A9lly13c/gFozho8K1gAGlwpnAAvAwazG35
	vfw/rSs3iML0m3w3HQzEptG9SICadGAS4UVZrvja4jAucHcCqnZYcYQ11P5U/xKLCLOyCW5B25K
	XQ4QIGJr1A4/e8Np0k4I4a/QXu4NCR8u6DOJbzp8nUT+eskUQP7h2RrsKOiu0+gR+s21UkWIEpJ
	RcbelqdADXE8V3mpEVDNcDXkV4d67bfdDP+zORmdXz3l78F3YmkWoMjFfK3Xpsoi2XrUn/Jn6Kd
	MrRsL14qtq5d3cxkNZd/mwLf2BVU7XmIj3Q8NGKV/FaFi4vPW8I5R9GaztHqgQZKMf1HUClLDBw
	YotNgRw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.205400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 139515506FFD2417A89CF598BEB46A38A599400E7E3B732E405FAA2E0D15D1D22000:8
X-MTK: N

From: Yi-De Wu <yi-de.wu@mediatek.com>

From: "Kevenny Hsieh" <kevenny.hsieh@mediatek.com>

Enabled Precision Time Protocol (PTP) for improved host-guest VM time
synchronization, optimizing operations needing precise clock sync in
virtual environment.

Signed-off-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |  2 +-
 arch/arm64/geniezone/gzvm_arch_common.h |  3 +
 arch/arm64/geniezone/hvc.c              | 73 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_exception.c |  3 +-
 include/linux/soc/mediatek/gzvm_drv.h   |  1 +
 include/uapi/linux/gzvm.h               |  1 +
 6 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/geniezone/hvc.c

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 0e4f1087f9de..553a64a926dc 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += vm.o vcpu.o vgic.o
+gzvm-y += vm.o vcpu.o vgic.o hvc.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 192d023722e5..8f5d8528ab96 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -83,6 +83,8 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
  * @__pad: add an explicit '__u32 __pad;' in the middle to make it clear
  *         what the actual layout is.
  * @lr: The array of LRs(list registers).
+ * @vtimer_offset: The offset maintained by hypervisor that is host cycle count
+ *                 when guest VM startup.
  *
  * - Keep the same layout of hypervisor data struct.
  * - Sync list registers back for acking virtual device interrupt status.
@@ -91,6 +93,7 @@ struct gzvm_vcpu_hwstate {
 	__le32 nr_lrs;
 	__le32 __pad;
 	__le64 lr[GIC_V3_NR_LRS];
+	__le64 vtimer_offset;
 };
 
 static inline unsigned int
diff --git a/arch/arm64/geniezone/hvc.c b/arch/arm64/geniezone/hvc.c
new file mode 100644
index 000000000000..3d7f71f20dce
--- /dev/null
+++ b/arch/arm64/geniezone/hvc.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+#include <linux/clocksource.h>
+#include <linux/kernel.h>
+#include <linux/timekeeping.h>
+#include <linux/soc/mediatek/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+#define GZVM_PTP_VIRT_COUNTER 0
+#define GZVM_PTP_PHYS_COUNTER 1
+/**
+ * gzvm_handle_ptp_time() - Sync time between host and guest VM
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * @counter: Counter type from guest VM
+ * Return: Always return 0 because there are no cases of failure
+ *
+ * The following register values will be passed to the guest VM
+ * for time synchronization:
+ * regs->x0 (upper 32 bits) wall clock time
+ * regs->x1 (lower 32 bits) wall clock time
+ * regs->x2 (upper 32 bits) cycles
+ * regs->x3 (lower 32 bits) cycles
+ */
+static int gzvm_handle_ptp_time(struct gzvm_vcpu *vcpu, int counter)
+{
+	struct system_time_snapshot snapshot;
+	u64 cycles = 0;
+
+	ktime_get_snapshot(&snapshot);
+
+	switch (counter) {
+	case GZVM_PTP_VIRT_COUNTER:
+		cycles = snapshot.cycles -
+			 le64_to_cpu(vcpu->hwstate->vtimer_offset);
+		break;
+	case GZVM_PTP_PHYS_COUNTER:
+		cycles = snapshot.cycles;
+		break;
+	default:
+		break;
+	}
+
+	vcpu->run->hypercall.args[0] = upper_32_bits(snapshot.real);
+	vcpu->run->hypercall.args[1] = lower_32_bits(snapshot.real);
+	vcpu->run->hypercall.args[2] = upper_32_bits(cycles);
+	vcpu->run->hypercall.args[3] = lower_32_bits(cycles);
+
+	return 0;
+}
+
+/**
+ * gzvm_arch_handle_guest_hvc() - Handle architecture-related guest hvc
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * Return:
+ * * true - This hvc has been processed, no need to back to VMM.
+ * * false - This hvc has not been processed, require userspace.
+ */
+bool gzvm_arch_handle_guest_hvc(struct gzvm_vcpu *vcpu)
+{
+	int ret, counter;
+
+	switch (vcpu->run->hypercall.args[0]) {
+	case GZVM_HVC_PTP:
+		counter = vcpu->run->hypercall.args[1];
+		ret = gzvm_handle_ptp_time(vcpu, counter);
+		return (ret == 0) ? true : false;
+	default:
+		break;
+	}
+	return false;
+}
diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
index cdfc99d24ded..5ffee863e378 100644
--- a/drivers/virt/geniezone/gzvm_exception.c
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -56,7 +56,6 @@ bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu)
 		ret = gzvm_handle_relinquish(vcpu, ipa);
 		return (ret == 0) ? true : false;
 	default:
-		break;
+		return gzvm_arch_handle_guest_hvc(vcpu);
 	}
-	return false;
 }
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 7c0ccbcd114f..4518f3b0a69b 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -227,6 +227,7 @@ int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu);
 bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
 int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa);
 bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu);
+bool gzvm_arch_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 5411357ec05e..1cf89213a383 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -197,6 +197,7 @@ enum {
 
 /* hypercall definitions of GZVM_EXIT_HYPERCALL */
 enum {
+	GZVM_HVC_PTP = 0x86000001,
 	GZVM_HVC_MEM_RELINQUISH = 0xc6000009,
 };
 
-- 
2.18.0


