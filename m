Return-Path: <netdev+bounces-234741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA49FC26B6E
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CED64F818B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40730AD19;
	Fri, 31 Oct 2025 19:22:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7462E093A;
	Fri, 31 Oct 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938540; cv=none; b=KO3wrJ2/X4/aXYUEsN34w9v9R3EKxNcq2/oGE5+otKvw93F8v9ixXwLVAkapWgAUaDwLctOQ2nbbdeYy3bAmdnnFuyHKt/90zSosjKdt3lnFXSdCcAmemfca3WFcBn7rJuws208c35SqlTfMwvd2ugjs8XMQHIoF9DsjbjMUtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938540; c=relaxed/simple;
	bh=YGqBINOA4V1yy0FT4F2dUV8OYYbAAzKImdsdlcO4/Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om4KnYpj52kXknAA2yosJtJKpBzHDOdUTBto8GJcTYdhQzG10BbCIxvZ0Pb2pVIpgiyjCyxzkKfOQhb52i23zdRoEQ0Kc9i3y+Jy9el1HgXpgrsJT7UVINOTjSNPTDneOkX2/GMkEfQpFS/O5nIYzlGZEPvLearb7mJ5Z1wOZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEuhR-000000005uU-0nEQ;
	Fri, 31 Oct 2025 19:22:13 +0000
Date: Fri, 31 Oct 2025 19:22:09 +0000
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
Subject: [PATCH net-next v6 08/12] dt-bindings: net: dsa: lantiq,gswip: add
 support for MII delay properties
Message-ID: <3c8dc0bab72de05ce5b5a7960b6596009287fa8e.1761938079.git.daniel@makrotopia.org>
References: <cover.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761938079.git.daniel@makrotopia.org>

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
v6:
 * switch order of patches

v4:
 * remove misleading defaults

v3:
 * redefine ports node so properties are defined actually apply
 * RGMII port with 2ps delay is 'rgmii-id' mode

 .../bindings/net/dsa/lantiq,gswip.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index b494f414a3e1..cf01b07f7f44 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -22,6 +22,20 @@ patternProperties:
             description:
               Configure the RMII reference clock to be a clock output
               rather than an input. Only applicable for RMII mode.
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
@@ -127,8 +141,10 @@ examples:
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

