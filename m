Return-Path: <netdev+bounces-264535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDOrCkXkqWl1HAEAu9opvQ
	(envelope-from <netdev+bounces-264535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:15:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8752180FF
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D63C9303B3F1
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD741C0B4;
	Thu,  5 Mar 2026 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FKLRilv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975B41C31A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740907; cv=none; b=D/MI48rTWFzCtZpH1HZ+fcZaw4TGBQtdP9x8bXcXhGuuqjEeQhNhiZ1YBP6GXjUyqGw/m81NbMJVujdVium93iAA/qOU3RjIRDzqyQddqxsZPXzRIAQw1VvWiVhquduZ4i3qJAj7ZIJ1kyqytvhTW51yRYU4qFcNR0BbZqAsacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740907; c=relaxed/simple;
	bh=s+shqdSUHh1XHcUoJ+GLd9bGludiwY1qRuIcKd7JX6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8f6W0C8IMN6zPhbobP0cEWyTIp/ZsGGPNzsaHD+Lt6nLpDr6pA+YNuApCWZ7pQlXVlrnNaoE1BO/irjR5pHWFRvIxsl4oC20zovwv2gbEuCav1xiPT81wQfQkQPg1fKr1V9RNVvN4SPFoh4rZli4PoDbFKxjw8f7g8HmkFzfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FKLRilv1; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-824af5e5c81so8310099b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740905; x=1773345705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X742MM3bjRLLkPQn57crOg7YhGYxGkXa3E19p0llyss=;
        b=XJ2tTep1wnCi4HDvTyaY81Q3rQUvoEhA9nZd5VuCo9ztkmaWlYNqlIp3Nkzx4ZOI6D
         tDFkYQiYH/PDlnMFu1OXD/iaHUgr08GnzCohQUUMafL2PZgxAcDtlap4PsN7ldKTTSMw
         oGteRhX06P0QlTcGC4EROz4qG5x7OeuFWXDckJsqhxbwG2whGrI3ETUgPe82vHAzYXz3
         MAxT1RGZQCAqvLdRZkTuD15DnbvY1KdmjJu9yHE1jGk7suVYLUwWlbUhfdFVdVB1sKkR
         GUr0eN+d5AGeRdKWzq13wDxD6pwfKijLJqOUM17FcxcDbv1aZn08PDn5jmNB5CetL3kt
         gxWA==
X-Gm-Message-State: AOJu0YzBRiZ+RU5HbiTTeEcJToNsyrW5juvcoWX4cvw1+V8hZ5OgipJb
	jSIfRnQI/CnXQ7tONSK++HGP95Du5f3zaJ4fmaFzjH8wzP4+WPsxb6XIbqeP2wLAhD74SAGKFvH
	TD8W8xQD1SWeIZjkstw7QCOdbS3Bg/9RhH4f+AYBIIQcOGmg8qIOEUA/p8jl+NnI/n9Q/si0yWE
	3nCzfMiHzWlZ2WgXFBN5FL19VxK5OirPaTPTUZFULwclg8eHeODpgfe3K+KzdCFrypswcGq4Ma6
	wXypgoY4R4lCBImEw==
X-Gm-Gg: ATEYQzzDVd84IUQpVd8lNHK8oa0NBC90eVj+SJ3ecinHLvFQxbP2kYoTyCTqcBCF9Ti
	FK+cAns3JzeNhke6yxP5q7Oh4e60Uu7YGHflbKn/K7EusorSGwMVTMdR1zL4VaiyMWtTUKPN5Le
	5WT0y2rKiOAp2aJV/pZzXl+0TmtUaPoUH8/WgNbRC21ZUV+vkebO0C9FQz1LW6Mjsog5UUzA4s8
	GUEYAfRb12ZVxK9Iz6M0YRDqjO8eGcRoVI8bySfsb/Jw95QhRgu7VWHWvkCjHcy5pOpoBsoupe2
	IFIS0Uz01w2VVI9Svh6qEqbEs1Jg7zqB7xVhmtEUQkIselu7Pu6ZnVS1gsgBNIzFsOxuvUuPWQj
	rEFCuDk7MQrAHxYX5/91Byd7nHhyz0cYiKOiO1w2+3rt5vRc7UIUqPCgxLB2XXdSKMWuOwX7YEz
	mMynbmoZ8Cl5+k+Zbap1EFinGEORkQkZPAkmmCQ+WFc+4T9wf8aBddpNcgfzuZx1pDDg==
X-Received: by 2002:a05:6a00:2355:b0:823:c4dc:d20 with SMTP id d2e1a72fcca58-82972cf8b6fmr6288799b3a.53.1772740905051;
        Thu, 05 Mar 2026 12:01:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8297b30a4e4sm450234b3a.5.2026.03.05.12.01.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae5031c6c5so218778635ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740903; x=1773345703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X742MM3bjRLLkPQn57crOg7YhGYxGkXa3E19p0llyss=;
        b=FKLRilv1R1r5SGyJcfgLHDrmNaGymmpJS3Sol6+6naMjJrIpURrjxOqqh43bAZnUVB
         si8zDpgFA9651l8HyuUhp14TUI8lAkOxFK4XP0M28pMrBXWvkFnZHX/0tJNBLMKI4tKj
         vygeEt3+MNd8Bn3oG+QmWgm+QpbOetiKwkaVA=
X-Received: by 2002:a17:902:d486:b0:2ae:5ab4:f4c7 with SMTP id d9443c01a7336-2ae6a9ff1f4mr69240615ad.15.1772740903169;
        Thu, 05 Mar 2026 12:01:43 -0800 (PST)
X-Received: by 2002:a17:902:d486:b0:2ae:5ab4:f4c7 with SMTP id d9443c01a7336-2ae6a9ff1f4mr69240315ad.15.1772740902545;
        Thu, 05 Mar 2026 12:01:42 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:42 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v4 09/10] bng_en: implement netdev_stat_ops
Date: Fri,  6 Mar 2026 01:30:16 +0530
Message-ID: <20260305200018.111728-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
References: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 2D8752180FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264535-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Implement netdev_stat_ops to provide standardized per-queue
statistics via the Netlink API.

The implementation was verified using the ynl tool:

$ ./cli.py --spec netlink/specs/netdev.yaml --dump \
    qstats-get --json '{"ifindex":5, "scope":"queue"}'

[{'ifindex': 5, 'queue-id': 0, 'queue-type': 'rx',
  'rx-alloc-fail': 0, 'rx-bytes': 1024, 'rx-packets': 10},
 {'ifindex': 5, 'queue-id': 1, 'queue-type': 'rx',
  'rx-alloc-fail': 0, 'rx-bytes': 2048, 'rx-packets': 20},
 {'ifindex': 5, 'queue-id': 0, 'queue-type': 'tx',
  'tx-bytes': 512,  'tx-packets': 5},
 {'ifindex': 5, 'queue-id': 1, 'queue-type': 'tx',
  'tx-bytes': 1536, 'tx-packets': 15}]

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ec0a8c5e28d..9710113b51f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3089,6 +3089,76 @@ void bnge_get_ring_err_stats(struct bnge_net *bn,
 					    &bn->bnapi[i]->nq_ring);
 }
 
+static void bnge_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_nq_ring_info *nqr;
+	u64 *sw;
+
+	if (!bn->bnapi)
+		return;
+
+	nqr = &bn->bnapi[i]->nq_ring;
+	sw = nqr->stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+	stats->alloc_fail = nqr->sw_stats->rx.rx_oom_discards;
+}
+
+static void bnge_get_queue_stats_tx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_napi *bnapi;
+	u64 *sw;
+
+	if (!bn->tx_ring)
+		return;
+
+	bnapi = bn->tx_ring[bn->tx_ring_map[i]].bnapi;
+	sw = bnapi->nq_ring.stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+}
+
+static void bnge_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	rx->packets = bn->net_stats_prev.rx_packets;
+	rx->bytes = bn->net_stats_prev.rx_bytes;
+	rx->alloc_fail = bn->ring_err_stats_prev.rx_total_oom_discards;
+
+	tx->packets = bn->net_stats_prev.tx_packets;
+	tx->bytes = bn->net_stats_prev.tx_bytes;
+}
+
+static const struct netdev_stat_ops bnge_stat_ops = {
+	.get_queue_stats_rx	= bnge_get_queue_stats_rx,
+	.get_queue_stats_tx	= bnge_get_queue_stats_tx,
+	.get_base_stats		= bnge_get_base_stats,
+};
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
@@ -3252,6 +3322,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bd->netdev = netdev;
 
 	netdev->netdev_ops = &bnge_netdev_ops;
+	netdev->stat_ops = &bnge_stat_ops;
 
 	bnge_set_ethtool_ops(netdev);
 
-- 
2.47.3


