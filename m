Return-Path: <netdev+bounces-124230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7116E968A5A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280B428324D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B019F10E;
	Mon,  2 Sep 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T2oB9WNo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC11A263A;
	Mon,  2 Sep 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288899; cv=none; b=REc5MvwdOTjA1o6O7XshG8Qir/KW0uYb87TUJVAczIQcagBaGbzLLSQt4Wp8NxIxly11F8dQLU/v1/FqCkdhysx4Z+PSq3Mtkhwh2cFa47kwVyYtYgpFCPfwNGpRv2hcqmoaIFZUhC5TwMvxVSBxLJ2dI3LxO4IWkAx3FD0yyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288899; c=relaxed/simple;
	bh=eS165KBt/VWfkinZmqHUA0FZg4j2gcoUnecwJ2Uequ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TBExUihSYjAvR+BOZd0I//ZDjmbaZktY/C/vR8dwUg2tdRfLEFWlwiUo5wsBXCwKAovmkcE8O7/pBwKNyqaze8OP7KEqToHtUsvKey4APcIGHZmOgT3JW99hjsYkkYh4m5cicj8lHutCZgFV2hdusflICLVb/uhop3X8YM61kGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T2oB9WNo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288897; x=1756824897;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eS165KBt/VWfkinZmqHUA0FZg4j2gcoUnecwJ2Uequ0=;
  b=T2oB9WNo1Qmsl++uqB5gtBFLADnqCa9yRddQSKf9Kff9eHRI0hWqD1yH
   wmgrBdmxMW7+U6E/KJgCpmcjEEUff8fKateriQa+AzUSCLi7JkMlthQQN
   fEr+mZaw5f4Rve1RS80OXOByB46xpqtC4yfJGHzJt+OlkjG7Zl0+AMdaJ
   w3N8U6/6eKNJv/i8iC9SajT5mYEmlsQF+jFAS12HAbSu+OgyssuRutHev
   DplBg/Tf7SHT1lwkT3QDYrwGJj/etFNJCljzWQCSj+jaqtmpytyJW5aZb
   Vkm/JSr5ignKspcNgjOkUC8uAAVZsSaVeFAOookBVGg/EzlDMjrC48YmN
   A==;
X-CSE-ConnectionGUID: WWovGYJSTraVm+sPH856TA==
X-CSE-MsgGUID: bLSEX0AeSYaGswVqI2xnBQ==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="262150742"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:54:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:47 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:44 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:09 +0200
Subject: [PATCH net-next 04/12] net: sparx5: use the FDMA library for
 allocation of rx buffers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-4-1e7d5e5a9f34@microchip.com>
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

Use the two functions: fdma_alloc_phys() and fdma_dcb_init() for rx
buffer allocation and use the new buffers throughout.

In order to replace the old buffers with the new ones, we have to do the
following refactoring:

    - use fdma_alloc_phys() and fdma_dcb_init()

    - replace the variables: rx->dma, rx->dcb_entries and rx->last_entry
      with the equivalents from the FDMA struct.

    - replace uses of sparx5_db_hw and sparx5_rx_dcb_hw with fdma_db and
      fdma_dcb.

    - add sparx5_fdma_rx_dataptr_cb callback for obtaining the dataptr.

    - Initialize FDMA struct values.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 89 +++++++++++-----------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  8 --
 2 files changed, 43 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 5e058dbc734e..675f8d5faa74 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -32,8 +32,26 @@ struct sparx5_db {
 	void *cpu_addr;
 };
 
+static int sparx5_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				     u64 *dataptr)
+{
+	struct sparx5 *sparx5 = fdma->priv;
+	struct sparx5_rx *rx = &sparx5->rx;
+	struct sk_buff *skb;
+
+	skb = __netdev_alloc_skb(rx->ndev, fdma->db_size, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	*dataptr = virt_to_phys(skb->data);
+
+	rx->skb[dcb][db] = skb;
+
+	return 0;
+}
+
 static void sparx5_fdma_rx_add_dcb(struct sparx5_rx *rx,
-				   struct sparx5_rx_dcb_hw *dcb,
+				   struct fdma_dcb *dcb,
 				   u64 nextptr)
 {
 	struct fdma *fdma = &rx->fdma;
@@ -41,14 +59,15 @@ static void sparx5_fdma_rx_add_dcb(struct sparx5_rx *rx,
 
 	/* Reset the status of the DB */
 	for (idx = 0; idx < fdma->n_dbs; ++idx) {
-		struct sparx5_db_hw *db = &dcb->db[idx];
+		struct fdma_db *db = &dcb->db[idx];
 
 		db->status = FDMA_DCB_STATUS_INTR;
 	}
 	dcb->nextptr = FDMA_DCB_INVALID_DATA;
 	dcb->info = FDMA_DCB_INFO_DATAL(FDMA_XTR_BUFFER_SIZE);
-	rx->last_entry->nextptr = nextptr;
-	rx->last_entry = dcb;
+
+	fdma->last_dcb->nextptr = nextptr;
+	fdma->last_dcb = dcb;
 }
 
 static void sparx5_fdma_tx_add_dcb(struct sparx5_tx *tx,
@@ -72,9 +91,10 @@ static void sparx5_fdma_rx_activate(struct sparx5 *sparx5, struct sparx5_rx *rx)
 	struct fdma *fdma = &rx->fdma;
 
 	/* Write the buffer address in the LLP and LLP1 regs */
-	spx5_wr(((u64)rx->dma) & GENMASK(31, 0), sparx5,
+	spx5_wr(((u64)fdma->dma) & GENMASK(31, 0), sparx5,
 		FDMA_DCB_LLP(fdma->channel_id));
-	spx5_wr(((u64)rx->dma) >> 32, sparx5, FDMA_DCB_LLP1(fdma->channel_id));
+	spx5_wr(((u64)fdma->dma) >> 32, sparx5,
+		FDMA_DCB_LLP1(fdma->channel_id));
 
 	/* Set the number of RX DBs to be used, and DB end-of-frame interrupt */
 	spx5_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
@@ -168,16 +188,16 @@ static struct sk_buff *sparx5_fdma_rx_alloc_skb(struct sparx5_rx *rx)
 static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
 	struct fdma *fdma = &rx->fdma;
-	struct sparx5_db_hw *db_hw;
 	unsigned int packet_size;
 	struct sparx5_port *port;
 	struct sk_buff *new_skb;
+	struct fdma_db *db_hw;
 	struct frame_info fi;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
 
 	/* Check if the DCB is done */
-	db_hw = &rx->dcb_entries[fdma->dcb_index].db[fdma->db_index];
+	db_hw = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
 	if (unlikely(!(db_hw->status & FDMA_DCB_STATUS_DONE)))
 		return false;
 	skb = rx->skb[fdma->dcb_index][fdma->db_index];
@@ -227,7 +247,7 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 	int counter = 0;
 
 	while (counter < weight && sparx5_fdma_rx_get_frame(sparx5, rx)) {
-		struct sparx5_rx_dcb_hw *old_dcb;
+		struct fdma_dcb *old_dcb;
 
 		fdma->db_index++;
 		counter++;
@@ -238,13 +258,13 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 		 * pointer and set the nextptr in the DCB
 		 */
 		fdma->db_index = 0;
-		old_dcb = &rx->dcb_entries[fdma->dcb_index];
+		old_dcb = &fdma->dcbs[fdma->dcb_index];
 		fdma->dcb_index++;
 		fdma->dcb_index &= fdma->n_dcbs - 1;
 		sparx5_fdma_rx_add_dcb(rx, old_dcb,
-				       rx->dma +
+				       fdma->dma +
 				       ((unsigned long)old_dcb -
-					(unsigned long)rx->dcb_entries));
+					(unsigned long)fdma->dcbs));
 	}
 	if (counter < weight) {
 		napi_complete_done(&rx->napi, counter);
@@ -311,43 +331,15 @@ static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
 {
 	struct sparx5_rx *rx = &sparx5->rx;
 	struct fdma *fdma = &rx->fdma;
-	struct sparx5_rx_dcb_hw *dcb;
-	int idx, jdx;
-	int size;
+	int err;
 
-	size = sizeof(struct sparx5_rx_dcb_hw) * fdma->n_dcbs;
-	size = ALIGN(size, PAGE_SIZE);
-	rx->dcb_entries = devm_kzalloc(sparx5->dev, size, GFP_KERNEL);
-	if (!rx->dcb_entries)
-		return -ENOMEM;
-	rx->dma = virt_to_phys(rx->dcb_entries);
-	rx->last_entry = rx->dcb_entries;
-	fdma->db_index = 0;
-	fdma->dcb_index = 0;
-	/* Now for each dcb allocate the db */
-	for (idx = 0; idx < fdma->n_dcbs; ++idx) {
-		dcb = &rx->dcb_entries[idx];
-		dcb->info = 0;
-		/* For each db allocate an skb and map skb data pointer to the DB
-		 * dataptr. In this way when the frame is received the skb->data
-		 * will contain the frame, so no memcpy is needed
-		 */
-		for (jdx = 0; jdx < fdma->n_dbs; ++jdx) {
-			struct sparx5_db_hw *db_hw = &dcb->db[jdx];
-			dma_addr_t dma_addr;
-			struct sk_buff *skb;
+	err = fdma_alloc_phys(fdma);
+	if (err)
+		return err;
 
-			skb = sparx5_fdma_rx_alloc_skb(rx);
-			if (!skb)
-				return -ENOMEM;
+	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_INTR);
 
-			dma_addr = virt_to_phys(skb->data);
-			db_hw->dataptr = dma_addr;
-			db_hw->status = 0;
-			rx->skb[idx][jdx] = skb;
-		}
-		sparx5_fdma_rx_add_dcb(rx, dcb, rx->dma + sizeof(*dcb) * idx);
-	}
 	netif_napi_add_weight(rx->ndev, &rx->napi, sparx5_fdma_napi_callback,
 			      FDMA_WEIGHT);
 	napi_enable(&rx->napi);
@@ -413,6 +405,11 @@ static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
 	fdma->channel_id = channel;
 	fdma->n_dcbs = FDMA_DCB_MAX;
 	fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
+	fdma->priv = sparx5;
+	fdma->db_size = ALIGN(FDMA_XTR_BUFFER_SIZE, PAGE_SIZE);
+	fdma->size = fdma_get_size(&sparx5->rx.fdma);
+	fdma->ops.dataptr_cb = &sparx5_fdma_rx_dataptr_cb;
+	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
 	/* Fetch a netdev for SKB and NAPI use, any will do */
 	for (idx = 0; idx < SPX5_PORTS; ++idx) {
 		struct sparx5_port *port = sparx5->ports[idx];
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 542f57569c5f..1f57739b601c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -107,12 +107,6 @@ struct sparx5_db_hw {
 	u64 status;
 };
 
-struct sparx5_rx_dcb_hw {
-	u64 nextptr;
-	u64 info;
-	struct sparx5_db_hw db[FDMA_RX_DCB_MAX_DBS];
-};
-
 struct sparx5_tx_dcb_hw {
 	u64 nextptr;
 	u64 info;
@@ -127,8 +121,6 @@ struct sparx5_tx_dcb_hw {
  */
 struct sparx5_rx {
 	struct fdma fdma;
-	struct sparx5_rx_dcb_hw *dcb_entries;
-	struct sparx5_rx_dcb_hw *last_entry;
 	struct sk_buff *skb[FDMA_DCB_MAX][FDMA_RX_DCB_MAX_DBS];
 	dma_addr_t dma;
 	struct napi_struct napi;

-- 
2.34.1


