Return-Path: <netdev+bounces-208300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7B5B0AD46
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D21C5885D0
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3619007D;
	Sat, 19 Jul 2025 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CZ7FP1xL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB187260A;
	Sat, 19 Jul 2025 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888152; cv=none; b=H4if3wGrvfOkqB9NQDCWjoNY8HQ5TAycgLl+Mv3hfEz0jmpEvb9VgeF3dLgkkyZdLUSJvccnA4dRbChy1jeq6/h3P27Y1t63Q8Q271S6Sg16ew/q5ZJzQ2umTTM9iSAMo8lGYu4gAQCQQ9mUDiFX+GG8GNTFMIGaVeCgxXk4VRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888152; c=relaxed/simple;
	bh=OVbbYkCBcZ+CNDoO6CgnMGQXExnG7/i7qu3C3IVJKkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtwsejbMTZBOWsd5H4BI6FaUyATvEEp4PBBxQbbBVQCvgSvSeqN/dquMQT+4/Xd6ADPArWF9o8HnF5oIyZPMZfwB2mkeHL3xmjLNVfLjHY4Fyf/nRQQFuvpcXzOiVKe27VyPUZ+IhycLNp7J2YHzWIJdG6CzgWEj7Iqfn7FkGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CZ7FP1xL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752888151; x=1784424151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OVbbYkCBcZ+CNDoO6CgnMGQXExnG7/i7qu3C3IVJKkE=;
  b=CZ7FP1xLqHhNaPJU7oYzZEHvk9S1RwAoMKb4UnCn+274Xfdek4LzgWRe
   N/Sfj7VB2yPmHjXUZyrZu/qcz8dGrRCJjd/S9DrZF7XKR49g+ELaTo5eY
   VbT71AXyW/JS4wIprLCxEiuYoMeAdldwluFDanXMwapto09o3gsAWnLnm
   /4zhJJB2p8+YFGJtPRMCJGlJCKmL+kcQsP1K8JyUn/87cJ5KDuJtG0ZP4
   VHVH15aOXnlK7b1NuUGw3WL93TXI7M5Fnh7Ue5qX7AsyrFPV+DW41w692
   8WFcDnLYKctQy5SVKbIi28gU4YdGS9x0aMBHVU7pnB4p3+Pa6BDkgH/W3
   g==;
X-CSE-ConnectionGUID: ddxsHBV8SmSEFdelM5WBgw==
X-CSE-MsgGUID: zNzCk4BARD2ljdhwTloXvw==
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="275554253"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2025 18:21:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 18 Jul 2025 18:21:02 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 18 Jul 2025 18:21:02 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v4 0/7] net: dsa: microchip: Add KSZ8463 switch support
Date: Fri, 18 Jul 2025 18:20:59 -0700
Message-ID: <20250719012106.257968-1-Tristram.Ha@microchip.com>
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

This series of patches is to add KSZ8463 switch support to the KSZ DSA
driver.

v4
- Fix a typo in ksz8_reg.h
- Fix logic in ksz8463_r_phy()

v3
- Replace cpu_to_be16() with swab16() to avoid compiler warning
- Disable PTP function in a separate patch

v2
- Break the KSZ8463 driver code into several patches for easy review
- Replace ntohs with cpu_to_be16


Tristram Ha (7):
  dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
  net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
  net: dsa: microchip: Transform register for use with KSZ8463
  net: dsa: microchip: Use different registers for KSZ8463
  net: dsa: microchip: Write switch MAC address differently for KSZ8463
  net: dsa: microchip: Setup fiber ports for KSZ8463
  net: dsa: microchip: Disable PTP function of KSZ8463

 .../bindings/net/dsa/microchip,ksz.yaml       |   1 +
 drivers/net/dsa/microchip/ksz8.c              | 195 +++++++++++++++---
 drivers/net/dsa/microchip/ksz8.h              |   4 +
 drivers/net/dsa/microchip/ksz8_reg.h          |  49 +++++
 drivers/net/dsa/microchip/ksz_common.c        | 168 ++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        | 104 ++++++++--
 drivers/net/dsa/microchip/ksz_dcb.c           |  10 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  14 ++
 include/linux/platform_data/microchip-ksz.h   |   1 +
 9 files changed, 497 insertions(+), 49 deletions(-)

-- 
2.34.1


