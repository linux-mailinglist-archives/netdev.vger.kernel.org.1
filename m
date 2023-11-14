Return-Path: <netdev+bounces-47782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0C7EB630
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4257E281356
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798B41A8E;
	Tue, 14 Nov 2023 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUB2QkLZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFBF11C90
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6168122
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985720; x=1731521720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/jMOObLTqKfzpKbC9jfEDic4o4OmWtMGLupRXZJIeQ=;
  b=QUB2QkLZZRs71XKgVxtPTv8OQU41ZghnQIY5W9Z9M62/WaOiPrBp0NTg
   mV1c4D5Q5jNPQuv2m8GDDDPLQVcEXefF6en6UT/9DYLiiBKjHRQyRc5Fq
   PoDCnPwwEWbj7W9lI7wyrPz/mWwfywCN4AmmZ+J2VSGVBfQVaCWlg9ItB
   OIgT3dM9zMJvjqZDy7JURBIt7uPMMnOUNtbJ1ZXhWbhyWsBM7qhI+aV/m
   Z9Uzj1gwp6kRhfaZeWVspPzPd9ISBBNglyNRiuDe0xUFoOhnu/EqjpK6a
   uDKg4+F14vRV+0LY3cXSMTT9nZTFeZWswMozrRLHgVf/55hiwMjMwXK2P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514449"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160928"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160928"
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
Subject: [PATCH net-next 02/15] ice: remove redundant max_vsi_num variable
Date: Tue, 14 Nov 2023 10:14:22 -0800
Message-ID: <20231114181449.1290117-3-anthony.l.nguyen@intel.com>
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

It is a leftover from previous implementation. Accidentally it wasn't
removed. Do it now.

Commit that has removed it:
commit c1e5da5dd465 ("ice: improve switchdev's slow-path")

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index e7f1e53314d7..fd8d59f4d97d 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -224,7 +224,6 @@ ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
 static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 {
 	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
-	int max_vsi_num = 0;
 	struct ice_vf *vf;
 	unsigned int bkt;
 
@@ -267,9 +266,6 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 			goto err;
 		}
 
-		if (max_vsi_num < vsi->vsi_num)
-			max_vsi_num = vsi->vsi_num;
-
 		netif_napi_add(vf->repr->netdev, &vf->repr->q_vector->napi,
 			       ice_napi_poll);
 
-- 
2.41.0


