Return-Path: <netdev+bounces-266192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEZ2MuhAsGkehgIAu9opvQ
	(envelope-from <netdev+bounces-266192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:03:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5822543B2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 484413162466
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E62FFF90;
	Tue, 10 Mar 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LAzo73Qb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6C30F534
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153757; cv=none; b=GCclXGtu+8W8ehvt3MZVOUkqgpePSNMVrnQ7PXX5ZoAMNjhRcWWW9HnWDpa7EW+NpF2je6ZA6gena06zo9jrDZ+l6BOc7ArGIhXHXKlZV0HDXR8sg2m0jsMUJ2k8Cq52447p6/qSRetOGJxqXRPw4grwDvfetSV4b9PJAfzyB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153757; c=relaxed/simple;
	bh=HD53WEloZpiUkqsGJVarB/QEtXh3b9MZItbp9/qP+Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3QPeOC/pXJ0rTF3tAP7oGATHHr/oVD9uEZiLm1hUBqkpEpgHvWmI3qmOk9s367G86sUtPIwmOuh6VySXbLPtZGmuSoAMI17LcpYRwNoqsMdnegOlAD6SDlJ6caaMpZ01wv8FN5ik40qVn5D1tviu03pYuI08rVECrkGTSZ4YHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LAzo73Qb; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ae5423b02aso61272395ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153755; x=1773758555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwqrorqNkgGbJ1s5Hp8bRWegJettjwK6hrdBhdQhXEE=;
        b=ENFs+6Ba+z1syGQsXaQT8O/RUgeBS6I4u+NEbvT5szLSyK8suH3dKD2fUPeRgKoSIM
         ZVqHu5klacUfCr73vK8zfhft0ZuknI/NczEvl+68Qg+72BISzESn/3jRoW2PP729gMn0
         QtuAM2T94VlnbYgu3QOvEW1BACRwBQiSNVpMW0hwVbuFjvyOEYhoN33jIPAx3o9tdIy3
         oFffks1ONvuwVdaJp+1LgnJpBhJdAs7a3eEpjRyJjlJOdmFgc4z6O65z5AFzSZAg3T50
         0HF5NQs3FjxRp5Fb8/DYB5FPpjOnexyYl69ZALBntv3VysYTdS2YNtz0nelH8iR4dVy+
         3dLg==
X-Gm-Message-State: AOJu0Yyf/2DdgQGQrq40i4gSjDxFD0/3TS/Qgq8j2PRPO9trTKS5t47i
	mSBX1mbRFphv0grSe1GppeArFSUUgIEFAqRYOyqjPmEk1HyUDQimgWBDWPNMTUrN8hYhuWADMVg
	uWpaPjq94Sloty+89moomGj+n0vpuNsO6WxVDxC5QlcORH0A64gZqMVllto/YwwEHWxDoSPjx0o
	6UXmHZnROJkBr9ncJ7Skxbg8H1cNzOxyRs97l7ITlHVjGxseLI0T2BrvsYiY41eiO80r9PjTv/j
	oUGJGMHaTEvAGhJBA==
X-Gm-Gg: ATEYQzwvQ1n6l4JSLDc/YMONdBOhWGZfUuq++osCgVbRnzr93m5Xn+s2UzAWIm92dBk
	MCkFS+ulHDsIeC9aVIkVAYZp1GwnosSngoo5ixvjkN6cU6EIqPsV/zY6qXjaffFIsq8rU3wILR9
	sluDHrfWw3um7AK1J1ucTO5N6AX2yydnpwH7TRMQVBphzN9gayx182WJmg/DSsi+/dXlX4ayn4N
	MzYgRmLhLxLoQmufFAh5BJLNkNH8p7CtSe6N6ucQCG3njQBnPto5LbdE3NFfDPdFMk2K3/JrhWh
	UHbxFISwDFyoJmz6BLhd+MqKLQr5KjuGZuULna30SL9p8m41OO694n17EOl811qIK0C4gkXoY3g
	63TIBb8F1zlLz7WCwF3LfINMkc40QggXhy9jHeO27jd91nYrXLSfLtnL1Zy2n4bVv2Kv06CJeMX
	H5/YeKWn/XRxSWdVppQL2T9dgEZGzsgTY56bhOWIa7bJN7q+lnUFgbtmjJBlg1p7Y=
X-Received: by 2002:a17:902:ef46:b0:2ae:3b36:23e7 with SMTP id d9443c01a7336-2ae82398d80mr151086495ad.16.1773153755153;
        Tue, 10 Mar 2026 07:42:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae83f47df8sm19231725ad.41.2026.03.10.07.42.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:42:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae57228f64so95347275ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773153753; x=1773758553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwqrorqNkgGbJ1s5Hp8bRWegJettjwK6hrdBhdQhXEE=;
        b=LAzo73QboU75+BoJeUQlPMRnpuEM3qyL/6c1SM4SGo64E4iBmBCN8cSpSqPWoznOVf
         8dnOXopd25S1uAPADTot/Q1Sl16rOhj+FcMpVYhHP7ZCmRmMVfxrAQFLxhR30Peh1A+O
         X6yPkXf4kaGn/TreiembuNFfnkxGjt8zedB2c=
X-Received: by 2002:a17:903:388f:b0:2ae:665c:8b17 with SMTP id d9443c01a7336-2ae8248700amr152785285ad.46.1773153753339;
        Tue, 10 Mar 2026 07:42:33 -0700 (PDT)
X-Received: by 2002:a17:903:388f:b0:2ae:665c:8b17 with SMTP id d9443c01a7336-2ae8248700amr152784885ad.46.1773153752661;
        Tue, 10 Mar 2026 07:42:32 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783cfsm157096515ad.56.2026.03.10.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:42:32 -0700 (PDT)
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
Subject: [PATCH net-next v6 10/10] bng_en: add support for ethtool -S stats display
Date: Tue, 10 Mar 2026 20:10:44 +0530
Message-ID: <20260310144044.21672-11-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: BE5822543B2
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-266192-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
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
index 2ae13f18e2d7..1a15c3ff0149 100644
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


