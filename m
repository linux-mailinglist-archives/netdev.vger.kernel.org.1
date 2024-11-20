Return-Path: <netdev+bounces-146509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFED9D3CC3
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695641F224D6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754291AA7AA;
	Wed, 20 Nov 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pid6Nw3o"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6191A2C19;
	Wed, 20 Nov 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110732; cv=none; b=ES33NiiPjGwbM+umQOQzz694jAI1VYc3fmoTx4VYFUxN5SgSxUmbqfCcEo6aiHYd6DCiI9zX3jOdMMnUOF7IfZIHLJDjK2LlJeKtXIkKbmZCCzitBJnjk4XoFwcW/B4TXVHRH33ouwDGCbQ/5W1zd6cfTvNFqIdDRZ5J7HuZN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110732; c=relaxed/simple;
	bh=pEMpv2mCrTIHaDGvsx61QzAW2LBgE2EwFt/YekNzMo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dk1q3sngI+AxdIADOHZhLwEAAmQZvJIT06mDagSniGw9OlzyTH39APjNopmjawk8z7pRTAL6k2MGdOPSoqa2g782krNqZJluTW4lqCi+yFdafZB/SFIhU5IR9NfqzJKjWwUBXi54IZSJ7N87QILdTC7QvokoR4vzQKC8jnHuM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pid6Nw3o; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732110731; x=1763646731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEMpv2mCrTIHaDGvsx61QzAW2LBgE2EwFt/YekNzMo4=;
  b=pid6Nw3oodtRJ9vo9mD3Z4DpUzESmJ4C9/eBqmYGjZWONeLgur0gT+ub
   fjGgcLoKlb5zPv3UCP6iz5T/TJTSE40GdUBuRulJ/roqkq6X4f/aWQvLr
   3EPlP4utoPeQUfd6jkaWI9Z60uWTa9SpwkDSzI5yjsb3rw2GkugFrfeai
   VqmKMemnJ2oGhla9JOWGj7CJLdKBJYns9+7adpnAPqjAaAhDaOZG0eIIV
   NQ7O1SVd9DLgEscB/rfNvze+Q+617Oy+xboJaP5kYdwNhn3RQAzM8q08o
   RmRNyAGniJq2BUMDvdyIynHWEO28izUHP9Ab88p3bCgxlKyhScWrUEFMG
   Q==;
X-CSE-ConnectionGUID: WBCiSaUmTIiOsb/Y4ShUkw==
X-CSE-MsgGUID: /CT4PeVzTD27tUCTfZ3vIg==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="34563298"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 06:52:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 06:52:06 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Nov 2024 06:51:56 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>
Subject: [PATCH net 1/2] net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes 0
Date: Wed, 20 Nov 2024 19:21:41 +0530
Message-ID: <20241120135142.586845-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
References: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
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


