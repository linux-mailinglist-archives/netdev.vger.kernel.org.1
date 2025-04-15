Return-Path: <netdev+bounces-183014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF27A8AB01
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D20190193A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9472749D7;
	Tue, 15 Apr 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7UGW+C3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB022686F;
	Tue, 15 Apr 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755191; cv=none; b=NjMFbVBu5DN/b4V5LHzH4f1/ySTa5d5pLAfhs/Br1pGBjqe0NW5SJqc8DnvA0TCjCVe6cGONq1a6MdxJheuOkINDHyXRk1xQI/m/bIfq0rGsdLYgYOdmPMoFQVgwQBagdriJehKWGpPz5c9nS8eUmM49nvYTd1zAkEq9b0CjNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755191; c=relaxed/simple;
	bh=VYvPCNsZaadYB1Z5mQ9xM9QJuSv4gfHhIC2AxjA4/0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3yuzHHEDX8l2yuXTE8G6Ywt7RA0IMh8FYpZkneK3NL/uBFqbSWvyue4WxF1YhrRR8jTLsF498mKy5gyEx6HlXsRkZ9TUL15+26LWy+t3fG7CUSdfLe25YGCWCf13OTO8asq6iZR9tpveOMg4hVfJ+rSZwWNGxIUSQryzjW3Ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7UGW+C3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744755189; x=1776291189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYvPCNsZaadYB1Z5mQ9xM9QJuSv4gfHhIC2AxjA4/0g=;
  b=F7UGW+C3DFdLy7reEjUwXj4fB9rPuRYJIvHRF8RT4Xvpp+6FUGLzxtIy
   S1VIUo85JgX3X5aeRMBlWRCpUpLOVgLT5nmmJFchzqmDKotM68zabypoX
   8CJc/0XBAprLkkFbowXIZbdS7xpyqTLy4duqm3RGmQZUP38YQXvdL5XN5
   /VxueywdqAXy54wPiEOTOyXGRbpCnXrUtoEqO2d+usDGha5AN2MWSiHWK
   D1AzanHcVHkKwAJFKFup2vFsPhsiwxZjr+XBPTUuZg+F9LgaKWR0kr+bL
   EVphFmROAMsuqDLDkDT96ZpjzQ20Us31kqKC4B74YDedR05fz/4ikNud/
   w==;
X-CSE-ConnectionGUID: fiI54WfmRM2hlytMXbBCRw==
X-CSE-MsgGUID: vOzfic4RRVixYamGz2VsKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46206596"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46206596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 15:13:07 -0700
X-CSE-ConnectionGUID: 85HPByulRWGJe4bPcGhRnQ==
X-CSE-MsgGUID: oDIOHOh3Qo+3ueiSLm083g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="131218523"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 Apr 2025 15:13:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	shannon.nelson@amd.com,
	ecree.xilinx@gmail.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next v2 01/15] devlink: add value check to devlink_info_version_put()
Date: Tue, 15 Apr 2025 15:12:44 -0700
Message-ID: <20250415221301.1633933-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415221301.1633933-1-anthony.l.nguyen@intel.com>
References: <20250415221301.1633933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Prevent from proceeding if there's nothing to print.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 net/devlink/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index d6e3db300acb..02602704bdea 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -775,7 +775,7 @@ static int devlink_info_version_put(struct devlink_info_req *req, int attr,
 		req->version_cb(version_name, version_type,
 				req->version_cb_priv);
 
-	if (!req->msg)
+	if (!req->msg || !*version_value)
 		return 0;
 
 	nest = nla_nest_start_noflag(req->msg, attr);
-- 
2.47.1


