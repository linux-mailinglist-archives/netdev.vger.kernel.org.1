Return-Path: <netdev+bounces-199572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32356AE0BB3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD854A2778
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2452B28BA81;
	Thu, 19 Jun 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qo0+a+CC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E85275B08;
	Thu, 19 Jun 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352707; cv=none; b=AYFHlCkye0I3bcBoJhENmg1RD/RIQY8fLrFQDu/uHVAXHc4qSslO+Vi9VRJC/gBAionXfObtBFopUfahig+MO1Qi43hh2WWQ1UIf76OrAX4FBrMmW9TEFVrI4bKW27WFJ60956c8WqvXXy+COXaxGlFosR6/ijjcj8bhWVwxrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352707; c=relaxed/simple;
	bh=ZjMY4Fa96m+s23sE8OnwzE3fdgUKcaNsPpnljTmbXxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjxTdT13/PQ6jxJDJKfP92/WgDDgzEkARe9Mwgx+cxiaCZJYguoz4iXLO2prPf1FU11N914qHrrTuKVsFei3EN4CuQDKZnD6fZPsT0TPe86Nj848mexTRXMg3AD4v5PZ+c5tWKT2VFquJ/XCWwj511VhZE+TghZYfi6ucVrwyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qo0+a+CC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750352705; x=1781888705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZjMY4Fa96m+s23sE8OnwzE3fdgUKcaNsPpnljTmbXxQ=;
  b=qo0+a+CChQFUfB0ZG6oFjgk0wFAt5Pd8ZLazVDvmFvvGCj3IFOPCrV3G
   y26XKvQKtSbrJpD3HIjxF6V74qD5OgCvBSQ7pYlvpWHgB4ov59UUkiYPg
   LKoGs/Wejbf3c6cKS2zwUXqKQqzQ495jj/t1zjfqpaRyxkzzJJ5HeV0CX
   f9Hb/ngofo33gGCSV95K6atw0vWjjl1c+O8AHcBl9swfUVana7r8V+o/t
   5qGMLcS5/2egpC/KqI8oCOzNn7h3z5ubPrYypd3aA5fXvIWFGFYhxV3If
   mufc8u6WrPr8075vSCardb7tbJwFQTqYpchhyWdnQp1NHfaOMCZFxSbOG
   Q==;
X-CSE-ConnectionGUID: sSReNXTdTRmYjwcJmlGBZA==
X-CSE-MsgGUID: BhLU5CLySg2t/vGmvgLpEg==
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="42526388"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 10:05:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Jun 2025 10:04:02 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 19 Jun 2025 10:04:02 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 1/3] dt-bindings: net: cdns,macb: Add external REFCLK property
Date: Thu, 19 Jun 2025 10:04:13 -0700
Message-ID: <7f9c7308e404a6bcebdc8cc65ccf188dde435924.1750346271.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750346271.git.Ryan.Wanner@microchip.com>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

REFCLK can be provided by an external source so this should be exposed
by a DT property. The REFCLK is used for RMII and in some SoCs that use
this driver the RGMII 125MHz clk can also be provided by an external
source.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 8d69846b2e09..e69f60c37793 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -114,6 +114,13 @@ properties:
   power-domains:
     maxItems: 1
 
+  cdns,refclk-ext:
+    type: boolean
+    description:
+      This selects if the REFCLK for RMII is provided by an external source.
+      For RGMII mode this selects if the 125MHz REF clock is provided by an external
+      source.
+
   cdns,rx-watermark:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.43.0


