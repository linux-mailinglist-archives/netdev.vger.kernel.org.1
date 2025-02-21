Return-Path: <netdev+bounces-168527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921DA3F3C4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D4019C1401
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FD20B218;
	Fri, 21 Feb 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLgb1Mky"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54693D994
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139512; cv=none; b=qvahZIQFVVxPnGoCAgyEc+tDaOAxfsbSDlg2QMVhOANHnHsz0lEAH8XZ4x7ljQ95KkqTBqeVonSBbCe3bVk0D00N79ot5lNUACNoalTud7bQSTDexDxcPoznE6WHcMFSNAxjTLiX2rSOcKlqjTPcc7aObSVPhwrc820hTZ0q3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139512; c=relaxed/simple;
	bh=hJhmGrRCE4BroX1OnJa+3A/+mjS9ayraqChALrdsUIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxsyeDl8FCL9SHoTd5zeKlnaUCFawSpC0NNKXseZMaV04IG79GTg+8nbcyu27aos7wLhz8g1Bk710Lj+cDa+ZiAWzMyJeUZLHGKT8WwtBLxAw9LuUwapMLdEM80txS1bWOqJn8IDHVFvBsiU3E4O+eSsAMRlobJ78IO71AhZ2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLgb1Mky; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740139511; x=1771675511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJhmGrRCE4BroX1OnJa+3A/+mjS9ayraqChALrdsUIo=;
  b=MLgb1MkyYtlrS1ChM1Q7b716iaVoCRUrtpURN8+4av/RJpB5xGOwGnWL
   TV5H/VisPNTR4/dT8qWlLjSH04Hpi92w8/1JeBN9r18cFsILeNViobzbL
   j/2JXrqqmpsS+yY5owVDDr3+ZY/pSGdES4LA/a/SiQROsoPgeJYGYxKy8
   EdCOdn08DD9OF7RLiCDTYGm7xm6fRnk9487KRkbT5cWtLmOt8mcDVkMLo
   +AH2f1lJJBcqGm7r5km10ooDCA+tkg3sdVootWg7KXuZNsS39SerCEvQe
   IAOMTr4yhaikhXTRqLuWloBkD0ry5QmGc7smgDKPcRDLfucB0x2byuv5n
   w==;
X-CSE-ConnectionGUID: Gys2GuqFSQu97B4OWBcCJA==
X-CSE-MsgGUID: SDr8EMfeTbigQFpB1W8gTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51598923"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51598923"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:05:10 -0800
X-CSE-ConnectionGUID: dbRgF8VaT2uMSof7HbhPpg==
X-CSE-MsgGUID: 4Q8BSlwtQDC4Cjexq+lBGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116260295"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 21 Feb 2025 04:05:08 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiri@nvidia.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v5 01/15] devlink: add value check to devlink_info_version_put()
Date: Fri, 21 Feb 2025 12:51:02 +0100
Message-Id: <20250221115116.169158-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
References: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent from proceeding if there's nothing to print.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
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
2.31.1


