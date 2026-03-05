Return-Path: <netdev+bounces-264536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGzpIhPjqWl1HAEAu9opvQ
	(envelope-from <netdev+bounces-264536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:09:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEA218006
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DAF730E972E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3833EF0A0;
	Thu,  5 Mar 2026 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DbOUaRaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DD3EDAB2
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740912; cv=none; b=Ezcm5fjg3C7fga922nofbL8ccKha6PFFJPwCnM4bX0DeiRN4S4xdO1RS/CBZpeP5yylyA+/xdTJ3vVUlJISecm8P9jilhImImlT84ulwmiUVyivlnaD8nzqYemYPkxdyeYy5bAjme3/osS7Lfo4RjGWwS11F1VtCUp39TMMV7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740912; c=relaxed/simple;
	bh=xVLP3g2IrLa/sEPJkiOaPYnXzlFOBdIGNiPxd3lQY7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZzhdksGm06g4VNMRNyL/PzJl32BaGi5Bp9+UVbxbejhfZxE8NsBEMez2PVuVkByEYgNHVShyK2n4kYIngZgdBguUj8YnLavMc08fMJSzIGn7fj5gk9rGZgEEZxDik+r1CenQf+cijMhywodpgUZvQzILmA9IOBhu6+jJEsG7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DbOUaRaW; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8299f1ca894so43912b3a.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740910; x=1773345710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOsnD0Nn2kbWU9xFPlC6q+2AQ7Cnu0X2R4k8ACFeJoI=;
        b=PE0iJ2c+KF5W11EIyVVcFaF22lS9bfe+G6rSQYRTKC1D5Iw+3eccInEJCXvrf1DplF
         LfHIJCVaHXtDzAtynT10lhudGpdhrwCLnDoqo74sseoZfdO8gexITC90FC8xkzjTx2Lb
         Vh1RE+1UWM9HOVlReZiQle+IzeJ5e+AsZbbU8x5AEUBNTh+xBvcNaDJxNVdzFsxAOGQH
         jW5aCtg7sY4OL8DL0S9wgafEBzSKHSj9BRfWcdtcFUclCo5QidJ6KOooMZBR7GIFrC2I
         Sy2eCTzAWrO85tdSYZ7Au4dPlqNy3SQxKysdHECiYY5600cq+iBRcJ+q8AZWKZjCYmdV
         OYow==
X-Gm-Message-State: AOJu0YzcyuzIyUNGtH8dUcGl4rjkxPI3q3XVx6igDPvvn1x2Ox3Hl3A6
	LjENVdFUPSGHhoyaP8LPeOF6LlFiPGDJdx5azJp5BngmAeOTZ10KoGRWWJMaanQplZ3LHI1/43H
	czK5HyRP7afjG+zcju0MaPc3Blr0xUKJY114GMjZFXHY5EKqs+PEmOrbzMt6jMOdhrFfIC9Aqzf
	3jnTmKJXqAWIlq/tPBfGolHD/lbDwf0Q0ZAJow0Be8YeVNcmdc+a8jBNKfbfTJRoSUEIx57J+NS
	Ypo7Wd45ZvR8jao6A==
X-Gm-Gg: ATEYQzwKKIvXcnBqM7gxgUzFN0LflcITrodX4WAo2nQjnYz6BDtAlcCHi6wgJbU0Y9m
	FaRNLoBq6UZpU6BCNHvkaYj7d8D6iIKIr5bvTeFiVuB7i0CAQS54kKWVgZwbtpZN5j16/P+lEzJ
	FHlYFDhGd8CqlqVassQ36q29bMEvbeupdk4QjsoEGvOYMPpiLPccHL59T1wh2fGaPT1VsfdbdmL
	KUKYgQ7SaNJitpz27/EGXQ8OxujU6pw+3sIvpZzwNgkbBTIfVbXVZBBjf5EB+r0/6eWZ9ag+cxc
	oAWhq15JopoEx/N/YBNncj3OxwzEZMeUrXo3rFWdp7dHoQTjv8ZWdPtQTrO6znvyiPE+IWGBNbz
	7a//5yWV8NqD0VmhZ3MrBc2TJX6Qlrdj73yymteZfCBdQiPU43dEta33Hbn68AkTDewLQ6urd6+
	jVUqgPTBb8p6gmubqIH8Onmr7LUkVy0j1UZuiboqAo+HZ+Ub2QT/CDvXgOK0IEHt5g5Q==
X-Received: by 2002:a05:6a00:854:b0:823:3fd0:7a08 with SMTP id d2e1a72fcca58-82972d50dd2mr7054064b3a.49.1772740909713;
        Thu, 05 Mar 2026 12:01:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82986f21dd7sm271495b3a.6.2026.03.05.12.01.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358e425c261so7512567a91.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740908; x=1773345708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOsnD0Nn2kbWU9xFPlC6q+2AQ7Cnu0X2R4k8ACFeJoI=;
        b=DbOUaRaWxdfLYC12nb4JhcKJqbmhQEhZ9jUwxXx7u+ofbp3vVcTZqr91Fz4n1bre3f
         xY0YEbpIGvp1Ede36uZbnqu2pA3OHGNIvYKkm8Md0KWZOr8ruumpR2cljg+45pAN58wp
         0Kv9ztsI9BbvZi3NB/8XuOfqEC+SURTh+ezeM=
X-Received: by 2002:a17:902:cf03:b0:2ae:4d93:ba36 with SMTP id d9443c01a7336-2ae6a9de465mr76077155ad.11.1772740907457;
        Thu, 05 Mar 2026 12:01:47 -0800 (PST)
X-Received: by 2002:a17:902:cf03:b0:2ae:4d93:ba36 with SMTP id d9443c01a7336-2ae6a9de465mr76076795ad.11.1772740906758;
        Thu, 05 Mar 2026 12:01:46 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:46 -0800 (PST)
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
Subject: [PATCH net-next v4 10/10] bng_en: add support for ethtool -S stats display
Date: Fri,  6 Mar 2026 01:30:17 +0530
Message-ID: <20260305200018.111728-11-bhargava.marreddy@broadcom.com>
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
X-Rspamd-Queue-Id: 22CEA218006
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264536-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Implement the legacy ethtool statistics interface (.get_sset_count,
.get_strings, and .get_ethtool_stats) to provide per-queue and
port-level visibility.

A. Exclusions:
  To comply with the "no duplication" policy, excluded all stats already
  covered by rtnl_link_stats64.
  For ex:
  1. tx_err
  2. tx_fifo_underruns
  3. tx_total_collisions

B. Retained Stats Analysis:
  Retained the counters which provide unique per-queue granularity or
  represent different hardware events:

  1. rxqN_errors
  2. txqN_errors

   These provide per-ring visibility for debugging.
   While they look similar to ndo_get_stats64's [rx/tx]_errors counters,
   they map to different hardware sources:
   For ex:
   - ethtool rxqN_errors: ctx_hw_stats->rx_error_pkts (per-ring)
   - ndo_get_stats64 rx_errors: (rx_port_stats->rx_false_carrier_frames +
     rx_jbr_frames) (per-port)

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 566 ++++++++++++++++++
 1 file changed, 566 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 2ae13f18e2d..1a15c3ff014 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -31,6 +31,328 @@ static int bnge_nway_reset(struct net_device *dev)
 	return rc;
 }
 
+static const char * const bnge_ring_rx_stats_str[] = {
+	"ucast_packets",
+	"mcast_packets",
+	"bcast_packets",
+	"discards",
+	"errors",
+	"ucast_bytes",
+	"mcast_bytes",
+	"bcast_bytes",
+};
+
+static const char * const bnge_ring_tx_stats_str[] = {
+	"ucast_packets",
+	"mcast_packets",
+	"bcast_packets",
+	"errors",
+	"discards",
+	"ucast_bytes",
+	"mcast_bytes",
+	"bcast_bytes",
+};
+
+static const char * const bnge_ring_tpa_stats_str[] = {
+	"tpa_packets",
+	"tpa_bytes",
+	"tpa_events",
+	"tpa_aborts",
+};
+
+static const char * const bnge_ring_tpa2_stats_str[] = {
+	"tpa_eligible_pkt",
+	"tpa_eligible_bytes",
+	"tpa_pkt",
+	"tpa_bytes",
+	"tpa_errors",
+	"tpa_events",
+};
+
+static const char * const bnge_rx_sw_stats_str[] = {
+	"l4_csum_errors",
+	"resets",
+	"buf_errors",
+};
+
+#define BNGE_RX_STATS_ENTRY(counter)	\
+	{ BNGE_RX_STATS_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_TX_STATS_ENTRY(counter)	\
+	{ BNGE_TX_STATS_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_RX_STATS_EXT_ENTRY(counter)	\
+	{ BNGE_RX_STATS_EXT_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_TX_STATS_EXT_ENTRY(counter)	\
+	{ BNGE_TX_STATS_EXT_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_RX_STATS_EXT_PFC_ENTRY(n)				\
+	BNGE_RX_STATS_EXT_ENTRY(pfc_pri##n##_rx_duration_us),	\
+	BNGE_RX_STATS_EXT_ENTRY(pfc_pri##n##_rx_transitions)
+
+#define BNGE_TX_STATS_EXT_PFC_ENTRY(n)				\
+	BNGE_TX_STATS_EXT_ENTRY(pfc_pri##n##_tx_duration_us),	\
+	BNGE_TX_STATS_EXT_ENTRY(pfc_pri##n##_tx_transitions)
+
+#define BNGE_RX_STATS_EXT_PFC_ENTRIES				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(7)
+
+#define BNGE_TX_STATS_EXT_PFC_ENTRIES				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(0),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(1),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(2),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(3),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(4),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(5),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(6),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(7)
+
+#define BNGE_RX_STATS_EXT_COS_ENTRY(n)				\
+	BNGE_RX_STATS_EXT_ENTRY(rx_bytes_cos##n),		\
+	BNGE_RX_STATS_EXT_ENTRY(rx_packets_cos##n)
+
+#define BNGE_TX_STATS_EXT_COS_ENTRY(n)				\
+	BNGE_TX_STATS_EXT_ENTRY(tx_bytes_cos##n),		\
+	BNGE_TX_STATS_EXT_ENTRY(tx_packets_cos##n)
+
+#define BNGE_RX_STATS_EXT_COS_ENTRIES				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(7)				\
+
+#define BNGE_TX_STATS_EXT_COS_ENTRIES				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(0),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(1),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(2),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(3),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(4),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(5),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(6),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(7)				\
+
+#define BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(n)			\
+	BNGE_RX_STATS_EXT_ENTRY(rx_discard_bytes_cos##n),	\
+	BNGE_RX_STATS_EXT_ENTRY(rx_discard_packets_cos##n)
+
+#define BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(7)
+
+#define BNGE_RX_STATS_PRI_ENTRY(counter, n)		\
+	{ BNGE_RX_STATS_EXT_OFFSET(counter##_cos0),	\
+	  __stringify(counter##_pri##n) }
+
+#define BNGE_TX_STATS_PRI_ENTRY(counter, n)		\
+	{ BNGE_TX_STATS_EXT_OFFSET(counter##_cos0),	\
+	  __stringify(counter##_pri##n) }
+
+#define BNGE_RX_STATS_PRI_ENTRIES(counter)		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 0),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 1),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 2),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 3),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 4),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 5),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 6),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 7)
+
+#define BNGE_TX_STATS_PRI_ENTRIES(counter)		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 0),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 1),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 2),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 3),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 4),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 5),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 6),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 7)
+
+static const char *const bnge_ring_err_stats_arr[] = {
+	"rx_total_l4_csum_errors",
+	"rx_total_resets",
+	"rx_total_buf_errors",
+	"rx_total_oom_discards",
+	"rx_total_netpoll_discards",
+	"rx_total_ring_discards",
+	"tx_total_resets",
+	"tx_total_ring_discards",
+};
+
+#define NUM_RING_RX_SW_STATS		ARRAY_SIZE(bnge_rx_sw_stats_str)
+#define NUM_RING_RX_HW_STATS		ARRAY_SIZE(bnge_ring_rx_stats_str)
+#define NUM_RING_TX_HW_STATS		ARRAY_SIZE(bnge_ring_tx_stats_str)
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_port_stats_ext_arr[] = {
+	BNGE_TX_STATS_EXT_COS_ENTRIES,
+	BNGE_TX_STATS_EXT_PFC_ENTRIES,
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_rx_bytes_pri_arr[] = {
+	BNGE_RX_STATS_PRI_ENTRIES(rx_bytes),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_rx_pkts_pri_arr[] = {
+	BNGE_RX_STATS_PRI_ENTRIES(rx_packets),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_bytes_pri_arr[] = {
+	BNGE_TX_STATS_PRI_ENTRIES(tx_bytes),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_pkts_pri_arr[] = {
+	BNGE_TX_STATS_PRI_ENTRIES(tx_packets),
+};
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_port_stats_arr[] = {
+	BNGE_RX_STATS_ENTRY(rx_good_vlan_frames),
+	BNGE_RX_STATS_ENTRY(rx_total_frames),
+	BNGE_RX_STATS_ENTRY(rx_ucast_frames),
+	BNGE_RX_STATS_ENTRY(rx_pfc_frames),
+	BNGE_RX_STATS_ENTRY(rx_mtu_err_frames),
+	BNGE_RX_STATS_ENTRY(rx_tagged_frames),
+	BNGE_RX_STATS_ENTRY(rx_double_tagged_frames),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri0),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri1),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri2),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri3),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri4),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri5),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri6),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri7),
+	BNGE_RX_STATS_ENTRY(rx_eee_lpi_events),
+	BNGE_RX_STATS_ENTRY(rx_eee_lpi_duration),
+	BNGE_RX_STATS_ENTRY(rx_runt_bytes),
+	BNGE_RX_STATS_ENTRY(rx_runt_frames),
+	BNGE_RX_STATS_ENTRY(rx_stat_discard),
+	BNGE_RX_STATS_ENTRY(rx_stat_err),
+
+	BNGE_TX_STATS_ENTRY(tx_good_vlan_frames),
+	BNGE_TX_STATS_ENTRY(tx_total_frames),
+	BNGE_TX_STATS_ENTRY(tx_ucast_frames),
+	BNGE_TX_STATS_ENTRY(tx_pfc_frames),
+	BNGE_TX_STATS_ENTRY(tx_jabber_frames),
+	BNGE_TX_STATS_ENTRY(tx_fcs_err_frames),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri0),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri1),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri2),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri3),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri4),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri5),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri6),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri7),
+	BNGE_TX_STATS_ENTRY(tx_eee_lpi_events),
+	BNGE_TX_STATS_ENTRY(tx_eee_lpi_duration),
+	BNGE_TX_STATS_ENTRY(tx_xthol_frames),
+	BNGE_TX_STATS_ENTRY(tx_stat_discard),
+	BNGE_TX_STATS_ENTRY(tx_stat_error),
+};
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_port_stats_ext_arr[] = {
+	BNGE_RX_STATS_EXT_ENTRY(link_down_events),
+	BNGE_RX_STATS_EXT_ENTRY(continuous_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(resume_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(continuous_roce_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(resume_roce_pause_events),
+	BNGE_RX_STATS_EXT_COS_ENTRIES,
+	BNGE_RX_STATS_EXT_PFC_ENTRIES,
+	BNGE_RX_STATS_EXT_ENTRY(rx_bits),
+	BNGE_RX_STATS_EXT_ENTRY(rx_buffer_passed_threshold),
+	BNGE_RX_STATS_EXT_ENTRY(rx_corrected_bits),
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES,
+	BNGE_RX_STATS_EXT_ENTRY(rx_fec_corrected_blocks),
+	BNGE_RX_STATS_EXT_ENTRY(rx_fec_uncorrectable_blocks),
+	BNGE_RX_STATS_EXT_ENTRY(rx_filter_miss),
+};
+
+static int bnge_get_num_tpa_ring_stats(struct bnge_dev *bd)
+{
+	if (BNGE_SUPPORTS_TPA(bd))
+		return BNGE_NUM_TPA_RING_STATS;
+	return 0;
+}
+
+#define BNGE_NUM_RING_ERR_STATS	ARRAY_SIZE(bnge_ring_err_stats_arr)
+#define BNGE_NUM_PORT_STATS ARRAY_SIZE(bnge_port_stats_arr)
+#define BNGE_NUM_STATS_PRI			\
+	(ARRAY_SIZE(bnge_rx_bytes_pri_arr) +	\
+	 ARRAY_SIZE(bnge_rx_pkts_pri_arr) +	\
+	 ARRAY_SIZE(bnge_tx_bytes_pri_arr) +	\
+	 ARRAY_SIZE(bnge_tx_pkts_pri_arr))
+
+static int bnge_get_num_ring_stats(struct bnge_dev *bd)
+{
+	int rx, tx;
+
+	rx = NUM_RING_RX_HW_STATS + NUM_RING_RX_SW_STATS +
+	     bnge_get_num_tpa_ring_stats(bd);
+	tx = NUM_RING_TX_HW_STATS;
+	return rx * bd->rx_nr_rings +
+	       tx * bd->tx_nr_rings_per_tc;
+}
+
+static u32 bnge_get_num_stats(struct bnge_net *bn)
+{
+	u32 num_stats = bnge_get_num_ring_stats(bn->bd);
+	u32 len;
+
+	num_stats += BNGE_NUM_RING_ERR_STATS;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS)
+		num_stats += BNGE_NUM_PORT_STATS;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		len = min_t(int, bn->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnge_port_stats_ext_arr));
+		num_stats += len;
+		len = min_t(int, bn->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+		num_stats += len;
+		if (bn->pri2cos_valid)
+			num_stats += BNGE_NUM_STATS_PRI;
+	}
+
+	return num_stats;
+}
+
 static void bnge_get_drvinfo(struct net_device *dev,
 			     struct ethtool_drvinfo *info)
 {
@@ -40,6 +362,247 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 	strscpy(info->fw_version, bd->fw_ver_str, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
+	info->n_stats = bnge_get_num_stats(bn);
+}
+
+static int bnge_get_sset_count(struct net_device *dev, int sset)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		return bnge_get_num_stats(bn);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static bool is_rx_ring(struct bnge_dev *bd, u16 ring_num)
+{
+	return ring_num < bd->rx_nr_rings;
+}
+
+static bool is_tx_ring(struct bnge_dev *bd, u16 ring_num)
+{
+	u16 tx_base = 0;
+
+	if (!(bd->flags & BNGE_EN_SHARED_CHNL))
+		tx_base = bd->rx_nr_rings;
+
+	if (ring_num >= tx_base && ring_num < (tx_base + bd->tx_nr_rings))
+		return true;
+	return false;
+}
+
+static void bnge_get_ethtool_stats(struct net_device *dev,
+				   struct ethtool_stats *stats, u64 *buf)
+{
+	struct bnge_total_ring_err_stats ring_err_stats = {};
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u64 *curr, *prev;
+	u32 tpa_stats;
+	u32 i, j = 0;
+
+	if (!bn->bnapi) {
+		j += bnge_get_num_ring_stats(bd);
+		goto skip_ring_stats;
+	}
+
+	tpa_stats = bnge_get_num_tpa_ring_stats(bd);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+		u64 *sw_stats = nqr->stats.sw_stats;
+		u64 *sw;
+		int k;
+
+		if (is_rx_ring(bd, i)) {
+			for (k = 0; k < NUM_RING_RX_HW_STATS; j++, k++)
+				buf[j] = sw_stats[k];
+		}
+		if (is_tx_ring(bd, i)) {
+			k = NUM_RING_RX_HW_STATS;
+			for (; k < NUM_RING_RX_HW_STATS + NUM_RING_TX_HW_STATS;
+			       j++, k++)
+				buf[j] = sw_stats[k];
+		}
+		if (!tpa_stats || !is_rx_ring(bd, i))
+			goto skip_tpa_ring_stats;
+
+		k = NUM_RING_RX_HW_STATS + NUM_RING_TX_HW_STATS;
+		for (; k < NUM_RING_RX_HW_STATS + NUM_RING_TX_HW_STATS +
+			   tpa_stats; j++, k++)
+			buf[j] = sw_stats[k];
+
+skip_tpa_ring_stats:
+		sw = (u64 *)&nqr->sw_stats->rx;
+		if (is_rx_ring(bd, i)) {
+			for (k = 0; k < NUM_RING_RX_SW_STATS; j++, k++)
+				buf[j] = sw[k];
+		}
+	}
+
+	bnge_get_ring_err_stats(bn, &ring_err_stats);
+
+skip_ring_stats:
+	curr = &ring_err_stats.rx_total_l4_csum_errors;
+	prev = &bn->ring_err_stats_prev.rx_total_l4_csum_errors;
+	for (i = 0; i < BNGE_NUM_RING_ERR_STATS; i++, j++, curr++, prev++)
+		buf[j] = *curr + *prev;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		u64 *port_stats = bn->port_stats.sw_stats;
+
+		for (i = 0; i < BNGE_NUM_PORT_STATS; i++, j++)
+			buf[j] = *(port_stats + bnge_port_stats_arr[i].offset);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		u64 *rx_port_stats_ext = bn->rx_port_stats_ext.sw_stats;
+		u64 *tx_port_stats_ext = bn->tx_port_stats_ext.sw_stats;
+		u32 len;
+
+		len = min_t(u32, bn->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnge_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
+			buf[j] = *(rx_port_stats_ext +
+				   bnge_port_stats_ext_arr[i].offset);
+		}
+		len = min_t(u32, bn->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
+			buf[j] = *(tx_port_stats_ext +
+				   bnge_tx_port_stats_ext_arr[i].offset);
+		}
+		if (bn->pri2cos_valid) {
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_rx_bytes_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(rx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_rx_pkts_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(rx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_tx_bytes_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(tx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_tx_pkts_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(tx_port_stats_ext + n);
+			}
+		}
+	}
+}
+
+static void bnge_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u32 i, j, num_str;
+	const char *str;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < bd->nq_nr_rings; i++) {
+			if (is_rx_ring(bd, i))
+				for (j = 0; j < NUM_RING_RX_HW_STATS; j++) {
+					str = bnge_ring_rx_stats_str[j];
+					ethtool_sprintf(&buf, "rxq%d_%s", i,
+							str);
+				}
+			if (is_tx_ring(bd, i))
+				for (j = 0; j < NUM_RING_TX_HW_STATS; j++) {
+					str = bnge_ring_tx_stats_str[j];
+					ethtool_sprintf(&buf, "txq%d_%s", i,
+							str);
+				}
+			num_str = bnge_get_num_tpa_ring_stats(bd);
+			if (!num_str || !is_rx_ring(bd, i))
+				goto skip_tpa_stats;
+
+			if (bd->max_tpa_v2)
+				for (j = 0; j < num_str; j++) {
+					str = bnge_ring_tpa2_stats_str[j];
+					ethtool_sprintf(&buf, "rxq%d_%s", i,
+							str);
+				}
+			else
+				for (j = 0; j < num_str; j++) {
+					str = bnge_ring_tpa_stats_str[j];
+					ethtool_sprintf(&buf, "rxq%d_%s", i,
+							str);
+				}
+skip_tpa_stats:
+			if (is_rx_ring(bd, i))
+				for (j = 0; j < NUM_RING_RX_SW_STATS; j++) {
+					str = bnge_rx_sw_stats_str[j];
+					ethtool_sprintf(&buf, "rxq%d_%s", i,
+							str);
+				}
+		}
+		for (i = 0; i < BNGE_NUM_RING_ERR_STATS; i++)
+			ethtool_puts(&buf, bnge_ring_err_stats_arr[i]);
+
+		if (bn->flags & BNGE_FLAG_PORT_STATS)
+			for (i = 0; i < BNGE_NUM_PORT_STATS; i++) {
+				str = bnge_port_stats_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+		if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+			u32 len;
+
+			len = min_t(u32, bn->fw_rx_stats_ext_size,
+				    ARRAY_SIZE(bnge_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
+				str = bnge_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+			len = min_t(u32, bn->fw_tx_stats_ext_size,
+				    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
+				str = bnge_tx_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+			if (bn->pri2cos_valid) {
+				for (i = 0; i < 8; i++) {
+					str = bnge_rx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_rx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_tx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_tx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+			}
+		}
+		break;
+	default:
+		netdev_err(bd->netdev, "%s invalid request %x\n",
+			   __func__, stringset);
+		break;
+	}
 }
 
 static void bnge_get_eth_phy_stats(struct net_device *dev,
@@ -262,6 +825,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.nway_reset		= bnge_nway_reset,
 	.get_pauseparam		= bnge_get_pauseparam,
 	.set_pauseparam		= bnge_set_pauseparam,
+	.get_sset_count		= bnge_get_sset_count,
+	.get_strings		= bnge_get_strings,
+	.get_ethtool_stats	= bnge_get_ethtool_stats,
 	.get_eth_phy_stats	= bnge_get_eth_phy_stats,
 	.get_eth_mac_stats	= bnge_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= bnge_get_eth_ctrl_stats,
-- 
2.47.3


