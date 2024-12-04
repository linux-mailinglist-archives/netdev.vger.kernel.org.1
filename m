Return-Path: <netdev+bounces-148983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6899E3B55
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136E61642DA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937B91E3DCF;
	Wed,  4 Dec 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hmyVQlcb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC141DB527;
	Wed,  4 Dec 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319354; cv=none; b=kp+4SXnEM9bqu+SSONlvXLnirWq4yUJaW5sAVRpGoEaO9gZImso7rJhWI7uLo7F2RgWigoto4HZALGhcASRP7/zlJWXaEtQxVpTef39bvsn0cN/XIRwJ32SHPweFC/vQOFDFPICXjKnuL8X5KYGRtmz705WCCDYskGPGuObh4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319354; c=relaxed/simple;
	bh=kCmQpc62vu7iN2vewBCEv8SdnbZpuhZa7qB4XcIC48c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRLgTI93Wwig5sRyFXR4snMUFkSpwwlm19Jwi9yzkw3SPX/u8AUhzwi0qok1BMIv2noev9fxxb0VMF/310l/oPFV3OJ/S/6yN642s6qGpNyxbzKS7e0oYPQVj6j1y1zSLyyvjtdcRYWH2Kdkfi2Tah6NEk8Y9nPl/tJMB9FXt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hmyVQlcb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733319352; x=1764855352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kCmQpc62vu7iN2vewBCEv8SdnbZpuhZa7qB4XcIC48c=;
  b=hmyVQlcb9x+BqulN+a6G64eyeEPbTfav1zYv8cWyVTcn6lYqDL5cgWZ/
   T8XG4gnClERMcBdNl+qmiOT2pwu+UjqJivXH7pf3BLfyjPstfxPtdYCA6
   xpIL0DSK9bvSyr6Klu2X4fUAg6Il2gc66MKIyOo5QOUbSrH8Sh+5g5GLY
   TgVA2l3dudImH6W7Wp3Lo5ud0QXirS/aXLZERGIkzJzwIZvn9EANdWsFy
   ry2xbkE9lG67BhhrjnysjiDwXOw9fSJMlKlH7ut0VBxXzwRC5MVg4hp3w
   orOkHotc6ryjEXcmuxpgVU3Rdnr2h97bkX3ToOCr+2VAg3Vra2F1XWly0
   w==;
X-CSE-ConnectionGUID: VbhafuIkT3qGMiaY6WYdEQ==
X-CSE-MsgGUID: GwlJ9O+GQOmXPXaaAiokAA==
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="34821617"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 06:35:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Dec 2024 06:35:33 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Dec 2024 06:35:30 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race condition between reference pointers
Date: Wed, 4 Dec 2024 19:05:18 +0530
Message-ID: <20241204133518.581207-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
References: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are two skb pointers to manage tx skb's enqueued from n/w stack.
waiting_tx_skb pointer points to the tx skb which needs to be processed
and ongoing_tx_skb pointer points to the tx skb which is being processed.

SPI thread prepares the tx data chunks from the tx skb pointed by the
ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
processed, the tx skb pointed by the waiting_tx_skb is assigned to
ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
Whenever there is a new tx skb from n/w stack, it will be assigned to
waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
handled in two different threads.

Consider a scenario where the SPI thread processed an ongoing_tx_skb and
it moves next tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer
without doing any NULL check. At this time, if the waiting_tx_skb pointer
is NULL then ongoing_tx_skb pointer is also assigned with NULL. After
that, if a new tx skb is assigned to waiting_tx_skb pointer by the n/w
stack and there is a chance to overwrite the tx skb pointer with NULL in
the SPI thread. Finally one of the tx skb will be left as unhandled,
resulting packet missing and memory leak.

- Consider the below scenario where the TXC reported from the previous
transfer is 10 and ongoing_tx_skb holds an tx ethernet frame which can be
transported in 20 TXCs and waiting_tx_skb is still NULL.
	tx_credits = 10; /* 21 are filled in the previous transfer */
	ongoing_tx_skb = 20;
	waiting_tx_skb = NULL; /* Still NULL */
- So, (tc6->ongoing_tx_skb || tc6->waiting_tx_skb) becomes true.
- After oa_tc6_prepare_spi_tx_buf_for_tx_skbs()
	ongoing_tx_skb = 10;
	waiting_tx_skb = NULL; /* Still NULL */
- Perform SPI transfer.
- Process SPI rx buffer to get the TXC from footers.
- Now let's assume previously filled 21 TXCs are freed so we are good to
transport the next remaining 10 tx chunks from ongoing_tx_skb.
	tx_credits = 21;
	ongoing_tx_skb = 10;
	waiting_tx_skb = NULL;
- So, (tc6->ongoing_tx_skb || tc6->waiting_tx_skb) becomes true again.
- In the oa_tc6_prepare_spi_tx_buf_for_tx_skbs()
	ongoing_tx_skb = NULL;
	waiting_tx_skb = NULL;

- Now the below bad case might happen,

Thread1 (oa_tc6_start_xmit)	Thread2 (oa_tc6_spi_thread_handler)
---------------------------	-----------------------------------
- if waiting_tx_skb is NULL
				- if ongoing_tx_skb is NULL
				- ongoing_tx_skb = waiting_tx_skb
- waiting_tx_skb = skb
				- waiting_tx_skb = NULL
				...
				- ongoing_tx_skb = NULL
- if waiting_tx_skb is NULL
- waiting_tx_skb = skb

To overcome the above issue, protect the moving of tx skb reference from
waiting_tx_skb pointer to ongoing_tx_skb pointer and assigning new tx skb
to waiting_tx_skb pointer, so that the other thread can't access the
waiting_tx_skb pointer until the current thread completes moving the tx
skb reference safely.

Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 4c8b0ca922b7..574bfd4e9356 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -113,6 +113,7 @@ struct oa_tc6 {
 	struct mii_bus *mdiobus;
 	struct spi_device *spi;
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
+	struct mutex tx_skb_lock; /* Protects tx skb handling */
 	void *spi_ctrl_tx_buf;
 	void *spi_ctrl_rx_buf;
 	void *spi_data_tx_buf;
@@ -1004,8 +1005,10 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
 	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
 	     used_tx_credits++) {
 		if (!tc6->ongoing_tx_skb) {
+			mutex_lock(&tc6->tx_skb_lock);
 			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
 			tc6->waiting_tx_skb = NULL;
+			mutex_unlock(&tc6->tx_skb_lock);
 		}
 		if (!tc6->ongoing_tx_skb)
 			break;
@@ -1210,7 +1213,9 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 		return NETDEV_TX_OK;
 	}
 
+	mutex_lock(&tc6->tx_skb_lock);
 	tc6->waiting_tx_skb = skb;
+	mutex_unlock(&tc6->tx_skb_lock);
 
 	/* Wake spi kthread to perform spi transfer */
 	wake_up_interruptible(&tc6->spi_wq);
@@ -1240,6 +1245,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	tc6->netdev = netdev;
 	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
+	mutex_init(&tc6->tx_skb_lock);
 
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
-- 
2.34.1


