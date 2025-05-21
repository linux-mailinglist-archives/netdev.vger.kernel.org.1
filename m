Return-Path: <netdev+bounces-192300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478CCABF5C2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194B33AC5E0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D026983B;
	Wed, 21 May 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LYoxcSd/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2602267B74;
	Wed, 21 May 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833221; cv=none; b=GoabfVccGdEdP02/bz3aQlMab8FZbGnhx2B34KUX69duNHk0mP2L55kikxlx83mvpA0smek+f6Wnq+Aex45xcqpBkFbxbYjApiDE85DovnLo6hZyiHD1ex4Mwgzt+0ZYxEuny/S0N17OEw7+P8nmmSJQuw8LZFtRgY/BWO/hCCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833221; c=relaxed/simple;
	bh=K7L5xXjKGwqao/240GIrsFv5DITq/nJrUbkX2CFlM4Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pXv7jARHxUOnUaEpI7ANPrBM0GVex8HABAHrPQsna825VBzrtkC3l5wuiezgCPHsgIME3yh9WvhYz885R7VHl7wSGgGSczrRzRQPm74v0GUSNVAzUHBP9M/siiWqITAXcw/M1dFRNV9nIVszVbdCdqmID9c/f+wR7GyEQAjzT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LYoxcSd/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747833220; x=1779369220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K7L5xXjKGwqao/240GIrsFv5DITq/nJrUbkX2CFlM4Q=;
  b=LYoxcSd/diwWCvFwtxkYuZyzXjto0SpuyiOVonnQXNtRLROy8OeiUuRz
   VuSma225dVqeTUmmZet2u/fjrxz4y1TAC6KdzZ+5vAIFx8I0z1M1c5Aop
   YBN/AQf+3Mnnhzsqk3OKv7H3pTqThC+FGtAcEzAnPUyZda+iYgq7lXlGY
   95yZzUaDe/VG3mH3O1ZoquJXUCIwAQXZa6GvK+KmHXapyB6WSGP5xhZi5
   L+oLkPF7gOXzAvg3ztfSk8R1V9VyiQhks8FRbpGdRe/bnBnFUX1SRyg1g
   713Ro5GTMewrCoHWN0Be27V4skCP2SoUAAdXdi/kQXfteOtO4RPN4Qz66
   A==;
X-CSE-ConnectionGUID: Ho6MR7HOQcaGdH2JBUdWGg==
X-CSE-MsgGUID: /e80DkcVStK6KBJCNc6+vg==
X-IronPort-AV: E=Sophos;i="6.15,303,1739862000"; 
   d="scan'208";a="273274614"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2025 06:13:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 21 May 2025 06:13:07 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 21 May 2025 06:13:05 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <kory.maincent@bootlin.com>,
	<shannon.nelson@amd.com>, <viro@zeniv.linux.org.uk>, <atenart@kernel.org>,
	<quentin.schulz@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: phy: mscc: Fix memory leak when using one step timestamping
Date: Wed, 21 May 2025 15:11:14 +0200
Message-ID: <20250521131114.2719084-1-horatiu.vultur@microchip.com>
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
 drivers/net/phy/mscc/mscc_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index ed8fb14a7f215..db8ca1dfd5322 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1173,6 +1173,13 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 		return;
 	}
 
+	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_ONESTEP_SYNC) {
+		if (ptp_msg_is_sync(skb, type)) {
+			kfree_skb(skb);
+			return;
+		}
+	}
+
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 	mutex_lock(&vsc8531->ts_lock);
-- 
2.34.1


