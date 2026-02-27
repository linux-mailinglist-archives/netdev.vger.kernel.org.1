Return-Path: <netdev+bounces-261868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKyZG5axoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:00:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 880251B95ED
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56BC0305E446
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842C42EEAF;
	Fri, 27 Feb 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T/YocOQd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43E42DFE6;
	Fri, 27 Feb 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204267; cv=none; b=URhkyTsYQBIJwqctGDg4xqriUsI43GweIgHJGU1rCSPmCfSJNAb2jChmY4SmMYYOTzFjqHSMyQepQeP7HrtvQXt804sI49wqqXlJf3JyvYYYnaUVXorGzaD39XyS+RwdDfNHTW8tdEMs0Vi8Fof+zVxUaIebH5/rEwdaiYYY6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204267; c=relaxed/simple;
	bh=JGGgjQLyYr4k2tf/YRLE0LmiapfLAIzxEgTqt5+t/F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VnB9u+EwZLmUsQXcykuXG0A95Pg+IvzDhWq953RKf3CHxO6kK8+pe8Fm4gEQFE1lRIk24fqvNV7jA+j8JHXRgns1haPw7hcaueFTM/zW/eJnpBlbDiuMFIv6yv1kftgoEphwoDMlG0xAG+FX91bOPPZ7hO8006x/U0F0Th+2afA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T/YocOQd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204266; x=1803740266;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JGGgjQLyYr4k2tf/YRLE0LmiapfLAIzxEgTqt5+t/F8=;
  b=T/YocOQd8e9zCXniuufzAykde7n1r/n8jqNJ9ctjJ9go2p8K1GU+/bj3
   IUUucmgv1wPRJuXExPYMeUDXBmZ0zNE+AZYTIjb6zTsIo1U7ZX6nf+nlD
   6jqLXXYapUd5QTR1lXMU/BLOW8/RsJD82hO1rabJ5/jks+1aqOklNjaCU
   dYeplRmbLSJ7NeGb2VWFO2sFJEonSS0rVgUz6sOtDPnv63DiKKFc1dyLC
   HYO3lpmrAr8KcAqTBS/6uqtJY/V1wi7xJYuQe8c7R2I0XRscfX29Z3B95
   GP/9Nu26qKDePgfQ7MMSnX4jDMoaAb78Q/jjvuvkmPMo3KLcuVzsJljtb
   Q==;
X-CSE-ConnectionGUID: wDbLW9d7SnOseX1061A6kw==
X-CSE-MsgGUID: YOtBsiwHQzexSo0RYhF6Qw==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="221253470"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:57:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 27 Feb 2026 07:57:19 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:57:16 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 27 Feb 2026 15:56:46 +0100
Subject: [PATCH net-next v2 8/9] net: sparx5: move FDMA/XTR initialization
 out of sparx5_start()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-sparx5-init-deinit-v2-8-10ba54ccf005@microchip.com>
References: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
In-Reply-To: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <maxime.chevallier@bootlin.com>,
	<rmk+kernel@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: 880251B95ED
X-Rspamd-Action: no action

Move the Frame DMA and register-based extraction initialization out of
sparx5_start() and into a new sparx5_frame_io_init() function, called
from probe().

Also, add sparx5_frame_io_deinit() for the cleanup path.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 109 ++++++++++++---------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index f359008d2205..e4a448fd2b30 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -658,6 +658,58 @@ static int sparx5_qlim_set(struct sparx5 *sparx5)
 	return 0;
 }
 
+static int sparx5_frame_io_init(struct sparx5 *sparx5)
+{
+	const struct sparx5_ops *ops = sparx5->data->ops;
+	int err = -ENXIO;
+
+	/* Start Frame DMA with fallback to register based INJ/XTR */
+	if (sparx5->fdma_irq >= 0) {
+		if (GCB_CHIP_ID_REV_ID_GET(sparx5->chip_id) > 0 ||
+		    !is_sparx5(sparx5))
+			err = devm_request_irq(sparx5->dev,
+					       sparx5->fdma_irq,
+					       sparx5_fdma_handler,
+					       0,
+					       "sparx5-fdma", sparx5);
+		if (!err) {
+			err = ops->fdma_init(sparx5);
+			if (!err)
+				sparx5_fdma_start(sparx5);
+		}
+		if (err)
+			sparx5->fdma_irq = -ENXIO;
+	} else {
+		sparx5->fdma_irq = -ENXIO;
+	}
+	if (err && sparx5->xtr_irq >= 0) {
+		err = devm_request_irq(sparx5->dev, sparx5->xtr_irq,
+				       sparx5_xtr_handler, IRQF_SHARED,
+				       "sparx5-xtr", sparx5);
+		if (!err)
+			err = sparx5_manual_injection_mode(sparx5);
+		if (err)
+			sparx5->xtr_irq = -ENXIO;
+	} else {
+		sparx5->xtr_irq = -ENXIO;
+	}
+
+	return err;
+}
+
+static void sparx5_frame_io_deinit(struct sparx5 *sparx5)
+{
+	if (sparx5->xtr_irq >= 0) {
+		disable_irq(sparx5->xtr_irq);
+		sparx5->xtr_irq = -ENXIO;
+	}
+	if (sparx5->fdma_irq >= 0) {
+		disable_irq(sparx5->fdma_irq);
+		sparx5->data->ops->fdma_deinit(sparx5);
+		sparx5->fdma_irq = -ENXIO;
+	}
+}
+
 /* Some boards needs to map the SGPIO for signal detect explicitly to the
  * port module
  */
@@ -686,9 +738,7 @@ static void sparx5_board_init(struct sparx5 *sparx5)
 static int sparx5_start(struct sparx5 *sparx5)
 {
 	const struct sparx5_consts *consts = sparx5->data->consts;
-	const struct sparx5_ops *ops = sparx5->data->ops;
 	u32 idx;
-	int err;
 
 	/* Setup own UPSIDs */
 	for (idx = 0; idx < consts->n_own_upsids; idx++) {
@@ -729,39 +779,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 	/* Enable queue limitation watermarks */
 	sparx5_qlim_set(sparx5);
 
-	/* Start Frame DMA with fallback to register based INJ/XTR */
-	err = -ENXIO;
-	if (sparx5->fdma_irq >= 0) {
-		if (GCB_CHIP_ID_REV_ID_GET(sparx5->chip_id) > 0 ||
-		    !is_sparx5(sparx5))
-			err = devm_request_irq(sparx5->dev,
-					       sparx5->fdma_irq,
-					       sparx5_fdma_handler,
-					       0,
-					       "sparx5-fdma", sparx5);
-		if (!err) {
-			err = ops->fdma_init(sparx5);
-			if (!err)
-				sparx5_fdma_start(sparx5);
-		}
-		if (err)
-			sparx5->fdma_irq = -ENXIO;
-	} else {
-		sparx5->fdma_irq = -ENXIO;
-	}
-	if (err && sparx5->xtr_irq >= 0) {
-		err = devm_request_irq(sparx5->dev, sparx5->xtr_irq,
-				       sparx5_xtr_handler, IRQF_SHARED,
-				       "sparx5-xtr", sparx5);
-		if (!err)
-			err = sparx5_manual_injection_mode(sparx5);
-		if (err)
-			sparx5->xtr_irq = -ENXIO;
-	} else {
-		sparx5->xtr_irq = -ENXIO;
-	}
-
-	return err;
+	return 0;
 }
 
 static int mchp_sparx5_probe(struct platform_device *pdev)
@@ -965,10 +983,16 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
+	err = sparx5_frame_io_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to initialize frame I/O\n");
+		goto cleanup_stats;
+	}
+
 	err = sparx5_ptp_init(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to initialize PTP\n");
-		goto cleanup_stats;
+		goto cleanup_frame_io;
 	}
 
 	err = sparx5_register_netdevs(sparx5);
@@ -989,6 +1013,8 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5_unregister_netdevs(sparx5);
 cleanup_ptp:
 	sparx5_ptp_deinit(sparx5);
+cleanup_frame_io:
+	sparx5_frame_io_deinit(sparx5);
 cleanup_stats:
 	sparx5_stats_deinit(sparx5);
 cleanup_mact:
@@ -1007,24 +1033,15 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 static void mchp_sparx5_remove(struct platform_device *pdev)
 {
 	struct sparx5 *sparx5 = platform_get_drvdata(pdev);
-	const struct sparx5_ops *ops = sparx5->data->ops;
 
 	debugfs_remove_recursive(sparx5->debugfs_root);
-	if (sparx5->xtr_irq) {
-		disable_irq(sparx5->xtr_irq);
-		sparx5->xtr_irq = -ENXIO;
-	}
-	if (sparx5->fdma_irq) {
-		disable_irq(sparx5->fdma_irq);
-		sparx5->fdma_irq = -ENXIO;
-	}
 	sparx5_unregister_notifier_blocks(sparx5);
 	sparx5_unregister_netdevs(sparx5);
 	sparx5_ptp_deinit(sparx5);
+	sparx5_frame_io_deinit(sparx5);
 	sparx5_stats_deinit(sparx5);
 	sparx5_mact_deinit(sparx5);
 	sparx5_vcap_deinit(sparx5);
-	ops->fdma_deinit(sparx5);
 	sparx5_destroy_netdevs(sparx5);
 }
 

-- 
2.34.1


