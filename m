Return-Path: <netdev+bounces-120579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41773959D1A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7B6281C37
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6D189BA4;
	Wed, 21 Aug 2024 13:04:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02A1E4A6;
	Wed, 21 Aug 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245499; cv=none; b=Na7I2Nq0RlhOPaOJkaAFkeisbw7tQNoHz8IRFQ/01pXEPQKTSJMhlzF5no4wQSwZaXfsH+g9SRN+G8xtxcBuS7/u2LDEFiIoxyjyr2j5dxoqUFux7BUtQsBrxw+PZdhsnOsaPiLM+IylEwC3bn4WAqfsR26U4IifYmuKLDZnL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245499; c=relaxed/simple;
	bh=Y4lCTV71R7phi1cnmoWUFUQoiKik1jA+Xp+D3T0SQ3w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sTVXcYEwNF3g+kHEFhlSSZBqkckwv1s2MgBCNZDv1Ph0BoHaxH7g0Tny1xky1qKQwBbUvGgq3xCfpM3w9vXyaxN1jc1y+uj/DPNlSwwnRjmIN/7zQkhoMDYI/2cfEepjWOorAO0t2qH62IM+/8vJP/gFlUsKo1te5h/TWAHrDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sgkjW-000000003Vv-0zZD;
	Wed, 21 Aug 2024 12:46:38 +0000
Date: Wed, 21 Aug 2024 13:46:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] dt-bindings: net: marvell,aquantia: add
 properties to override MDI_CFG
Message-ID: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Usually the MDI pair order reversal configuration is defined by
bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
pair order and force either normal or reverse order.

Add properties 'marvell,force-mdi-order-normal' and
'marvell,force-mdi-order-reverse' for that purpose.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/net/marvell,aquantia.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
index 9854fab4c4db0..c82d0be48741d 100644
--- a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -48,6 +48,16 @@ properties:
   firmware-name:
     description: specify the name of PHY firmware to load
 
+  marvell,force-mdi-order-normal:
+    type: boolean
+    description:
+      force normal order of MDI pairs, overriding MDI_CFG bootstrap pin.
+
+  marvell,force-mdi-order-reverse:
+    type: boolean
+    description:
+      force reverse order of MDI pairs, overriding MDI_CFG bootstrap pin.
+
   nvmem-cells:
     description: phandle to the firmware nvmem cell
     maxItems: 1
-- 
2.46.0

