Return-Path: <netdev+bounces-303636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xkmINskORWpr6AoAu9opvQ
	(envelope-from <netdev+bounces-303636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 776206EDAB5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nuHkTFXU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303636-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303636-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D81E3040031
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E1404BFD;
	Wed,  1 Jul 2026 12:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783E481A84
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909939; cv=none; b=q4uXtkERPCrEDw398goKUsZZ7y9bheadiIgEwbuQhunQ2Hrvj+NWrynVrExgRR479eiv8pGiLKPIPII13dHOgVs0x0dO0zc+NHnRi60kW1Yg/9E+O7wSgSD9g2+EcvDS7Nu6sWeHVtWaJMO6WKn0/YvFaBwdoO3jpWouXzwFb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909939; c=relaxed/simple;
	bh=eRQgpL4qfxEAYee/aiq5vXUQEARM1LUI4g4CYk+FfSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqajRoOHKIX1nUzWx3zy+WyF90ioy1vhTE25WJPgMNZdyPMwAvIsT2jHp+T0eyP2XKHPpGf5iqn5VhPmkKd0BAkhwNccGOPzwWcimuUuS15RKxKyF2hCT7WxjDQO2l1zi5A1iurn474f+9dMZINYtM0vdg5Y67OOwOToyoVB1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuHkTFXU; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909938; x=1814445938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRQgpL4qfxEAYee/aiq5vXUQEARM1LUI4g4CYk+FfSI=;
  b=nuHkTFXUcJxXL58wUhayqnfd3D9JeNrPNhrljM6C93icWhSQR+4KJ4br
   RVSgCfAD6CUBpEiS2PER5D69tRMfBwXXs52TJfq1Umjv3ck8tBDaJHU/b
   nqQjZS6gQn2nk9+Vik3We14MURDrDlJxqsE9jvdgl6GcLWeHDkN7S5ksF
   HnsooTUo1nC63JqVJlgoVoZhCyP2eJ2qplG0SXHEOXd8YSPlC+W98N5JH
   wLOjZ0G3At4QSdKG6AshusCxvZdKv7zaNotw+EcrDkUjhAlWfc80VBkzd
   VToac9rv2xS9T71C8e+EX0F1g6Ptf2+ydx1h+PN6zMuui+I8IgVNLiAgb
   g==;
X-CSE-ConnectionGUID: dh+MOk8dRsi5iE4HIwFR6g==
X-CSE-MsgGUID: nsW3FKqzQ7ui9vUUQv8drA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839241"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839241"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:38 -0700
X-CSE-ConnectionGUID: LS2XpwoSQtC3pq2UN3bcmg==
X-CSE-MsgGUID: zuC5blPTRHinkJVHV7WTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864918"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:35 -0700
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
Subject: [PATCH v5 net 4/7] i40e: avoid deadlock when calling unregister_netdev()
Date: Wed,  1 Jul 2026 14:45:21 +0200
Message-Id: <20260701124524.13644-5-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 776206EDAB5

Sashiko reports:
***
> +err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
Could this result in a deadlock when called during a device rebuild?
Looking at i40e_rebuild(), it explicitly acquires the RTNL lock before
proceeding:
drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_rebuild() {
    ...
	if (!lock_acquired)
		rtnl_lock();
	ret = i40e_setup_pf_switch(pf, reinit, true);
    ...
}
If i40e_setup_pf_switch() calls i40e_vsi_reinit_setup() and takes this new
err_netdev path, unregister_netdev() will unconditionally attempt to acquire
rtnl_lock(), leading to a deadlock on the non-recursive mutex.
***

Use unregister_netdevice() when the rebuild path already holds RTNL, and
keep unregister_netdev() for callers that do not. This avoids both
recursive RTNL locking and dropping RTNL in the middle of the VSI unwind
path.

Fixes: bc7d338fbb3f ("i40e: reinit flow for the main VSI")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a29a89192a7a..e88cf7cfbd84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14257,7 +14257,8 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
  * Returns pointer to the successfully allocated and configured VSI sw struct
  * on success, otherwise returns NULL on failure.
  **/
-static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
+static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
+					      bool lock_acquired)
 {
 	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
@@ -14314,7 +14315,10 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 err_netdev:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
-		unregister_netdev(vsi->netdev);
+		if (lock_acquired)
+			unregister_netdevice(vsi->netdev);
+		else
+			unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
 	}
@@ -15036,7 +15040,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
 						  uplink_seid, 0);
 		else if (reinit)
-			main_vsi = i40e_vsi_reinit_setup(main_vsi);
+			main_vsi = i40e_vsi_reinit_setup(main_vsi, lock_acquired);
 		if (!main_vsi) {
 			dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
 			i40e_cloud_filter_exit(pf);
-- 
2.43.0


