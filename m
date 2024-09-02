Return-Path: <netdev+bounces-124231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997B968A5C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801A0B20C7B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5A20126B;
	Mon,  2 Sep 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sRukddVR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00B364BA;
	Mon,  2 Sep 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288900; cv=none; b=s96ovOjoFuxheY+pNkY883GYhgSkYRQ2Q2DVU18l4nV2MqhD1te2Kh657oz8mXCsd/JJXClBu0GH6gt16JfQvhDtGqyY9ydZlP4olK7QDJoTeSmyPxawqS6nS6ud0VlAjg6AfRKzy7oFIAxgTpjNGfXfgHu0u5KRN6TxLu/6DoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288900; c=relaxed/simple;
	bh=RFq5AxOzVdqoMzd9LJQyduTyNy1tEpM8ZAnkxMUGgs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hJ6xNAle5h0hOpLTNX4a13WtfTtwtNx8JNmnz9V1Y6fRnBG9LsBmTpGoRZ9iW5ujbnD9UpCRXKN7ibW0SY3OhoKgfwmomqjgffgRRZZmNdOgYiOK7ot0C2AMR9EuEy7/BBlvh3jiaGVO973M/xaepoqjY4gs/MeGLdAFMHOJfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sRukddVR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288898; x=1756824898;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RFq5AxOzVdqoMzd9LJQyduTyNy1tEpM8ZAnkxMUGgs8=;
  b=sRukddVRvggVy/z3nMsVmYCi4lIEjfqbOl2iW7TIqbw1z0i0UtKA2QK5
   FCcwvhTWIfhdaYXyFLqDi/EoYCz+ospUzlpo1GVPPIoArlx51Mguh8GxF
   qQBoAmVBqD/UPeDNFOCX0dr6KUCDH4hFN2pBIP1fPeNxM2gArtYy9olyC
   582jk2xZ+1PCf0nujyUsWZbNnq8lau6U3IRcy4jIGTMQ60PJ3FkdflXyt
   L/gq5Pa8YevBME5vzAtp7Ke7SbTC3H1YkAmfZlp3/h4BNcaTI9vys7SlI
   5ayUbHa0/7fPdejOrkYGS/HKFs9kWA4f0XQdsBTcVubEzn/dFiwZovQqo
   g==;
X-CSE-ConnectionGUID: WWovGYJSTraVm+sPH856TA==
X-CSE-MsgGUID: Sz3lNb5bSGy63k78rnTx+Q==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="262150743"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:54:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:49 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:47 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:10 +0200
Subject: [PATCH net-next 05/12] net: sparx5: use FDMA library for adding
 DCB's in the rx path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-5-1e7d5e5a9f34@microchip.com>
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

Use the fdma_dcb_add() function to add DCB's in the rx path. This gets
rid of the open-coding of nextptr and dataptr handling and leaves it to
the library.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 49 ++--------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 675f8d5faa74..122876136f75 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -50,26 +50,6 @@ static int sparx5_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 	return 0;
 }
 
-static void sparx5_fdma_rx_add_dcb(struct sparx5_rx *rx,
-				   struct fdma_dcb *dcb,
-				   u64 nextptr)
-{
-	struct fdma *fdma = &rx->fdma;
-	int idx = 0;
-
-	/* Reset the status of the DB */
-	for (idx = 0; idx < fdma->n_dbs; ++idx) {
-		struct fdma_db *db = &dcb->db[idx];
-
-		db->status = FDMA_DCB_STATUS_INTR;
-	}
-	dcb->nextptr = FDMA_DCB_INVALID_DATA;
-	dcb->info = FDMA_DCB_INFO_DATAL(FDMA_XTR_BUFFER_SIZE);
-
-	fdma->last_dcb->nextptr = nextptr;
-	fdma->last_dcb = dcb;
-}
-
 static void sparx5_fdma_tx_add_dcb(struct sparx5_tx *tx,
 				   struct sparx5_tx_dcb_hw *dcb,
 				   u64 nextptr)
@@ -179,36 +159,20 @@ static void sparx5_fdma_tx_reload(struct sparx5 *sparx5, struct sparx5_tx *tx)
 	spx5_wr(BIT(tx->fdma.channel_id), sparx5, FDMA_CH_RELOAD);
 }
 
-static struct sk_buff *sparx5_fdma_rx_alloc_skb(struct sparx5_rx *rx)
-{
-	return __netdev_alloc_skb(rx->ndev, FDMA_XTR_BUFFER_SIZE,
-				  GFP_ATOMIC);
-}
-
 static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
 	struct fdma *fdma = &rx->fdma;
 	unsigned int packet_size;
 	struct sparx5_port *port;
-	struct sk_buff *new_skb;
 	struct fdma_db *db_hw;
 	struct frame_info fi;
 	struct sk_buff *skb;
-	dma_addr_t dma_addr;
 
 	/* Check if the DCB is done */
 	db_hw = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
 	if (unlikely(!(db_hw->status & FDMA_DCB_STATUS_DONE)))
 		return false;
 	skb = rx->skb[fdma->dcb_index][fdma->db_index];
-	/* Replace the DB entry with a new SKB */
-	new_skb = sparx5_fdma_rx_alloc_skb(rx);
-	if (unlikely(!new_skb))
-		return false;
-	/* Map the new skb data and set the new skb */
-	dma_addr = virt_to_phys(new_skb->data);
-	rx->skb[fdma->dcb_index][fdma->db_index] = new_skb;
-	db_hw->dataptr = dma_addr;
 	packet_size = FDMA_DCB_STATUS_BLOCKL(db_hw->status);
 	skb_put(skb, packet_size);
 	/* Now do the normal processing of the skb */
@@ -247,24 +211,17 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 	int counter = 0;
 
 	while (counter < weight && sparx5_fdma_rx_get_frame(sparx5, rx)) {
-		struct fdma_dcb *old_dcb;
-
 		fdma->db_index++;
 		counter++;
 		/* Check if the DCB can be reused */
 		if (fdma->db_index != fdma->n_dbs)
 			continue;
-		/* As the DCB  can be reused, just advance the dcb_index
-		 * pointer and set the nextptr in the DCB
-		 */
+		fdma_dcb_add(fdma, fdma->dcb_index,
+			     FDMA_DCB_INFO_DATAL(fdma->db_size),
+			     FDMA_DCB_STATUS_INTR);
 		fdma->db_index = 0;
-		old_dcb = &fdma->dcbs[fdma->dcb_index];
 		fdma->dcb_index++;
 		fdma->dcb_index &= fdma->n_dcbs - 1;
-		sparx5_fdma_rx_add_dcb(rx, old_dcb,
-				       fdma->dma +
-				       ((unsigned long)old_dcb -
-					(unsigned long)fdma->dcbs));
 	}
 	if (counter < weight) {
 		napi_complete_done(&rx->napi, counter);

-- 
2.34.1


