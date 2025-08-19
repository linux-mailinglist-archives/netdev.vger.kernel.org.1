Return-Path: <netdev+bounces-215010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DBB2C9D5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25216168B7E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B542580F3;
	Tue, 19 Aug 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ug74YUG8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D2246332;
	Tue, 19 Aug 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621152; cv=none; b=X+fSunMt0qBnM3Iv2UcppaBwA6jDzK6YjSZvvYtUyuYZCJUk48QBSBz/3gVInJ15YNcr4WPwiGJQgWGrmRu2M+OVs5OYFD83UODnv7yYGfZGI8lKh74EIalFhzgHcb4wrI8Qk1zW4tPZLLgg/hdlkTLh7JCnB35h13MKEBEkRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621152; c=relaxed/simple;
	bh=MQnDmrXiyua8kPUq8gr/FxtUPRZGgcWnr5iZgi75NiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fow3gPcVbIbiuTVujK8IeL+WANABDVPDfOljIeBxWzm9OuAK2R4mejuYyQHOqpdWLhyK+5Fze0LFfO5vcGxK5/rUrvvbsaF+JW3hzUyzVTTLsXFoAgRUfySfF9phH6muoNx6ddwgO70IyI0Nnnq1Yy91cbJX72nQh5BBdRMBt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ug74YUG8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755621151; x=1787157151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQnDmrXiyua8kPUq8gr/FxtUPRZGgcWnr5iZgi75NiY=;
  b=Ug74YUG8V8oti3wzlnlggiAV7vCCRcKlDhMMsQxp2y4+4xc6s9+wFwwe
   FLV9lnwXs67Gfi39YotIQoL/Fb0pFGgHSLrbOtN2MD88X9cohSPrzwLys
   t0+pDBI1dwBTA7w0ZT/aZbbxdIESjlnm4HbTX+dYb0jueXgFFpd3b8dx4
   f3EMmH4XuRtXO8ErwiBdBbbs/JTo/OLJ/RlWXCHDs6hOiZjEFonyTeRLe
   isksDy7FKUHjXyJg9ifUvJnC8IOzJ6ZGMF/NJ2uVtazoFerR9RctIseFO
   dKHgahdLIJKlX3j41TJCdUg/n+XawsV088PG7KLmxj5eOMFO9qV68suuN
   g==;
X-CSE-ConnectionGUID: NyzeezATTkm1HJH7itjXdw==
X-CSE-MsgGUID: 2oKNj41hQOepDe6zqWRjqA==
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="45382213"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2025 09:32:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 19 Aug 2025 09:31:49 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 19 Aug 2025 09:31:49 -0700
From: <Ryan.Wanner@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH] Revert "net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag"
Date: Tue, 19 Aug 2025 09:32:30 -0700
Message-ID: <20250819163236.100680-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This reverts commit db400061b5e7cc55f9b4dd15443e9838964119ea.

This commit can cause a Devicetree ABI break for older DTS files that rely this
flag for RMII configuration. Adding this back in ensures that the older
DTBs will not break.

Fixes: db400061b5e7 ("net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag")
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce95fad8cedd..9693f0289435 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5113,7 +5113,8 @@ static const struct macb_config sama7g5_gem_config = {
 
 static const struct macb_config sama7g5_emac_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
-		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
+		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.43.0


