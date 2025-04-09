Return-Path: <netdev+bounces-180936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FAA832DB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 22:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FE08A0760
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7A202C39;
	Wed,  9 Apr 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBjR5w/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186B1E520F
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232232; cv=none; b=DGCR7OVn6kDQ9pQUYD8hxdLwn7asEbq6RMjHrwWaYgKj6eaYv+QyS+0AlQVVFpq7/mhPt/7rm8jGKXz3xTYMYR0MjM5pj8A4urVxEP4eMrKQ0sUvMQpH90oJVC1kuUCgAX79yopSKxqKQv3k/67aix+K+r0Ucu4fFQHn3veopeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232232; c=relaxed/simple;
	bh=NCFwEvRWd8RhKMXrRod3jP44gTOZyUL6jE+zGFld6X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGPKia74pzMO5I5d8hjEIEwins+1m5BydQtQGZpy7FE8GSNSPgpsSz0stVq30Vo685OwGTkwepBt+eTERBAUtywst8ZWzE7IFkW7pwMVycYtGA9jq2lHnCGzEtNgUo+ALuSrfKVU5+ddf4uhkIeY8PEbqAYlVipCn7SCgzatY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBjR5w/Q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744232230; x=1775768230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NCFwEvRWd8RhKMXrRod3jP44gTOZyUL6jE+zGFld6X8=;
  b=BBjR5w/QhYx8jA7SsMkxBkUJXlsI+dXAERthWaqYWG69zxsjCNSJzdOO
   oVzBJXLF+IWRjK+n3WnTB1fsal3W4JWJHFi+/Lq51nzjd0qEjsF6PEEqb
   WnkoesOWPZBUl6CVvylyanT104Bo9U6cuwGffguKHM29nVdBnISC5T/LJ
   KYQAx8yzindf88VG/BOhU/NFd/sXB3ONXvXm+xeyEwkWvHUjLN6To8IRr
   5zj9mPzT9h1QK8mNWSB0GjXNed6A91KNyOzx4SdtH5/W4WpwlgfpPRVhw
   3ZcL30NbmlOmK2Fu5v/f0x7wK9c/GCszja/ddl5jxiybUFHEaIPgMH4Dg
   Q==;
X-CSE-ConnectionGUID: DBoJHhasQzKED27FApDq5Q==
X-CSE-MsgGUID: i9QjxlDnSPO0V9WwonQa5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56711253"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56711253"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 13:57:09 -0700
X-CSE-ConnectionGUID: Hp/p/5MMQO+ob42GLY1nSA==
X-CSE-MsgGUID: bQWsjAM4RsGC7eEeEMIf6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133422964"
Received: from kcaccard-desk.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.223])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 13:57:03 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	ahmed.zaki@intel.com,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	willemb@google.com
Subject: [PATCH iwl-next v3 0/3] idpf: add flow steering support 
Date: Wed,  9 Apr 2025 14:56:52 -0600
Message-ID: <20250409205655.1039865-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic flow steering. For now, we support IPv4 and TCP/UDP only.

Patch 1 renames "enum virtchnl2_cap_rss" to a more generic "enum 
virtchnl2_flow_types" that can be used with RSS and flow steering.

Patch 2 adds the required flow steering virtchnl2 OP codes and patch 3
adds the required flow steering ethtool ntuple ops to the idpf driver.
---
v3: - Fix sparse errors in patch 3 (Tony).

v2: - https://lore.kernel.org/netdev/20250407191017.944214-1-ahmed.zaki@intel.com/
    - Rename "enum virtchnl2_cap_rss" to virtchnl2_flow_types in
      a separate patch (Patch 1).
    - Change comments of freed BIT(6, 13) in patch 2 (Tony).
    - Remove extra lines before VIRTCHNL2_CHECK_STRUCT_LEN (this makes
      checkpatch complaints, but Tony believes this is preferred.
    - Expand commit of patch 3 (Sridhar).
    - Fix lkp build error (patch 3).
    - Move 'include "idpf_virtchnl.h"' from idpf.h to idpf_ethtool.c
      (patch 3) (Olek).
    - Expand the cover letter text (Olek).
    - Fix kdocs warnings.

v1:
    - https://lore.kernel.org/netdev/20250324134939.253647-1-ahmed.zaki@intel.com/

Ahmed Zaki (2):
  virtchnl2: rename enum virtchnl2_cap_rss
  idpf: add flow steering support

Sudheer Mogilappagari (1):
  virtchnl2: add flow steering support

 drivers/net/ethernet/intel/idpf/idpf.h        |  33 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 298 +++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   5 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 120 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 249 +++++++++++++--
 6 files changed, 665 insertions(+), 46 deletions(-)

-- 
2.43.0


