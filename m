Return-Path: <netdev+bounces-204796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBCAFC14A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7728316E4E7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9CB262FDC;
	Tue,  8 Jul 2025 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qPFloZvu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2243231830;
	Tue,  8 Jul 2025 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944647; cv=none; b=XWuEvqxPLg2OX8cdq6FlNs0N233VavyDABXYmS5+AokGUuHbwFxPcD/wD5DzDL8JzgWNT+Pg1/F8ggZf61R1FTKS4qFPw4Ex5NsbdFycvYGHucU949zvo1/0W84anpufCQHZ1+QyRBF49obagHa+3tVpXW8ghf3PJXyDL8rQa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944647; c=relaxed/simple;
	bh=cRIyKtVNHxEkRXCQQhpfzkO1G4puRnV/5rOXJha/Vn0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nctnjVgiI8oj+yhZzoloJhZhwCRX/n5YmfptQkz1aAtddxm1BIvp+50HlJz9Z453OG2BEaiqCqmVgIpF1cWPxXRbYyCDtdgXaKb0a7Qpj7RuPA45D9JmF27Yc/C8BFoOpWkO9ojLWNJD0muf1Yd1wNNbucypqbm84bJnZJbmO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qPFloZvu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751944645; x=1783480645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cRIyKtVNHxEkRXCQQhpfzkO1G4puRnV/5rOXJha/Vn0=;
  b=qPFloZvu2QADe9S+2sVnpr4YnRsHAwvY88sjhTgRcH6OT+z6D6cE4MKO
   unZPw1bRafS9k616EkTcr1aUEhY4QcaQzhxi6GgaCuCw/lJnjY4rYAC2h
   MXltNzv7jZEpX7eb9qditpEgQpVIgpwyZTBTs8VJc1Qpjbnz/TlAD4GDM
   LAM7N8b4FbAEdldliDTN7gdFDhZwvrZPHSAIaoLv1eKRQmKIxHY+xUofk
   MPDRgZHpOxf/lO61p4UhOrZqA+DBKwTrEo5NAxhN9hLqB5uaq4o4KWuGq
   uxnRcEKW+8vjN2K1N+NgvVxSlHGBKZXavmjGJXTXCrLDTwmTMcK6BlKSR
   g==;
X-CSE-ConnectionGUID: Xj5xTQr8TOOb2tovSmM8jA==
X-CSE-MsgGUID: TGeA1eCdQFSZsaOP8DD0Hw==
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="44305506"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2025 20:17:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 20:16:44 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 7 Jul 2025 20:16:43 -0700
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
Subject: [PATCH net-next 0/6 v2] net: dsa: microchip: Add KSZ8463 switch support
Date: Mon, 7 Jul 2025 20:16:42 -0700
Message-ID: <20250708031648.6703-1-Tristram.Ha@microchip.com>
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

v2
- Break the KSZ8463 driver code into several patches for easy review
- Replace ntohs with cpu_to_be16

Tristram Ha (6):
  dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
  net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
  net: dsa: microchip: Transform register for use with KSZ8463
  net: dsa: microchip: Use different registers for KSZ8463
  net: dsa: microchip: Write switch MAC address differently for KSZ8463
  net: dsa: microchip: Setup fiber ports for KSZ8463

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


