Return-Path: <netdev+bounces-260805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jGZWCvi7nmnHXAQAu9opvQ
	(envelope-from <netdev+bounces-260805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:08:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B6194A6A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2F613028054
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AF36F43E;
	Wed, 25 Feb 2026 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V7mXltrI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629536EA9A;
	Wed, 25 Feb 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010390; cv=none; b=nkzY2ac/e9bqgqi9Tug4r8NLNqP2Pj+j16uZmRyNvCNDN694REoB2y8VdBiKTY4/LI4nnbiQtX8k+s8YTmOCZiTa0f/2VFV0t28Bx7tl02m8Ra9m/QjDVoNsyczIFrBLnWk8crq9C8/EY/wtS7ByROM8A2oDzJvLvajSY6pQ7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010390; c=relaxed/simple;
	bh=SjGo6ZLzuUnmkoqGRlfVYGuWFR89kHfN9qVzMB3AD+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uRTFe0/LxPv0mu0yn/Xc/pQ36NXXx0zxJGH3zsxxNmCnHHdrRbhSy1Z9r0uyGUoFw1KLmsBWvjjCKVfngandZvfTmdZfCZgfRSUAcY7TpmYleyhHPMy6vP7R52dENKMM4KhqYtU9lZGW0mWnq62pDe2r4QpD9mCFMM/dzdSDBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V7mXltrI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010386; x=1803546386;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SjGo6ZLzuUnmkoqGRlfVYGuWFR89kHfN9qVzMB3AD+4=;
  b=V7mXltrIN1QkLxS9uBxLozuOlrj19W6J2TIhCnJQKUs+2MRsbN0IgW0W
   qWGjBhNZKrrkVL5bTbb29aQ9/9GS4bVP1wXLYYYkdl4sNXvefLm1KU2Ac
   rik2v/teDUrS4JoJRz7YJgLC1IXW4PyscVwp6eIM2L6HziYCRdsEh7dQ3
   SvnfnRN/Tcke/5Ucqr4lEl0RoYxptSAVRLS5Pci8ksxsSEHVUuZHflN8S
   JmgPO0rr/bF3GAPrc2ZowacfMURuZUAoKI/7EseD4k+lZLumqj3vAyrTG
   cZ8cSRc7341Tn1+Y9oaUJAn4LdpWNs3rNWQo2uZiNN/qnJITu8r/QyfEz
   A==;
X-CSE-ConnectionGUID: GvK6L9OjSSuGPw39llTOAQ==
X-CSE-MsgGUID: SVwWFSU9S9+y8DN8tRTZiw==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="61259300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:06:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 02:06:16 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:14 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 25 Feb 2026 10:05:27 +0100
Subject: [PATCH net-next 4/7] net: sparx5: move MAC table initialization
 and add deinit function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260225-sparx5-init-deinit-v1-4-97036580b9f0@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260805-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D3B6194A6A
X-Rspamd-Action: no action

Consolidate all MAC table initialization from sparx5_start() into
sparx5_mact_init(), move it to probe(), and add a deinit function for
proper teardown.

Also, make sparx5_mact_pull_work() static since it is only used within
sparx5_mactable.c.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_mactable.c    | 27 +++++++++++++++++--
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 31 +++++++---------------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  4 +--
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index f5584244612c..626ce6f9046d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -419,7 +419,7 @@ static void sparx5_mact_handle_entry(struct sparx5 *sparx5,
 				  true);
 }
 
-void sparx5_mact_pull_work(struct work_struct *work)
+static void sparx5_mact_pull_work(struct work_struct *work)
 {
 	struct delayed_work *del_work = to_delayed_work(work);
 	struct sparx5 *sparx5 = container_of(del_work, struct sparx5,
@@ -489,8 +489,10 @@ void sparx5_set_ageing(struct sparx5 *sparx5, int msecs)
 		 LRN_AUTOAGE_CFG(0));
 }
 
-void sparx5_mact_init(struct sparx5 *sparx5)
+int sparx5_mact_init(struct sparx5 *sparx5)
 {
+	char queue_name[32];
+
 	mutex_init(&sparx5->lock);
 
 	/*  Flush MAC table */
@@ -502,4 +504,25 @@ void sparx5_mact_init(struct sparx5 *sparx5)
 		dev_warn(sparx5->dev, "MAC flush error\n");
 
 	sparx5_set_ageing(sparx5, BR_DEFAULT_AGEING_TIME / HZ * 1000);
+
+	mutex_init(&sparx5->mact_lock);
+	INIT_LIST_HEAD(&sparx5->mact_entries);
+	snprintf(queue_name, sizeof(queue_name), "%s-mact",
+		 dev_name(sparx5->dev));
+	sparx5->mact_queue = create_singlethread_workqueue(queue_name);
+	if (!sparx5->mact_queue)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&sparx5->mact_work, sparx5_mact_pull_work);
+	queue_delayed_work(sparx5->mact_queue, &sparx5->mact_work,
+			   SPX5_MACT_PULL_DELAY);
+
+	return 0;
+}
+
+void sparx5_mact_deinit(struct sparx5 *sparx5)
+{
+	cancel_delayed_work_sync(&sparx5->mact_work);
+	destroy_workqueue(sparx5->mact_queue);
+	mutex_destroy(&sparx5->mact_lock);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 28ee45815c7f..97dd3cea0554 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -688,7 +688,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	u8 broadcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const struct sparx5_consts *consts = sparx5->data->consts;
 	const struct sparx5_ops *ops = sparx5->data->ops;
-	char queue_name[32];
 	u32 idx;
 	int err;
 
@@ -728,9 +727,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 			 ANA_CL_FILTER_CTRL_FORCE_FCS_UPDATE_ENA,
 			 sparx5, ANA_CL_FILTER_CTRL(idx));
 
-	/* Init MAC table, ageing */
-	sparx5_mact_init(sparx5);
-
 	/* Init PGID table arbitrator */
 	sparx5_pgid_init(sparx5);
 
@@ -757,19 +753,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	if (err)
 		return err;
 
-	/* Init mact_sw struct */
-	mutex_init(&sparx5->mact_lock);
-	INIT_LIST_HEAD(&sparx5->mact_entries);
-	snprintf(queue_name, sizeof(queue_name), "%s-mact",
-		 dev_name(sparx5->dev));
-	sparx5->mact_queue = create_singlethread_workqueue(queue_name);
-	if (!sparx5->mact_queue)
-		return -ENOMEM;
-
-	INIT_DELAYED_WORK(&sparx5->mact_work, sparx5_mact_pull_work);
-	queue_delayed_work(sparx5->mact_queue, &sparx5->mact_work,
-			   SPX5_MACT_PULL_DELAY);
-
 	mutex_init(&sparx5->mdb_lock);
 	INIT_LIST_HEAD(&sparx5->mdb_entries);
 
@@ -987,12 +970,18 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_ptp;
 	}
 
+	err = sparx5_mact_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to initialize MAC table\n");
+		goto cleanup_vcap;
+	}
+
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
 	err = sparx5_register_netdevs(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to register net devices\n");
-		goto cleanup_vcap;
+		goto cleanup_mact;
 	}
 
 	err = sparx5_register_notifier_blocks(sparx5);
@@ -1016,14 +1005,14 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5_unregister_notifier_blocks(sparx5);
 cleanup_netdevs:
 	sparx5_unregister_netdevs(sparx5);
+cleanup_mact:
+	sparx5_mact_deinit(sparx5);
 cleanup_vcap:
 	sparx5_vcap_deinit(sparx5);
 cleanup_ptp:
 	sparx5_ptp_deinit(sparx5);
 cleanup_ports:
 	sparx5_destroy_netdevs(sparx5);
-	if (sparx5->mact_queue)
-		destroy_workqueue(sparx5->mact_queue);
 cleanup_config:
 	kfree(configs);
 cleanup_pnode:
@@ -1051,11 +1040,11 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 	}
 	sparx5_unregister_notifier_blocks(sparx5);
 	sparx5_unregister_netdevs(sparx5);
+	sparx5_mact_deinit(sparx5);
 	sparx5_vcap_deinit(sparx5);
 	sparx5_ptp_deinit(sparx5);
 	ops->fdma_deinit(sparx5);
 	sparx5_destroy_netdevs(sparx5);
-	destroy_workqueue(sparx5->mact_queue);
 }
 
 static const struct sparx5_regs sparx5_regs = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 6a069434fca6..e4c39cca7b26 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -470,7 +470,6 @@ void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma);
 void sparx5_fdma_injection_mode(struct sparx5 *sparx5);
 
 /* sparx5_mactable.c */
-void sparx5_mact_pull_work(struct work_struct *work);
 int sparx5_mact_learn(struct sparx5 *sparx5, int port,
 		      const unsigned char mac[ETH_ALEN], u16 vid);
 bool sparx5_mact_getnext(struct sparx5 *sparx5,
@@ -489,7 +488,8 @@ int sparx5_del_mact_entry(struct sparx5 *sparx5,
 int sparx5_mc_sync(struct net_device *dev, const unsigned char *addr);
 int sparx5_mc_unsync(struct net_device *dev, const unsigned char *addr);
 void sparx5_set_ageing(struct sparx5 *sparx5, int msecs);
-void sparx5_mact_init(struct sparx5 *sparx5);
+int sparx5_mact_init(struct sparx5 *sparx5);
+void sparx5_mact_deinit(struct sparx5 *sparx5);
 
 /* sparx5_vlan.c */
 void sparx5_pgid_update_mask(struct sparx5_port *port, int pgid, bool enable);

-- 
2.34.1


