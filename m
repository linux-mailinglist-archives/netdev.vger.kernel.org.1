Return-Path: <netdev+bounces-206782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0AEB04597
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234CB1A62978
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A43265623;
	Mon, 14 Jul 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZT6AMF6E"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF60263C92;
	Mon, 14 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511035; cv=none; b=H+DxjTb4qUkNw3DtSiWF4OucB5R+YRLvsBZawY20mUsv80+XvO5Az+jyVWCFzgHBx88MLfXuZhVD0awu6lslmNuHpP2yBvJifujfo8IAhE3pMrC2uOXn+p+hTIKXijFI3XdAfKdWuf94p+r4PgLQV9jMLz2vo7z62T70Al+k9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511035; c=relaxed/simple;
	bh=5pPrl6QKhmk/QD+ET8LzO0pObwgIOomGvZko72FMz4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+qXcV4W0XjHHBycz2w1n/o+Oigt7gCU1glkrHFhVQBtaIYEj4UHGrnZf7MhNCkfD9Vrb3VCpbrYdXgpiQbGT50Hb+QQrpU4aHSe6SedZP/OhWTGokTbbFslNkXetSkNLTszku0SwRKZs1iqCMetLqAScNcRObFlOjKdMxinvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZT6AMF6E; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752511033; x=1784047033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pPrl6QKhmk/QD+ET8LzO0pObwgIOomGvZko72FMz4U=;
  b=ZT6AMF6EoPQ0gZlATlsJujp40PXPo5zxb1QpS44jyj1UDxFwycrY3Wkx
   fMTh8QETWnxt25aNBWSh2P0wJFTqhIMcvpZ6MvSV/IAyNIMy/d0nrqzFI
   0SwcIcOU/P1PzfAeEErRCAPmuHAAW3zmj7HNzZWA53qrfNm9LI8x2x77g
   OGlvJmEuwlUvUTFTHr1EX1SHDnGZjX8xIN6CASjxlqplVX/AdZrW16sVb
   MibhHd3q1DhtG2YL6Ghb2nYgnFlMRv3eYOFHCf1Q4bdvmwliI5f9tVEMN
   5qOL4v4yXJOoBqm2/VgX/RqIyik9LALv8gOSNPQqsqvoeywk3sFvY2x+B
   Q==;
X-CSE-ConnectionGUID: hBq1ljEWSkqL674rDMJkcA==
X-CSE-MsgGUID: gp9RKsQNQa2rPkZIUjTdvA==
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="211399328"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 09:37:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Jul 2025 09:36:28 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Jul 2025 09:36:28 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 4/5] net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag
Date: Mon, 14 Jul 2025 09:37:02 -0700
Message-ID: <1e7a8c324526f631f279925aa8a6aa937d55c796.1752510727.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752510727.git.Ryan.Wanner@microchip.com>
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Remove USARIO_CLKEN flag since this is now a device tree argument and
not fixed to the SoC.

This will instead be selected by the "cdns,refclk-ext"
device tree property.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 51667263c01d..cd54e4065690 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5113,8 +5113,7 @@ static const struct macb_config sama7g5_gem_config = {
 
 static const struct macb_config sama7g5_emac_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
-		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.43.0


