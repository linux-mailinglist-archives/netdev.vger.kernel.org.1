Return-Path: <netdev+bounces-213312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EABB24864
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE021BC1C85
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51162F547A;
	Wed, 13 Aug 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J0lxEjl9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F02836F;
	Wed, 13 Aug 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084131; cv=none; b=jotHho9JezOeYASOI8njJ6ZrkSc/f1QssHLI8cgKugu2iJt7KtC3YkiltOB97gc3NDjqAWipv/1daC0yNHiuxquny+W+J/tZzlPMRJK1NTihHDYQh5bYwMxIxpkFvOapvzqhgna47nPzsoTbMjYvn4JvXiH7L8RebGGVOPT6Hbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084131; c=relaxed/simple;
	bh=+MTNKKrqnDS1NTJkQHj+0RjBJiIMHLuQbpEYXdFBwc4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hOPZ1z8vY2iKGVjjCEt+78kKvNfavQJcJ0sQQEZdOERoDITCQFYTRlZmAsJKsnMxW3AM5yKFDKcgJ+OYtBYmqGtGvAe14Nq1vwpli/BA3ksb6ISFGzh9DGgAdJsT4ZAQ6sSw+NuJNHpKPEzFjcPvf/ktPP2/K9VTZIGFJa+kj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J0lxEjl9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9V9Frno602tqIyrt+g7Dl1Wm10SviDWFljx5aIiqPxU=; b=J0lxEjl9+5Hq21kc7yz4bE94ar
	M1UA1QEoItv10tp/6OcXAZhcVaigIRFmL9pZMTpxgs0my1mx5OBH2WBxE6oO/7SQeAH0SF3DDLDBQ
	cYID61AS68TJfuXY583srbRjtNY6QL1dveFOrqrC+obLTSzZXCoJ/bi53phjlbr2/BPNdkeN2nCBx
	2fo02PhfabDkcqWa2Y/tpmCz6yvGwf7OslFrbWEE2UhxrIGEkN/KK6xQY6Swzns/Z1UxFfCi+vQ8e
	57rL04XSvd9VEup8vRusxp6TqlJED4yIjYUb0d8kDbvaE4OOHG5LO0vdqgrKrf91IjtPvzrtVUwH+
	J+iXbNdg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38656 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1um9YR-0006WM-2x;
	Wed, 13 Aug 2025 12:22:03 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1um9Xj-008kBx-72; Wed, 13 Aug 2025 12:21:19 +0100
In-Reply-To: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
References: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next] dt-bindings: net: realtek,rtl82xx: document
 wakeup-source property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1um9Xj-008kBx-72@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Aug 2025 12:21:19 +0100

The RTL8211F PHY has two modes for a single INTB/PMEB pin:

1. INTB mode, where it signals interrupts to the CPU, which can
   include wake-on-LAN events.
2. PMEB mode, where it only signals a wake-on-LAN event, which
   may either be a latched logic low until software manually
   clears the WoL state, or pulsed mode.

In the case of (1), there is no way to know whether the interrupt to
which the PHY is connected is capable of waking the system. In the
case of (2), there would be no interrupt property in the PHY's DT
description, and thus there is nothing to describe whether the pin is
even wired to anything such as a power management controller.

There is a "wakeup-source" property which can be applied to any device
- see Documentation/devicetree/bindings/power/wakeup-source.txt

Case 1 above matches example 2 in this document, and case 2 above
matches example 3. Therefore, it seems reasonable to make use of this
existing specification, albiet it hasn't been converted to YAML.

Document the wakeup-source property in the device description, which
will indicate that the PHY has been wired up in such a way that it
can wake the system from a low power state.

We will use this in a rewrite of the existing broken Wake-on-Lan code
that was merged during the 6.16 merge window to support case 1. Case 2
can be added to the driver later without needing to further alter the
DT description. To be clear, the existing Wake-on-Lan code that was
recently merged has multiple functional issues.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Apologies, this should've been sent with the patch to the driver which
can be found at:

https://lore.kernel.org/r/E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk

 Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index d248a08a2136..2b5697bd7c5d 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -45,12 +45,16 @@ title: Realtek RTL82xx PHY
     description:
       Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
-
   realtek,aldps-enable:
     type: boolean
     description:
       Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
 
+  wakeup-source:
+    type: boolean
+    description:
+      Enable Wake-on-LAN support for the RTL8211F PHY.
+
 unevaluatedProperties: false
 
 allOf:
-- 
2.30.2


