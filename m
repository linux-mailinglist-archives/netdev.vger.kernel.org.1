Return-Path: <netdev+bounces-232630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077DC0771E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F3A4FBF26
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3786833F8C3;
	Fri, 24 Oct 2025 17:03:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DE319862;
	Fri, 24 Oct 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325392; cv=none; b=H/70d80RsWYzariyIdJDoWWqqc2gU98iwUWjXu/Sv6Orr5cE9Md5GQ/5NKeiUCCMC534uCWIMA/OT7qhjr1nFPDdTH/UjlVqlAo8gMn4/dW5PdeY5sqnkk8HqBRMUH00Z5jqVipaiGxedosueQQDiO3dTV69sIe16rOnD3xIsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325392; c=relaxed/simple;
	bh=luX+GnxH+j++LqYxpyzXnYFQCTvDVBjG0Ip5MORcqeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX5sXnhUS3yaNSFCBqWZa3VKbVbo6TorFzuFGpE3N3phvhafn0t49AbqJOt4WvKd+sRG3UCWe0/eDmhS3TKWA+9YQ2HZxxa4GSiZBRAiq4A70xsr32pVshfuoGqCwGMn4087N8j9FGpM+NpHTOHC5DjKQe/tsdIA4BTmYG21YVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCLBx-0000000068Q-1cGj;
	Fri, 24 Oct 2025 17:03:05 +0000
Date: Fri, 24 Oct 2025 18:02:52 +0100
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
Subject: [PATCH net-next 06/13] dt-bindings: net: dsa: lantiq,gswip: add
 support for MII delay properties
Message-ID: <ece8a3741edd1dacb8b5a3115ba971d9a8167c47.1761324950.git.daniel@makrotopia.org>
References: <cover.1761324950.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761324950.git.daniel@makrotopia.org>

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

