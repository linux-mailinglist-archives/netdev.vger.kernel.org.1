Return-Path: <netdev+bounces-98904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2908D31CD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1057A28715B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17B169382;
	Wed, 29 May 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cvMm7zbn"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B981667DB;
	Wed, 29 May 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972173; cv=none; b=JKskIn9SCCmaRSWWbIcjpC5j7AttqId+THbZ5OeeGiet6RSkSXrdkclYwK60yVwoZFUjhoq+sMK/PPTJ3eOxZcZKBw/TY5SJdyiqt55lhIlK9xagpJHoy4bb1hwLb0OKi/bDi14C0WZ5TNtZTdLO3V6IljSpIwWylDuwjeeO/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972173; c=relaxed/simple;
	bh=jg1Jp8N6Tl94tpp4AHgxx8UuAEyR6RsgqHUvtxEbRg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f80zroNyVehbrN95WqXyLaW+pkJCgjEbsEvlUUUKRlGFla6q0HsLKq8xGmJxe/i7ymNiKjbphc7e6FyGZKYKZnXoWdqRuvlg5BJhomRNPliGMY/ka1pEYF6rVNzwCGUwzMqIT6EQTRet6akJn0t6RTWnV5coFEOBFtpbYMZdL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cvMm7zbn; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6aa850061d9711efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=21X9UlHX+fPsujEUXeJTIFpAAcXsNqjBqq3kXV2CRnA=;
	b=cvMm7zbnjmcejupBjGP43TAJUHMcbPQil5pTdl/LWHkpnUxbQCbS6kP30NGioywxrm8eAfE4FcOmBNnlWyjPrjnIXPnC2nZWp9jFNrGEHXlIxFmPkniAs4itn/w5a11pW0bFdWyw7eRzIh3mGesMglX8p12r+3S1XwwBhVaGZ18=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:f297f757-15e9-444c-9530-18ee3cb1778b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:393d96e,CLOUDID:231cf587-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 6aa850061d9711efbfff99f2466cf0b4-20240529
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 16314301; Wed, 29 May 2024 16:42:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 16:42:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 16:42:41 +0800
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
	<Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>,
	Liju-clr Chen <liju-clr.chen@mediatek.com>
Subject: [PATCH v11 12/21] virt: geniezone: Add memory region purpose for hypervisor
Date: Wed, 29 May 2024 16:42:30 +0800
Message-ID: <20240529084239.11478-13-liju-clr.chen@mediatek.com>
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
X-TM-AS-Result: No-10--3.824400-8.000000
X-TMASE-MatchedRID: Bo0EIJTmAYww2a0RxGqSGyVypP66BP0QNNuh+5zmS68Cgjr7b0ytGZas
	fA8Y/RCF8B1Eq8wDKAEQzM3Grt8RghUBkTmMruyZhK8o4aoss8pKPIx+MJF9o99RlPzeVuQQpc2
	xgJAY6Lr/EdEp4HtkngHGJy9aPQkxszLAY5oHhBDd+fuf9kcapoLFgHaE9Li9myiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ19+9ZqEp9FThLnv07eOR+FADAYkZXyNcIbd6xgOLRhrpgBPiGQ8jlcOwYV
	dkT7SkWWPeZyqTFSSOvAR+R87rVR56r4mzrm8D9E37uz0EXFfMXRoPmWO3jekxwdkPqCq7vDEyN
	+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.824400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4A0668940C8103318647D27F0CF410D4B8048F4C12FE9DF4285CF724B447C25D2000:8
X-MTK: N

From: Yi-De Wu <yi-de.wu@mediatek.com>

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

Hypervisor might need to know the precise purpose of each memory
region, so that it can provide specific memory protection. We add a new
uapi to pass address and size of a memory region and its purpose.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
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
index 8690def2419f..c20a2ded2a4f 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -144,6 +144,16 @@ int gzvm_arch_destroy_vm(u16 vm_id)
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
index 6d666974fbf7..91f08dd72c63 100644
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
index 096e72b76e5c..3c2b5d9071c6 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -179,6 +179,9 @@ void gzvm_drv_irqfd_exit(void);
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


