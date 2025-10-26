Return-Path: <netdev+bounces-233033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85798C0B792
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 549E94EA75D
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 23:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAAE3019B6;
	Sun, 26 Oct 2025 23:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5CF2FF152;
	Sun, 26 Oct 2025 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522329; cv=none; b=jjVn+uzBtgee9blN0j8pfM1Irz4Ngh+KNKBp1PuC02JlKpHJsWSz6JOjtkSX4GSYJUqWDt/r/xmwJcE6vN8Cp4pGx7+QT2p7qNQxj9WhUNmDgvl5LIXfH/X5XpkCgCNkQ1Ma3eR+7YyvEXduQTU6JrvcQ4vAYpZKUItpGOJk/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522329; c=relaxed/simple;
	bh=1TyHD51+FeUqL5CO0Td6sW8rkWIzkLQZiunMDkYQK6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE4sUIw4dxWhdBIVhDsFVqdA4XVUzUG9eHmRDUSAWesOqdekqKctW6jnvRfHtuvkz1VP8lf3WnQklEJaan5Pm5cbkVjHE3hmrhXC8XvbF03VgMgTYkZ5MCK5VAG4jL/2r8dd63KUinIs81fMp+bMtWYFSO93VpTbb96F7K3Syks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDAQM-000000007e1-2ziP;
	Sun, 26 Oct 2025 23:45:22 +0000
Date: Sun, 26 Oct 2025 23:45:19 +0000
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
Subject: [PATCH net-next v3 06/12] dt-bindings: net: dsa: lantiq,gswip: add
 support for MII delay properties
Message-ID: <e7a4dadf49c506ff71124166b7ca3009e30d64d8.1761521845.git.daniel@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761521845.git.daniel@makrotopia.org>

Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
properties on port nodes to allow fine-tuning of RGMII clock delays.

The GSWIP switch hardware supports delay values in 500 picosecond
increments from 0 to 3500 picoseconds, with a default of 2000
picoseconds for both TX and RX delays.

This corresponds to the driver changes that allow adjusting MII delays
using Device Tree properties instead of relying solely on the PHY
interface mode.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3:
 * redefine ports node so properties are defined actually apply
 * RGMII port with 2ps delay is 'rgmii-id' mode

 .../bindings/net/dsa/lantiq,gswip.yaml        | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index f3154b19af78..b0227b80716c 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -6,8 +6,29 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
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
+            default: 2000
+            description:
+              RGMII TX Clock Delay defined in pico seconds.
+              The delay lines adjust the MII clock vs. data timing.
+          rx-internal-delay-ps:
+            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
+            default: 2000
+            description:
+              RGMII RX Clock Delay defined in pico seconds.
+              The delay lines adjust the MII clock vs. data timing.
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
@@ -113,8 +134,10 @@ examples:
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
2.51.1

