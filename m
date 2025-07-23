Return-Path: <netdev+bounces-209175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8469B0E892
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E134E3A5EE4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD331D7E5C;
	Wed, 23 Jul 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mzv/Gso8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE7143744;
	Wed, 23 Jul 2025 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237605; cv=none; b=OL5x++LZmzNZ+PtMTFU2EYgNflCbIfJL9n5++rDexsuB943YBqRjYl2t7DAg1502l847WhIeksGIZ/b4HMEMwgeDhFE6wsf29UqaKiobYaqctBNpbTrD34tFwIqN0XEYgxsrrIWc7l/Qf4b5nYVVPDlMKOWUaCaeXcrYi/Ku6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237605; c=relaxed/simple;
	bh=iLQcjOA3vZPsJE/UQiro/P/PPG33jciNo+M3p4/Lwhw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RVRF5Fhb5UE6Jve1uXT9ev9mEW4vN/Q97c70Xmy0KpN6b3zeZKBKqk9KOy3UFLCSjgIJnTw/kiROl2W5PZkP/aGBUmbp5b30J/Bg6g9W7+X8XkaVg0BW9WyDWvnqbTBD5M/Y3CpDOjQLEvTbH/L0Sx0dkQhz+cj2mkjZfSSnKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Mzv/Gso8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753237603; x=1784773603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iLQcjOA3vZPsJE/UQiro/P/PPG33jciNo+M3p4/Lwhw=;
  b=Mzv/Gso8yVx1NkOYkenorf4/JUuaJbzTES9Y/QQfl1IwcDvpok5gDoDC
   RTZ2pOMeA/nVTXKt9sLNaOFZKiIziSb6IXfvSFnQCunSrXlH6ypraIH4M
   vwDlT4DwqlK8aEbVtYUlkEIBscQIrGMsNmo4X3jhiJuYRjQOs+sJf9mS1
   LL3DbFkRXXQRPYRUKA+7sTe2LlWwwcl9B2Y13/kL6mDGgYuyl/h8GJ/Lw
   ZfuMDrKbSIb5q5+EQ5E0jESuwZCeD0NiAPJIBhV6e15fP2J19YrBRPviM
   JjNKkg4SX2NHYJmJXMEvWDJcx01CHD7jkqUlZ3QsVuiUHJHlFSXYAGXw6
   g==;
X-CSE-ConnectionGUID: ol8zE+5pQbyz8nKT026TwA==
X-CSE-MsgGUID: 7aFriOxhRdex1E/AdBOZfQ==
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="275694682"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2025 19:26:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 22 Jul 2025 19:26:13 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 22 Jul 2025 19:26:12 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon Horman
	<horms@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next v5 0/6] net: dsa: microchip: Add KSZ8463 switch support
Date: Tue, 22 Jul 2025 19:26:06 -0700
Message-ID: <20250723022612.38535-1-Tristram.Ha@microchip.com>
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

v5
- Use separate SPI read and write functions for KSZ8463
- remove inline keyword inside ksz8.c

v4
- Fix a typo in ksz8_reg.h
- Fix logic in ksz8463_r_phy()

v3
- Replace cpu_to_be16() with swab16() to avoid compiler warning
- Disable PTP function in a separate patch

v2
- Break the KSZ8463 driver code into several patches for easy review
- Replace ntohs with cpu_to_be16

Tristram Ha (6):
  dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
  net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
  net: dsa: microchip: Use different registers for KSZ8463
  net: dsa: microchip: Write switch MAC address differently for KSZ8463
  net: dsa: microchip: Setup fiber ports for KSZ8463
  net: dsa: microchip: Disable PTP function of KSZ8463

 .../bindings/net/dsa/microchip,ksz.yaml       |   1 +
 drivers/net/dsa/microchip/ksz8.c              | 188 ++++++++++++++++--
 drivers/net/dsa/microchip/ksz8.h              |   4 +
 drivers/net/dsa/microchip/ksz8_reg.h          |  49 +++++
 drivers/net/dsa/microchip/ksz_common.c        | 160 ++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  52 ++++-
 drivers/net/dsa/microchip/ksz_dcb.c           |  10 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  68 +++++++
 include/linux/platform_data/microchip-ksz.h   |   1 +
 9 files changed, 501 insertions(+), 32 deletions(-)

-- 
2.34.1


