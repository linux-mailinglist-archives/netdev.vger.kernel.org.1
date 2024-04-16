Return-Path: <netdev+bounces-88468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C9E8A757D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C892DB216D2
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79DE13A25E;
	Tue, 16 Apr 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msG8u9va"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB67139D0B
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299056; cv=none; b=aerzs3oBZdxcPQ0f9RzJ0cLKvpODB1U/BnEIw3e/RzbrNOf9f4D39H3aYlqecH9TyUnh78+eYrhEbKftLMlmlvFLzE3HwDCNTbFYGehGn3+yDyxGYzFLpyfZ0PHBco31vJBA/rKjrtCa3nskP0E6Wmdmy5oPqA1rOvZAVO7/gsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299056; c=relaxed/simple;
	bh=Lkxs2jxpSfMnw9Ng6K/i7PiLVRbb/QQuS25pSxsWvpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DozrbrMHE+WAX65oguUCPDtsZSUPg56RDqvwwbOr7HNipkA6PAll3KdT76Q5Z6zTmtLNIjY7OXCzpoPBV34/C3HaoCb6pN/bZl+ZB5CT0nV5i+aIM5VhoTqeTSfwbrojxnCcehO77LT98mf2RS2jM+YclMhuCx6Z/yXvsqmTdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msG8u9va; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713299055; x=1744835055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lkxs2jxpSfMnw9Ng6K/i7PiLVRbb/QQuS25pSxsWvpE=;
  b=msG8u9vavKqysLC9My1AOCiOKg0XHx0AT16HzOzWi1b54l2PEvGKXrxV
   TH1CbKXBVOWJWiZJvTAiRHO5/JH4LGwSb3AHit4CbbV4TmxHdV//J7DDi
   3xpKjeu2ShwAdE0FNSZoud9L2LYyNI1wXlrQgikGIJkCvierP5UG6sN8s
   34w6o+M0oe3KoCxE0Kaet79R+Lwid6W81aCa7U+SjLXMbenT62Ke8NeL4
   rLCTKQdHqHh81kQwqPByS7WdLv8x1NAeKtP2gHXcNuSJaEw7RsGv3J0R8
   ccpZph9ySsWeGwwoMTn0Kv78Qkx5UbVW0O64ZtlUI1WjJ7H8GEfrPICMo
   A==;
X-CSE-ConnectionGUID: RjUHaTiRRGSdJQpX4QkD+w==
X-CSE-MsgGUID: ODt4xIn3RaKC1qSMKoZhdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8688457"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8688457"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:24:13 -0700
X-CSE-ConnectionGUID: pAnU5b93Q5CYJSP9hfNFoQ==
X-CSE-MsgGUID: iIEJi3khTzy1X24744X/yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26941875"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 16 Apr 2024 13:24:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 2/3] ice: tc: allow zero flags in parsing tc flower
Date: Tue, 16 Apr 2024 13:24:07 -0700
Message-ID: <20240416202409.2008383-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
References: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The check for flags is done to not pass empty lookups to adding switch
rule functions. Since metadata is always added to lookups there is no
need to check against the flag.

It is also fixing the problem with such rule:
$ tc filter add dev gtp_dev ingress protocol ip prio 0 flower \
	enc_dst_port 2123 action drop
Switch block in case of GTP can't parse the destination port, because it
should always be set to GTP specific value. The same with ethertype. The
result is that there is no other matching criteria than GTP tunnel. In
this case flags is 0, rule can't be added only because of defensive
check against flags.

Fixes: 9a225f81f540 ("ice: Support GTP-U and GTP-C offload in switchdev")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 49ed5fd7db10..bcbcfc67e560 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -779,7 +779,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	int ret;
 	int i;
 
-	if (!flags || (flags & ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT)) {
+	if (flags & ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported encap field(s)");
 		return -EOPNOTSUPP;
 	}
-- 
2.41.0


