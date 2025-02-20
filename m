Return-Path: <netdev+bounces-168065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A2A3D416
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA863B2BF0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04071EDA11;
	Thu, 20 Feb 2025 09:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FA1EDA20
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042133; cv=none; b=oKnIU9XlAlgA0lhmQVmLNXJf55HF0Ec0zEv7lbgnKbMCY+1R5JU2OsFSKsW8Fq+cL/KAjHS1srce3EzUSSKdPg9tz9NGqYeybkLpR9ilB32sAbrAO0ONDvjC+w7KOHYCJaVz1LNJEXUixhD8C1YXpQ/VC0MKjL84vGxX5qxsD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042133; c=relaxed/simple;
	bh=kKRwnS9riO6TOm2jt8o0D2S+vQy3OXvSA39Zd4PiTH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8Yu42A+3/NPxSiwwRUp0tZLd/nD/m8zQV9CuIq0rDi+xtvzfsR4ExtnsgpELmy34vEM9LU1yN4TRx/uUY1jfOb7cUjJpEyJA7hNyArMMdt2ZohbDQQJJpWqtIrPcrp/hf0OIlt79i9WxCCTo57elmdF0EKP1rJ+Upn8GwKs+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl2RR-0007Br-7T; Thu, 20 Feb 2025 10:01:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl2RQ-001uIH-0Q;
	Thu, 20 Feb 2025 10:01:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl2RQ-00CKDh-09;
	Thu, 20 Feb 2025 10:01:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 2/3] dt-bindings: arm: stm32: Add Plymovent AQM board
Date: Thu, 20 Feb 2025 10:01:54 +0100
Message-Id: <20250220090155.2937620-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220090155.2937620-1-o.rempel@pengutronix.de>
References: <20250220090155.2937620-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add support for the Plymovent AQM board based on the ST STM32MP151 SoC
to the STM32 devicetree bindings.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- fix alphabetical order
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 2cea166641c5..544010683b06 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -60,6 +60,7 @@ properties:
       - description: ST STM32MP151 based Boards
         items:
           - enum:
+              - ply,plyaqm   # Plymovent AQM board
               - prt,mecio1r0 # Protonic MECIO1r0
               - prt,mect1s   # Protonic MECT1S
               - prt,prtt1a   # Protonic PRTT1A
--
2.39.5


