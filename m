Return-Path: <netdev+bounces-261863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOenKwWxoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:58:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 638151B9565
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75242303AF12
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B6042E014;
	Fri, 27 Feb 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2pJN77z6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CA42B740;
	Fri, 27 Feb 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204252; cv=none; b=EWsAKQmEIfdYy0u0UwMLUIBnyJPXT+hSATZVoIu32/FWsBX7t17y7KpYM9psSkUZ2a3tTcv8eXtL6EuYBtDqHpiG5hW5C1FYXrBB/5gNEyPYoroDhqtPAi07KejLW8K8VQPHdWefAKA2xtA9Uu3ntqZn9qVQpIAIYu1q20rTdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204252; c=relaxed/simple;
	bh=jDlPP0Dhjhl6jNJafNK8XeaZ3H+YJC5WkqOkIyeSUdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FH4lw7wqnsW02EAiBUk2CREX2vEeNVjR1+b5G07Zg/A3Uf0lUXeRauOSvKZmYbK421wvqgfCOwxctUBnC3DPCdkFPTgqFklD4QrqSGguqFduDMOEw+ESU8cbNNhFKFVCjOsTwygAvHxs5QMCbPd21yAo2tDAtPFobhKCdR/jk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2pJN77z6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204249; x=1803740249;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jDlPP0Dhjhl6jNJafNK8XeaZ3H+YJC5WkqOkIyeSUdo=;
  b=2pJN77z680UOEkhRW4RUHRTe3/q/qopPtY/tOphCBfQ1pdVlE0AGlsdH
   ZwmzTJgaOUaXJsR7LJQTD8RVtJhChme5irdTlyfUd+7gWQHsO999rz7LY
   oeyhOyBF2CmNM3g94Z8KvQxQMLKTA9foYf8MBTkyIrrLyKaXzuGktdikC
   2c79hDI5de/o/JV6bwHNtjEeJdZuUUCjGVH8vd0FTvlV+JKCkAc8lh65S
   1QL0TyJZjaIf2PaV6P/LVM9jg9XvyGtUhID1Kx7vSFpIkuiugf17dEBSJ
   c4a0EMrwU3aLD/RzoeSqM4TjvQIdeNGEN1wtmbKEoXh8TbVXUNdqtp1WG
   g==;
X-CSE-ConnectionGUID: wgI98+BBT5OZU+rH87zgwA==
X-CSE-MsgGUID: V/pfDvvOTpKSt0UAbksa+Q==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="53970561"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 07:57:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 27 Feb 2026 07:57:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:57:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 27 Feb 2026 15:56:42 +0100
Subject: [PATCH net-next v2 4/9] net: sparx5: move stats initialization and
 add deinit function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-sparx5-init-deinit-v2-4-10ba54ccf005@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261863-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: 638151B9565
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
index 4271f4a29cad..bcc7b895fad6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -743,11 +743,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	if (err)
 		return err;
 
-	/* Init stats */
-	err = sparx_stats_init(sparx5);
-	if (err)
-		return err;
-
 	sparx5_board_init(sparx5);
 
 	/* Start Frame DMA with fallback to register based INJ/XTR */
@@ -986,12 +981,18 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
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
@@ -1004,6 +1005,8 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 
 cleanup_netdevs:
 	sparx5_unregister_netdevs(sparx5);
+cleanup_stats:
+	sparx5_stats_deinit(sparx5);
 cleanup_mact:
 	sparx5_mact_deinit(sparx5);
 cleanup_vcap:
@@ -1035,6 +1038,7 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
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


