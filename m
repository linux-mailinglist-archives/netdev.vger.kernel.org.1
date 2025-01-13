Return-Path: <netdev+bounces-157862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA00A0C19E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EA5188B209
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4AF1CCEF6;
	Mon, 13 Jan 2025 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LQIPhOpd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CE1C5F1B;
	Mon, 13 Jan 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796995; cv=none; b=XXWfjRdM4KcuLomex+Gb3nntL44dBWrnkV1ihMvB0mhH9RLeC79dd/d1UZEgqNgo5ZQfUhNgti2Z3C9ZF8C/9OFQxtmaYdp/WlpPuE8xLazodwcrEIpAkpPRdx1AMsf6W3UlF+UAnzwgdOOBdp2gpNlkX9UzQUdHa94dr4ZDipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796995; c=relaxed/simple;
	bh=J2M9/MtCDlgYilNahaNA6XZPwjCl15h2CgtaBcerqow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Er/Utp5XQAu1uaqzf5Z7Ssw/bnLW5fbu4PJ8gxOFQ7mHMyO9nbe/SsQZgTzjtrCVb3G7A2EAcrXJHvFcXuCebK+l28QeOMwNnGYBoOv7iPyY5wYNnS2AljLJQ1uZabqFRtpQKUAYY1l5FBQCLe8ibGdrbUfu1B2aZ2cHWc1YW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LQIPhOpd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736796993; x=1768332993;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=J2M9/MtCDlgYilNahaNA6XZPwjCl15h2CgtaBcerqow=;
  b=LQIPhOpd7REl9VGc15bgB1tthLcIaB43JhR6BNftXjvMIGstVa7hKhKf
   gg7t1mVK0QTlxzbWGbH/cyyzhtFeManezXBQ8MlXT9ePEvh0SdYmZbqb9
   e9csOb05x/pVM3j6Rg6W9VWxWaGrShgwPR3AiBqJRkNdzIhiiEEmwOLqh
   3MT5bAPgewEr/XnhCM/3R0Z3+VK6lGbsxS1Q0BVcTKXCaijILiNa5rdys
   eq9TfeNuyj4KJ9LswLl74YTAk5p+wtz7bk8sWFj5EBqqtwpcY+qlxqm9T
   033LPce+F/ST2OD7v//sxb6XDkBVk1nN6Dnq+7Pw3FTQ2qCbx0I+R+V8v
   g==;
X-CSE-ConnectionGUID: Fja7+Z77S3CaoQEzhBU3bA==
X-CSE-MsgGUID: reRBLOXoTjGrTnehgDtFpQ==
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="203970674"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2025 12:36:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 Jan 2025 12:36:25 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 13 Jan 2025 12:36:22 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 13 Jan 2025 20:36:06 +0100
Subject: [PATCH net-next v2 2/5] net: sparx5: split
 sparx5_fdma_{start(),stop()}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250113-sparx5-lan969x-switch-driver-5-v2-2-c468f02fd623@microchip.com>
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


