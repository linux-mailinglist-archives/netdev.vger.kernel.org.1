Return-Path: <netdev+bounces-210292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7BFB12AD8
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 16:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6AE7B0858
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7B207669;
	Sat, 26 Jul 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RHkJNp4K"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86F1A5BAF;
	Sat, 26 Jul 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753538812; cv=none; b=lUeIaLXYfwMD1ybNbsGRQiF+7mFNUK0Ze5z3ELFtLW1EmHZ4VAgfdjOsA8tA6UOH8NIoowoBuRo2rvNWuQS25LzoT2T5VmTWYLbvW7sfsAiVI9He5THx051arGDDAFbYQ3Bfe54qROBQoDSWSFqUCO795As9a2m1kKPf9DmpNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753538812; c=relaxed/simple;
	bh=623Hd04OMS2Ej99XxCHARAevY27XQrlv7B2c/Aw9oOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YRgVJXqbO6ZPcDPcdCOfu0XujLvG//iuIVjxhkVb1tbmfabXMuZJ3xGsP2NXTPILQTDG/BzI+W7MwHdtq33DtXpKwes2FEZ0vid+q+9RptR1oX5y44rw4bPBK6leUlVCYVh7NoBK6LpvoSKZj6gW5ItDo/C1aiflw3x3apm+bT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RHkJNp4K; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753538812; x=1785074812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=623Hd04OMS2Ej99XxCHARAevY27XQrlv7B2c/Aw9oOo=;
  b=RHkJNp4KiqG6BbePp4kF4fWdmYcJWOCmpRX5aseWCYY1fJMDlTaAYpVI
   oXalpHJXE0YyMvRFjGpk61ztCGdwqs4JHJoQfVMGKdA3CL9Zch7LI2KbJ
   H7ryg74SpIUbXFs7yTCdkTJwLp1IIjCCwNTZCjLsroAxIleN/n7ne/4yV
   1+9fC18Nd8AGg8ntf03OM70ekHbTppQyZGjGv4Xk+2d8S22LVBIifKdzp
   wd4WEe+rE+YM7AsVYQScGNrnliftc5YYvcHYp7+zAgOG7cM8IMff+LBba
   UoiP4hIUVbvhH+lugprboZD2mqHUb6E3u5xYAAD285hl/AKMZ37ARk5pM
   w==;
X-CSE-ConnectionGUID: RIQvQkNBTnq3luoL6v8zAg==
X-CSE-MsgGUID: 5+W5u1H7T6eEQG7TXrIlrA==
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="275844670"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2025 07:06:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 26 Jul 2025 07:06:41 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sat, 26 Jul 2025 07:06:39 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] phy: mscc: Fix parsing of unicast frames
Date: Sat, 26 Jul 2025 16:03:07 +0200
Message-ID: <20250726140307.3039694-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

According to the 1588 standard, it is possible to use both unicast and
multicast frames to send the PTP information. It was noticed that if the
frames were unicast they were not processed by the analyzer meaning that
they were not timestamped. Therefore fix this to match also these
unicast frames.

Fixes: ab2bf9339357 ("net: phy: mscc: 1588 block initialization")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc_ptp.c | 1 +
 drivers/net/phy/mscc/mscc_ptp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 6b800081eed52..275706de5847c 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -900,6 +900,7 @@ static int vsc85xx_eth1_conf(struct phy_device *phydev, enum ts_blk blk,
 				     get_unaligned_be32(ptp_multicast));
 	} else {
 		val |= ANA_ETH1_FLOW_ADDR_MATCH2_ANY_MULTICAST;
+		val |= ANA_ETH1_FLOW_ADDR_MATCH2_ANY_UNICAST;
 		vsc85xx_ts_write_csr(phydev, blk,
 				     MSCC_ANA_ETH1_FLOW_ADDR_MATCH2(0), val);
 		vsc85xx_ts_write_csr(phydev, blk,
diff --git a/drivers/net/phy/mscc/mscc_ptp.h b/drivers/net/phy/mscc/mscc_ptp.h
index da3465360e901..ae9ad925bfa8c 100644
--- a/drivers/net/phy/mscc/mscc_ptp.h
+++ b/drivers/net/phy/mscc/mscc_ptp.h
@@ -98,6 +98,7 @@
 #define MSCC_ANA_ETH1_FLOW_ADDR_MATCH2(x) (MSCC_ANA_ETH1_FLOW_ENA(x) + 3)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_MASK_MASK	GENMASK(22, 20)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_ANY_MULTICAST	0x400000
+#define ANA_ETH1_FLOW_ADDR_MATCH2_ANY_UNICAST	0x200000
 #define ANA_ETH1_FLOW_ADDR_MATCH2_FULL_ADDR	0x100000
 #define ANA_ETH1_FLOW_ADDR_MATCH2_SRC_DEST_MASK	GENMASK(17, 16)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_SRC_DEST	0x020000
-- 
2.34.1


