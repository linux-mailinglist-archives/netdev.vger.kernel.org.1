Return-Path: <netdev+bounces-243461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71736CA1A10
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F133025F9B
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4D2D47EF;
	Wed,  3 Dec 2025 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cD11pDS4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dMzocChk"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC02D063F;
	Wed,  3 Dec 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796153; cv=none; b=BkekiLnADaVfJRlGsTxzk0texaiKq+indrvgq6FJ1ezk5l3qbSaoIkRNAlPeBoZ5tOQ1eis8uwpyW7BXAV43EzihqXDIHYwKTwQ/QUIJ7EDclSpZt74iO42LTcU/pvkwpk/3fJbHrHVpMNGrcIXGZF9tCOlDbtn0LLrqO8k0sZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796153; c=relaxed/simple;
	bh=5V8hOE68pWVZ41qV0XQDZyrUFMvdYQtI0T3z1qjI/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU9/8Juowwzc5/dtnc+1FOq8AXcfcqS89pIQp4oIsz8aSB/BNI4QU0Z/jcpuCFXGhUV27PgwQ6tD2e+D18A3gmvauRE/12LkgqJVzchLd5rHMgx326xUIDcGydVHn4yCGMIAYSx/iUV4+kw7t4+kobd7/IejCsfqv7mDEt60iKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cD11pDS4; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dMzocChk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dM9HT5lM2z9t16;
	Wed,  3 Dec 2025 22:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vMYnMEDuuR+MyUR6StcED08X+lyAQd78LlIzc0yikY=;
	b=cD11pDS4WaCk6HtWZk/SXWME24L1r1neYIQkbmR5gwdzf/rXB2Qg+bYJC/ipv6xrXugAp3
	9eeY9RHbfUjubA+B3m2lorxDELcJXumNvbcF2BP3OvvpyCTinXQDnoT9mioS1p+69FEQ2k
	25VSDzHofD8WfCKvcg/eCauCL9tRaBXTjsjpPr5BzkYeJ35Jh36zuHogAWXrrVrNuO51v5
	7sgyXObfZZjMdawQBj0LipBcCeXJOhldiCcXP6laQPtCK0jgTnKmvF9m7szts9TgiWodX2
	d+UkFfqn5CkO9Hs8Uv4kLgB1ePqUZXRCrwhXwKmt3vrZwn4vsHSjm3Lv+B9c0g==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vMYnMEDuuR+MyUR6StcED08X+lyAQd78LlIzc0yikY=;
	b=dMzocChkz7j032FdlGdRvCRRneG7aJVC2ACEgCr4v41BLjV9eadyyQ6/eQw0vuQDiCFGKb
	f3mBxW5w3r73PAIMUFioL8Kb7N4o4tF72BlMJX03eHZptYOLpJ/GfTP0g7h5wsRTNbuUOd
	9HBkfs2GIWiKhuNFRMWP2+j8vj/wuM08dvJImycLTT1yrIlR7Zy1lsPLDwcNzEdNxpmPRi
	mEFIfVAj8S6Gc6B6X8l5KNU52zmGBnuY0bzZdcAHqABBY1ZCRJ0KP1kiW7VbcD+Q/6LtFT
	yr/9ma17m6ywVcoQuYeFt8q8Okd74I5Yit7ENWFE2DPnd0wKeoPXuGcLfKdKIw==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v2 2/3] dt-bindings: net: realtek,rtl82xx: Document realtek,ssc-enable property
Date: Wed,  3 Dec 2025 22:08:05 +0100
Message-ID: <20251203210857.113328-2-marek.vasut@mailbox.org>
In-Reply-To: <20251203210857.113328-1-marek.vasut@mailbox.org>
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9074bd9ca06d9ed5cdb
X-MBO-RS-META: udbipf8ew55eakjzyqcryn8aps6e9x51

Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce DT properties
'realtek,clkout-ssc-enable', 'realtek,rxc-ssc-enable' and
'realtek,sysclk-ssc-enable' which control CLKOUT, RXC and SYSCLK
SSC spread spectrum clocking enablement on these signals. These
clock are not exposed via the clock API, therefore assigned-clock-sscs
property does not apply.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: Split SSC clock control for each CLKOUT, RXC, SYSCLK signal
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index eafcc2f3e3d66..45033c31a2d51 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -50,6 +50,21 @@ properties:
     description:
       Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
+  realtek,clkout-ssc-enable:
+    type: boolean
+    description:
+      Enable CLKOUT SSC mode, CLKOUT SSC mode default is disabled after hardware reset.
+
+  realtek,rxc-ssc-enable:
+    type: boolean
+    description:
+      Enable RXC SSC mode, RXC SSC mode default is disabled after hardware reset.
+
+  realtek,sysclk-ssc-enable:
+    type: boolean
+    description:
+      Enable SYSCLK SSC mode, SYSCLK SSC mode default is disabled after hardware reset.
+
   wakeup-source:
     type: boolean
     description:
-- 
2.51.0


