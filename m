Return-Path: <netdev+bounces-60313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93781E8BE
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 18:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71B11C20F13
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED874F88A;
	Tue, 26 Dec 2023 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/pKH5cI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A294CB59
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703612495; x=1735148495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wUTKbKKmW41tZu4WRzZA4icf6MiHJA23L7ijnJBoU4o=;
  b=P/pKH5cIB3m/pG/OiUH4L8m5dcdWjJcpN87EBIVfHhQqoZuTdRIr6baB
   1QsQHcxuQ87GZnytJzIW/4ZwcM87yvNJS20Wvma57yUblyqEX0lHuNlk2
   ofuVktoarGIYHPPl8sLPjdQ2jrMw2JWLvJuMCXK9RhDLKsl6+C7Gxf2Gd
   HKAMVuPlI2UIfQgajrIsAx2Bqsqvq7VK1Qka9sG/87GAyLA3Mis3utvw5
   l3Mps3hhLU+ouRw35kvyEu48Fg02xi7/w5rtavnPN1YmAeW8grGsiTUOj
   ev1QPX9BHk39DkLqMbU12+aE5uAoU0hIh6ugbAudHpP0XQg0izO6Jr/Ta
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="396099061"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="396099061"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 09:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="868638782"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="868638782"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2023 09:41:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2023-12-26 (idpf)
Date: Tue, 26 Dec 2023 09:41:22 -0800
Message-ID: <20231226174125.2632875-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to idpf driver only.

Alexander resolves issues in singleq mode to prevent corrupted frames
and leaking skbs.

Pavan prevents extra padding on RSS struct causing load failure due to
unexpected size.

The following are changes since commit dff90e4a092b771354287fbe55e557467c9da620:
  Merge branch 'nfc-refcounting'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Alexander Lobakin (1):
  idpf: fix corrupted frames and skb leaks in singleq mode

Pavan Kumar Linga (1):
  idpf: avoid compiler introduced padding in virtchnl2_rss_key struct

 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 1 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 2 +-
 drivers/net/ethernet/intel/idpf/virtchnl2.h         | 6 +++---
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.41.0


