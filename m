Return-Path: <netdev+bounces-43512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C47D3B4E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D0D2813C1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3AF1C2A0;
	Mon, 23 Oct 2023 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XcEQeZtA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE614291E;
	Mon, 23 Oct 2023 15:48:45 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E2D78;
	Mon, 23 Oct 2023 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076124; x=1729612124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=319+vSZztvLLamoEF3n0o2ZCH6mocDPpJVQBgHHyFrE=;
  b=XcEQeZtA4ReGOaXZ7E4oPLMHZPutMmkwZVYpV1G1lYL+nftrxQNuCDVG
   OmAXV4a3aCqvPEPwiymz2eanSDPemCrOk0ePd2r4+OJ7IM7hsf3l3PGqL
   GkJIDjbpjJIskGkNZtNEGJXZsGYODLjqsz661AvzS05S3SqPcRIVmpOMl
   A5A703lMD1ha+SzWwgbWSUtgws93jVf0i8pHMUuNez0qVinamm/bt0Gbw
   +BOVgDWkrNUiHLaThllVhqQ8+mXw8uOg+/wCJSHmMqAIHVppzAJS/OB7n
   nnj+cgDLB2lnoMp3VZiGPoeG1mQTEAEhVBQjFR5N/FECy1zmHWYVnZuMa
   g==;
X-CSE-ConnectionGUID: 3fgSQoFlQtGqppEDCSfPXA==
X-CSE-MsgGUID: 9FbTWUEDSxOq5imcHkIxXQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="241208203"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:48:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:48:30 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:48:17 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
	<steen.hegelund@microchip.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
	<casper.casan@gmail.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
	<Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 6/9] dt-bindings: net: oa-tc6: add PHY register access capability
Date: Mon, 23 Oct 2023 21:16:46 +0530
Message-ID: <20231023154649.45931-7-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Direct PHY Register Access Capability indicates if PHY registers are
directly accessible within the SPI register memory space. Indirect PHY
Register Access Capability indicates if PHY registers are indirectly
accessible through the MDIO/MDC registers MDIOACCn.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 Documentation/devicetree/bindings/net/oa-tc6.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/oa-tc6.yaml b/Documentation/devicetree/bindings/net/oa-tc6.yaml
index 9f442fa6cace..09f1c11c68b9 100644
--- a/Documentation/devicetree/bindings/net/oa-tc6.yaml
+++ b/Documentation/devicetree/bindings/net/oa-tc6.yaml
@@ -58,6 +58,18 @@ properties:
       data written to and read from the MAC-PHY will be transferred with
       its complement for detection of bit errors.
 
+  oa-dprac:
+    maxItems: 1
+    description:
+      Direct PHY Register Access Capability. Indicates if PHY registers
+      are directly accessible within the SPI register memory space.
+
+  oa-dprac:
+    maxItems: 1
+    description:
+      Indirect PHY Register Access Capability. Indicates if PHY registers
+      are indirectly accessible through the MDIO/MDC registers MDIOACCn.
+
 additionalProperties: true
 
 examples:
@@ -69,4 +81,6 @@ examples:
 	oa-txcte;
 	oa-rxcte;
 	oa-prote;
+	oa-dprac;
+	oa-iprac;
     };
-- 
2.34.1


