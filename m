Return-Path: <netdev+bounces-160860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A22FA1BDE8
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51BF162DE6
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1AF1EEA22;
	Fri, 24 Jan 2025 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXuJXbq1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CE1E98FD
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754345; cv=none; b=FyAjZprKwM2CsE64ectnjp5GerK8NRO+IcVg7r3wBS/Y9oe8N2jPec1ijkIUraY4k3E2U485SefOAwgrdyZuMsvpVDC/WGCln1Zt7w88lijuKxivKxXHRo2hmpgo0Rv4stKWsSwN9hDtTAJK73QzybbPfWFSvP1qBVre/0NOp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754345; c=relaxed/simple;
	bh=H8nOM7SSy24Jz13dsHfv/Pc3sazm6NLngjfMS12J8n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGcHGt2JwA0nQ2P1hMvdypWBpXrYNDqtK5ml1pp8TSdzJHK7FfU0Y3dtPFyV+15JMvBKeOSLg1maO8vZZZ3HuocY66/CRsPYhydpu3fS8IdfFde2A6p+dxQ8mn9fUDiQKlNLT/VKkcb2QGGF692qDozIRjgoqI/psqbVGmH7/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXuJXbq1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754344; x=1769290344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8nOM7SSy24Jz13dsHfv/Pc3sazm6NLngjfMS12J8n4=;
  b=EXuJXbq1XSNI0SEkYehfgnop+mtpbfKTRInQEntJATZ2vM5bxVfIFWLL
   t+XjXrVsI4ZRvcp7R9sJcHRCglhUDV5sVsmcPHubCgsSeeTprPiPpdWhE
   kNZNW4i3uyeLZMxPVDwfAWG9j5ETsT9W5c0r8bwHzK+cSLer3cctJcPJT
   HCehVldAwxiS1tJveSO6+7g+H/08atT4DoKaW7wBqcXC3fHwmbG5LWTKD
   bczPXk82nhK+jQLiFuIYKkjZo6cjvrMfEg1ydwHPmn/k+KJMvdgPRHC6c
   ZGB9SuNhA91Z9hMP5G9horzUaEcSq2RgrPJalzVItudeobU9VUwTEPRZL
   g==;
X-CSE-ConnectionGUID: app9tB01TrOwjN2mI4svzg==
X-CSE-MsgGUID: fPnc8g2nTrWWvVnP+gpbSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140429"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140429"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:18 -0800
X-CSE-ConnectionGUID: FcZtJZDLQVSbBLLJmm7FGw==
X-CSE-MsgGUID: Myn2BTtRQCmCOpLNVhjK8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861099"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 8/8] iavf: allow changing VLAN state without calling PF
Date: Fri, 24 Jan 2025 13:32:10 -0800
Message-ID: <20250124213213.1328775-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

First case:
> ip l a l $VF name vlanx type vlan id 100
> ip l d vlanx
> ip l a l $VF name vlanx type vlan id 100

As workqueue can be execute after sometime, there is a window to have
call trace like that:
- iavf_del_vlan
- iavf_add_vlan
- iavf_del_vlans (wq)

It means that our VLAN 100 will change the state from IAVF_VLAN_ACTIVE
to IAVF_VLAN_REMOVE (iavf_del_vlan). After that in iavf_add_vlan state
won't be changed because VLAN 100 is on the filter list. The final
result is that the VLAN 100 filter isn't added in hardware (no
iavf_add_vlans call).

To fix that change the state if the filter wasn't removed yet directly
to active. It is save as IAVF_VLAN_REMOVE means that virtchnl message
wasn't sent yet.

Second case:
> ip l a l $VF name vlanx type vlan id 100
Any type of VF reset ex. change trust
> ip l s $PF vf $VF_NUM trust on
> ip l d vlanx
> ip l a l $VF name vlanx type vlan id 100

In case of reset iavf driver is responsible for readding all filters
that are being used. To do that all VLAN filters state are changed to
IAVF_VLAN_ADD. Here is even longer window for changing VLAN state from
kernel side, as workqueue isn't called immediately. We can have call
trace like that:

- changing to IAVF_VLAN_ADD (after reset)
- iavf_del_vlan (called from kernel ops)
- iavf_del_vlans (wq)

Not exsisitng VLAN filters will be removed from hardware. It isn't a
bug, ice driver will handle it fine. However, we can have call trace
like that:

- changing to IAVF_VLAN_ADD (after reset)
- iavf_del_vlan (called from kernel ops)
- iavf_add_vlan (called from kernel ops)
- iavf_del_vlans (wq)

With fix for previous case we end up with no VLAN filters in hardware.
We have to remove VLAN filters if the state is IAVF_VLAN_ADD and delete
VLAN was called. It is save as IAVF_VLAN_ADD means that virtchnl message
wasn't sent yet.

Fixes: 0c0da0e95105 ("iavf: refactor VLAN filter states")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index cbfaaa5b7d02..2d7a18fcc3be 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -773,6 +773,11 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		f->state = IAVF_VLAN_ADD;
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
+	} else if (f->state == IAVF_VLAN_REMOVE) {
+		/* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
+		 * We can safely only change the state here.
+		 */
+		f->state = IAVF_VLAN_ACTIVE;
 	}
 
 clearout:
@@ -793,8 +798,18 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 
 	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
-		f->state = IAVF_VLAN_REMOVE;
-		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
+		/* IAVF_ADD_VLAN means that VLAN wasn't even added yet.
+		 * Remove it from the list.
+		 */
+		if (f->state == IAVF_VLAN_ADD) {
+			list_del(&f->list);
+			kfree(f);
+			adapter->num_vlan_filters--;
+		} else {
+			f->state = IAVF_VLAN_REMOVE;
+			iavf_schedule_aq_request(adapter,
+						 IAVF_FLAG_AQ_DEL_VLAN_FILTER);
+		}
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-- 
2.47.1


