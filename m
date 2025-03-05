Return-Path: <netdev+bounces-172043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E151A50058
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B77189B5F1
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D3924EAAA;
	Wed,  5 Mar 2025 13:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17124503E
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180490; cv=none; b=H7IZTBKEwKInAirjRpCA7LlvFOEhV6Cm8g4Yits6RAgZyObw1d+giyQScAgaXtPb9fZIgAM6F8wrv6xqJXMZTVBV7rDERF2UplIRv5TLEjkpCntH9X5lGM4DK5QrfwaLz5wsizY7Rb3YlOj2TRYe6CMMDVYOQhyO1/R+othHxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180490; c=relaxed/simple;
	bh=o8rb0cRL5d/DJLK3zumcC2E3PtRerI3iEuNDOsyCwjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQ73d1aqvqezlreU9TUJJJEtdurlvvchOF70zugMb2fCmSaBAwiRs2asgC0O+5MX1t/XPKlV2E26BnTxs8QFgpgD4I9kWVI0MeLVVHwg1l7YeB12s+IiaSS5HjXxsApOf5wVM1MciEwLxMJW9oL7nZ7dGSFILs+lKPhGKAgAke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZw-0000xZ-A1; Wed, 05 Mar 2025 14:14:28 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZu-0049P5-1i;
	Wed, 05 Mar 2025 14:14:26 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZu-006G5O-1R;
	Wed, 05 Mar 2025 14:14:26 +0100
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
Subject: [PATCH v5 0/4] Add support for Plymovent AQM board
Date: Wed,  5 Mar 2025 14:14:21 +0100
Message-Id: <20250305131425.1491769-1-o.rempel@pengutronix.de>
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

This patch series adds support for the Plymovent AQM board based on the
STM32MP151C SoC. Additionally, the ICS-43432 device tree binding is
converted to YAML to address a validation warning.

The ICS-43432 patch resolves one of the devicetree validation warnings.
However, the false-positive warning:

  "audio-controller@44004000: port:endpoint: Unevaluated properties are
   not allowed ('format' was unexpected)"

remains unresolved. The "format" property is required for proper
functionality of this device.

Best regards,

Oleksij Rempel (4):
  dt-bindings: sound: convert ICS-43432 binding to YAML
  dt-bindings: arm: stm32: Add Plymovent AQM board
  ARM: dts: stm32: Add pinmux groups for Plymovent AQM board
  arm: dts: stm32: Add Plymovent AQM devicetree

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   1 +
 .../devicetree/bindings/sound/ics43432.txt    |  19 -
 .../bindings/sound/invensense,ics43432.yaml   |  51 +++
 arch/arm/boot/dts/st/Makefile                 |   1 +
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi   | 292 ++++++++++++++
 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts   | 376 ++++++++++++++++++
 6 files changed, 721 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
 create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
 create mode 100644 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts

--
2.39.5


