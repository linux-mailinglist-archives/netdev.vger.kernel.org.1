Return-Path: <netdev+bounces-235062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5FC2B9FC
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7663A3AB5
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283830BF69;
	Mon,  3 Nov 2025 12:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6E30AD05;
	Mon,  3 Nov 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172383; cv=none; b=ugr0lyrhWYoGNAPw1c+EtioLznsQBKQ1pBFkf218CXgFM6kKHAsc7KcUQ49nO+cOGqW3B5fKXvL2waKLDmHape5Td3dEP8EGIFyjpsM+U905mHySQI4BAhgupmVLsSkNGdyrI6THTM6dBoOyVlA/gXpA9OhTF3HNaktisc4f2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172383; c=relaxed/simple;
	bh=Kg6znQRD5qyU+hyUC/o2Pcdoa0Lc+Hoa651QbQCbKfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsvwLcdaBB/WLp1kW/nRy0RbHP/YnFFGWkQhJlNIsB4LNxZUCCyjVlJsmqCRFvu9S/gibT+YJIiJSNHaAwFnrZW7onnYPWTR05kVCBINm5e0y6+3ya8RGGeMWdNC9+O8C0LCf7Knl6NK3V6fp/bco0ixZpRLVg3vuGi767K8YBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vFtX7-000000000pr-2w9C;
	Mon, 03 Nov 2025 12:19:37 +0000
Date: Mon, 3 Nov 2025 12:19:34 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v7 06/12] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear RMII refclk output property
Message-ID: <9813bb916ecce9bae366e6c50c081014fe5371ea.1762170107.git.daniel@makrotopia.org>
References: <cover.1762170107.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762170107.git.daniel@makrotopia.org>

Add support for the maxlinear,rmii-refclk-out boolean property on port
nodes to configure the RMII reference clock to be an output rather than
an input.

This property is only applicable for ports in RMII mode and allows the
switch to provide the reference clock for RMII-connected PHYs instead
of requiring an external clock source.

This corresponds to the driver changes that read this Device Tree
property to configure the RMII clock direction.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
v7:
 * put patternProperties: after properties: to follow standardized
   order

v6:
 * switch order of patches, move deviation from
   dsa.yaml#/$defs/ethernet-ports to this patch which actually
   needs it

v5: no changes

v4: no changes

v3: no changes

v2: no changes

since RFC: no changes

 .../bindings/net/dsa/lantiq,gswip.yaml         | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index f3154b19af78..809d0e9d0a15 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -6,8 +6,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Lantiq GSWIP Ethernet switches
 
-allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
+$ref: dsa.yaml#
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
@@ -91,6 +90,21 @@ properties:
 
     additionalProperties: false
 
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    patternProperties:
+      "^(ethernet-)?port@[0-6]$":
+        $ref: dsa-port.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          maxlinear,rmii-refclk-out:
+            type: boolean
+            description:
+              Configure the RMII reference clock to be a clock output
+              rather than an input. Only applicable for RMII mode.
+
 required:
   - compatible
   - reg
-- 
2.51.2

