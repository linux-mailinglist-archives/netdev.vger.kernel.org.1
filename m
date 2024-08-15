Return-Path: <netdev+bounces-118691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA449527DC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA56FB22F97
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A167F9DF;
	Thu, 15 Aug 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mP0uiXcA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702963D5;
	Thu, 15 Aug 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723688426; cv=none; b=UoBIZ6AHrTsh4wCgWTwW9Gedgfs6whqnx+nkWfgJjj4p6qTGRrPBD+kgReOxYhYEDmtoFBjfcbruwBs5VGmbdnIOhhWLKC420HgjLo4uTNVkd6OkMSSOW5idLv9APTLtld5CrOwJOfid4Z1dkZcZ9roy9d5TFZEDKeW8MaMpZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723688426; c=relaxed/simple;
	bh=U60fVcnNPb8Res7UfK5rezEEz6bFcHgFOoBqSJZaN7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KXI2mRzc+ekndCHYAu8HaVzsEnO8a7z/UKZN+tWCXs2miu+RhzXwClH+S/k5YDdoZhxB8oY6WO7k4Z1akptw3znL9z06br3qbH6BHLiriefASM68K7gADZn+B98idhoyTZXWF5IffXuzevudUdZQbDPX1pFmaCgKBXNZHgbcDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mP0uiXcA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723688423; x=1755224423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U60fVcnNPb8Res7UfK5rezEEz6bFcHgFOoBqSJZaN7U=;
  b=mP0uiXcAH8H9gur+kJk5AtaL06szjm9S3fHIs75KpC3kwvn0RkA1gCXC
   m90QVuTXRYz7RJuhlcR27LB7Bgrl3venxJIrw5U3p2NcMwRCF0QeR5ZY5
   4EN4TyXCCUGtf44REHXcbAJQStsKdMAQCwZvUWfxOZwKeyVlkJK4rgO2o
   AdNta4JVrmaGxNheHk51Oh2BuV0WAnqOOygcAZZdLaVb8XPVlkmgIfJKf
   1UywKj0mgwp84TkMvGSyDqARP/YIXGo4j4iFAAkOvXbHnwb68MxdR5BCZ
   GkHMgZH7hTTTfaXFP6MQsUbdiQh+zv5D03zHAIBVd63OOIEUphpxRa5SP
   Q==;
X-CSE-ConnectionGUID: TLKY8qnjRuKJglbogpyTvw==
X-CSE-MsgGUID: GtTHX5xjRV2BZxOcfUxztQ==
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="30473034"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 19:20:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 19:20:13 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 14 Aug 2024 19:20:12 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut
	<marex@denx.de>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v4 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Wed, 14 Aug 2024 19:20:12 -0700
Message-ID: <20240815022014.55275-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

This series of patches is to add KSZ8895/KSZ8864 switch support to the
KSZ DSA driver.

v4
- Update with Paolo's suggestion
- Sort KSZ8864 and KSZ8895 behind KSZ8863

v3
- Correct microchip,ksz.yaml to pass yamllint check

v2
- Add maintainers for devicetree

Tristram Ha (2):
  dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
  net: dsa: microchip: Add KSZ8895/KSZ8864 switch support

 .../bindings/net/dsa/microchip,ksz.yaml       |   2 +
 drivers/net/dsa/microchip/ksz8795.c           |  16 ++-
 drivers/net/dsa/microchip/ksz_common.c        | 130 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  20 ++-
 drivers/net/dsa/microchip/ksz_spi.c           |  15 +-
 include/linux/platform_data/microchip-ksz.h   |   2 +
 6 files changed, 172 insertions(+), 13 deletions(-)

-- 
2.34.1


