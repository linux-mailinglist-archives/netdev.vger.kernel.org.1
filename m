Return-Path: <netdev+bounces-199708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5180AAE188D
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD784A39B4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EA528B4FB;
	Fri, 20 Jun 2025 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y11UvJ8s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647E285051;
	Fri, 20 Jun 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413809; cv=none; b=dKps+UN9CuaLGgTbNFZ3NUpp8eYIkfNx5fuLOiCfbLALnrxrN9xKP3qTn2gQtZGhLvMlY5GO1pS6a3Ha0LB4TrH1WrVLCKdzK7Yh7GRNvc8U34DR0rQrHr7u1YmMX8wcDfidAiwfeQ8kWA1YujLkRq2mw17d7DOENdN5qub6gHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413809; c=relaxed/simple;
	bh=CQGVmG5DzyINqq9HjZaFAhV7/N9sszZHtO3uOlf8a+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/mPgSM5Ra7P/o2zo0BUBKfCELex01qjLB3sPsHTZC89iQy3kXNVSOTUvYt2pxBHQ5NFxiBDjW062CfiBa+RA60M7Bwc8tQBztKG2SzMYgTWb1vgNhEQ+kYtqOToMyoLpDgVIwgNTf8+Kcw9zMrJZX3f0s18XHAQr3xkIK55f6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y11UvJ8s; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750413807; x=1781949807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CQGVmG5DzyINqq9HjZaFAhV7/N9sszZHtO3uOlf8a+k=;
  b=Y11UvJ8sYIJLu5zHCjUU3tJz3beIUDDbc89F1DlCkCPp1/kBl9eXDkxV
   T9AdqJy5X5bsBoIxC6lJaQ5q8ZfG4oWo+yKkMkdjEXjGm2TgM+OA9wSOx
   I4aDvhdsrsus9eismWmjrW/qJinIH1K6cMp0avhjPnf6G2zzEe9pSsUxz
   81STFZH0dapvrylRgtiQDD2iIcUKhrtEQTEb9/Ni1V9Vr15BlDDFb/I0z
   WoI5bvJ573g7KIkNbuTS2cwQz6YwHey+RmBifU5Q+CVVlkEKy8r0zbxdi
   YOYk+wGq52ynxLxAZRNUAHhTE+HGbDF6lfJvu6eKfE/9PkkLA9stRRytz
   Q==;
X-CSE-ConnectionGUID: Ypwolvp5QJe5vBVaz3FKeg==
X-CSE-MsgGUID: zjCs9c/kRXiLe1fMp+w12g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52817095"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52817095"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 03:03:27 -0700
X-CSE-ConnectionGUID: MhaWDlu1QxqkL0qi3Zw4pw==
X-CSE-MsgGUID: Ce0XWxVtSoSksHuUAySBQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="181744791"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jun 2025 03:03:21 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Brett Creeley <bcreeley@amd.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next,v3 1/2] igc: Relocate RSS field definitions to igc_defines.h
Date: Fri, 20 Jun 2025 18:02:50 +0800
Message-Id: <20250620100251.2791202-2-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620100251.2791202-1-yoong.siang.song@intel.com>
References: <20250620100251.2791202-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the RSS field definitions related to IPv4 and IPv6 UDP from igc.h to
igc_defines.h to consolidate the RSS field definitions in a single header
file, improving code organization and maintainability.

This refactoring does not alter the functionality of the driver but
enhances the logical grouping of related constants

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         | 4 ----
 drivers/net/ethernet/intel/igc/igc_defines.h | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 1525ae25fd3e..0b35e593d5ee 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -406,10 +406,6 @@ extern char igc_driver_name[];
 #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
 
-#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
-#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
-#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
-
 /* RX-desc Write-Back format RSS Type's */
 enum igc_rss_type_num {
 	IGC_RSS_TYPE_NO_HASH		= 0,
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 86b346687196..d80254f2a278 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -383,11 +383,14 @@
 #define IGC_RXDEXT_STATERR_IPE		0x40000000
 #define IGC_RXDEXT_STATERR_RXE		0x80000000
 
+#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
 #define IGC_MRQC_RSS_FIELD_IPV4_TCP	0x00010000
 #define IGC_MRQC_RSS_FIELD_IPV4		0x00020000
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP_EX	0x00040000
 #define IGC_MRQC_RSS_FIELD_IPV6		0x00100000
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP	0x00200000
+#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
+#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
 
 /* Header split receive */
 #define IGC_RFCTL_IPV6_EX_DIS	0x00010000
-- 
2.34.1


