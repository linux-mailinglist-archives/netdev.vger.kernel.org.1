Return-Path: <netdev+bounces-114034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733F1940B84
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C6C2867F8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853D619939B;
	Tue, 30 Jul 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qNiCW+mr"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9D192B87;
	Tue, 30 Jul 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327902; cv=none; b=em+deapnYx/s8cqyZMoNImvQRIOGeAXgBbPuJG9h7MQ9QQkH+eVxPuL8FOoqsNp2var1BjZv9i4wsw1cdnQPUqL8SGiUXONTzS76gn9wMRKfL2MvwpISLcunPwGTqFeMg+HubvFEvo4nLcf8j71MYezBGxkRAH4Z7cV4rKpGG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327902; c=relaxed/simple;
	bh=Z5PpKmUt6ndVpX6eH/PPsQpUJ7qGgb6oyllXrZBd/P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jC0sx07Owx0wBpA3tL03VKBHEiaybILh5oLTdOyxE1wzI73RkY+cV7sE7s7Gj9d+cM7q+p0JdeP2cE6KSz1TYuXYbaiqPmYK5Ux1PhmUr+KwzqYck2v4ZJGGohZTgOhRLRf0l38XJgH7AvOvPlZpx8lPfqti0WxgdASTJOAJDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qNiCW+mr; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 330f6ba24e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CcJzTAL9IFu4/nhUMP2RjTp8+dJQAQi4jXS1e0DRnFY=;
	b=qNiCW+mrbTHqMq3Ivje8mGgJ4ZQKBFLQEC2qveMZ0lC4L7aAUe/GnTBZh1UgRbJzgCt6H+9KhJQGMxHbIOg5/wmTnyD86y0MrqBZ+e6159qIp/L0LM23xbtGXYFOx2ZOTPrLhi2lKQboD4VsRrE7+EzYN41tHKSWL3mv8KNTPKk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:bc0159b6-2371-4ec5-8d8b-ef1790efd4a1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:6dc6a47,CLOUDID:1e23e245-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 330f6ba24e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1299080935; Tue, 30 Jul 2024 16:24:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 01:24:40 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:40 +0800
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
Subject: [PATCH v12 24/24] virt: geniezone: Emulate IPI for guest VM
Date: Tue, 30 Jul 2024 16:24:36 +0800
Message-ID: <20240730082436.9151-25-liju-clr.chen@mediatek.com>
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
index 61f3ae4ee793..0302890ed69e 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -241,6 +241,7 @@ int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa);
 bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 bool gzvm_arch_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 int gzvm_handle_guest_idle(struct gzvm_vcpu *vcpu);
+void gzvm_handle_guest_ipi(struct gzvm_vcpu *vcpu);
 void gzvm_vcpu_wakeup_all(struct gzvm *gzvm);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 1fe483ef2ed5..bcbc4d62a70f 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -189,6 +189,7 @@ enum {
 	GZVM_EXIT_SHUTDOWN = 0x92920009,
 	GZVM_EXIT_GZ = 0x9292000a,
 	GZVM_EXIT_IDLE = 0x9292000b,
+	GZVM_EXIT_IPI = 0x9292000d,
 };
 
 /* exception definitions of GZVM_EXIT_EXCEPTION */
-- 
2.18.0


