Return-Path: <netdev+bounces-115152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619F94551A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9861F231DA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67577F6;
	Fri,  2 Aug 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="il03V0sn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDF360;
	Fri,  2 Aug 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557138; cv=none; b=YU+vT5bbcyO6pcDmcJa8DKqtsmbXLLNiSE14Hir4ZRDY1+Fhc1YmZzcqre2NgNfHX5sCWA25LULdhESxh+c+INCpMHWVyLbgowMFXGjn9Gx+cV091MAtsE282zHVtveNxLzxQ3er7nXhA7xBCHtkifrPHu7T2lR45eQhjES10V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557138; c=relaxed/simple;
	bh=Mk+Wb2FalPTBQ7RngNErfEg66fBNQpeyb/IVX6aSUYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gAE9Fka7NY5Wk6ZXDyhKV0vE1E4z3akoX9kHunWUm5+fZJMrLGRm2N/oIA6nxYXMKaPUx7A/jBmj3s0CG5jdLtEI0FVJ1O2GsuuzoMTp+4QXHE1J2c963ufYuqIgDhEhulv4k7mQHN+BTFfuHIxkHVMWWXSpERRgZFG1vMnHj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=il03V0sn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722557137; x=1754093137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mk+Wb2FalPTBQ7RngNErfEg66fBNQpeyb/IVX6aSUYE=;
  b=il03V0snNU6EYCCbOe5uW3UDya43ryA+T8I350X7SaQhwj/xPZCVYTdv
   uA493G9k/vFQCl7Jp1kBUwRYmClRUNVj2qnAr5heUyEQeAK36LsQpjzSU
   ibWJkzgfVtORpPDV2acdAxoOuTb1sUf5JAYgNLRhmLraa7LuxJx0D2RMi
   yirjIGVpG54dG95eKtAtUUh+h5ZnThjh9QDglV2X5JwLw+c3Cb9AC+GPJ
   k7hnTjjrTndoF5y720EuxFee57evAdL7D3sMgUZEuzCJZIbpbuv2OGwo7
   fB2pXbNGgGpm1atV0og896mM0TcscnzpqtW0zCScgHWs7L9cHZQZJyZ1F
   g==;
X-CSE-ConnectionGUID: Nd1Mm3CYRsmzk10QRL3M7w==
X-CSE-MsgGUID: znJPEgPDS0Sx0oMgty1lSw==
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="30662038"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2024 17:05:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Aug 2024 17:05:10 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 1 Aug 2024 17:05:10 -0700
From: <Tristram.Ha@microchip.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot
	<vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	"Vladimir Oltean" <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: Fix Wake-on-LAN check to not return an error
Date: Thu, 1 Aug 2024 17:05:10 -0700
Message-ID: <20240802000510.7088-1-Tristram.Ha@microchip.com>
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

The wol variable in ksz_port_set_mac_address() is declared with random
data, but the code in ksz_get_wol call may not be executed so the
WAKE_MAGIC check may be invalid resulting in an error message when
setting a MAC address after starting the DSA driver.

Fixes: 3b454b6390c3 ("net: dsa: microchip: ksz9477: Add Wake on Magic Packet support")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b074b4bb0629..2725c5bc311c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3764,6 +3764,12 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 		return -EBUSY;
 	}
 
+	/* Need to initialize variable as the code to fill in settings may
+	 * not be executed.
+	 */
+	wol.supported = 0;
+	wol.wolopts = 0;
+
 	ksz_get_wol(ds, dp->index, &wol);
 	if (wol.wolopts & WAKE_MAGIC) {
 		dev_err(ds->dev,
-- 
2.34.1


