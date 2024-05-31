Return-Path: <netdev+bounces-99618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607CC8D582F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEF1C212D5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF732848D;
	Fri, 31 May 2024 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jlT9UCFF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803217997;
	Fri, 31 May 2024 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119333; cv=none; b=Yf6KDTKXniulUJXiJ9iDAi52jCo32orpG0Hl0ovwsvxPa1Crk/DDUPoGaFeZS2UZ4oWtcZoHUBJ/fEad//wV0V371ycJU0j6D822nx0fEbHyVL6jv8FfROu/Q9Jz8RI/Nu9UFiDXcDO1Mz/+qAf3g1TmqwvfjTTUKCy1tfHJx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119333; c=relaxed/simple;
	bh=zLFIT7XW4up0CVQnRvr8v7E+UFd7Ne27jN3zvsFPxlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMy5qcZ0JUqa3wNaiL+eJr0uYTEQWCHX97eDX/6Fnkg3UwkpD4J54FpZH3J5ly3EkItUscUVDARgLVJ2rX3oLKO7hy2pMTbl2nbl33ETVQNFOnJCNresisHqoYxoUoxu53EFusLQXIoq9apwkmNv+OhazuZDBmhB+8kpoQCqwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jlT9UCFF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717119332; x=1748655332;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=zLFIT7XW4up0CVQnRvr8v7E+UFd7Ne27jN3zvsFPxlU=;
  b=jlT9UCFFzQzEOJP4gTciLZzXL4TkL9zO2OCpuHPKH25gIhnFdgXc1fni
   tEjxQvCKarR8b/f06cVNa5thPz4iTv692sZMX+aCqi/uP4ITUsDwlFI6m
   2PjZxQf8DczU35jJI3yHesMb6gz+Cagf/FcLvRn7jtySnQQQSPhivHNi2
   2tx7IZ60IllEBdoPRW64Ff5K9f8zgwSJZYD0C8NdFaQUDD653I/NgPkNw
   yspGW1hXVrj//Oz03Wl6if6zyBme0rhNC+UapKNDuWsbM/55B5eBdNHrE
   FUSLm5KtMC5p/sS2ZjqgQ3FkEr0mnPPod3ZxomvklSEPFD7KXq4vuV7Nm
   Q==;
X-CSE-ConnectionGUID: uaX4rQuDRYaqKusCUzsbmg==
X-CSE-MsgGUID: VbXv9pbSRWe4ULR1kz/fsQ==
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="27407181"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2024 18:35:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 18:35:09 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 18:35:08 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH v1 net] net: dsa: microchip: fix RGMII error in KSZ DSA driver
Date: Thu, 30 May 2024 18:38:31 -0700
Message-ID: <1717119511-3401-1-git-send-email-Tristram.Ha@microchip.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v1
- Add review from Andrew Lunn

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


