Return-Path: <netdev+bounces-144788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0499C8724
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4049B24CE3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D01F9AA1;
	Thu, 14 Nov 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hNYMMSml"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4401F80CB;
	Thu, 14 Nov 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578900; cv=none; b=ZG5obQDgwPvZFbJabi+qG8NZAk7xAQG3GP4sItRwUNACraMAV8I24gKZTcm/5yd7ufBzu60LBYFT5Mft25a3dl0uzKwNUce+/3Ge5ldf/kcxtivgfnvFmWWA6yoNEw1uGhsD8aV2n6ulGxE011YNecqWQfG+1j6YN6MfKCA305I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578900; c=relaxed/simple;
	bh=xvgaCmvoiR8tTXAiLoKCPODCJkm3RmTKP3UKdTEhCRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WS3VJFPpMGru348umkI5CMdD4BsOzJgRl5jLlq01v3Y/Sc2kWJ4d0w0rWanJbtxc/QZpvBdVjoha6ioYlRJ1WPbft+3+1eFTAq4pK8l/e+haKIVl/OVqJlq6z9JEMCumpE8x1ICRs5kV9/fe9VFiV9iFq5xmQPjY7r4Wpz2JLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hNYMMSml; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58a7c752a27011ef99858b75a2457dd9-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=olVph3cQeOWUn5eJcsuo5CyNUNQwKw8vhf+nxFUdb9U=;
	b=hNYMMSml3TVdCv1deOp8ZeB1Klm1wT2IPaSOPOlnQgRpazooVDJwlz37WvOi1m7T2aMf4a8+j44paU2tsEWgdVSHUZjMP1e3Dn1jMN//UPUiyH1paljRoEto8HRINdT47pTnk1YHQI6tCJ0kl9YwrJu/YeP7yAX3wwgh7TxGQh4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:52cfc9e9-5a7e-4ee6-91dd-9577aff92326,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:136c1307-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 58a7c752a27011ef99858b75a2457dd9-20241114
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1522867474; Thu, 14 Nov 2024 18:08:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:07 +0800
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
Subject: [PATCH v13 24/25] virt: geniezone: Emulate IPI for guest VM
Date: Thu, 14 Nov 2024 18:08:01 +0800
Message-ID: <20241114100802.4116-25-liju-clr.chen@mediatek.com>
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

From: Kevenny Hsieh <kevenny.hsieh@mediatek.com>

Emulate Inter-Processor Interrupts (IPI) handling for guest VMs.
Ensure that when a vCPU thread enters an idle state and relinquishes
CPU control to the host, it can be woken up by IPIs issued by other
vCPUs through the gzvm driver.

Add a new wake-up mechanism, `GZVM_EXIT_IPI`, to handle IPIs. Ensure
that idle vCPUs can be woken up not only by virtual timer (vtimer) and
virtio interrupts but also by IPIs issued by other vCPUs.

Ensure proper handling of IPIs, allowing idle vCPUs to be woken up and
respond to interrupts, thereby maintaining correct and efficient
inter-processor communication within the guest VM.

Signed-off-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 drivers/virt/geniezone/gzvm_exception.c | 5 +++++
 drivers/virt/geniezone/gzvm_vcpu.c      | 3 +++
 include/linux/soc/mediatek/gzvm_drv.h   | 1 +
 include/uapi/linux/gzvm.h               | 1 +
 4 files changed, 10 insertions(+)

diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
index 391168a3f737..7a4e3d76aa7a 100644
--- a/drivers/virt/geniezone/gzvm_exception.c
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -105,3 +105,8 @@ int gzvm_handle_guest_idle(struct gzvm_vcpu *vcpu)
 
 	return ret;
 }
+
+void gzvm_handle_guest_ipi(struct gzvm_vcpu *vcpu)
+{
+	gzvm_vcpu_wakeup_all(vcpu->gzvm);
+}
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 247848ee126c..5cdd6ccbe76d 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -184,6 +184,9 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 		case GZVM_EXIT_IDLE:
 			gzvm_handle_guest_idle(vcpu);
 			break;
+		case GZVM_EXIT_IPI:
+			gzvm_handle_guest_ipi(vcpu);
+			break;
 		case GZVM_EXIT_UNKNOWN:
 			fallthrough;
 		default:
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 54fa7aea7245..8fc6c6f54227 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -266,6 +266,7 @@ int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa);
 bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 bool gzvm_arch_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 int gzvm_handle_guest_idle(struct gzvm_vcpu *vcpu);
+void gzvm_handle_guest_ipi(struct gzvm_vcpu *vcpu);
 void gzvm_vcpu_wakeup_all(struct gzvm *gzvm);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 61ce53cd9448..d69e1abb21a0 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -190,6 +190,7 @@ enum {
 	GZVM_EXIT_SHUTDOWN = 0x92920009,
 	GZVM_EXIT_GZ = 0x9292000a,
 	GZVM_EXIT_IDLE = 0x9292000b,
+	GZVM_EXIT_IPI = 0x9292000d,
 };
 
 /* exception definitions of GZVM_EXIT_EXCEPTION */
-- 
2.18.0


