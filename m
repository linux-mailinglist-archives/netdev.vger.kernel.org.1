Return-Path: <netdev+bounces-100772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535398FBE9E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E808D1F23C43
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFD14D2B9;
	Tue,  4 Jun 2024 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpUusI+/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5414D28E;
	Tue,  4 Jun 2024 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539220; cv=none; b=hy9X/E0PneOCCfSgKYMP+CG10TjZUZssDQJ6DFdGfO2qO9ybN80vJJrS67f2yUybeZ5LM04fBVz3ldoCvd7ZcDzakSKmzgt9tF5ddYdFb8Fu2UeqJTxl9ZLlPkXMlXjWmtlgl8ogyGDV18WHrAucCEBgBruQXJedyOyU8Vcj0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539220; c=relaxed/simple;
	bh=NH0e1gv30FCCZJHwSEekSafzctrL119woZPwilJfxY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuDvhxR5FxhFVjuTltA4yCiGxXWAJ+773tcvo2R0y1B5ETmzp0RRHcTGoE3hzSROHECOfO1hVIjgohw0yeE1bN4Mw/meIPUH16XuHlruZ0oAsROEhipQCv5hQ3kIy85rKOAQ1m8JPRV8UgiY18Wflc/JriexAq3RfS6mYYpo2/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpUusI+/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717539219; x=1749075219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NH0e1gv30FCCZJHwSEekSafzctrL119woZPwilJfxY8=;
  b=VpUusI+/q3k1DAP3CM0NkGebER50PkejQflocEuhLrp17O0Bz81i05TI
   uWqUzztQQl928C6LYbe2yHZ+L4nW5mDJPCgxellsEfnhFhcK/+LEIoFFa
   w4KAsAeLGkxNarxdOUjMBVEd1ZJe6gW0pnnjXtXZTsc3soIRhG7TGOieE
   nxq1dfMC0cfVomULntrxTkIPk5byweRTkFsnHm3eqDjAq1GNomnhnBAXc
   S04hvqUw6H771aT/gWpXBNqL7l72yBn40mt4sP8yBZ65FbL4AUmj9JDZM
   DeS0CKa2vJOO6VMnapB2KXcYRzLKJrSLfpOXcSvQFJuXj+J6Bh0W9F3QV
   Q==;
X-CSE-ConnectionGUID: dBAJcf5kRoS7geVz6KRmRQ==
X-CSE-MsgGUID: +7y6u/KyQbGpOsfmA10TSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36635254"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="36635254"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:33 -0700
X-CSE-ConnectionGUID: kKp/BzTuQsaTHfbLTqH4WA==
X-CSE-MsgGUID: WiCz+YyNQ2++ZuhmAYwhZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37503235"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:32 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v1 1/5] net: docs: add missing features that can have stats
Date: Tue,  4 Jun 2024 15:13:21 -0700
Message-ID: <20240604221327.299184-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604221327.299184-1-jesse.brandeburg@intel.com>
References: <20240604221327.299184-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to figure out ethtool -I | --include-statistics, I noticed
some docs got missed when implementing commit 0e9c127729be ("ethtool:
add interface to read Tx hardware timestamping statistics").

Fix up the docs to match the kernel code, and while there, sort them in
alphabetical order.

Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
I didn't add a Fixes: tag because this is not an urgent kind of fix that
should require backports.
---
 Documentation/networking/statistics.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 75e017dfa825..22503a90e369 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -184,9 +184,11 @@ Protocol-related statistics can be requested in get commands by setting
 the `ETHTOOL_FLAG_STATS` flag in `ETHTOOL_A_HEADER_FLAGS`. Currently
 statistics are supported in the following commands:
 
-  - `ETHTOOL_MSG_PAUSE_GET`
   - `ETHTOOL_MSG_FEC_GET`
+  - 'ETHTOOL_MSG_LINKSTATE_GET'
   - `ETHTOOL_MSG_MM_GET`
+  - `ETHTOOL_MSG_PAUSE_GET`
+  - 'ETHTOOL_MSG_TSINFO_GET'
 
 debugfs
 -------
-- 
2.43.0


