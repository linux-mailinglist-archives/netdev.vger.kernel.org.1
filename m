Return-Path: <netdev+bounces-56597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409B80F874
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6411F211A0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211065A6C;
	Tue, 12 Dec 2023 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXtd3dHq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0899910EF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702414217; x=1733950217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YVYHoXCnk3auriUU90EN0qBQSejq+uGK5jENimuGkyU=;
  b=PXtd3dHqVPDNUb9cKQqujrCCGelBjEI7Ie8LrQr7K9UDAMR5AmgIKBuC
   xwatCwrH2/vsET6//L2AwcAu29LmiWXY/ffq6gjaTf22U6AyuxcWbFXqD
   Q2Sj22bc9wnwZ/czyVC/nQo1xNQmpWY8pqaPSBeZfpZ+ska+PDlnQ/A8Z
   Qta08fq6oY2Fe6tf8IOBQR2HdSpRzOW8HiMP6J0rlgbwYtIu/a4vPvJVw
   e1eXXvmJRlAGpW0SzTUgzpN3cIkYAHgAIzMuuW050EjJaF5bIm8I1Ge4x
   6dLWCGPFfp6ery70Kj00QDdbLf+dN559DihGTSx/k/Q+AWTTIKi79fm4F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1942375"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1942375"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105044025"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1105044025"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 12:49:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates 2023-12-12 (igb, e1000e)
Date: Tue, 12 Dec 2023 12:49:42 -0800
Message-ID: <20231212204947.513563-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains updates to igb and e1000e drivers.

Ilpo Järvinen does some cleanups to both drivers: utilizing FIELD_GET()
helpers and using standard kernel defines over driver created ones.

The following are changes since commit 609c767f2c5505f104ed6bbb3554158131913f86:
  Merge branch 'net-dsa-realtek-two-rtl8366rb-fixes'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Ilpo Järvinen (3):
  igb: Use FIELD_GET() to extract Link Width
  e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom
    defines/code
  e1000e: Use pcie_capability_read_word() for reading LNKSTA

 drivers/net/ethernet/intel/e1000e/defines.h |  3 ---
 drivers/net/ethernet/intel/e1000e/mac.c     | 18 ++++++++----------
 drivers/net/ethernet/intel/igb/e1000_mac.c  |  6 +++---
 3 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.41.0


