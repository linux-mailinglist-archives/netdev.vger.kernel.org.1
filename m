Return-Path: <netdev+bounces-144791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86D9C86FF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BB71F23B2C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006361F9ED8;
	Thu, 14 Nov 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qEQEKRuF"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBC1F7796;
	Thu, 14 Nov 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578900; cv=none; b=YULIVwkvvdGT4IAATrE1Ew49ZnXcC8Gg83EYvuDDI6KbessJDDAWCwfz6Zcjvd+wLXxyIV2RXPVUQFdGdtX+HoKfSwF9LQRjWLGhiRLy2rXdU9NBnlGgWGmX9wS0KHaZtfUaEqwK9qUO3Jwq+rUsnwRABGWTkyNyYndoqVqSKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578900; c=relaxed/simple;
	bh=+zQ6qqZUbppfom3vUzm7Qfhcl63rxoUSx8nOUo99fOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWvliOi8j+AuOxuViqsEI6fV4Fqb1Axmdaem/SaKpS4mJl58F8XZBFnv1NaGBKUiKvXfPz99UzJmqx7RGg/W7cxk2D76U1icbG9/H7fuWHUB5+uhmtIY3y5w1zp42G7w5XutNjitaRY4GGIwMl/U8Qz1n+Z9z0jJRtgg2V0MstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qEQEKRuF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 56e4da7ca27011efbd192953cf12861f-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9FJ7JtnvV9b15dJtnISl5o8zU3rCv61vcVYHpSWnMyM=;
	b=qEQEKRuFdxcrIPhJ8Mzg3oJMCAG2MapKvo2Uo40qQ3EJLzqsnK+1NvWM/rRpXGtDThvbD2ogKmbcXe2KnuxTAyAGNF1Lh7wbKEZ+o+xoPQNBZKZwNZlm7t6krxT8SDf9KAyJwixAw/yrSfDBczjP5ysKOL+OG2YlInF83UAquF0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:003bb6ab-e4ab-42b3-8e79-63b1f1220890,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:263fa25c-f18b-4d56-b49c-93279ee09144,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 56e4da7ca27011efbd192953cf12861f-20241114
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 582868460; Thu, 14 Nov 2024 18:08:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:03 +0800
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
Subject: [PATCH v13 04/25] virt: geniezone: Add GenieZone hypervisor driver
Date: Thu, 14 Nov 2024 18:07:41 +0800
Message-ID: <20241114100802.4116-5-liju-clr.chen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.710900-8.000000
X-TMASE-MatchedRID: 7lb+J3RorLbPwZWTvltloQI0yP/uoH+DUAjrAJWsTe9mU223IIioZfb9
	MQK6DQClvfKrrb4bmIqy7ec+ITUwM2eIEG00SdU9drnuu4cCcfF/aDoolm3GXWJkJOQVCIpwMKw
	CZ7huGiG36SL29gBZ5pCCPgbCpGAQEx7gYK5Baw8mZusHWPhfCgXBq8VnFhCkGoH7Aor25l4faH
	aH7SYxz5w9wMcKngv65JZWpbmrOY42fA1oT3w9vBes/RxhysDbO69hrW/YgWHRziMbBeTI+f6rI
	PjisOwVLnrst5PEBItY/xqzfORJ/3+cOjB/YDBsE0Q83A2vD+sikU4xQFgb7nwqSr02aA0dg7M3
	17/33cGmuE8sHNH+0fooE3M+qP72Nb4r89y+oGvRfDQgu+j+5SlayzmQ9QV0Fp7kniXxovOJW14
	oA532uJW8QZiQ0LetCAtqzqtapouzMsBjmgeEEBIRh9wkXSlF+q1Y+/eEArbczkKO5k4APq0Rom
	hWPJaQe8WHAlOjF6AQCEi5k+nQxB8TzIzimOwPC24oEZ6SpSk6XEE7Yhw4Fi2BBbyYEj+Q5vYtb
	tlkT/6Wv3BspGBaJ/lZLP6l7wtQSZ5q7ZSBIyM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.710900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 29EDF289D22924B512A59001A52A272A3404E3BD152226C4C9ADBD9EA32D74C92000:8
X-MTK: N

From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>

GenieZone hypervisor(gzvm) is a type-I hypervisor that supports various
virtual machine types and provides security features such as TEE-like
scenarios and secure boot. It can create guest VMs for security use
cases and has virtualization capabilities for both platform and
interrupt. Although the hypervisor can be booted independently, it
requires the assistance of GenieZone hypervisor kernel driver(gzvm-ko)
to leverage the ability of Linux kernel for vCPU scheduling, memory
management, inter-VM communication and virtio backend support.

Add the basic hypervisor driver. Subsequent patches will add more
supported features to this driver.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Co-developed-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 MAINTAINERS                             |   3 +
 arch/arm64/Kbuild                       |   1 +
 arch/arm64/geniezone/Makefile           |   9 ++
 arch/arm64/geniezone/gzvm_arch_common.h |  44 +++++++++
 arch/arm64/geniezone/vm.c               |  72 +++++++++++++++
 drivers/virt/Kconfig                    |   2 +
 drivers/virt/geniezone/Kconfig          |  16 ++++
 drivers/virt/geniezone/Makefile         |   9 ++
 drivers/virt/geniezone/gzvm_main.c      | 117 ++++++++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  41 +++++++++
 10 files changed, 314 insertions(+)
 create mode 100644 arch/arm64/geniezone/Makefile
 create mode 100644 arch/arm64/geniezone/gzvm_arch_common.h
 create mode 100644 arch/arm64/geniezone/vm.c
 create mode 100644 drivers/virt/geniezone/Kconfig
 create mode 100644 drivers/virt/geniezone/Makefile
 create mode 100644 drivers/virt/geniezone/gzvm_main.c
 create mode 100644 include/linux/soc/mediatek/gzvm_drv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 291f46017f3f..708c13103ec5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9677,6 +9677,9 @@ M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
 M:	Liju Chen <liju-clr.chen@mediatek.com>
 F:	Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml
 F:	Documentation/virt/geniezone/
+F:	arch/arm64/geniezone/
+F:	drivers/virt/geniezone/
+F:	include/linux/soc/mediatek/gzvm_drv.h
 
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 5bfbf7d79c99..0c3cca572919 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -4,6 +4,7 @@ obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
 obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
 obj-$(CONFIG_CRYPTO)	+= crypto/
+obj-$(CONFIG_MTK_GZVM)	+= geniezone/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
new file mode 100644
index 000000000000..2957898cdd05
--- /dev/null
+++ b/arch/arm64/geniezone/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Main Makefile for gzvm, this one includes drivers/virt/geniezone/Makefile
+#
+include $(srctree)/drivers/virt/geniezone/Makefile
+
+gzvm-y += vm.o
+
+obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
new file mode 100644
index 000000000000..660c7cf3fc18
--- /dev/null
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZVM_ARCH_COMMON_H__
+#define __GZVM_ARCH_COMMON_H__
+
+#include <linux/arm-smccc.h>
+
+enum {
+	GZVM_FUNC_PROBE = 12,
+	NR_GZVM_FUNC,
+};
+
+#define SMC_ENTITY_MTK			59
+#define GZVM_FUNCID_START		(0x1000)
+#define GZVM_HCALL_ID(func)						\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,	\
+			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
+
+#define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
+
+/**
+ * gzvm_hypcall_wrapper() - the wrapper for hvc calls
+ * @a0: argument passed in registers 0
+ * @a1: argument passed in registers 1
+ * @a2: argument passed in registers 2
+ * @a3: argument passed in registers 3
+ * @a4: argument passed in registers 4
+ * @a5: argument passed in registers 5
+ * @a6: argument passed in registers 6
+ * @a7: argument passed in registers 7
+ * @res: result values from registers 0 to 3
+ *
+ * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
+ */
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
+			 unsigned long a2, unsigned long a3,
+			 unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res);
+
+#endif /* __GZVM_ARCH_COMMON_H__ */
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
new file mode 100644
index 000000000000..daad21b28f6f
--- /dev/null
+++ b/arch/arm64/geniezone/vm.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/err.h>
+#include <linux/uaccess.h>
+
+#include <linux/soc/mediatek/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+/**
+ * gzvm_hypcall_wrapper() - the wrapper for hvc calls
+ * @a0: arguments passed in registers 0
+ * @a1: arguments passed in registers 1
+ * @a2: arguments passed in registers 2
+ * @a3: arguments passed in registers 3
+ * @a4: arguments passed in registers 4
+ * @a5: arguments passed in registers 5
+ * @a6: arguments passed in registers 6
+ * @a7: arguments passed in registers 7
+ * @res: result values from registers 0 to 3
+ *
+ * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
+ */
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
+			 unsigned long a2, unsigned long a3,
+			 unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res)
+{
+	struct arm_smccc_1_2_regs res_1_2;
+	struct arm_smccc_1_2_regs args = {
+		.a0 = a0,
+		.a1 = a1,
+		.a2 = a2,
+		.a3 = a3,
+		.a4 = a4,
+		.a5 = a5,
+		.a6 = a6,
+		.a7 = a7,
+	};
+	arm_smccc_1_2_hvc(&args, &res_1_2);
+	res->a0 = res_1_2.a0;
+	res->a1 = res_1_2.a1;
+	res->a2 = res_1_2.a2;
+	res->a3 = res_1_2.a3;
+
+	return gzvm_err_to_errno(res->a0);
+}
+
+int gzvm_arch_probe(struct gzvm_version drv_version,
+		    struct gzvm_version *hyp_version)
+{
+	struct arm_smccc_res res;
+	int ret;
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_PROBE,
+				   drv_version.major,
+				   drv_version.minor,
+				   drv_version.sub,
+				   0, 0, 0, 0, &res);
+	if (ret)
+		return -ENXIO;
+
+	hyp_version->major = (u32)res.a1;
+	hyp_version->minor = (u32)res.a2;
+	hyp_version->sub = res.a3;
+
+	return 0;
+}
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index d8c848cf09a6..848eb97202d1 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -49,4 +49,6 @@ source "drivers/virt/acrn/Kconfig"
 
 source "drivers/virt/coco/Kconfig"
 
+source "drivers/virt/geniezone/Kconfig"
+
 endif
diff --git a/drivers/virt/geniezone/Kconfig b/drivers/virt/geniezone/Kconfig
new file mode 100644
index 000000000000..b17c06c91074
--- /dev/null
+++ b/drivers/virt/geniezone/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config MTK_GZVM
+	tristate "GenieZone Hypervisor driver for guest VM operation"
+	depends on ARM64 && EVENTFD
+	help
+	  This driver, gzvm, enables to run guest VMs on MTK GenieZone
+	  hypervisor. It exports kvm-like interfaces for VMM (e.g., crosvm) in
+	  order to operate guest VMs on GenieZone hypervisor.
+
+	  GenieZone hypervisor now only supports MediaTek SoC and arm64
+	  architecture.
+
+	  Select M if you want it be built as a module (gzvm.ko).
+
+	  If unsure, say N.
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
new file mode 100644
index 000000000000..3a82e5fddf90
--- /dev/null
+++ b/drivers/virt/geniezone/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for GenieZone driver, this file should be include in arch's
+# to avoid two ko being generated.
+#
+
+GZVM_DIR ?= ../../../drivers/virt/geniezone
+
+gzvm-y := $(GZVM_DIR)/gzvm_main.o
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
new file mode 100644
index 000000000000..dc91fd61ba75
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/kdev_t.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/soc/mediatek/gzvm_drv.h>
+
+static struct gzvm_driver gzvm_drv = {
+	.drv_version = {
+		.major = GZVM_DRV_MAJOR_VERSION,
+		.minor = GZVM_DRV_MINOR_VERSION,
+		.sub = 0,
+	},
+};
+
+/**
+ * gzvm_err_to_errno() - Convert geniezone return value to standard errno
+ *
+ * @err: Return value from geniezone function return
+ *
+ * Return: Standard errno
+ */
+int gzvm_err_to_errno(unsigned long err)
+{
+	int gz_err = (int)err;
+
+	switch (gz_err) {
+	case 0:
+		return 0;
+	case ERR_NO_MEMORY:
+		return -ENOMEM;
+	case ERR_NOT_SUPPORTED:
+		fallthrough;
+	case ERR_NOT_IMPLEMENTED:
+		return -EOPNOTSUPP;
+	case ERR_FAULT:
+		return -EFAULT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int gzvm_dev_open(struct inode *inode, struct file *file)
+{
+	/*
+	 * Reference count to prevent this module is unload without destroying
+	 * VM
+	 */
+	try_module_get(THIS_MODULE);
+	return 0;
+}
+
+static int gzvm_dev_release(struct inode *inode, struct file *file)
+{
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+static const struct file_operations gzvm_chardev_ops = {
+	.llseek		= noop_llseek,
+	.open		= gzvm_dev_open,
+	.release	= gzvm_dev_release,
+};
+
+static struct miscdevice gzvm_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = KBUILD_MODNAME,
+	.fops = &gzvm_chardev_ops,
+};
+
+static int gzvm_drv_probe(struct platform_device *pdev)
+{
+	if (gzvm_arch_probe(gzvm_drv.drv_version, &gzvm_drv.hyp_version) != 0) {
+		dev_err(&pdev->dev, "Not found available conduit\n");
+		return -ENODEV;
+	}
+
+	pr_debug("Found GenieZone hypervisor version %u.%u.%llu\n",
+		 gzvm_drv.hyp_version.major, gzvm_drv.hyp_version.minor,
+		 gzvm_drv.hyp_version.sub);
+
+	return misc_register(&gzvm_dev);
+}
+
+static void gzvm_drv_remove(struct platform_device *pdev)
+{
+	misc_deregister(&gzvm_dev);
+}
+
+static const struct of_device_id gzvm_of_match[] = {
+	{ .compatible = "mediatek,geniezone" },
+	{/* sentinel */},
+};
+
+static struct platform_driver gzvm_driver = {
+	.probe = gzvm_drv_probe,
+	.remove = gzvm_drv_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = gzvm_of_match,
+	},
+};
+
+module_platform_driver(gzvm_driver);
+
+MODULE_DEVICE_TABLE(of, gzvm_of_match);
+MODULE_AUTHOR("MediaTek");
+MODULE_DESCRIPTION("GenieZone interface for VMM");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
new file mode 100644
index 000000000000..495bf5b8b8e0
--- /dev/null
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZVM_DRV_H__
+#define __GZVM_DRV_H__
+
+/* GZVM version encode */
+#define GZVM_DRV_MAJOR_VERSION		16
+#define GZVM_DRV_MINOR_VERSION		0
+
+struct gzvm_version {
+	u32 major;
+	u32 minor;
+	u64 sub;	/* currently, used by hypervisor */
+};
+
+struct gzvm_driver {
+	struct gzvm_version hyp_version;
+	struct gzvm_version drv_version;
+};
+
+/*
+ * These are the definitions of APIs between GenieZone hypervisor and driver,
+ * there's no need to be visible to uapi. Furthermore, we need GenieZone
+ * specific error code in order to map to Linux errno
+ */
+#define NO_ERROR                (0)
+#define ERR_NO_MEMORY           (-5)
+#define ERR_NOT_SUPPORTED       (-24)
+#define ERR_NOT_IMPLEMENTED     (-27)
+#define ERR_FAULT               (-40)
+
+int gzvm_err_to_errno(unsigned long err);
+
+/* arch-dependant functions */
+int gzvm_arch_probe(struct gzvm_version drv_version,
+		    struct gzvm_version *hyp_version);
+
+#endif /* __GZVM_DRV_H__ */
-- 
2.18.0


