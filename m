Return-Path: <netdev+bounces-33494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B679E30C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D891C20DF6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F181DDE2;
	Wed, 13 Sep 2023 09:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E41DDDF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:10:44 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279B19B5;
	Wed, 13 Sep 2023 02:10:43 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D9ATMO004026;
	Wed, 13 Sep 2023 04:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694596229;
	bh=mvDBDTRCcsLLSyskq4FBY2Itwxzxg045lA0r3W+7xV8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WghxVUzg5gfSBEqartSCAL1VB2gAU2ZsH7f2OTmLbfEeVJHHwamWiLWElS6UH6xu4
	 Pe/R18NuzopohaJWj/HEzHHtyv3yBvV7qIRI+WkO6w/ko+JBPEf2DPL+wTFzX8ls3F
	 X1lErQyfo6DTDIsXyw7lT2Z7PsGU1YaLLp/JIs5w=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D9ATj0085152
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Sep 2023 04:10:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 04:10:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 04:10:27 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D9ARBh051263;
	Wed, 13 Sep 2023 04:10:27 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38D9AQSJ022778;
	Wed, 13 Sep 2023 04:10:27 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
        MD Danish
 Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman
	<horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: Add documentation for Half duplex support.
Date: Wed, 13 Sep 2023 14:40:10 +0530
Message-ID: <20230913091011.2808202-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913091011.2808202-1-danishanwar@ti.com>
References: <20230913091011.2808202-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

In order to support half-duplex operation at 10M and 100M link speeds, the
PHY collision detection signal (COL) should be routed to ICSSG
GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
property, "ti,half-duplex-capable" is introduced for this purpose. If
board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
be added to eth node of ICSSG, MII port to support half duplex operation at
that port.

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index 836d2d60e87d..229c8f32019f 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -107,6 +107,13 @@ properties:
               phandle to system controller node and register offset
               to ICSSG control register for RGMII transmit delay
 
+          ti,half-duplex-capable:
+            type: boolean
+            description:
+              Indicates that the PHY output pin COL is routed to ICSSG GPIO pin
+              (PRGx_PRU0/1_GPIO10) as input so that the ICSSG MII port is
+              capable of half duplex operations.
+
         required:
           - reg
     anyOf:
-- 
2.34.1


