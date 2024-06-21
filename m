Return-Path: <netdev+bounces-105815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62453913054
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 00:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B781F240EB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE1155306;
	Fri, 21 Jun 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sy2OGDDG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67448208C4;
	Fri, 21 Jun 2024 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009128; cv=none; b=lFl3aQXpH3u9D62onmeMeqEV5dulRSOqmJQabwMd4Z0IlApDwR+W+IKPJABNnGYRIZyS1xXEcdbV6/ChMp0VJRCMJ2SzvwzdiTcU2uG2iiCMc8TNBd+b6KyB4wBHNS6ePl/t7zyKNl+G1NGqIqIV12f4LPHvBncQEe2maFW44Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009128; c=relaxed/simple;
	bh=QeaV/gigR1FI9RZaEuLwvoMRHp+ehS5UqWHrv0g8cio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXn+i7ZWwWyexzvTDKoZZpaZuHAqGIp1PsDEtMPPv9sZpOF2cSCH7Lpu273g/kSDbuNkW0+KWQ/HSecVCRZ7mY5Vmx9J9RnqVe2EX/uoJlKcQL8FAaZFBPIj0Phtu/RbExAuzDvpSQ65soDNTnxH8oVkYaaDuv6S4lhprpf74vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Sy2OGDDG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719009126; x=1750545126;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QeaV/gigR1FI9RZaEuLwvoMRHp+ehS5UqWHrv0g8cio=;
  b=Sy2OGDDGnTllCiHgQ4C12bImzeB4/gY68fWJc/zd60nZ8IZBD6NoV3h3
   TnOkbnja7KsxR9J3EQL4Zf2/sKY2z6yij9oR7/+hlhdxpHSG7JOwKKc6A
   xcopGUO3zzcKd2aO/+ykFe8q71x9RTkGgbwl9GnYCYYiK9j7vtqJB7DDA
   vdr/WXJ1f1OHmKozNatT6ryRZVJvaKCIhhowHZezcPc3/Vxo3Hw53de7P
   pGzuHvatu/JfA6lVF2EPIz0+vUFrzO1TPW9K0WPOYoVV7jEVH3cQaL062
   kwv8yXes+04Np4jHKyfo7dPmGAgNlG4H+l+IhGZDHol9TXVzGj4eQc99r
   g==;
X-CSE-ConnectionGUID: iMm8jkvNTRuUQTWGawN5rA==
X-CSE-MsgGUID: HPkZBEfsTq64Sz/5N2j+hg==
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="28992499"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2024 15:31:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Jun 2024 15:30:46 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 21 Jun 2024 15:30:46 -0700
From: <Tristram.Ha@microchip.com>
To: Arun Ramadoss <arun.ramadoss@microchip.com>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot
	<vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	"Vladimir Oltean" <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH v3 net] net: dsa: microchip: fix wrong register write when masking interrupt
Date: Fri, 21 Jun 2024 15:34:22 -0700
Message-ID: <1719009262-2948-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The switch global port interrupt mask, REG_SW_PORT_INT_MASK__4, is
defined as 0x001C in ksz9477_reg.h.  The designers used 32-bit value in
anticipation for increase of port count in future product but currently
the maximum port count is 7 and the effective value is 0x7F in register
0x001F.  Each port has its own interrupt mask and is defined as 0x#01F.
It uses only 4 bits for different interrupts.

The developer who implemented the current interrupt mechanism in the
switch driver noticed there are similarities between the mechanism to
mask port interrupts in global interrupt and individual interrupts in
each port and so used the same code to handle these interrupts.  He
updated the code to use the new macro REG_SW_PORT_INT_MASK__1 which is
defined as 0x1F in ksz_common.h but he forgot to update the 32-bit write
to 8-bit as now the mask registers are 0x1F and 0x#01F.

In addition all KSZ switches other than the KSZ9897/KSZ9893 and LAN937X
families use only 8-bit access and so this common code will eventually
be changed to accommodate them.

Fixes: e1add7dd6183 ("net: dsa: microchip: use common irq routines for girq and pirq")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v3
 - bump the number for third submission
 - provide the full explanation of modifying the code

v1
 - clarify the reason to change the code

 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1e0085cd9a9a..3ad0879b00cd 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2185,7 +2185,7 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
 	struct ksz_device *dev = kirq->dev;
 	int ret;
 
-	ret = ksz_write32(dev, kirq->reg_mask, kirq->masked);
+	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
 	if (ret)
 		dev_err(dev->dev, "failed to change IRQ mask\n");
 
-- 
2.34.1


