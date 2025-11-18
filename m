Return-Path: <netdev+bounces-239382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E3C674DF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB3EA3570C2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3826738B;
	Tue, 18 Nov 2025 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nd5GuK5P"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BC71F4CA9;
	Tue, 18 Nov 2025 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442020; cv=none; b=JWl+oBadRQXc+037IUuceBn6xh2pOeIDa6gjSNPYgVBPxIBAnrRIETi3Vgg/DKn0H7p6Vqq/Vvc1bDw1cXe16n1+HsBqnZhaQvHAMGn5Ad7NPq2tGmxFvzT+bdIgEi3YO/dmfUt+4Pmbs3q9Zi3ld4KhacMjlIInF1yD9Qxitr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442020; c=relaxed/simple;
	bh=9u6G1uRxPermdv4TCk/mWsUbTEfeHI/uhloFW7LMPPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsVnNDZCFT0e6ZPilq8D5y7G9yEV9kvWE7olYBuSRmFzaNA0png5U+j5OaRyJDGJTZabU1p1YnB/a3mXOpTLrO8jIEb9zUvdeDYG5wqGzv/qYO/Nn/lY3AaaAiaVS5orwyPBOS81IHiJ5va6Twz9TSe6L22LFemrkTwPBY7rAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nd5GuK5P; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763442019; x=1794978019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9u6G1uRxPermdv4TCk/mWsUbTEfeHI/uhloFW7LMPPQ=;
  b=nd5GuK5Pw7prXjZM8BqJcRwYXKdIIldwd1m4hc3VeBEf/YIcRjaYC+JA
   41YI1MqZ5PvekWA3X3W+/Ftg03OZdmNAeevq8InmaZkGDe5dA7ASnHV3U
   w4taYd1FjIhopVV9oBSYNqNHChf+uJXPutr1DmVVvZleyrvfjJipgMHuw
   7FaF+PmD1vMsdeV9Kjok6CUBP3IFhFIBVd/I3TdKbp8YJGDDxHsScvXCa
   69ADnVazKMjZbMURN47tSSAZbjnaJuVjDrwqWhR2FO+QsOS1kjQG+Z371
   ZgHbrMseIqg+z081kLxk+79YBh4xSJEaaEROncZwBwfD0tB1pLNY6EAYC
   w==;
X-CSE-ConnectionGUID: 4R7ydPrJSk+JBSrkNRlplw==
X-CSE-MsgGUID: /bjX7wJVQ1yZ0fpsrDD0dg==
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="55790470"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2025 22:00:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Nov 2025 22:00:02 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Nov 2025 21:59:58 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 2/2] net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs
Date: Tue, 18 Nov 2025 10:29:46 +0530
Message-ID: <20251118045946.31825-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118045946.31825-1-parthiban.veerasooran@microchip.com>
References: <20251118045946.31825-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for Signal Quality Index (SQI) reporting in the
Microchip T1S PHY driver for LAN867x Rev.D0 (OATC14-compliant) PHYs.

This patch registers the following callbacks in the microchip_t1s driver
structure:

- .get_sqi      - returns the current SQI value
- .get_sqi_max  - returns the maximum SQI value

This enables ethtool to report the SQI value for LAN867x Rev.D0 PHYs.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 5a0a66778977..e601d56b2507 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -575,6 +575,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_status    = genphy_c45_plca_get_status,
 		.cable_test_start   = genphy_c45_oatc14_cable_test_start,
 		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
+		.get_sqi            = genphy_c45_oatc14_get_sqi,
+		.get_sqi_max        = genphy_c45_oatc14_get_sqi_max,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
-- 
2.34.1


