Return-Path: <netdev+bounces-144795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3B89C8709
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2A82840C6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056071FA83D;
	Thu, 14 Nov 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GnxuB4RW"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD41F893E;
	Thu, 14 Nov 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578901; cv=none; b=fB48+Re4U/0MrWvYsKc0N+biLRoFiL0xBN5cn2Lo+wQtGsELJrkWweBDZfaLviMaQhXNaRdRAMCb691wEcSn9egGnEws3SkqNRGeJKBlcK5EqgR5uBVD6la0Ak5en6Ux01Z8eMyHq3lJ8tqV0/HzHBVSH8ULrojAQLeM/W891xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578901; c=relaxed/simple;
	bh=lfs9v6JWw3ofrtFrRrrDy2qCu/PTF2gE6z0UXcsAbAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilvru+qpj2Hdsv/Fhqm9LP3vX0kZuTWEO2CNHZEuuqybS3b7Mgtv2eDUBaD8WK0Xkqcn6etkI3x3WQ504u4ezJFzH+14KhLmIreeeoDKuN+/xuZQEijx2g+iXKAINGS0mssGuJStgAPlYRz9vs27ttZ5D51BEvwQVo97la0vUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GnxuB4RW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 583954fca27011ef99858b75a2457dd9-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MHCUzgNzvRYpdtn0+aXqa8vcEJ2ZuUHgIfAQYwIndAM=;
	b=GnxuB4RWrqXIla4p5QEkVPYD935/7Y/b+TATvIRmS9sW6L6lLrjDaL+PvAOmjqdFdN0m83YYYRz4HT6imxR5HgXOcrbxHlU5p5ahfUCcZCZgp2dfPQmtSkSyqU/nRPM9mvf4bz0z1JiGO7dN4t8luvyvxbo/082Yam1zG68JAqg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:91eb236f-e2ba-4c6b-bfc0-623749cc221c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:3d3fa25c-f18b-4d56-b49c-93279ee09144,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 583954fca27011ef99858b75a2457dd9-20241114
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1908025639; Thu, 14 Nov 2024 18:08:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:04 +0800
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
Subject: [PATCH v13 12/25] virt: geniezone: Add memory region purpose for hypervisor
Date: Thu, 14 Nov 2024 18:07:49 +0800
Message-ID: <20241114100802.4116-13-liju-clr.chen@mediatek.com>
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
X-TM-AS-Result: No-10--3.824400-8.000000
X-TMASE-MatchedRID: Bo0EIJTmAYww2a0RxGqSGyVypP66BP0QNNuh+5zmS68Cgjr7b0ytGZas
	fA8Y/RCF8B1Eq8wDKAEQzM3Grt8RghUBkTmMruyZhK8o4aoss8pKPIx+MJF9o99RlPzeVuQQpc2
	xgJAY6Lr/EdEp4HtkngHGJy9aPQkxszLAY5oHhBDd+fuf9kcapoLFgHaE9Li9myiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ19+9ZqEp9FTjbIpd/FKSDlJsJ98yktZKjDFej/B3xT7KOXRJoEQaneGkvT
	FWLTL2hKBJ/fQnHuR9UuZzX1SryYb7MpHk3WinNOvpYxzItg+EXRoPmWO3jekxwdkPqCq7vDEyN
	+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.824400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	15492F276D697DA72D1DBB9A899C85FE50092AE46761A00D0B8A572DC4E8477F2000:8
X-MTK: N

From: Jerry Wang <ze-yu.wang@mediatek.com>

Hypervisor might need to know the precise purpose of each memory
region, so that it can provide specific memory protection. We add a new
uapi to pass address and size of a memory region and its purpose.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 ++
 arch/arm64/geniezone/vm.c               | 10 ++++++++++
 drivers/virt/geniezone/gzvm_vm.c        |  7 +++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index d4b49a4b283a..dabd11438e94 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -22,6 +22,7 @@ enum {
 	GZVM_FUNC_PROBE = 12,
 	GZVM_FUNC_ENABLE_CAP = 13,
 	GZVM_FUNC_INFORM_EXIT = 14,
+	GZVM_FUNC_MEMREGION_PURPOSE = 15,
 	NR_GZVM_FUNC,
 };
 
@@ -44,6 +45,7 @@ enum {
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
+#define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 743951aa8ec3..fe1caf841de8 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -153,6 +153,16 @@ int gzvm_arch_destroy_vm(u16 vm_id)
 				    0, 0, &res);
 }
 
+int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
+				struct gzvm_userspace_memory_region *mem)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MEMREGION_PURPOSE, gzvm->vm_id,
+				    mem->guest_phys_addr, mem->memory_size,
+				    mem->flags, 0, 0, 0, &res);
+}
+
 static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
 				   struct gzvm_enable_cap *cap,
 				   struct arm_smccc_res *res)
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 27275d44b7a4..c2e4568d2d3f 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -105,6 +105,7 @@ static int
 gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 				struct gzvm_userspace_memory_region *mem)
 {
+	int ret;
 	struct vm_area_struct *vma;
 	struct gzvm_memslot *memslot;
 	unsigned long size;
@@ -128,6 +129,12 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	memslot->vma = vma;
 	memslot->flags = mem->flags;
 	memslot->slot_id = mem->slot;
+
+	ret = gzvm_arch_memregion_purpose(gzvm, mem);
+	if (ret) {
+		pr_err("Failed to config memory region for the specified purpose\n");
+		return -EFAULT;
+	}
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 85ac8bb3a4fa..8e98b3145881 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -197,6 +197,9 @@ void gzvm_drv_irqfd_exit(void);
 int gzvm_vm_irqfd_init(struct gzvm *gzvm);
 void gzvm_vm_irqfd_release(struct gzvm *gzvm);
 
+int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
+				struct gzvm_userspace_memory_region *mem);
+
 int gzvm_init_ioeventfd(struct gzvm *gzvm);
 int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
 bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
-- 
2.18.0


