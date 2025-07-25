Return-Path: <netdev+bounces-209918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57019B1151A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F86177C90
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCD772614;
	Fri, 25 Jul 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UUh9b93m"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1331096F;
	Fri, 25 Jul 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402685; cv=none; b=ZYT0CuAG5YhUqS0wrs/w3JUBRYu5R6ouOVC4PoLDiatrVpzL5qjXXVzYVJwjkglaeoSM2VsHOmjxAD4qDYvlB4RAoYemf/K2NPN/qP+dkCsN13uVF1u4Asf9Ph674Fp8puogSIS82uKLgzUxv7sJpvsQI6fQJqZsMlAFvBhmVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402685; c=relaxed/simple;
	bh=nbHCZnjrkstbidgrzhyUGpiUbbGUAR3CtOOXEtfl+NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seges9cg5eBNuEph5RkWs85WDLdNvaFx0n1dP+Ge/jjQjZFqRogDURtscKiPqVPvYEuef4rXw4w+9vg2XYpX6sybdEpUDmWvVDKpCzwczrIAlQbnVFJWCUkJ6LHbbPKuyd9QGZA4kxEVEp5CEFr+GaBCE4JBc5JMS+KvXjtop5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UUh9b93m; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753402684; x=1784938684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbHCZnjrkstbidgrzhyUGpiUbbGUAR3CtOOXEtfl+NM=;
  b=UUh9b93m+h4046HLPY8Y5Vp9d0CyXS//fTkhPL2FwokjrhEI5To/4BJ9
   cLcALVVRIOIh86TDx9VQopKQTZBP5vct8dBLq6H5ZzQieBI5ToZB7BzJd
   iw0tv5LB5xwBTm0fpZboAAKHbuJT2pGQ5wI+zA1WhX4FLz6MGtvxmBjGx
   KvhjUHY45XG8QhgNtYQGCMsWzNZuqgM6K0QBH/lKlF2MN6gju+OkoKTFC
   Q/UFg6vgU+hTCrd1wtwr1lA0BRhf1ygNcAAp7kjaE+68xxVZYgdxI+MJV
   2ISwUMd5+CD7SsCWX0CHNyvOtOmAJkC5I+am0X8lDH9mWmA8gLWHItFTA
   g==;
X-CSE-ConnectionGUID: eDIQSHZ3TP2otfHW2Moz3Q==
X-CSE-MsgGUID: J0BAtwe1RzCysrZv6NG8sQ==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="49728961"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 17:18:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 17:17:52 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Jul 2025 17:17:51 -0700
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
	<tristram.ha@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v6 1/6] dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
Date: Thu, 24 Jul 2025 17:17:48 -0700
Message-ID: <20250725001753.6330-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725001753.6330-1-Tristram.Ha@microchip.com>
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
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


