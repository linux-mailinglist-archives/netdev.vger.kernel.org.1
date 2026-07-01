Return-Path: <netdev+bounces-303635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7djpIr0ORWpI6AoAu9opvQ
	(envelope-from <netdev+bounces-303635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:57:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C66EDAAF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:57:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=coHcBY4Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303635-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303635-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 003A5312F750
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211548164A;
	Wed,  1 Jul 2026 12:45:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC72481A84
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909936; cv=none; b=dmMyHeY8m1M/0xjEoJ21ZN4PLcw+pqf9UzHCN62iBBS5MAtHMI5lk+9InH00raPr1FgVzfNspAheW+Q5ftVp9L7xERhxPZmiGr5D+3zJuijbK9RSPm6oX8xvbNVOfEWfNs9y+dVwBWdV1vh/o2Uc5H2aa7zJo6rCuvF8AWeFFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909936; c=relaxed/simple;
	bh=8Dwvhzji6WxYV9lCY1qvZHWe+fj258rib/mlG/ST8ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5NvsafzqTZPoWhm+fFhat7vNtSD0tAgpb7RcofRM/hxdAHBoUfD65+2yx/FhtmC17K8Ps1azlZnP5e+D8nv2myxQAcbjqZCpjAqdVdJvLfSIB2cRzYbLHF0UhQUFwn1W338jbV+1Y51DgG8bGdFEiDKNjTD2bz2J1l7lhM3jeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coHcBY4Y; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909935; x=1814445935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Dwvhzji6WxYV9lCY1qvZHWe+fj258rib/mlG/ST8ek=;
  b=coHcBY4YYyUej1qlOsuPNNH3dJvLibFWGDcl5hymXutmCKgnvp9Hjc/G
   SAXdgfyjNDDO+tzKuigVyUfX1q1sQw4pF356WNB2mR/UbKrPv5QWCAm8G
   niq4LYwlTET/NjpMyZVkHvE9VVchWyFP3+STbJxtbPIVZ/cNmfL+4jc5/
   wOoAGvK+s4MwdvRFPySIL2NxUWXNERCMMKCvr1qEpc2u/e67N/cAMacVz
   gsR0jC8Jwj/8aCJvrfD8StoITpnuBU6BGR84Tzl2ygYfNL1in7/ewawXi
   77ihyriH3h+CM3paR3TjV+3P11Cpreru1QDH5LPdUaB9MQx+bvGct8r0o
   A==;
X-CSE-ConnectionGUID: FbXqvPpdS9upNmxpbTU4LQ==
X-CSE-MsgGUID: b4xAjanBRb2iorzfeltD7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839233"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839233"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:35 -0700
X-CSE-ConnectionGUID: JrurodIYSPK7D0Al54FJfg==
X-CSE-MsgGUID: vC4dkGwdRrOKZEUqD5DpfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864905"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:33 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH v5 net 3/7] i40e: make ring pointers unreachable before freeing via rcu
Date: Wed,  1 Jul 2026 14:45:20 +0200
Message-Id: <20260701124524.13644-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 297C66EDAAF

Sashiko reports:
***
>  err_config:
> +	i40e_vsi_free_q_vectors(vsi);
> +err_qvec:
>  	i40e_vsi_clear_rings(vsi);
This is a pre-existing issue, but can the sequence in i40e_vsi_clear_rings()
lead to an RCU ordering violation?
In i40e_vsi_clear_rings(), the rings are freed before the array pointers are
nullified:
	kfree_rcu(vsi->tx_rings[i], rcu);
	WRITE_ONCE(vsi->tx_rings[i], NULL);
Under RCU rules, a pointer must be made unreachable to new readers before it
is handed off to kfree_rcu(). Could a new RCU reader (like
i40e_get_netdev_stats_struct_tx()) fetch the pointer after kfree_rcu() is
invoked, and access freed memory if the grace period expires while the
reader is still active?
***

Save the Tx ring pointer before clearing the published ring array slots
and pass the saved pointer to kfree_rcu(). This preserves the intended
RCU ordering, where new readers can no longer discover the ring through
vsi->tx_rings/rx_rings/xdp_rings before the object is queued for
deferred freeing, while avoiding a NULL kfree_rcu() argument after the
slot has already been cleared. Since the Tx pointer is the base of the
per-queue-pair allocation block, re-reading vsi->tx_rings[i] after
WRITE_ONCE(..., NULL) would otherwise turn the free into a no-op and
leak the whole ring block.

Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of pointers")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 471fa7f7b643..a29a89192a7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11699,11 +11699,13 @@ static void i40e_vsi_clear_rings(struct i40e_vsi *vsi)
 
 	if (vsi->tx_rings && vsi->tx_rings[0]) {
 		for (i = 0; i < vsi->alloc_queue_pairs; i++) {
-			kfree_rcu(vsi->tx_rings[i], rcu);
+			struct i40e_ring *tx_ring = vsi->tx_rings[i];
+
 			WRITE_ONCE(vsi->tx_rings[i], NULL);
 			WRITE_ONCE(vsi->rx_rings[i], NULL);
 			if (vsi->xdp_rings)
 				WRITE_ONCE(vsi->xdp_rings[i], NULL);
+			kfree_rcu(tx_ring, rcu);
 		}
 	}
 }
-- 
2.43.0


