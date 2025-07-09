Return-Path: <netdev+bounces-205198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F801AFDC60
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1985F54227F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A817A300;
	Wed,  9 Jul 2025 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bkTfZT06"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AC146588;
	Wed,  9 Jul 2025 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021189; cv=none; b=hQ66DKN2VvLi1++5QzQKE66TKAf1EwcFVOGnfQ7/6UHXQ1A75dVzhcdKOjjYs6gvkkIKnpZW6+FlV1TWyqGoQOpVGKSmvn5B+dzx+AF6ftHnv5HMYlyP7n7R6WHUgFvzQ1VKG3GtNgUktWvPxgbId5TqrpgR43jEA/FnP9u6jMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021189; c=relaxed/simple;
	bh=xMtjFSvuZd9US/DfdTnB6PYkcqHXEdxUA7hUSCIXUB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WhR+vjz8Lq9n7Ypy27tS+lUuspnkcnrOal9WiMhtI9ELDkQd7zb9sdbwzVoQWAW1L4HKgYGScn0jKhNqVaKIeVjNR2HWCDMKtSb4fu/UgunkLVf8V4M6kufpEG3ohuUatYiqK9Y+VFGUj2Xod1oOsAht0aaOdLXg482BWPE4v0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bkTfZT06; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752021188; x=1783557188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xMtjFSvuZd9US/DfdTnB6PYkcqHXEdxUA7hUSCIXUB0=;
  b=bkTfZT06hLpeMK9DVvwqVRDopG1eT6CJ/+fjoXiooJP/Dw4PTFd2YXOO
   8llAB4azWGU6pCq5ro9u9acDrhQawkKb5H6aFIrYRWeNj4ozO2Bgz+sh1
   gEnxIXKF/8YS6OJtqWnnEaN1yTrWBGZUtTSSAOUC9Jrsp266bHGOu23Dt
   0JI9AkbTgUQUqfaFpkmWX9dCSjdfqVNXGTvL3SBDKtuS2b5o8n+AqVfsZ
   EMyfziCLG1MbkTO/wSWAHYZJHK4i+CKOaGKZIdZ/BPXFSSrjHEVN1wQ/U
   VvG0dKcudbxN7Qc1U0BcQNZFuQ+FLagpQgAXJpPIc2MhNdvaq3BhTVJqP
   A==;
X-CSE-ConnectionGUID: CSUfBCd3SzyYJ8hslua0Vg==
X-CSE-MsgGUID: aC7eUGMKR0uwYLt1NkGEZQ==
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="211198513"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2025 17:33:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Jul 2025 17:32:34 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 8 Jul 2025 17:32:33 -0700
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
Subject: [PATCH net-next 0/7 v3] net: dsa: microchip: Add KSZ8463 switch support
Date: Tue, 8 Jul 2025 17:32:26 -0700
Message-ID: <20250709003234.50088-1-Tristram.Ha@microchip.com>
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
 drivers/net/dsa/microchip/ksz8.c              | 202 +++++++++++++++---
 drivers/net/dsa/microchip/ksz8.h              |   4 +
 drivers/net/dsa/microchip/ksz8_reg.h          |  49 +++++
 drivers/net/dsa/microchip/ksz_common.c        | 168 ++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        | 104 +++++++--
 drivers/net/dsa/microchip/ksz_dcb.c           |  10 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  14 ++
 include/linux/platform_data/microchip-ksz.h   |   1 +
 9 files changed, 504 insertions(+), 49 deletions(-)

-- 
2.34.1


