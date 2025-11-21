Return-Path: <netdev+bounces-240673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1939C7788D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A0BD12CB40
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294702FE58C;
	Fri, 21 Nov 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vfYnPQj1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695492FE59F;
	Fri, 21 Nov 2025 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705704; cv=none; b=eK5uwfnl/J31+8PYlkhBkvJBuUAP0UvB7BcMOpQFCadpmdnbqKbKFTbYn97mgmkRajGYtalYlMWW77wPIchNB1JJ4kR4i8kCWWRLq2sKJx71qIT3n1QAN1O02HRa7uXsfMNod1bAec/x67EOLSLT87a7fe8+2cJdwaaTEfMFI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705704; c=relaxed/simple;
	bh=2E+PlPIMJlUFzlq+Ad5uxJAJFvt3j/JD5Aph1y8h4Ys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CarrUOqoue+nFae2ZSb2JCHYJajnI7fiSrOyIcnbsBQJmaCWG45C2LPDA0miI37WlR6985114X27L8A8s2db/ymwEmxzLh4zZ3zVTgdj/Ndai0fud4gdDLwmDjF/A9j+664N3FqfyC7TJzwvTT5VtZYpRjmES6SIJ2wf3cjJoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vfYnPQj1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763705701; x=1795241701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2E+PlPIMJlUFzlq+Ad5uxJAJFvt3j/JD5Aph1y8h4Ys=;
  b=vfYnPQj13hDt6e2kY04FxtLAza6d6+QqCv6ZCAXnFo1XSLcoTyZLeYVH
   0o9PaJYFaCSZlbzPvBv9yb9fRovc8mPb+pc3BP3LHFUmrh+cM/FVdZMvo
   aB6xO6y09AUIfmlWsmDUTG5e8Ht7R3hBp5vxl/DDAt9Oy5Tln068ned6F
   AvMyNaKBOvOfDeYLzRGq80t2oTARVaerm4TGFylpPdyqhYNuFkhTrKYuo
   pzJEqxOKDUCjPXhG5ASsTyxC75XvTaZy9T1qOHadiehpMqktn6LCFfCOU
   U4oP7faB7ynPwYqi1/DRA2h1QZbaFbfiDBx4sgSA5vET+7t6ORa3A5dW0
   w==;
X-CSE-ConnectionGUID: dFfjss4gRLuOCgpFmSYcog==
X-CSE-MsgGUID: or3OLPtgSmy4UO1s56WH2A==
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="280855884"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2025 23:15:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 20 Nov 2025 23:14:26 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 20 Nov 2025 23:14:24 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v3] net: lan966x: Fix the initialization of taprio
Date: Fri, 21 Nov 2025 07:14:11 +0100
Message-ID: <20251121061411.810571-1-horatiu.vultur@microchip.com>
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
v2-v3:
- start to use the define

v1->v2:
- add define for system clock and calculate the period in picoseconds
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index b4377b8613c3a..8c40db90ee8f6 100644
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
+	return PICO / LAN9X66_CLOCK_RATE;
 }
-- 
2.34.1


