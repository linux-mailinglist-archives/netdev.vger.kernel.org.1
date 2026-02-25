Return-Path: <netdev+bounces-261083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKRjBMVmn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:16:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF1D19DBEE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3716B3026BD3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EDF314A67;
	Wed, 25 Feb 2026 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLMdXXGl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436731329B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054159; cv=none; b=Zf7X8WdT3kJmq9gahTtpQtUHcO3r3eu8sDRv6hG4Om5zPA9oEs6sDWxZcH0WlYoZvClLCyqnoe8JdC2wlPsDrivZdZJO8+jibd2Vjku5punYS42+1Skw+HHkwUhsTxf9WNe3EFCSwi1SINlWrWNd47nUh2+8p3Xzpd1u7bMFVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054159; c=relaxed/simple;
	bh=8jMKm/Q5p7RGXO9Q9vPnyzkHwS8ajLrgvjEuNDAEvcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfJnjnP+eeQPHt24AeTgCKj386jSdR0cNf4shMMfIeEVU6Tqkwz4XBDrNUsnvTavXDThFR/0Yir440QBTBhPY0c6U9AEVx8S4Y3SBjcyqQpxCqx5Z+lFCYblvxRMZgxP75OAdVK/zAvr4hyZanBP8WA1+a2PmAeD1mnV/+IIXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLMdXXGl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054158; x=1803590158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8jMKm/Q5p7RGXO9Q9vPnyzkHwS8ajLrgvjEuNDAEvcg=;
  b=DLMdXXGlcCzre9rahkO6Tml2ymVrnujdZJWG3PYLnzCa1uR6ZjIEyAwO
   FI0Lix36F9mm+EgJF6tg1VWEEGBzykzH7yqO+d9lCKywBH9zs+/6U3tSL
   mjhcO4q6z2/7luESO3ajZLRZj+oKjquOw4UGmvZ266zKQ6WLhxYsKf/xk
   R5bouHpxpNiEnF0I86B/rOuzBoT9GqAt6NSfamUf21/kX0iw44j+d+Arf
   RguUQMLsTxi8BIyAkmVkvKc4kPgBadCEz0TEuT+tV6UvrkKhNcaRITDU4
   Vt7rlwMOYPAsHqqX45nsJxmePvHqy6FmhrIf08PJr5zI8am7NK9ebgRdL
   Q==;
X-CSE-ConnectionGUID: jKdY34njQuuo1vWQsxNB8g==
X-CSE-MsgGUID: kV0hWzXeSNutjhpfDyE2Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013807"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013807"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:56 -0800
X-CSE-ConnectionGUID: AO7T0ZzATHq1cHfyqiHLqw==
X-CSE-MsgGUID: mvSs/k6QSL6W9soSbYaUEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349702"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net v2 08/12] ice: fix crash in ethtool offline loopback test
Date: Wed, 25 Feb 2026 13:15:39 -0800
Message-ID: <20260225211546.1949260-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261083-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EF1D19DBEE
X-Rspamd-Action: no action

From: Michal Schmidt <mschmidt@redhat.com>

Since the conversion of ice to page pool, the ethtool loopback test
crashes:

 BUG: kernel NULL pointer dereference, address: 000000000000000c
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 1100f1067 P4D 0
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 23 UID: 0 PID: 5904 Comm: ethtool Kdump: loaded Not tainted 6.19.0-0.rc7.260128g1f97d9dcf5364.49.eln154.x86_64 #1 PREEMPT(lazy)
 Hardware name: [...]
 RIP: 0010:ice_alloc_rx_bufs+0x1cd/0x310 [ice]
 Code: 83 6c 24 30 01 66 41 89 47 08 0f 84 c0 00 00 00 41 0f b7 dc 48 8b 44 24 18 48 c1 e3 04 41 bb 00 10 00 00 48 8d 2c 18 8b 04 24 <89> 45 0c 41 8b 4d 00 49 d3 e3 44 3b 5c 24 24 0f 83 ac fe ff ff 44
 RSP: 0018:ff7894738aa1f768 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000700 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ff16dcae79880200 R09: 0000000000000019
 R10: 0000000000000001 R11: 0000000000001000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ff16dcae6c670000
 FS:  00007fcf428850c0(0000) GS:ff16dcb149710000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000000c CR3: 0000000121227005 CR4: 0000000000773ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ice_vsi_cfg_rxq+0xca/0x460 [ice]
  ice_vsi_cfg_rxqs+0x54/0x70 [ice]
  ice_loopback_test+0xa9/0x520 [ice]
  ice_self_test+0x1b9/0x280 [ice]
  ethtool_self_test+0xe5/0x200
  __dev_ethtool+0x1106/0x1a90
  dev_ethtool+0xbe/0x1a0
  dev_ioctl+0x258/0x4c0
  sock_do_ioctl+0xe3/0x130
  __x64_sys_ioctl+0xb9/0x100
  do_syscall_64+0x7c/0x700
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [...]

It crashes because we have not initialized libeth for the rx ring.

Fix it by treating ICE_VSI_LB VSIs slightly more like normal PF VSIs and
letting them have a q_vector. It's just a dummy, because the loopback
test does not use interrupts, but it contains a napi struct that can be
passed to libeth_rx_fq_create() called from ice_vsi_cfg_rxq() ->
ice_rxq_pp_create().

Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++++
 drivers/net/ethernet/intel/ice/ice_lib.c     | 15 ++++++++++-----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index afbff8aa9ceb..49b4304c4975 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -124,6 +124,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	if (vsi->type == ICE_VSI_VF) {
 		ice_calc_vf_reg_idx(vsi->vf, q_vector);
 		goto out;
+	} else if (vsi->type == ICE_VSI_LB) {
+		goto skip_alloc;
 	} else if (vsi->type == ICE_VSI_CTRL && vsi->vf) {
 		struct ice_vsi *ctrl_vsi = ice_get_vf_ctrl_vsi(pf, vsi);
 
@@ -662,7 +664,8 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	u32 rx_buf_len;
 	int err;
 
-	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
+	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF ||
+	    ring->vsi->type == ICE_VSI_LB) {
 		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c6bc29cfb8e6..ff003529beba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1289,6 +1289,10 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	test_vsi->netdev = netdev;
 	tx_ring = test_vsi->tx_rings[0];
 	rx_ring = test_vsi->rx_rings[0];
+	/* Dummy q_vector and napi. Fill the minimum required for
+	 * ice_rxq_pp_create().
+	 */
+	rx_ring->q_vector->napi.dev = netdev;
 
 	if (ice_lbtest_prepare_rings(test_vsi)) {
 		ret = 2;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d921269e1fe7..3cd6296a1fbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -107,10 +107,6 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->rxq_map)
 		goto err_rxq_map;
 
-	/* There is no need to allocate q_vectors for a loopback VSI. */
-	if (vsi->type == ICE_VSI_LB)
-		return 0;
-
 	/* allocate memory for q_vector pointers */
 	vsi->q_vectors = devm_kcalloc(dev, vsi->num_q_vectors,
 				      sizeof(*vsi->q_vectors), GFP_KERNEL);
@@ -241,6 +237,8 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 	case ICE_VSI_LB:
 		vsi->alloc_txq = 1;
 		vsi->alloc_rxq = 1;
+		/* A dummy q_vector, no actual IRQ. */
+		vsi->num_q_vectors = 1;
 		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi_type);
@@ -2428,14 +2426,21 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		}
 		break;
 	case ICE_VSI_LB:
-		ret = ice_vsi_alloc_rings(vsi);
+		ret = ice_vsi_alloc_q_vectors(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
+		ret = ice_vsi_alloc_rings(vsi);
+		if (ret)
+			goto unroll_alloc_q_vector;
+
 		ret = ice_vsi_alloc_ring_stats(vsi);
 		if (ret)
 			goto unroll_vector_base;
 
+		/* Simply map the dummy q_vector to the only rx_ring */
+		vsi->rx_rings[0]->q_vector = vsi->q_vectors[0];
+
 		break;
 	default:
 		/* clean up the resources and exit */
-- 
2.47.1


