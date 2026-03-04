Return-Path: <netdev+bounces-263936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBgDOFNgqGnPuAAAu9opvQ
	(envelope-from <netdev+bounces-263936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:39:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5302047A1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F217E300B457
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A7377EBD;
	Wed,  4 Mar 2026 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1fvYWFH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D647374745;
	Wed,  4 Mar 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642184; cv=none; b=rX9MoWhVD4cpgGrf0E973SYRNzBocEczVHXN0hxLJWuvKnNSMHEi5JpXVetuoPcTwrUr3YRPf3Ue0AqilBIIhuV9kARMl/rHMb7MlBOPgmPVID9w0eyvflE1Jlaxa8uoF182V/GoyE0nlkekV3nr2V7sTaSQdkj3lM+nh+mP2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642184; c=relaxed/simple;
	bh=xSoRegfDOP/5IirhtXxj8ro8oytZUXfZQIPbEnLhFj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKLX5/v2yVkpSvyRNb3gnXtagZyMWNJ0rq2Z7HUTSGIwARmHuAdc+Z5DPcXh64ci1u3AW923gQ6nt1hGkzA9Apdhf06z90ajIXEehlH7KKpLb3SK4ibu61RoxcbqSkm43gN4qbFh1ktT3RKcVkAXqj5SFQw3ZidHjEUZ2VjGk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1fvYWFH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772642176; x=1804178176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSoRegfDOP/5IirhtXxj8ro8oytZUXfZQIPbEnLhFj0=;
  b=W1fvYWFHPWDTUvwr+a6TUurNqZ/eK7OHMrVTvsKdUEegMXpoVQChGinI
   1GjOKr9JJyANH+TkqeLaIy7z8KeEknOgV7czEtfVZblp22HWnCKF4We/g
   VEkABcEN9q4fTOvQNPj3c3XGMF/C1osDQszLCwJRSO+rtHvAFNtFI8PbM
   MJO/Y8rILcbXS55L2/tdTyhMl9N4aPT2SMxwqgffyb9vsX9Sy73HmV9Aa
   doxQ4cs5T7pVkB3H4nqrcQnoJJR7G5A+Pf4WiyaEsgDvw3M6tmABDP/zm
   wuVfRasade6sYtJu49yel6SvrB0c1CpihF/4Y0oDibNst+nr3f+5ke/gz
   g==;
X-CSE-ConnectionGUID: lPlGa30tR7a5mWu+tY9sEA==
X-CSE-MsgGUID: XIKd8roiTBCe43olBpK+NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72906460"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72906460"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:36:15 -0800
X-CSE-ConnectionGUID: 7wkR9efNR9uyL5ijqtiN3Q==
X-CSE-MsgGUID: 1fYrwHwiR7qWLIM1XMTJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="241405043"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2026 08:36:11 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 109DB312CB;
	Wed,  4 Mar 2026 16:36:10 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v3 10/10] ixgbevf: allow changing MTU when XDP program is attached
Date: Wed,  4 Mar 2026 17:03:42 +0100
Message-ID: <20260304160345.1340940-11-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304160345.1340940-1-larysa.zaremba@intel.com>
References: <20260304160345.1340940-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA5302047A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263936-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

xskxceiver attempts to change MTU after attaching XDP program,
ixgbevf rejects the request leading to test being failed.

Support MTU change operation even when XDP program is already attached,
perform the same frame size check as when attaching a program.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 196e51eb516a..08ea2ae45cea 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -569,8 +569,8 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 	};
 	u16 ntu = rx_ring->next_to_use;
 
-	/* nothing to do or no valid netdev defined */
-	if (unlikely(!cleaned_count || !rx_ring->netdev))
+	/* nothing to do or page pool is not present */
+	if (unlikely(!cleaned_count || !fq.pp))
 		return;
 
 	rx_desc = IXGBEVF_RX_DESC(rx_ring, ntu);
@@ -1764,6 +1764,7 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	bool rlpml_valid = false;
 	u64 rdba = ring->dma;
 	u32 rxdctl;
+	int err;
 
 	/* disable queue to avoid issues while updating state */
 	rxdctl = IXGBE_READ_REG(hw, IXGBE_VFRXDCTL(reg_idx));
@@ -1797,7 +1798,13 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 
-	ixgbevf_rx_create_pp(ring);
+	err = ixgbevf_rx_create_pp(ring);
+	if (err) {
+		netdev_err(ring->netdev,
+			   "Failed to create Page Pool for buffer allocation: (%pe), RxQ %d is disabled, driver reload may be needed\n",
+			   ERR_PTR(err), ring->queue_index);
+		return;
+	}
 
 	/* RXDCTL.RLPML does not work on 82599 */
 	if (adapter->hw.mac.type != ixgbe_mac_82599_vf) {
@@ -4082,6 +4089,18 @@ static int ixgbevf_set_mac(struct net_device *netdev, void *p)
 	return 0;
 }
 
+static bool ixgbevf_xdp_mtu_ok(const struct ixgbevf_adapter *adapter,
+			       const struct bpf_prog *prog, unsigned int mtu)
+{
+	u32 frame_size = mtu + LIBETH_RX_LL_LEN;
+	bool requires_mbuf;
+
+	requires_mbuf = frame_size > IXGBEVF_RX_PAGE_LEN(LIBETH_XDP_HEADROOM) ||
+			adapter->flags & IXGBEVF_FLAG_HSPLIT;
+
+	return prog->aux->xdp_has_frags || !requires_mbuf;
+}
+
 /**
  * ixgbevf_change_mtu - Change the Maximum Transfer Unit
  * @netdev: network interface device structure
@@ -4097,8 +4116,10 @@ static int ixgbevf_change_mtu(struct net_device *netdev, int new_mtu)
 	int ret;
 
 	/* prevent MTU being changed to a size unsupported by XDP */
-	if (adapter->xdp_prog) {
-		dev_warn(&adapter->pdev->dev, "MTU cannot be changed while XDP program is loaded\n");
+	if (adapter->xdp_prog &&
+	    !ixgbevf_xdp_mtu_ok(adapter, adapter->xdp_prog, new_mtu)) {
+		netdev_warn(netdev,
+			    "MTU value provided cannot be set while current XDP program is attached\n");
 		return -EPERM;
 	}
 
@@ -4261,14 +4282,10 @@ ixgbevf_features_check(struct sk_buff *skb, struct net_device *dev,
 static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 			     struct netlink_ext_ack *extack)
 {
-	u32 frame_size = READ_ONCE(dev->mtu) + LIBETH_RX_LL_LEN;
 	struct ixgbevf_adapter *adapter = netdev_priv(dev);
 	struct bpf_prog *old_prog;
-	bool requires_mbuf;
 
-	requires_mbuf = frame_size > IXGBEVF_RX_PAGE_LEN(LIBETH_XDP_HEADROOM) ||
-			adapter->flags & IXGBEVF_FLAG_HSPLIT;
-	if (prog && !prog->aux->xdp_has_frags && requires_mbuf) {
+	if (prog && !ixgbevf_xdp_mtu_ok(adapter, prog, READ_ONCE(dev->mtu))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Configured MTU or HW limitations require non-linear frames and XDP prog does not support frags");
 		return -EOPNOTSUPP;
-- 
2.52.0


