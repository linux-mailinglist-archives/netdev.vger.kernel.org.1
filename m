Return-Path: <netdev+bounces-209917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3358B11518
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BAD1CE530C
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780F72BAF4;
	Fri, 25 Jul 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="noLGunJj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED4EAF9;
	Fri, 25 Jul 2025 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402684; cv=none; b=gDtMmb+jm4slAzC+3OITOeFcEVLHCBYydFelaKu9NKP7UGZ3oFZRjf4UlaCOipZOjvHLc6w2LEZziobPnfhdu1hNdSXi954MEzhPyQF8rZDc83NtQSAxeMbpjnIujAomCWoNZXHzG615gdjWDIRtEyEg/OHoYWflMhdhjUtwHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402684; c=relaxed/simple;
	bh=p79ByLDbKVxk5rGBQA0gpIRtgMyAUqa0aOZTG+rIihE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BKWE5fuLuwtMeA1XWO/5iSG1UoxzLVOPMNa7PTfD3hUI9xuMMJA2TpNO/7ogUtLugGOp+VszJOHQOl9qfkux/63cW+t77Nw4ARUG1yNde7P+n6W5AJ9rA9Qudkj4w6jYjo3dMhUaFlYFxeFYCfHk51AcQn7kL4eNSrKbENvg0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=noLGunJj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753402682; x=1784938682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p79ByLDbKVxk5rGBQA0gpIRtgMyAUqa0aOZTG+rIihE=;
  b=noLGunJjOTXUPsnIcSTTQCpMgafNNitbXXmZroJwXDkCfr9HoOZmUfsV
   5mVUVq1TmkjZDJufVAUrgOFlj9Se/oesVWGl41wPtCMqvxl5HPBNydzuE
   0Z8e2oAbBOx1plTrDWBct/gUl6z/Tmx5melH+nNW23lHrtXsYIUTs6Lft
   baBKaKoiX2RXu7BzbD7Rrd3/GGRdr6EbEvKJxr0DGPTC7ejVLBwTKf0jL
   unluHSHCw5fDM7sDF4AGUKsaOuCYd7zvQ8OcQjatvpPCYp0QhfrQi2sFv
   6IEPu8YkwsI1xdvPiyAuno5NpAXu/PT/CPE1YsU9ZWTwT9UuEkVjiH3VG
   w==;
X-CSE-ConnectionGUID: eDIQSHZ3TP2otfHW2Moz3Q==
X-CSE-MsgGUID: w2kM5rxtTRiHsSdb3cZZig==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="49728960"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 17:18:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 17:17:51 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Jul 2025 17:17:50 -0700
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
Subject: [PATCH net-next v6 0/6] net: dsa: microchip: Add KSZ8463 switch support
Date: Thu, 24 Jul 2025 17:17:47 -0700
Message-ID: <20250725001753.6330-1-Tristram.Ha@microchip.com>
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

v6
- Set use_single_read and use_single_write so that 64-bit access works
- Change register values for big-endian system if necessary

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
 drivers/net/dsa/microchip/ksz_common.h        |  37 +++-
 drivers/net/dsa/microchip/ksz_dcb.c           |  10 +-
 drivers/net/dsa/microchip/ksz_spi.c           | 104 ++++++++++
 include/linux/platform_data/microchip-ksz.h   |   1 +
 9 files changed, 522 insertions(+), 32 deletions(-)

-- 
2.34.1


