Return-Path: <netdev+bounces-165526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD56A326FE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A24F3A640F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684E20E31C;
	Wed, 12 Feb 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwDudOBB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FE20E033
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366876; cv=none; b=C8bOiRDo3DSoh15On2vqHOFaDA4nYYv8ttC4oCOXIzQ9f7RmeITIh13NT70Jti4rIfJmLAQVx/nl5/R4g3ErvGNo00sMamV92ApxYXobs1ZZVmyRP7wF25VnB0PksoTXnxpiY+K15d7T50B3IZPvLTGkOX9JwObWKlMy7vo4Dug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366876; c=relaxed/simple;
	bh=ZGQPqIgzQ8u2dfuHYjkNeT/O3aLlbiigGyfdgXmOSMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xz46O9aGNMl4mX+g81+1RKpm5SbX6yiosD9mSnUuCDRXYOCkVMtBHiTbjO3HX+r+iUZgYuie5B1YT+APLPEw+C20JLyFVABFO+588PJwIxH7E3BDRSKmXW8367KbTlfDyWG2EKTR81H2u6lncV1mppXOcAMk9jpmDeBRYlmd6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwDudOBB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739366875; x=1770902875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZGQPqIgzQ8u2dfuHYjkNeT/O3aLlbiigGyfdgXmOSMI=;
  b=EwDudOBBxgljwPFG64DbaWKRde/kcddqfU+kwFi/L1AJzSDuw9g56vGj
   C1sCee1ur4T/B1ASjeSkI5AE8cEFufL8TAVnSw2Ip2Z65MW/2ngZUOVSk
   QHJPXMlwEaf1s144pKex/p650pwP4xgFLw39mgnGCBtLIQ1frls7BVK1o
   KqXW7W83g92z3KWqdpWF6u3HbhAoYRwy/6L5atqzXxfi5SEf6E1ynetEF
   Xu23hbHQqg7Uu2Xu3UwNYoc++r54RhPvkEMa7Y7B1Fyqd42PhbXFFr98N
   UZNFQ84lQjKcUPII3aUPHFhJZdTmGwLOeWPARleaDQU16Oozsf7L+9pld
   Q==;
X-CSE-ConnectionGUID: hVGPhMZUR8K606csaVkxpA==
X-CSE-MsgGUID: yl18rNyzTHeBYZnRlzZzDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50665518"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50665518"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:27:54 -0800
X-CSE-ConnectionGUID: CJQDOvjJSSOw1cveLufgWA==
X-CSE-MsgGUID: 0NNIpOj8RQWFkTVjxyqITg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="117830620"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa004.jf.intel.com with ESMTP; 12 Feb 2025 05:27:52 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 01/14] devlink: add value check to devlink_info_version_put()
Date: Wed, 12 Feb 2025 14:14:00 +0100
Message-Id: <20250212131413.91787-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
References: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent from proceeding if there's nothing to print.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
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


