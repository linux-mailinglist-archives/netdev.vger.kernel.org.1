Return-Path: <netdev+bounces-223693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1EB5A130
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3352A7C0A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDF32DCC05;
	Tue, 16 Sep 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewqBVhYB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7A7E0E8;
	Tue, 16 Sep 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050216; cv=none; b=rr3IMtiRb/IhJkVxuU7vtgSLpE0Yok/OESzbg0oUdwoMPpf8/LwLXugtuuFr89fIui0o7cU5JiPXA4xAy3NEK11hdDv68qoE+JDDIHYi3Q2zojNkSsQGntZEjdP9dhNkIhb9HXSSy9D2FA3WWF90k52KFDTf4W+neitAnw091wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050216; c=relaxed/simple;
	bh=U5LicZk3zOH+cfVm8UiDiYn2gNrNlZZkTJ30LuKTw3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Im/b0KP/gSXtarMrGgBo6L0qkPEJ9mtUiLeFO66fieRR0mVgvx2DTTk9WDehI33RVYAqpYYCYJTxUMQMAde2T0ip28owY//t+2WF1oYE4FHFeKR22q6UoiqJyOMTa7y+9cthmtf3ffQpi5g4Ufhgze//AVRMbceIzmi+JNIU0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewqBVhYB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758050215; x=1789586215;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=U5LicZk3zOH+cfVm8UiDiYn2gNrNlZZkTJ30LuKTw3c=;
  b=ewqBVhYBp9hLQyyTB0Hll+vJbOTrkPEaullwGybQDCLBSZM1h3rx9BwS
   WvB/D9RRY7xvmcfJvJZF/Heu3CCiKKPXSu8O/4uHTJBYSZNBVgdG8XfvY
   cwnHAlbtVawwqjnAqD5PD/pmBwQoEPnDOBgg1JoOiYj/ose5QdC4xNhI8
   LqkXPrUuVfxGZxyY3NsCOqoouykyopcAAqB0syEL9ge6UbFSxLLzXeCuq
   UJCPbOqgahK9Yv98A4SULHB84lconnndQjQCZNN1Tw3wonNb2dUh18/qk
   rVgfVTtZvunS1JINcTfX5x4cex5KX3Ernc/koHSCxVgxi32qZMFvo7dpX
   Q==;
X-CSE-ConnectionGUID: w1bJyIOzSrK7LrEpBT+vcw==
X-CSE-MsgGUID: THIUZuE6THut1JBzRkDnhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60037575"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60037575"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:54 -0700
X-CSE-ConnectionGUID: 6n+vR93nSqCTUNP7tKLnRw==
X-CSE-MsgGUID: J18ZnI/HQ1O3fJFO1fJTAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174961755"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Sep 2025 12:14:54 -0700
Subject: [PATCH iwl-next v4 1/5] net: docs: add missing features that can
 have stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-resend-jbrandeb-ice-standard-stats-v4-1-ec198614c738@intel.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=tgbQu2OqsM4wvoaJ2Ac7Pu7HlNzbap0vQ4hGe758rUM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyT2xfbrSpT5zhu5a/0JWHqvtk2sV6eCayXUrfY3Vn6M
 r9qjtO/jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaSVsjIsHtekb7solp18/j5
 izKMWyTj6jwElhZdDrq7wujfJe2nuQz/w1ef9FZLjgzQsfayyGR60qqeuF5Ablac6eu/Wz5ZGcq
 yAQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

While trying to figure out ethtool -I | --include-statistics, I noticed
some docs got missed when implementing commit 0e9c127729be ("ethtool:
add interface to read Tx hardware timestamping statistics").

Fix up the docs to match the kernel code, and while there, sort them in
alphabetical order.

Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/statistics.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 518284e287b0..66b0ef941457 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -184,9 +184,11 @@ Protocol-related statistics can be requested in get commands by setting
 the `ETHTOOL_FLAG_STATS` flag in `ETHTOOL_A_HEADER_FLAGS`. Currently
 statistics are supported in the following commands:
 
-  - `ETHTOOL_MSG_PAUSE_GET`
   - `ETHTOOL_MSG_FEC_GET`
+  - `ETHTOOL_MSG_LINKSTATE_GET`
   - `ETHTOOL_MSG_MM_GET`
+  - `ETHTOOL_MSG_PAUSE_GET`
+  - `ETHTOOL_MSG_TSINFO_GET`
 
 debugfs
 -------

-- 
2.51.0.rc1.197.g6d975e95c9d7


