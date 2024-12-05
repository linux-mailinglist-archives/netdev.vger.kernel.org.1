Return-Path: <netdev+bounces-149387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A809E55F1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA31285EEB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BD218EA0;
	Thu,  5 Dec 2024 12:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427A218AC4
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403420; cv=none; b=Wgvlw1iWMfLfntDXuRyoRlheftna/5YRfbgEK0FUXfZGsdNcSggf1uvCSmDQZGhUMfFF8+c6wnVKkzhFzrLewH4wz1xdirEjhHFjsXhXHA2cUncEXOdeoqBxMN+/J8VfIyxrhlbQhEIuQhZwGh2qOkqrYsoXvcfxP0qwu0+AWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403420; c=relaxed/simple;
	bh=ltlZ1X980XEljgkzY/NiPgAEA6GecoAYrB0BAEh5vRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5HeOwxMxfxyC1hRb/X1sY/wEnGm29nSZEWWllX7gduB1wjvGSW22+BUVfvIcizJXLk91HwjluCyrE74dwwrkb1LIoBVJWl5yo2EX+ssdZdIDobQvrvj6wpQSOu+qPsBH2/Wf0l1jxj68JhuiOH6TX0ipuZALVUy6Bi+I7BfkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tJBPP-0006PG-HP; Thu, 05 Dec 2024 13:56:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJBPN-001pLG-0J;
	Thu, 05 Dec 2024 13:56:41 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJBPN-005GEN-2X;
	Thu, 05 Dec 2024 13:56:41 +0100
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
Subject: [PATCH 0/5] Add support for Priva E-Measuringbox board
Date: Thu,  5 Dec 2024 13:56:35 +0100
Message-Id: <20241205125640.1253996-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

This patch series introduces support for the Priva E-Measuringbox board
based on the ST STM32MP133 SoC. The set includes all the necessary
changes for device tree bindings, vendor prefixes, thermal support, and
board-specific devicetree to pass devicetree validation and checkpatch
tests.

Oleksij Rempel (3):
  dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY
  dt-bindings: vendor-prefixes: Add prefix for Priva
  dt-bindings: arm: stm32: Add Priva E-Measuringbox board

Roan van Dijk (2):
  arm: dts: stm32: Add thermal support for STM32MP131
  arm: dts: stm32: Add Priva E-Measuringbox devicetree

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   6 +
 .../devicetree/bindings/net/ti,dp83td510.yaml |  35 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/st/Makefile                 |   1 +
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  35 ++
 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts   | 496 ++++++++++++++++++
 6 files changed, 575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,dp83td510.yaml
 create mode 100644 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts

--
2.39.5


