Return-Path: <netdev+bounces-94684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3718C0331
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F3A2822E7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2012BE93;
	Wed,  8 May 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5gJeJqH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92922127E34
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189634; cv=none; b=Ga86V08f0jpmol8Uxg/eFW5YzFDOocXCOUjo0DsE6X9i/uX4FlHPQdpmtnKrukL9Nlk6WzdYeVQa6FJ8bKfOyHMNz+eFAcEwpQor6wTBpoHUKu+iwMdwXFwqdw/pw1KPYgjaGA0AoSRmzUdd9Jg5QKugclTwyS5Uyq5FeHmroOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189634; c=relaxed/simple;
	bh=+rUXdlHEyy7kwyMtKRB+ZWoUZ9vj9Z0ixiPDttmOnyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIaywyqwR05u/ZFYIlTLeCeqn5Aac1Y1+RhaMLjLw6XWtJuFbdlk7nrUjYGSEG7CrCDSb+wjOnKtaQJDpCehfJmcuMrhW3OxwSE1l9jz0CB5v2vUkz1eT5UshbICcY7ZSzJhh5kfJf/9Yi5FKpwXClJTsfmyIKfAiuvttjKeqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5gJeJqH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189632; x=1746725632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+rUXdlHEyy7kwyMtKRB+ZWoUZ9vj9Z0ixiPDttmOnyM=;
  b=a5gJeJqH9kx+9WTfT/TPbloOgbaeDwtjiwGMU/dqQXwtSezGVxBlsJAj
   VslD8YViCcw1a/Be8L4xyqk5W4kttukp+P1RpGZxD7ipkLUjHIHuASd9j
   PeJjZICOnGuAyydYuehmRIAnH8qm+GRjcjyIpyjzzS+4RY3Uph7vm+bZx
   vQHzxXvFsgzrPUbS4JmYynxDGSPHVpIrDlgkfQaC6D5q0nhQRTPxd02Q6
   BXfGEQbHpYqps0km/BfWnE2rJL2QgdHRXcujZv3KyRSJxNWN63lvrBAtQ
   3Yej7BA+1iaeTGj9xYBgdD5bg4veHsuu0EbNsSwZ0ojzR6awMdpZ2cB0r
   A==;
X-CSE-ConnectionGUID: n7G/LxQHRwygxGkDXuG/kQ==
X-CSE-MsgGUID: VPZDrFJvRDmQh3OckSziBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938939"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938939"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:51 -0700
X-CSE-ConnectionGUID: DSWI0EOwSlu2hFOmLxJRVQ==
X-CSE-MsgGUID: z4Bmr4IMTXmLOcb1DafYQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843707"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 10:33:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 1/7] i40e: flower: validate control flags
Date: Wed,  8 May 2024 10:33:33 -0700
Message-ID: <20240508173342.2760994-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
References: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

This driver currently doesn't support any control flags.

Use flow_rule_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 143e37ae88ef..1f188c052828 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8671,6 +8671,10 @@ static int i40e_parse_cls_flower(struct i40e_vsi *vsi,
 
 		flow_rule_match_control(rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
-- 
2.41.0


