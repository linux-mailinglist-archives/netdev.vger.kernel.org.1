Return-Path: <netdev+bounces-209181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17609B0E8A1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B74E3A4670
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF120B1E8;
	Wed, 23 Jul 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R2bBWHZ4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9BD1F461A;
	Wed, 23 Jul 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237610; cv=none; b=DiyQEGkme9gvgvJ2CQrO8bjtx1rCFsO+LFH9dIv/WW5ZMoftTiNct+aC62GztWEYEiDpV8KQAlX2Rx+OO0lg/powdySyq92yVYLtdtajPrGgqVFSowcOXFkFhORvce7KlLiS13vtO6uWYaCnX0bfZ04MbjH8yohQnAs399N/kTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237610; c=relaxed/simple;
	bh=KV62NoXC9aWiyFqUrd583Tuwhbt7qTYtiziCYEan+zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7yQ2R0M0FVAzzH4GeK6GBQZIbJpjSr3Bu2JnY0+15Bi+iMkMl1UT7xcIAoxs5ClrmjcZJeLEF3QT8pLBkO/ckXlD/4OIm5eeVTM9dDX7nuPJo6yUqXKEuIyYme6juL1LWzqcflm/BCljPJA/pRxMUCw7DyRrbMVW9Dmvrk74B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R2bBWHZ4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753237609; x=1784773609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KV62NoXC9aWiyFqUrd583Tuwhbt7qTYtiziCYEan+zg=;
  b=R2bBWHZ4sBaSIZ9xdbwQ9OsDDzKpwELCTGoPQgYY6qwC063Wtm5c439M
   9dlAxPfOaO/+oNlWdaglQ+Y+uTf71zCH8zze9q5vmd4hzuQChr2kRNjOn
   q8U1kH12kPJ6OHqhBO1uE3ykq24mWut++k1VwHwDXhvaChfMg1s5rvr+X
   ERUeQzcYI07FDKCUDld4w/ny1VqOO5d7llvbvYs+wj8B+C9CR06BAUY3k
   6FF4PP5GML+5q5mruvoeamKwkOgJ15LTs2RPoIA1nbsrm6p+CoACJ3HZi
   DNcPyrJTLOUg6V3CMwQBO3ecHTrgM4gs8/EwLc8Xl/emzOlGcMAYEWwxt
   Q==;
X-CSE-ConnectionGUID: ol8zE+5pQbyz8nKT026TwA==
X-CSE-MsgGUID: k7HcpH0dTvu2Xe51WtW5JQ==
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="275694689"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2025 19:26:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 22 Jul 2025 19:26:17 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 22 Jul 2025 19:26:16 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon Horman
	<horms@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next v5 6/6] net: dsa: microchip: Disable PTP function of KSZ8463
Date: Tue, 22 Jul 2025 19:26:12 -0700
Message-ID: <20250723022612.38535-7-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723022612.38535-1-Tristram.Ha@microchip.com>
References: <20250723022612.38535-1-Tristram.Ha@microchip.com>
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

Note the PTP driver for KSZ switches does not work for KSZ8463 and is not
activated for it.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 62224426a9bd..c400e1c0369e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1760,6 +1760,17 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 					   KSZ8463_REG_DSP_CTRL_6,
 					   COPPER_RECEIVE_ADJUSTMENT, 0);
 		}
+
+		/* Turn off PTP function as the switch's proprietary way of
+		 * handling timestamp is not supported in current Linux PTP
+		 * stack implementation.
+		 */
+		regmap_update_bits(ksz_regmap_16(dev),
+				   KSZ8463_PTP_MSG_CONF1,
+				   PTP_ENABLE, 0);
+		regmap_update_bits(ksz_regmap_16(dev),
+				   KSZ8463_PTP_CLK_CTRL,
+				   PTP_CLK_ENABLE, 0);
 	}
 }
 
-- 
2.34.1


