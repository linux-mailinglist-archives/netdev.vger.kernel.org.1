Return-Path: <netdev+bounces-205196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C132AFDC5B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD51C2027C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B74317D;
	Wed,  9 Jul 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UcWMJQA5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E2EEBD;
	Wed,  9 Jul 2025 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021185; cv=none; b=jRa9XBRWpVBMhaZgpCq0gF8evBNESgGpRn2ziMoSmt8Y2gI4fT4bYDdUi4pz+unJXUE5FAPvJxE/XMQMIlSag9vQdrec8c7379lbdFG49j41R0vju+wzDEm0mDdFl4jXzRr0kUrrfhx/bsifq+Lq6THoUJXA90/inT3gmlkTnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021185; c=relaxed/simple;
	bh=nbHCZnjrkstbidgrzhyUGpiUbbGUAR3CtOOXEtfl+NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6d6Cg62p0NDQszl4lkQavvuYYOLtWNlSKKdMjM6ydypvIT24e6+VSWBtZ43M3UuSekBqR4khMZTyYnqZvoig2lxhK6f/Tpz+VBqSYZI5Y9TBLCgRs/3h2viM8CAMtKwEWRkHUB1X5f1lH4hJlx3WyegOO0LRbgNEtIYcXcOTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UcWMJQA5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752021184; x=1783557184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbHCZnjrkstbidgrzhyUGpiUbbGUAR3CtOOXEtfl+NM=;
  b=UcWMJQA5vYO0/MkGZwBCSn1luMcwJbNl0eJWur1uioR52OMZTsWQ6fq6
   0siUBnjHeb4h72fYuGcQugJxC8WHccKyxwURKM5bFthzPalqQ4gkMEM3f
   Mf9KIBNxhEoV0n43u5iSTBGUmVF5MLk1mfPZIDRoXJTw32JaTMRLJA9XP
   +wtYNlVButGGAJUC0lx0f8F0yoxdvja1HzSEyqlekxbw+etXHg+lhX5Dj
   kFW0TuNXdUjolh1cY8qIVNopDslg5D2RksSugdFVDS3gAFsU56TP6lRvb
   yBixsJeEvWrrB8lsH2/S1Dyj3peKfJNxCgAMQDETTjBWh61YRV6Wnhlld
   A==;
X-CSE-ConnectionGUID: 6Mp8GMV4SjKiBLDMr7TPXA==
X-CSE-MsgGUID: iuU4nyynSnqR9E2xm2jrQg==
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="44354046"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2025 17:32:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Jul 2025 17:32:34 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 8 Jul 2025 17:32:34 -0700
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
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v3 1/7] dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
Date: Tue, 8 Jul 2025 17:32:27 -0700
Message-ID: <20250709003234.50088-2-Tristram.Ha@microchip.com>
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

KSZ8463 switch is a 3-port switch based from KSZ8863.  Its register
access is significantly different from the other KSZ SPI switches.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 62ca63e8a26f..eb4607460db7 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -18,6 +18,7 @@ properties:
   # required and optional properties.
   compatible:
     enum:
+      - microchip,ksz8463
       - microchip,ksz8765
       - microchip,ksz8794
       - microchip,ksz8795
-- 
2.34.1


