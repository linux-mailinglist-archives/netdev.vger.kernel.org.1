Return-Path: <netdev+bounces-124234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7BC968A61
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49269B22093
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECC2139BF;
	Mon,  2 Sep 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e4M8aPcS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998E205E0D;
	Mon,  2 Sep 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288901; cv=none; b=WDiuqmpys3XIhljdnHUu3GIJXAL3ZVrpnv+GqgJdGOUpPmFEuz9qwVFlEWoaCjO5kke2WYajeUAUWm0y0mwgQhOU8PCtHf8B2pj7Vc46ZUHu5ixesZJ3EAoz2kmrV9+LTaCcC4ZhD/Sid6GrOwdLQo524Vjci18jTi12tgpfBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288901; c=relaxed/simple;
	bh=Lfn4u5s/2I5b5td2uE+L9ED5cm4xpV1zdxMEvhbd1Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NEv7vpSD4knOHr0cn8akg1KkH10QG0hnt+RR54mlTwSgk3HhU0u7OfILC4Q4mn2UqPeQ1mUbiWARAQstTjiG3+f7/4c2RiQHxkj0JQDd4rkt7An4bM3skAM4DS0G9dcVfHvDn3ZOHAha/NRWm1Ipgiv8L6UohR7DSTfvEQlsiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e4M8aPcS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288900; x=1756824900;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Lfn4u5s/2I5b5td2uE+L9ED5cm4xpV1zdxMEvhbd1Is=;
  b=e4M8aPcSfIJLK14MBZnWB1/XTOn6ogisZfciVZ5jTqgIoBAREXINc40n
   WrUG7Xl33CfLYgpLXN3mliBEtqjTSAZtTXHH2G6Tj6GOy8nCXDEyeucjI
   ANlRsbj75suCKIAHGVWgog3NwTabmU71u6bdC0P4nOiqnkJ4D78nFghN6
   ulD3U+YLaWhnq6CA2dKAfTGqaACcTQ6zxD96o5GQkj58evwQkLFz5nys2
   ZL3xnqAGwgtL60hduB/OKda62RQbh/N2ZWpoSoCMkHWa/UbggBqsGr8jC
   /ESPZ94hkDIqFme5PNRrZiyRYqhOIedsVJT//j5JBy7TcWUJZbmx39oOH
   w==;
X-CSE-ConnectionGUID: WWovGYJSTraVm+sPH856TA==
X-CSE-MsgGUID: Fj3hJQhtR12n8CP3wvoU5A==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="262150746"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:54:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:57 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:55 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:13 +0200
Subject: [PATCH net-next 08/12] net: sparx5: use the FDMA library for
 allocation of tx buffers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-8-1e7d5e5a9f34@microchip.com>
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

Use the two functions: fdma_alloc_phys() and fdma_dcb_init() for tx
buffer allocation and use the new buffers throughout.

In order to replace the old buffers with the new ones, we have to do the
following refactoring:

    - use fdma_alloc_phys() and fdma_dcb_init()

    - replace the variables: tx->dma, tx->first_entry and tx->curr_entry
      with the equivalents from the FDMA struct.

    - replace uses of sparx5_db_hw and sparx5_tx_dcb_hw with fdma_db and
      fdma_dcb.

    - add sparx5_fdma_tx_dataptr_cb callback for obtaining the dataptr.

    - Initialize FDMA struct values.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 94 ++++++++++------------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 14 ----
 2 files changed, 44 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index c37718b99d67..8f721f7671ce 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -32,6 +32,21 @@ struct sparx5_db {
 	void *cpu_addr;
 };
 
+static int sparx5_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				     u64 *dataptr)
+{
+	struct sparx5 *sparx5 = fdma->priv;
+	struct sparx5_tx *tx = &sparx5->tx;
+	struct sparx5_db *db_buf;
+
+	db_buf = list_first_entry(&tx->db_list, struct sparx5_db, list);
+	list_move_tail(&db_buf->list, &tx->db_list);
+
+	*dataptr = virt_to_phys(db_buf->cpu_addr);
+
+	return 0;
+}
+
 static int sparx5_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 				     u64 *dataptr)
 {
@@ -50,22 +65,6 @@ static int sparx5_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 	return 0;
 }
 
-static void sparx5_fdma_tx_add_dcb(struct sparx5_tx *tx,
-				   struct sparx5_tx_dcb_hw *dcb,
-				   u64 nextptr)
-{
-	int idx = 0;
-
-	/* Reset the status of the DB */
-	for (idx = 0; idx < tx->fdma.n_dbs; ++idx) {
-		struct sparx5_db_hw *db = &dcb->db[idx];
-
-		db->status = FDMA_DCB_STATUS_DONE;
-	}
-	dcb->nextptr = FDMA_DCB_INVALID_DATA;
-	dcb->info = FDMA_DCB_INFO_DATAL(FDMA_XTR_BUFFER_SIZE);
-}
-
 static void sparx5_fdma_rx_activate(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
 	struct fdma *fdma = &rx->fdma;
@@ -122,9 +121,10 @@ static void sparx5_fdma_tx_activate(struct sparx5 *sparx5, struct sparx5_tx *tx)
 	struct fdma *fdma = &tx->fdma;
 
 	/* Write the buffer address in the LLP and LLP1 regs */
-	spx5_wr(((u64)tx->dma) & GENMASK(31, 0), sparx5,
+	spx5_wr(((u64)fdma->dma) & GENMASK(31, 0), sparx5,
 		FDMA_DCB_LLP(fdma->channel_id));
-	spx5_wr(((u64)tx->dma) >> 32, sparx5, FDMA_DCB_LLP1(fdma->channel_id));
+	spx5_wr(((u64)fdma->dma) >> 32, sparx5,
+		FDMA_DCB_LLP1(fdma->channel_id));
 
 	/* Set the number of TX DBs to be used, and DB end-of-frame interrupt */
 	spx5_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
@@ -231,40 +231,41 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 	return counter;
 }
 
-static struct sparx5_tx_dcb_hw *sparx5_fdma_next_dcb(struct sparx5_tx *tx,
-						     struct sparx5_tx_dcb_hw *dcb)
+static struct fdma_dcb *sparx5_fdma_next_dcb(struct sparx5_tx *tx,
+					     struct fdma_dcb *dcb)
 {
-	struct sparx5_tx_dcb_hw *next_dcb;
+	struct fdma_dcb *next_dcb;
 	struct fdma *fdma = &tx->fdma;
 
 	next_dcb = dcb;
 	next_dcb++;
 	/* Handle wrap-around */
 	if ((unsigned long)next_dcb >=
-	    ((unsigned long)tx->first_entry + fdma->n_dcbs * sizeof(*dcb)))
-		next_dcb = tx->first_entry;
+	    ((unsigned long)fdma->dcbs + fdma->n_dcbs * sizeof(*dcb)))
+		next_dcb = fdma->dcbs;
 	return next_dcb;
 }
 
 int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 {
-	struct sparx5_tx_dcb_hw *next_dcb_hw;
 	struct sparx5_tx *tx = &sparx5->tx;
+	struct fdma *fdma = &tx->fdma;
 	static bool first_time = true;
-	struct sparx5_db_hw *db_hw;
+	struct fdma_dcb *next_dcb_hw;
+	struct fdma_db *db_hw;
 	struct sparx5_db *db;
 
-	next_dcb_hw = sparx5_fdma_next_dcb(tx, tx->curr_entry);
+	next_dcb_hw = sparx5_fdma_next_dcb(tx, fdma->last_dcb);
 	db_hw = &next_dcb_hw->db[0];
 	if (!(db_hw->status & FDMA_DCB_STATUS_DONE))
 		return -EINVAL;
 	db = list_first_entry(&tx->db_list, struct sparx5_db, list);
 	list_move_tail(&db->list, &tx->db_list);
 	next_dcb_hw->nextptr = FDMA_DCB_INVALID_DATA;
-	tx->curr_entry->nextptr = tx->dma +
+	fdma->last_dcb->nextptr = fdma->dma +
 		((unsigned long)next_dcb_hw -
-		 (unsigned long)tx->first_entry);
-	tx->curr_entry = next_dcb_hw;
+		(unsigned long)fdma->dcbs);
+	fdma->last_dcb = next_dcb_hw;
 	memset(db->cpu_addr, 0, FDMA_XTR_BUFFER_SIZE);
 	memcpy(db->cpu_addr, ifh, IFH_LEN * 4);
 	memcpy(db->cpu_addr + IFH_LEN * 4, skb->data, skb->len);
@@ -304,28 +305,15 @@ static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
 static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 {
 	struct sparx5_tx *tx = &sparx5->tx;
-	struct sparx5_tx_dcb_hw *dcb;
 	struct fdma *fdma = &tx->fdma;
-	int idx, jdx;
-	int size;
+	int idx, jdx, err;
 
-	size = sizeof(struct sparx5_tx_dcb_hw) * fdma->n_dcbs;
-	size = ALIGN(size, PAGE_SIZE);
-	tx->curr_entry = devm_kzalloc(sparx5->dev, size, GFP_KERNEL);
-	if (!tx->curr_entry)
-		return -ENOMEM;
-	tx->dma = virt_to_phys(tx->curr_entry);
-	tx->first_entry = tx->curr_entry;
 	INIT_LIST_HEAD(&tx->db_list);
 	/* Now for each dcb allocate the db */
 	for (idx = 0; idx < fdma->n_dcbs; ++idx) {
-		dcb = &tx->curr_entry[idx];
-		dcb->info = 0;
 		/* TX databuffers must be 16byte aligned */
 		for (jdx = 0; jdx < fdma->n_dbs; ++jdx) {
-			struct sparx5_db_hw *db_hw = &dcb->db[jdx];
 			struct sparx5_db *db;
-			dma_addr_t phys;
 			void *cpu_addr;
 
 			cpu_addr = devm_kzalloc(sparx5->dev,
@@ -333,20 +321,21 @@ static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 						GFP_KERNEL);
 			if (!cpu_addr)
 				return -ENOMEM;
-			phys = virt_to_phys(cpu_addr);
-			db_hw->dataptr = phys;
-			db_hw->status = 0;
 			db = devm_kzalloc(sparx5->dev, sizeof(*db), GFP_KERNEL);
 			if (!db)
 				return -ENOMEM;
 			db->cpu_addr = cpu_addr;
 			list_add_tail(&db->list, &tx->db_list);
 		}
-		sparx5_fdma_tx_add_dcb(tx, dcb, tx->dma + sizeof(*dcb) * idx);
-		/* Let the curr_entry to point to the last allocated entry */
-		if (idx == fdma->n_dcbs - 1)
-			tx->curr_entry = dcb;
 	}
+
+	err = fdma_alloc_phys(fdma);
+	if (err)
+		return err;
+
+	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_DONE);
+
 	return 0;
 }
 
@@ -383,6 +372,11 @@ static void sparx5_fdma_tx_init(struct sparx5 *sparx5,
 	fdma->channel_id = channel;
 	fdma->n_dcbs = FDMA_DCB_MAX;
 	fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
+	fdma->priv = sparx5;
+	fdma->db_size = ALIGN(FDMA_XTR_BUFFER_SIZE, PAGE_SIZE);
+	fdma->size = fdma_get_size(&sparx5->tx.fdma);
+	fdma->ops.dataptr_cb = &sparx5_fdma_tx_dataptr_cb;
+	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
 }
 
 irqreturn_t sparx5_fdma_handler(int irq, void *args)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 1f57739b601c..81c3f8f2f474 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -102,17 +102,6 @@ enum sparx5_vlan_port_type {
 
 struct sparx5;
 
-struct sparx5_db_hw {
-	u64 dataptr;
-	u64 status;
-};
-
-struct sparx5_tx_dcb_hw {
-	u64 nextptr;
-	u64 info;
-	struct sparx5_db_hw db[FDMA_TX_DCB_MAX_DBS];
-};
-
 /* Frame DMA receive state:
  * For each DB, there is a SKB, and the skb data pointer is mapped in
  * the DB. Once a frame is received the skb is given to the upper layers
@@ -133,10 +122,7 @@ struct sparx5_rx {
  */
 struct sparx5_tx {
 	struct fdma fdma;
-	struct sparx5_tx_dcb_hw *curr_entry;
-	struct sparx5_tx_dcb_hw *first_entry;
 	struct list_head db_list;
-	dma_addr_t dma;
 	u64 packets;
 	u64 dropped;
 };

-- 
2.34.1


