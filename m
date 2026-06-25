Return-Path: <netdev+bounces-301995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U/BHFBVGPWqE0ggAu9opvQ
	(envelope-from <netdev+bounces-301995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C46C6FB5
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MNVe+H1a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301995-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301995-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809043071C6F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72F3E8324;
	Thu, 25 Jun 2026 15:14:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9B3E7BD9
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:14:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400487; cv=none; b=Et8NcwwiV9nqFqrpGvm5tUGZK9rfi7nNuMxuZpN+1KdihoIZpEYIf09obsJ6eSq1OoaeUl2t7OlhtfidVNXlifD/7Z1Ax1Afy07zio5Nf23sAKEhcSry5wpLSgzK+YGg/+pASR7Q0QgwGwlqbdS8XzLItE69rD3jfSVE/vnpqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400487; c=relaxed/simple;
	bh=FqAu1SYkvELBsVn8SuaoHwAKV6DkoPDKT+iZ6Cw8WBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBIPGV801AbWVAFvBpbynqqUBm/kDRaAkl860fxQR/B3EABobvQiSEd6rU85qAvhKGnC32QXydnWJY49psgiZfa9cO2OFmBB/RljZ/suRoQiBaKtK8Wc4r212AxM6hMDsvGoe9qgL9JxPceLZU6vf9A/zmwHSYfVvoAcLp+e+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNVe+H1a; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782400485; x=1813936485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqAu1SYkvELBsVn8SuaoHwAKV6DkoPDKT+iZ6Cw8WBQ=;
  b=MNVe+H1aZMS9lpbP3DnYRroNu/OhhupBOv4i3xgB0bBvXkKqSXOQ9wx8
   wfWDmn0TcoqWyZhaF48+7NwgN1CoE+Aakoqg+CSfd0l51/JBOfSq9/2VX
   +bwvunRNm4vZPLCQxjBVQqexjwFLmdF1B7CZvELgcRQNl8f/7FzbjiAb4
   lQL5H5uy1bmcVFLVqs5r70cZiZPD7F2wjsy/NNMoVu7ZwP6wBe2quDxY8
   H+24JoMiTymwnAq9535elMaroOIMGMhtrVuMGcY9UqnluAvJbtnJWOQI+
   JfFyFcBCtrIVjiRf+iP2o2gmkkSXJ9dNsgdYDMke1lhGUslo2sgfGBbag
   g==;
X-CSE-ConnectionGUID: QA+1jTwBQTClWrVbXzcCVw==
X-CSE-MsgGUID: e2/Pb9N9TxOR8+OmqJ12ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83304536"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83304536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:14:44 -0700
X-CSE-ConnectionGUID: n1pJKhfJRUW+IGRRjAj0NA==
X-CSE-MsgGUID: AyD4E529QxyIjjBOmKqz/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254866944"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2026 08:14:43 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 1/3] i40e: unregister netdev before clearing VSI on reinit failure
Date: Thu, 25 Jun 2026 17:14:29 +0200
Message-Id: <20260625151431.1102838-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
References: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B4C46C6FB5

i40e_vsi_reinit_setup() tears down the existing VSI queue/ring backing
state before allocating replacement arrays and queue tracking. If one of
these early allocations fails, the function jumps directly to err_vsi
and calls i40e_vsi_clear().

For a registered netdev, this frees the VSI while
netdev_priv(netdev)->vsi can still point at it, leaving the registered
netdev with dangling private driver state.

Split the error path so failures after destructive reinit teardown first
unregister and free the netdev before clearing the VSI.

Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..471fa7f7b643 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14274,7 +14274,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	i40e_set_num_rings_in_vsi(vsi);
 	ret = i40e_vsi_alloc_arrays(vsi, false);
 	if (ret)
-		goto err_vsi;
+		goto err_netdev;
 
 	alloc_queue_pairs = vsi->alloc_queue_pairs *
 			    (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
@@ -14284,7 +14284,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_vsi;
+		goto err_netdev;
 	}
 	vsi->base_queue = ret;
 
@@ -14309,6 +14309,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
+err_netdev:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14318,7 +14319,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
-err_vsi:
 	i40e_vsi_clear(vsi);
 	return NULL;
 }
-- 
2.43.0


