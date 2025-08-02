Return-Path: <netdev+bounces-211432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B46B189D9
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB12626A1C
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C30AF9C0;
	Sat,  2 Aug 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WNFRdf49"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D1AD5A;
	Sat,  2 Aug 2025 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094203; cv=none; b=ZTul9+3PjSfwdDf/1HUecqQBCsmsbxG+Zu4EwkdqjwKyXxi4sylvS19WOEaIfQuNzv29Zu4SAb9iuhfA3twSPyaqMzBtf7Rhd+yrKGz8C+vAnhNtf9VXA+5ssY1BebQ0wCjrhtza0OfCza+dsHTVlOR7RNYeDJvkREnAuMnLw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094203; c=relaxed/simple;
	bh=qPr6XJteyUG7b/XqJ7b6KFN1JCYuhGTQkFlq7rLfCas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZzOgT704kegpP6lwc49nSlHHJUenTQwppz92VYlZZxsCAhy8nxuvV1R0oxnwgdUN2U9BdytsT1eXLDPgX89yHm9FNQuWVU06cGpZmbKQQRX0tM3bM/WsdopE2VvauzNW5/6Z3NAoAf+OY3ZQuZ5NRaULH3AjDX8fVuX2yGLinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WNFRdf49; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754094201; x=1785630201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qPr6XJteyUG7b/XqJ7b6KFN1JCYuhGTQkFlq7rLfCas=;
  b=WNFRdf49IZbrwGivWX2jRqashwJLckx1oNve5VTyBVo0kmanzaEPpZoM
   dUwg0SkPfs1fNLQtnRnSiZliCWMSkuMLDeIQNJhrSLr81Ausnca7YEfPo
   NV982tHZAT996T8S0/1xGz+qatO8DROjFEMH+jHsj8UM657BiIGcMBg36
   HgMU5gmtWuX5foMH32SJPOf/xLn4wvRVnSGfNzC/vkK7dmTe6TgxWT34V
   ZNsEX3LxkVC8s1fwfcO8Mol0VcjaO/NKimiqpBnz14N5Wg9gQ5xYq8nsc
   5y9btSO5AWNJ3Cg7BjYj1Gf7R8fHZeyYf3msA5oQGUdZZrpvo2yc2gAVF
   Q==;
X-CSE-ConnectionGUID: JuC/NCVjQ62LEWY/sgsqSQ==
X-CSE-MsgGUID: HcKIG/VFTKiMJ+g0arhJwA==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="212144311"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2025 17:23:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 17:22:44 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 1 Aug 2025 17:22:44 -0700
From: <Tristram.Ha@microchip.com>
To: Oleksij Rempel <linux@rempel-privat.de>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: Fix KSZ8863 reset problem
Date: Fri, 1 Aug 2025 17:22:53 -0700
Message-ID: <20250802002253.5210-1-Tristram.Ha@microchip.com>
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

ksz8873_valid_regs[] was added for register access for KSZ8863/KSZ8873
switches, but the reset register is not in the list so
ksz8_reset_switch() does not take any effect.

ksz_cfg() is updated to display an error so that there will be a future
check for adding new register access code.

A side effect of not resetting the switch is the static MAC table is not
cleared.  Further additions to the table will show write error as there
are only 8 entries in the table.

Fixes: d0dec3333040 ("net: dsa: microchip: Add register access control for KSZ8873 chip")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 7 ++++++-
 drivers/net/dsa/microchip/ksz_common.c | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 76e490070e9c..6d282a8e3684 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -36,7 +36,12 @@
 
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
+	int ret;
+
+	ret = regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
+	if (ret)
+		dev_err(dev->dev, "can't update reg 0x%x: %pe\n", addr,
+			ERR_PTR(ret));
 }
 
 static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7292bfe2f7ca..4cb14288ff0f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1447,6 +1447,7 @@ static const struct regmap_range ksz8873_valid_regs[] = {
 	regmap_reg_range(0x3f, 0x3f),
 
 	/* advanced control registers */
+	regmap_reg_range(0x43, 0x43),
 	regmap_reg_range(0x60, 0x6f),
 	regmap_reg_range(0x70, 0x75),
 	regmap_reg_range(0x76, 0x78),
-- 
2.34.1


