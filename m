Return-Path: <netdev+bounces-148982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AEF9E3B6C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35150B23CAE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5671C1F29;
	Wed,  4 Dec 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yCd0d6kn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2BB8827;
	Wed,  4 Dec 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319352; cv=none; b=iBIgmM7HpkzQ7P5jTEMfnPY3eG0aaqwiuJKbFN4A2G8yNlBrmm3G8PSabU4lovYRu3Y0oqJ8kj7gjf/lJ2O3q6Kegss1jOXhJAWfPhfYbWhnRYHNclriGqQT2Cy9RShPVPNzgIJQGI6unvWyMseIBS3HW3GZgtRlyIQBKVEhxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319352; c=relaxed/simple;
	bh=Cmo6WDz3rC/L7dCSEvrpYVHvneSHBq6A6CB+GmSheiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPXJ5h3jILpOr7ZNi1HqFkXu55QWXBCx7gCEa5Jc3k3qAnoYl8RnMV8/ALS3yM6qzQ0crq5EPP7xkELqlOJJFBG9Wvz4gdTmceklIdYzLokLzBdgE9SNSesakWjjq4xvtSek8khNKQPiwj0FM/bCKDjzg2jx5PDr7ZjhiqS0Mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yCd0d6kn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733319350; x=1764855350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cmo6WDz3rC/L7dCSEvrpYVHvneSHBq6A6CB+GmSheiY=;
  b=yCd0d6knEqJGK86/AwjGGrqSkNiIDypvaqEnETZcbrSWc8tmejmqyDu+
   1hVyFZaN+cR0GJyCRO37cs+fsrC5ju3QtMYejBvpLJ+dNfIno7SVZcR5t
   Q2dTbmafLHlx5oqR5MB2KOula2XYgl9KCbMzpZVjqqpi2Zi68NzQlHMc9
   t7k3uJ0OXYAEa+TPxaAk2TsACLj8jVcOuRei4Bl2avIXg6B0wcc850gwW
   pmqOw7pq8R2TtOffnoHGX1hBApfq9oOfE1hTBpf/76DjEzRvHYlknAZyM
   TfRUkGZbHIVx/ZrfdnlL4k4K9CXyHy0m4IwIfsQHB45zRoi2z3nka04Bp
   g==;
X-CSE-ConnectionGUID: VbhafuIkT3qGMiaY6WYdEQ==
X-CSE-MsgGUID: nFGgGzjVTbKOeXTBpAU5ug==
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="34821616"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 06:35:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Dec 2024 06:35:29 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Dec 2024 06:35:26 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v3 1/2] net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes 0
Date: Wed, 4 Dec 2024 19:05:17 +0530
Message-ID: <20241204133518.581207-2-parthiban.veerasooran@microchip.com>
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

SPI thread wakes up to perform SPI transfer whenever there is an TX skb
from n/w stack or interrupt from MAC-PHY. Ethernet frame from TX skb is
transferred based on the availability tx credits in the MAC-PHY which is
reported from the previous SPI transfer. Sometimes there is a possibility
that TX skb is available to transmit but there is no tx credits from
MAC-PHY. In this case, there will not be any SPI transfer but the thread
will be running in an endless loop until tx credits available again.

So checking the availability of tx credits along with TX skb will prevent
the above infinite loop. When the tx credits available again that will be
notified through interrupt which will trigger the SPI transfer to get the
available tx credits.

Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index f9c0dcd965c2..4c8b0ca922b7 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1111,8 +1111,9 @@ static int oa_tc6_spi_thread_handler(void *data)
 		/* This kthread will be waken up if there is a tx skb or mac-phy
 		 * interrupt to perform spi transfer with tx chunks.
 		 */
-		wait_event_interruptible(tc6->spi_wq, tc6->waiting_tx_skb ||
-					 tc6->int_flag ||
+		wait_event_interruptible(tc6->spi_wq, tc6->int_flag ||
+					 (tc6->waiting_tx_skb &&
+					 tc6->tx_credits) ||
 					 kthread_should_stop());
 
 		if (kthread_should_stop())
-- 
2.34.1


