Return-Path: <netdev+bounces-261866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDqaJ2+xoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:59:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E51B95B1
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3345E304A106
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0442B754;
	Fri, 27 Feb 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kS2DFg8h"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E542B736;
	Fri, 27 Feb 2026 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204265; cv=none; b=XxAr7k2WuQbUnMSrz0Wsb84hEM82a3lTEVigwL9hK+xBkdzBl1IbBoHbO7vkdWc1fXCSFD0urXJ1bdI5CDYDV+lJeDGHJ1Jxj2U6reKmOSQIZziFwzmBOyz06TCW+iLoV/M2AEbNhCulJBszCA8ezPi9RPqeuRSQ2zzcZl5Crho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204265; c=relaxed/simple;
	bh=ad/LhZWihMSxoB3f8xRbFoDYpgaS3dn/F656MTIvq44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aQSoHtWrytGSzqjY+5bB36eFWWy3zddPVY7EDhUNsw6COfFKxNJB12/dW+Hv5HyhsaySQnHIpBeTO5kt4+CPdDNmw3sCUViLOLs7KZmW5pKKDUBAnq7eQzLpMH3tI+0W391ux08uExZs+HOUpLDffYoVbMzKXR0cGQB17DOvK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kS2DFg8h; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204264; x=1803740264;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ad/LhZWihMSxoB3f8xRbFoDYpgaS3dn/F656MTIvq44=;
  b=kS2DFg8hEMrrA2E0supP/0iOk0hPl/w4PQFCqmUDoyArHaxCa3SCcBJE
   qmicbeKev7eWfrrblHYCnotnRIYA6ZH0rPhk0TzNI+HMST40R7kPzRF98
   EmGHYWiM11nKXmi/3D1Ipoe8CISC1Crt+oDXes6vSkVjMK1NPZj/kUGtw
   FzjmBqRxZjwaa1Ja/oHqsck5HIgWPARKU36lTR4MFoE1BBqCHXrUqFs0N
   8se64KIO3U4Iu9tWJ8kRlzcKpfjIOivxW5GzLtuCHaNIkBkBWF6vDBqcK
   N8CrF2hdA212W7knvR0O29z1APp1Yinc/b44u7wU2i/ZE5U0r4193AAu8
   w==;
X-CSE-ConnectionGUID: wDbLW9d7SnOseX1061A6kw==
X-CSE-MsgGUID: QlVELnkhTC+anAGdFG6OVQ==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="221253468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:57:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 27 Feb 2026 07:57:03 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:57:01 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 27 Feb 2026 15:56:40 +0100
Subject: [PATCH net-next v2 2/9] net: sparx5: move VCAP initialization to
 probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-sparx5-init-deinit-v2-2-10ba54ccf005@microchip.com>
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
	TAGGED_FROM(0.00)[bounces-261866-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B28E51B95B1
X-Rspamd-Action: no action

Move the VCAP initialization code from sparx5_start() to probe(). Add
proper error handling with a cleanup_vcap label and sparx5_vcap_deinit()
call.

Also, rename sparx5_vcap_destroy() to sparx5_vcap_deinit() to stay
consistent with the naming.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c      | 16 ++++++++++------
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h      |  2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 0ca4001a3667..fbd75423f2a7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -775,10 +775,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 
 	sparx5_board_init(sparx5);
 
-	err = sparx5_vcap_init(sparx5);
-	if (err)
-		return err;
-
 	/* Start Frame DMA with fallback to register based INJ/XTR */
 	err = -ENXIO;
 	if (sparx5->fdma_irq >= 0) {
@@ -1003,12 +999,18 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_ports;
 	}
 
+	err = sparx5_vcap_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to initialize VCAP\n");
+		goto cleanup_ptp;
+	}
+
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
 	err = sparx5_register_netdevs(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to register net devices\n");
-		goto cleanup_ptp;
+		goto cleanup_vcap;
 	}
 
 	err = sparx5_register_notifier_blocks(sparx5);
@@ -1021,6 +1023,8 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 
 cleanup_netdevs:
 	sparx5_unregister_netdevs(sparx5);
+cleanup_vcap:
+	sparx5_vcap_deinit(sparx5);
 cleanup_ptp:
 	sparx5_ptp_deinit(sparx5);
 cleanup_ports:
@@ -1050,9 +1054,9 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 	}
 	sparx5_unregister_notifier_blocks(sparx5);
 	sparx5_unregister_netdevs(sparx5);
+	sparx5_vcap_deinit(sparx5);
 	sparx5_ptp_deinit(sparx5);
 	ops->fdma_deinit(sparx5);
-	sparx5_vcap_destroy(sparx5);
 	sparx5_destroy_netdevs(sparx5);
 	destroy_workqueue(sparx5->mact_queue);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index fe7d8bcc0cd9..6a069434fca6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -563,7 +563,7 @@ void sparx5_get_hwtimestamp(struct sparx5 *sparx5,
 
 /* sparx5_vcap_impl.c */
 int sparx5_vcap_init(struct sparx5 *sparx5);
-void sparx5_vcap_destroy(struct sparx5 *sparx5);
+void sparx5_vcap_deinit(struct sparx5 *sparx5);
 
 /* sparx5_pgid.c */
 enum sparx5_pgid_type {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 25066ddb8d4d..9b4ea3e22ef8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -2083,7 +2083,7 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 	return err;
 }
 
-void sparx5_vcap_destroy(struct sparx5 *sparx5)
+void sparx5_vcap_deinit(struct sparx5 *sparx5)
 {
 	struct vcap_control *ctrl = sparx5->vcap_ctrl;
 	struct vcap_admin *admin, *admin_next;

-- 
2.34.1


