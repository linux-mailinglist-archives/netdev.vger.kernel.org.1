Return-Path: <netdev+bounces-247511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B5CFB6C7
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79F3D3005F28
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71B19CCF7;
	Wed,  7 Jan 2026 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLIzmWYh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94117A31C
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744423; cv=none; b=gKWefMyH5gu3SPENzy6w3zqT4jvBCwrUpOOhXftvJGTZmsyzIJY09dvGkjuKGc3WaWLrl4OKT65Gkvioebk3zTy3Noyl/ZFzeKUbhRJAejC3fNQVRrHwDDldKKVvA6c9TKwK9Gh4VELvp9csLCGSvPqYBQxl2uh+7isKNWpeQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744423; c=relaxed/simple;
	bh=/RivF8jJo9an+unAjuLeJtZktqUpKOr1D3Rof4+nCtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFICBRU+JITiOqmTpZ+1w5nIJTxf0FBZrRkUQQpSpB50xYhbvaZUK7DEa/C2aIcHe7pSit+VffBO7BkYFhPyf7Lc8SIS+IGYpjFnSWnZ8PD+uB/tWs6zTcyW+NC8PXodPotIuLtKkGDM7AdmkMRXy+ANJDinB1pWo1v74G9odjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLIzmWYh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744422; x=1799280422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/RivF8jJo9an+unAjuLeJtZktqUpKOr1D3Rof4+nCtY=;
  b=mLIzmWYhXRciiLxLDQe29zYPLawDpa3YhPD80ArY1F09J9x1iFfFzCSJ
   DJIXTKXK/8AkXv06E2dXyOGZ23Rp0xUPpaETMS07FazP+7xRwt5LKfMB9
   2cLY+APoPw3QXcxao5WYXkDmT++N5Y8gXxcB2LsubjRsh7UpryHIPUprK
   l8z+1iX56mByR+APb1F9KbqZ+nDUdKtGbqC7iLNnCwaFJmxZM6COKzcBh
   J8rwDwjuC/b0CxLnF34+jzXQI+PbeOUdNS36eBbnpwXNxpt0f5LnVSC67
   ganhysi0iplkRSk4CeTr9kIhxPKON8Q4ieHCYoKltJd3g3gJnEkAfIVX4
   g==;
X-CSE-ConnectionGUID: 3UzFus4HSYGX87ClyOAWTw==
X-CSE-MsgGUID: a5c6nlXAT8SzLPJ4T2s/4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161672"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:55 -0800
X-CSE-ConnectionGUID: dBKtP05xRpeUykAb38F1Yw==
X-CSE-MsgGUID: sYsvCRXYTnqnST59K5znkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841205"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 10/13] idpf: Fix RSS LUT NULL ptr issue after soft reset
Date: Tue,  6 Jan 2026 16:06:42 -0800
Message-ID: <20260107000648.1861994-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

During soft reset, the RSS LUT is freed and not restored unless the
interface is up. If an ethtool command that accesses the rss lut is
attempted immediately after reset, it will result in NULL ptr
dereference. Also, there is no need to reset the rss lut if the soft reset
does not involve queue count change.

After soft reset, set the RSS LUT to default values based on the updated
queue count only if the reset was a result of a queue count change and
the LUT was not configured by the user. In all other cases, don't touch
the LUT.

Steps to reproduce:

** Bring the interface down (if up)
ifconfig eth1 down

** update the queue count (eg., 27->20)
ethtool -L eth1 combined 20

** display the RSS LUT
ethtool -x eth1

[82375.558338] BUG: kernel NULL pointer dereference, address: 0000000000000000
[82375.558373] #PF: supervisor read access in kernel mode
[82375.558391] #PF: error_code(0x0000) - not-present page
[82375.558408] PGD 0 P4D 0
[82375.558421] Oops: Oops: 0000 [#1] SMP NOPTI
<snip>
[82375.558516] RIP: 0010:idpf_get_rxfh+0x108/0x150 [idpf]
[82375.558786] Call Trace:
[82375.558793]  <TASK>
[82375.558804]  rss_prepare.isra.0+0x187/0x2a0
[82375.558827]  rss_prepare_data+0x3a/0x50
[82375.558845]  ethnl_default_doit+0x13d/0x3e0
[82375.558863]  genl_family_rcv_msg_doit+0x11f/0x180
[82375.558886]  genl_rcv_msg+0x1ad/0x2b0
[82375.558902]  ? __pfx_ethnl_default_doit+0x10/0x10
[82375.558920]  ? __pfx_genl_rcv_msg+0x10/0x10
[82375.558937]  netlink_rcv_skb+0x58/0x100
[82375.558957]  genl_rcv+0x2c/0x50
[82375.558971]  netlink_unicast+0x289/0x3e0
[82375.558988]  netlink_sendmsg+0x215/0x440
[82375.559005]  __sys_sendto+0x234/0x240
[82375.559555]  __x64_sys_sendto+0x28/0x30
[82375.560068]  x64_sys_call+0x1909/0x1da0
[82375.560576]  do_syscall_64+0x7a/0xfa0
[82375.561076]  ? clear_bhb_loop+0x60/0xb0
[82375.561567]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
<snip>

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 20 ++++----------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  1 +
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 51716e5a84ef..003bab3ce5ae 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1484,8 +1484,6 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_vport_config *vport_config;
-	struct idpf_rss_data *rss_data;
 	int err;
 
 	if (test_bit(IDPF_VPORT_UP, np->state))
@@ -1579,19 +1577,6 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 
 	idpf_restore_features(vport);
 
-	vport_config = adapter->vport_config[vport->idx];
-	rss_data = &vport_config->user_config.rss_data;
-
-	if (!rss_data->rss_lut) {
-		err = idpf_init_rss_lut(vport);
-		if (err) {
-			dev_err(&adapter->pdev->dev,
-				"Failed to initialize RSS LUT for vport %u: %d\n",
-				vport->vport_id, err);
-			goto disable_vport;
-		}
-	}
-
 	err = idpf_config_rss(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure RSS for vport %u: %d\n",
@@ -2068,7 +2053,6 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_stop(vport, false);
 	}
 
-	idpf_deinit_rss_lut(vport);
 	/* We're passing in vport here because we need its wait_queue
 	 * to send a message and it should be getting all the vport
 	 * config data out of the adapter but we need to be careful not
@@ -2094,6 +2078,10 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (err)
 		goto err_open;
 
+	if (reset_cause == IDPF_SR_Q_CHANGE &&
+	    !netif_is_rxfh_configured(vport->netdev))
+		idpf_fill_dflt_rss_lut(vport);
+
 	if (vport_is_up)
 		err = idpf_vport_open(vport, false);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 8991a891a440..f51d52297e1e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4641,7 +4641,7 @@ int idpf_config_rss(struct idpf_vport *vport)
  * idpf_fill_dflt_rss_lut - Fill the indirection table with the default values
  * @vport: virtual port structure
  */
-static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	u16 num_active_rxq = vport->num_rxq;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 7d20593bd877..0472698ca192 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1085,6 +1085,7 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
 void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
 void idpf_vport_intr_ena(struct idpf_vport *vport);
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport);
 int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss_lut(struct idpf_vport *vport);
 void idpf_deinit_rss_lut(struct idpf_vport *vport);
-- 
2.47.1


