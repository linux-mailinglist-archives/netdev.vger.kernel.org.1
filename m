Return-Path: <netdev+bounces-273676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 25xiBvTjy2mHMQYAu9opvQ
	(envelope-from <netdev+bounces-273676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C4D36B7A1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E923D31670AD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F24402455;
	Tue, 31 Mar 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2rk2BQC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4249401A30;
	Tue, 31 Mar 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969372; cv=none; b=U0QYaQmbuMXWjoRCmrOFa8eJSPeCOmqTDJ234xbT57BNN9GmRDmTUOR+d2YPikWbShxznZGgOrgeW2fB9YuG8aZcUOcE2MvJ047weiHGa+JP4bfA1KgRB3RYQ+BKhiGELHEQp9DyXejncUTUZej2xHaCxBv5q/q9U7iEhhsCLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969372; c=relaxed/simple;
	bh=qV+KGO787iVQA6q+LeGiudsVWzWKdh1iKu/pKa7i5zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jgb75qfizOpZ0l+ggep7rCP4kgW8iDCcUJyW8ICCsrtduchSUJamTCgnBn5tm4dZAY+C6SbSeyrJGGq6jBk3ZdnCU+xfI5pO9tW3hOyIyXsIquC+u8vhYsIlWijulEcSfcV0tUU0rMaWaYjJdDN+tAUIcVq/y6uk9NJqZxBYzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2rk2BQC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969371; x=1806505371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qV+KGO787iVQA6q+LeGiudsVWzWKdh1iKu/pKa7i5zE=;
  b=C2rk2BQCEN9gTBR1g09Sz8w578Hu0DKiY4dldIfDV05aJHN1cOX9qzic
   Uip+I3ydnowM7e8OSOi0DH/14VeIdQTq7VKRuDng9F9VeZ15FZ9vJQG/S
   krGhMDBLkQmmnrUfsiAP4LEo/aiKxTAjKd/IXU2u8gcXQtsu8/4DX3uMC
   R2EJ1V3Fi46flDA3bpZIsOGb+Wcnc02ujL/Q+NQVjLcXosJJZ6uKye3bl
   ICGtpvyiJYv7quuE5ehDeGJVyYt8gx4MNcuii/A74Fz/SCikUzV8LDrkg
   OAm99W2LSOKRB5u7rmov4j6tqZzrH5nhfz64lynpYSL9hJXI3zrASacZw
   A==;
X-CSE-ConnectionGUID: AuM7gH6uR9C/FdfPy8qX1w==
X-CSE-MsgGUID: Xrnep1aaT/mm4NTUW3CXJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046218"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046218"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:48 -0700
X-CSE-ConnectionGUID: LpLd4fErQja/d/K6zFlFoA==
X-CSE-MsgGUID: IuAasp0QRNS7xAuZcnUpew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735653"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:45 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 net 10/11] igc: remove home-grown xsk's frame size validation
Date: Tue, 31 Mar 2026 17:02:12 +0200
Message-Id: <20260331150213.550797-11-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273676-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 81C4D36B7A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since this check is now present in core in xp_assign_dev(), remove
redundant statement from igc_xdp_enable_pool().

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_xdp.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 9eb47b4beb06..4126173a0226 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -61,23 +61,12 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 	struct igc_ring *rx_ring, *tx_ring;
 	struct napi_struct *napi;
 	bool needs_reset;
-	u32 frame_size;
 	int err;
 
 	if (queue_id >= adapter->num_rx_queues ||
 	    queue_id >= adapter->num_tx_queues)
 		return -EINVAL;
 
-	frame_size = xsk_pool_get_rx_frame_size(pool);
-	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
-		/* When XDP is enabled, the driver doesn't support frames that
-		 * span over multiple buffers. To avoid that, we check if xsk
-		 * frame size is big enough to fit the max ethernet frame size
-		 * + vlan double tagging.
-		 */
-		return -EOPNOTSUPP;
-	}
-
 	err = xsk_pool_dma_map(pool, dev, IGC_RX_DMA_ATTR);
 	if (err) {
 		netdev_err(ndev, "Failed to map xsk pool\n");
-- 
2.43.0


