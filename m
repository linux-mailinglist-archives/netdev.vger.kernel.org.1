Return-Path: <netdev+bounces-301209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GqshMxixOWqPwQcAu9opvQ
	(envelope-from <netdev+bounces-301209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765B6B28F0
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:03:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Kg33euVZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301209-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301209-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613A2305A71B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548836EAA8;
	Mon, 22 Jun 2026 22:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1937BE6E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:01:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165673; cv=none; b=ID2pGmI7jd+/wXnsDhHu6VUSrrkFonst9TUto9XfFlYM/xRm3AdYTyGtjq732BMXmU5i/DBQgXk5xgIXNQUfpT9EVPEpU9S7gEMaVpJS41xmhA3O2eH36f5dBUVvsN2XsyYsEPIWRwXmr5uc7H9m4M3tDPwpWSRarrghL+F4PHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165673; c=relaxed/simple;
	bh=Y1+zdllyrky8xr+DQci2O1Fo1kVAo2TocSFD8EowaqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI6HwWiNdTFoZAbYsqTcAj27CaQDftkELOAzwox0iBWHw5CrMo1OUBODo1w2i550N5pPPWosNp/fqozDVLXb+Zk3w3+gGcerewKANivLPERhf4+TozLr6qg7z885Hh+scTh1IfQX0UnnRbZuRe+nJXL9IhxpcMFu80JeEZ/ukk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kg33euVZ; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165671; x=1813701671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1+zdllyrky8xr+DQci2O1Fo1kVAo2TocSFD8EowaqY=;
  b=Kg33euVZcAUKXu0FR2iVtUZvdctOgGWCf4xP5poMO8hgn19tVFHx0yWV
   dQHHOLmY9LsewoIgZcFTU8QZNUrfQK34qN3QBjhc2/wub2f/nGtOrhjYZ
   U3lHm3T5eZOBuf4Y+exjBLXkSXivkANgdlzOenPAD8F5k3BMSItv8qpvh
   9e8wzuEAl8qY2c8bZeyARLKRGsZybrcc2EegS7okpClRWmB99ab5/XjZR
   F5YJ+4stQnlzMqggX0fzr1MYay7SIhbf/dLyJjfd8qJLGLb1CtW+L1E76
   D+h/abNqznSuZbwyvcthhBEBElicb1UMYx0pitckNvZCGAZS8jgQPjdb+
   Q==;
X-CSE-ConnectionGUID: pb1aEkrgTCWk2ihNyMVdDA==
X-CSE-MsgGUID: 5zZBGrmIRJq2OBPF5Kc52w==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675589"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675589"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:05 -0700
X-CSE-ConnectionGUID: fcewnz40SdKl3bCQE72C+w==
X-CSE-MsgGUID: UPUDipW8QMKBL4A0xCOWzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205724"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	grzegorz.nitka@intel.com,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 6/8] ice: dpll: fix memory leak in ice_dpll_init_info error paths
Date: Mon, 22 Jun 2026 15:00:53 -0700
Message-ID: <20260622220059.2471844-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
References: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301209-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:zhaojinming@uniontech.com,m:anthony.l.nguyen@intel.com,m:arkadiusz.kubalewski@intel.com,m:grzegorz.nitka@intel.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:aleksandr.loktionov@intel.com,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1765B6B28F0

From: ZhaoJinming <zhaojinming@uniontech.com>

Several error return paths in ice_dpll_init_info() directly return
without freeing previously allocated resources, causing memory leaks:

- When de->input_prio allocation fails, d->inputs is leaked
- When dp->input_prio allocation fails, d->inputs and de->input_prio
  are leaked
- When ice_get_cgu_rclk_pin_info() fails, all previously allocated
  inputs/outputs/input_prio are leaked
- When ice_dpll_init_pins_info(RCLK_INPUT) fails, same resources
  are leaked

Fix this by jumping to the deinit_info label which properly calls
ice_dpll_deinit_info() to free all allocated resources.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 3876ee7255ac..30c3a4db7d61 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4752,12 +4752,16 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 
 	alloc_size = sizeof(*de->input_prio) * d->num_inputs;
 	de->input_prio = kzalloc(alloc_size, GFP_KERNEL);
-	if (!de->input_prio)
-		return -ENOMEM;
+	if (!de->input_prio) {
+		ret = -ENOMEM;
+		goto deinit_info;
+	}
 
 	dp->input_prio = kzalloc(alloc_size, GFP_KERNEL);
-	if (!dp->input_prio)
-		return -ENOMEM;
+	if (!dp->input_prio) {
+		ret = -ENOMEM;
+		goto deinit_info;
+	}
 
 	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
 	if (ret)
@@ -4782,12 +4786,12 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	ret = ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
 					&pf->dplls.rclk.num_parents);
 	if (ret)
-		return ret;
+		goto deinit_info;
 	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
 		pf->dplls.rclk.parent_idx[i] = d->base_rclk_idx + i;
 	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
 	if (ret)
-		return ret;
+		goto deinit_info;
 	de->mode = DPLL_MODE_AUTOMATIC;
 	dp->mode = DPLL_MODE_AUTOMATIC;
 
-- 
2.47.1


