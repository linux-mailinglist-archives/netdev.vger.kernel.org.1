Return-Path: <netdev+bounces-114033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53225940B81
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DAF1F23414
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77F199223;
	Tue, 30 Jul 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LR8XXURz"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014F194A77;
	Tue, 30 Jul 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327902; cv=none; b=F8v+2jX9ILb5COh62dmzsE4mE1BSXsChYNG+DAQNQOpPAit2r9rxa/a9+bPcACibzaRUWdajeU6QAIUdknSPL44fm2ZQgEcoOBbrY5ynnLnQjn2JDtb/ZySxO0G+rpxL1CeK+8Ri0zp+WkddNeuyUcUXmGaIlInF9kwIe0j1uTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327902; c=relaxed/simple;
	bh=wzIqHtHQsXe2Q3mVccQ10owPm4RJozhUdYWOwbuzoSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOIPRMP9awyqNCM79fPOJNC8S59W0EouxSL4hw370XT3yFkcG+34BSWmHigyjoFoCb003beIgwlncQVVEM5Ts/bq5GnXRowEpfrwS9kCh6mPemEt96wswU0ZC8nyAzVl3/2EMgE2P8dWIbTZzAQMQQCNsXmbc9hYTCUPUzbMoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LR8XXURz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f0be1984e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gS0SSJoMTpGGYuw1yF8PnhoHS0mh3H+dolB/IxQPYcE=;
	b=LR8XXURzQI4N0syTevRK0UxvpMAgmzYjEcMhQObP9y3Nb9eMLiMjmZC5LEBgoFiLfHb7JrHZz4V5lkx3ZdX88T0j3smmB4pU92LzT+LXZx7+t1z1bdzntjYFlE3gzi4RRb56Hh5Xy8ovMDKFE9rQ3ouAfvt59KfBtQ3+7BFGNCc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0aa4e902-55b6-473b-953b-f68c45bc4a49,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6dc6a47,CLOUDID:4b1d11d2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2f0be1984e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1235617757; Tue, 30 Jul 2024 16:24:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:38 +0800
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
Subject: [PATCH v12 11/24] virt: geniezone: Add ioeventfd support
Date: Tue, 30 Jul 2024 16:24:23 +0800
Message-ID: <20240730082436.9151-12-liju-clr.chen@mediatek.com>
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
X-TM-AS-Result: No-10--10.421100-8.000000
X-TMASE-MatchedRID: LEh2rosnnTdFXAohF8vNJsnUT+eskUQPsjXBCUyiRiYExRMryOBAgVe/
	KWmAuveA8AyWk2NFMNZM8qdoCvOVvj13WcdbGR6QpvwZ9GmdwDPDHSNFHFxB8/EJBoK3pfxusLN
	r5TqhtfjcN0v5cWnqNbwpUHaPzI/rpljg/F9ExYTJ1E39jKDimP+UEb65dgmQCqIJhrrDy2+zGY
	EK/2YaaGNbE4CAcEm4UNsncxXyULflb2fVWad3hB3EEAbn+GRbU+A7YkpDJ1j7eDzreGwykfhT6
	/pHvNpJbYhZaTgJK+cOl4+I2REw+o434Zqk7ja9Z91l70P0n5gWyk90TI5HWhhebWRMUzUk166X
	b3/Hw4PawbqPp7YH7nle04HMQBrpbx+xmQHMNIO5OP59hhqaSIfsPVs/8Vw6itUKTl2bFuqWJwm
	I319SEUrTBDFLr+J6xFVslrem0y5k8dv95NwXEb50lYduDghO0Wobj8GkNVp2jD/JuqpOktqP3/
	FJpX5vJr4WRqPKAUZkBfBoO7jomX4yb5DiJrQyuXBOQEKj7Tgol9KlwBS/XZsoi2XrUn/Jn6KdM
	rRsL14qtq5d3cxkNYwmYPNvIh23mFkfmYwROiYx2Cl2RlZn9o0+p93XvPgKu2QwcffYR6o=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.421100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DF59661E9EE576B663DDA166529F07E673D72577C243F08BAB35EA01192DFEEF2000:8
X-MTK: N

From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>

Ioeventfd leverages eventfd to provide asynchronous notification
mechanism for VMM. VMM can register a mmio address and bind with an
eventfd. Once a mmio trap occurs on this registered region, its
corresponding eventfd will be notified.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_ioeventfd.c | 281 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      |  27 ++-
 drivers/virt/geniezone/gzvm_vm.c        |  17 ++
 include/linux/soc/mediatek/gzvm_drv.h   |  15 ++
 include/uapi/linux/gzvm.h               |  25 +++
 6 files changed, 366 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_ioeventfd.c

diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 19a835b0aac2..bc5ae49f2407 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,4 +7,5 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
-	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o
+	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o \
+	  $(GZVM_DIR)/gzvm_ioeventfd.o
diff --git a/drivers/virt/geniezone/gzvm_ioeventfd.c b/drivers/virt/geniezone/gzvm_ioeventfd.c
new file mode 100644
index 000000000000..3ab65d78acba
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_ioeventfd.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/syscalls.h>
+#include <linux/gzvm.h>
+#include <linux/soc/mediatek/gzvm_drv.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+struct gzvm_ioevent {
+	struct list_head list;
+	__u64 addr;
+	__u32 len;
+	struct eventfd_ctx  *evt_ctx;
+	__u64 datamatch;
+	bool wildcard;
+};
+
+/**
+ * ioeventfd_check_collision() - Check collison assumes gzvm->ioevent_lock held.
+ * @gzvm: Pointer to gzvm.
+ * @p: Pointer to gzvm_ioevent.
+ *
+ * Return:
+ * * true			- collison found
+ * * false			- no collison
+ */
+static bool ioeventfd_check_collision(struct gzvm *gzvm, struct gzvm_ioevent *p)
+{
+	struct gzvm_ioevent *_p;
+
+	list_for_each_entry(_p, &gzvm->ioevents, list) {
+		if (_p->addr == p->addr &&
+		    (!_p->len || !p->len ||
+		     (_p->len == p->len &&
+		      (_p->wildcard || p->wildcard ||
+		       _p->datamatch == p->datamatch))))
+			return true;
+		if (p->addr >= _p->addr && p->addr < _p->addr + _p->len)
+			return true;
+	}
+
+	return false;
+}
+
+static void gzvm_ioevent_release(struct gzvm_ioevent *p)
+{
+	eventfd_ctx_put(p->evt_ctx);
+	list_del(&p->list);
+	kfree(p);
+}
+
+static bool gzvm_ioevent_in_range(struct gzvm_ioevent *p, __u64 addr, int len,
+				  const void *val)
+{
+	u64 _val;
+
+	if (addr != p->addr)
+		/* address must be precise for a hit */
+		return false;
+
+	if (!p->len)
+		/* length = 0 means only look at the address, so always a hit */
+		return true;
+
+	if (len != p->len)
+		/* address-range must be precise for a hit */
+		return false;
+
+	if (p->wildcard)
+		/* all else equal, wildcard is always a hit */
+		return true;
+
+	/* otherwise, we have to actually compare the data */
+
+	WARN_ON_ONCE(!IS_ALIGNED((unsigned long)val, len));
+
+	switch (len) {
+	case 1:
+		_val = *(u8 *)val;
+		break;
+	case 2:
+		_val = *(u16 *)val;
+		break;
+	case 4:
+		_val = *(u32 *)val;
+		break;
+	case 8:
+		_val = *(u64 *)val;
+		break;
+	default:
+		return false;
+	}
+
+	return _val == p->datamatch;
+}
+
+static int gzvm_deassign_ioeventfd(struct gzvm *gzvm,
+				   struct gzvm_ioeventfd *args)
+{
+	struct gzvm_ioevent *p, *tmp;
+	struct eventfd_ctx *evt_ctx;
+	int ret = -ENOENT;
+	bool wildcard;
+
+	evt_ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(evt_ctx))
+		return PTR_ERR(evt_ctx);
+
+	wildcard = !(args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH);
+
+	mutex_lock(&gzvm->ioevent_lock);
+	list_for_each_entry_safe(p, tmp, &gzvm->ioevents, list) {
+		if (p->evt_ctx != evt_ctx  ||
+		    p->addr != args->addr  ||
+		    p->len != args->len ||
+		    p->wildcard != wildcard)
+			continue;
+
+		if (!p->wildcard && p->datamatch != args->datamatch)
+			continue;
+
+		gzvm_ioevent_release(p);
+		ret = 0;
+		break;
+	}
+
+	mutex_unlock(&gzvm->ioevent_lock);
+
+	/* got in the front of this function */
+	eventfd_ctx_put(evt_ctx);
+
+	return ret;
+}
+
+static int gzvm_assign_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args)
+{
+	struct eventfd_ctx *evt_ctx;
+	struct gzvm_ioevent *evt;
+	int ret;
+
+	evt_ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(evt_ctx))
+		return PTR_ERR(evt_ctx);
+
+	evt = kmalloc(sizeof(*evt), GFP_KERNEL);
+	if (!evt)
+		return -ENOMEM;
+	*evt = (struct gzvm_ioevent) {
+		.addr = args->addr,
+		.len = args->len,
+		.evt_ctx = evt_ctx,
+	};
+	if (args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH) {
+		evt->datamatch = args->datamatch;
+		evt->wildcard = false;
+	} else {
+		evt->wildcard = true;
+	}
+
+	mutex_lock(&gzvm->ioevent_lock);
+	if (ioeventfd_check_collision(gzvm, evt)) {
+		ret = -EEXIST;
+		mutex_unlock(&gzvm->ioevent_lock);
+		goto err_free;
+	}
+
+	list_add_tail(&evt->list, &gzvm->ioevents);
+	mutex_unlock(&gzvm->ioevent_lock);
+
+	return 0;
+
+err_free:
+	kfree(evt);
+	eventfd_ctx_put(evt_ctx);
+	return ret;
+}
+
+/**
+ * gzvm_ioeventfd_check_valid() - Check user arguments is valid.
+ * @args: Pointer to gzvm_ioeventfd.
+ *
+ * Return:
+ * * true if user arguments are valid.
+ * * false if user arguments are invalid.
+ */
+static bool gzvm_ioeventfd_check_valid(struct gzvm_ioeventfd *args)
+{
+	/* must be natural-word sized, or 0 to ignore length */
+	switch (args->len) {
+	case 0:
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		break;
+	default:
+		return false;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return false;
+
+	/* check for extra flags that we don't understand */
+	if (args->flags & ~GZVM_IOEVENTFD_VALID_FLAG_MASK)
+		return false;
+
+	/* ioeventfd with no length can't be combined with DATAMATCH */
+	if (!args->len && (args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH))
+		return false;
+
+	/* gzvm does not support pio bus ioeventfd */
+	if (args->flags & GZVM_IOEVENTFD_FLAG_PIO)
+		return false;
+
+	return true;
+}
+
+/**
+ * gzvm_ioeventfd() - Register ioevent to ioevent list.
+ * @gzvm: Pointer to gzvm.
+ * @args: Pointer to gzvm_ioeventfd.
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
+ */
+int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args)
+{
+	if (gzvm_ioeventfd_check_valid(args) == false)
+		return -EINVAL;
+
+	if (args->flags & GZVM_IOEVENTFD_FLAG_DEASSIGN)
+		return gzvm_deassign_ioeventfd(gzvm, args);
+	return gzvm_assign_ioeventfd(gzvm, args);
+}
+
+/**
+ * gzvm_ioevent_write() - Travers this vm's registered ioeventfd to see if
+ *			  need notifying it.
+ * @vcpu: Pointer to vcpu.
+ * @addr: mmio address.
+ * @len: mmio size.
+ * @val: Pointer to void.
+ *
+ * Return:
+ * * true if this io is already sent to ioeventfd's listener.
+ * * false if we cannot find any ioeventfd registering this mmio write.
+ */
+bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
+			const void *val)
+{
+	struct gzvm_ioevent *e;
+
+	mutex_lock(&vcpu->gzvm->ioevent_lock);
+	list_for_each_entry(e, &vcpu->gzvm->ioevents, list) {
+		if (gzvm_ioevent_in_range(e, addr, len, val)) {
+			eventfd_signal(e->evt_ctx);
+			mutex_unlock(&vcpu->gzvm->ioevent_lock);
+			return true;
+		}
+	}
+
+	mutex_unlock(&vcpu->gzvm->ioevent_lock);
+	return false;
+}
+
+int gzvm_init_ioeventfd(struct gzvm *gzvm)
+{
+	INIT_LIST_HEAD(&gzvm->ioevents);
+	mutex_init(&gzvm->ioevent_lock);
+
+	return 0;
+}
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 7e1e16d0f3a1..446c0e42dec6 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -50,6 +50,30 @@ static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu,
 	return 0;
 }
 
+/**
+ * gzvm_vcpu_handle_mmio() - Handle mmio in kernel space.
+ * @vcpu: Pointer to vcpu.
+ *
+ * Return:
+ * * true - This mmio exit has been processed.
+ * * false - This mmio exit has not been processed, require userspace.
+ */
+static bool gzvm_vcpu_handle_mmio(struct gzvm_vcpu *vcpu)
+{
+	__u64 addr;
+	__u32 len;
+	const void *val_ptr;
+
+	/* So far, we don't have in-kernel mmio read handler */
+	if (!vcpu->run->mmio.is_write)
+		return false;
+	addr = vcpu->run->mmio.phys_addr;
+	len = vcpu->run->mmio.size;
+	val_ptr = &vcpu->run->mmio.data;
+
+	return gzvm_ioevent_write(vcpu, addr, len, val_ptr);
+}
+
 /**
  * gzvm_vcpu_run() - Handle vcpu run ioctl, entry point to guest and exit
  *		     point from guest
@@ -81,7 +105,8 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 
 		switch (exit_reason) {
 		case GZVM_EXIT_MMIO:
-			need_userspace = true;
+			if (!gzvm_vcpu_handle_mmio(vcpu))
+				need_userspace = true;
 			break;
 		/**
 		 * it's geniezone's responsibility to fill corresponding data
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 7f5b1fc2ab8c..e7415d0620af 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -254,6 +254,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_irqfd(gzvm, &data);
 		break;
 	}
+	case GZVM_IOEVENTFD: {
+		struct gzvm_ioeventfd data;
+
+		if (copy_from_user(&data, argp, sizeof(data))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_ioeventfd(gzvm, &data);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
@@ -330,6 +340,13 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 		return ERR_PTR(ret);
 	}
 
+	ret = gzvm_init_ioeventfd(gzvm);
+	if (ret) {
+		pr_err("Failed to initialize ioeventfd\n");
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 4e7ac8014cec..096e72b76e5c 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -6,6 +6,7 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <linux/eventfd.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
@@ -104,6 +105,8 @@ struct gzvm_vcpu {
  * @memslot: VM's memory slot descriptor
  * @lock: lock for list_add
  * @irqfds: the data structure is used to keep irqfds's information
+ * @ioevents: list head for ioevents
+ * @ioevent_lock: lock for ioevent list
  * @vm_list: list head for vm list
  * @vm_id: vm id
  * @irq_ack_notifier_list: list head for irq ack notifier
@@ -123,6 +126,9 @@ struct gzvm {
 		struct mutex      resampler_lock;
 	} irqfds;
 
+	struct list_head ioevents;
+	struct mutex ioevent_lock;
+
 	struct list_head vm_list;
 	u16 vm_id;
 
@@ -173,4 +179,13 @@ void gzvm_drv_irqfd_exit(void);
 int gzvm_vm_irqfd_init(struct gzvm *gzvm);
 void gzvm_vm_irqfd_release(struct gzvm *gzvm);
 
+int gzvm_init_ioeventfd(struct gzvm *gzvm);
+int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
+bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
+			const void *val);
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr);
+void add_wait_queue_priority(struct wait_queue_head *wq_head,
+			     struct wait_queue_entry *wq_entry);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index aa61ece00cac..6e102cbfec98 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -339,4 +339,29 @@ struct gzvm_irqfd {
 
 #define GZVM_IRQFD	_IOW(GZVM_IOC_MAGIC, 0x76, struct gzvm_irqfd)
 
+enum {
+	gzvm_ioeventfd_flag_nr_datamatch = 0,
+	gzvm_ioeventfd_flag_nr_pio = 1,
+	gzvm_ioeventfd_flag_nr_deassign = 2,
+	gzvm_ioeventfd_flag_nr_max,
+};
+
+#define GZVM_IOEVENTFD_FLAG_DATAMATCH	(1 << gzvm_ioeventfd_flag_nr_datamatch)
+#define GZVM_IOEVENTFD_FLAG_PIO		(1 << gzvm_ioeventfd_flag_nr_pio)
+#define GZVM_IOEVENTFD_FLAG_DEASSIGN	(1 << gzvm_ioeventfd_flag_nr_deassign)
+#define GZVM_IOEVENTFD_VALID_FLAG_MASK	((1 << gzvm_ioeventfd_flag_nr_max) - 1)
+
+struct gzvm_ioeventfd {
+	__u64 datamatch;
+	/* private: legal pio/mmio address */
+	__u64 addr;
+	/* private: 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__u32 len;
+	__s32 fd;
+	__u32 flags;
+	__u8  pad[36];
+};
+
+#define GZVM_IOEVENTFD	_IOW(GZVM_IOC_MAGIC, 0x79, struct gzvm_ioeventfd)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0


