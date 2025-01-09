Return-Path: <netdev+bounces-156851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA8A07FFA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39CD188B4EE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D831ACEC9;
	Thu,  9 Jan 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kV6/MMtv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1611ACEAE;
	Thu,  9 Jan 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447943; cv=none; b=h4xQMd1l8WuL5Pz2RQt3aQJi/8b1aZWxAEUeDn5XEJScRYixvwRo8l9OzdYT3tqK+QWNDNUmd91n8SbtJ2lAGkaPC9zA5svAZFhIwCH1GfQ2muGT+WyOc0mueS+GR6RpBd1QEa9xqrPjk3xbyKQI6wRqz71sZBhO5u91+tl3qM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447943; c=relaxed/simple;
	bh=hb+pIfxLqWR5ZmBxPYruVZjC/cnYstJRtQm8eMUCPTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tsXZlMNiLIcoys1uEvv96IquQd8th+XvmqU66l4n0LaDPwLvnHw/E2bncUuDCjyS4HHJAdIk3bekakAT3epxpe6qvyF1bbeSF+r2WpGnPEP/suPR1ouLWdClmm7Av8b4umbvlWPndQzTMkJm2HDHzu/uv8VvpDQyIKU+492i1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kV6/MMtv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736447941; x=1767983941;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hb+pIfxLqWR5ZmBxPYruVZjC/cnYstJRtQm8eMUCPTs=;
  b=kV6/MMtvnjVa89mlbYD88kfgwKmi67u7aZkRGlwUI2KZFjup2bQs7JLF
   LL/BJXrIlOVyp6mMUWhHKpMtr71LrPCRieqcBEGV+FGtxi8pvwCTVgpMh
   iqdstE4+F4JM8L/ZnABzMRdZW0PAAqVV3KpT4Mgmg3NgxJ6XQ1+WScHHV
   EiRTKQcsQ5+gYc7h3Rtamqqy72kOTO1RJifOpc7jnTlvwzE4yti8/PFCS
   OcbCmI3HjDSDKD8G1XB/I/wTF2olS1ryPaoOj9f6esUtGjmsxj76E+/Py
   DoF3B9M01nrzMDEzLBRAm050gN4aIaEtvEm1YopsEPDdsRZ5995dNhIIX
   A==;
X-CSE-ConnectionGUID: 9qQcIadkSziBmk+kwO7anA==
X-CSE-MsgGUID: SSXpPqSxRxSqH1YPw5VZ9Q==
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36007588"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 11:39:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 11:38:24 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 11:38:22 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 9 Jan 2025 19:37:58 +0100
Subject: [PATCH net-next 6/6] net: lan969x: add FDMA implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-sparx5-lan969x-switch-driver-5-v1-6-13d6d8451e63@microchip.com>
References: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
In-Reply-To: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The lan969x switch device supports manual frame injection and extraction
to and from the switch core, using a number of injection and extraction
queues.  This technique is currently supported, but delivers poor
performance compared to Frame DMA (FDMA).

This lan969x implementation of FDMA, hooks into the existing FDMA for
Sparx5, but requires its own RX and TX handling, as lan969x does not
support the same native cache coherency that Sparx5 does. Effectively,
this means that we are going to use the DMA mapping API for mapping and
unmapping TX buffers. The RX loop will utilize the page pool API for
efficient RX handling. Other than that, the implementation is largely
the same, and utilizes the FDMA library for DCB and DB handling.

Some numbers:

Manual injection/extraction (before this series):

// iperf3 -c 1.0.1.1

[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.02  sec   345 MBytes   289 Mbits/sec  sender
[  5]   0.00-10.06  sec   345 MBytes   288 Mbits/sec  receiver

FDMA (after this series):

// iperf3 -c 1.0.1.1

[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.03  sec  1.10 GBytes   940 Mbits/sec  sender
[  5]   0.00-10.07  sec  1.10 GBytes   936 Mbits/sec  receiver

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Kconfig      |   1 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   4 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |   6 +
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 408 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   7 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  21 +-
 7 files changed, 443 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Kconfig b/drivers/net/ethernet/microchip/sparx5/Kconfig
index 35b057c9d0cb..35e1c0cf345e 100644
--- a/drivers/net/ethernet/microchip/sparx5/Kconfig
+++ b/drivers/net/ethernet/microchip/sparx5/Kconfig
@@ -28,5 +28,6 @@ config SPARX5_DCB
 config LAN969X_SWITCH
 	bool "Lan969x switch driver"
 	depends on SPARX5_SWITCH
+	select PAGE_POOL
 	help
 	  This driver supports the lan969x family of network switch devices.
diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index 3f34e83246a0..d447f9e84d92 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -21,7 +21,8 @@ sparx5-switch-$(CONFIG_LAN969X_SWITCH) += lan969x/lan969x_regs.o \
 					  lan969x/lan969x_calendar.o \
 					  lan969x/lan969x_vcap_ag_api.o \
 					  lan969x/lan969x_vcap_impl.o \
-					  lan969x/lan969x_rgmii.o
+					  lan969x/lan969x_rgmii.o \
+					  lan969x/lan969x_fdma.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index 396f76b6eea5..f3a9c71bea36 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -341,6 +341,10 @@ static const struct sparx5_ops lan969x_ops = {
 	.ptp_irq_handler         = &lan969x_ptp_irq_handler,
 	.dsm_calendar_calc       = &lan969x_dsm_calendar_calc,
 	.port_config_rgmii       = &lan969x_port_config_rgmii,
+	.fdma_init               = &lan969x_fdma_init,
+	.fdma_deinit             = &lan969x_fdma_deinit,
+	.fdma_poll               = &lan969x_fdma_napi_poll,
+	.fdma_xmit               = &lan969x_fdma_xmit,
 };
 
 const struct sparx5_match_data lan969x_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
index 9a7ddebecf1e..a4c511a30c2a 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
@@ -72,4 +72,10 @@ int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 int lan969x_port_config_rgmii(struct sparx5_port *port,
 			      struct sparx5_port_config *conf);
 
+/* lan969x_fdma.c */
+int lan969x_fdma_init(struct sparx5 *sparx5);
+int lan969x_fdma_deinit(struct sparx5 *sparx5);
+int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight);
+int lan969x_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb);
+
 #endif
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
new file mode 100644
index 000000000000..4b5d1889214f
--- /dev/null
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip lan969x Switch driver
+ *
+ * Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries.
+ */
+#include <net/page_pool/helpers.h>
+
+#include "../sparx5_main.h"
+#include "../sparx5_main_regs.h"
+#include "../sparx5_port.h"
+
+#include "fdma_api.h"
+#include "lan969x.h"
+
+#define FDMA_PRIV(fdma) ((struct sparx5 *)((fdma)->priv))
+
+static int lan969x_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				      u64 *dataptr)
+{
+	*dataptr = FDMA_PRIV(fdma)->tx.dbs[dcb].dma_addr;
+
+	return 0;
+}
+
+static int lan969x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				      u64 *dataptr)
+{
+	struct sparx5_rx *rx = &FDMA_PRIV(fdma)->rx;
+	struct page *page;
+
+	page = page_pool_dev_alloc_pages(rx->page_pool);
+	if (unlikely(!page))
+		return -ENOMEM;
+
+	rx->page[dcb][db] = page;
+
+	*dataptr = page_pool_get_dma_addr(page);
+
+	return 0;
+}
+
+static int lan969x_fdma_get_next_dcb(struct sparx5_tx *tx)
+{
+	struct fdma *fdma = &tx->fdma;
+
+	for (int i = 0; i < fdma->n_dcbs; ++i)
+		if (!tx->dbs[i].used && !fdma_is_last(fdma, &fdma->dcbs[i]))
+			return i;
+
+	return -ENOSPC;
+}
+
+static void lan969x_fdma_tx_clear_buf(struct sparx5 *sparx5, int weight)
+{
+	struct fdma *fdma = &sparx5->tx.fdma;
+	struct sparx5_tx_buf *db;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&sparx5->tx_lock, flags);
+
+	for (i = 0; i < fdma->n_dcbs; ++i) {
+		db = &sparx5->tx.dbs[i];
+
+		if (!db->used)
+			continue;
+
+		if (!fdma_db_is_done(fdma_db_get(fdma, i, 0)))
+			continue;
+
+		dma_unmap_single(sparx5->dev,
+				 db->dma_addr,
+				 db->len,
+				 DMA_TO_DEVICE);
+
+		if (!db->ptp)
+			napi_consume_skb(db->skb, weight);
+
+		db->used = false;
+	}
+
+	spin_unlock_irqrestore(&sparx5->tx_lock, flags);
+}
+
+static void lan969x_fdma_free_pages(struct sparx5_rx *rx)
+{
+	struct fdma *fdma = &rx->fdma;
+
+	for (int i = 0; i < fdma->n_dcbs; ++i) {
+		for (int j = 0; j < fdma->n_dbs; ++j)
+			page_pool_put_full_page(rx->page_pool,
+						rx->page[i][j], false);
+	}
+}
+
+static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
+						 struct sparx5_rx *rx)
+{
+	const struct sparx5_consts *consts = sparx5->data->consts;
+	struct fdma *fdma = &rx->fdma;
+	struct sparx5_port *port;
+	struct frame_info fi;
+	struct sk_buff *skb;
+	struct fdma_db *db;
+	struct page *page;
+
+	/* Get the received frame and unmap it */
+	db = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
+	page = rx->page[fdma->dcb_index][fdma->db_index];
+
+	skb = build_skb(page_address(page), fdma->db_size);
+	if (unlikely(!skb))
+		goto free_page;
+
+	skb_mark_for_recycle(skb);
+	skb_put(skb, fdma_db_len_get(db));
+
+	sparx5_ifh_parse(sparx5, (u32 *)skb->data, &fi);
+
+	port = fi.src_port < consts->n_ports ? sparx5->ports[fi.src_port] :
+					       NULL;
+
+	if (WARN_ON(!port))
+		goto free_skb;
+
+	skb->dev = port->ndev;
+	skb_pull(skb, IFH_LEN * sizeof(u32));
+
+	if (likely(!(skb->dev->features & NETIF_F_RXFCS)))
+		skb_trim(skb, skb->len - ETH_FCS_LEN);
+
+	sparx5_ptp_rxtstamp(sparx5, skb, fi.timestamp);
+	skb->protocol = eth_type_trans(skb, skb->dev);
+
+	if (test_bit(port->portno, sparx5->bridge_mask))
+		skb->offload_fwd_mark = 1;
+
+	skb->dev->stats.rx_bytes += skb->len;
+	skb->dev->stats.rx_packets++;
+
+	return skb;
+
+free_skb:
+	kfree_skb(skb);
+free_page:
+	page_pool_recycle_direct(rx->page_pool, page);
+
+	return NULL;
+}
+
+static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+	struct fdma *fdma = &rx->fdma;
+	int err;
+
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = fdma->n_dcbs * fdma->n_dbs,
+		.nid = NUMA_NO_NODE,
+		.dev = sparx5->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = fdma->db_size -
+			   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+	};
+
+	rx->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(rx->page_pool))
+		return PTR_ERR(rx->page_pool);
+
+	err = fdma_alloc_coherent(sparx5->dev, fdma);
+	if (err)
+		return err;
+
+	fdma_dcbs_init(fdma,
+		       FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_INTR);
+
+	return 0;
+}
+
+static int lan969x_fdma_tx_alloc(struct sparx5 *sparx5)
+{
+	struct sparx5_tx *tx = &sparx5->tx;
+	struct fdma *fdma = &tx->fdma;
+	int err;
+
+	tx->dbs = kcalloc(fdma->n_dcbs,
+			  sizeof(struct sparx5_tx_buf),
+			  GFP_KERNEL);
+	if (!tx->dbs)
+		return -ENOMEM;
+
+	err = fdma_alloc_coherent(sparx5->dev, fdma);
+	if (err) {
+		kfree(tx->dbs);
+		return err;
+	}
+
+	fdma_dcbs_init(fdma,
+		       FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_DONE);
+
+	return 0;
+}
+
+static void lan969x_fdma_rx_init(struct sparx5 *sparx5)
+{
+	struct fdma *fdma = &sparx5->rx.fdma;
+
+	fdma->channel_id = FDMA_XTR_CHANNEL;
+	fdma->n_dcbs = FDMA_DCB_MAX;
+	fdma->n_dbs = 1;
+	fdma->priv = sparx5;
+	fdma->size = fdma_get_size(fdma);
+	fdma->db_size = PAGE_SIZE;
+	fdma->ops.dataptr_cb = &lan969x_fdma_rx_dataptr_cb;
+	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
+
+	/* Fetch a netdev for SKB and NAPI use, any will do */
+	for (int idx = 0; idx < sparx5->data->consts->n_ports; ++idx) {
+		struct sparx5_port *port = sparx5->ports[idx];
+
+		if (port && port->ndev) {
+			sparx5->rx.ndev = port->ndev;
+			break;
+		}
+	}
+}
+
+static void lan969x_fdma_tx_init(struct sparx5 *sparx5)
+{
+	struct fdma *fdma = &sparx5->tx.fdma;
+
+	fdma->channel_id = FDMA_INJ_CHANNEL;
+	fdma->n_dcbs = FDMA_DCB_MAX;
+	fdma->n_dbs = 1;
+	fdma->priv = sparx5;
+	fdma->size = fdma_get_size(fdma);
+	fdma->db_size = PAGE_SIZE;
+	fdma->ops.dataptr_cb = &lan969x_fdma_tx_dataptr_cb;
+	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
+}
+
+int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight)
+{
+	struct sparx5_rx *rx = container_of(napi, struct sparx5_rx, napi);
+	struct sparx5 *sparx5 = container_of(rx, struct sparx5, rx);
+	int old_dcb, dcb_reload, counter = 0;
+	struct fdma *fdma = &rx->fdma;
+	struct sk_buff *skb;
+
+	dcb_reload = fdma->dcb_index;
+
+	lan969x_fdma_tx_clear_buf(sparx5, weight);
+
+	dcb_reload = fdma->dcb_index;
+
+	/* Process rx data */
+	while (counter < weight) {
+		if (!fdma_has_frames(fdma))
+			break;
+
+		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
+		if (!skb)
+			break;
+
+		napi_gro_receive(&rx->napi, skb);
+
+		fdma_db_advance(fdma);
+		counter++;
+		/* Check if the DCB can be reused */
+		if (fdma_dcb_is_reusable(fdma))
+			continue;
+
+		fdma_db_reset(fdma);
+		fdma_dcb_advance(fdma);
+	}
+
+	/* Allocate new pages and map them */
+	while (dcb_reload != fdma->dcb_index) {
+		old_dcb = dcb_reload;
+		dcb_reload++;
+		 /* n_dcbs must be a power of 2 */
+		dcb_reload &= fdma->n_dcbs - 1;
+
+		fdma_dcb_add(fdma,
+			     old_dcb,
+			     FDMA_DCB_INFO_DATAL(fdma->db_size),
+			     FDMA_DCB_STATUS_INTR);
+
+		sparx5_fdma_reload(sparx5, fdma);
+	}
+
+	if (counter < weight && napi_complete_done(napi, counter))
+		spx5_wr(0xff, sparx5, FDMA_INTR_DB_ENA);
+
+	return counter;
+}
+
+int lan969x_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
+{
+	int next_dcb, needed_headroom, needed_tailroom, err;
+	struct sparx5_tx *tx = &sparx5->tx;
+	struct fdma *fdma = &tx->fdma;
+	struct sparx5_tx_buf *db_buf;
+	u64 status;
+
+	next_dcb = lan969x_fdma_get_next_dcb(tx);
+	if (next_dcb < 0)
+		return -EBUSY;
+
+	needed_headroom = max_t(int, IFH_LEN * 4 - skb_headroom(skb), 0);
+	needed_tailroom = max_t(int, ETH_FCS_LEN - skb_tailroom(skb), 0);
+	if (needed_headroom || needed_tailroom || skb_header_cloned(skb)) {
+		err = pskb_expand_head(skb, needed_headroom, needed_tailroom,
+				       GFP_ATOMIC);
+		if (unlikely(err))
+			return err;
+	}
+
+	skb_push(skb, IFH_LEN * 4);
+	memcpy(skb->data, ifh, IFH_LEN * 4);
+	skb_put(skb, ETH_FCS_LEN);
+
+	db_buf = &tx->dbs[next_dcb];
+	db_buf->len = skb->len;
+	db_buf->used = true;
+	db_buf->skb = skb;
+	db_buf->ptp = false;
+
+	db_buf->dma_addr = dma_map_single(sparx5->dev,
+					  skb->data,
+					  skb->len,
+					  DMA_TO_DEVICE);
+	if (dma_mapping_error(sparx5->dev, db_buf->dma_addr))
+		return -ENOMEM;
+
+	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
+	    SPARX5_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
+		db_buf->ptp = true;
+
+	status = FDMA_DCB_STATUS_SOF |
+		 FDMA_DCB_STATUS_EOF |
+		 FDMA_DCB_STATUS_BLOCKO(0) |
+		 FDMA_DCB_STATUS_BLOCKL(skb->len) |
+		 FDMA_DCB_STATUS_INTR;
+
+	fdma_dcb_advance(fdma);
+	fdma_dcb_add(fdma, next_dcb, 0, status);
+
+	sparx5_fdma_reload(sparx5, fdma);
+
+	return NETDEV_TX_OK;
+}
+
+int lan969x_fdma_init(struct sparx5 *sparx5)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+	int err;
+
+	lan969x_fdma_rx_init(sparx5);
+	lan969x_fdma_tx_init(sparx5);
+	sparx5_fdma_injection_mode(sparx5);
+
+	err = dma_set_mask_and_coherent(sparx5->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(sparx5->dev, "Failed to set 64-bit FDMA mask");
+		return err;
+	}
+
+	err = lan969x_fdma_rx_alloc(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to allocate RX buffers: %d\n",
+			err);
+		return err;
+	}
+
+	err = lan969x_fdma_tx_alloc(sparx5);
+	if (err) {
+		fdma_free_coherent(sparx5->dev, &rx->fdma);
+		dev_err(sparx5->dev, "Failed to allocate TX buffers: %d\n",
+			err);
+		return err;
+	}
+
+	/* Reset FDMA state */
+	spx5_wr(FDMA_CTRL_NRESET_SET(0), sparx5, FDMA_CTRL);
+	spx5_wr(FDMA_CTRL_NRESET_SET(1), sparx5, FDMA_CTRL);
+
+	return err;
+}
+
+int lan969x_fdma_deinit(struct sparx5 *sparx5)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+	struct sparx5_tx *tx = &sparx5->tx;
+
+	sparx5_fdma_stop(sparx5);
+	fdma_free_coherent(sparx5->dev, &tx->fdma);
+	fdma_free_coherent(sparx5->dev, &rx->fdma);
+	lan969x_fdma_free_pages(rx);
+	page_pool_destroy(rx->page_pool);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 49f5af1eab94..822dfe55efb3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -18,9 +18,6 @@
 #include "sparx5_main.h"
 #include "sparx5_port.h"
 
-#define FDMA_XTR_CHANNEL		6
-#define FDMA_INJ_CHANNEL		0
-
 #define FDMA_XTR_BUFFER_SIZE		2048
 #define FDMA_WEIGHT			4
 
@@ -133,7 +130,7 @@ static void sparx5_fdma_tx_deactivate(struct sparx5 *sparx5, struct sparx5_tx *t
 		 sparx5, FDMA_CH_ACTIVATE);
 }
 
-static void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma)
+void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma)
 {
 	/* Reload the RX channel */
 	spx5_wr(BIT(fdma->channel_id), sparx5, FDMA_CH_RELOAD);
@@ -341,7 +338,7 @@ irqreturn_t sparx5_fdma_handler(int irq, void *args)
 	return IRQ_HANDLED;
 }
 
-static void sparx5_fdma_injection_mode(struct sparx5 *sparx5)
+void sparx5_fdma_injection_mode(struct sparx5 *sparx5)
 {
 	const int byte_swap = 1;
 	int portno;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 35706e9a27c8..69125df85f52 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -112,6 +112,8 @@ enum sparx5_feature {
 #define XTR_QUEUE     0
 #define INJ_QUEUE     0
 
+#define FDMA_XTR_CHANNEL		6
+#define FDMA_INJ_CHANNEL		0
 #define FDMA_DCB_MAX			64
 #define FDMA_RX_DCB_MAX_DBS		15
 #define FDMA_TX_DCB_MAX_DBS		1
@@ -157,11 +159,25 @@ struct sparx5_calendar_data {
  */
 struct sparx5_rx {
 	struct fdma fdma;
-	struct sk_buff *skb[FDMA_DCB_MAX][FDMA_RX_DCB_MAX_DBS];
+	struct page_pool *page_pool;
+	union {
+		struct sk_buff *skb[FDMA_DCB_MAX][FDMA_RX_DCB_MAX_DBS];
+		struct page *page[FDMA_DCB_MAX][FDMA_RX_DCB_MAX_DBS];
+	};
 	dma_addr_t dma;
 	struct napi_struct napi;
 	struct net_device *ndev;
 	u64 packets;
+	u8 page_order;
+};
+
+/* Used to store information about TX buffers. */
+struct sparx5_tx_buf {
+	struct sk_buff *skb;
+	dma_addr_t dma_addr;
+	bool used;
+	bool ptp;
+	int len;
 };
 
 /* Frame DMA transmit state:
@@ -169,6 +185,7 @@ struct sparx5_rx {
  */
 struct sparx5_tx {
 	struct fdma fdma;
+	struct sparx5_tx_buf *dbs;
 	u64 packets;
 	u64 dropped;
 };
@@ -447,6 +464,8 @@ int sparx5_fdma_stop(struct sparx5 *sparx5);
 int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight);
 int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb);
 irqreturn_t sparx5_fdma_handler(int irq, void *args);
+void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma);
+void sparx5_fdma_injection_mode(struct sparx5 *sparx5);
 
 /* sparx5_mactable.c */
 void sparx5_mact_pull_work(struct work_struct *work);

-- 
2.34.1


