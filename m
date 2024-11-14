Return-Path: <netdev+bounces-144787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63B9C8730
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B02B2B07E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B741F9A8A;
	Thu, 14 Nov 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c/ALBO09"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFA1F7789;
	Thu, 14 Nov 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578899; cv=none; b=HbbRTGnsc+fsECyDWKmhLNDPwRyUkfv9P07paFk07aOYC+G/ALTfW2tsasweMRZui9UuKSxnbRTSnqnaOR5nQAHQGMrUoHHgeqWi10dRKqqrGW/S9+LOuIEgZ0uYYu9ocruR48JvE2I/hCpbNb+16ACQTCa9B8Fk3IYuH2NKV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578899; c=relaxed/simple;
	bh=kvyRHDyImxXjhKxdoVzxK8xW36OyLtNhCrsUulNwzvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDy4FL5fTVm+EkwpeD21dP6X7yZpqmVxkiRMRGSmsbJP8d98jxlrWW/6WnbuoyM8SoytKhk6oxYvWRE4xioN1VTHjyeiKb9Xr/00og49ONUgXL6hRPjJzZO4Reu/RIXL7srVoMYSHoVqttk6d/Q3dukFQQf01pZaF0tsfR1F6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c/ALBO09; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 56b83e86a27011efbd192953cf12861f-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PO7+1L/RL1jlngVwSYfjIWxhUQu8nxxElZ4cG7x7r88=;
	b=c/ALBO09I62XsFGLRj8l+YQr1OpPbBuOqtVh7gq6Wpwci8wgGNAqfaXfnqQ6yEF9JNBjw05VH3t6ogN5cG9k9Lw9uPhO1f18QFHhbQcbn6FTech1FjUMrpMGxKj2zZij01+ia9T+fpNT8/4xmpWRkcaBwvWKTIkE2cug5NrVepQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:dca5c297-f48e-428b-8a60-343c3932a906,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d76b1307-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 56b83e86a27011efbd192953cf12861f-20241114
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 507297029; Thu, 14 Nov 2024 18:08:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:02 +0800
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
Subject: [PATCH v13 02/25] docs: geniezone: Introduce GenieZone hypervisor
Date: Thu, 14 Nov 2024 18:07:39 +0800
Message-ID: <20241114100802.4116-3-liju-clr.chen@mediatek.com>
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
X-TM-AS-Result: No-10--14.459700-8.000000
X-TMASE-MatchedRID: +CLiPMT38ZAihjhlMTu+HHa57ruHAnHxFuNF4lJG6xs1LB46LFAAkkd0
	Rzx07LDVu1YWrIMJBFIUZ7mqlsLL7wAwGIAo3ShbyATMS/tDL5ipD1R7N5OROMA5YKm8dwM6jIZ
	02fRmyUctK7tHzSdmVLdnCNkrUAnN1ddezVny+QLiHyvyXeXh5qny79MYSKWc/uK0hv0lVwklHD
	ysIsZQz11tBKF7hhAzucwGRxuiOSoY1mlq1H5Z3ov2/i8VNqeOWOi4GPaBr7/FpA1uJFd1mtZho
	S9qxz0XHuLux1hFzDvyN9+MhBBXP9D+INh9HpXLSEQN/D/3cG4ayaQg2/Z1zxy/A9iZcrIf+bls
	dPlPYzaEOdaLaz+/0fJtR6XZoHQXq9Fb0RfhjvR3p/MPn9NFkc/rSr8VfmGwJ870fpj93L41Itq
	0yDsRhtMHHnHl1YlR3VFTasCiHDkWfqaKovr4bRDK/Fqp4JZ8fS0Ip2eEHnz3IzXlXlpamPoLR4
	+zsDTtgUicvJ4MChmZe7u+gKYNYQqHGxD+0tBiTNWJBiG7qgnFyyED9rMmwkNHOP6jPEsn
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.459700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C36932093DDEBE95FB9B90E7042C04888CCC10DA95C3422327E1DA15A6F171792000:8
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
index 000000000000..206b019f777b
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
+GenieZone hypervisor (gzvm) is a type-I hypervisor that supports various virtual
+machine types and provides security features such as TEE-like scenarios and
+secure boot. It can create guest VMs for security use cases and has
+virtualization capabilities for both platform and interrupt. Although the
+hypervisor can be booted independently, it requires the assistance of GenieZone
+hypervisor kernel driver (also named gzvm) to leverage the ability of Linux
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
+  reason. With the help of the gzvm module, the hypervisor is able to manipulate
+  memory as objects.
+
+- Virtual Platform
+
+  The gzvm hypervisor emulates a virtual mobile platform for guest OS running on
+  guest VM. The platform supports various architecture-defined devices, such as
+  virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
+
+- Inter-VM Communication
+
+  Communication among guest VMs is provided mainly on RPC. More communication
+  mechanisms will be provided in the future based on VirtIO-vsock.
+
+- Device Virtualization
+
+  The solution is provided using the well-known VirtIO. The gzvm module redirects
+  MMIO traps back to VMM where the virtual devices are mostly emulated.
+  Ioeventfd is implemented using eventfd for signaling host VM that some IO
+  events in guest VMs need to be processed.
+
+- Interrupt virtualization
+
+  All interrupts during some guest VMs running are handled by GenieZone
+  hypervisor with the help of gzvm module, both virtual and physical ones.
+  In case there's no guest VM running, physical interrupts are handled by host
+  VM directly for performance reason. Irqfd is also implemented using eventfd
+  for accepting vIRQ requests in gzvm module.
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
+  The vcpu component is the core of virtualizing an aarch64 physical CPU, and it
+  controls the vCPU lifecycle including creating, running and destroying.
+  With self-defined exit handler, the vm component is able to act accordingly
+  before termination.
+
+- vgic
+
+  The vgic component exposes control interfaces to Linux kernel via irqchip, and
+  we intend to support all SPI, PPI, and SGI. When it comes to virtual
+  interrupts, the GenieZone hypervisor writes to list registers and triggers
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
index 279560bf2b6d..bd119e707b7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9671,6 +9671,12 @@ F:	include/vdso/
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


