Return-Path: <netdev+bounces-261865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL3vGZiyoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:04:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A251B9689
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 401F531804E4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057342EEDA;
	Fri, 27 Feb 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZKfeLAgF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2F42E017;
	Fri, 27 Feb 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204253; cv=none; b=Reh949/CpkCM2/Y7iolUOAk6J6BkETXfYAtLKQwmKqkFD+I2xh6+Zdrqx5K8+mFH0sTERBKmX8nKyhPk32EzENKn8CnKS98S4VvORg6NXOU9GLjvgWhOgB68n3BaRZbiZJfR6E4cxgH6qTpFBcxJgoi1msDlPqYHMusXgEKD9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204253; c=relaxed/simple;
	bh=TZmrEqNYunFkfCNtjB0WvV61y+JRk2jGtPFp6ATKH94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c0tFT0SFbEHI+D4YmQJyiORWoxe03+Vm0ddx4U89LQe8BXe1S8f6Ahx64VDQnNv8xbxFMaplcP34bHtjXtIY/vE7HzhVBcBccoEx8IoXkMk42407VNGZjBQ53OghOt9y9fSB3aboSXjGVeLspjL59fhwk/7F20VrqkOLTPyz8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZKfeLAgF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204251; x=1803740251;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TZmrEqNYunFkfCNtjB0WvV61y+JRk2jGtPFp6ATKH94=;
  b=ZKfeLAgF7dHnPzio1etutrp4VYyRS/j3QXa+Xr+ISdQ+U8hP3D/ufIXR
   ofHgsckE0gQu8UmZr+huJ9kX8JJWoqhhzgfo6UzzEsN/PRm8oRsvHRNXS
   YHBKrpdv3qkcCw5VZwp+sBwiYJms16jOBw08ohoUs4SGM50vLZHas2Qc3
   96W3I/zHvO7MziE/S9vzMLOAfL3jvk/Gqjm15VFLBXiWJvSHFxVTHZCkA
   Aui1WIkIVT1KoGeL0PELQSw9jvByWfftgQ7C+dD8xYheIoOLNj+MtkA9G
   RpRAUUBrolQjHuSdd4khAx12e4P2CR9ovk+KIAhei/jbNqD+kWaHvUaaX
   w==;
X-CSE-ConnectionGUID: wgI98+BBT5OZU+rH87zgwA==
X-CSE-MsgGUID: NwFtLTw4RKuhXMCJaqmLrw==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="53970563"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 07:57:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 27 Feb 2026 07:57:16 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:57:14 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 27 Feb 2026 15:56:45 +0100
Subject: [PATCH net-next v2 7/9] net: sparx5: move PTP IRQ handling out of
 sparx5_start()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-sparx5-init-deinit-v2-7-10ba54ccf005@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0A251B9689
X-Rspamd-Action: no action

Move the PTP IRQ request into sparx5_ptp_init() so all PTP setup is
done in one place.

Also move the sparx5_ptp_init() call to right before
sparx5_register_netdevs() and add a cleanup_ptp label. Update remove()
to disable the PTP IRQ and reorder ptp_deinit accordingly.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 34 +++++++---------------
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 18 ++++++++++++
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index d37f34197e84..f359008d2205 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -761,18 +761,6 @@ static int sparx5_start(struct sparx5 *sparx5)
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
 
@@ -957,16 +945,10 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_ports;
 	}
 
-	err = sparx5_ptp_init(sparx5);
-	if (err) {
-		dev_err(sparx5->dev, "PTP failed\n");
-		goto cleanup_ports;
-	}
-
 	err = sparx5_vcap_init(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to initialize VCAP\n");
-		goto cleanup_ptp;
+		goto cleanup_ports;
 	}
 
 	err = sparx5_mact_init(sparx5);
@@ -983,10 +965,16 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
+	err = sparx5_ptp_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to initialize PTP\n");
+		goto cleanup_stats;
+	}
+
 	err = sparx5_register_netdevs(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to register net devices\n");
-		goto cleanup_stats;
+		goto cleanup_ptp;
 	}
 
 	err = sparx5_register_notifier_blocks(sparx5);
@@ -999,14 +987,14 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 
 cleanup_netdevs:
 	sparx5_unregister_netdevs(sparx5);
+cleanup_ptp:
+	sparx5_ptp_deinit(sparx5);
 cleanup_stats:
 	sparx5_stats_deinit(sparx5);
 cleanup_mact:
 	sparx5_mact_deinit(sparx5);
 cleanup_vcap:
 	sparx5_vcap_deinit(sparx5);
-cleanup_ptp:
-	sparx5_ptp_deinit(sparx5);
 cleanup_ports:
 	sparx5_destroy_netdevs(sparx5);
 cleanup_config:
@@ -1032,10 +1020,10 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 	}
 	sparx5_unregister_notifier_blocks(sparx5);
 	sparx5_unregister_netdevs(sparx5);
+	sparx5_ptp_deinit(sparx5);
 	sparx5_stats_deinit(sparx5);
 	sparx5_mact_deinit(sparx5);
 	sparx5_vcap_deinit(sparx5);
-	sparx5_ptp_deinit(sparx5);
 	ops->fdma_deinit(sparx5);
 	sparx5_destroy_netdevs(sparx5);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 8b2e07821a95..a16ec8136d6d 100644
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
 
@@ -660,6 +673,11 @@ void sparx5_ptp_deinit(struct sparx5 *sparx5)
 	struct sparx5_port *port;
 	int i;
 
+	if (sparx5->ptp_irq >= 0) {
+		disable_irq(sparx5->ptp_irq);
+		sparx5->ptp_irq = -ENXIO;
+	}
+
 	for (i = 0; i < sparx5->data->consts->n_ports; i++) {
 		port = sparx5->ports[i];
 		if (!port)

-- 
2.34.1


