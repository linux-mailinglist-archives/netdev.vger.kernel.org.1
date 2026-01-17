Return-Path: <netdev+bounces-250673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC00D38B0D
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 02:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 975E23033D7C
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC721772A;
	Sat, 17 Jan 2026 01:16:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9D6D1A7;
	Sat, 17 Jan 2026 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612578; cv=none; b=mnbgY5pMAoJCNFaznGur4jTS9NNvXaq3SxCZQeRLcZTJQMUTx+pIyPPYJIG4txW7BjcWBqNCwKwh3l2R13Z16RqZK26AY8TEjMny45vrIKOk9m1JRiFv/7p1733ZBDmx7q5SrSHtFBniDyRJrd/YcBV1so9lmxU6ku2InkJUeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612578; c=relaxed/simple;
	bh=eAWwEXBQ/y3A4ryVc4g1DuwAnR1TbZmhctQIBvQT8CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETwoiVQQd2a+uRjPn85CBUAVzUfonD3dx/7/eba0OyrAwAGYyP/332R4hLxOmE9Bxltr2YSfmVS8wwIC6DDfksY6d78dJX3zIGKjDZWODfxAi3W2rme1HoxWEfH5EgHWPhdzJqsGNKtYcn3AKxQM4FHdjhzEtoJGMMiytq+uEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vguvE-000000005F0-1XZN;
	Sat, 17 Jan 2026 01:16:12 +0000
Date: Sat, 17 Jan 2026 01:16:09 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v4 1/6] dt-bindings: net: dsa: lantiq,gswip: use
 correct node name
Message-ID: <b85391636db5af2f038ba6968b292199d312f403.1768612113.git.daniel@makrotopia.org>
References: <cover.1768612113.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768612113.git.daniel@makrotopia.org>

Ethernet PHYs should use nodes named 'ethernet-phy@'.
Rename the Ethernet PHY nodes in the example to comply.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v4: no changes
v3: no changes
v2: new patch

 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 205b683849a53..9c0de536bae97 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -316,7 +316,7 @@ examples:
                 #address-cells = <1>;
                 #size-cells = <0>;
 
-                switchphy0: switchphy@0 {
+                switchphy0: ethernet-phy@0 {
                     reg = <0>;
 
                     leds {
@@ -331,7 +331,7 @@ examples:
                     };
                 };
 
-                switchphy1: switchphy@1 {
+                switchphy1: ethernet-phy@1 {
                     reg = <1>;
 
                     leds {
-- 
2.52.0

