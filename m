Return-Path: <netdev+bounces-136945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3E9A3B5B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B642854A6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3B202F8B;
	Fri, 18 Oct 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AihPVWLu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8F202F70
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246839; cv=none; b=VzbsC/oQWFLMlZBhSMPIfrZv+Eje3YsJ0ybQSR5VDE+bLGt5njtASzxfg9fc4IlPkp70EEZcZjX6ZpTUtRsboaLqITl3qLxyes9Riozu6bmAPUREoKZAEJGvsMntwx0iluwNB8c44RqmL0UJr3fBqbQj5n1PfHUhno7r+CNS6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246839; c=relaxed/simple;
	bh=nMPjOOSaoGe4vadY3FHtlMl/7Cuyeh9Dg4UPbcKc/C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdzpdGrY9Fdh9t/tAfSssD5TnDkjIqbJXbAevaKMVrxQvEPh48x6gtce1HnXlObwScnvhSIZj4G7lQqzwKbKjOJMs64B1gLILh1hOi+UooOdmFX+eVWOclTP7TkBtNOO0ATOWHR3Pe3zSRrvbUrCHuJGjJjG7cTfhfL7TtcphUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AihPVWLu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246838; x=1760782838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nMPjOOSaoGe4vadY3FHtlMl/7Cuyeh9Dg4UPbcKc/C8=;
  b=AihPVWLuYf2VrUB3bhYpOYmxp1cv0rr3/ewfxo/4911rr8zAJaS0MaAV
   377mNcs9mRrp/R0kf8935cBW22oAsGmlOG8KtWoQE6chok8C5kzQMt1Bh
   gmXBJIFLr12QjY0CVUYd7RvTtvf8/EpvE3yr/EC0WqlrO0wxQJW96VpnK
   VLV1VSRFw6OOTKmQUBtZ3iuBYk7cl8NwSnmmUIdU+wnrUFGUdzsrlMA78
   mwpv+DJ/EJ6ZKVnd/E8p7uZKCmRMecviPPgoEFNCiWx4OExAhR+ByNvMf
   dTAKRPioxJAuMkRj6p6F41m2M3LC+4yMsuLZqFrnsAnPxK962EfGsqJdp
   Q==;
X-CSE-ConnectionGUID: 2gz3KAUWRLqf0bMq95wpFQ==
X-CSE-MsgGUID: EHtarxAHRIaMk93pZwqeWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401228"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401228"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:37 -0700
X-CSE-ConnectionGUID: qN45RSLsQiiM1y++k6Ttjw==
X-CSE-MsgGUID: ZhQ6RkgmSlyP6F+WdPNaGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789317"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:35 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0A1C627BCC;
	Fri, 18 Oct 2024 11:20:32 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH v1 3/7] devlink: devl_resource_register(): differentiate error codes
Date: Fri, 18 Oct 2024 12:18:32 +0200
Message-ID: <20241018102009.10124-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differentiate error codes of devl_resource_register().

Replace one of -EINVAL exit paths by -EEXIST. This should aid developers
introducing new resources and registering them in the wrong order.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 5ce05e94f484..96c0ff24b65a 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -345,7 +345,7 @@ int devl_resource_register(struct devlink *devlink,
 
 	resource = devlink_resource_find(devlink, NULL, resource_id);
 	if (resource)
-		return -EINVAL;
+		return -EEXIST;
 
 	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
 	if (!resource)
-- 
2.46.0


