Return-Path: <netdev+bounces-156847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ECAA07FF0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C09160717
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D969219E7F7;
	Thu,  9 Jan 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qVHtkHAF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BB199239;
	Thu,  9 Jan 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447922; cv=none; b=W/H4MBRpgn71Mz0WHj59g1dFf+cjuJT8NLN1sAQ2+3/WtiQtut7bB8Uu+1HaTBY/U6a7NQ88YDvA8aJB9aIW1pn5skwGcJTreJOWqH/rpq7mGvTaVOqXrmwODY4eR73R3ToDZt2l9pfrpy8DXzMjclPU9bruHp5gMqoddJ7nH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447922; c=relaxed/simple;
	bh=J2M9/MtCDlgYilNahaNA6XZPwjCl15h2CgtaBcerqow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oUY2HNx3RmVzZ3oZpjAqWTcP8aQUsrI/TM1B51Zf0GAKU/WXi1qGgk0fSGUPq8ToewcPHJQQ5DbdDdt6p3Baz87nR0MiYIn0Q1Nrajpe6dMQaJUrU8WOhQ2ETdQKffuqBXVSTD/G6ubiOgPOH8YxKP/jewDMC+xEzAoQoMxSIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qVHtkHAF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736447921; x=1767983921;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=J2M9/MtCDlgYilNahaNA6XZPwjCl15h2CgtaBcerqow=;
  b=qVHtkHAF10v7oQR8R5zyKG8Q4B0E1nhEb4+AStkNKLkDrdhL9R/avzcJ
   gy4Er96MxFBweipKY16YDOPB9bjeEUDLoeE9RJ5cPpDa+sH18Crd0U1Si
   WOWgVcmxZcaYSfJ2LM+6rkKonjfkWwJTMXha5ggnnbkrissIiaJrgITND
   3CPUi/kQK3OLBkQtSFiIj62JzQRpEIbbmHm/F0dHIbGaQ5FUIq8J5J4s9
   k6/On44lSuV/u1x+nCT3x/A8kO/buDOXcPUCjA76AELExp/TshXVAF2gg
   Jmt8prsN9Gnvk+JX9KmesJVxBVh4MVo9aGMZyXFvgWLb8Q65EZ8xIHz7o
   g==;
X-CSE-ConnectionGUID: EEpZxm35SCOeNwgRklSfsQ==
X-CSE-MsgGUID: STyF79YdRnO4h5Bqofx8pw==
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36007571"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 11:38:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 11:38:12 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 11:38:09 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 9 Jan 2025 19:37:54 +0100
Subject: [PATCH net-next 2/6] net: sparx5: split
 sparx5_fdma_{start(),stop()}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-sparx5-lan969x-switch-driver-5-v1-2-13d6d8451e63@microchip.com>
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

The two functions: sparx5_fdma_{start(),stop()} are responsible for a
number of things, namely: allocation and initialization of FDMA buffers,
activation FDMA channels in hardware and activation of the NAPI
instance.

This patch splits the buffer allocation and initialization into init and
deinit functions, and the channel and NAPI activation into start and
stop functions. This serves two purposes: 1) the start() and stop()
functions can be reused for lan969x and 2) prepares for future MTU
change support, where we must be able to stop and start the FDMA
channels and NAPI instance, without free'ing and reallocating the FDMA
buffers.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 44 +++++++++++++++++-----
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  7 +++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  2 +
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 0027144a2af2..56cd206bd1af 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -260,10 +260,6 @@ static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
 	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
 		       FDMA_DCB_STATUS_INTR);
 
-	netif_napi_add_weight(rx->ndev, &rx->napi, sparx5_fdma_napi_callback,
-			      FDMA_WEIGHT);
-	napi_enable(&rx->napi);
-	sparx5_fdma_rx_activate(sparx5, rx);
 	return 0;
 }
 
@@ -410,7 +406,7 @@ static void sparx5_fdma_injection_mode(struct sparx5 *sparx5)
 	}
 }
 
-int sparx5_fdma_start(struct sparx5 *sparx5)
+int sparx5_fdma_init(struct sparx5 *sparx5)
 {
 	int err;
 
@@ -443,24 +439,52 @@ int sparx5_fdma_start(struct sparx5 *sparx5)
 	return err;
 }
 
+int sparx5_fdma_deinit(struct sparx5 *sparx5)
+{
+	sparx5_fdma_stop(sparx5);
+	fdma_free_phys(&sparx5->rx.fdma);
+	fdma_free_phys(&sparx5->tx.fdma);
+
+	return 0;
+}
+
 static u32 sparx5_fdma_port_ctrl(struct sparx5 *sparx5)
 {
 	return spx5_rd(sparx5, FDMA_PORT_CTRL(0));
 }
 
+int sparx5_fdma_start(struct sparx5 *sparx5)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+
+	netif_napi_add_weight(rx->ndev,
+			      &rx->napi,
+			      sparx5_fdma_napi_callback,
+			      FDMA_WEIGHT);
+
+	napi_enable(&rx->napi);
+
+	sparx5_fdma_rx_activate(sparx5, rx);
+
+	return 0;
+}
+
 int sparx5_fdma_stop(struct sparx5 *sparx5)
 {
+	struct sparx5_rx *rx = &sparx5->rx;
+	struct sparx5_tx *tx = &sparx5->tx;
 	u32 val;
 
-	napi_disable(&sparx5->rx.napi);
+	napi_disable(&rx->napi);
+
 	/* Stop the fdma and channel interrupts */
-	sparx5_fdma_rx_deactivate(sparx5, &sparx5->rx);
-	sparx5_fdma_tx_deactivate(sparx5, &sparx5->tx);
+	sparx5_fdma_rx_deactivate(sparx5, rx);
+	sparx5_fdma_tx_deactivate(sparx5, tx);
+
 	/* Wait for the RX channel to stop */
 	read_poll_timeout(sparx5_fdma_port_ctrl, val,
 			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val) == 0,
 			  500, 10000, 0, sparx5);
-	fdma_free_phys(&sparx5->rx.fdma);
-	fdma_free_phys(&sparx5->tx.fdma);
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 340fedd1d897..a60f6a166522 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -792,8 +792,11 @@ static int sparx5_start(struct sparx5 *sparx5)
 					       sparx5_fdma_handler,
 					       0,
 					       "sparx5-fdma", sparx5);
-		if (!err)
-			err = sparx5_fdma_start(sparx5);
+		if (!err) {
+			err = sparx5_fdma_init(sparx5);
+			if (!err)
+				sparx5_fdma_start(sparx5);
+		}
 		if (err)
 			sparx5->fdma_irq = -ENXIO;
 	} else {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 3ae760da17e2..7433a77204cd 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -436,6 +436,8 @@ int sparx5_manual_injection_mode(struct sparx5 *sparx5);
 void sparx5_port_inj_timer_setup(struct sparx5_port *port);
 
 /* sparx5_fdma.c */
+int sparx5_fdma_init(struct sparx5 *sparx5);
+int sparx5_fdma_deinit(struct sparx5 *sparx5);
 int sparx5_fdma_start(struct sparx5 *sparx5);
 int sparx5_fdma_stop(struct sparx5 *sparx5);
 int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb);

-- 
2.34.1


