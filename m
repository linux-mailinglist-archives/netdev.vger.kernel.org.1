Return-Path: <netdev+bounces-209185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE956B0E8F2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95CF3BE8EB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F721DE3CA;
	Wed, 23 Jul 2025 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cFgZdow/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8D19C55E;
	Wed, 23 Jul 2025 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753239883; cv=none; b=OmZcBpKcCDOmCNXrYpRU0GpsM7/WX2GZ2+sMTEsrfP+loNE7ZkQ2k1MuxzzwjcsAQRA0cKyF5/N1aTCTeuQLq06j4nw2p971fwHHEXh1A6Qk9k9iCDB5FV+18lJknY5bxD+ZW8b5ql6n73ZmqQwGeFphzUWovKuD8X9BbP3O3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753239883; c=relaxed/simple;
	bh=5Nl9JET6mcAfxTbOUjqQ3aF5keMnpA8MjbKqQN9pySs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nwQxQkIBRNoC8rEVmG6luZSFYvkpdcY6PT+5KbG30TNN/IG9z0BmOD9/d2Vg4Uj0FEORE4k58ahR8kTiSLTwhbVVdvk1wu6qux6hS4xLHvCWaHGtTxa7Pkfh8eMwXCxjSLCTTTu5vMPV3UGbGAxUqKv0Ou9H3Vidl+tScTmFJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cFgZdow/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753239882; x=1784775882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Nl9JET6mcAfxTbOUjqQ3aF5keMnpA8MjbKqQN9pySs=;
  b=cFgZdow/CXy96FAXjzRyKrHl5Uho2a6u00cjJsWcglborD0a+7W/RXYw
   PsCF3fl7LwW5gFxdNS+6paTKs2Bvy/uigm3NHCzGK/0oonA6sj6LWDW/g
   x3PwwVlrYiBW5jGVdFFUOKccgYClFRaaV+gpoet4jRLA1vly3HsGL3sYy
   XzQL8KyZnXxL+qhkTFDVURYji51HHIvTYulLDUIW7wfW01XfrLFpj3CJ9
   t/WhkihoxS4krsHD0Rwdi68Kx3IsE1j9lsuaxPfv3P2KziH/ta+3+dZUc
   Mv+ex4UDkpWpTX8EsoTz54DkI5FKRJY2V816rrYVBNcKYlP+t+5fS/ISw
   Q==;
X-CSE-ConnectionGUID: xSVfhEo0TXyd97+4CNr+4g==
X-CSE-MsgGUID: d7oyaCNFS9GZ22ZTmNzXvg==
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="43781679"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2025 20:04:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 22 Jul 2025 20:04:04 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 22 Jul 2025 20:04:04 -0700
From: <Tristram.Ha@microchip.com>
To: Oleksij Rempel <linux@rempel-privat.de>, Michael Grzeschik
	<m.grzeschik@pengutronix.de>, Woojung Huh <woojung.huh@microchip.com>,
	"Andrew Lunn" <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: Fix wrong rx drop MIB counter for KSZ8863
Date: Tue, 22 Jul 2025 20:04:03 -0700
Message-ID: <20250723030403.56878-1-Tristram.Ha@microchip.com>
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

When KSZ8863 support was first added to KSZ driver the RX drop MIB
counter was somehow defined as 0x105.  The TX drop MIB counter
starts at 0x100 for port 1, 0x101 for port 2, and 0x102 for port 3, so
the RX drop MIB counter should start at 0x103 for port 1, 0x104 for
port 2, and 0x105 for port 3.

There are 5 ports for KSZ8895, so its RX drop MIB counter starts at
0x105.

Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz88xx chips")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c     | 3 +++
 drivers/net/dsa/microchip/ksz8_reg.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index be433b4e2b1c..8f55be89f8bf 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -371,6 +371,9 @@ static void ksz8863_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 	addr -= dev->info->reg_mib_cnt;
 	ctrl_addr = addr ? KSZ8863_MIB_PACKET_DROPPED_TX_0 :
 			   KSZ8863_MIB_PACKET_DROPPED_RX_0;
+	if (ksz_is_8895_family(dev) &&
+	    ctrl_addr == KSZ8863_MIB_PACKET_DROPPED_RX_0)
+		ctrl_addr = KSZ8895_MIB_PACKET_DROPPED_RX_0;
 	ctrl_addr += port;
 	ctrl_addr |= IND_ACC_TABLE(TABLE_MIB | TABLE_READ);
 
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 329688603a58..da80e659c648 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -784,7 +784,9 @@
 #define KSZ8795_MIB_TOTAL_TX_1		0x105
 
 #define KSZ8863_MIB_PACKET_DROPPED_TX_0 0x100
-#define KSZ8863_MIB_PACKET_DROPPED_RX_0 0x105
+#define KSZ8863_MIB_PACKET_DROPPED_RX_0 0x103
+
+#define KSZ8895_MIB_PACKET_DROPPED_RX_0 0x105
 
 #define MIB_PACKET_DROPPED		0x0000FFFF
 
-- 
2.34.1


