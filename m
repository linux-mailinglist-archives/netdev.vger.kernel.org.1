Return-Path: <netdev+bounces-141704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C849BC0FE
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F23B1F22B99
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5D1FDFAA;
	Mon,  4 Nov 2024 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqRzCaEs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182231F755C
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759806; cv=none; b=MiA93/MAmJcBi4clH73gycg2a4/3F+tUpa46vzZrJDyb6FmSbDpDSHVLWbxjyUeyRUnBFykxOPjr3zmyhu35H7obRY/08fwkyZ0J2l2A6z/XIc1fqKcbBJeO1Yx8nboiQnw6fv/iDqSz1+luCC/2T8QrTyUYdFE1wxv5w0FLO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759806; c=relaxed/simple;
	bh=fK5GtXswCCfWw3ynsynFvA5cf0rRYbuXSvMeNJZ+8UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG9tGdHaOPcJGdtEtHTi2AqxWttb4m4amQxr3iIHAFrs+zcoy7gPoV5vJVKX0mQ7afqkU9eoE+2p9o2V9/LvkRgDxBx/Q+jgp2j/HS5MJa+IoatmKVgbiHurYg0wwo6kyhOQWgMGm24Fv34ctn5Q/JRXzEwtJ7PAvV3qDGo/Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqRzCaEs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730759805; x=1762295805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fK5GtXswCCfWw3ynsynFvA5cf0rRYbuXSvMeNJZ+8UI=;
  b=ZqRzCaEsRKMf4tNPJF/wUADIbVbzHNw7oIV6SiY3m/TkKN/OUPn3gLCq
   FLIlFuR8u2Cl9JlaUhinizJJU+HPZ9aY9UVdaGmpKy75kN5T2D1KBpH5O
   pxFKOPukk3qpeA8YsG6nnElZdhAe4/4TbVLbjIXPUeiljgN8XTRtSPvPK
   RR7o92AO3lQ0/0s5+f4CmnUlwPGNs9/4R7DA4aoG4kN112ZgOFE3o8vAx
   JlTsX+9vv15pzwC/4P/qIwfQkyC6MtGIWyyM1vLiZyoaA+Yc4UBAdcXVn
   JuS2u2bpjvrJr7H0bRwapkeYONMvADqSbhriUDA+z0rQ8Ak4tdaEOY80P
   g==;
X-CSE-ConnectionGUID: vDAQseVATyKYxmgX1BTJMw==
X-CSE-MsgGUID: IbBZyAyGSP6meANCWZ8SwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29901638"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="29901638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:36:43 -0800
X-CSE-ConnectionGUID: 58dMR06KTNWRwm04BhM5bQ==
X-CSE-MsgGUID: M/Iw3kQ4QRmJ0vyM3g01DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83316973"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2024 14:36:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 1/6] ice: Fix use after free during unload with ports in bridge
Date: Mon,  4 Nov 2024 14:36:29 -0800
Message-ID: <20241104223639.2801097-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
References: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Unloading the ice driver while switchdev port representors are added to
a bridge can lead to kernel panic. Reproducer:

  modprobe ice

  devlink dev eswitch set $PF1_PCI mode switchdev

  ip link add $BR type bridge
  ip link set $BR up

  echo 2 > /sys/class/net/$PF1/device/sriov_numvfs
  sleep 2

  ip link set $PF1 master $BR
  ip link set $VF1_PR master $BR
  ip link set $VF2_PR master $BR
  ip link set $PF1 up
  ip link set $VF1_PR up
  ip link set $VF2_PR up
  ip link set $VF1 up

  rmmod irdma ice

When unloading the driver, ice_eswitch_detach() is eventually called as
part of VF freeing. First, it removes a port representor from xarray,
then unregister_netdev() is called (via repr->ops.rem()), finally
representor is deallocated. The problem comes from the bridge doing its
own deinit at the same time. unregister_netdev() triggers a notifier
chain, resulting in ice_eswitch_br_port_deinit() being called. It should
set repr->br_port = NULL, but this does not happen since repr has
already been removed from xarray and is not found. Regardless, it
finishes up deallocating br_port. At this point, repr is still not freed
and an fdb event can happen, in which ice_eswitch_br_fdb_event_work()
takes repr->br_port and tries to use it, which causes a panic (use after
free).

Note that this only happens with 2 or more port representors added to
the bridge, since with only one representor port, the bridge deinit is
slightly different (ice_eswitch_br_port_deinit() is called via
ice_eswitch_br_ports_flush(), not ice_eswitch_br_port_unlink()).

Trace:
  Oops: general protection fault, probably for non-canonical address 0xf129010fd1a93284: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0x8948287e8d499420-0x8948287e8d499427]
  (...)
  Workqueue: ice_bridge_wq ice_eswitch_br_fdb_event_work [ice]
  RIP: 0010:__rht_bucket_nested+0xb4/0x180
  (...)
  Call Trace:
   (...)
   ice_eswitch_br_fdb_find+0x3fa/0x550 [ice]
   ? __pfx_ice_eswitch_br_fdb_find+0x10/0x10 [ice]
   ice_eswitch_br_fdb_event_work+0x2de/0x1e60 [ice]
   ? __schedule+0xf60/0x5210
   ? mutex_lock+0x91/0xe0
   ? __pfx_ice_eswitch_br_fdb_event_work+0x10/0x10 [ice]
   ? ice_eswitch_br_update_work+0x1f4/0x310 [ice]
   (...)

A workaround is available: brctl setageing $BR 0, which stops the bridge
from adding fdb entries altogether.

Change the order of operations in ice_eswitch_detach(): move the call to
unregister_netdev() before removing repr from xarray. This way
repr->br_port will be correctly set to NULL in
ice_eswitch_br_port_deinit(), preventing a panic.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c0b3e70a7ea3..fb527434b58b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -552,13 +552,14 @@ int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
 static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
 {
 	ice_eswitch_stop_reprs(pf);
+	repr->ops.rem(repr);
+
 	xa_erase(&pf->eswitch.reprs, repr->id);
 
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
 
 	ice_eswitch_release_repr(pf, repr);
-	repr->ops.rem(repr);
 	ice_repr_destroy(repr);
 
 	if (xa_empty(&pf->eswitch.reprs)) {
-- 
2.42.0


