Return-Path: <netdev+bounces-124238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63AB968A6D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E71F22958
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258941AB6CE;
	Mon,  2 Sep 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nakcoOUr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8F1A303B;
	Mon,  2 Sep 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288913; cv=none; b=c86TZm7thckl28bb7VyZdKH/fAoSwcvXuCAV3czIOnUmU2itu0UdA2NiUkO8j+wpat7sYDu/4Ej5JSPZqwZ+Z9Qe/fzTssLx7SlUNBeqkVZzfPjHkt5LCNhhP10p3ah2BUHSEK61gWwVsB7skzy5MdUetBsrvALupwZb2IAcEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288913; c=relaxed/simple;
	bh=SnbxsRd8KzRVOAugBrmuhFoO/e/dsflVvDqnpcSmtpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZvOKUeiqt9r3L25ChemB/m7xAJeQ2JzmP4chRJp0LJ6RVhn6asuqu/dvUYL3Bs0tKu+iLU9gOUVEO2ec5A3SEwm/H8NwCYAhKh+4JsD1jvuB+liLvMbDNEHQ0gPdA1Vgl0MaNkmuN+kGA5/wkKK+nctY2FXFqG2tz36GSUrlNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nakcoOUr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288911; x=1756824911;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SnbxsRd8KzRVOAugBrmuhFoO/e/dsflVvDqnpcSmtpw=;
  b=nakcoOUr5+PIf+rGxZkF14efIwf+Yr4tnpWb7VeMfpwPdIAKT8tu2YMY
   BpZObPQ+bpwLm5IepzmwWuXvfAWOo+GsqhZsWZAoriZXxnFSQ9VCGR0g/
   XkX8Gn2NzTmYiRGzVWuy2OKVEe9h+t8Msh0Zp/DJs4ePvYkQ5409Xalb/
   lweLLowSxZmk26SYuDeFxV9dDnsSBVwYXSDJyOkF3m+ZgqPzNm0t1Qmr3
   ljJofJbtpiCH5xeFMbIp4ms3Iq4xYnKji8LXNOJRJM32kekFnCvuemE0I
   PwtM1UprbemMuS19gmA003/zAxnawgbNTjmZi3Rd0Zv7tMQQGP7QgKpDX
   A==;
X-CSE-ConnectionGUID: /Vcaqev1TP+OZLTGnI90pA==
X-CSE-MsgGUID: JVUjPa14R4+kpOd9o7IGxg==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34271106"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:44 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:42 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:08 +0200
Subject: [PATCH net-next 03/12] net: sparx5: replace a few variables with
 new equivalent ones
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-3-1e7d5e5a9f34@microchip.com>
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

Replace the old rx and tx variables: channel_id, FDMA_DCB_MAX,
FDMA_RX_DCB_MAX_DBS, FDMA_TX_DCB_MAX_DBS, dcb_index and db_index with
the equivalents from the FDMA rx and tx structs. These variables are not
entangled in any buffer allocation and can therefore be replaced in
advance.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 103 ++++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   6 +-
 2 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index e7acf4ef291f..5e058dbc734e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -36,10 +36,11 @@ static void sparx5_fdma_rx_add_dcb(struct sparx5_rx *rx,
 				   struct sparx5_rx_dcb_hw *dcb,
 				   u64 nextptr)
 {
+	struct fdma *fdma = &rx->fdma;
 	int idx = 0;
 
 	/* Reset the status of the DB */
-	for (idx = 0; idx < FDMA_RX_DCB_MAX_DBS; ++idx) {
+	for (idx = 0; idx < fdma->n_dbs; ++idx) {
 		struct sparx5_db_hw *db = &dcb->db[idx];
 
 		db->status = FDMA_DCB_STATUS_INTR;
@@ -57,7 +58,7 @@ static void sparx5_fdma_tx_add_dcb(struct sparx5_tx *tx,
 	int idx = 0;
 
 	/* Reset the status of the DB */
-	for (idx = 0; idx < FDMA_TX_DCB_MAX_DBS; ++idx) {
+	for (idx = 0; idx < tx->fdma.n_dbs; ++idx) {
 		struct sparx5_db_hw *db = &dcb->db[idx];
 
 		db->status = FDMA_DCB_STATUS_DONE;
@@ -68,16 +69,18 @@ static void sparx5_fdma_tx_add_dcb(struct sparx5_tx *tx,
 
 static void sparx5_fdma_rx_activate(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
+	struct fdma *fdma = &rx->fdma;
+
 	/* Write the buffer address in the LLP and LLP1 regs */
 	spx5_wr(((u64)rx->dma) & GENMASK(31, 0), sparx5,
-		FDMA_DCB_LLP(rx->channel_id));
-	spx5_wr(((u64)rx->dma) >> 32, sparx5, FDMA_DCB_LLP1(rx->channel_id));
+		FDMA_DCB_LLP(fdma->channel_id));
+	spx5_wr(((u64)rx->dma) >> 32, sparx5, FDMA_DCB_LLP1(fdma->channel_id));
 
 	/* Set the number of RX DBs to be used, and DB end-of-frame interrupt */
-	spx5_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(FDMA_RX_DCB_MAX_DBS) |
+	spx5_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 		FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 		FDMA_CH_CFG_CH_INJ_PORT_SET(XTR_QUEUE),
-		sparx5, FDMA_CH_CFG(rx->channel_id));
+		sparx5, FDMA_CH_CFG(fdma->channel_id));
 
 	/* Set the RX Watermark to max */
 	spx5_rmw(FDMA_XTR_CFG_XTR_FIFO_WM_SET(31), FDMA_XTR_CFG_XTR_FIFO_WM,
@@ -89,22 +92,24 @@ static void sparx5_fdma_rx_activate(struct sparx5 *sparx5, struct sparx5_rx *rx)
 		 sparx5, FDMA_PORT_CTRL(0));
 
 	/* Enable RX channel DB interrupt */
-	spx5_rmw(BIT(rx->channel_id),
-		 BIT(rx->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
+	spx5_rmw(BIT(fdma->channel_id),
+		 BIT(fdma->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
 		 sparx5, FDMA_INTR_DB_ENA);
 
 	/* Activate the RX channel */
-	spx5_wr(BIT(rx->channel_id), sparx5, FDMA_CH_ACTIVATE);
+	spx5_wr(BIT(fdma->channel_id), sparx5, FDMA_CH_ACTIVATE);
 }
 
 static void sparx5_fdma_rx_deactivate(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
+	struct fdma *fdma = &rx->fdma;
+
 	/* Deactivate the RX channel */
-	spx5_rmw(0, BIT(rx->channel_id) & FDMA_CH_ACTIVATE_CH_ACTIVATE,
+	spx5_rmw(0, BIT(fdma->channel_id) & FDMA_CH_ACTIVATE_CH_ACTIVATE,
 		 sparx5, FDMA_CH_ACTIVATE);
 
 	/* Disable RX channel DB interrupt */
-	spx5_rmw(0, BIT(rx->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
+	spx5_rmw(0, BIT(fdma->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
 		 sparx5, FDMA_INTR_DB_ENA);
 
 	/* Stop RX fdma */
@@ -114,42 +119,44 @@ static void sparx5_fdma_rx_deactivate(struct sparx5 *sparx5, struct sparx5_rx *r
 
 static void sparx5_fdma_tx_activate(struct sparx5 *sparx5, struct sparx5_tx *tx)
 {
+	struct fdma *fdma = &tx->fdma;
+
 	/* Write the buffer address in the LLP and LLP1 regs */
 	spx5_wr(((u64)tx->dma) & GENMASK(31, 0), sparx5,
-		FDMA_DCB_LLP(tx->channel_id));
-	spx5_wr(((u64)tx->dma) >> 32, sparx5, FDMA_DCB_LLP1(tx->channel_id));
+		FDMA_DCB_LLP(fdma->channel_id));
+	spx5_wr(((u64)tx->dma) >> 32, sparx5, FDMA_DCB_LLP1(fdma->channel_id));
 
 	/* Set the number of TX DBs to be used, and DB end-of-frame interrupt */
-	spx5_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(FDMA_TX_DCB_MAX_DBS) |
+	spx5_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 		FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 		FDMA_CH_CFG_CH_INJ_PORT_SET(INJ_QUEUE),
-		sparx5, FDMA_CH_CFG(tx->channel_id));
+		sparx5, FDMA_CH_CFG(fdma->channel_id));
 
 	/* Start TX fdma */
 	spx5_rmw(FDMA_PORT_CTRL_INJ_STOP_SET(0), FDMA_PORT_CTRL_INJ_STOP,
 		 sparx5, FDMA_PORT_CTRL(0));
 
 	/* Activate the channel */
-	spx5_wr(BIT(tx->channel_id), sparx5, FDMA_CH_ACTIVATE);
+	spx5_wr(BIT(fdma->channel_id), sparx5, FDMA_CH_ACTIVATE);
 }
 
 static void sparx5_fdma_tx_deactivate(struct sparx5 *sparx5, struct sparx5_tx *tx)
 {
 	/* Disable the channel */
-	spx5_rmw(0, BIT(tx->channel_id) & FDMA_CH_ACTIVATE_CH_ACTIVATE,
+	spx5_rmw(0, BIT(tx->fdma.channel_id) & FDMA_CH_ACTIVATE_CH_ACTIVATE,
 		 sparx5, FDMA_CH_ACTIVATE);
 }
 
 static void sparx5_fdma_rx_reload(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
 	/* Reload the RX channel */
-	spx5_wr(BIT(rx->channel_id), sparx5, FDMA_CH_RELOAD);
+	spx5_wr(BIT(rx->fdma.channel_id), sparx5, FDMA_CH_RELOAD);
 }
 
 static void sparx5_fdma_tx_reload(struct sparx5 *sparx5, struct sparx5_tx *tx)
 {
 	/* Reload the TX channel */
-	spx5_wr(BIT(tx->channel_id), sparx5, FDMA_CH_RELOAD);
+	spx5_wr(BIT(tx->fdma.channel_id), sparx5, FDMA_CH_RELOAD);
 }
 
 static struct sk_buff *sparx5_fdma_rx_alloc_skb(struct sparx5_rx *rx)
@@ -160,6 +167,7 @@ static struct sk_buff *sparx5_fdma_rx_alloc_skb(struct sparx5_rx *rx)
 
 static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
+	struct fdma *fdma = &rx->fdma;
 	struct sparx5_db_hw *db_hw;
 	unsigned int packet_size;
 	struct sparx5_port *port;
@@ -169,17 +177,17 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 	dma_addr_t dma_addr;
 
 	/* Check if the DCB is done */
-	db_hw = &rx->dcb_entries[rx->dcb_index].db[rx->db_index];
+	db_hw = &rx->dcb_entries[fdma->dcb_index].db[fdma->db_index];
 	if (unlikely(!(db_hw->status & FDMA_DCB_STATUS_DONE)))
 		return false;
-	skb = rx->skb[rx->dcb_index][rx->db_index];
+	skb = rx->skb[fdma->dcb_index][fdma->db_index];
 	/* Replace the DB entry with a new SKB */
 	new_skb = sparx5_fdma_rx_alloc_skb(rx);
 	if (unlikely(!new_skb))
 		return false;
 	/* Map the new skb data and set the new skb */
 	dma_addr = virt_to_phys(new_skb->data);
-	rx->skb[rx->dcb_index][rx->db_index] = new_skb;
+	rx->skb[fdma->dcb_index][fdma->db_index] = new_skb;
 	db_hw->dataptr = dma_addr;
 	packet_size = FDMA_DCB_STATUS_BLOCKL(db_hw->status);
 	skb_put(skb, packet_size);
@@ -215,23 +223,24 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 {
 	struct sparx5_rx *rx = container_of(napi, struct sparx5_rx, napi);
 	struct sparx5 *sparx5 = container_of(rx, struct sparx5, rx);
+	struct fdma *fdma = &rx->fdma;
 	int counter = 0;
 
 	while (counter < weight && sparx5_fdma_rx_get_frame(sparx5, rx)) {
 		struct sparx5_rx_dcb_hw *old_dcb;
 
-		rx->db_index++;
+		fdma->db_index++;
 		counter++;
 		/* Check if the DCB can be reused */
-		if (rx->db_index != FDMA_RX_DCB_MAX_DBS)
+		if (fdma->db_index != fdma->n_dbs)
 			continue;
 		/* As the DCB  can be reused, just advance the dcb_index
 		 * pointer and set the nextptr in the DCB
 		 */
-		rx->db_index = 0;
-		old_dcb = &rx->dcb_entries[rx->dcb_index];
-		rx->dcb_index++;
-		rx->dcb_index &= FDMA_DCB_MAX - 1;
+		fdma->db_index = 0;
+		old_dcb = &rx->dcb_entries[fdma->dcb_index];
+		fdma->dcb_index++;
+		fdma->dcb_index &= fdma->n_dcbs - 1;
 		sparx5_fdma_rx_add_dcb(rx, old_dcb,
 				       rx->dma +
 				       ((unsigned long)old_dcb -
@@ -239,8 +248,8 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 	}
 	if (counter < weight) {
 		napi_complete_done(&rx->napi, counter);
-		spx5_rmw(BIT(rx->channel_id),
-			 BIT(rx->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
+		spx5_rmw(BIT(fdma->channel_id),
+			 BIT(fdma->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
 			 sparx5, FDMA_INTR_DB_ENA);
 	}
 	if (counter)
@@ -252,12 +261,13 @@ static struct sparx5_tx_dcb_hw *sparx5_fdma_next_dcb(struct sparx5_tx *tx,
 						     struct sparx5_tx_dcb_hw *dcb)
 {
 	struct sparx5_tx_dcb_hw *next_dcb;
+	struct fdma *fdma = &tx->fdma;
 
 	next_dcb = dcb;
 	next_dcb++;
 	/* Handle wrap-around */
 	if ((unsigned long)next_dcb >=
-	    ((unsigned long)tx->first_entry + FDMA_DCB_MAX * sizeof(*dcb)))
+	    ((unsigned long)tx->first_entry + fdma->n_dcbs * sizeof(*dcb)))
 		next_dcb = tx->first_entry;
 	return next_dcb;
 }
@@ -300,28 +310,29 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
 {
 	struct sparx5_rx *rx = &sparx5->rx;
+	struct fdma *fdma = &rx->fdma;
 	struct sparx5_rx_dcb_hw *dcb;
 	int idx, jdx;
 	int size;
 
-	size = sizeof(struct sparx5_rx_dcb_hw) * FDMA_DCB_MAX;
+	size = sizeof(struct sparx5_rx_dcb_hw) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	rx->dcb_entries = devm_kzalloc(sparx5->dev, size, GFP_KERNEL);
 	if (!rx->dcb_entries)
 		return -ENOMEM;
 	rx->dma = virt_to_phys(rx->dcb_entries);
 	rx->last_entry = rx->dcb_entries;
-	rx->db_index = 0;
-	rx->dcb_index = 0;
+	fdma->db_index = 0;
+	fdma->dcb_index = 0;
 	/* Now for each dcb allocate the db */
-	for (idx = 0; idx < FDMA_DCB_MAX; ++idx) {
+	for (idx = 0; idx < fdma->n_dcbs; ++idx) {
 		dcb = &rx->dcb_entries[idx];
 		dcb->info = 0;
 		/* For each db allocate an skb and map skb data pointer to the DB
 		 * dataptr. In this way when the frame is received the skb->data
 		 * will contain the frame, so no memcpy is needed
 		 */
-		for (jdx = 0; jdx < FDMA_RX_DCB_MAX_DBS; ++jdx) {
+		for (jdx = 0; jdx < fdma->n_dbs; ++jdx) {
 			struct sparx5_db_hw *db_hw = &dcb->db[jdx];
 			dma_addr_t dma_addr;
 			struct sk_buff *skb;
@@ -348,10 +359,11 @@ static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 {
 	struct sparx5_tx *tx = &sparx5->tx;
 	struct sparx5_tx_dcb_hw *dcb;
+	struct fdma *fdma = &tx->fdma;
 	int idx, jdx;
 	int size;
 
-	size = sizeof(struct sparx5_tx_dcb_hw) * FDMA_DCB_MAX;
+	size = sizeof(struct sparx5_tx_dcb_hw) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	tx->curr_entry = devm_kzalloc(sparx5->dev, size, GFP_KERNEL);
 	if (!tx->curr_entry)
@@ -360,11 +372,11 @@ static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 	tx->first_entry = tx->curr_entry;
 	INIT_LIST_HEAD(&tx->db_list);
 	/* Now for each dcb allocate the db */
-	for (idx = 0; idx < FDMA_DCB_MAX; ++idx) {
+	for (idx = 0; idx < fdma->n_dcbs; ++idx) {
 		dcb = &tx->curr_entry[idx];
 		dcb->info = 0;
 		/* TX databuffers must be 16byte aligned */
-		for (jdx = 0; jdx < FDMA_TX_DCB_MAX_DBS; ++jdx) {
+		for (jdx = 0; jdx < fdma->n_dbs; ++jdx) {
 			struct sparx5_db_hw *db_hw = &dcb->db[jdx];
 			struct sparx5_db *db;
 			dma_addr_t phys;
@@ -386,7 +398,7 @@ static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 		}
 		sparx5_fdma_tx_add_dcb(tx, dcb, tx->dma + sizeof(*dcb) * idx);
 		/* Let the curr_entry to point to the last allocated entry */
-		if (idx == FDMA_DCB_MAX - 1)
+		if (idx == fdma->n_dcbs - 1)
 			tx->curr_entry = dcb;
 	}
 	return 0;
@@ -395,9 +407,12 @@ static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
 				struct sparx5_rx *rx, int channel)
 {
+	struct fdma *fdma = &rx->fdma;
 	int idx;
 
-	rx->channel_id = channel;
+	fdma->channel_id = channel;
+	fdma->n_dcbs = FDMA_DCB_MAX;
+	fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
 	/* Fetch a netdev for SKB and NAPI use, any will do */
 	for (idx = 0; idx < SPX5_PORTS; ++idx) {
 		struct sparx5_port *port = sparx5->ports[idx];
@@ -412,7 +427,11 @@ static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
 static void sparx5_fdma_tx_init(struct sparx5 *sparx5,
 				struct sparx5_tx *tx, int channel)
 {
-	tx->channel_id = channel;
+	struct fdma *fdma = &tx->fdma;
+
+	fdma->channel_id = channel;
+	fdma->n_dcbs = FDMA_DCB_MAX;
+	fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
 }
 
 irqreturn_t sparx5_fdma_handler(int irq, void *args)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index f7ac47af58ce..542f57569c5f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -126,14 +126,12 @@ struct sparx5_tx_dcb_hw {
  * When the db_index reached FDMA_RX_DCB_MAX_DBS the DB is reused.
  */
 struct sparx5_rx {
+	struct fdma fdma;
 	struct sparx5_rx_dcb_hw *dcb_entries;
 	struct sparx5_rx_dcb_hw *last_entry;
 	struct sk_buff *skb[FDMA_DCB_MAX][FDMA_RX_DCB_MAX_DBS];
-	int db_index;
-	int dcb_index;
 	dma_addr_t dma;
 	struct napi_struct napi;
-	u32 channel_id;
 	struct net_device *ndev;
 	u64 packets;
 };
@@ -142,11 +140,11 @@ struct sparx5_rx {
  * DCBs are chained using the DCBs nextptr field.
  */
 struct sparx5_tx {
+	struct fdma fdma;
 	struct sparx5_tx_dcb_hw *curr_entry;
 	struct sparx5_tx_dcb_hw *first_entry;
 	struct list_head db_list;
 	dma_addr_t dma;
-	u32 channel_id;
 	u64 packets;
 	u64 dropped;
 };

-- 
2.34.1


