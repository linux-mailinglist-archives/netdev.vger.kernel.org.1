Return-Path: <netdev+bounces-199569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F668AE0BAB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAB74A2276
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2E25D527;
	Thu, 19 Jun 2025 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q9mwf/mA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9423CB;
	Thu, 19 Jun 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352655; cv=none; b=VifzNk7d5Ixi+W/lQXqek4j4YDLTb4BmB2vmHmw7ru2oenW1eN/0fgooMkGwQ5kuOw90QUxspa1UHvCB3Tgx2DjX0e9rrmDwTpI254/d1oHxcZGewhV/aLNQKQtsq+qpha/pKTf/vSETwlODb3E2VTf91zT+/TdE1jHrvh4bpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352655; c=relaxed/simple;
	bh=rkue6qCTiyMbLrRxDHpkHGwB6s3jUn/L79o500WV5/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jdt7vvFx2vgbfs7lpxJQQ9wD0yjRoH1myMQ3HHJDc+/jnbrXVL088K/+x5C6yQ6dpACZ8Cp2r2y7TbmS4doAU5TrVALRpHpohK8uH9swsE3byzVo06UtJjFm3Fmec7mKQCxYabBo/uy6KZE5FIC5UCe46+umBVbh2D9xrlK3GFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q9mwf/mA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750352654; x=1781888654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkue6qCTiyMbLrRxDHpkHGwB6s3jUn/L79o500WV5/g=;
  b=Q9mwf/mA43eLiJlmm18GguPl9owTTyyQTWa8MYIQogeExEbtZsI/nQdx
   pUYNHWN3yQmuLGwRnFyR/7VmWqLsZWdyPaqHvAivyxLXgbMDdQzr75emp
   M97ADUD5ESzP8UoOH1LUOH4q7+mEvKRgXW1qAnOXVuyPLNvC+HGIWynYI
   OzSXcZp6l2IhW+cbjJUfN1xZDhQ3I+8lkP1p/KHV/JVmnAkc4uZZWYTkp
   M8+A3+70EPl8SKr46meKdQ3dKfAH7PhRLAS9ffpV9T/HT2TW/8bEj1chD
   S46cHzjGyjDYdtl03T4APrduGJ9VCENsE5/brXWnoCc1E4iZj7yXoQno7
   w==;
X-CSE-ConnectionGUID: gIxPXZ7kQ0e0IzwdxhfIcw==
X-CSE-MsgGUID: /TXATMiURlqyR2BrkjcObg==
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="48040283"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 10:04:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Jun 2025 10:04:02 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 19 Jun 2025 10:04:02 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 3/3] net: cadence: macb: Enable RMII for SAMA7 gem
Date: Thu, 19 Jun 2025 10:04:15 -0700
Message-ID: <0d56e0bd0cb32d1d9ff2c5674f66986251db5e40.1750346271.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750346271.git.Ryan.Wanner@microchip.com>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This macro enables the RMII mode bit in the USRIO register when RMII
mode is requested.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 146e532543a1..f4f922915ade 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5101,6 +5101,7 @@ static const struct macb_config mpfs_config = {
 
 static const struct macb_config sama7g5_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
+		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
 		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
-- 
2.43.0


