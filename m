Return-Path: <netdev+bounces-235433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A5C30772
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737941891909
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA83115B5;
	Tue,  4 Nov 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rwRemfaK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB118D636;
	Tue,  4 Nov 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251643; cv=none; b=tGuaox+KbFnL/pX/Rd9+7AIu15+ccAhkqh68hqKIJVjQ63rx+GO0E756Wqgma6CshPtngkldIc1oAnrJgf49CH2fdsimj3sERak92lSGwAPVuGpDhXm72A9f8hRrrqtyOBKaqe1aSpg3E539EnbCXHoLN7MI709qQExGC22sHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251643; c=relaxed/simple;
	bh=kifZlPCKxYvvqUqvG1gJERfEBvK6kx+T9JxGrCjLHuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZd95+ymVJ8O85YsmkaPnEZchyiBuf4RbXy3Y+JLkKdG+ChfI6873SzEtLoEyg6r23fpHtUjuWwCRqcOGn1qXpy3TxfvpLU6Jv2G2PI8nLIQb9vqPFMfqXeDs0YRXnATQFlAMfR5EJayNrK9id8W269grmduiFJG7iOBEelJ3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rwRemfaK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762251641; x=1793787641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kifZlPCKxYvvqUqvG1gJERfEBvK6kx+T9JxGrCjLHuU=;
  b=rwRemfaK4RoPgS6JYM5cGU7ivpytv/obkvNmBhd3xpxKzEBmq3yrWJk3
   6XJ+woWFYgyA6S7HOZ7ydXNL9ZQItCmx4yKoFKLRjfV0VJQlQEF7n10D1
   Ndr+5EeaCtDmf/nbiRJEsSZBgMvCJy8gEb0nO1S2akrPfUjFBff8XT5OT
   KgrkxViFgGaVTKJ+6YwiCo3bnnc1Auex8HaVqU+dBFZLhoUb1PJtV9iax
   iStpsq5vxdOpHJc117kWO/zfZqI/I7I6bRqIIie/Dqjb8xp22MljH8/hU
   fOONkzDnufr+Ycfr8u2DMszcDuxwp8vipJ1A87aZ0WQwcXZjvmdScNeYU
   A==;
X-CSE-ConnectionGUID: CDUlbOQDQXa1I5jogreq6A==
X-CSE-MsgGUID: MkuJMKMiSpKByVmla/283A==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="49163441"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 03:20:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 03:20:28 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Nov 2025 03:20:25 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 2/2] net: phy: microchip_t1s:: add cable diagnostic support for LAN867x Rev.D0
Date: Tue, 4 Nov 2025 15:50:13 +0530
Message-ID: <20251104102013.63967-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104102013.63967-1-parthiban.veerasooran@microchip.com>
References: <20251104102013.63967-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable Open Alliance TC14 (OATC14) 10Base-T1S cable diagnostic feature
for Microchip LAN867x Rev.D0 PHY by implementing `cable_test_start` and
`cable_test_get_status` using the generic C45 functions. This allows the
`ethtool` utility to perform cable diagnostic tests directly on the PHY,
improving network troubleshooting and maintenance.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index bce5cf087b19..dd3de712c9d4 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -573,6 +573,9 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
+		.cable_test_start   = genphy_c45_oatc14_cable_test_start,
+		.cable_test_get_status =
+					genphy_c45_oatc14_cable_test_get_status,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
-- 
2.34.1


