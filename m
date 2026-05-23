Return-Path: <netdev+bounces-291115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMZ0E6m8EWo5pQYAu9opvQ
	(envelope-from <netdev+bounces-291115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49BF5BF71A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B1D73013864
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5752F531B;
	Sat, 23 May 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b="N4MY6jdK"
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035E2EF653;
	Sat, 23 May 2026 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779547297; cv=pass; b=pEiysSQ608LUHwxxuXMH407MuKntGX3/89r6LIYquWgANF+Lcl8o/4CbsMFnG+xZyaY/HthmAZ5qvFhoBUoWqL2TtSfpbI8bWoG9AKNz9/GzyCEpnxWZaO5xhqqIt+k8dfs39CQMwYNAZaP09y5qrc0N1SZSrYGKPZV8FO01w2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779547297; c=relaxed/simple;
	bh=OKfB/CNHhDR2pBvQCOqJYACI8BQaj/tZQdDTuPBaFRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5JSR1juDX61u7gV+zijyr6JYnWHfoQms4hkApIKp9i17gM7oVxPhYvO9DTtrTb4hctztGJiR7TVr/l+WW/calU4JrtwM48jik50YH7b+qU9Rhx+Z8+Aw6zSTM7iOaktaM/5paK+YHjXd/HL2lRVk2w3F7E4LTYoLiZvckhWV9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=N4MY6jdK; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1779547249; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Vevrvt6UrQSQxrCxjs0I8G9/04QvxyiDso+RpVlsJyqtee5jHgbH5G+0uK/5iKnrCrbGydTCBYpah3o4NwnaGOGz+n7iisNF4QFD5Xn5+grXEsrRMVIvZDP6CjxJKddOCxerPbPQzEuYnndeFE0AgF93v7GMzf4wORP/vVTUmoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779547249; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kq4gAaal/V6/TQrHczoyukEEROImx0VyXHhPwwFKXEg=; 
	b=DlURBEk49mjyEjr2C2oA3oTQyPN6X8WmU6XvJEIy5e8ltkYi7sdbTM4z3labNjf6ra4i1vk9z0oqehJdfTlnjfaRwdabcM5daK3S7/VG+UxLq6ZiQTHMlGjQCq0/3WAUpChSQrGSu81/eJMhYdRQf1JykCkZ5pGFop3RtpMa2R8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779547249;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kq4gAaal/V6/TQrHczoyukEEROImx0VyXHhPwwFKXEg=;
	b=N4MY6jdKQL2tHq18tG707FhjAEIO4y5cOWkU8PWjL5DxnKkZmgjt16duE57xXfrw
	65zRRvkS3g1slX69BkFGAjIcVjKfo8WPQyB1qWrJRZC4n8WempIqgJ7nm8nVDaE5hIc
	oAN/loOYGeaGlvFMkqROXEISqTrW4+3AqDEV78yU=
Received: by mx.zoho.in with SMTPS id 1779547242609712.7333978020995;
	Sat, 23 May 2026 20:10:42 +0530 (IST)
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ixgbe: implement get_queue_stats_rx
Date: Sat, 23 May 2026 20:10:16 +0530
Message-ID: <20260523144022.36484-1-kshitiz.bartariya@zohomail.in>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-291115-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kshitiz.bartariya@zohomail.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[zohomail.in:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zohomail.in:email,zohomail.in:mid,zohomail.in:dkim]
X-Rspamd-Queue-Id: B49BF5BF71A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hook into the netdev_stat_ops interface to expose per RX queue
statistics through the netdev generic netlink API.

The following counters are filled:

 - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed

 - csum_bad: maps directly to csum_err, which is incremented for both
   IP header and L4 checksum errors in ixgbe_rx_checksum().

 - hw_gro_packets and hw_gro_wire_packets: filled only when RSC
   is enabled on the ring

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2646ee6f295f..f40309f6c72b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9740,6 +9740,34 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
 }
 
+static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	struct ixgbe_ring *ring;
+
+	if (idx >= adapter->num_rx_queues)
+		return;
+
+	ring = adapter->rx_ring[idx];
+	if (!ring)
+		return;
+
+	stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
+			    ring->rx_stats.alloc_rx_buff_failed;
+	stats->csum_bad = ring->rx_stats.csum_err;
+
+	if (ring_is_rsc_enabled(ring)) {
+		stats->hw_gro_packets = ring->rx_stats.rsc_flush;
+		stats->hw_gro_wire_packets = ring->rx_stats.rsc_flush +
+					     ring->rx_stats.rsc_count;
+	}
+}
+
+static const struct netdev_stat_ops ixgbe_stat_ops = {
+	.get_queue_stats_rx	= ixgbe_get_queue_stats_rx,
+};
+
 static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
 				  struct ifla_vf_stats *vf_stats)
 {
@@ -11643,6 +11671,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
 	netdev->netdev_ops = &ixgbe_netdev_ops;
+	netdev->stat_ops   = &ixgbe_stat_ops;
 	ixgbe_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-- 
2.50.1 (Apple Git-155)


