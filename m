Return-Path: <netdev+bounces-47784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9807EB633
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F86A281327
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AC26ACF;
	Tue, 14 Nov 2023 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9xADqJn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07604177C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93434120
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985722; x=1731521722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bN+OQTtLAb0SyhDXBm/9bxArljwyqUlOgWT3iU90DOc=;
  b=H9xADqJngPIIl79qLO0JIo/wul4UifzuaH7Mly/sdyTZqjysqIs+hbpc
   Xm76OlzrUjEt965iYz/QeCHk7/r392WZYbjYEAFkdqxlQETgYFQ6dbMfd
   VSKvXoaWrmo9lLRTJNu34L6Nk82FsBUynbKnnoGn0ftigWCjOdGJXJRAp
   /UgWOH4Na/5CNoMgsBAUScmAB2JOJu1Rfmr/FG9hrJfK3LlKIa3hErr6g
   Up8lG8YCXYlVofurFQp8hS16HnePLrVTx5Zzrehfo/2i2UwcTDGG8Z67B
   rmC6pqgC2zmo01I0OMZAEyeFmv/JGHtU9s3g6lhcg23o1kPDmqSXgakSs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514458"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514458"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160931"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160931"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 03/15] ice: remove unused control VSI parameter
Date: Tue, 14 Nov 2023 10:14:23 -0800
Message-ID: <20231114181449.1290117-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

It isn't used in ice_eswitch_release_reprs(). Probably leftover. Remove
it.

Commit that has removed usage of ctrl_vsi:
commit c1e5da5dd465 ("ice: improve switchdev's slow-path")

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index fd8d59f4d97d..a862681c0f64 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -189,10 +189,9 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 /**
  * ice_eswitch_release_reprs - clear PR VSIs configuration
  * @pf: poiner to PF struct
- * @ctrl_vsi: pointer to eswitch control VSI
  */
 static void
-ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
+ice_eswitch_release_reprs(struct ice_pf *pf)
 {
 	struct ice_vf *vf;
 	unsigned int bkt;
@@ -286,7 +285,7 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 	return 0;
 
 err:
-	ice_eswitch_release_reprs(pf, ctrl_vsi);
+	ice_eswitch_release_reprs(pf);
 
 	return -ENODEV;
 }
@@ -532,7 +531,7 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 	ice_eswitch_napi_disable(pf);
 	ice_eswitch_br_offloads_deinit(pf);
 	ice_eswitch_release_env(pf);
-	ice_eswitch_release_reprs(pf, ctrl_vsi);
+	ice_eswitch_release_reprs(pf);
 	ice_vsi_release(ctrl_vsi);
 	ice_repr_rem_from_all_vfs(pf);
 }
-- 
2.41.0


