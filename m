Return-Path: <netdev+bounces-192655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EACAC0AF5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222044E763A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65428A700;
	Thu, 22 May 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oXLSj4+A"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDD28934B;
	Thu, 22 May 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915192; cv=none; b=IZqY/00fTFHaWwc++6xYoqTw25ZHFqoCmktJ9b2vtHY4hufwEZ+G1VF1zz0m7G8nSRXkXLKMw/of8bl1H8whuzDtF5fkg7rbgzWXuABz7bCZwMumy01gNmf5yqVC+2M65PIjc1HqWBA7WCiFq9nKyC3TKbmLmfJDTTMaKg7sB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915192; c=relaxed/simple;
	bh=PF9dmA4Hm1iB100iBDu8fLWsebQWAajt/CAuvNHw/b4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cNal2sVzU3030HdXOPdbUDfZ1kwgpmKAoOjPYsDY7N5XwHuUElyGhFlB4xHnOcgBaozdvPJud2VN+E4i8Ifz2TPEhP34dz2B7KuMGqowTS6oq5aj/sc+vv+WvvNnj1rgiQyGmh/39b6h92JC7RPBmKS7bj+F0Jp7xhDFAOqlHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oXLSj4+A; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747915190; x=1779451190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PF9dmA4Hm1iB100iBDu8fLWsebQWAajt/CAuvNHw/b4=;
  b=oXLSj4+AM6V7Hx6H4Vd/MTGTw/ap19zOVrMqRhzPYOx5v+uR8jerXbDI
   fmpTHj2WMD0/WTMOOtJnX1+0vbU+7biawwQXfJAUne69zEcqd2fH9mlPg
   CyIZIyoUYE8FRZ9mWO+7dfIIwGBqW+D2q0FP1E5shcRLJqpWT+usr8Lb5
   EgbKlZAis/GtMXFzGfsitmqwZFX6FZovnvH3wwm6x6LjJ3xFp0XVfUPF+
   4XvBMP82KXHI0gyzHBG+2t/LAmm7oFcn0sraji9/ALozsYlrTncx7Dh96
   rc8X1XQhrP5r1PxYiGUWnGwVs94/TWM1vsvc/Qxaf1dV6Qfj063R8sE3n
   Q==;
X-CSE-ConnectionGUID: Qq+9gTYBQQW18d+HaTQ8Ow==
X-CSE-MsgGUID: 2s/v/hcwTQuInFP4o9FnRA==
X-IronPort-AV: E=Sophos;i="6.15,306,1739862000"; 
   d="scan'208";a="46766031"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2025 04:59:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 04:59:09 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 04:59:06 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <kory.maincent@bootlin.com>,
	<shannon.nelson@amd.com>, <rrameshbabu@nvidia.com>,
	<viro@zeniv.linux.org.uk>, <quentin.schulz@bootlin.com>, <atenart@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2] net: phy: mscc: Fix memory leak when using one step timestamping
Date: Thu, 22 May 2025 13:57:22 +0200
Message-ID: <20250522115722.2827199-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fix memory leak when running one-step timestamping. When running
one-step sync timestamping, the HW is configured to insert the TX time
into the frame, so there is no reason to keep the skb anymore. As in
this case the HW will never generate an interrupt to say that the frame
was timestamped, then the frame will never released.
Fix this by freeing the frame in case of one-step timestamping.

Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

---
v1->v2: Free the skb also when ptp is not configured
---
 drivers/net/phy/mscc/mscc_ptp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index ed8fb14a7f215..6f96f2679f0bf 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1166,18 +1166,24 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
 
 	if (!vsc8531->ptp->configured)
-		return;
+		goto out;
 
-	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_OFF) {
-		kfree_skb(skb);
-		return;
-	}
+	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_OFF)
+		goto out;
+
+	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		if (ptp_msg_is_sync(skb, type))
+			goto out;
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 	mutex_lock(&vsc8531->ts_lock);
 	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
 	mutex_unlock(&vsc8531->ts_lock);
+	return;
+
+out:
+	kfree_skb(skb);
 }
 
 static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
-- 
2.34.1


