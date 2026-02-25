Return-Path: <netdev+bounces-260810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K6wIDS8nmnHXAQAu9opvQ
	(envelope-from <netdev+bounces-260810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:09:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B4194AD6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B507A303B19E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC4237BE8F;
	Wed, 25 Feb 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sr8A+pdJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D6371046;
	Wed, 25 Feb 2026 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010422; cv=none; b=h17Lz7clLv9ZgKDVIiKcG6eYNqnYXlGoyQ62IM4HYtws1PeqpHTyPx+9CZKH+GXg086kSxMYzy4LMf/0NnAGDDwMW9bnzqVTggb4pTLAX0fV2sNLX471So/sno7KZYhjrBydKT87WKbSVO7cCG6f4k07ZLtqaUHp689D4tlF+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010422; c=relaxed/simple;
	bh=9VZ1uVovnXCdERkt2fVQaLnP6Cbs4phjqlrfHL7fq2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KJSAz4oOzdETaSDmZ92XpLQUWWb0ka7subWygKqdORPti6cLNkWnyG7UEtRxT0+0CQ3B4ZtZZkYluT1AmNwd5HX/uLmVYLhGQ5p8mm48HPQyq93tP4v805hiVxqcRRxO7m4BqhXAUrJz49cl6LCOP2iyExpRUV6j5caCA8bNZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Sr8A+pdJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010418; x=1803546418;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9VZ1uVovnXCdERkt2fVQaLnP6Cbs4phjqlrfHL7fq2M=;
  b=Sr8A+pdJzZnxids5YJKv7kTfvrBD8E6tsSwdK++z4mZm1SWn1mzBKo5M
   YxNPCKR8WT+SOmQdWQoZskknHnMHeuAIKd3fNEsBlOyCQHFVtJ+c0TFy/
   2dTP5/y0Q2KTwCNMoBtQmmOOc1L2u9o97pB6OdOCs8dmW4oqsTEjK7wIu
   mc4bFnKp+7jL6+ZoBwq2RIQj+8JmHZj6XNPt3twOfaVNza7XyfuhCUh/G
   Nt/qDdQhefao+W+OIbVf7ft0Vzpm4Nr+nf549BgxtZ+vW+paifHyUaZtl
   QZZ85vRtVU4tXxlwjqYoHBnbKRC+DN8n7Y0f71JX8CG/mKGfbEY13EhKh
   A==;
X-CSE-ConnectionGUID: qnurV3sJT6mUYuyKYf9Ihg==
X-CSE-MsgGUID: vQY8kQEYSXyRvmukcJalZQ==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="54259087"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 02:06:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 25 Feb 2026 02:06:23 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:21 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 25 Feb 2026 10:05:30 +0100
Subject: [PATCH net-next 7/7] net: sparx5: move remaining init functions
 from start() to probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260225-sparx5-init-deinit-v1-7-97036580b9f0@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260810-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: 491B4194AD6
X-Rspamd-Action: no action

Move sparx5_pgid_init(), sparx5_vlan_init(), and sparx5_board_init()
from sparx5_start() to probe(). These functions do not require cleanup.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 581f87eb9781..fb3010446707 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -727,12 +727,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 			 ANA_CL_FILTER_CTRL_FORCE_FCS_UPDATE_ENA,
 			 sparx5, ANA_CL_FILTER_CTRL(idx));
 
-	/* Init PGID table arbitrator */
-	sparx5_pgid_init(sparx5);
-
-	/* Setup VLANs */
-	sparx5_vlan_init(sparx5);
-
 	/* Add host mode BC address (points only to CPU) */
 	sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_CPU), broadcast,
 			  NULL_VID);
@@ -743,8 +737,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	mutex_init(&sparx5->mdb_lock);
 	INIT_LIST_HEAD(&sparx5->mdb_entries);
 
-	sparx5_board_init(sparx5);
-
 	/* Start Frame DMA with fallback to register based INJ/XTR */
 	err = -ENXIO;
 	if (sparx5->fdma_irq >= 0) {
@@ -939,6 +931,10 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		}
 	}
 
+	sparx5_pgid_init(sparx5);
+	sparx5_vlan_init(sparx5);
+	sparx5_board_init(sparx5);
+
 	err = sparx5_calendar_init(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to initialize calendar\n");

-- 
2.34.1


