Return-Path: <netdev+bounces-235064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17993C2BA11
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F3A3A61D6
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB830C60E;
	Mon,  3 Nov 2025 12:20:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725630AD0F;
	Mon,  3 Nov 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172407; cv=none; b=F9jGx+KUn2kNOdIeK/4eFp5cM9JOA5Bwkds5AYzsuI90Q1o8OXtcCLAnYPYbzLVjd6Me7Exr5h+UJjnzWbuOxM+6gsEfKGOAXvZ+C1xJBXWdfwqMpNywMZpXNH+0iCS74pjg9zr8pp+k3ArHUZzjRlAkWDi4x0D73bdBpLYWtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172407; c=relaxed/simple;
	bh=M/5vgyEOFPHsA0g19RKbTP11wWgjxSVn1yfcmgSU9ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqu3s2Jn7YpZOC0OQi0L+7rR888XQHrozu6TrBY1XsP2oFjWIlL24QDous/blcryAfqZWQ+pjsftuD9A7TTc6+9YTOeQR6ss65LSx6FBe7otpUks7Usj7KtNQZXV3AoKhr39s9h0yU8DYe2YiImpg9e19omtNQAQ2EwbVBEZNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vFtXV-000000000qX-2B1E;
	Mon, 03 Nov 2025 12:20:01 +0000
Date: Mon, 3 Nov 2025 12:19:58 +0000
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
Subject: [PATCH net-next v7 08/12] dt-bindings: net: dsa: lantiq,gswip: add
 support for MII delay properties
Message-ID: <9e007d4f85c2c6d69e0b91f3663d99e0f6fc8eac.1762170107.git.daniel@makrotopia.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v7: no changes

v6:
 * switch order of patches

v5: no changes

v4:
 * remove misleading defaults

v3:
 * redefine ports node so properties are defined actually apply
 * RGMII port with 2ps delay is 'rgmii-id' mode

v2: no changes

since RFC: no changes

 .../bindings/net/dsa/lantiq,gswip.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 809d0e9d0a15..929f6f8e4534 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -104,6 +104,20 @@ patternProperties:
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
 
 required:
   - compatible
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

