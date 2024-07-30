Return-Path: <netdev+bounces-114026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD5940B68
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C000B1C208BE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2FE19538C;
	Tue, 30 Jul 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j0sVL1jC"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9D192B66;
	Tue, 30 Jul 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327899; cv=none; b=FfShFhIVFbFK2X8rhZa2agae2rTyww9MkG5kNlrRQtZhgqxatbpUZbfk3iRV/+icEOg2yk2YNSCtneDgpw7zAfqSWOONQQliOdmT43wNjo9Fg1suFIPAQrpp6L/oLKOca+j2LzLuK2Suvg+mYxdKPDsaNZBULWzj3gtLN6QhrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327899; c=relaxed/simple;
	bh=T9TYD+nIBzMWl0sE8jhxkBf952ycrTnmqYpaA8cm1xU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sTGLH8Q1LywilolYSXSLFDzAFa5qripcaFWDqdvRzRY0nyXp3bMp+265uOUurYFoCGQYkYwHp62c5k94W7kRXxC8QzIBqqLh+6lx7K71UAovrLLB/1stfY3FQt8KWu5BZrcX+tq5lNq//r1/MslHLKkGV9xSBrxNFZNw7Z5eaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=j0sVL1jC; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 27eb78424e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=A6mn92rUV5LDImegfXO663Es17xIGXd9r6oLaBOe1S4=;
	b=j0sVL1jCLSQ3GwzhPdm+lyZR+mZqlYoCVunhCKSDEyOFOwz7Hhbnr5JaS84dZD0R+Nk+8ZanedqF87/UGrj+KPTNFVFiqPE0zHSWIAc/IwV/bmSAWkfbj+2SiBf1qon09xK+LGpcf/YKhV7h/tCl033Pj89yS8/isGPjpeRKzG4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:cc35094d-5258-4f75-95a5-b7541ee68bc5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6dc6a47,CLOUDID:941c11d2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 27eb78424e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 981228636; Tue, 30 Jul 2024 16:24:36 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:36 +0800
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
Subject: [PATCH v12 00/24] GenieZone hypervisor drivers
Date: Tue, 30 Jul 2024 16:24:12 +0800
Message-ID: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

From: Liju-Clr Chen <liju-clr.chen@mediatek.com>

This series is based on linux-next, tag: next-20240730.

GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various
virtual machine types and provides security features such as TEE-like
scenarios and secure boot. It can create guest VMs for security use cases
and has virtualization capabilities for both platform and interrupt.
Although the hypervisor can be booted independently, it requires the
assistance of GenieZone hypervisor kernel driver(gzvm-ko) to leverage the
ability of Linux kernel for vCPU scheduling, memory management, inter-VM
communication and virtio backend support.

Changes in v12:
- Introduce a mechanism to migrate the ARM64 virtual timer from the
  guest VM to the host Linux system when the execution context switches
  from the guest VM to the host.
- Implement CPU idle functionality for guest VMs to reduce CPU usage
  and achieve power savings.
- Emulate Inter-Processor Interrupts (IPI) handling for guest VMs.
- Add Co-developed-by tags, adjust the order of Signed-off-by lines, and
  remove "From:" lines.
- Fix coding style from viewer suggestion.

Changes in v11:
https://lore.kernel.org/all/20240529084239.11478-1-liju-clr.chen@mediatek.com/
- Resolve low memory issue by using only one api to get pages for guest VM.
- The GenieZone hypervisor acts as a vendor firmware to enable platform
  virtualization, offering an implementation that is independent of
  Linux-specific implementations. So, relocate dt-binding yaml file to
  the firmware path, as the dts node is used to confirm the presence of
  the geniezone hypervisor firmware.
- Fix coding style from viewer suggestion and checking tools.

Changes in v10:
https://lore.kernel.org/all/20240412065718.29105-1-yi-de.wu@mediatek.com/
- Optimize memory allocation: query hypervisor demand paging capability
  before VM memory population.
- Fix goto syntax according to ACK reviewer in `gzvm_vcpu.c`.
- Fix coding style from viewer suggestion and checking tools.

Changes in v9:
https://lore.kernel.org/all/20240129083302.26044-1-yi-de.wu@mediatek.com/
- Add gzvm_vm_allocate_guest_page function for demand paging support and
  protected VM memory performance optimization.
- Fix coding style from viewer suggestion and checking tools.

Changes in v8:
https://lore.kernel.org/all/20231228105147.13752-1-yi-de.wu@mediatek.com/
- Add reasons for using dt solution in dt-bindings.
- Add locks for memory pin/unpin and relinquish operations.
- Add VM memory stats in debugfs.
- Add tracing support for hypercall and vcpu exit reasons.
- Enable PTP for timing synchronization between host and guests.
- Optimize memory performance for protected VMs.
- Refactor wording and titles in documentation.

Changes in v7:
https://lore.kernel.org/all/20231116152756.4250-1-yi-de.wu@mediatek.com/
- Rebase these patches to the Linux 6.7-rc1 release.
- Refactor patches 1 to 15 to improve coding style while ensuring they do
  not violate the majority of the changes made in v6
- Provide individual VM memory statistics within debugfs in patch 16.
- Add tracing support for hyper call and vcpu exit_reason.

Changes in v6:
https://lore.kernel.org/all/20230919111210.19615-1-yi-de.wu@mediatek.com/
- Rebase based on kernel 6.6-rc1
- Keep dt solution and leave the reasons in the commit message
- Remove arch/arm64/include/uapi/asm/gzvm_arch.h due to simplicity
- Remove resampler in drivers/virt/geniezone/gzvm_irqfd.c due to defeature
  for now
- Remove PPI in arch/arm64/geniezone/vgic.c
- Refactor vm related components into 3 smaller patches, namely adding vm
  support, setting user memory region and checking vm capability
- Refactor vcpu and vm component to remove unnecessary ARM prefix
- Add demand paging to fix crash on destroying memory page, acclerate on
  booting and support ballooning deflate
- Add memory pin/unpin memory mechanism to support protected VM
- Add block-based demand paging for performance concern
- Response to reviewers and fix coding style accordingly

Changes in v5:
https://lore.kernel.org/all/20230727080005.14474-1-yi-de.wu@mediatek.com/
- Add dt solution back for device initialization
- Add GZVM_EXIT_GZ reason for gzvm_vcpu_run()
- Add patch for guest page fault handler
- Add patch for supporitng pin/unpin memory
- Remove unused enum members, namely GZVM_FUNC_GET_REGS and
  GZVM_FUNC_SET_REGS
- Use dev_debug() for debugging when platform device is available, and use
  pr_debug() otherwise
- Response to reviewers and fix bugs accordingly

Changes in v4:
https://lore.kernel.org/all/20230609085214.31071-1-yi-de.wu@mediatek.com/
- Add macro to set VM as protected without triggering pvmfw in AVF.
- Add support to pass dtb config to hypervisor.
- Add support for virtual timer.
- Add UAPI to pass memory region metadata to hypervisor.
- Define our own macros for ARM's interrupt number
- Elaborate more on GenieZone hyperivsor in documentation
- Fix coding style.
- Implement our own module for coverting ipa to pa
- Modify the way of initializing device from dt to a more discoverable way
- Move refactoring changes into indepedent patches.

Changes in v3:
https://lore.kernel.org/all/20230512080405.12043-1-yi-de.wu@mediatek.com/
- Refactor: separate arch/arm64/geniezone/gzvm_arch.c into
  vm.c/vcpu.c/vgic.c
- Remove redundant functions
- Fix reviewer's comments

Changes in v2:
https://lore.kernel.org/all/20230428103622.18291-1-yi-de.wu@mediatek.com/
- Refactor: move to drivers/virt/geniezone
- Refactor: decouple arch-dependent and arch-independent
- Check pending signal before entering guest context
- Fix reviewer's comments

Initial Commit in v1:
https://lore.kernel.org/all/20230413090735.4182-1-yi-de.wu@mediatek.com/

Jerry Wang (5):
  virt: geniezone: Add memory region purpose for hypervisor
  virt: geniezone: Add dtb config support
  virt: geniezone: Add memory pin/unpin support
  virt: geniezone: Add memory relinquish support
  virt: geniezone: Provide individual VM memory statistics within
    debugfs

Kevenny Hsieh (3):
  virt: geniezone: Enable PTP for synchronizing time between host and
    guest VMs
  virt: geniezone: Add support for guest VM CPU idle
  virt: geniezone: Emulate IPI for guest VM

Liju Chen (1):
  virt: geniezone: Add tracing support for hyp call and vcpu exit_reason

Willix Yeh (1):
  virt: geniezone: Add support for virtual timer migration

Yingshiuan Pan (14):
  virt: geniezone: enable gzvm-ko in defconfig
  docs: geniezone: Introduce GenieZone hypervisor
  dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
  virt: geniezone: Add GenieZone hypervisor driver
  virt: geniezone: Add vm support
  virt: geniezone: Add set_user_memory_region for vm
  virt: geniezone: Add vm capability check
  virt: geniezone: Add vcpu support
  virt: geniezone: Add irqchip support for virtual interrupt injection
  virt: geniezone: Add irqfd support
  virt: geniezone: Add ioeventfd support
  virt: geniezone: Optimize performance of protected VM memory
  virt: geniezone: Add demand paging support
  virt: geniezone: Add block-based demand paging support

 .../bindings/firmware/mediatek,geniezone.yaml |  34 +
 Documentation/virt/geniezone/introduction.rst |  87 +++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  11 +
 arch/arm64/Kbuild                             |   1 +
 arch/arm64/configs/defconfig                  |   2 +
 arch/arm64/geniezone/Makefile                 |   9 +
 arch/arm64/geniezone/gzvm_arch_common.h       | 120 ++++
 arch/arm64/geniezone/hvc.c                    |  73 ++
 arch/arm64/geniezone/vcpu.c                   |  96 +++
 arch/arm64/geniezone/vgic.c                   |  50 ++
 arch/arm64/geniezone/vm.c                     | 452 ++++++++++++
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/geniezone/Kconfig                |  16 +
 drivers/virt/geniezone/Makefile               |  12 +
 drivers/virt/geniezone/gzvm_common.h          |  12 +
 drivers/virt/geniezone/gzvm_exception.c       | 112 +++
 drivers/virt/geniezone/gzvm_ioeventfd.c       | 281 ++++++++
 drivers/virt/geniezone/gzvm_irqfd.c           | 382 ++++++++++
 drivers/virt/geniezone/gzvm_main.c            | 151 ++++
 drivers/virt/geniezone/gzvm_mmu.c             | 243 +++++++
 drivers/virt/geniezone/gzvm_vcpu.c            | 332 +++++++++
 drivers/virt/geniezone/gzvm_vm.c              | 672 ++++++++++++++++++
 include/linux/soc/mediatek/gzvm_drv.h         | 271 +++++++
 include/trace/events/geniezone.h              |  84 +++
 include/uapi/linux/gzvm.h                     | 405 +++++++++++
 26 files changed, 3911 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml
 create mode 100644 Documentation/virt/geniezone/introduction.rst
 create mode 100644 arch/arm64/geniezone/Makefile
 create mode 100644 arch/arm64/geniezone/gzvm_arch_common.h
 create mode 100644 arch/arm64/geniezone/hvc.c
 create mode 100644 arch/arm64/geniezone/vcpu.c
 create mode 100644 arch/arm64/geniezone/vgic.c
 create mode 100644 arch/arm64/geniezone/vm.c
 create mode 100644 drivers/virt/geniezone/Kconfig
 create mode 100644 drivers/virt/geniezone/Makefile
 create mode 100644 drivers/virt/geniezone/gzvm_common.h
 create mode 100644 drivers/virt/geniezone/gzvm_exception.c
 create mode 100644 drivers/virt/geniezone/gzvm_ioeventfd.c
 create mode 100644 drivers/virt/geniezone/gzvm_irqfd.c
 create mode 100644 drivers/virt/geniezone/gzvm_main.c
 create mode 100644 drivers/virt/geniezone/gzvm_mmu.c
 create mode 100644 drivers/virt/geniezone/gzvm_vcpu.c
 create mode 100644 drivers/virt/geniezone/gzvm_vm.c
 create mode 100644 include/linux/soc/mediatek/gzvm_drv.h
 create mode 100644 include/trace/events/geniezone.h
 create mode 100644 include/uapi/linux/gzvm.h

-- 
2.18.0


