Return-Path: <netdev+bounces-234739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91F9C26B56
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857C718942AC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E95337110;
	Fri, 31 Oct 2025 19:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1396229B18;
	Fri, 31 Oct 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938500; cv=none; b=jpcChvDx9G++SC3l2irmd3Wx8RSpFwrtEoGDocVjpyCtctVL+hOvis6xVJYTlD6gauX4jUSwzkxOVT5kNqLWwLo5eb8y3zoChRMrX2sELiXe/23G8NsfNNNNLg52esAK2wP9FbEqV/TdzoRGrV3+TYtsv04FjiAGHjFTK9WIyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938500; c=relaxed/simple;
	bh=7p6Au6FouVQsLTYdKqrLOFedyC3CUIDWOFbaCparMK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsD6wc7EYtx+56Dirr+tRAF3Tf6AmzQT+byI0QwqUxZO6h1RvvYjPZM0uSMjx2SwoQ0cucqKLUiH6H7cKgYHgb6oqhszbfpUwcRQu03KDE8etdLynTFCHadmrhdIa1ClvKCoPk5jzgZfaNjDaIrExIRSbxcVro9+JT8Ucn91ciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEugo-000000005tv-0IUY;
	Fri, 31 Oct 2025 19:21:34 +0000
Date: Fri, 31 Oct 2025 19:21:30 +0000
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
Subject: [PATCH net-next v6 06/12] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear RMII refclk output property
Message-ID: <c25fdd18373a60eb566f4de85a17279f7ab5518b.1761938079.git.daniel@makrotopia.org>
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
v6:
 * switch order of patches, move deviation from
   dsa.yaml#/$defs/ethernet-ports to this patch which actually
   needs it

 .../bindings/net/dsa/lantiq,gswip.yaml         | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index f3154b19af78..b494f414a3e1 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -6,8 +6,22 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
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
+          maxlinear,rmii-refclk-out:
+            type: boolean
+            description:
+              Configure the RMII reference clock to be a clock output
+              rather than an input. Only applicable for RMII mode.
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
-- 
2.51.2

