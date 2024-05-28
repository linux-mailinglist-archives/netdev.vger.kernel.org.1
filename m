Return-Path: <netdev+bounces-98776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E88D270A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153361F23EC4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780507345A;
	Tue, 28 May 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g5TU9e63"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B912FB2;
	Tue, 28 May 2024 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931874; cv=none; b=BN4DECeJGtnFvGF5X1hcflaMH1PHTOP6TzNFgKNeZzO03tb8S3wdNbBKwJoz5tu+Gx/fUiBbW7ugJTLgX28jKiwUlQeBb9ppvuiESFkrvxn9sETpuMEZhH9peLuWbr4+dOofIL2C6x2Nk+SnUIr2NAWGCWi6EFmEAp7sJTKlESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931874; c=relaxed/simple;
	bh=qhikkG0+J3ao9eUj/gAqD8DTEQECSMaXK+bVgpJ4E1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7ujkgUQyQsmmGWGQtKr5mG1g7njwxWXL1qzf69Zi0A8rurTGMCW5Noih2F+W8n2vfn+2OrQOwF7N9ibGcYJKBoWMZlw0RkSeY+1qfl9y7TGGV+suMa6YVz+KAXLIkmikWq3/MxT+2HxANk2yH4SUVu1hHWX8EJ4XFwa/Sp0Pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g5TU9e63; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716931873; x=1748467873;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qhikkG0+J3ao9eUj/gAqD8DTEQECSMaXK+bVgpJ4E1s=;
  b=g5TU9e639SuOhYJRrE0Oe3L7LRtXLPVlb7OM4JjqED83PPTl9MtGw6wN
   +K3SR/mYDl55KFrj4LBstIOz4Oly4Mxmr0JQFeA+DGgeeVTSiJbhCtoXz
   KDFb/rLTDY2Yc88z+Jz0ldyNC8EX4rCOyy51AsClMnfLQK0yq2I8nyGZw
   ctWImbjVAE4B3QEQV7KXm7cDTyTxFMfcwcOgMXLbpcFHSILZkHJs24Oz4
   /+RY2EXgshujKpfWNWDiG/TAc4FlDkxaPl1nssShzeu8hN9UvBb4vwLj9
   LB84M+fw69ywm11Nds6gbkvhVpQ4cu/G9k28xfQUBtEkEZILGbseN2bwO
   A==;
X-CSE-ConnectionGUID: /9I5zD/kRmu9YPlRbLYtAg==
X-CSE-MsgGUID: Oe2pBzO0RKiwpp5fvrsyVw==
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="26625587"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 14:31:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 14:31:05 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 28 May 2024 14:31:04 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: fix RGMII error in KSZ DSA driver
Date: Tue, 28 May 2024 14:34:26 -0700
Message-ID: <1716932066-3342-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The driver should return RMII interface when XMII is running in RMII mode.

Fixes: 0ab7f6bf1675 ("net: dsa: microchip: ksz9477: use common xmii function")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Acked-by: Jerry Ray <jerry.ray@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1e0085cd9a9a..2818e24e2a51 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3142,7 +3142,7 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 		else
 			interface = PHY_INTERFACE_MODE_MII;
 	} else if (val == bitval[P_RMII_SEL]) {
-		interface = PHY_INTERFACE_MODE_RGMII;
+		interface = PHY_INTERFACE_MODE_RMII;
 	} else {
 		interface = PHY_INTERFACE_MODE_RGMII;
 		if (data8 & P_RGMII_ID_EG_ENABLE)
-- 
2.34.1


