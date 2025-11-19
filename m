Return-Path: <netdev+bounces-240101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6EC70834
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA533344A4E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16708327C0E;
	Wed, 19 Nov 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WSeaeorj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB862366DA0;
	Wed, 19 Nov 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573392; cv=none; b=aKbrDjW8rTT45pzPx5pkX6G+m+mVimJXPbDhkZNLPrVq93q+5ozIt4dhrHLoreRtXdw8RQaPM97gsliraU3GzV1sqTBq4cbYbaEp9dJN2MMJb4yZfALeyoHWbVirTbiqNgWY7Wv56d6wvUIAPOEQc1vDYHj4JuR+AemVN8ogd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573392; c=relaxed/simple;
	bh=AAhInjK0hV7inLiITcWEDEw5AyGHlBIp5m8Q6XZHpPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ueNdC2fhC5rJxG4vdC7XOb+zOckhqBLMzqWETLPjN3DaD6GuIZTUGqhj6VAcVZRWF03xx5iPOUAxYuiGOA1Oe33zZ+7QnrZl5hWgTAmbVj8xsnyG97Kd0Ts+kyhGlVu/fr55lWxGlCsVCtbyyHAYscj31amHY0XBvvXqC6ja5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WSeaeorj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763573390; x=1795109390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AAhInjK0hV7inLiITcWEDEw5AyGHlBIp5m8Q6XZHpPM=;
  b=WSeaeorjxU0zt/BfY7uqjLKgG5tsFITlT/Fa7Bodnr698dxf90wUGJsS
   ZJemycQQv67aM2Ix91lwn2yysV8UfxwXHmRgXEpkUmVDPUA3FfZUrDUy9
   g0R4mgCzOkAgsiRH5gCntfyHgCPLVi9cW563AKKu+4nyzA2AMXnLPwhaJ
   lvTtkjf0kC7p/SJN99AJCyiMLFshpkZoYs4TpOCG7EXN3LabKklPIqEmu
   bk5AeErAvgm9jALelct2JTi7CHTIpO8ltjcsKuJbmA+1YUCry+tLLCH8l
   igdIe/5jZl3gFjLMbvwxo+EW80mh7bgsKITXC2VD7q1pbENTt2GSp/Hz3
   A==;
X-CSE-ConnectionGUID: X5qVgr6yQDyAe5PvHREMHg==
X-CSE-MsgGUID: B3WnMsxrS5O9HsUuXdhCUA==
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="49869025"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 10:29:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 19 Nov 2025 10:28:58 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 19 Nov 2025 10:28:57 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2] net: lan966x: Fix the initialization of taprio
Date: Wed, 19 Nov 2025 18:28:45 +0100
Message-ID: <20251119172845.430730-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To initialize the taprio block in lan966x, it is required to configure
the register REVISIT_DLY. The purpose of this register is to set the
delay before revisit the next gate and the value of this register depends
on the system clock. The problem is that the we calculated wrong the value
of the system clock period in picoseconds. The actual system clock is
~165.617754MHZ and this correspond to a period of 6038 pico seconds and
not 15125 as currently set.

Fixes: e462b2717380b4 ("net: lan966x: Add offload support for taprio")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

---
v1->v2:
- add define for system clock and calculate the period in picoseconds
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index b4377b8613c3a..18fab2d4bda0d 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/ptp_classify.h>
+#include <linux/units.h>
 
 #include "lan966x_main.h"
 #include "vcap_api.h"
 #include "vcap_api_client.h"
 
+#define LAN9X66_CLOCK_RATE	165617754
+
 #define LAN966X_MAX_PTP_ID	512
 
 /* Represents 1ppm adjustment in 2^59 format with 6.037735849ns as reference
@@ -1126,5 +1129,5 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
 u32 lan966x_ptp_get_period_ps(void)
 {
 	/* This represents the system clock period in picoseconds */
-	return 15125;
+	return PICO / 165617754;
 }
-- 
2.34.1


