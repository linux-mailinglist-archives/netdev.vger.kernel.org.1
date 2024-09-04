Return-Path: <netdev+bounces-125181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4396C303
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAE5282E48
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F271E2019;
	Wed,  4 Sep 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwtIhd7r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB41E1A01;
	Wed,  4 Sep 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465083; cv=none; b=EkHB1O0ddeUuWJemkurV1TfOVAY/rPWIRUAhz28QonY6Mfx76DbjSMb3+AKRyTjGDV+1K0pivFERHv4px4r/RXB6Ug8jaLr9hianmrtejGJcQepES9w1JQGiASKBFAncNm8smh6eIbi25EEVeY7pQIpZ4PEzBDvYvBNVxExdWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465083; c=relaxed/simple;
	bh=+c6k8kZUFsJQTANSFsKNMQJBLtPKazDUI2uf9Cm4mPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVknaxbqIoTjRJOemmensyMLiYD2Z3v2bQA/lrRujeTm7wKlGIQ+C+NiivtrL5PpE/N1XEeksR4148zzjMdBrDz2xdi6EHne5TRzq5JcWsKRmuBQQZHYRqpE1BEkBIekrkK1NzjD3lCogUWbo2yUsMtZ5CToK+gTrcT03Efssu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwtIhd7r; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725465082; x=1757001082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+c6k8kZUFsJQTANSFsKNMQJBLtPKazDUI2uf9Cm4mPk=;
  b=PwtIhd7rEbkeHa4elEBjI2F81lWWyc6crxOd7SKUX0a9MGo9iM8bEdvt
   fZyCzxMXPdD7e6VEySwMaP14NuIhhMGAX8FJ/z0a1U48sy8kE+h+wjHSa
   +FAm5Oq09hpVFZ6ijLpcm35t9aqxa9+A8gkW/v92pQLbiGhAFR2vihpIy
   B//49eizCnqR3DTj5uXz2eS4yK1Kg59f6MQEqfNVAYFS5BSA59SaI7ChV
   EQhoCkPeI8j2N1SDudAvt8040+nONRCyWaS8yrAlztaMN+YbJJWY/9Jbq
   /CUkS7SZgPxY7xUBqBvTUcVy6H/SSV9eJn7Kray1cUay5IfsFYIIImuI0
   g==;
X-CSE-ConnectionGUID: w81+6sLsRhaDxoyBQUKiIA==
X-CSE-MsgGUID: qrvvMTXrSLeDJPmwUfhGrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34737131"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34737131"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:51:21 -0700
X-CSE-ConnectionGUID: GaxMN3nIS/GGrC2LA+Y/IA==
X-CSE-MsgGUID: 4boM2xAERZihTXmohc5EmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="66041824"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2024 08:51:19 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 1/6] libeth: add Tx buffer completion helpers
Date: Wed,  4 Sep 2024 17:47:43 +0200
Message-ID: <20240904154748.2114199-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904154748.2114199-1-aleksander.lobakin@intel.com>
References: <20240904154748.2114199-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Software-side Tx buffers for storing DMA, frame size, skb pointers etc.
are pretty much generic and every driver defines them the same way. The
same can be said for software Tx completions -- same napi_consume_skb()s
and all that...
Add a couple simple wrappers for doing that to stop repeating the old
tale at least within the Intel code. Drivers are free to use 'priv'
member at the end of the structure.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/types.h |  25 +++++++
 include/net/libeth/tx.h    | 129 +++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 include/net/libeth/types.h
 create mode 100644 include/net/libeth/tx.h

diff --git a/include/net/libeth/types.h b/include/net/libeth/types.h
new file mode 100644
index 000000000000..603825e45133
--- /dev/null
+++ b/include/net/libeth/types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_TYPES_H
+#define __LIBETH_TYPES_H
+
+#include <linux/types.h>
+
+/**
+ * struct libeth_sq_napi_stats - "hot" counters to update in Tx completion loop
+ * @packets: completed frames counter
+ * @bytes: sum of bytes of completed frames above
+ * @raw: alias to access all the fields as an array
+ */
+struct libeth_sq_napi_stats {
+	union {
+		struct {
+							u32 packets;
+							u32 bytes;
+		};
+		DECLARE_FLEX_ARRAY(u32, raw);
+	};
+};
+
+#endif /* __LIBETH_TYPES_H */
diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
new file mode 100644
index 000000000000..35614f9523f6
--- /dev/null
+++ b/include/net/libeth/tx.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_TX_H
+#define __LIBETH_TX_H
+
+#include <linux/skbuff.h>
+
+#include <net/libeth/types.h>
+
+/* Tx buffer completion */
+
+/**
+ * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
+ * @LIBETH_SQE_EMPTY: unused/empty, no action required
+ * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
+ * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
+ * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
+ * @LIBETH_SQE_SKB: &sk_buff, unmap and napi_consume_skb(), update stats
+ */
+enum libeth_sqe_type {
+	LIBETH_SQE_EMPTY		= 0U,
+	LIBETH_SQE_CTX,
+	LIBETH_SQE_SLAB,
+	LIBETH_SQE_FRAG,
+	LIBETH_SQE_SKB,
+};
+
+/**
+ * struct libeth_sqe - represents a Send Queue Element / Tx buffer
+ * @type: type of the buffer, see the enum above
+ * @rs_idx: index of the last buffer from the batch this one was sent in
+ * @raw: slab buffer to free via kfree()
+ * @skb: &sk_buff to consume
+ * @dma: DMA address to unmap
+ * @len: length of the mapped region to unmap
+ * @nr_frags: number of frags in the frame this buffer belongs to
+ * @packets: number of physical packets sent for this frame
+ * @bytes: number of physical bytes sent for this frame
+ * @priv: driver-private scratchpad
+ */
+struct libeth_sqe {
+	enum libeth_sqe_type		type:32;
+	u32				rs_idx;
+
+	union {
+		void				*raw;
+		struct sk_buff			*skb;
+	};
+
+	DEFINE_DMA_UNMAP_ADDR(dma);
+	DEFINE_DMA_UNMAP_LEN(len);
+
+	u32				nr_frags;
+	u32				packets;
+	u32				bytes;
+
+	unsigned long			priv;
+} __aligned_largest;
+
+/**
+ * LIBETH_SQE_CHECK_PRIV - check the driver's private SQE data
+ * @p: type or name of the object the driver wants to fit into &libeth_sqe
+ *
+ * Make sure the driver's private data fits into libeth_sqe::priv. To be used
+ * right after its declaration.
+ */
+#define LIBETH_SQE_CHECK_PRIV(p)					  \
+	static_assert(sizeof(p) <= sizeof_field(struct libeth_sqe, priv))
+
+/**
+ * struct libeth_cq_pp - completion queue poll params
+ * @dev: &device to perform DMA unmapping
+ * @ss: onstack NAPI stats to fill
+ * @napi: whether it's called from the NAPI context
+ *
+ * libeth uses this structure to access objects needed for performing full
+ * Tx complete operation without passing lots of arguments and change the
+ * prototypes each time a new one is added.
+ */
+struct libeth_cq_pp {
+	struct device			*dev;
+	struct libeth_sq_napi_stats	*ss;
+
+	bool				napi;
+};
+
+/**
+ * libeth_tx_complete - perform Tx completion for one SQE
+ * @sqe: SQE to complete
+ * @cp: poll params
+ *
+ * Do Tx complete for all the types of buffers, incl. freeing, unmapping,
+ * updating the stats etc.
+ */
+static inline void libeth_tx_complete(struct libeth_sqe *sqe,
+				      const struct libeth_cq_pp *cp)
+{
+	switch (sqe->type) {
+	case LIBETH_SQE_EMPTY:
+		return;
+	case LIBETH_SQE_SKB:
+	case LIBETH_SQE_FRAG:
+	case LIBETH_SQE_SLAB:
+		dma_unmap_page(cp->dev, dma_unmap_addr(sqe, dma),
+			       dma_unmap_len(sqe, len), DMA_TO_DEVICE);
+		break;
+	default:
+		break;
+	}
+
+	switch (sqe->type) {
+	case LIBETH_SQE_SKB:
+		cp->ss->packets += sqe->packets;
+		cp->ss->bytes += sqe->bytes;
+
+		napi_consume_skb(sqe->skb, cp->napi);
+		break;
+	case LIBETH_SQE_SLAB:
+		kfree(sqe->raw);
+		break;
+	default:
+		break;
+	}
+
+	sqe->type = LIBETH_SQE_EMPTY;
+}
+
+#endif /* __LIBETH_TX_H */
-- 
2.46.0


