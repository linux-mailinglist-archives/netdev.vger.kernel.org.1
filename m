Return-Path: <netdev+bounces-260806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAhpHli9nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:14:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3B194BA8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68313300C263
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD99C371049;
	Wed, 25 Feb 2026 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BN6/8T5T"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C036EAA8;
	Wed, 25 Feb 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010390; cv=none; b=rKYIe2eHfkt+LAhrFofEu/lXsHsT/Rl4UYQtQqD7vvsBGts1pSdKHEEr7V/rE9hcieUJWqUdAtGE6WK5I6IGeGHm74Jlm+zAab/XSthUe1GOFrU+9n3LRJaKDy01fOimrdAlbqt9F+DARN3YYROH8HTQ/ERbISEN3gpNz4rM+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010390; c=relaxed/simple;
	bh=CEOoIShVVz67EX2t2AqHEGK8T7hIP5WU9sisxJNNPzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jwZJcHZDQSylc25HQh0yLVDTFl0lY1vnOrEJM7cWWUBpjOSXxgko6gfVQpz4aqtxwn4JWvPtPvzYeqSnTTmMXD9OLzVbspj7x08YtebOx0O5U/rwHCpMv/Ir1GD3dksE0dGthMK1JdsIR26TS8SPHScKy6zgU2jJqS7OQHkN158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BN6/8T5T; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010387; x=1803546387;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CEOoIShVVz67EX2t2AqHEGK8T7hIP5WU9sisxJNNPzs=;
  b=BN6/8T5TYq64T/e/lhmt8kJ1QnRhx3PlACOrQ+Ocy4mlUD79Vhv5QxDa
   9kMXd1WsahrAQmHkBbPGWzU863+rA/i/9llH609iLo13/XwmCE0z+Lg7j
   /fJdTSOxzHb8AFENKlyzQTcZsfdmnJs3l7wiemDO10VkIG0h4qA1u7z8y
   uAHTOzyvQqApaUO1tb+ueovR1XjKj0XHthnn8oTDT9DAhSu+Pr/HViFIa
   CgM1ZEGp0XoPv8NJhUTwziw+4+4UrVu8TqyprVtNprbIijTBen4DTlGG5
   aLHG+zyFbDwupsrwrXYe9/vbWo54sTre1KigtYUk1oNvpL7NAGgeXpu7l
   g==;
X-CSE-ConnectionGUID: GvK6L9OjSSuGPw39llTOAQ==
X-CSE-MsgGUID: ZyZB/CyDSGC4HN5xo0MT/Q==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="61259302"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:06:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 02:06:18 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:16 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 25 Feb 2026 10:05:28 +0100
Subject: [PATCH net-next 5/7] net: sparx5: move stats initialization and
 add deinit function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260225-sparx5-init-deinit-v1-5-97036580b9f0@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260806-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: 28C3B194BA8
X-Rspamd-Action: no action

The sparx5_stats_init() function starts a worker thread which needs to
be cleaned up. Move the initialization code to probe() and add a
deinit() function for proper teardown.

Also, rename sparx_stats_init() to sparx5_stats_init() to match the
driver naming convention.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c |  9 ++++++++-
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c    | 16 ++++++++++------
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h    |  3 ++-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 049541eeaae0..d42c57bead89 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1244,7 +1244,7 @@ const struct ethtool_ops sparx5_ethtool_ops = {
 	.set_pauseparam         = sparx5_set_pauseparam,
 };
 
-int sparx_stats_init(struct sparx5 *sparx5)
+int sparx5_stats_init(struct sparx5 *sparx5)
 {
 	const struct sparx5_consts *consts = sparx5->data->consts;
 	char queue_name[32];
@@ -1278,3 +1278,10 @@ int sparx_stats_init(struct sparx5 *sparx5)
 
 	return 0;
 }
+
+void sparx5_stats_deinit(struct sparx5 *sparx5)
+{
+	cancel_delayed_work_sync(&sparx5->stats_work);
+	destroy_workqueue(sparx5->stats_queue);
+	mutex_destroy(&sparx5->queue_stats_lock);
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 97dd3cea0554..17748854ca48 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -748,11 +748,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	if (err)
 		return err;
 
-	/* Init stats */
-	err = sparx_stats_init(sparx5);
-	if (err)
-		return err;
-
 	mutex_init(&sparx5->mdb_lock);
 	INIT_LIST_HEAD(&sparx5->mdb_entries);
 
@@ -976,12 +971,18 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_vcap;
 	}
 
+	err = sparx5_stats_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to initialize stats\n");
+		goto cleanup_mact;
+	}
+
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
 	err = sparx5_register_netdevs(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to register net devices\n");
-		goto cleanup_mact;
+		goto cleanup_stats;
 	}
 
 	err = sparx5_register_notifier_blocks(sparx5);
@@ -1005,6 +1006,8 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5_unregister_notifier_blocks(sparx5);
 cleanup_netdevs:
 	sparx5_unregister_netdevs(sparx5);
+cleanup_stats:
+	sparx5_stats_deinit(sparx5);
 cleanup_mact:
 	sparx5_mact_deinit(sparx5);
 cleanup_vcap:
@@ -1040,6 +1043,7 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 	}
 	sparx5_unregister_notifier_blocks(sparx5);
 	sparx5_unregister_netdevs(sparx5);
+	sparx5_stats_deinit(sparx5);
 	sparx5_mact_deinit(sparx5);
 	sparx5_vcap_deinit(sparx5);
 	sparx5_ptp_deinit(sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index e4c39cca7b26..97d53e229ad6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -514,7 +514,8 @@ enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5, u32 portno);
 
 /* sparx5_ethtool.c */
 void sparx5_get_stats64(struct net_device *ndev, struct rtnl_link_stats64 *stats);
-int sparx_stats_init(struct sparx5 *sparx5);
+int sparx5_stats_init(struct sparx5 *sparx5);
+void sparx5_stats_deinit(struct sparx5 *sparx5);
 
 /* sparx5_dcb.c */
 #ifdef CONFIG_SPARX5_DCB

-- 
2.34.1


