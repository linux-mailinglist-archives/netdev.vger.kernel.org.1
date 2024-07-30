Return-Path: <netdev+bounces-114035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C66D940B88
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0279A286970
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F41119AD7E;
	Tue, 30 Jul 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ggtGmPMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FF1946C5;
	Tue, 30 Jul 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327902; cv=none; b=XPz5idY5SOzvfGg6NcExAIpnHszguWXp1DHBoqDL1xPJsN+z6kapUKn0xcTZsj39aTqMEAx8a68jwJ+ODQrAjI9SuaM+z0UOBhfOfGGWrDyWNHfff0tlNIgP5ukVr8vhox6PZUvixqGU3rNpa/fwCeFFa5NodTptdev5PbXvj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327902; c=relaxed/simple;
	bh=3PYaiExMUQu0KDjIB3hWcwpYiWhAC+LcbLhzVB/w9pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cP/Ueque0kYIty8xVu1QJdY5wjV+dGwjd5LM9fYbqSG8q9QV1AlEixhTqb5BSdAjj/hkn6XexkjLIhaB5RjM0Kb0OWDlBK+JdnGBm+DNiJOmnPa6bkSZF3lXTovonm1cZ67TyWpi1XNF3yD/b/zwScBqy1LF5aN91EwZX0R6wSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ggtGmPMQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2b7e7e5a4e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NWIWCweIOakrDfgNs5zGEvD6ho1gGyfq0mG6Fz1cUGE=;
	b=ggtGmPMQy2H6N+5dRS+75ei77O2l5Kvr2KTGwgG0s7PQrB/m3mRvSTo5UaO8CCfp8utIAIPxhEu/8V34D4j8pBBLNSUR5ZFRrAgcYIjXsSFozqSmz+50qQuMeO0Lv2C+1eip/OAxVzgthuNpnG0zQ0Jj+YWQ2550o81JcOP7odA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a5d23add-16fa-4e4a-8433-3921447bdeb3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:f31c11d2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2b7e7e5a4e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 124177734; Tue, 30 Jul 2024 16:24:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:36 +0800
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
Subject: [PATCH v12 02/24] docs: geniezone: Introduce GenieZone hypervisor
Date: Tue, 30 Jul 2024 16:24:14 +0800
Message-ID: <20240730082436.9151-3-liju-clr.chen@mediatek.com>
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
X-TM-AS-Result: No-10--13.623400-8.000000
X-TMASE-MatchedRID: tzHfit9At4wihjhlMTu+HHa57ruHAnHxFuNF4lJG6xs1LB46LFAAkkd0
	Rzx07LDVu1YWrIMJBFIUZ7mqlsLL7wAwGIAo3ShbyATMS/tDL5ipD1R7N5OROMA5YKm8dwM6jIZ
	02fRmyUctK7tHzSdmVLdnCNkrUAnN1ddezVny+QLiHyvyXeXh5qny79MYSKWc/uK0hv0lVwklHD
	ysIsZQz11tBKF7hhAzucwGRxuiOSoY1mlq1H5Z3ov2/i8VNqeOWOi4GPaBr7/FpA1uJFd1mtZho
	S9qxz0XFekDcD12A6u1XPxxyTBct3y3NtgjFBPrGLXhwJ3YV6NAq6/y5AEOOjvpyveVkrtEhCLR
	gWbx/Un1D9AzgdWivKIys8bfOtn9+hiRYeF7szVHoKp7fxLOV7ZvJfWpnfsSEoBacoHAF/+lBxI
	wyU8eVQMQDDSpB+BxYhdQng3DZoPhLW5g057g5cgc0seoKgtWFugFBW/IrRqNBRPxef1SsaPFjJ
	EFr+olwXCBO/GKkVqOhzOa6g8KrQYkmK8tpaSXVQrS5euNgFhciHkBWf/Oc6QZnJa/jTGTKvtsd
	0Acl7A=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.623400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D4ACDC185A25CE4FC4D8FE0268A8C4265378709796C18F68713953EBACF9B2672000:8
X-MTK: N

From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. It is a pure EL2
implementation which implies it does not rely any specific host VM, and
this behavior improves GenieZone's security as it limits its interface.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Co-developed-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 Documentation/virt/geniezone/introduction.rst | 87 +++++++++++++++++++
 Documentation/virt/index.rst                  |  1 +
 MAINTAINERS                                   |  6 ++
 3 files changed, 94 insertions(+)
 create mode 100644 Documentation/virt/geniezone/introduction.rst

diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
new file mode 100644
index 000000000000..f280476228b3
--- /dev/null
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+GenieZone Introduction
+======================
+
+Overview
+========
+GenieZone hypervisor (gzvm) is a type-1 hypervisor that supports various virtual
+machine types and provides security features such as TEE-like scenarios and
+secure boot. It can create guest VMs for security use cases and has
+virtualization capabilities for both platform and interrupt. Although the
+hypervisor can be booted independently, it requires the assistance of GenieZone
+hypervisor kernel driver(also named gzvm) to leverage the ability of Linux
+kernel for vCPU scheduling, memory management, inter-VM communication and virtio
+backend support.
+
+Supported Architecture
+======================
+GenieZone now only supports MediaTek ARM64 SoC.
+
+Features
+========
+
+- vCPU Management
+
+  VM manager aims to provide vCPUs on the basis of time sharing on physical
+  CPUs. It requires Linux kernel in host VM for vCPU scheduling and VM power
+  management.
+
+- Memory Management
+
+  Direct use of physical memory from VMs is forbidden and designed to be
+  dictated to the privilege models managed by GenieZone hypervisor for security
+  reason. With the help of gzvm module, the hypervisor would be able to manipulate
+  memory as objects.
+
+- Virtual Platform
+
+  We manage to emulate a virtual mobile platform for guest OS running on guest
+  VM. The platform supports various architecture-defined devices, such as
+  virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
+
+- Inter-VM Communication
+
+  Communication among guest VMs was provided mainly on RPC. More communication
+  mechanisms were to be provided in the future based on VirtIO-vsock.
+
+- Device Virtualization
+
+  The solution is provided using the well-known VirtIO. The gzvm module would
+  redirect MMIO traps back to VMM where the virtual devices are mostly emulated.
+  Ioeventfd is implemented using eventfd for signaling host VM that some IO
+  events in guest VMs need to be processed.
+
+- Interrupt virtualization
+
+  All Interrupts during some guest VMs running would be handled by GenieZone
+  hypervisor with the help of gzvm module, both virtual and physical ones.
+  In case there's no guest VM running out there, physical interrupts would be
+  handled by host VM directly for performance reason. Irqfd is also implemented
+  using eventfd for accepting vIRQ requests in gzvm module.
+
+Platform architecture component
+===============================
+
+- vm
+
+  The vm component is responsible for setting up the capability and memory
+  management for the protected VMs. The capability is mainly about the lifecycle
+  control and boot context initialization. And the memory management is highly
+  integrated with ARM 2-stage translation tables to convert VA to IPA to PA
+  under proper security measures required by protected VMs.
+
+- vcpu
+
+  The vcpu component is the core of virtualizing aarch64 physical CPU runnable,
+  and it controls the vCPU lifecycle including creating, running and destroying.
+  With self-defined exit handler, the vm component would be able to act
+  accordingly before terminated.
+
+- vgic
+
+  The vgic component exposes control interfaces to Linux kernel via irqchip, and
+  we intend to support all SPI, PPI, and SGI. When it comes to virtual
+  interrupts, the GenieZone hypervisor would write to list registers and trigger
+  vIRQ injection in guest VMs via GIC.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 7fb55ae08598..cf12444db336 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -16,6 +16,7 @@ Virtualization Support
    coco/sev-guest
    coco/tdx-guest
    hyperv/index
+   geniezone/introduction
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 12b870712da4..a61f74e258f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9446,6 +9446,12 @@ F:	include/vdso/
 F:	kernel/time/vsyscall.c
 F:	lib/vdso/
 
+GENIEZONE HYPERVISOR DRIVER
+M:	Yingshiuan Pan <yingshiuan.pan@mediatek.com>
+M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
+M:	Liju Chen <liju-clr.chen@mediatek.com>
+F:	Documentation/virt/geniezone/
+
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
 S:	Supported
-- 
2.18.0


