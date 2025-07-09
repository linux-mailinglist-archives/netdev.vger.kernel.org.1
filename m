Return-Path: <netdev+bounces-205204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CDDAFDC72
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5B15A0318
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C01DA617;
	Wed,  9 Jul 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H1cE1CVH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEAA1A00FA;
	Wed,  9 Jul 2025 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021194; cv=none; b=DhATOIqpNzRR7yl1xKnjIBZIRUhuH4+zu3UJImk8pxXcLwiMKhrD2uvdONhAnTFN7k/SuHwWRJxkjJ6a8oE2rIDMvChVneNbuluiHW3A6YE1prqZ83lZKrVSdHMlwpuRUjO0WezRRMSHhlTew8qOLOM+UVDdFlo9cz3GpVqFTxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021194; c=relaxed/simple;
	bh=R8Z7zT8+Eo5ToVWBGmOnfHkf7yV6oU3nOi/6vXFWB7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vA9H6S7kodKRO0RJGkLFA6KYwgkFYJXrHuaors4dYXOC9vwjCJpXcaMNIvyqh5sm+puFUbRH8U6yyXncoonDp/aMVy0EMVgAGkVtysCYILKzH8pFgYF+q7dZEoO1shKfRmDWYizSAUn+yQhW+FVDstQcl/3XAzwm5nAWt4UK4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H1cE1CVH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752021192; x=1783557192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R8Z7zT8+Eo5ToVWBGmOnfHkf7yV6oU3nOi/6vXFWB7Y=;
  b=H1cE1CVHM67JrGXoLFQAvdpq1NM1QrzA8+aOn1OuL7z9Bu8kgXjtdVNA
   tk75jOumhRM5ymAhDyRSFLDOngu4wGWKQcModLo2Fqk7ceWUyzrxpu3Za
   SvINuUl+BAJqe7IakqMtePJ/35w0FCf9Lp8//cEh72PzvRp4mYzkdRQNC
   SUzkgwE92IdIomTJ0VOZM9Ryt4e2CRaPNzHMLA2HfqPmainRGEV1DGSQy
   Ldtw3gmmyqzgPM2OCQ+wBx/kHLvX8Gs3eorkf4P0j78Q+eutBu3XJXXP6
   hm453OMoGfNq9vKQqY0ImJUv/tWCVKBqMYw1tnAYdU1yfTPt0Eht1l8Db
   A==;
X-CSE-ConnectionGUID: CSUfBCd3SzyYJ8hslua0Vg==
X-CSE-MsgGUID: +/AFQHjZQGOH46rjorNzYA==
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="211198520"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2025 17:33:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Jul 2025 17:32:38 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 8 Jul 2025 17:32:38 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP function of KSZ8463
Date: Tue, 8 Jul 2025 17:32:33 -0700
Message-ID: <20250709003234.50088-8-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709003234.50088-1-Tristram.Ha@microchip.com>
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The PTP function of KSZ8463 is on by default.  However, its proprietary
way of storing timestamp directly in a reserved field inside the PTP
message header is not suitable for use with the current Linux PTP stack
implementation.  It is necessary to disable the PTP function to not
interfere the normal operation of the MAC.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index ddbd05c44ce5..fd4a000487d6 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1761,6 +1761,17 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 					   reg16(dev, KSZ8463_REG_DSP_CTRL_6),
 					   COPPER_RECEIVE_ADJUSTMENT, 0);
 		}
+
+		/* Turn off PTP function as the switch's proprietary way of
+		 * handling timestamp is not supported in current Linux PTP
+		 * stack implementation.
+		 */
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_MSG_CONF1),
+				   PTP_ENABLE, 0);
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_CLK_CTRL),
+				   PTP_CLK_ENABLE, 0);
 	}
 }
 
-- 
2.34.1


