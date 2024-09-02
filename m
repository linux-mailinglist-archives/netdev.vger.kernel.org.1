Return-Path: <netdev+bounces-124236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08055968A69
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA0E1C21A9F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59A1A303A;
	Mon,  2 Sep 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N6MJONfU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA71A263D;
	Mon,  2 Sep 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288911; cv=none; b=Dc5YON8mkfY4gaAIhasUSdwUTOPYJEayQ8mhkX43BWKd2wtX1nNDXqGkaSxfJQ8zmCK0QU1WrDzpNZziVz9OT2RsufyBRkB7QgxS2rfVDLE9GK9/rRr3h2rJksS9mXL8oQSAQlFGqlQd2eZA2wPRHQqixcvRjiXSowrmpI4G3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288911; c=relaxed/simple;
	bh=HJSeBoG37HOXuBlKwLJGao5fjrJY3G0gBKHFIisc/fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lVrHh788ddeKJmudoNurm57xfJQjyZx5kpI2BuWlWQ5T3n+NHtxeDbf+Bk5f7kRpFXduwQMoZUWR5LkaRIPqb7R6lZMBNFJAparl+2AYrLoAVNh/MGZIVYx0D54b0y1CWiceMOgiwdg18ju9fkFwE8dEFaa6Vcg0ySknux18URM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N6MJONfU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288909; x=1756824909;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HJSeBoG37HOXuBlKwLJGao5fjrJY3G0gBKHFIisc/fI=;
  b=N6MJONfUCDukqDbboiKVo6oeeRcFK8u3hmlwn/FXu27UZb84bj86icNM
   36VXW82L5N25f+kOzzTL1Nx634CDYAv2e5KCY10Pb6lkXkR31zpxWO+Dz
   nfS8VDC7nd1P0pMeB66gDiTyPmYfzbzH4R+Twrv/qoWOoUKpSeg68bFWJ
   5BjQ8TdxqngLY73KvkfdhsnqebC7Cs61TZqYapFLKCtTnNUAZCbFSq5T/
   kJMLALSEALwdrHVEJBg73z+AaEinaCs+TpsfTZs1BE3DMAO9sAqSa5OnM
   NxQ+vSui4RIUrPTsBOUyUzFph2dkkdpCVQQyNlrJ6LvSW7Il3cKWwNNkH
   A==;
X-CSE-ConnectionGUID: /Vcaqev1TP+OZLTGnI90pA==
X-CSE-MsgGUID: hMM1KTKPQ7G/9e3jAPiofw==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34271104"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:39 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:36 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:06 +0200
Subject: [PATCH net-next 01/12] net: microchip: add FDMA library
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-1-1e7d5e5a9f34@microchip.com>
References: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
In-Reply-To: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<rdunlap@infradead.org>, <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14-dev

Add new FDMA library for interacting with the FDMA engine on Microchip
Sparx5 and lan966x switch chips, in an effort to reduce duplicate code
and provide a common set of symbols and functions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig         |   1 +
 drivers/net/ethernet/microchip/Makefile        |   1 +
 drivers/net/ethernet/microchip/fdma/Kconfig    |  18 ++
 drivers/net/ethernet/microchip/fdma/Makefile   |   7 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c | 146 +++++++++++++++
 drivers/net/ethernet/microchip/fdma/fdma_api.h | 243 +++++++++++++++++++++++++
 drivers/net/ethernet/microchip/sparx5/Kconfig  |   1 +
 7 files changed, 417 insertions(+)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 43ba71e82260..ce2435987fb6 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -59,5 +59,6 @@ config LAN743X
 source "drivers/net/ethernet/microchip/lan966x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
+source "drivers/net/ethernet/microchip/fdma/Kconfig"
 
 endif # NET_VENDOR_MICROCHIP
diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
index bbd349264e6f..94045537b643 100644
--- a/drivers/net/ethernet/microchip/Makefile
+++ b/drivers/net/ethernet/microchip/Makefile
@@ -12,3 +12,4 @@ lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
 obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
 obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
 obj-$(CONFIG_VCAP) += vcap/
+obj-$(CONFIG_FDMA) += fdma/
diff --git a/drivers/net/ethernet/microchip/fdma/Kconfig b/drivers/net/ethernet/microchip/fdma/Kconfig
new file mode 100644
index 000000000000..59159ad6701a
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microchip FDMA API configuration
+#
+
+if NET_VENDOR_MICROCHIP
+
+config FDMA
+	bool "FDMA API"
+	help
+	  Provides the basic FDMA functionality for multiple Microchip
+	  switchcores.
+
+	  Say Y here if you want to build the FDMA API that provides a common
+	  set of functions and data structures for interacting with the Frame
+	  DMA engine in multiple microchip switchcores.
+
+endif # NET_VENDOR_MICROCHIP
diff --git a/drivers/net/ethernet/microchip/fdma/Makefile b/drivers/net/ethernet/microchip/fdma/Makefile
new file mode 100644
index 000000000000..cc9a736be357
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Microchip FDMA
+#
+
+obj-$(CONFIG_FDMA) += fdma.o
+fdma-y += fdma_api.o
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
new file mode 100644
index 000000000000..e78c3590da9e
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "fdma_api.h"
+
+#include <linux/bits.h>
+#include <linux/etherdevice.h>
+#include <linux/types.h>
+
+/* Add a DB to a DCB, providing a callback for getting the DB dataptr. */
+static int __fdma_db_add(struct fdma *fdma, int dcb_idx, int db_idx, u64 status,
+			 int (*cb)(struct fdma *fdma, int dcb_idx,
+				   int db_idx, u64 *dataptr))
+{
+	struct fdma_db *db = fdma_db_get(fdma, dcb_idx, db_idx);
+
+	db->status = status;
+
+	return cb(fdma, dcb_idx, db_idx, &db->dataptr);
+}
+
+/* Add a DB to a DCB, using the callback set in the fdma_ops struct. */
+int fdma_db_add(struct fdma *fdma, int dcb_idx, int db_idx, u64 status)
+{
+	return __fdma_db_add(fdma,
+			     dcb_idx,
+			     db_idx,
+			     status,
+			     fdma->ops.dataptr_cb);
+}
+
+/* Add a DCB with callbacks for getting the DB dataptr and the DCB nextptr. */
+int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
+		   int (*dcb_cb)(struct fdma *fdma, int dcb_idx, u64 *nextptr),
+		   int (*db_cb)(struct fdma *fdma, int dcb_idx, int db_idx,
+				u64 *dataptr))
+{
+	struct fdma_dcb *dcb = fdma_dcb_get(fdma, dcb_idx);
+	int i, err;
+
+	for (i = 0; i < fdma->n_dbs; i++) {
+		err = __fdma_db_add(fdma, dcb_idx, i, status, db_cb);
+		if (unlikely(err))
+			return err;
+	}
+
+	err = dcb_cb(fdma, dcb_idx, &fdma->last_dcb->nextptr);
+	if (unlikely(err))
+		return err;
+
+	fdma->last_dcb = dcb;
+
+	dcb->nextptr = FDMA_DCB_INVALID_DATA;
+	dcb->info = info;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__fdma_dcb_add);
+
+/* Add a DCB, using the preset callbacks in the fdma_ops struct. */
+int fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status)
+{
+	return __fdma_dcb_add(fdma,
+			      dcb_idx,
+			      info, status,
+			      fdma->ops.nextptr_cb,
+			      fdma->ops.dataptr_cb);
+}
+EXPORT_SYMBOL_GPL(fdma_dcb_add);
+
+/* Initialize the DCB's and DB's. */
+int fdma_dcbs_init(struct fdma *fdma, u64 info, u64 status)
+{
+	int i, err;
+
+	fdma->last_dcb = fdma->dcbs;
+	fdma->db_index = 0;
+	fdma->dcb_index = 0;
+
+	for (i = 0; i < fdma->n_dcbs; i++) {
+		err = fdma_dcb_add(fdma, i, info, status);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fdma_dcbs_init);
+
+/* Allocate coherent DMA memory for FDMA. */
+int fdma_alloc_coherent(struct device *dev, struct fdma *fdma)
+{
+	fdma->dcbs = dma_alloc_coherent(dev,
+					fdma->size,
+					&fdma->dma,
+					GFP_KERNEL);
+	if (!fdma->dcbs)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fdma_alloc_coherent);
+
+/* Allocate physical memory for FDMA. */
+int fdma_alloc_phys(struct fdma *fdma)
+{
+	fdma->dcbs = kzalloc(fdma->size, GFP_KERNEL);
+	if (!fdma->dcbs)
+		return -ENOMEM;
+
+	fdma->dma = virt_to_phys(fdma->dcbs);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fdma_alloc_phys);
+
+/* Free coherent DMA memory. */
+void fdma_free_coherent(struct device *dev, struct fdma *fdma)
+{
+	dma_free_coherent(dev, fdma->size, fdma->dcbs, fdma->dma);
+}
+EXPORT_SYMBOL_GPL(fdma_free_coherent);
+
+/* Free virtual memory. */
+void fdma_free_phys(struct fdma *fdma)
+{
+	kfree(fdma->dcbs);
+}
+EXPORT_SYMBOL_GPL(fdma_free_phys);
+
+/* Get the size of the FDMA memory */
+u32 fdma_get_size(struct fdma *fdma)
+{
+	return ALIGN(sizeof(struct fdma_dcb) * fdma->n_dcbs, PAGE_SIZE);
+}
+EXPORT_SYMBOL_GPL(fdma_get_size);
+
+/* Get the size of the FDMA memory. This function is only applicable if the
+ * dataptr addresses and DCB's are in contiguous memory.
+ */
+u32 fdma_get_size_contiguous(struct fdma *fdma)
+{
+	return ALIGN(fdma->n_dcbs * sizeof(struct fdma_dcb) +
+		     fdma->n_dcbs * fdma->n_dbs * fdma->db_size,
+		     PAGE_SIZE);
+}
+EXPORT_SYMBOL_GPL(fdma_get_size_contiguous);
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.h b/drivers/net/ethernet/microchip/fdma/fdma_api.h
new file mode 100644
index 000000000000..d91affe8bd98
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.h
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _FDMA_API_H_
+#define _FDMA_API_H_
+
+#include <linux/bits.h>
+#include <linux/etherdevice.h>
+#include <linux/types.h>
+
+/* This provides a common set of functions and data structures for interacting
+ * with the Frame DMA engine on multiple Microchip switchcores.
+ *
+ * Frame DMA DCB format:
+ *
+ * +---------------------------+
+ * |         Next Ptr          |
+ * +---------------------------+
+ * |   Reserved  |    Info     |
+ * +---------------------------+
+ * |         Data0 Ptr         |
+ * +---------------------------+
+ * |   Reserved  |    Status0  |
+ * +---------------------------+
+ * |         Data1 Ptr         |
+ * +---------------------------+
+ * |   Reserved  |    Status1  |
+ * +---------------------------+
+ * |         Data2 Ptr         |
+ * +---------------------------+
+ * |   Reserved  |    Status2  |
+ * |-------------|-------------|
+ * |                           |
+ * |                           |
+ * |                           |
+ * |                           |
+ * |                           |
+ * |---------------------------|
+ * |         Data14 Ptr        |
+ * +-------------|-------------+
+ * |   Reserved  |    Status14 |
+ * +-------------|-------------+
+ *
+ * The data pointers points to the actual frame data to be received or sent. The
+ * addresses of the data pointers can, as of writing, be either a: DMA address,
+ * physical address or mapped address.
+ *
+ */
+
+#define FDMA_DCB_INFO_DATAL(x)		((x) & GENMASK(15, 0))
+#define FDMA_DCB_INFO_TOKEN		BIT(17)
+#define FDMA_DCB_INFO_INTR		BIT(18)
+#define FDMA_DCB_INFO_SW(x)		(((x) << 24) & GENMASK(31, 24))
+
+#define FDMA_DCB_STATUS_BLOCKL(x)	((x) & GENMASK(15, 0))
+#define FDMA_DCB_STATUS_SOF		BIT(16)
+#define FDMA_DCB_STATUS_EOF		BIT(17)
+#define FDMA_DCB_STATUS_INTR		BIT(18)
+#define FDMA_DCB_STATUS_DONE		BIT(19)
+#define FDMA_DCB_STATUS_BLOCKO(x)	(((x) << 20) & GENMASK(31, 20))
+#define FDMA_DCB_INVALID_DATA		0x1
+
+#define FDMA_DB_MAX			15 /* Max number of DB's on Sparx5 */
+
+struct fdma;
+
+struct fdma_db {
+	u64 dataptr;
+	u64 status;
+};
+
+struct fdma_dcb {
+	u64 nextptr;
+	u64 info;
+	struct fdma_db db[FDMA_DB_MAX];
+};
+
+struct fdma_ops {
+	/* User-provided callback to set the dataptr */
+	int (*dataptr_cb)(struct fdma *fdma, int dcb_idx, int db_idx, u64 *ptr);
+	/* User-provided callback to set the nextptr */
+	int (*nextptr_cb)(struct fdma *fdma, int dcb_idx, u64 *ptr);
+};
+
+struct fdma {
+	void *priv;
+
+	/* Virtual addresses */
+	struct fdma_dcb *dcbs;
+	struct fdma_dcb *last_dcb;
+
+	/* DMA address */
+	dma_addr_t dma;
+
+	/* Size of DCB + DB memory */
+	int size;
+
+	/* Indexes used to access the next-to-be-used DCB or DB */
+	int db_index;
+	int dcb_index;
+
+	/* Number of DCB's and DB's */
+	u32 n_dcbs;
+	u32 n_dbs;
+
+	/* Size of DB's */
+	u32 db_size;
+
+	/* Channel id this FDMA object operates on */
+	u32 channel_id;
+
+	struct fdma_ops ops;
+};
+
+/* Advance the DCB index and wrap if required. */
+static inline void fdma_dcb_advance(struct fdma *fdma)
+{
+	fdma->dcb_index++;
+	if (fdma->dcb_index >= fdma->n_dcbs)
+		fdma->dcb_index = 0;
+}
+
+/* Advance the DB index. */
+static inline void fdma_db_advance(struct fdma *fdma)
+{
+	fdma->db_index++;
+}
+
+/* Reset the db index to zero. */
+static inline void fdma_db_reset(struct fdma *fdma)
+{
+	fdma->db_index = 0;
+}
+
+/* Check if a DCB can be reused in case of multiple DB's per DCB. */
+static inline bool fdma_dcb_is_reusable(struct fdma *fdma)
+{
+	return fdma->db_index != fdma->n_dbs;
+}
+
+/* Check if the FDMA has marked this DB as done. */
+static inline bool fdma_db_is_done(struct fdma_db *db)
+{
+	return db->status & FDMA_DCB_STATUS_DONE;
+}
+
+/* Get the length of a DB. */
+static inline int fdma_db_len_get(struct fdma_db *db)
+{
+	return FDMA_DCB_STATUS_BLOCKL(db->status);
+}
+
+/* Set the length of a DB. */
+static inline void fdma_dcb_len_set(struct fdma_dcb *dcb, u32 len)
+{
+	dcb->info = FDMA_DCB_INFO_DATAL(len);
+}
+
+/* Get a DB by index. */
+static inline struct fdma_db *fdma_db_get(struct fdma *fdma, int dcb_idx,
+					  int db_idx)
+{
+	return &fdma->dcbs[dcb_idx].db[db_idx];
+}
+
+/* Get the next DB. */
+static inline struct fdma_db *fdma_db_next_get(struct fdma *fdma)
+{
+	return fdma_db_get(fdma, fdma->dcb_index, fdma->db_index);
+}
+
+/* Get a DCB by index. */
+static inline struct fdma_dcb *fdma_dcb_get(struct fdma *fdma, int dcb_idx)
+{
+	return &fdma->dcbs[dcb_idx];
+}
+
+/* Get the next DCB. */
+static inline struct fdma_dcb *fdma_dcb_next_get(struct fdma *fdma)
+{
+	return fdma_dcb_get(fdma, fdma->dcb_index);
+}
+
+/* Check if the FDMA has frames ready for extraction. */
+static inline bool fdma_has_frames(struct fdma *fdma)
+{
+	return fdma_db_is_done(fdma_db_next_get(fdma));
+}
+
+/* Get a nextptr by index */
+static inline int fdma_nextptr_cb(struct fdma *fdma, int dcb_idx, u64 *nextptr)
+{
+	*nextptr = fdma->dma + (sizeof(struct fdma_dcb) * dcb_idx);
+	return 0;
+}
+
+/* Get the DMA address of a dataptr, by index. This function is only applicable
+ * if the dataptr addresses and DCB's are in contiguous memory and the driver
+ * supports XDP.
+ */
+static inline u64 fdma_dataptr_get_contiguous(struct fdma *fdma, int dcb_idx,
+					      int db_idx)
+{
+	return fdma->dma + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
+	       (dcb_idx * fdma->n_dbs + db_idx) * fdma->db_size +
+	       XDP_PACKET_HEADROOM;
+}
+
+/* Get the virtual address of a dataptr, by index. This function is only
+ * applicable if the dataptr addresses and DCB's are in contiguous memory and
+ * the driver supports XDP.
+ */
+static inline void *fdma_dataptr_virt_get_contiguous(struct fdma *fdma,
+						     int dcb_idx, int db_idx)
+{
+	return (u8 *)fdma->dcbs + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
+	       (dcb_idx * fdma->n_dbs + db_idx) * fdma->db_size +
+	       XDP_PACKET_HEADROOM;
+}
+
+/* Check if this DCB is the last used DCB. */
+static inline bool fdma_is_last(struct fdma *fdma, struct fdma_dcb *dcb)
+{
+	return dcb == fdma->last_dcb;
+}
+
+int fdma_dcbs_init(struct fdma *fdma, u64 info, u64 status);
+int fdma_db_add(struct fdma *fdma, int dcb_idx, int db_idx, u64 status);
+int fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status);
+int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
+		   int (*dcb_cb)(struct fdma *fdma, int dcb_idx, u64 *nextptr),
+		   int (*db_cb)(struct fdma *fdma, int dcb_idx, int db_idx,
+				u64 *dataptr));
+
+int fdma_alloc_coherent(struct device *dev, struct fdma *fdma);
+int fdma_alloc_phys(struct fdma *fdma);
+
+void fdma_free_coherent(struct device *dev, struct fdma *fdma);
+void fdma_free_phys(struct fdma *fdma);
+
+u32 fdma_get_size(struct fdma *fdma);
+u32 fdma_get_size_contiguous(struct fdma *fdma);
+
+#endif
diff --git a/drivers/net/ethernet/microchip/sparx5/Kconfig b/drivers/net/ethernet/microchip/sparx5/Kconfig
index f58c506bda22..3f04992eace6 100644
--- a/drivers/net/ethernet/microchip/sparx5/Kconfig
+++ b/drivers/net/ethernet/microchip/sparx5/Kconfig
@@ -10,6 +10,7 @@ config SPARX5_SWITCH
 	select PHY_SPARX5_SERDES
 	select RESET_CONTROLLER
 	select VCAP
+	select FDMA
 	help
 	  This driver supports the Sparx5 network switch device.
 

-- 
2.34.1


