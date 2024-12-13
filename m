Return-Path: <netdev+bounces-151748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97269F0C4A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B312822F5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90D1DFE04;
	Fri, 13 Dec 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T4NC2HZs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AC1DF97A;
	Fri, 13 Dec 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093153; cv=none; b=N1U/hoIAOAB6cc5eXKFvui+ZHyaUe8m7UJFUnryBBqYxut5vEBdBz7hFObi5onUbuK6Y3sYboU7D6oXGzTPL2CBz4iMDnTYNUG3YgRo51wTlGjeql0odcbrRLRKAOPqKHfHC6orx3IvYkNTtwA5JEpQy2beYIqc965PpcRSHoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093153; c=relaxed/simple;
	bh=8bsBblHZ5HPCS/0voc9auFAQnDpRi3kvKg2hfGu9DYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBgLMkz05gneBUcorrSS7dtctj4Fg3m0UKnn7NBB9qcDYmLEccI2cEVDLsb/6uwc+fu7llQqo2PSoRip/AqDPkDWlHoMODM7zk31SIyD96P0JeTjq+x/JCDY0uVpioBlDO2LGj5hatvQesj/VzbFIEFTVxhcTMbdRmWFzRGKZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T4NC2HZs; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734093151; x=1765629151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bsBblHZ5HPCS/0voc9auFAQnDpRi3kvKg2hfGu9DYI=;
  b=T4NC2HZstTIaBtMS8Biz4ElyRaEJ4Ckdhrmtue0R1g4uNUPZsYFdYscU
   EXzvsZUPtpEj69cEQvkIEQQI4dWtEx59k0peDd0iTwWhjIfOow0nt2PYn
   kqP3qI0jceIxb2qJZr2UBzABLNY6ufK7ePKT2dkDYTGhoxiLJ7STTMOXO
   MUbP3u3/vpH60sP3d59ac9dHDeCvH4PTyWctlufBFFIW3078Dj4IYW1G8
   b8P+0j9xOXsQFlpavWKvcRCSPTc3PWL5mBglgCSL3xTXKfrBMB5kzOUiy
   aW1Fhchc15/aqPaLoAD8wXXaU1vvyOiSQO5wy1CtWrydKl1QnMi1p8ylO
   g==;
X-CSE-ConnectionGUID: T4iONzRASJC/nLtS7vBTbg==
X-CSE-MsgGUID: wfiaStY1STeeGdAxq3S2ww==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="35183036"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 05:32:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 05:32:17 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 05:32:13 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v4 2/2] net: ethernet: oa_tc6: fix tx skb race condition between reference pointers
Date: Fri, 13 Dec 2024 18:01:59 +0530
Message-ID: <20241213123159.439739-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
References: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
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
index 4c8b0ca922b7..db200e4ec284 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -113,6 +113,7 @@ struct oa_tc6 {
 	struct mii_bus *mdiobus;
 	struct spi_device *spi;
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
+	spinlock_t tx_skb_lock; /* Protects tx skb handling */
 	void *spi_ctrl_tx_buf;
 	void *spi_ctrl_rx_buf;
 	void *spi_data_tx_buf;
@@ -1004,8 +1005,10 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
 	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
 	     used_tx_credits++) {
 		if (!tc6->ongoing_tx_skb) {
+			spin_lock_bh(&tc6->tx_skb_lock);
 			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
 			tc6->waiting_tx_skb = NULL;
+			spin_unlock_bh(&tc6->tx_skb_lock);
 		}
 		if (!tc6->ongoing_tx_skb)
 			break;
@@ -1210,7 +1213,9 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 		return NETDEV_TX_OK;
 	}
 
+	spin_lock_bh(&tc6->tx_skb_lock);
 	tc6->waiting_tx_skb = skb;
+	spin_unlock_bh(&tc6->tx_skb_lock);
 
 	/* Wake spi kthread to perform spi transfer */
 	wake_up_interruptible(&tc6->spi_wq);
@@ -1240,6 +1245,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	tc6->netdev = netdev;
 	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
+	spin_lock_init(&tc6->tx_skb_lock);
 
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
-- 
2.34.1


