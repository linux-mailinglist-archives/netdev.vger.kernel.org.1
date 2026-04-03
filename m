Return-Path: <netdev+bounces-274927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CCRKQ5vz2kTwQYAu9opvQ
	(envelope-from <netdev+bounces-274927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21C2391CDE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3B0E303CC1F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB237D116;
	Fri,  3 Apr 2026 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e9eZdd6K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11C378D8E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201930; cv=none; b=aSWtoqqK9Wsfm4e3HKtnD/uaH6A5JwBas5xHOoKydTEvMmlWGGBKlPW7akHsosvDbw1cfpAXnAuAUJZbpUTcEU3HWN1whop7W1xVKawMnJ30ONjUfHb2FYodJTv3s7yREb+br2S9IaF/ITW4wh//ik+K61qT+Cp3r3t6lNLJckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201930; c=relaxed/simple;
	bh=UZaqlO8VeMfK4aEKq77j2AIGkI8+JtmAtIhTVoDJFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE97s4xL2NvHcs1lsltTtEaQwJIb/pIwQ4nEvcWjEXnB8H1GTek5x4bQ3vhH3tse2Js0wVZRFMKmTsBHFNOieLn/qGUxAyP3fxKqHKslFciQ+1slMIe3SYwOaH+1NHOqVX0FVDDyWJ47Grg6qEPJm/4GdhDlbYuzEzGVHyzVDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e9eZdd6K; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-60579e72ff9so1111295137.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201928; x=1775806728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6lKK5aP5kx8lPrjwqHaz+xkwFO79/yzuqTI3BWKwFM=;
        b=eJezcJfMTs5aEYPNEDmuXmtaKzGtlACcSKBzRUt/D5VNDJbj+1lowNZ7Ve9gNLMycI
         mAuV1E0rwoCg8+Xxt5Z4TFNd+QfWAv2zL4l1j0+4hRHTWTxNJz6fIzOIpDzvcgoQ3vHJ
         JheA8HOBevOZgAjz+QBCu5F99x4n0oacT8j/KmUtc3Vh9eOFUnCVqCawSOsfNfNXlyzw
         6j4uL2bHvPvMVhoXV9sN4AdSAS/FLCkdQHvi3tBeVbcplDO2N3RQApjdhazeEvWwLYxW
         q5n4uyYaLM2+azB4Sc3imJomssMByUepnoDMQVy0GO5DFjMZh7U+65vhc9f7bpYowIgF
         kJRw==
X-Gm-Message-State: AOJu0YzWA3ySAvl7MmhbcI/GYzddn7EbQ9H6izR1udQTccpoXNSHNFpm
	snsISO0Nsgaw+oNHAat/OZD6ICTQ9ZjMdiZZdE/ZgFIiUQ68zI88yXLaJShaeXcEKj7RavZfkg2
	l3eDYTRf4MbB+9ooi9Fy/RZFRNnZz399v1an7f/ZG+Ww9sujw6mg59cMm5UxFz9cSLrQzHs6oL4
	LYVOHfTxzZedPc99J3SUsVKbl7WIEbMZvhgUVKdy9PBcK9ZfyhoDOe7ZcfvzcBAVmia6Bpn8zu0
	cUAANaRywtTHu3SrQ==
X-Gm-Gg: AeBDietALIL/zXxM2LxJrENx0RJVewonNMxD+V0J3hm6C3Ia0elrfl3eufODqqsR6bL
	jVGp6C7uyxStGDM8s8x+bK4WfdGyyyE625AxQ/OvYeR0epkbJU9rF4riEc6dT8r+QS/Ia50gPAg
	cMBnTl9bVw7aIxlH4beNMNleqWniGpsU/4UpWE41KReAfogCizI3AzxmkV1FB6jYp4+qC/2PFbw
	7W5U1xLWZ9RDUdtzH6mBBkGQt9LZbudHfxgvahiqUdGaGf2uZTfZ8aZEDIhJO4mr/bUwTRHHagv
	D3R+2UdTdj2by0AwjuhgTCQbcLNnRoCdruXk1gWuGBxwqSq/DOy5QBvZ+UYnmd5AqjuIbGLRqyB
	xLah+q5ddfv0/ah1sak4n1umEvTOwdeMLozu4tCMZeQrKXhdxrLjFQJX4V526euPn/m9sTaSfSb
	RE5gDvae9qCrZZWKvRR5Q7fOFEhmrnAyKbWqj4iiiLMviqCtXW6/RN2c/zFW49D6k=
X-Received: by 2002:a05:6102:dcf:b0:5fd:eacf:27df with SMTP id ada2fe7eead31-605a50354e5mr657876137.10.1775201927667;
        Fri, 03 Apr 2026 00:38:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-60582fe6f5fsm410020137.17.2026.04.03.00.38.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 00:38:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so1749045a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775201926; x=1775806726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6lKK5aP5kx8lPrjwqHaz+xkwFO79/yzuqTI3BWKwFM=;
        b=e9eZdd6KfD55KRyDamEMpT0Mf2Ke+Jc/fgFDAUVjXbCo76cuSRduLi08fAxMW3MbRR
         Miaxm4AccVrP/MIb3aOz9VZViuvOyqXXjhFJG9YeuhSlpLoytHcwKtLqOH6bspOjBYXb
         0dIYmp2fwnKM1hsKwwelEmzC4rfmc2JXOpxrQ=
X-Received: by 2002:a17:90b:2b50:b0:35d:9276:eba7 with SMTP id 98e67ed59e1d1-35de5972e5emr1736053a91.7.1775201926570;
        Fri, 03 Apr 2026 00:38:46 -0700 (PDT)
X-Received: by 2002:a17:90b:2b50:b0:35d:9276:eba7 with SMTP id 98e67ed59e1d1-35de5972e5emr1736038a91.7.1775201926090;
        Fri, 03 Apr 2026 00:38:46 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm13124901a91.10.2026.04.03.00.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:38:45 -0700 (PDT)
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
Subject: [PATCH net-next v11 08/10] bng_en: implement ndo_get_stats64
Date: Fri,  3 Apr 2026 13:07:22 +0530
Message-ID: <20260403073724.194360-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274927-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A21C2391CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 61bac71c7f74..9a5d667defea 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2897,6 +2897,46 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_get_port_stats64(struct bnge_net *bn,
+				  struct rtnl_link_stats64 *stats)
+{
+	unsigned int start;
+	u64 *tx, *rx;
+
+	rx = bn->port_stats.sw_stats;
+	tx = bn->port_stats.sw_stats + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+
+	do {
+		start = u64_stats_fetch_begin(&bn->port_stats.syncp);
+
+		stats->rx_crc_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_fcs_err_frames);
+		stats->rx_frame_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_align_err_frames);
+		stats->rx_length_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_undrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_ovrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_runt_frames);
+		stats->rx_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_false_carrier_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_jbr_frames);
+		stats->collisions =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_total_collisions);
+		stats->tx_fifo_errors =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_fifo_underruns);
+		stats->tx_errors = BNGE_GET_TX_PORT_STATS64(tx, tx_err);
+	} while (u64_stats_fetch_retry(&bn->port_stats.syncp, start));
+}
+
+static void bnge_get_stats64(struct net_device *dev,
+			     struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS)
+		bnge_get_port_stats64(bn, stats);
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2930,6 +2970,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
-- 
2.47.3


