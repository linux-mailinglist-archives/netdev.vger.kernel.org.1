Return-Path: <netdev+bounces-196240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE70EAD4025
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E753A4D81
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73908244682;
	Tue, 10 Jun 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foDtEIah"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A02441A6
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575638; cv=none; b=ug83QaXYf3g3JzGVGwsUYc8qrru1Ij6AFs+hiwzxcoH9VzLQUpU7RgBZRu5nJbtPiagyBZxHmQqmbfKGcujF6Svauw+G3lf/Zy4cEbAZE6RKDmm6Vg3awacx24O7JKcXqG94Xt2IlOIOX2NzFIRAutPME/FGO1JZ7fL+aPuXUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575638; c=relaxed/simple;
	bh=6E8LTJHoCnvuzDFPBPpjnxvdf4mTHb/1eHp1xb/VI3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2ZPUX9eLdAYkYAZjAhoN/mLOic3Rff7N3A1JZPNjMHJeAeg+2vgBKAXV3Kqzgn8L81kJEH+x4S9zEAsAXrh6SErlnFVLWB/p8thV3RQE4PZ/2PI1/mYJaXe92YQMzgVe3YhRHxiKrUO7gHbdSDmPA6k4FrCZ6Ejz6COuF6gBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foDtEIah; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749575637; x=1781111637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6E8LTJHoCnvuzDFPBPpjnxvdf4mTHb/1eHp1xb/VI3o=;
  b=foDtEIahRCvp4I1eFtPuDkalizfjNCAjq0UkECqzuPTtENpSwsvKpF7y
   77H7pd0FmQTZc/WVv7mKzSK4i6qu1ECAQ9lO7rhec8cQYweZuQeBPKbdo
   p84r23DR72VHBCbKDewDxXT5uz50tcnR3BnWH2e1/hbQBEh8ZON8FRV94
   aCDG0QrdzWy5VElGwVByLrAamTKXjfGXO8yNLdEQJKDMqjc7sCeXNtoy0
   xIg1+o4CjV45tyZtH6q+GfTujxT6ljrH5x8q61cn40grtjw61L14z/4Ub
   GcMjpDZcL7XlrzC7AU7nZIXmKMNN4PXQ6ysvSIKlasPIHIwss2zMULu++
   Q==;
X-CSE-ConnectionGUID: biAsks/DQvCDWJF9NGieRw==
X-CSE-MsgGUID: ryb7f4/3QJufmzZ96dGL6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51554656"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51554656"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:13:54 -0700
X-CSE-ConnectionGUID: ShyL+t7aTwSS1Dh+TJwEcA==
X-CSE-MsgGUID: q7bqVJXYS4GIRc/ZpJxoSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147850440"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2025 10:13:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Robert Malz <robert.malz@canonical.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/5] i40e: retry VFLR handling if there is ongoing VF reset
Date: Tue, 10 Jun 2025 10:13:42 -0700
Message-ID: <20250610171348.1476574-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
References: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robert Malz <robert.malz@canonical.com>

When a VFLR interrupt is received during a VF reset initiated from a
different source, the VFLR may be not fully handled. This can
leave the VF in an undefined state.
To address this, set the I40E_VFLR_EVENT_PENDING bit again during VFLR
handling if the reset is not yet complete. This ensures the driver
will properly complete the VF reset in such scenarios.

Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 22d5b1ec2289..88e6bef69342 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4328,7 +4328,10 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 		reg = rd32(hw, I40E_GLGEN_VFLRSTAT(reg_idx));
 		if (reg & BIT(bit_idx))
 			/* i40e_reset_vf will clear the bit in GLGEN_VFLRSTAT */
-			i40e_reset_vf(vf, true);
+			if (!i40e_reset_vf(vf, true)) {
+				/* At least one VF did not finish resetting, retry next time */
+				set_bit(__I40E_VFLR_EVENT_PENDING, pf->state);
+			}
 	}
 
 	return 0;
-- 
2.47.1


