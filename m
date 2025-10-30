Return-Path: <netdev+bounces-234370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D74C1FD03
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EF424E9E55
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437B8354AF5;
	Thu, 30 Oct 2025 11:28:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AA34403C;
	Thu, 30 Oct 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823725; cv=none; b=UaHKptqdQnAtPJQDyUEhUC91SrrjmpZwEjnr3J4czFVShZ8xu/qr5v2dVGVSRz5nuAdquy2KpNotDaH/m8/8qnfI38NeWgZ+rWyFvV89oWMvK6RhVS7O6KW8lKgqNjDL5PGEQPl/fzTj0SU+Bu6zC3Nt8HKNcQY3lo7IU8Z0nlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823725; c=relaxed/simple;
	bh=D2rAWptM7aFcYCGuCiBJwV/RTS4n2J5zYr+50BdhJDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTBhEskhk9z+FUw5c+7BYfsTdamRCokyOpLGVHEYF/SWm6PPn+sJK6G17SoE3UGSC0G7Qfmd9okpZ1zGyv/8cFDGUPf6T05IrZWTjI8IWlI1e6E7yqqzvHhJhDJqwLc6Wy3Yo2Gtk8+ylsb1AQv6QtOs9v+yGmhpdAS+GRccjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEQpb-000000005EI-10Em;
	Thu, 30 Oct 2025 11:28:39 +0000
Date: Thu, 30 Oct 2025 11:28:35 +0000
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
Subject: [PATCH net-next v5 06/12] dt-bindings: net: dsa: lantiq,gswip: add
 support for MII delay properties
Message-ID: <8025f8c5fcc31adf6c82f78e5cfaf75b0f89397c.1761823194.git.daniel@makrotopia.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761823194.git.daniel@makrotopia.org>

Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
properties on port nodes to allow fine-tuning of RGMII clock delays.

The GSWIP switch hardware supports delay values in 500 picosecond
increments from 0 to 3500 picoseconds, with a post-reset default of 2000
picoseconds for both TX and RX delays. The driver currently sets the
delay to 0 in case the PHY is setup to carry out the delay by the
corresponding interface modes ("rgmii-id", "rgmii-rxid", "rgmii-txid").

This corresponds to the driver changes that allow adjusting MII delays
using Device Tree properties instead of relying solely on the PHY
interface mode.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4:
 * remove misleading defaults

v3:
 * redefine ports node so properties are defined actually apply
 * RGMII port with 2ps delay is 'rgmii-id' mode

 .../bindings/net/dsa/lantiq,gswip.yaml        | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index f3154b19af78..8ccbc8942eb3 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -6,8 +6,31 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Lantiq GSWIP Ethernet switches
 
-allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
+$ref: dsa.yaml#
+
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    patternProperties:
+      "^(ethernet-)?port@[0-6]$":
+        $ref: dsa-port.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          tx-internal-delay-ps:
+            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
+            description:
+              RGMII TX Clock Delay defined in pico seconds.
+              The delay lines adjust the MII clock vs. data timing.
+              If this property is not present the delay is determined by
+              the interface mode.
+          rx-internal-delay-ps:
+            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
+            description:
+              RGMII RX Clock Delay defined in pico seconds.
+              The delay lines adjust the MII clock vs. data timing.
+              If this property is not present the delay is determined by
+              the interface mode.
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
@@ -113,8 +136,10 @@ examples:
                     port@0 {
                             reg = <0>;
                             label = "lan3";
-                            phy-mode = "rgmii";
+                            phy-mode = "rgmii-id";
                             phy-handle = <&phy0>;
+                            tx-internal-delay-ps = <2000>;
+                            rx-internal-delay-ps = <2000>;
                     };
 
                     port@1 {
-- 
2.51.2

