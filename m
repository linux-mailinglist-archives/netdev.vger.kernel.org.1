Return-Path: <netdev+bounces-212242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE4B1ED58
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F1F18C6180
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD5288C1C;
	Fri,  8 Aug 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ip39DrYn"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B21286412;
	Fri,  8 Aug 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671970; cv=none; b=XbwhMWYLsXVQYpC7+XWf9nuKPDJ7cPuRZNEbPM+yWqFUOzdHY7yLtBz8JgPzRXmRx2Z6PLKrMWGaw50ht0gBQ1R4vVePPuqNnXGR8eo7A3V+JOerzvHdp009lHDNsnLKZupt1R3mKa6tBDlUyvdL+92lyqLy2e0Z2erXd4c0788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671970; c=relaxed/simple;
	bh=n/GewMioDQ4ipBD/SytX9/X63slAi3JDM0dK1ndCHd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuGGkidgyZI8kbs/4tnc/mo0/oGoqDCFH003/pyypl0j6oWkraNg24wiKA2szmFBn8BnPKpjnBiFTDPY6HZ5OPJ/NzDY7sMOt3uSqUAfHQZ9IvYPIvwj5z8i3ob0Zb4hhQVscrIdPN4yEvRflA3oneUJBGoqysMNNtmmVBbjNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ip39DrYn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A30B1442DE;
	Fri,  8 Aug 2025 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PefWoP6TiGv686A1HXjhQU5Qqkp7zhcSH4Yu0r2+y9A=;
	b=Ip39DrYnLwIAVqjBrRAhvRHA9giGN04QKRza3soU4u3YST8fwP34CkIfDyJaGN5RrhvjRr
	/GgPTesla+JvR2nku+gD1HCP+yATsddybCNiFt7/Qzbz/uXrtOZmp6e52t27GsRNGJgvvx
	nXC79b/axwGupeti7IViF32+rKtqOCWWfrDZQFXDfA2LfHOEyw9FczG7BRVkhz3QHbNcY2
	dw289v2U4yH8hYD4/jtXtt6+CRaqyHKbBdtMCgWiezMtc/I5Bk7sUhKIfTGx6PNyKRMJsi
	Tjb599NIrAqWkyxIiQcxLWg+zH4yrEuVMCWSB95t4xdrG7ddYRXNGIFpCXtUbg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:34 +0200
Subject: [PATCH net v3 02/16] dt-bindings: net: cdns,macb: sort compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-2-08f1fcb5179f@bootlin.com>
References: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
In-Reply-To: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepvfhhrohoucfnvggsrhhunhcuoehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelvefhkeeufedvkefghefhgfdukeejlefgtdehtdeivddtteetgedvieelieeuhfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplgduledvrdduieekrddutddrvddvudgnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghom
 hdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvh
X-GND-Sasl: theo.lebrun@bootlin.com

Compatibles inside this enum are sorted-ish. Make it sorted.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 6e20d67e7628cd9dcef6e430b2a49eeedd0991a7..b3bb08a41ef8f867fd4f6813f965bbd12df042dc 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -47,17 +47,17 @@ properties:
           - const: cdns,macb          # Generic
 
       - enum:
-          - atmel,sama5d29-gem        # GEM XL IP (10/100) on Atmel sama5d29 SoCs
           - atmel,sama5d2-gem         # GEM IP (10/100) on Atmel sama5d2 SoCs
+          - atmel,sama5d29-gem        # GEM XL IP (10/100) on Atmel sama5d29 SoCs
           - atmel,sama5d3-gem         # Gigabit IP on Atmel sama5d3 SoCs
           - atmel,sama5d4-gem         # GEM IP (10/100) on Atmel sama5d4 SoCs
+          - cdns,emac                 # Generic
+          - cdns,gem                  # Generic
+          - cdns,macb                 # Generic
           - cdns,np4-macb             # NP4 SoC devices
           - microchip,sama7g5-emac    # Microchip SAMA7G5 ethernet interface
           - microchip,sama7g5-gem     # Microchip SAMA7G5 gigabit ethernet interface
           - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
-          - cdns,emac                 # Generic
-          - cdns,gem                  # Generic
-          - cdns,macb                 # Generic
 
       - items:
           - enum:

-- 
2.50.1


