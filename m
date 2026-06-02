Return-Path: <netdev+bounces-294478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3XA3FXhvH2rClwAAu9opvQ
	(envelope-from <netdev+bounces-294478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6463312A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:04:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Pk2Hxua2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294478-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294478-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5969330E7A11
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E453DA5C3;
	Tue,  2 Jun 2026 23:59:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CE3D6495
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:59:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444754; cv=none; b=XYUpme44e9mKDS2CVMV2xnVIxLsdpZjSYKf5BSRhr05Wori/FFoHvDDaZDHltMfnj7UUQbHnwV0OBGlbILEuGW4UZCIFgLqf74S+KyDpsIHip1H7PjF1rH5usiqXimBvpGR4EA/4cIXKKRgpvczCBh2WfonGIBOGugN+7wQDpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444754; c=relaxed/simple;
	bh=vlXYIYL9QTWznkvct15QBSB66UjBNT4nj/9EHJkxq4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5Hdyi03IxVRz8lzjVNz5wF8C5cg3TEZ6wx+XKMkWbZxj+4Wpb4EA1+BIw6dvLUsvPatQ5E9FOsNcGMbUGFWw5EcyaAjqHWz9GIJk4jLz0vmRVpnY9URqJDJCzhOzNyh2GhU1fRriDBLG0S6YPQIE+4RrX4Do2DTnbygMPo2HL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pk2Hxua2; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423970cb30so2219350b3a.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444750; x=1781049550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpDIxHnDF0+XKaA/CcYR60ivGnavty89fftbvhrFuDE=;
        b=Pk2Hxua2xZghsLsBfP1KrFnK3B+CGQbfMtbxJg08yLDBwZ/bFhWPNasIduP2IIJgs7
         7M2gcJfcin/HTbWlivSfc6mT7GYZstGTsiKwpHTc3Uo9hfja2+8SR2DmSpJpcnQ6u23+
         z2dUgD1maxXbBDFXu9okUs/ijGXQ0X5YS+q0VyR9uqnhWt7w2SmGvwm/n/wS6fG5HYoJ
         FE6br/LoxyhN56LqLU2S+LEPTlqLxtu9tetj7X4h5qiP/0bLoUBJll/RpPGZULrLrap0
         ZpYkL7RtpLFK2VjbKPE8ptsFCFbzAGWOWEIIDbI41wEoq2G1hyNy0xAyP+nkQFg2dfdT
         wobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444750; x=1781049550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpDIxHnDF0+XKaA/CcYR60ivGnavty89fftbvhrFuDE=;
        b=qB1IKHYCGL8hAze90oKGVNYsRisyRkgxbUF6lR1VqGFIs7BD8DYPiA1HXgSxSYq/d4
         keh9fTD0qa4MYWUpt4CoME5N3hbitOuMppHMvCNLjWtKxgigKEXp/XYkxchaM07dnLUc
         Zz6X9lKBHLVwaDROFG9+d4nXv+0vHi9pQGIZKNQrLUT6Zk5NhICkiDWCJQLKVkjkXbP2
         oeqsd5zRzsg61yTl7oEIcbgkY9sL/CBwuScv0XWdO0jQEoD1CE3aNVAG5tncW07in1GM
         gNdmH73B4hVfeS8JwKvElBDavIEVzUcclBY3Ryj7rTKMD9bhQXQhO+AroJrFF+laSEw1
         bxbg==
X-Gm-Message-State: AOJu0YxxPazJ4Br4c2ezaeDEAbRlk19NYVgF2QfV/BE7N4d+GPZv485/
	rmmXNQJx/jBwY3hT21AHAHah0l0F5PZBbNl5W2bmO7AC0dKGsu8mP33+ndSWSOUSNePdprd9QVK
	tZNJaG2yaz2diMf+v41kb1zbTd86XtTfLYu02mgd3E0Fe+sm5thYm7UeGTWeXBui3LQXG5Bl7GC
	qoqqSJLm/bIIvDS38xEr9MIwRr8LFSyFnOvsztohY9/pxUyMGo7fCNlMincwomr6Y=
X-Received: from pfbdo14.prod.google.com ([2002:a05:6a00:4a0e:b0:842:48fe:379a])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3687:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-84284e5f662mr974597b3a.21.1780444749852;
 Tue, 02 Jun 2026 16:59:09 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:53 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-10-hramamurthy@google.com>
Subject: [PATCH net-next v2 09/15] gve: simplify reset logic
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,tor.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:joshwash@google.com,m:hramamurthy@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9B6463312A

From: Joshua Washington <joshwash@google.com>

Current GVE reset logic is quite complex, with a number of methods with
similar names and functionalities. This complexity has allowed a number
of bugs to enter the reset/recovery path, including the potential for
reset loops if an operation fails during teardown.

Simplify the reset path by doing the following:
1) Removing recursive resets. Recursive resets have two major issues.
   First, there is the potential for stack overflows if resets are
   invoked too many times in a row. Second, long recursive calls mean
   that GVE never gives up the RTNL lock, or at the very least holds it
   for too long. If a reset must occur anywhere during the
   reset/recovery path, it should be scheduled as a separate task.
2) Removing resets during teardown. This is partly covered by removing
   recursive resets, but the primary goal in this case is to ensure that
   the driver is capable of actually executing a hardware reset if
   something goes wrong with a control plane operation. As it stands, if
   `deconfigure_device_resources` fails, for example, GVE will preempt
   its reset with another reset without actually invoking a hardware
   reset, which could actually help with recovery.
3) Decompose allocation/de-allocation and setup/teardown. Performing
   allocation and setup for each control plane system (RSS, ptype map,
   etc) leaves many more error conditions to handle, causing teardown in
   the case of failures to be much more complex than they need to be.
   This will also be useful to better align a major behavioral change
   in mailbox mode, which will use separate response buffers instead to
   get data from the device instead of a pre-allocated shared memory
   region.

With the new reset functionality, shared resources between the device
and driver are not freed until after the hardware reset has completed
in the event that `deconfigure_device_resources` fails, meaning that the
device could potentially still be holding on to shared memory.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v2:
- Fixed typos in commit message (recursive, preempt)
- Fixed a kdoc warning

 drivers/net/ethernet/google/gve/gve.h         |   2 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |   5 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   1 -
 drivers/net/ethernet/google/gve/gve_ethtool.c |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 338 +++++++++---------
 5 files changed, 167 insertions(+), 181 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 72588d201e5d..c2e68fd97de5 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1347,7 +1347,7 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
-int gve_reset(struct gve_priv *priv, bool attempt_teardown);
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup);
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index e7956d2768b6..84b548467a0c 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -363,7 +363,7 @@ int gve_adminq_init(struct gve_priv *priv)
 	return gve_adminq_alloc(priv);
 }
 
-void gve_adminq_release(struct gve_priv *priv)
+static void gve_adminq_release(struct gve_priv *priv)
 {
 	int i = 0;
 
@@ -392,7 +392,6 @@ void gve_adminq_release(struct gve_priv *priv)
 	}
 	gve_clear_device_rings_ok(priv);
 	gve_clear_device_resources_ok(priv);
-	gve_clear_admin_queue_ok(priv);
 }
 
 void gve_adminq_free(struct gve_priv *priv)
@@ -1377,7 +1376,7 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
 
 	if (err == -ETIME) {
 		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
-		gve_reset(priv, true);
+		gve_reset(priv, false);
 	} else if (!err) {
 		priv->flow_rules_cache.rules_cache_synced = false;
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index d07e9c6f279d..12d2d1347e21 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -621,7 +621,6 @@ static_assert(sizeof(union gve_adminq_command) == 64);
 
 int gve_adminq_init(struct gve_priv *priv);
 void gve_adminq_free(struct gve_priv *priv);
-void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
 int gve_adminq_configure_device_resources(struct gve_priv *priv,
 					  dma_addr_t counter_array_bus_addr,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index dc2213b5ce24..54b623b678ce 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -651,7 +651,7 @@ static int gve_user_reset(struct net_device *netdev, u32 *flags)
 
 	if (*flags == ETH_RESET_ALL) {
 		*flags = 0;
-		return gve_reset(priv, true);
+		return gve_reset(priv, false);
 	}
 
 	return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 746ff69a28dd..f8289f478e5b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -591,7 +591,22 @@ static void gve_free_notify_blocks(struct gve_priv *priv)
 	priv->msix_vectors = NULL;
 }
 
-static int gve_setup_device_resources(struct gve_priv *priv)
+static void gve_free_control_plane_resources(struct gve_priv *priv)
+{
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
+
+	kvfree(priv->ptype_lut_dqo);
+	priv->ptype_lut_dqo = NULL;
+
+	gve_free_stats_report(priv);
+	gve_free_notify_blocks(priv);
+	gve_free_counter_array(priv);
+	gve_free_rss_config_cache(priv);
+	gve_free_flow_rule_caches(priv);
+}
+
+static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
@@ -600,16 +615,42 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
 	if (err)
-		goto abort_with_flow_rule_caches;
+		goto abort;
 	err = gve_alloc_counter_array(priv);
 	if (err)
-		goto abort_with_rss_config_cache;
+		goto abort;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
-		goto abort_with_counter;
+		goto abort;
 	err = gve_alloc_stats_report(priv);
 	if (err)
-		goto abort_with_ntfy_blocks;
+		goto abort;
+
+	if (!gve_is_gqi(priv)) {
+		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo,
+						   GFP_KERNEL);
+		if (!priv->ptype_lut_dqo) {
+			err = -ENOMEM;
+			goto abort;
+		}
+	}
+
+	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
+	if (!priv->xsk_pools) {
+		err = -ENOMEM;
+		goto abort;
+	}
+
+	return 0;
+abort:
+	gve_free_control_plane_resources(priv);
+	return err;
+}
+
+static int gve_setup_control_plane_resources(struct gve_priv *priv)
+{
+	int err = 0;
+
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
 						    priv->num_event_counters,
@@ -619,20 +660,15 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		dev_err(&priv->pdev->dev,
 			"could not setup device_resources: err=%d\n", err);
 		err = -ENXIO;
-		goto abort_with_stats_report;
+		return err;
 	}
 
 	if (!gve_is_gqi(priv)) {
-		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo);
-		if (!priv->ptype_lut_dqo) {
-			err = -ENOMEM;
-			goto abort_with_stats_report;
-		}
 		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto abort_with_ptype_lut;
+			goto deconfigure_device;
 		}
 	}
 
@@ -647,7 +683,7 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		dev_err(&priv->pdev->dev, "Failed to init RSS config");
-		goto abort_with_clock;
+		goto teardown_clock;
 	}
 
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
@@ -659,67 +695,61 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_set_device_resources_ok(priv);
 	return 0;
 
-abort_with_clock:
+teardown_clock:
 	gve_teardown_clock(priv);
-abort_with_ptype_lut:
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-abort_with_stats_report:
-	gve_free_stats_report(priv);
-abort_with_ntfy_blocks:
-	gve_free_notify_blocks(priv);
-abort_with_counter:
-	gve_free_counter_array(priv);
-abort_with_rss_config_cache:
-	gve_free_rss_config_cache(priv);
-abort_with_flow_rule_caches:
-	gve_free_flow_rule_caches(priv);
-
+deconfigure_device:
+	gve_adminq_deconfigure_device_resources(priv);
 	return err;
 }
 
-static void gve_trigger_reset(struct gve_priv *priv);
-
-static void gve_teardown_device_resources(struct gve_priv *priv)
+/*
+ * Request the device to release any allocated shared resources.
+ *
+ * If any part of the teardown step fails, the failure is documented, but is
+ * otherwise ignored. It is expected that a device reset is triggered
+ * immediately after tearing down device resources, which would clear any
+ * lingering state on the device.
+ */
+static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
 		err = gve_flow_rules_reset(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to reset flow rules: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
 		/* detach the stats report */
 		err = gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_REPORT_TIMER_PERIOD);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
+		gve_teardown_clock(priv);
 		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Could not deconfigure device resources: err=%d\n",
 				err);
-			gve_trigger_reset(priv);
-		}
 	}
 
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-
-	gve_free_flow_rule_caches(priv);
-	gve_free_rss_config_cache(priv);
-	gve_free_counter_array(priv);
-	gve_free_notify_blocks(priv);
-	gve_free_stats_report(priv);
-	gve_teardown_clock(priv);
 	gve_clear_device_resources_ok(priv);
 }
 
+static void gve_teardown_device(struct gve_priv *priv)
+{
+	gve_teardown_control_plane_resources(priv);
+	gve_adminq_free(priv);
+	/*
+	 * Free any resources shared with the device only after we have a
+	 * guarantee that the device will not try to access such resources.
+	 * Device commands in gve_teardown_control_plane_resources can fail, in
+	 * which case, device resources won't be relinquished until
+	 * gve_adminq_free is called to trigger a device reset.
+	 */
+	gve_free_control_plane_resources(priv);
+}
+
 static int gve_unregister_qpl(struct gve_priv *priv,
 			      struct gve_queue_page_list *qpl)
 {
@@ -1160,8 +1190,6 @@ void gve_schedule_reset(struct gve_priv *priv)
 	queue_work(priv->gve_wq, &priv->service_task);
 }
 
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up);
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up);
 static void gve_turndown(struct gve_priv *priv);
 static void gve_turnup(struct gve_priv *priv);
 
@@ -1272,11 +1300,12 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 	return err;
 }
 
-
 static void gve_drain_page_cache(struct gve_priv *priv)
 {
 	int i;
 
+	if (!priv->rx)
+		return;
 	for (i = 0; i < priv->rx_cfg.num_queues; i++)
 		page_frag_cache_drain(&priv->rx[i].page_cache);
 }
@@ -1419,10 +1448,11 @@ static int gve_queues_start(struct gve_priv *priv,
 reset:
 	if (gve_get_reset_in_progress(priv))
 		goto stop_and_free_rings;
-	gve_reset_and_teardown(priv, true);
-	/* if this fails there is nothing we can do so just ignore the return */
-	gve_reset_recovery(priv, false);
-	/* return the original error */
+
+	/* Attempt to reset. If reset is successful, gve_queues_start was
+	 * successful.
+	 */
+	err = gve_reset(priv, false);
 	return err;
 stop_and_free_rings:
 	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
@@ -1438,6 +1468,12 @@ static int gve_open(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
+	if (!gve_get_device_resources_ok(priv)) {
+		dev_err(&priv->pdev->dev,
+			"Attempting to open netdev without resources. Device must be reset.");
+		return -ENODEV;
+	}
+
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	err = gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
@@ -1454,41 +1490,18 @@ static int gve_open(struct net_device *dev)
 	return 0;
 }
 
-static int gve_queues_stop(struct gve_priv *priv)
+static void gve_queues_stop(struct gve_priv *priv)
 {
-	int err;
-
-	netif_carrier_off(priv->dev);
-	if (gve_get_device_rings_ok(priv)) {
-		gve_turndown(priv);
-		gve_drain_page_cache(priv);
-		err = gve_destroy_rings(priv);
-		if (err)
-			goto err;
-		err = gve_unregister_qpls(priv);
-		if (err)
-			goto err;
-		gve_clear_device_rings_ok(priv);
-	}
-	timer_delete_sync(&priv->stats_report_timer);
+	gve_turndown(priv);
 
 	gve_unreg_xdp_info(priv);
+	gve_drain_page_cache(priv);
+
+	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
 
 	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
-
-	priv->interface_down_cnt++;
-	return 0;
-
-err:
-	/* This must have been called from a reset due to the rtnl lock
-	 * so just return at this point.
-	 */
-	if (gve_get_reset_in_progress(priv))
-		return err;
-	/* Otherwise reset before returning */
-	gve_reset_and_teardown(priv, true);
-	return gve_reset_recovery(priv, false);
 }
 
 static int gve_close(struct net_device *dev)
@@ -1496,12 +1509,28 @@ static int gve_close(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = gve_queues_stop(priv);
-	if (err)
-		return err;
+	gve_queues_stop(priv);
+
+	/* Surrender to reset if the queue destroying adminq cmds fail. Reset
+	 * will not re-enable the interface.
+	 */
+	if (gve_get_device_rings_ok(priv)) {
+		gve_clear_device_rings_ok(priv);
+		err = gve_destroy_rings(priv);
+		if (err)
+			goto reset;
+		err = gve_unregister_qpls(priv);
+		if (err)
+			goto reset;
+	}
 
 	gve_queues_mem_remove(priv);
+	priv->interface_down_cnt++;
 	return 0;
+
+reset:
+	err = gve_reset(priv, true);
+	return err;
 }
 
 static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
@@ -2420,25 +2449,17 @@ static int gve_setup_device(struct gve_priv *priv)
 {
 	int err;
 
-	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
-	if (!priv->xsk_pools) {
-		err = -ENOMEM;
-		goto err;
-	}
-
 	gve_set_netdev_xdp_features(priv);
 	if (!gve_is_gqi(priv))
 		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
 
-	err = gve_setup_device_resources(priv);
+	err = gve_alloc_control_plane_resources(priv);
 	if (err)
-		goto err_free_xsk_bitmap;
-
+		goto err;
+	err = gve_setup_control_plane_resources(priv);
+	if (err)
+		goto err;
 	return 0;
-
-err_free_xsk_bitmap:
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
 err:
 	return err;
 }
@@ -2513,30 +2534,7 @@ static int gve_init_priv(struct gve_priv *priv)
 	return 0;
 }
 
-static void gve_teardown_priv_resources(struct gve_priv *priv)
-{
-	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
-}
-
-static void gve_trigger_reset(struct gve_priv *priv)
-{
-	/* Reset the device by releasing the AQ */
-	gve_adminq_release(priv);
-}
-
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up)
-{
-	gve_trigger_reset(priv);
-	/* With the reset having already happened, close cannot fail */
-	if (was_up)
-		gve_close(priv->dev);
-	gve_teardown_priv_resources(priv);
-}
-
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
+static int gve_recover(struct gve_priv *priv, bool setup_queues)
 {
 	int err;
 
@@ -2549,54 +2547,52 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
 
 	err = gve_setup_device(priv);
 	if (err)
-		goto err_free_adminq;
-	if (was_up) {
+		goto err;
+	if (setup_queues) {
 		err = gve_open(priv->dev);
 		if (err)
-			goto err_free_device;
+			goto err;
 	}
 	return 0;
 
-err_free_device:
-	gve_teardown_device_resources(priv);
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
-err_free_adminq:
-	gve_adminq_free(priv);
 err:
-	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
-	gve_turndown(priv);
+	dev_err(&priv->pdev->dev, "Recover failed! !!! DISABLING ALL QUEUES !!!\n");
+	gve_teardown_device(priv);
 	return err;
 }
 
-int gve_reset(struct gve_priv *priv, bool attempt_teardown)
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
 {
 	bool was_up = netif_running(priv->dev);
 	int err;
 
+	if (gve_get_reset_in_progress(priv))
+		return 0;
+
 	dev_info(&priv->pdev->dev, "Performing reset\n");
 	gve_clear_do_reset(priv);
 	gve_set_reset_in_progress(priv);
-	/* If we aren't attempting to teardown normally, just go turndown and
-	 * reset right away.
-	 */
-	if (!attempt_teardown) {
-		gve_turndown(priv);
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* Otherwise attempt to close normally */
-		if (was_up) {
-			err = gve_close(priv->dev);
-			/* If that fails reset as we did above */
-			if (err)
-				gve_reset_and_teardown(priv, was_up);
-		}
-		/* Clean up any remaining resources */
-		gve_teardown_priv_resources(priv);
+
+	if (was_up) {
+		gve_queues_stop(priv);
+		gve_destroy_rings(priv);
+		gve_unregister_qpls(priv);
 	}
 
-	/* Set it all back up */
-	err = gve_reset_recovery(priv, was_up);
+	/* Reset the device by releasing the AQ. Rings and other resources
+	 * within the NIC are implicitly destroyed if commands fail.
+	 */
+	gve_adminq_free(priv);
+
+	gve_queues_mem_remove(priv);
+	gve_teardown_clock(priv);
+	gve_free_control_plane_resources(priv);
+
+	err = gve_recover(priv, was_up && !skip_queue_setup);
+	if (err)
+		dev_info(&priv->pdev->dev,
+			 "Failed to recover in reset: %d\n", err);
+
 	gve_clear_reset_in_progress(priv);
 	priv->reset_cnt++;
 	priv->interface_up_cnt = 0;
@@ -2928,7 +2924,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup device: err=%d\n", err);
-		goto abort_with_wq;
+		goto abort_teardown_device;
 	}
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
@@ -2936,7 +2932,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = register_netdev(dev);
 	if (err)
-		goto abort_with_gve_init;
+		goto abort_teardown_device;
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
@@ -2944,8 +2940,8 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
 
-abort_with_gve_init:
-	gve_teardown_priv_resources(priv);
+abort_teardown_device:
+	gve_teardown_device(priv);
 
 abort_with_wq:
 	destroy_workqueue(priv->gve_wq);
@@ -2977,8 +2973,8 @@ static void gve_remove(struct pci_dev *pdev)
 	void __iomem *reg_bar = priv->reg_bar0;
 
 	unregister_netdev(netdev);
-	gve_teardown_priv_resources(priv);
 	destroy_workqueue(priv->gve_wq);
+	gve_teardown_device(priv);
 	priv->ctrl_ops->unmap_db_bar(priv);
 	free_netdev(netdev);
 	pci_iounmap(pdev, reg_bar);
@@ -2996,13 +2992,9 @@ static void gve_shutdown(struct pci_dev *pdev)
 
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+	gve_teardown_device(priv);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 }
@@ -3017,13 +3009,9 @@ static int gve_suspend(struct device *dev)
 	priv->suspend_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+	gve_teardown_device(priv);
 	priv->up_before_suspend = was_up;
 	netdev_unlock(netdev);
 	rtnl_unlock();
@@ -3040,7 +3028,7 @@ static int gve_resume(struct device *dev)
 	priv->resume_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	err = gve_reset_recovery(priv, priv->up_before_suspend);
+	err = gve_recover(priv, priv->up_before_suspend);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 	return err;
-- 
2.54.0.1013.g208068f2d8-goog


