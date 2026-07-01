Return-Path: <netdev+bounces-303638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TJsUGkgVRWq/6goAu9opvQ
	(envelope-from <netdev+bounces-303638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C4B6EE121
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:25:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YH9RzkLT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303638-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303638-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC9C3367FD8
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EC481AAF;
	Wed,  1 Jul 2026 12:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FD481AB2
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909944; cv=none; b=oXCfgfHad00cUaacbGo6V73GqZM3RSAf2Lvdnq2i4YcoXm3EfkdymGyu1+sVm71nM4d8dVLRG84Fq+JPbZByfD1ricn9TjCH3vPfQNt9YqQ3KZkEYwFKNpo/VqL2EM3yWadEFTPOG+X33xZYdSkT8I5ZjxNBLO9BrsiEt9PQ/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909944; c=relaxed/simple;
	bh=O00QyTCjuQndyzpgME7KOpR/bYZTOs5ybPP6b8Yssz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GrFDAX54ue4Sz2p8vcehH1JXoWwcOCoSotZB5F0jLBzp9EMpNS0leOwPw2m+n+l+ciccioySNcogdVDhTJPqR1fN9nB8IOiqSSyzzdjiWx320v7TEQwjhUM+JWpw7CCRIrQpmnhfBHqwb2RUXKprYBZY38C7J0a9wPvSrvaSUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH9RzkLT; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909943; x=1814445943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O00QyTCjuQndyzpgME7KOpR/bYZTOs5ybPP6b8Yssz4=;
  b=YH9RzkLT8utHJalm6AB2QPeywWyin87hQAZvpuVC1517gmhU38ux0z85
   epx03AGv19CzIIAciRFLSHEIugL/zZspKrclcGAsJq9imiJu0msd8BtD0
   Ez2sNJmIcy9gTD0gJMTQEWRrfzByKnW3qXLj9QUlK9gWlm1aL0Cb8N3WS
   Yyc6Q6RGAZEEK0nBiBGNbBXF996DEIMqxVMlwLfYbAMFWLGoiL8rVRL9f
   4mygs2qC5wWlofD/Kij55rJpJ1xAH5t5oT45Cd0MeoeExe54Efj16imxo
   AQpLHSzr1XLNy3DhlHdoKrWSJSRGIrosKAxJ1TPBgDVQIepxFt8XF9zpS
   g==;
X-CSE-ConnectionGUID: Wt0RO1wJSkO5GtKcn2GJGg==
X-CSE-MsgGUID: x6/DxJedTdagAne6mOwCWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839255"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839255"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:43 -0700
X-CSE-ConnectionGUID: 14YWUQ5IT8+1iBrXN2RmdA==
X-CSE-MsgGUID: cWqHN7CTRYKWU6F7DK2aEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864944"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:40 -0700
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
Subject: [PATCH v5 net 6/7] i40e: do not expose netdev too early
Date: Wed,  1 Jul 2026 14:45:23 +0200
Message-Id: <20260701124524.13644-7-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303638-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0C4B6EE121

i40e_vsi_setup() registers the netdev before rings and q_vectors are fully
allocated and mapped. Once register_netdev() returns, userspace can reach
netdev callbacks such as ndo_open(), so the VSI backing state must already
be ready.

Move register_netdev() to the end of the setup path, after ring/q_vector
allocation, ring mapping and RSS configuration. Keep freeing an allocated
but not registered netdev on the error path.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 29 ++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fcdd13af08ea..a9ec53cfd905 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14454,15 +14454,6 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 				goto err_netdev;
 			SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
 		}
-		ret = register_netdev(vsi->netdev);
-		if (ret)
-			goto err_dl_port;
-		vsi->netdev_registered = true;
-		netif_carrier_off(vsi->netdev);
-#ifdef CONFIG_I40E_DCB
-		/* Setup DCB netlink interface */
-		i40e_dcbnl_setup(vsi);
-#endif /* CONFIG_I40E_DCB */
 		fallthrough;
 	case I40E_VSI_FDIR:
 		/* set up vectors and rings if needed */
@@ -14490,6 +14481,19 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		if (ret)
 			goto err_config;
 	}
+
+	if (vsi->netdev) {
+		ret = register_netdev(vsi->netdev);
+		if (ret)
+			goto err_config;
+		vsi->netdev_registered = true;
+		netif_carrier_off(vsi->netdev);
+#ifdef CONFIG_I40E_DCB
+		/* Setup DCB netlink interface */
+		i40e_dcbnl_setup(vsi);
+#endif /* CONFIG_I40E_DCB */
+	}
+
 	return vsi;
 
 err_config:
@@ -14500,13 +14504,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
-		free_netdev(vsi->netdev);
-		vsi->netdev = NULL;
 	}
-err_dl_port:
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 err_netdev:
+	if (vsi->netdev) {
+		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
+	}
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
 err_vsi:
 	i40e_vsi_clear(vsi);
-- 
2.43.0


