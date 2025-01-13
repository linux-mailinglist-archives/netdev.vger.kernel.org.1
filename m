Return-Path: <netdev+bounces-157863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA428A0C1A5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292213A8EEC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741111CDA01;
	Mon, 13 Jan 2025 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o7kUW2uM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B11CB332;
	Mon, 13 Jan 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796996; cv=none; b=j3rdMcLF1hBZ5nXoK1ehOV52G0IIGm5JZjqayHXAeXQUFLPUbc1B0L6fjhq8o9wG5JnJIhwcSMhLuqpdVoP7in27OWlgNOOXsLw8tkXyoLuJDkV18DSxW4yf3RyOccdPOhbnYZ0AJDYGXOv0k0ZMKLTFUq/Eu86B86vHP1Ur+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796996; c=relaxed/simple;
	bh=NarY2lDYWT/7Ik5g+joQruXzb90bHeiZvEDHahiv2iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YY+CxYyel9w4zHq39y6Vm9I9/fmuCjfWxYimB1/KCgQkqoc983cjrIs5rt5X8r3DaLKFMvnHWrH7c4yIiYZVpKsmaWxylF1WGGQZSFxHEh819GG3bc2Ce241NFDNUwhutnc21oqrX+SHrbXr4pZC4XCAzNNBZiuR2oSqDpSbt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o7kUW2uM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736796994; x=1768332994;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NarY2lDYWT/7Ik5g+joQruXzb90bHeiZvEDHahiv2iw=;
  b=o7kUW2uMCCiQKOTzm0NH4FXdJ3QRzh+L7/+rv/EYEy0VfeNwz90stUjb
   sQNvp249HTHiapoGAJiq/o0imFoh9L82lORXsZXfSVKGFh73hFeONsj6h
   LXsFo4DI6vwMVvGimaAsKrrppqLKQWT8HXB8ESuPEjmvnazzQ5zUMSIph
   pK7UhhPevx9n4wRf/juRRnZor6l19Py/S3M6a9Wf+Vj/5KDAd8C8ynKbW
   GearOwpFM0OoT2aYLP4Mxb9gf8q8+2bsiRBsEyjo0QN8vu4fylZuuQ8nd
   z/XYmGs3eF43RSMdq6VvlvDcSwIqtj4USdGEPLP8mtnAr/ct+lyUdXmOu
   g==;
X-CSE-ConnectionGUID: Fja7+Z77S3CaoQEzhBU3bA==
X-CSE-MsgGUID: Wb0hUpFeQ0ara6hC8wfm6A==
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="203970675"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2025 12:36:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 Jan 2025 12:36:28 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 13 Jan 2025 12:36:25 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 13 Jan 2025 20:36:07 +0100
Subject: [PATCH net-next v2 3/5] net: sparx5: activate FDMA tx in start()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250113-sparx5-lan969x-switch-driver-5-v2-3-c468f02fd623@microchip.com>
References: <20250113-sparx5-lan969x-switch-driver-5-v2-0-c468f02fd623@microchip.com>
In-Reply-To: <20250113-sparx5-lan969x-switch-driver-5-v2-0-c468f02fd623@microchip.com>
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


