Return-Path: <netdev+bounces-232825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF373C091F6
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650F01C22531
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4992E2FFF87;
	Sat, 25 Oct 2025 14:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8542FFF86;
	Sat, 25 Oct 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403765; cv=none; b=htGNYGmPxrpZ/ibv1c7kH3pVLkQk3QN1B5XaTy+dJvggt9dSSBA93+efKmMrumvPZf2ZYnPUgbqI2qGvor2zIZMnQcfn3BEtJ+UXAG8XVTJUbQItO8KMjQbehoC2reVNV2jqzgaZOPsggaQf/58yry6E1UQy+xHRi4ND59J//hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403765; c=relaxed/simple;
	bh=luX+GnxH+j++LqYxpyzXnYFQCTvDVBjG0Ip5MORcqeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNzFZa75Dhjmm95NQ9RMb98im/dkyFX0YiWX6SSJ7sImxHySldABkryO9wa5iCC22zqSrh4SfYdA8Cql0Sooba1CsebhCLD/v0YCL3exsA0UWZIxwmMDhtYo3J/LlZm9LOVM4aPng4Hq0m1OqGWoGhw2zsmfU/+SVesJdiIspZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCfa3-000000001cM-22hK;
	Sat, 25 Oct 2025 14:49:19 +0000
Date: Sat, 25 Oct 2025 15:49:09 +0100
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
Subject: [PATCH net-next v2 06/13] dt-bindings: net: dsa: lantiq,gswip: add
 support for MII delay properties
Message-ID: <73d0de129a6fc9f8a8a087a2759f9c2ab0d710c0.1761402873.git.daniel@makrotopia.org>
References: <cover.1761402873.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761402873.git.daniel@makrotopia.org>

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
 .../bindings/net/dsa/lantiq,gswip.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index f3154b19af78..ed274bfb8d49 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -8,6 +8,24 @@ title: Lantiq GSWIP Ethernet switches
 
 allOf:
   - $ref: dsa.yaml#/$defs/ethernet-ports
+  - properties:
+      ports:
+        patternProperties:
+          "^port@[0-6]$":
+            type: object
+            properties:
+              tx-internal-delay-ps:
+                enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
+                default: 2000
+                description:
+                  RGMII TX Clock Delay defined in pico seconds.
+                  The delay lines adjust the MII clock vs. data timing.
+              rx-internal-delay-ps:
+                enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
+                default: 2000
+                description:
+                  RGMII RX Clock Delay defined in pico seconds.
+                  The delay lines adjust the MII clock vs. data timing.
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
@@ -115,6 +133,8 @@ examples:
                             label = "lan3";
                             phy-mode = "rgmii";
                             phy-handle = <&phy0>;
+                            tx-internal-delay-ps = <2000>;
+                            rx-internal-delay-ps = <2000>;
                     };
 
                     port@1 {
-- 
2.51.0

