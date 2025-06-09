Return-Path: <netdev+bounces-195870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80483AD28B7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CAA3A8663
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1973223705;
	Mon,  9 Jun 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="np/oEVnM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3D221FC0
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504425; cv=none; b=dPSLOY6Nr9DsuHNMP8EiAipArSMFZmP5w1B0b60i/EQyyu9KYiJ8TddSImZTeKYpWSK7QV+uA4SbmyjFGFhogZ4/MJ3mfhXWg0/XC7pd4LGvGGYXY8Acm4bu3sSdM0lR6OMjHY+dLp2+1lEr/kfyoKrvCe+0RXmzorXO8x9pTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504425; c=relaxed/simple;
	bh=VoaEtH/dSUK/NmDJ0wfJAqkc73Gbjcqj5Lfj0JNuJdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r26Z73IEkHvaylSeTvmqVi7QpMQ6l6Fp3kN0B7tMP3ZcP0A/wQm2li3EfTnGaYxHQ+FX9Wf/js9tlzl4FLTU+eroAxgVIeNzeQmSXCF0OUHutuSDxovCxEI5KwwlPMNlK9Q8qMNpDtHMjbT23W/7aAllmqFZwa8DI7yAxmZt1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=np/oEVnM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504424; x=1781040424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VoaEtH/dSUK/NmDJ0wfJAqkc73Gbjcqj5Lfj0JNuJdk=;
  b=np/oEVnMMe/tDaLkD5OJOUUiPMrRpW2yMtgsVrbdhTY05KL5ata1Rswi
   317NQBWCJMCHQklE4Qae6pGERaoldtBv9UEty8NYJOQh+IfSwf0Sy8wD4
   qjRf94LR779iUsYAeCoFTRmjHho+XsetiJt9YPYmAuZz2fPa8V/JyxuGk
   aeS+N5RW81jEFMqiT4el6gxAPLd+26b8wZThTDYDt5cJlXdULnKChJKFd
   3H5z7QYzQ8D//hJk+uZqBbv8PJAuq+HyNkM2wq8/Ivho/6xL3R/ZmAfSc
   77GcgXQyWbl1o1Jzk01jdFoKFz2PprBRmNmwCRQNnd5C1l/8LwxGaC9XK
   g==;
X-CSE-ConnectionGUID: Wl43ft9+Qy+uwkOHdHYfUA==
X-CSE-MsgGUID: mncbnOGFQOydzk30jFa8dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864183"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864183"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:02 -0700
X-CSE-ConnectionGUID: hgCRCh7gT2KM8xqrRdaseQ==
X-CSE-MsgGUID: Yrvvs9heTvqy+cA+0uokAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469021"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@linux.intel.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 03/11] ice: add link_down_events statistic
Date: Mon,  9 Jun 2025 14:26:42 -0700
Message-ID: <20250609212652.1138933-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Introduce a link_down_events counter to the ice driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ddd0ad68185b..dcf87efb9f20 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -614,6 +614,7 @@ struct ice_pf {
 	u16 globr_count;	/* Global reset count */
 	u16 empr_count;		/* EMP reset count */
 	u16 pfr_count;		/* PF reset count */
+	u32 link_down_events;
 
 	u8 wol_ena : 1;		/* software state of WoL */
 	u32 wakeup_reason;	/* last wakeup reason */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bbf9e6fd315b..5863a86482f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -836,6 +836,15 @@ static void ice_set_msglevel(struct net_device *netdev, u32 data)
 #endif /* !CONFIG_DYNAMIC_DEBUG */
 }
 
+static void ice_get_link_ext_stats(struct net_device *netdev,
+				   struct ethtool_link_ext_stats *stats)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = np->vsi->back;
+
+	stats->link_down_events = pf->link_down_events;
+}
+
 static int ice_get_eeprom_len(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
@@ -4784,6 +4793,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.set_msglevel		= ice_set_msglevel,
 	.self_test		= ice_self_test,
 	.get_link		= ethtool_op_get_link,
+	.get_link_ext_stats	= ice_get_link_ext_stats,
 	.get_eeprom_len		= ice_get_eeprom_len,
 	.get_eeprom		= ice_get_eeprom,
 	.get_coalesce		= ice_get_coalesce,
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d97d4b25b30d..4e04721467bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1144,6 +1144,9 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (link_up == old_link && link_speed == old_link_speed)
 		return 0;
 
+	if (!link_up && old_link)
+		pf->link_down_events++;
+
 	ice_ptp_link_change(pf, link_up);
 
 	if (ice_is_dcb_active(pf)) {
-- 
2.47.1


