Return-Path: <netdev+bounces-162012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CA9A2551D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF123A144F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A68204F62;
	Mon,  3 Feb 2025 08:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10451FC7FD
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573133; cv=none; b=ntQpIU7q71IvfJB24ou6JK5Lpk5w6ubjtEedK1V8wCs0SoUy0dplfAIJbmmgp8ZqeVgWf4KrJVJQH7y5LxQiSSEOuXD7Prd/lws0hvUDvHOZwyEsmRfa0yF499Pj86OmvJPQ4KLgjWXsvuhb0Nq5TpXbfv5Je/SPB1Ok4uvHXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573133; c=relaxed/simple;
	bh=66RywZ0JRagI5ZhzICafvsmxcJtS7MtCvp7n3FefA6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuULmzbjg+ilgzzB4I6KAVZO3ADur3AEl2lXVjyMwQtTF0sa+UA/KqCFdrNKUGXPKDxWfgFfppRT5gHua0/HC/9FTZ248Vuw6n/nnK7DgZUiqUlo0tLkXbzNSMTofTuGbwfGc70u1UYjSCpM0dv9Jv/gtd+F4Ks38EeXCPo2XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tesHf-0006KE-I4; Mon, 03 Feb 2025 09:58:23 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tesHd-003GNl-2g;
	Mon, 03 Feb 2025 09:58:21 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tesHd-002YYj-2Q;
	Mon, 03 Feb 2025 09:58:21 +0100
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
Subject: [PATCH v3 0/4] Add support for Priva E-Measuringbox board
Date: Mon,  3 Feb 2025 09:58:16 +0100
Message-Id: <20250203085820.609176-1-o.rempel@pengutronix.de>
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

changes v2:
- drop: dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY

Oleksij Rempel (2):
  dt-bindings: vendor-prefixes: Add prefix for Priva
  dt-bindings: arm: stm32: Add Priva E-Measuringbox board

Roan van Dijk (2):
  arm: dts: stm32: Add thermal support for STM32MP131
  arm: dts: stm32: Add Priva E-Measuringbox devicetree

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   6 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/st/Makefile                 |   1 +
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  35 ++
 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts   | 496 ++++++++++++++++++
 5 files changed, 540 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts

--
2.39.5


