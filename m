Return-Path: <netdev+bounces-234188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4CC1DA8B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCFCA4E4A46
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF630ACEC;
	Wed, 29 Oct 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meRtK7Rh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BA2FD69F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779632; cv=none; b=DLNh+GzHAJnF/F50xsSdz1I+QbCW4y1RUsCWWa/KK/3q8UfEl31ZWAlMLDRhxTyZ0EMveYf0XvvDskhBFSlNjt4S2BSKtVgkTH8mE2VWjiCvhnikH29FdhSrWZlZdhudO/5Z4r8XUHBIKZ/YbSi91cA9TbPRuKSr9btNI2qnOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779632; c=relaxed/simple;
	bh=m7nX5HtKR2Fr7AiyCut4GhnsxEWARwUJej/IEbiJVkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoCztjmbBnX/P19K3zmvmt1yAbch8Q7YB2+hyLv/GkC4Fzu8QHlzeIIsPnxcYLfaqjKWsATNLYT1BOF6q1wDZA6Q1hqwZJNwEe8X3kjiJy64nIQrTSAdDoFXlB9lGERvUf7S4yB+ejMbbchZOhGnRUNdX5d3h69J9wWIdt4h/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meRtK7Rh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779632; x=1793315632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7nX5HtKR2Fr7AiyCut4GhnsxEWARwUJej/IEbiJVkg=;
  b=meRtK7RhIzyohB9qRuowYE38NT3UUDZS9PiEWKM1f1s0o+/9TvqMDN45
   qI1Xl0DzBIiMil/yOM8UHHkuolCGnLC8LKiD4R0IVKqb/dC/9S3oY7/tD
   UsR8w65GZuK7Rz7jgY/d2aFET2em24/WsnAi2gCdpkjL/fccVHvxTHmNR
   ipQ8LEWZBTYllWKWcH8JLlCs7mZShPFIif+CFMuGUVn84/oMVmcr4aF6j
   suEYiAGZY1g0T8kfsOwDL45ZM/eeg+z1+P65cqr2vIW4KGUKd9C4mX+/q
   LvdwkXUm8mvbCFa9/u+1NzGM5JbFQ7JjatUZktykvygk/m1Bt23/Oyika
   A==;
X-CSE-ConnectionGUID: jbgiFzRHT5G5SMw+r9s6OQ==
X-CSE-MsgGUID: IjGwIRQzRT+eLn80RyZWiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817608"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817608"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:47 -0700
X-CSE-ConnectionGUID: KZH5JAjbQzuRsJ4hQ852aQ==
X-CSE-MsgGUID: H2lY9Th4QEiX/lqWcwhuYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729701"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	michal.swiatkowski@linux.intel.com,
	aleksandr.loktionov@intel.com,
	lukasz.czapnik@intel.com,
	jacob.e.keller@intel.com,
	jamie.bainbridge@gmail.com,
	horms@kernel.org,
	dechen@redhat.com,
	Robert Malz <robert.malz@canonical.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 6/9] i40e: avoid redundant VF link state updates
Date: Wed, 29 Oct 2025 16:12:13 -0700
Message-ID: <20251029231218.1277233-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Vosburgh <jay.vosburgh@canonical.com>

Multiple sources can request VF link state changes with identical
parameters. For example, OpenStack Neutron may request to set the VF link
state to IFLA_VF_LINK_STATE_AUTO during every initialization or user can
issue: `ip link set <ifname> vf 0 state auto` multiple times. Currently,
the i40e driver processes each of these requests, even if the requested
state is the same as the current one. This leads to unnecessary VF resets
and can cause performance degradation or instability in the VF driver,
particularly in environment using Data Plane Development Kit (DPDK).

With this patch i40e will skip VF link state change requests when the
desired link state matches the current configuration. This prevents
unnecessary VF resets and reduces PF-VF communication overhead.

To reproduce the problem run following command multiple times
on the same interface: 'ip link set <ifname> vf 0 state auto'
Every time command is executed, PF driver will trigger VF reset.

Co-developed-by: Robert Malz <robert.malz@canonical.com>
Signed-off-by: Robert Malz <robert.malz@canonical.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 081a4526a2f0..0fe0d52c796b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4788,6 +4788,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	unsigned long q_map;
 	struct i40e_vf *vf;
 	int abs_vf_id;
+	int old_link;
 	int ret = 0;
 	int tmp;
 
@@ -4806,6 +4807,17 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	vf = &pf->vf[vf_id];
 	abs_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
 
+	/* skip VF link state change if requested state is already set */
+	if (!vf->link_forced)
+		old_link = IFLA_VF_LINK_STATE_AUTO;
+	else if (vf->link_up)
+		old_link = IFLA_VF_LINK_STATE_ENABLE;
+	else
+		old_link = IFLA_VF_LINK_STATE_DISABLE;
+
+	if (link == old_link)
+		goto error_out;
+
 	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
 	pfe.severity = PF_EVENT_SEVERITY_INFO;
 
-- 
2.47.1


