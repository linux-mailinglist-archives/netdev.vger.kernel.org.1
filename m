Return-Path: <netdev+bounces-266191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKtnIDwvsGlHgwIAu9opvQ
	(envelope-from <netdev+bounces-266191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:48:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095E25269B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F7C3302CE9E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16C2FDC3C;
	Tue, 10 Mar 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UHuff2go"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3282FD68B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153752; cv=none; b=oQPwe9twLKGcWGs1seNxuDAhCzV7ythsntgviMaEYL6ilA4yNcuhvLlxaAVF3boApBTxqQY9hVRTwwntyVg7VtQu9f9GU2xv/KU6jXrKXeaEIoN8kTzCcW0H5LMn96tFGGyAj44g3UDMn/emGgD3Aipy+mRfmy08vG1MIkYJT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153752; c=relaxed/simple;
	bh=1hQ7wBRfyBdlvAHHMP81Lep77Jp9gTqZ4XwucfvdPCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pgcx/S8OU4vPBos3T+xuZDTu7uZgab63mYl82ErTbNZVXB4ah1nP0JbnMLQUFWhsuxfQMJwxwAQB2XNfOOfS0jt04ZKUmEYe3L5nJTwErViE+Zm2wi3qcpO167dLiwFXiidYBh2gUbA1ByIK8RDxtU+CknItEs1fY1uG9KWUwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UHuff2go; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2adbfab4501so58188495ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153750; x=1773758550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgrgpAa7weTPNe9rPKP4yGtVm6kQnpFxYyGVYn0Ky0k=;
        b=m9mea6ulY4QSVRD1ctEQsXhtN8VXgYqrrnhNVRG++kbgssXb9ARBsNdWgUmVWXgKiQ
         v3hzIlaXCXdlCJ69Naoxhpjpn7128GiwQv9tvWuxrQ18JjmouOgZ/9pHWxngt64iy4BK
         XYnOw7w8OO38PvZLC5spw+Ecb8yZN2tZyDiNdhRqtRjqOKBV+YtmN3NgqYNzJOkfurK+
         TAx7Nh+BgPKMvbOown1I/kj/Pgx0ZKWE7ZYcOQfz7PcT8WzkWrtJId7hDbb4eo9fArXC
         5trlwcWCusHkvHXXFCHlD9JrfnIt8YTrEoDnVDQQJS2KfPo3aWzbSRiRwApOJS+QPHQl
         JJvg==
X-Gm-Message-State: AOJu0YwBCxaBcbfNdyGFBmyjjesHVSfBMLRnTqNayxvEn2R7DZP+U2I3
	vEX7KuyWWQz44WxVanFGFSgq7lFTddzbEsDA+sDeGxt4IsJ4AvhxFOSIcCbrsUoOJY6vKsJcPF3
	KRehBEdv0KQeyjgGZXYMq77QiYoeLcOeDm6DbWEgvKV5p73PGIbnTOeQYTEIVer/4GzO3K/N+MK
	ZECf/EBcEg/pISfWE+CeWJ3UmO/VY4qwhQZF/y/Pen8L2zZaAfiHg+oEx+/2/iz3eF8vT9+nWaG
	VLt3BGUdPsQiNhROQ==
X-Gm-Gg: ATEYQzwd7A8nS0lK2pkISjj73tfo+6HFtv5j9QCJv84Y47v4RiiMgQB0ZXC2DYhKjlq
	xSk72FdjIUWl4bahvYGL/yAK2H6zaBVjlbrIwbRgXMbjj+0pM8ZNZuhUDl9rLOPgioBgvCbyNhp
	x9K97QSb9TB8mZpmfBBZkjhlyV8yXZ+14n0b1szU36LzrqWbppEtwz8zT/XDk4ZKc4UJq8UUbEp
	d+3Gw093VZEBYuzwj7s4y5SJeZjD9YI1xjZtVCtYUhmiStPMugzqTBvlzol08NaUDXLZwSMk607
	ulY96GFA7PnkWVDYKdpNc8IM57VwYi+1dfOcrdOWvsH+KlUTREGLC53Yo0Ptcdb9ZE/Jq+AMV8L
	vNWnBbjSeC5vtc/iPi7CrzbAhwMZSO+BgUfeev8EoVLImaW74955E0/bdiNldbImKpW06Vff8/f
	zJDAmbby2GagWQx0qcoXuh+Cau5tmmtiTZIx9dndP/9ktyQYiJ+9AvUiXlv0e6DgI=
X-Received: by 2002:a17:903:185:b0:2ae:7fa2:6bf4 with SMTP id d9443c01a7336-2ae8239b97emr143014695ad.19.1773153750442;
        Tue, 10 Mar 2026 07:42:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae83e9c46bsm19054725ad.24.2026.03.10.07.42.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:42:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae4af66f40so101895615ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773153749; x=1773758549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgrgpAa7weTPNe9rPKP4yGtVm6kQnpFxYyGVYn0Ky0k=;
        b=UHuff2gosKv1ILP2e1Kd4xSe1tDBP/DBHfXVZY/tQ/iiznhl6ZoPoBhHgTL/mJp6H0
         TGO0xz36PoE2s2tyAip2xpKvArE9WtQlSpZTMDONvAQkZQGyAzFCy3VphfYu+XnuyV8s
         BqJmgPEd1G4RCc2ndxcfgEs6hrl0n82+X7Kck=
X-Received: by 2002:a17:902:c943:b0:2ae:7f28:124b with SMTP id d9443c01a7336-2ae8239e4bcmr157518895ad.22.1773153748667;
        Tue, 10 Mar 2026 07:42:28 -0700 (PDT)
X-Received: by 2002:a17:902:c943:b0:2ae:7f28:124b with SMTP id d9443c01a7336-2ae8239e4bcmr157518705ad.22.1773153748196;
        Tue, 10 Mar 2026 07:42:28 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783cfsm157096515ad.56.2026.03.10.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:42:27 -0700 (PDT)
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
Subject: [PATCH net-next v6 09/10] bng_en: implement netdev_stat_ops
Date: Tue, 10 Mar 2026 20:10:43 +0530
Message-ID: <20260310144044.21672-10-bhargava.marreddy@broadcom.com>
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
X-Rspamd-Queue-Id: 2095E25269B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266191-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
index 03872bde4cd0..4925d31fc152 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3071,6 +3071,76 @@ void bnge_get_ring_err_stats(struct bnge_net *bn,
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
@@ -3234,6 +3304,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bd->netdev = netdev;
 
 	netdev->netdev_ops = &bnge_netdev_ops;
+	netdev->stat_ops = &bnge_stat_ops;
 
 	bnge_set_ethtool_ops(netdev);
 
-- 
2.47.3


