Return-Path: <netdev+bounces-281636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BIgJahE8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:24:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9CA47D8A1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496093045475
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9C340A6A;
	Tue, 28 Apr 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEHWqVuI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2A334695
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353803; cv=none; b=fiKKiPeTrFSBqq6/vUPUtCatCf4QBYNhRr4tBs5AGuK9kAA8i6WbymzDKNrBLqFbqUmJeqi6DpJ9QmNEup9JQC1V/ZZEa8yIAsZTjSM3z4XsKKZwdseaAKK2gFzu69NLtoC+UKJ+rnF4fEsKq7MFRXabsnXNG7Xkov/WbZ+alEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353803; c=relaxed/simple;
	bh=ZBzbfMJqu4EXxZqctCPprlTwmnYrISSB7mGEmW8Gl/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVEwOWf6ffC6iUTZOfDKYpTjDKyrAhjxKKfKxKdz87m1dy/JhpNriYtkNXbHx43NeEVMWBcYgJb+bfVhV37Y+s+Zh8iSUFrjPwLjsOi1MFwiCGU5SR+tTIzexX0z6MrKW+PRGr1+kDH5yAfSyQSmSA0n/ru1B+AnfPgWUCF/gFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEHWqVuI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353801; x=1808889801;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZBzbfMJqu4EXxZqctCPprlTwmnYrISSB7mGEmW8Gl/w=;
  b=nEHWqVuIGgFOV48iqgkAomDp5K0pjbM544Cvi1pN7oO/RO3CvtqX0qFN
   E6j4SxPWb2Uaq7/EP9zXtf9gW+i7PBrE0JOESfx9v5uY/tbSipJapJqA5
   ws9220Pbzg0w/JM4AOc8+AhA0+ebIbfZySE2tmL1sB5KWP8blyfS/3oNQ
   T8Ydgy2P6/Z9PXrXN269Z7IlJo0O9UGDXuDQcfehkHt4eiX3536mDMf/p
   VSiXv6uSGMWjDfYNSzTZ/Z/dzVgY/G2Vei+HhkK1+grUI2pvC7BEbDKxd
   a3Fiwjlg9nSmTP6LwfucqhsgCIJGCAD9yWUx175ZzfvGDZgRqLqviDi+7
   w==;
X-CSE-ConnectionGUID: CXaBWk/qS0ONe4X63ZLMBQ==
X-CSE-MsgGUID: PPug8W7kQIiR0ScEYKKqkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910549"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910549"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
X-CSE-ConnectionGUID: /qBTpBa5RIyucZyP8iv//g==
X-CSE-MsgGUID: ghGKacgLRG2h6cp/J9xraw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800209"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:18 -0700
Subject: [PATCH net 06/11] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-6-cdcb48303fd8@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 Alexander Nowlin <alexander.nowlin@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3909;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=FH7e+VDJUmxBBBdCvhgvRyfswmsNqpSnWWCAUugsb5M=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLo6nJ207wXSjl2knr624t3mNYF31zdiThaVNCjbn+
 8Lse493lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCcJN3MfxTPs7XHrRVX01q6/wf
 Sw6c4tykZ7dbt/xOqcoJHykT07NbGRnmPXV8u0zswd8rU0IOcL++Oil/+9xtu4u+31P6/PMsu5I
 YGwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: DB9CA47D8A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281636-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email]

From: Petr Oros <poros@redhat.com>

On certain E810 configurations where firmware supports Tx scheduler
topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
may need to apply a new 5-layer or 9-layer topology from the DDP
package. If the AQ command to set the topology fails (e.g. due to
invalid DDP data or firmware limitations), the global configuration
lock must still be cleared via a CORER reset.

Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
scheduler config fails") correctly fixed this by refactoring
ice_cfg_tx_topo() to always trigger CORER after acquiring the global
lock and re-initialize hardware via ice_init_hw() afterwards.

However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
breaking the reinit path introduced by 86aae43f21cf. This creates an
infinite recursive call chain:

  ice_init_hw()
    ice_init_dev_hw()
      ice_cfg_tx_topo()         # topology change needed
        ice_deinit_hw()
        ice_init_hw()           # reinit after CORER
          ice_init_dev_hw()     # recurse
            ice_cfg_tx_topo()
              ...               # stack overflow

Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
during its reinit, it only needs the core HW reinitialization. This
breaks the recursion cleanly without adding flags or guards.

The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
are preserved, only the init-side placement of ice_init_dev_hw() is
reverted.

Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_common.c      | 2 --
 drivers/net/ethernet/intel/ice/ice_main.c        | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 6144cee8034d..641d6e289d5c 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1245,6 +1245,8 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 		return err;
 	}
 
+	ice_init_dev_hw(pf);
+
 	/* load MSI-X values */
 	ice_set_min_max_msix(pf);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ce11fea122d0..b617a6bff891 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1126,8 +1126,6 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
 
-	ice_init_dev_hw(hw->back);
-
 	mutex_init(&hw->tnl_lock);
 	ice_init_chk_recipe_reuse_support(hw);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5f92377d4dfc..1d1947a7fe11 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5245,6 +5245,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return err;
 	}
 
+	ice_init_dev_hw(pf);
+
 	adapter = ice_adapter_get(pdev);
 	if (IS_ERR(adapter)) {
 		err = PTR_ERR(adapter);

-- 
2.54.0.rc2.531.gaf818d63126a


