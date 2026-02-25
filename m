Return-Path: <netdev+bounces-260811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLulDAC+nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:16:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C26194C24
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5567A3180EBA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C383803C6;
	Wed, 25 Feb 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ATRk9tW4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3937FF75;
	Wed, 25 Feb 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010431; cv=none; b=O/pXHos7netlch3KHUd+7XvZq88SHEY07ILaVWG5Wk5WZSUk+8oxptSB471dao5VeyN3aqlP8Qjxz1aOlWNOapykfIB5lwjhebI7iClWoPvBcYKVrudQyN0f+C3r5phIVcYJdsSVbK7mFwCJ0mnKrqIp6C3jNwTa3zBtyGrwMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010431; c=relaxed/simple;
	bh=wE0FxXJQW3yVDJE1a/1GJUQdpG7aGn8J4V+MDvPXIbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=urljushxw+irYDDBI7ui48sr0BVXUMwOzL6592nGdg9tHnPLoHQtbvZuLD3Z0pLbi2BSg4BbNYSVO/FW6Rve8IIMCqV4+lnrwlOsOMPjiyWzJG3UY97Vuet/7yrhmCmtvIGNAhLGJMPJ6iYBsAJI0uhQ0QoZobQsCbDPiJsmmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ATRk9tW4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010429; x=1803546429;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wE0FxXJQW3yVDJE1a/1GJUQdpG7aGn8J4V+MDvPXIbQ=;
  b=ATRk9tW46N9dNja269BPgDTHBV+kENXJ13FjBhLBsExZFUs5/gco8KlZ
   z+KLHNN2OaalAxdSrQMbs2v+SnX3rdCpNVQQARUz81IEHAROPDJlWLS0U
   uUT6kK9Bt3bTchxX+xkqht4JT/Jp1DKSULehqUW2ZnIgLWU7YzQEV4T8U
   262Ge3LtPY8TBoffCMkBXFwhKjgesaAGXgHbp2CXaCu92iLQXKNZT8RlN
   FmhARDSw0XdzZSIUaVrD2uIxJnzFdc5oN5kN1hDOv8guXnQWwErxQ+kp1
   7WTeVLqHGQvRiW7MfdpRDF5XNjn9YWMCkTHiuSKPCN2slpO7eozHkEmez
   w==;
X-CSE-ConnectionGUID: 1d+y6PO9SFGcdWGyfjWqeQ==
X-CSE-MsgGUID: 70P3UHu5T9G15aTdFF8Lfw==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="54259094"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 02:07:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 25 Feb 2026 02:06:09 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:07 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 25 Feb 2026 10:05:24 +0100
Subject: [PATCH net-next 1/7] net: sparx5: call sparx5_start() last in
 probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260225-sparx5-init-deinit-v1-1-97036580b9f0@microchip.com>
References: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
In-Reply-To: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260811-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: A2C26194C24
X-Rspamd-Action: no action

The sparx5_start() function initializes hardware and enables interrupts,
so it should be the last function called in probe(). Over time, new init
functions have been added after it, breaking this assumption.

Move sparx5_start() back to being last. To avoid breaking PTP between
patches in this series, also consolidate all PTP initialization into
sparx5_ptp_init() and add proper teardown via sparx5_ptp_deinit().

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 35 ++++++++++------------
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 13 ++++++++
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 582145713cfd..d7e823fe4ab9 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -820,18 +820,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 		sparx5->xtr_irq = -ENXIO;
 	}
 
-	if (sparx5->ptp_irq >= 0 &&
-	    sparx5_has_feature(sparx5, SPX5_FEATURE_PTP)) {
-		err = devm_request_threaded_irq(sparx5->dev, sparx5->ptp_irq,
-						NULL, ops->ptp_irq_handler,
-						IRQF_ONESHOT, "sparx5-ptp",
-						sparx5);
-		if (err)
-			sparx5->ptp_irq = -ENXIO;
-
-		sparx5->ptp = 1;
-	}
-
 	return err;
 }
 
@@ -1000,12 +988,6 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = sparx5_start(sparx5);
-	if (err) {
-		dev_err(sparx5->dev, "Start failed\n");
-		goto cleanup_ports;
-	}
-
 	err = sparx5_qos_init(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to initialize QoS\n");
@@ -1014,14 +996,25 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 
 	err = sparx5_ptp_init(sparx5);
 	if (err) {
-		dev_err(sparx5->dev, "PTP failed\n");
+		dev_err(sparx5->dev, "Failed to initialize PTP\n");
 		goto cleanup_ports;
 	}
 
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
+	/* Start the rest of the initialization and enable interrupts. Must be
+	 * called last, after all subsystems are initialized.
+	 */
+	err = sparx5_start(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Start failed\n");
+		goto cleanup_ptp;
+	}
+
 	goto cleanup_config;
 
+cleanup_ptp:
+	sparx5_ptp_deinit(sparx5);
 cleanup_ports:
 	sparx5_cleanup_ports(sparx5);
 	if (sparx5->mact_queue)
@@ -1047,6 +1040,10 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 		disable_irq(sparx5->fdma_irq);
 		sparx5->fdma_irq = -ENXIO;
 	}
+	if (sparx5->ptp_irq) {
+		disable_irq(sparx5->ptp_irq);
+		sparx5->ptp_irq = -ENXIO;
+	}
 	sparx5_ptp_deinit(sparx5);
 	ops->fdma_deinit(sparx5);
 	sparx5_cleanup_ports(sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 8b2e07821a95..84327ee5b8a2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -606,9 +606,22 @@ static int sparx5_ptp_phc_init(struct sparx5 *sparx5,
 int sparx5_ptp_init(struct sparx5 *sparx5)
 {
 	u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	struct sparx5_port *port;
 	int err, i;
 
+	if (sparx5->ptp_irq >= 0 &&
+	    sparx5_has_feature(sparx5, SPX5_FEATURE_PTP)) {
+		err = devm_request_threaded_irq(sparx5->dev, sparx5->ptp_irq,
+						NULL, ops->ptp_irq_handler,
+						IRQF_ONESHOT, "sparx5-ptp",
+						sparx5);
+		if (err)
+			sparx5->ptp_irq = -ENXIO;
+
+		sparx5->ptp = 1;
+	}
+
 	if (!sparx5->ptp)
 		return 0;
 

-- 
2.34.1


