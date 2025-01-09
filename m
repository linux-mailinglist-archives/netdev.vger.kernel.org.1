Return-Path: <netdev+bounces-156849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7797A07FF4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235261884102
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089751F8AE2;
	Thu,  9 Jan 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y/1kJ064"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195C1A238E;
	Thu,  9 Jan 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447924; cv=none; b=VdoIkrwVvTfrKMsRxC3PJU2WLao0f84ZQOUcEAsLrsx7eREv/UHMQUbBiXmhKa2yJcFxqOinRVnJnFz+akwLJ99xCzL9Ukf1rxTYfVEWk3LIATjWp5tL2cZC9W6OvC+Wl8BE2JAvAa1Co0UKXUOjf/qM5jZX0bVMZjatAeZmOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447924; c=relaxed/simple;
	bh=v7GYtFPyZViNkQDmJDnHFq7M6Py30knW0IeoNMAUuog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HiYyCTFxkF9oo+BrUmEKMWPx0ZWGKvU0+rKS9y6lbNF3HWOMU5D2G6IDP3vaVhyJIWd4qKJe2xv2diBy8fRDiDNhdrnl/MHTi4QtV8nSyF6x6xhRWnsTarLIb73uZ80667fOrh6F374K47GdKrysRvGa+H129yCa8HwHFgU0cxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y/1kJ064; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736447923; x=1767983923;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v7GYtFPyZViNkQDmJDnHFq7M6Py30knW0IeoNMAUuog=;
  b=Y/1kJ064Yq+X2kittoqr78XW6oB+g1/WivEow2WFGFShQPMEg3tyE71h
   1NVdngkAFOlh34kquT33FVuhOQOi4URBjk1CjpprdZt26aymJNuQ5E6vM
   EDz05VcDkN8Tlxdjo8jZXw9UQEfnN+9rSFud53psw2wql2mTrI4eLq3aC
   e2VSxbDs5N8cd8FSkfk8IuL5c04jkcWX5hboDwIvWDTphU37Qf5+bJMvT
   gHviaEGdbMRgss8grLh+8dHlSSgRh7v179BCiXiDmTGJi7bmRcL2HZzCr
   RjrmoiDXyx9n2LcXUtu5zqTaIvbi+9FkWqH7w/s8A2sH/IiJYZzK6R2vz
   g==;
X-CSE-ConnectionGUID: EEpZxm35SCOeNwgRklSfsQ==
X-CSE-MsgGUID: 7usoUu3MTqeXlqJjbnqndQ==
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36007573"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 11:38:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 11:38:18 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 11:38:15 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 9 Jan 2025 19:37:56 +0100
Subject: [PATCH net-next 4/6] net: sparx5: move SKB consumption to xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-sparx5-lan969x-switch-driver-5-v1-4-13d6d8451e63@microchip.com>
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

Currently, SKB's are consumed in sparx5_port_xmit_impl(), if the FDMA
xmit() function returns NETDEV_TX_OK. In a following commit, we will ops
out the xmit() function for lan969x support, and since lan969x is going
to consume SKB's asynchronously, in the NAPI poll loop, we cannot
consume SKB's in sparx5_port_xmit_impl() anymore. Therefore, move the
call of dev_consume_skb_any() to the xmit() function.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c   | 2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index fdae62f557ce..cb78acd356d2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -239,6 +239,8 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 
 	sparx5_fdma_reload(sparx5, fdma);
 
+	dev_consume_skb_any(skb);
+
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index b6f635d85820..e776fa0845c6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -272,7 +272,6 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
 	    SPARX5_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
 		return NETDEV_TX_OK;
 
-	dev_consume_skb_any(skb);
 	return NETDEV_TX_OK;
 drop:
 	stats->tx_dropped++;

-- 
2.34.1


