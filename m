Return-Path: <netdev+bounces-203590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC1AF679F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931451C28403
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCC17BA3;
	Thu,  3 Jul 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sKRA60SC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1A10E5;
	Thu,  3 Jul 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508151; cv=none; b=GLysL0T4X9nIjSeVdTh7MzkBU6aPWbwgY06e40p5gmREMX/Ak2rUX/x4UrMSe1ReJ7+/S823OJl011/PSKazUKbt5QGIpNCcPL6UVNjnSIyQ7lqWWD0pSmZHIvcyxrtPXB0MaN+6IuaYYXCqqRyFMO/d2mkhSZ/muZBGOmrtqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508151; c=relaxed/simple;
	bh=kigpZtZ43Wnyi2Zg5jzTbleL+jlhj2YELkKOByUoj4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ItEWhQeJjJDdf7knoP9/h/pyEutO9P2H6kHUE0TKoKUhplS1ki7Az11VUDXznFRzeQjLQF+HN7tV9bZTojNV+5fvjH/XzwpZWzEmy36OvNmWDB11luNoefWuQR8UyoAjdDsWrMryIbLwPkmcb5yxsHi+AVHIljFwXNz3hoy+fQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sKRA60SC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751508150; x=1783044150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kigpZtZ43Wnyi2Zg5jzTbleL+jlhj2YELkKOByUoj4c=;
  b=sKRA60SC0xibhzYtDHW46ozIJTijKNOGdvgUavcm3ES/qh9n2uzLay0G
   KwFV4TlF0CccGM8IozaiCcGjOj8xUEw3qLmZTTCBgRbOIv2ejoAdJ+3w2
   yoO3WQ1pbelcyGfNPudbqih1jVfdt3CfpZzRC7wfKQmQ4n48KGLgdrzRK
   qOlxl/B7tFZScmeot3kXfoG8/Q6YFo5+DL5SBuQwiJT6lJSiTYEvpqZHk
   6tlZLOBNM/2+fdYq01yGVlE4hVWAu9U4ZhAZFV/60+MsbDZopPxe3hxQy
   KtHRFSGJhi4N7rkw6UhrNecWEgcB4WiCJu3ba3ZMBHOx4yp4tFALcJ/Kl
   Q==;
X-CSE-ConnectionGUID: CQFyRSm3RYe0HuwgMRiJcQ==
X-CSE-MsgGUID: GKiz5L7kQQia1/kdGuVfhw==
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="274911712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2025 19:02:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Jul 2025 19:01:52 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 2 Jul 2025 19:01:52 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 0/2] net: dsa: microchip: Add KSZ8463 switch support
Date: Wed, 2 Jul 2025 19:01:53 -0700
Message-ID: <20250703020155.10331-1-Tristram.Ha@microchip.com>
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

Tristram Ha (2):
  dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
  net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver

 .../bindings/net/dsa/microchip,ksz.yaml       |   1 +
 drivers/net/dsa/microchip/ksz8.c              | 201 +++++++++++++++---
 drivers/net/dsa/microchip/ksz8.h              |   4 +
 drivers/net/dsa/microchip/ksz8_reg.h          |  49 +++++
 drivers/net/dsa/microchip/ksz_common.c        | 168 ++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        | 104 +++++++--
 drivers/net/dsa/microchip/ksz_dcb.c           |  10 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  14 ++
 include/linux/platform_data/microchip-ksz.h   |   1 +
 9 files changed, 503 insertions(+), 49 deletions(-)

-- 
2.34.1


