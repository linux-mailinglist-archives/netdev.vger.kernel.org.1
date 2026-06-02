Return-Path: <netdev+bounces-294470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iZOpEsJvH2rMlwAAu9opvQ
	(envelope-from <netdev+bounces-294470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:05:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E62C63314F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:05:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=LtI34trX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294470-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294470-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC3430F609F
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1223D332C;
	Tue,  2 Jun 2026 23:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168443CB919
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:59:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444748; cv=none; b=I13dAwSiOGhO+E0PhbJWtrZLcssjkMO/HI+WehXWOTPquY05IkVDL7+KaNsYllQsENY5iloEE5oaxZ6k2YqWub8RKOulFQ2lTJdOiJoPWCZip+Hb2UlQI5gJvndnv4hZ46wVsR2SY8zKsxeh9/FVQ/6GFBednJHryHvT7At2jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444748; c=relaxed/simple;
	bh=fH1rldMVm/p0+7buqgj8QdnCbb2w0Q4Q4kYREg9P/Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZVi0Z5u052Olh8Fqh9G8YBGi/5Ly7/MK3tU5Wn54TFp4LqlWk0tk18z6ztMymr4OYYgLmRxzoaD8E8l4+dmkJ/bJaqoLi2+HUyv4ZSffMOG2LQSk/cCDvdJbGM1yLOxl7+HR1TqS6HqWO/IiaekS+UwUfGcfGdNLLVRW69TVBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LtI34trX; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d982d932aso4105813a91.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444744; x=1781049544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTHN+ncLuFZ47q8BiVAGO1PaS6eMNaA/XSXGliZHi5s=;
        b=LtI34trXlPV4kiZ0uNYFFTn8/OJD6xfGxcQ3FHUNlzxqTEq3fkl321mBheZSQemp4U
         8deV3hwZza7cZ9hfiuXUbOx5fW1obDI/Wb9kR3zfTR38sJD8+P6BZo/B/vdFt/92iGWy
         R8wkiD9HupaGQRwJW0IPN1f2dZE4sQ57CDBrse2tNmqpriW7Omy2cQKZNAZYEUmC4dAU
         P8nF2DyPQhz4xV07C/VV37MitHsZW/CK4X8r3vya6OfTbBLscSlxPAOlbKtQwrvc9vAm
         eiit3wk89r7iDH66Ygx8kZ3eSn4uuOz0Vzns3jQRhnlLXvTmA/da2C717HA4rdHhTR3H
         mJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444744; x=1781049544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTHN+ncLuFZ47q8BiVAGO1PaS6eMNaA/XSXGliZHi5s=;
        b=H52C9H+1CobpfdpS+mfpmq/P182iZaTOH6Uyu0iGJxD0NFDCfj9ohL1dsFoWjIgbLZ
         75ze/4M5jCS7IGZnNdtN1LPbaLwrvfbwynZl7ngXDGjCJMb/twnh6iqvdzsTqCa34l28
         0Z87rn+CSnL3wJPWpgM+b3kJwJK5Rs1FCiKsYe8SSlucNIX8k88NEmjMkdUDsiUst0gY
         MzrwYsIOZjp5a0I6GP8pOWstTXbW8jwqUS6ZTF6/1Mh48PPr4WFoO2FfvHDhY4YujoVb
         DNlJUEW1sE3DZ2jMkgaZOdiYRC5U9AwfLSwSGHzoaUKtCbjEGUnuQ2e8UDaAi1G6LUt7
         UrXg==
X-Gm-Message-State: AOJu0YxxgRtDg4cJL0FGkf4065JK4772J1/GARltUKJ1mKOMVUtBiaCI
	EPOM5/GmT44hux/jpVttlI1NmriEIN7RTVSmowj8bl20ZfkhF0sWZd0uoOtKtN/EK/SDB6623s2
	ztH67x3qp77hBe4DC8mZaoWWkCKpu4CQemnr/DanJ433lgNRSLBeDW2Xe1EJljs+ZCDS4bADx5S
	MrONsoNZzH/zeMPk81g8x2hNb8YvDeVxYg0Z+ehrB++HYbFjlBycLfQ80CPAwd2mI=
X-Received: from pjtz23.prod.google.com ([2002:a17:90a:cb17:b0:368:bb57:bcb7])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5345:b0:36d:635a:ac1b with SMTP id 98e67ed59e1d1-36e34292d44mr918795a91.22.1780444743712;
 Tue, 02 Jun 2026 16:59:03 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:46 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-3-hramamurthy@google.com>
Subject: [PATCH net-next v2 02/15] gve: refactor initialization with helper functions
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294470-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:joshwash@google.com,m:hramamurthy@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E62C63314F

In the interest of commonizing code, refactor gve_probe()
and gve_init_priv() with a few helper functions that can
be expanded and utilized in upcoming patches that add the
mailbox ABI to the driver. The helper functions are:

- gve_set_num_ntfy_blks()
- gve_set_num_queues()

Reorder code to combine lines that accomplish a similar objective
like setting defaults. Move setting HW-GRO and UDP GSO support out
of an Adminq method into gve_init_priv().

These changes are just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c |   8 --
 drivers/net/ethernet/google/gve/gve_main.c   | 108 +++++++++++--------
 2 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 70ffed8b52c3..dfeabddfb396 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1117,14 +1117,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_set_default_rss_sizes(priv);
 
-	/* DQO supports HW-GRO and UDP_GSO */
-	if (gve_is_dqo(priv)) {
-		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
-
-		priv->dev->hw_features |= additional_features;
-		priv->dev->features |= additional_features;
-	}
-
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
 	mtu = be16_to_cpu(descriptor->mtu);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 30bf6df4ebc5..b9542ef36b29 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2398,65 +2398,32 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+static int gve_set_num_ntfy_blks(struct gve_priv *priv)
 {
 	int num_ntfy;
-	int err;
-
-	/* Set up the adminq */
-	err = gve_adminq_alloc(&priv->pdev->dev, priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Failed to alloc admin queue: err=%d\n", err);
-		return err;
-	}
-
-	err = gve_verify_driver_compatibility(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not verify driver compatibility: err=%d\n", err);
-		goto err;
-	}
-
-	priv->num_registered_pages = 0;
-
-	if (skip_describe_device)
-		goto setup_device;
 
-	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
-	/* Get the initial information we need from the device */
-	err = gve_adminq_describe_device(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not get device information: err=%d\n", err);
-		goto err;
-	}
-	priv->dev->mtu = priv->dev->max_mtu;
 	num_ntfy = pci_msix_vec_count(priv->pdev);
 	if (num_ntfy <= 0) {
 		dev_err(&priv->pdev->dev,
 			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		err = num_ntfy;
-		goto err;
+		return num_ntfy;
 	} else if (num_ntfy < GVE_MIN_MSIX) {
 		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
 			GVE_MIN_MSIX, num_ntfy);
-		err = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
-	/* Big TCP is only supported on DQO */
-	if (!gve_is_gqi(priv))
-		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
-
-	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
 	/* gvnic has one Notification Block per MSI-x vector, except for the
 	 * management vector
 	 */
 	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
 	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-	priv->numa_node = dev_to_node(&priv->pdev->dev);
 
+	return 0;
+}
+
+static void gve_set_num_queues(struct gve_priv *priv)
+{
 	priv->tx_cfg.max_queues =
 		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
 	priv->rx_cfg.max_queues =
@@ -2470,18 +2437,73 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
 						priv->rx_cfg.num_queues);
 	}
-	priv->tx_cfg.num_xdp_queues = 0;
 
 	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
 		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
 	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
+}
+
+static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+{
+	int err;
+
+	/* Set up the adminq */
+	err = gve_adminq_alloc(&priv->pdev->dev, priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Failed to alloc admin queue: err=%d\n", err);
+		return err;
+	}
+
+	priv->num_registered_pages = 0;
+
+	if (skip_describe_device)
+		goto setup_device;
+
+	err = gve_verify_driver_compatibility(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not verify driver compatibility: err=%d\n", err);
+		goto err;
+	}
+
+	/* Get the initial information we need from the device */
+	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
+	err = gve_adminq_describe_device(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not get device information: err=%d\n", err);
+		goto err;
+	}
+
+	err = gve_set_num_ntfy_blks(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not setup notify blocks: err=%d\n", err);
+		goto err;
+	}
+
+	gve_set_num_queues(priv);
+
+	if (gve_is_dqo(priv)) {
+		/* DQO supports HW-GRO and UDP_GSO */
+		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
+
+		priv->dev->hw_features |= additional_features;
+		priv->dev->features |= additional_features;
 
-	if (!gve_is_gqi(priv)) {
 		priv->tx_coalesce_usecs = GVE_TX_IRQ_RATELIMIT_US_DQO;
 		priv->rx_coalesce_usecs = GVE_RX_IRQ_RATELIMIT_US_DQO;
+
+		/* Big TCP is only supported on DQO */
+		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 	}
 
+	priv->dev->mtu = priv->dev->max_mtu;
+	priv->numa_node = dev_to_node(&priv->pdev->dev);
+	priv->tx_cfg.num_xdp_queues = 0;
+	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
 	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
 	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
 
-- 
2.54.0.1013.g208068f2d8-goog


