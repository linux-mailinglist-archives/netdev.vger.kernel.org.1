Return-Path: <netdev+bounces-156848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2DA07FF2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FA33A7CB6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921671AAE33;
	Thu,  9 Jan 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XB37ybMu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879319E7FA;
	Thu,  9 Jan 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447924; cv=none; b=itu6K7BQsDWyomq4x+dQhd9X5A64hBL+VBxAssFyIST7pgwGUmbkRNeEbagI+lQ6vD+2fcUu5jo5pgfEdIIRacVkIYE37DvGRXW2G7R2N01UaaWrsIQ6XS9dYI4HqTDLAvM6NAZhDySeeV8Oz9qt9/UbSpgyuopBJYwRRCyJ6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447924; c=relaxed/simple;
	bh=NarY2lDYWT/7Ik5g+joQruXzb90bHeiZvEDHahiv2iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZLm6xlPzqMLiCcWNuza2MIXBZWpdOHLdbNrYuKCNdn6E3h3GzS3fikQko3KVhxP9UwQxCBfc83kxyp+IKDNAb+xzeCUc4vCuh9hTXTLXE+sYnYZOOFweVeGG1YiSiPxf18i35eyV+X6NeYkxY/xGufM+WSjr+mwIkQPzZA3B6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XB37ybMu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736447923; x=1767983923;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NarY2lDYWT/7Ik5g+joQruXzb90bHeiZvEDHahiv2iw=;
  b=XB37ybMuyuvyloTZLwjWijkeQMn+44Hj3aQvFT5LHUrf+rsNOShkaWLY
   JylJ1cfFJDItoekGylfZ0KHet0qoE+71nQm4piGLwb2b4cHqgjhe7sQnd
   vVSWeNO8yhl3O176nvsZ3pOMi+18wfkmgU5t+vkcHjkZaarueFp1mo17A
   GceJpRWwqiOmGF3F93owEAMsdaQqueQ703FOJD5LLRNsMFb+HeXkhKgHG
   Qx2a6UgZ/Dssr7X/8+WTDUcYrrBbec1HDrQWj/XBILF8sJTOzXbiuxBU7
   krKuoK/1awV3PXkqXK54cJCB/wI2yXGRCrYVIxPVOyHevVLtW733JZvsZ
   A==;
X-CSE-ConnectionGUID: EEpZxm35SCOeNwgRklSfsQ==
X-CSE-MsgGUID: BqTo9F8fS1u5PV2T/3Zyjw==
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36007572"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 11:38:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 11:38:15 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 11:38:12 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 9 Jan 2025 19:37:55 +0100
Subject: [PATCH net-next 3/6] net: sparx5: activate FDMA tx in start()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-sparx5-lan969x-switch-driver-5-v1-3-13d6d8451e63@microchip.com>
References: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
In-Reply-To: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The function sparx5_fdma_tx_activate() is responsible for configuring
the TX FDMA instance and activating the channel. TX activation has
previously been done in the xmit() function, when the first frame is
transmitted. Now that we have separate functions for starting and
stopping the FDMA, it seems reasonable to move the TX activation to the
start function. This change has no implications on the functionality.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 56cd206bd1af..fdae62f557ce 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -217,7 +217,6 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 {
 	struct sparx5_tx *tx = &sparx5->tx;
 	struct fdma *fdma = &tx->fdma;
-	static bool first_time = true;
 	void *virt_addr;
 
 	fdma_dcb_advance(fdma);
@@ -238,12 +237,8 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 		     FDMA_DCB_STATUS_BLOCKO(0) |
 		     FDMA_DCB_STATUS_BLOCKL(skb->len + IFH_LEN * 4 + 4));
 
-	if (first_time) {
-		sparx5_fdma_tx_activate(sparx5, tx);
-		first_time = false;
-	} else {
-		sparx5_fdma_reload(sparx5, fdma);
-	}
+	sparx5_fdma_reload(sparx5, fdma);
+
 	return NETDEV_TX_OK;
 }
 
@@ -456,6 +451,7 @@ static u32 sparx5_fdma_port_ctrl(struct sparx5 *sparx5)
 int sparx5_fdma_start(struct sparx5 *sparx5)
 {
 	struct sparx5_rx *rx = &sparx5->rx;
+	struct sparx5_tx *tx = &sparx5->tx;
 
 	netif_napi_add_weight(rx->ndev,
 			      &rx->napi,
@@ -465,6 +461,7 @@ int sparx5_fdma_start(struct sparx5 *sparx5)
 	napi_enable(&rx->napi);
 
 	sparx5_fdma_rx_activate(sparx5, rx);
+	sparx5_fdma_tx_activate(sparx5, tx);
 
 	return 0;
 }

-- 
2.34.1


