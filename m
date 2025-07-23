Return-Path: <netdev+bounces-209179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1BBB0E89C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C801C25E4E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6C1F4C8E;
	Wed, 23 Jul 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tIHRfc53"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724C1E7C38;
	Wed, 23 Jul 2025 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237608; cv=none; b=gWBLe/EAAPGbWWvbd+33RWoTKD9CjUsu+w31CMB4Zcx/UnvM0W9hyMIBYfdN/6r1Ml2JOAx52/kgwYVXYUrhoMTrhPOMfS+BYG13lDKBGoHShK4xlIPlwTrcCrP8pUTSjjGl+OSSTC+7uEkEftznn7gsjW2WrGC7WfgPBaghdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237608; c=relaxed/simple;
	bh=pPSPnAUdAXPzmJliXAKAtBQbetuWfffW22gbyAsJmag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4Q66KcuS/6u1ccVxlGxJXN2wU1pJUzA8/FbDHW4Tko0axmKlY6T8ic4KvJeVEJKTGAtw/G2qpLb2Ak2tGTuQbJuvvMD8WdT5ofeEWDyt4XuWlI+EsxvUYhjEXU/YK/gFVissv33AdK2SplqWRUadnqou/cqdu4nvRg51csfrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tIHRfc53; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753237607; x=1784773607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPSPnAUdAXPzmJliXAKAtBQbetuWfffW22gbyAsJmag=;
  b=tIHRfc53JU/GoWZVwBcBWwZDGEmAOnKlzefvxOf9yjwPo0og5cM+iggQ
   7XS/yf5pZVSLoBvRRo1yyX1fPWfyhJINyYx4FHPyUol3I/ajLGOc5GjlE
   mjT1XpCQpUE56/nsrDcvDQNimdl5renfaBI5C9XHoVs8hfWyOD5B3uFaj
   cgex0dykutgyvzchF3FcAk2zEJFM/oiJCGLqmi3ZjWlEQ8bkC27yEpK6G
   66Exn3R5pooHU5Jbpn3AyPY01owVy1ImmJm15iTzscYbfg8amI6a3LRY5
   9p+RTQeQ/BYd9vEyU5Oq/fE4y2oGwISXBcHRioRKatHaq9yS2Z9oxklYf
   A==;
X-CSE-ConnectionGUID: ol8zE+5pQbyz8nKT026TwA==
X-CSE-MsgGUID: OVkGhdqYRTyKdEDLJb4zaw==
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="275694686"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2025 19:26:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 22 Jul 2025 19:26:15 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 22 Jul 2025 19:26:15 -0700
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
Subject: [PATCH net-next v5 4/6] net: dsa: microchip: Write switch MAC address differently for KSZ8463
Date: Tue, 22 Jul 2025 19:26:10 -0700
Message-ID: <20250723022612.38535-5-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723022612.38535-1-Tristram.Ha@microchip.com>
References: <20250723022612.38535-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8463 uses 16-bit register definitions so it writes differently for
8-bit switch MAC address.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/microchip/ksz_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 552c993b6519..e47c4a5aad6f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4821,7 +4821,16 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 
 	/* Program the switch MAC address to hardware */
 	for (i = 0; i < ETH_ALEN; i++) {
-		ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+		if (ksz_is_ksz8463(dev)) {
+			u16 addr16 = ((u16)addr[i] << 8) | addr[i + 1];
+
+			ret = ksz_write16(dev, regs[REG_SW_MAC_ADDR] + i,
+					  addr16);
+			i++;
+		} else {
+			ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i,
+					 addr[i]);
+		}
 		if (ret)
 			goto macaddr_drop;
 	}
-- 
2.34.1


