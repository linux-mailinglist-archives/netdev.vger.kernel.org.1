Return-Path: <netdev+bounces-124241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A5968A77
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6771C21AD9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE51205E32;
	Mon,  2 Sep 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T8H3xM9v"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED081C62C1;
	Mon,  2 Sep 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288934; cv=none; b=ola70yEs6jSWuzvjFas++2k5ZsEgzyEyIUCIlySGOv3TtBnLEqUrnNMqmCm1U9GREExTWj52ILfynvuZ+tWgPJTMp8D14BNci0vgUQlfOvQkn7mBTHV/lioFlTVvnBsPRCBUgmDQzb4v8UYCIKCu0TSEPsSokBMFsz9XqPj2FQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288934; c=relaxed/simple;
	bh=5v+NTjYBjG3As0RWQ3aYPQUqreQqYJtPgWQj/adShIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aQd2+OWOjRwppzqF2PF8fE2y7z0p55hpQgNmin89RleZXvjqJZbzVz6WqaGBgl18ZZoK9IOeLeJD/PZOIlK40GsLYWvNfiIFvMqAUwSmMAczhT7tYt/16k44ZA21SNU9t1d4fiq/kj3m2840+cN4DqiFvWGZd2S8WoTtHFtCHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T8H3xM9v; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288932; x=1756824932;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5v+NTjYBjG3As0RWQ3aYPQUqreQqYJtPgWQj/adShIA=;
  b=T8H3xM9vFEsB9jXtABq/QVU9GLZpQtK7CA4czz458Mhq4VCQwcn3OGnU
   rk/55fij52d1AdjflSoLH5D81KKwMgTc1N5HS+UXO9J+7GT9Zvr8XDcrl
   1hgpr80Vxv1g/OPUzylIzlbvGjsRAttn2gcMQoGRMGWUL4Gn0sc4QZezp
   iOxaiyoeb+FIBCnyjP0eJsHhQrnzz1DVmuWvJa/qCw/yOtaL1ckjkQHcU
   tHqMTyS5sa9iQdUiba8oa65yqzyyO5807d9FzoLNZJ2koUFQF5Z9wnaJX
   GPlXop3dqlFSDzBwYBxlAiyYumcDla682M6o8JF9NgcGocchwmbH7/XDL
   A==;
X-CSE-ConnectionGUID: 6WD2x+lUSXKxeZe2mffqQA==
X-CSE-MsgGUID: t6HLoMVXTIO/k+sBn4LPAA==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="31128332"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:55:05 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:55:03 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:16 +0200
Subject: [PATCH net-next 11/12] net: sparx5: use contiguous memory for tx
 buffers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-11-1e7d5e5a9f34@microchip.com>
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

Currently, the driver uses a linked list for storing the tx buffer
addresses. This requires a good amount of extra bookkeeping code. Ditch
the linked list in favor of tx buffers being in the same contiguous
memory space as the DCB's and the DB's. The FDMA library has a helper
for this - so use that.

The tx buffer addresses are now retrieved as an offset into the FDMA
memory space.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 57 +++++-----------------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  1 -
 2 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 38735bac6482..7e1bdd0344d0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -24,25 +24,11 @@
 #define FDMA_XTR_BUFFER_SIZE		2048
 #define FDMA_WEIGHT			4
 
-/* For each hardware DB there is an entry in this list and when the HW DB
- * entry is used, this SW DB entry is moved to the back of the list
- */
-struct sparx5_db {
-	struct list_head list;
-	void *cpu_addr;
-};
-
 static int sparx5_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 				     u64 *dataptr)
 {
-	struct sparx5 *sparx5 = fdma->priv;
-	struct sparx5_tx *tx = &sparx5->tx;
-	struct sparx5_db *db_buf;
-
-	db_buf = list_first_entry(&tx->db_list, struct sparx5_db, list);
-	list_move_tail(&db_buf->list, &tx->db_list);
-
-	*dataptr = virt_to_phys(db_buf->cpu_addr);
+	*dataptr = fdma->dma + (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
+		   ((dcb * fdma->n_dbs + db) * fdma->db_size);
 
 	return 0;
 }
@@ -236,15 +222,19 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 	struct sparx5_tx *tx = &sparx5->tx;
 	struct fdma *fdma = &tx->fdma;
 	static bool first_time = true;
-	struct sparx5_db *db;
+	void *virt_addr;
 
 	fdma_dcb_advance(fdma);
 	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
 		return -EINVAL;
-	db = list_first_entry(&tx->db_list, struct sparx5_db, list);
-	memset(db->cpu_addr, 0, FDMA_XTR_BUFFER_SIZE);
-	memcpy(db->cpu_addr, ifh, IFH_LEN * 4);
-	memcpy(db->cpu_addr + IFH_LEN * 4, skb->data, skb->len);
+
+	/* Get the virtual address of the dataptr for the next DB */
+	virt_addr = ((u8 *)fdma->dcbs +
+		     (sizeof(struct fdma_dcb) * fdma->n_dcbs) +
+		     ((fdma->dcb_index * fdma->n_dbs) * fdma->db_size));
+
+	memcpy(virt_addr, ifh, IFH_LEN * 4);
+	memcpy(virt_addr + IFH_LEN * 4, skb->data, skb->len);
 
 	fdma_dcb_add(fdma, fdma->dcb_index, 0,
 		     FDMA_DCB_STATUS_SOF |
@@ -285,28 +275,7 @@ static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 {
 	struct sparx5_tx *tx = &sparx5->tx;
 	struct fdma *fdma = &tx->fdma;
-	int idx, jdx, err;
-
-	INIT_LIST_HEAD(&tx->db_list);
-	/* Now for each dcb allocate the db */
-	for (idx = 0; idx < fdma->n_dcbs; ++idx) {
-		/* TX databuffers must be 16byte aligned */
-		for (jdx = 0; jdx < fdma->n_dbs; ++jdx) {
-			struct sparx5_db *db;
-			void *cpu_addr;
-
-			cpu_addr = devm_kzalloc(sparx5->dev,
-						FDMA_XTR_BUFFER_SIZE,
-						GFP_KERNEL);
-			if (!cpu_addr)
-				return -ENOMEM;
-			db = devm_kzalloc(sparx5->dev, sizeof(*db), GFP_KERNEL);
-			if (!db)
-				return -ENOMEM;
-			db->cpu_addr = cpu_addr;
-			list_add_tail(&db->list, &tx->db_list);
-		}
-	}
+	int err;
 
 	err = fdma_alloc_phys(fdma);
 	if (err)
@@ -353,7 +322,7 @@ static void sparx5_fdma_tx_init(struct sparx5 *sparx5,
 	fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
 	fdma->priv = sparx5;
 	fdma->db_size = ALIGN(FDMA_XTR_BUFFER_SIZE, PAGE_SIZE);
-	fdma->size = fdma_get_size(&sparx5->tx.fdma);
+	fdma->size = fdma_get_size_contiguous(&sparx5->tx.fdma);
 	fdma->ops.dataptr_cb = &sparx5_fdma_tx_dataptr_cb;
 	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 81c3f8f2f474..3309060b1e4c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -122,7 +122,6 @@ struct sparx5_rx {
  */
 struct sparx5_tx {
 	struct fdma fdma;
-	struct list_head db_list;
 	u64 packets;
 	u64 dropped;
 };

-- 
2.34.1


