Return-Path: <netdev+bounces-245407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8ECCCFEA
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACAF5301CEA7
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0FE313E2D;
	Thu, 18 Dec 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oj0wm3En";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qNO2L5X5"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781C30DEA6;
	Thu, 18 Dec 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079468; cv=none; b=FjB/io6AhTwCkTVOFrCvQ9Qe2iJ6nn6j9VJUQigrCvxzbHsYDWQTToYGGH4YaBGutWUwmEZ1RSn9xM7vkecVGdEnS3xOCLrZES/wkyi0966U67I6mNwHbXIXazrwvOyIC2vGBbDfQ/GnmkfP6Z4Lc0bMq/rIbLU1N2GqkCBdR1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079468; c=relaxed/simple;
	bh=/c2Av+EJatQ3qwMomANU+AaRrdhd3UgGrq8vKorVjVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJqOrBgAppaGkr5Jaw4iHgR8Y/nV6GlR1nw7veCdRtXgSWemNdq9xwbnNYt3Bq25rGQ2SHQ7Bz1ekGUGerHNZUg3b3R8z571iDuINJmh5WKUcbMom2nuPCFdIsSCn0AU/GdLK50TJN1VFxO/5sLgHGq0YYSvIUyxAXWlammVP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oj0wm3En; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qNO2L5X5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dXHtc34ktz9tNJ;
	Thu, 18 Dec 2025 18:37:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eF3q9GVdhXKfIzKc0XOirvGVH5rbZAa7GifR16bQMFs=;
	b=oj0wm3EnkvxTGKmAvjBw+SZCy0euMKiQlPNnPeY1o6LUvqdsSBncFjUFvkT3emxGeVmiNH
	6RGlm7+4BQ7+7aFC67prXL0HCMQjcQSrA29z0+MEbjV8qd6JwPeH6/QfgSKXpU7GjM/GPe
	L1iR9dejEj6w8jjb7Rk0zPjOyHoYMa1Cqnf/6ZGZ0snLmZrN4AdAz19kretdXpAP3N9M4N
	ERkEdGsmT3W/GIQ2Qqpti4zSFGAwWfhspmZlGqHAlsQoifzPIU1WGpmt/PCz+IEhpJS2i1
	L7i9tvYC8eowtiNvWs6vQw//EIF0NPtzVcHefEGRYVehDI7525uj3VofL2NMvg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eF3q9GVdhXKfIzKc0XOirvGVH5rbZAa7GifR16bQMFs=;
	b=qNO2L5X59tvUzhkLnzUSOyVh88c4P4ElBOriVclQ/5huC8I8NLdmqOOeRuQxkr5HN+FWA4
	VoS9ANJwZfLw1kmLDGPWhA+lKyssC8awclsVjljEEVkzrEmDVlpTjsXa3LqpCd8vex/OKV
	sIROp8T2fZP01ktqDnRZNtc7vwYEMlkyPgelO28WkDftQcKOYWGRGzaNh3d6pdYvqNWZRG
	iva3eWKxz0c/Dm+Grv3EQo/vpaMgVtk1cYf3RxGm5MkRWvf7YQtQkGUyhToJOZHxeLIyvb
	+4VRDBcPvMZcCjGl25ftknxeoGg5GcojU6Pqd9A3I1sLQR8itY6ro1JQtoVAmA==
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
Subject: [net-next,PATCH v3 1/3] dt-bindings: net: realtek,rtl82xx: Keep property list sorted
Date: Thu, 18 Dec 2025 18:36:12 +0100
Message-ID: <20251218173718.12878-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 25168245de2502b6751
X-MBO-RS-META: sw5grhkj6zog6cef6q6ucbwje8rs57q4

Sort the documented properties alphabetically, no functional change.

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
V2: No change
V3: No change
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2b5697bd7c5df..eafcc2f3e3d66 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -40,15 +40,15 @@ properties:
 
   leds: true
 
-  realtek,clkout-disable:
+  realtek,aldps-enable:
     type: boolean
     description:
-      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
+      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
 
-  realtek,aldps-enable:
+  realtek,clkout-disable:
     type: boolean
     description:
-      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
+      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
   wakeup-source:
     type: boolean
-- 
2.51.0


