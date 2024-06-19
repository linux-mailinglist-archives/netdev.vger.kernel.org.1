Return-Path: <netdev+bounces-104687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536090E084
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BC21C2129D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43505193;
	Wed, 19 Jun 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NWj8tTXj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A404EC5;
	Wed, 19 Jun 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756020; cv=none; b=hNirP53TH+DY/VSpq0D9Ev3Q06pDrGe2+mCPIYXwHXChESodudSxx+P1wj4/Qg50wjcObXrbVyjvwOMUnXX7DDEBkKCYLx1wZvP79QZNOVqd4MP8U2HN5/D5ZAtAgDkAh5amiIXGUEVLfO6pO2GuA5D/DIeiS1Ild1kUR/ZJzlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756020; c=relaxed/simple;
	bh=nCyR+FF46pdp2WHubBl4TFE4rTAqrIiTJSaS8RfSrEc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bvc1vs97fakot9rhrEGW4N+qaug266hqf1CDKn19PvqYbmTMR9pB783hGX9oMMwVbUv+w3eIKdKDhcMm2k3EVEDXsQRxysvYUI0+g96rBm2ddfMdlMaUicywuWqTxB1v164dNseNjWbRiVjTrOSBNK9otXwPqEPDpeknWkwarxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NWj8tTXj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718756018; x=1750292018;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=nCyR+FF46pdp2WHubBl4TFE4rTAqrIiTJSaS8RfSrEc=;
  b=NWj8tTXjN8rB8h1IR53uMdqg4QbMaNsbdscI8vQSbjtwxKEgdTz6WCxC
   8dSd93yrhH/axyodA+CzJWfdGl82HbGXkxllkFNYlvGxMvrW4A+7IUyoJ
   nScRNuhWYYyVrXaUw7kUHl3wdXlLkl/Cx39A0N85lZCtziw7EoG1zjEVl
   KfmpjoeHOu7vJcgxXAwPcb1JYzL3QYsKoFT7lo50hbSTjSSnPSEv+IUBk
   C4ZW1p8dAMm/MesTX41rOZwEhIMuTZR3yTobrpSgSCuKJpwG7olhEBJs+
   APuoQMie3ZyyYxAP+QHD7vEyaRUZObpXEpz+wcMwIgZy1KQ8geGloi9lm
   Q==;
X-CSE-ConnectionGUID: RCjaWn5qSgKWprKYp1rnmA==
X-CSE-MsgGUID: KnrOr0d8R5u8x7/pB7vSEQ==
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="28148942"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2024 17:13:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Jun 2024 17:13:10 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 18 Jun 2024 17:13:09 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH v1 net] net: dsa: microchip: fix initial port flush problem
Date: Tue, 18 Jun 2024 17:16:42 -0700
Message-ID: <1718756202-2731-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The very first flush in any port will flush all learned addresses in all
ports.  This can be observed by unplugging the cable from one port while
additional ports are connected and dumping the fdb entries.

This problem is caused by the initially wrong value programmed to the
REG_SW_LUE_CTRL_1 register.  Setting SW_FLUSH_STP_TABLE and
SW_FLUSH_MSTP_TABLE bits does not have an immediate effect.  It is when
ksz9477_flush_dyn_mac_table() is called then the SW_FLUSH_STP_TABLE bit
takes effect and flushes all learned entries.  After that call both bits
are reset and so the next port flush will not cause such problem again.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v1
 - explain how the 2 extra bits affect the flushing operation
 - write directly to disable the default SW_FWD_MCAST_SRC_ADDR bit and so
   no need to read the register first

 drivers/net/dsa/microchip/ksz9477.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index f8ad7833f5d9..2231128eef8b 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -355,10 +355,8 @@ int ksz9477_reset_switch(struct ksz_device *dev)
 			   SPI_AUTO_EDGE_DETECTION, 0);
 
 	/* default configuration */
-	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
-	data8 = SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
-	      SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE;
-	ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
+	ksz_write8(dev, REG_SW_LUE_CTRL_1,
+		   SW_AGING_ENABLE | SW_LINK_AUTO_AGING | SW_SRC_ADDR_FILTER);
 
 	/* disable interrupts */
 	ksz_write32(dev, REG_SW_INT_MASK__4, SWITCH_INT_MASK);
-- 
2.34.1


