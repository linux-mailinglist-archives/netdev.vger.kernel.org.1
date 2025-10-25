Return-Path: <netdev+bounces-232827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA2C0920B
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A691C22B72
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBBF2FFFBE;
	Sat, 25 Oct 2025 14:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AC2FFDF4;
	Sat, 25 Oct 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403816; cv=none; b=OTC0uu7vNbU3vQ+bR5CtXchJwCKY9Bup5iIXet7bGQ2cZcVTV0CcwJiQgtvcy71fTsNdlII39NcsQQWiaPiO0Tz685l4L/zYHc40UfjabVOQ0ZzVs5jLs4NFjraQZHvyQo/POOtcUUl0kmtmSynnn3FfCj+O9HRPkLwBJCKGhvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403816; c=relaxed/simple;
	bh=2BT6vYlpLIz17S7FZYvZUawSwLmLSpaSV3ovQAA6yN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezDl6Mogci62YFtJ4Cve9AZ8+Qh5kGFc7RzjN+bZAJ51Y+7I2F63YT0XCucujbMbo0xWOIcW8fhW8RSLc8+6mnB9GwERMdfFnNIcXKLCyLuEYQeGUBfpCSHohkzNS0A1GORwLdkvYdyUCzSLEUmatkI8VGK59+FYalx3L9XdwH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCfar-000000001dY-1s4s;
	Sat, 25 Oct 2025 14:50:09 +0000
Date: Sat, 25 Oct 2025 15:50:00 +0100
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
Subject: [PATCH net-next v2 08/13] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear RMII refclk output property
Message-ID: <69053e3f65171a7435aaf14e3277bc7bfef71d6d.1761402873.git.daniel@makrotopia.org>
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

Add support for the maxlinear,rmii-refclk-out boolean property on port
nodes to configure the RMII reference clock to be an output rather than
an input.

This property is only applicable for non-RGMII ports and allows the
switch to provide the reference clock for RMII-connected PHYs instead
of requiring an external clock source.

This corresponds to the driver changes that read this Device Tree
property to configure the RMII clock direction.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index ed274bfb8d49..48641c27da10 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -13,6 +13,8 @@ allOf:
         patternProperties:
           "^port@[0-6]$":
             type: object
+            allOf:
+              - $ref: /schemas/net/dsa/dsa-port.yaml#
             properties:
               tx-internal-delay-ps:
                 enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
@@ -26,6 +28,11 @@ allOf:
                 description:
                   RGMII RX Clock Delay defined in pico seconds.
                   The delay lines adjust the MII clock vs. data timing.
+              maxlinear,rmii-refclk-out:
+                type: boolean
+                description:
+                  Configure the RMII reference clock to be a clock output
+                  rather than an input. Only applicable for RMII mode.
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
-- 
2.51.0

