Return-Path: <netdev+bounces-250789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C65D39256
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 809D0301101A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE455217F2E;
	Sun, 18 Jan 2026 03:21:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA11C8616;
	Sun, 18 Jan 2026 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768706489; cv=none; b=An6dI+ioo0B/5KAD5j85UldIMCbZANVL+TmhLf1tEg0EGhgpmb0ggkvVTTFzDCF/AD71TzaKADvErzCN3MsxR2Z6Q12c6QPh0Nxvwnpj0+r2zRpbVPbDR75KOs2oybPzcTfeO7KIiTqslrZyKjyuDEp+NMXGyOBQx92+g3PfRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768706489; c=relaxed/simple;
	bh=k9jNCwjbNVhocGj15vaZH75IY3C7l989Ya6HAgJuAfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sbh3csEBfmUluSFYEHiF8/PZaIjixp3+O4aR6HOY4dVJtoGfniYu343GzRLDSTmbS60cDIM9qpHvDud64s8M+e7IlMvwv4dlFl26XHP/neZC0zJlyxMJF8m/wOxRhKeu/tBFerSzXGP/EvgJ2B5w0L4vtkbf3DjlYHpltKPgG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhJLw-000000000dH-1Hhx;
	Sun, 18 Jan 2026 03:21:24 +0000
Date: Sun, 18 Jan 2026 03:21:15 +0000
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
Subject: [PATCH net-next v5 1/6] dt-bindings: net: dsa: lantiq,gswip: use
 correct node name
Message-ID: <95935adb4df7d9f97a94cb77556976ca198382fb.1768704116.git.daniel@makrotopia.org>
References: <cover.1768704116.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768704116.git.daniel@makrotopia.org>

Ethernet PHYs should use nodes named 'ethernet-phy@'.
Rename the Ethernet PHY nodes in the example to comply.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v5: no changes
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

