Return-Path: <netdev+bounces-118692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181ED9527DE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958FEB22FE7
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768924211;
	Thu, 15 Aug 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Aqr75KkU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96210A0E;
	Thu, 15 Aug 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723688428; cv=none; b=KQ7jog7TRK8fLo7PghcMgfBDZWMKInF/C3dCmuE7mFQPNJzdK+kRi+dlr8I0gTuUXQYnbomFPHrtD0oWkEgseGM3DNmYPlf9XS1c6BC+vHFAAuHXFH23czBGvENuScdI9+emkReA9bbnwXzm9VLFna5wgEKs89J7IdS7uVqOj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723688428; c=relaxed/simple;
	bh=KrZZlnwEMNo01OSBuaNOMdmh5g0RYSfFonimGE6zWpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjGXnRk8akzaVoCiHjp6UaIjAGv+P049rAu34vOy4FqhpBkbZNU8jkbZym24t1uP/yJqaAC9gsGEkodUELlh2650tNlcNL0DuKs6o7ySbg9EYeEkcnwo7u1UNoKDAILsaIH1jCaPPtvlW7eUxnIxgVVUIKjKwe9hRtz7uPKVMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Aqr75KkU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723688426; x=1755224426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrZZlnwEMNo01OSBuaNOMdmh5g0RYSfFonimGE6zWpU=;
  b=Aqr75KkUa8SwqUGZf82vD2QUF0aPRdDJD+YwXLNPf1PDw6EvnjDemv8o
   kdwpUAzKeHcmwskCvQKINmORX7VESCn0E6P09+8qECqSldsuSVeWjOIyY
   Oft1cHo/ht+P3lmy/BLw0a5+vbKxzwoqx8XHob+N/3hvpoVWsYvXoBFSG
   75ZQO6YZYaVNqrFecwJ7e/z4PLI8k49Eqb6zCHEJN1oEJeAvbHVjc3Aib
   TEGhayle867DaZQoHJuv44z6Zo29LaUDIxiir8KUaeWTgut2vqfeJKRe7
   eZHyI1ZcJKZBhzF65CeGk8I2JIFgQ35DPv03c4sicpap2voh4D7pg7TKy
   w==;
X-CSE-ConnectionGUID: TLKY8qnjRuKJglbogpyTvw==
X-CSE-MsgGUID: uZda1idCTnKci1ZDeFbynw==
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="30473036"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 19:20:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 19:20:13 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 14 Aug 2024 19:20:13 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut
	<marex@denx.de>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Tristram Ha <tristram.ha@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v4 1/2] dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Wed, 14 Aug 2024 19:20:13 -0700
Message-ID: <20240815022014.55275-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815022014.55275-1-Tristram.Ha@microchip.com>
References: <20240815022014.55275-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after
KSZ8863, so it shares some registers and functions in those switches.
KSZ8895 has 5 ports and so is more similar to KSZ8795.

KSZ8864 is a 4-port version of KSZ8895.  The first port is removed
while port 5 remains as a host port.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..26a7da0cc0ce 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -22,7 +22,9 @@ properties:
       - microchip,ksz8794
       - microchip,ksz8795
       - microchip,ksz8863
+      - microchip,ksz8864  # 4-port version of KSZ8895 family switch
       - microchip,ksz8873
+      - microchip,ksz8895  # 5-port version of KSZ8895 family switch
       - microchip,ksz9477
       - microchip,ksz9897
       - microchip,ksz9896
-- 
2.34.1


