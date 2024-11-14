Return-Path: <netdev+bounces-144796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE29C870D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB41D1F20F18
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6381FA85C;
	Thu, 14 Nov 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hu+AMsdy"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525741F893F;
	Thu, 14 Nov 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578901; cv=none; b=roJraVobWjPSPhDJ4/KgHz9OJiUqJdZk/A9HRetzyzkV1mobZ+bbcWj1Y32K+HQ7b1Z8ZDd97QZLkstEy0yyNxFTaluDyTcQZM80shwyERlhMnaxO7Fli1TgKvpkGPoXcyBMPjQ5Zh7zuTwgZkbsZYTvRNyHjtg2NE0teB2Yjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578901; c=relaxed/simple;
	bh=Zjt7fBQtLgMlW6MzTLZ8+OwkYRvacRfMQCdKXXE8hZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDWWhNFIPzHUxDRh9t76O81amlnu0LYgrbv0P3YRG4c4F2b22QdNZOiQnsqEOB7827NSHKDkrTghRTlyxfCZ+lkHD7jHpPOKvZsI/6XZePnid4NWXFxWPXjZSt2NZHQVexuU8XO4i/ql2P2yGPixrRUAK70nemo233vHLzeNAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hu+AMsdy; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58860766a27011efbd192953cf12861f-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TOxnymXbfRT1DhUocscm0skShCOMFhsJtkf5CuwCaMY=;
	b=hu+AMsdy2tn2xX6PXB2f8FcToozYM6fGzsT0UQxsk0+w9F9mAKpdPSh4/RpvQKaeXgpl8dFHMOX/TVPP1+eo0LexgW+hFQKGtJCb9PnNg2foZf7+aFtdeYaekMWPd/EOOULSh/rlO2xDvQnMROprj8Rhdak3zotiiorF/7C2oU8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1fd6c40c-41f9-4969-a300-b8e140aabc9e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:5b3fa25c-f18b-4d56-b49c-93279ee09144,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 58860766a27011efbd192953cf12861f-20241114
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 826411859; Thu, 14 Nov 2024 18:08:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 18:08:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:06 +0800
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
Subject: [PATCH v13 20/25] virt: geniezone: Add tracing support for hyp call and vcpu exit_reason
Date: Thu, 14 Nov 2024 18:07:57 +0800
Message-ID: <20241114100802.4116-21-liju-clr.chen@mediatek.com>
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

From: Liju Chen <liju-clr.chen@mediatek.com>

Add tracepoints for hypervisor calls and VCPU exit reasons in GenieZone
driver. It aids performance debugging by providing more information
about hypervisor operations and VCPU behavior.

Command Usage:
echo geniezone:* >> /sys/kernel/tracing/set_event
echo 1 > /sys/kernel/tracing/tracing_on
echo 0 > /sys/kernel/tracing/tracing_on
cat /sys/kernel/tracing/trace

For example:
crosvm_vcpu0-4874    [007] .....    94.757349: mtk_hypcall_enter: id=0xfb001005
crosvm_vcpu0-4874    [007] .....    94.760902: mtk_hypcall_leave: id=0xfb001005 invalid=0
crosvm_vcpu0-4874    [007] .....    94.760902: mtk_vcpu_exit: vcpu exit_reason=IRQ(0x92920003)

This example tracks a hypervisor function call by an ID (`0xbb001005`)
from initiation to termination, which is supported (invalid=0). A vCPU
exit is triggered by an Interrupt Request (IRQ) (exit reason: 0x92920003).

/* VM exit reason */
enum {
	GZVM_EXIT_UNKNOWN = 0x92920000,
	GZVM_EXIT_MMIO = 0x92920001,
	GZVM_EXIT_HYPERCALL = 0x92920002,
	GZVM_EXIT_IRQ = 0x92920003,
	GZVM_EXIT_EXCEPTION = 0x92920004,
	GZVM_EXIT_DEBUG = 0x92920005,
	GZVM_EXIT_FAIL_ENTRY = 0x92920006,
	GZVM_EXIT_INTERNAL_ERROR = 0x92920007,
	GZVM_EXIT_SYSTEM_EVENT = 0x92920008,
	GZVM_EXIT_SHUTDOWN = 0x92920009,
	GZVM_EXIT_GZ = 0x9292000a,
};

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/vm.c          |  4 ++
 drivers/virt/geniezone/gzvm_vcpu.c |  3 ++
 include/trace/events/geniezone.h   | 84 ++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 include/trace/events/geniezone.h

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 0350d9444c18..026c1980d054 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -7,6 +7,8 @@
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/geniezone.h>
 #include <linux/gzvm.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
 #include "gzvm_arch_common.h"
@@ -44,11 +46,13 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
 		.a6 = a6,
 		.a7 = a7,
 	};
+	trace_mtk_hypcall_enter(a0);
 	arm_smccc_1_2_hvc(&args, &res_1_2);
 	res->a0 = res_1_2.a0;
 	res->a1 = res_1_2.a1;
 	res->a2 = res_1_2.a2;
 	res->a3 = res_1_2.a3;
+	trace_mtk_hypcall_leave(a0, (res->a0 != ERR_NOT_SUPPORTED) ? 0 : 1);
 
 	return gzvm_err_to_errno(res->a0);
 }
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index b0dc3e4f47d7..3b146148abf3 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -9,6 +9,8 @@
 #include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+
+#include <trace/events/geniezone.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
 
 /* maximum size needed for holding an integer */
@@ -102,6 +104,7 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 
 	while (!need_userspace && !signal_pending(current)) {
 		gzvm_arch_vcpu_run(vcpu, &exit_reason);
+		trace_mtk_vcpu_exit(exit_reason);
 
 		switch (exit_reason) {
 		case GZVM_EXIT_MMIO:
diff --git a/include/trace/events/geniezone.h b/include/trace/events/geniezone.h
new file mode 100644
index 000000000000..4fffd826ba67
--- /dev/null
+++ b/include/trace/events/geniezone.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM geniezone
+
+#define _TRACE_GENIEZONE_H
+
+#include <linux/gzvm.h>
+#include <linux/tracepoint.h>
+
+#define GZVM_EXIT_REASONS \
+EM(UNKNOWN)\
+EM(MMIO)\
+EM(HYPERCALL)\
+EM(IRQ)\
+EM(EXCEPTION)\
+EM(DEBUG)\
+EM(FAIL_ENTRY)\
+EM(INTERNAL_ERROR)\
+EM(SYSTEM_EVENT)\
+EM(SHUTDOWN)\
+EMe(GZ)
+
+#undef EM
+#undef EMe
+#define EM(a) TRACE_DEFINE_ENUM(GZVM_EXIT_##a);
+#define EMe(a) TRACE_DEFINE_ENUM(GZVM_EXIT_##a);
+
+GZVM_EXIT_REASONS
+
+#undef EM
+#undef EMe
+
+#define EM(a)       { GZVM_EXIT_##a, #a },
+#define EMe(a)      { GZVM_EXIT_##a, #a }
+
+TRACE_EVENT(mtk_hypcall_enter,
+	    TP_PROTO(unsigned long id),
+
+	    TP_ARGS(id),
+
+	    TP_STRUCT__entry(__field(unsigned long, id)),
+
+	    TP_fast_assign(__entry->id = id;),
+
+	    TP_printk("id=0x%lx", __entry->id)
+);
+
+TRACE_EVENT(mtk_hypcall_leave,
+	    TP_PROTO(unsigned long id, unsigned long invalid),
+
+	    TP_ARGS(id, invalid),
+
+	    TP_STRUCT__entry(__field(unsigned long, id)
+			     __field(unsigned long, invalid)
+	    ),
+
+	    TP_fast_assign(__entry->id = id;
+			   __entry->invalid = invalid;
+	    ),
+
+	    TP_printk("id=0x%lx invalid=%lu", __entry->id, __entry->invalid)
+);
+
+TRACE_EVENT(mtk_vcpu_exit,
+	    TP_PROTO(unsigned long exit_reason),
+
+	    TP_ARGS(exit_reason),
+
+	    TP_STRUCT__entry(__field(unsigned long, exit_reason)),
+
+	    TP_fast_assign(__entry->exit_reason = exit_reason;),
+
+	    TP_printk("vcpu exit_reason=%s(0x%lx)",
+		      __print_symbolic(__entry->exit_reason, GZVM_EXIT_REASONS),
+		      __entry->exit_reason)
+
+);
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.18.0


