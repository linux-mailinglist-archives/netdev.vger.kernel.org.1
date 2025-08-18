Return-Path: <netdev+bounces-214449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24FFB2995D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB3E3B8F6D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE06271A9A;
	Mon, 18 Aug 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zt/Qatke"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5212701D9;
	Mon, 18 Aug 2025 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497226; cv=none; b=kIpA2Xi9tZczri+JCzLVF7llhRd7qhaQROSUhVr75hLlQpyZa3lFqHxY7GyjlfYrah1rE3UJYYRgDgbmmfcZZ6xZnIvwweTy07135y1Anju2HR2ZmB26rWnT97GKXcv2UJ5n/7E7w0BJ8dMKUgv8gufaJafwOZsVxmuDHLjnMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497226; c=relaxed/simple;
	bh=60LMWBZfki/TpmSd4O0lqsTWQ+7STTq4cljniGsDTL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSYejhSX/eVA0pLNh1SjMI4MJ+aseid461s3nHzCGGwmh59I3jMGNFJOuHFWElfYOhsKiarmT0MawNhfWsk688Z8JmlzbC8Qmh8+FXqqOe/9PHJreacx1NxDFSnttfCcjee7STHnhHVbwnNVhNSgcfoOD8gq5HRHQVhaHrsAFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zt/Qatke; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755497224; x=1787033224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=60LMWBZfki/TpmSd4O0lqsTWQ+7STTq4cljniGsDTL0=;
  b=zt/Qatkem9DjN9SLUgRc9DUZiT0Pd8f7mP3ugGiPJzUN6DhLQLFRQlAi
   7WplQSLIB5iBBSb+yagVUKrGQ5Dynkx+A9jGQz+J0eLnq6VP/YmtYZm3Q
   lvRYbw3Yv3LVqS4H4rO6/Ky5UoSJ/QJ0LTzooRZgPpIOwWos/6HFKUkky
   rudWv7z2C3fj5Zkif8oQ4DWnINYUdcZWLtTBI/QdA4+aRr0GfIowmvPvF
   6SmtBS8JRVswnVO1ecRucL6j/bYaq7q4JLObIhOJIbhZGLWcqbUMFcP5K
   dbKuiK7y6hEzbIz8IX0xgLtK/waP7PfT8LLw91HrJvHsFQsgh/gU/VGo1
   w==;
X-CSE-ConnectionGUID: jhrJsGctQCiiFoS1UDzbFg==
X-CSE-MsgGUID: uRbV0M5aSj6xH1dRDL9AUg==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="50850433"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2025 23:05:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 17 Aug 2025 23:05:27 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 17 Aug 2025 23:05:24 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net v2 2/2] microchip: lan865x: fix missing Timer Increment config for Rev.B0/B1
Date: Mon, 18 Aug 2025 11:35:14 +0530
Message-ID: <20250818060514.52795-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
References: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fix missing configuration for LAN865x silicon revisions B0 and B1 as per
Microchip Application Note AN1760 (Rev F, June 2024).

The Timer Increment register was not being set, which is required for
accurate timestamping. As per the application note, configure the MAC to
set timestamping at the end of the Start of Frame Delimiter (SFD), and
set the Timer Increment register to 40 ns (corresponding to a 25 MHz
internal clock).

Link: https://www.microchip.com/en-us/application-notes/an1760

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 .../net/ethernet/microchip/lan865x/lan865x.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index d03f5a8de58d..84c41f193561 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -32,6 +32,10 @@
 /* MAC Specific Addr 1 Top Reg */
 #define LAN865X_REG_MAC_H_SADDR1	0x00010023
 
+/* MAC TSU Timer Increment Register */
+#define LAN865X_REG_MAC_TSU_TIMER_INCR		0x00010077
+#define MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS	0x0028
+
 struct lan865x_priv {
 	struct work_struct multicast_work;
 	struct net_device *netdev;
@@ -346,6 +350,21 @@ static int lan865x_probe(struct spi_device *spi)
 		goto free_netdev;
 	}
 
+	/* LAN865x Rev.B0/B1 configuration parameters from AN1760
+	 * As per the Configuration Application Note AN1760 published in the
+	 * link, https://www.microchip.com/en-us/application-notes/an1760
+	 * Revision F (DS60001760G - June 2024), configure the MAC to set time
+	 * stamping at the end of the Start of Frame Delimiter (SFD) and set the
+	 * Timer Increment reg to 40 ns to be used as a 25 MHz internal clock.
+	 */
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_TSU_TIMER_INCR,
+				    MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to config TSU Timer Incr reg: %d\n",
+			ret);
+		goto oa_tc6_exit;
+	}
+
 	/* As per the point s3 in the below errata, SPI receive Ethernet frame
 	 * transfer may halt when starting the next frame in the same data block
 	 * (chunk) as the end of a previous frame. The RFA field should be
-- 
2.34.1


