Return-Path: <netdev+bounces-271281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN1tKUbxwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:17:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826E31C365
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5082530950B1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15495311C15;
	Tue, 24 Mar 2026 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fya3uFWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020331F9AC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382946; cv=none; b=DWDi1yKgN9rkmgoGw4Yu8urqSYlnT749hSc4xL1GRwr36NrlVQ/NuLdyTq8emcPSkFyqK44ybgi680S844W/dGAZA3ErKlmG6wESk0++ydHVRz+LfJjtcBuV4ciTADH60nv72Q61ELijfLdL/z/hEroLGy2vZFqY00lTeq65r0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382946; c=relaxed/simple;
	bh=sAbjxlT8qw0sGpgqfVE0LsFirVoFkcAmYurDavAIbMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH+6wP71z8NMr6C50yghCdkaz2/esIlUhqDmqX25at41UXyXnimlk8friua5/0bRV17EMIkyfSD0SBFqWvIy7AQIpwoj4E0pyxilIf/nbz6pD/KD0FwXv24vLUWMqJ9z+Qy5DcIT8F4ybcp7l8iZkPwNf7I8pMvoIkNLKRkkT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fya3uFWY; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so5714008a91.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382937; x=1774987737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WA2sjF6rw0bDaGzqjV8DfWH5m3/PdSYizc64vpfSjY=;
        b=F4sMrX+qUM84jzWsEKUfFfqRWCs5ZLWxpwfh6oQ81KfZQ/iuGLc0t8+paapIkAVAJo
         mB8Ii7VfNygdfgA7BQnq8Hl3MLNAeqIAhGg0vSI8DY7WQMg7TtEX3qTqzJi3bCEndevy
         uOOM6jLoYJlbpxvZvEMwoxXVTFOnjSswMoP4xNNAh5u2kWgbk1d0Rq+1xN4DGVKi2EPu
         g34roOo6JqfhvyHOgt91Z2zGk0ZqwQCwXRrb35doL81PUPpRzTPbXqmKHucc+d9h+gVC
         qpoNEkaN8xwVwZS0iXEYwjlfHqrp3stJyyOOZcbWh7WgC2DBhP+p+3iTLzCrdD1w6K41
         aIkA==
X-Gm-Message-State: AOJu0Ywv1y9B0AOozYCd+llpBlxlTHQ4rA4vujl7/xkka988DTYJHS/w
	AMt4dwQI+b5ZWKUGk13b1/Q/UxfqWkK+33rnSfZ0Yjwpv+ynIr02Fl2iXwVOBfFxDc65lQPJVOy
	3N05oplEd86K+VV8M9dDNr1rtUL5Y6VIbzRe86ES8D0zXy9VNpAy0TQft9NtpgE8eQOMaFyAwBj
	QcaKTqMTk5lMROmbaY57oNeM4E1ZuNc4SzbXOjqtUCRVJCZxep5bZDTiJuHghl1U2c1ADCIsWzJ
	x8hQ9zcEUOY393Cgg==
X-Gm-Gg: ATEYQzyYVrHJWpbr1px/0CUWGBZJsZ+LZC6UtUhXEFl76VL6Czyl79z2Ib0z9IGoxD7
	tJe5USj66HSuCGr2bFnQm7+DsLqrInzhz8ZC80LvxGCWOtsm+GCaCCxr3NpcJPgZq8em4qgudjn
	htGCb3FYAOJQkeK1+Gob+9LKD/KRaIVo8vcfMVBeL6zuZ0rkEkfeTW5NLZ2EvnMHfLW6scUhMbG
	FM4VYVhB+kASxOTHZYMuVHU91lBoA+LDWD5T2hkr7E8TbZy2g3oQGzBB7gh0Mrqcs9nBGmFpah8
	v5C/UK8o1GSWxZuFwYBZpFrqaYtrmG/CIEfjQlLBtHtZvUxDfQ1r5gzwpMYhMQ+7vHulLtZym/8
	YO7vR8BH73tEtx5DjjPie3O0hnm0VIErYTzwXcc5qabsm5CX0Nz8agVyE/q/EMReSyW8cBTTrK2
	A+WOlQtXAEiTMPpwwu8VEEWvbZEfSheEStv5GmEP4/gsBgFVNjPtHt+2uZlHOK6jY3bQ==
X-Received: by 2002:a17:90b:4e8f:b0:35b:99f8:964e with SMTP id 98e67ed59e1d1-35c0dca8df2mr604170a91.13.1774382937541;
        Tue, 24 Mar 2026 13:08:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35c0db0bff2sm31213a91.0.2026.03.24.13.08.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:08:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7422397574so18853796a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774382936; x=1774987736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WA2sjF6rw0bDaGzqjV8DfWH5m3/PdSYizc64vpfSjY=;
        b=Fya3uFWYpSYWkRzK3PqnLLQ+LcEDZHnmFBj5Xfgnmrq8S1PiJZeg5uvG2aNBVtGTdA
         g2tA4Q4IwB31HG8HB9YAIMfa8rB5vK0uED1TtVmpwwJxksdFceIk6WIDxZkxryWbJoVc
         LRmzcjWL9WOBoA6eyO4ZjrW84VjeDb2ePK+Mk=
X-Received: by 2002:a05:6a20:3945:b0:398:8db5:40fe with SMTP id adf61e73a8af0-39c4aa06d99mr1072342637.7.1774382935502;
        Tue, 24 Mar 2026 13:08:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:3945:b0:398:8db5:40fe with SMTP id adf61e73a8af0-39c4aa06d99mr1072304637.7.1774382934620;
        Tue, 24 Mar 2026 13:08:54 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a80163bsm9930057a12.1.2026.03.24.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:08:54 -0700 (PDT)
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
Subject: [PATCH net-next v9 09/10] bng_en: implement netdev_stat_ops
Date: Wed, 25 Mar 2026 01:37:39 +0530
Message-ID: <20260324200740.346029-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
References: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271281-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 4826E31C365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement netdev_stat_ops to provide standardized per-queue
statistics via the Netlink API.

Below is the description of the hardware drop counters:

rx-hw-drop-overruns: Packets dropped by HW due to resource limitations
(e.g., no BDs available in the host ring).
rx-hw-drops: Total packets dropped by HW (sum of overruns and error
drops).
tx-hw-drop-errors: Packets dropped by HW because they were invalid or
malformed.
tx-hw-drops: Total packets dropped by HW (sum of resource limitations
and error drops).

The implementation was verified using the ynl tool:

./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/netdev.yaml --dump qstats-get --json \
'{"ifindex":14, "scope":"queue"}'

[{'ifindex': 14, 'queue-id': 0, 'queue-type': 'rx', 'rx-bytes': 758,
'rx-hw-drop-overruns': 0, 'rx-hw-drops': 0, 'rx-packets': 11},
 {'ifindex': 14, 'queue-id': 1, 'queue-type': 'rx', 'rx-bytes': 0,
'rx-hw-drop-overruns': 0, 'rx-hw-drops': 0, 'rx-packets': 0},
{'ifindex': 14, 'queue-id': 0, 'queue-type': 'tx', 'tx-bytes': 0,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 0},
 {'ifindex': 14, 'queue-id': 1, 'queue-type': 'tx', 'tx-bytes': 0,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 0},
 {'ifindex': 14, 'queue-id': 2, 'queue-type': 'tx', 'tx-bytes': 810,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 10},]

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 3c624f528545..797c02224c03 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3040,6 +3040,81 @@ static int bnge_close(struct net_device *dev)
 	return 0;
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
+	stats->hw_drop_overruns = BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+	stats->hw_drops = BNGE_GET_RING_STATS64(sw, rx_error_pkts) +
+				stats->hw_drop_overruns;
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
+
+	stats->hw_drop_errors = BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+	stats->hw_drops = BNGE_GET_RING_STATS64(sw, tx_discard_pkts) +
+				stats->hw_drop_errors;
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
@@ -3203,6 +3278,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bd->netdev = netdev;
 
 	netdev->netdev_ops = &bnge_netdev_ops;
+	netdev->stat_ops = &bnge_stat_ops;
 
 	bnge_set_ethtool_ops(netdev);
 
-- 
2.47.3


