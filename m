Return-Path: <netdev+bounces-56743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E0810B11
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A4B20DC7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49489168BE;
	Wed, 13 Dec 2023 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isnW75bA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193DAC;
	Tue, 12 Dec 2023 23:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702451481; x=1733987481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cF3pfJnlA+5G4OWOtCtXAGT41ADIKzwDy0yN6nIsYG8=;
  b=isnW75bAuOFVs2/vQ0KSrNN29mQy1QGOenE1HgUu5bduxRZ3z9gE7mgE
   azKZoD2LXu/HCpF5vk1+W7ZmsOHLKJQRGmjzysM+TEl62Vk8xH3PJAywY
   lZ0u/YUVfuL92wCsPnK+FscWl6lye2R156Yo+bU59Dz0BPig79YUhAU3D
   3br7q2MXNzWykNs6BRQDX7qIe7mNzxoxAqrm4FgV9mz3TZ9xW/yHByvQk
   x4kjfhOVdkPWnvrnutpCGougjH+o3YHQT6HT+jYliI5rfRwiIkVQypddQ
   xKYXIdkbFvJQSBjVi0lRYkLZKpWqLnm8xrqcl/9N/evNAhmsiZiWDJ44d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481126085"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481126085"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767109178"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="767109178"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2023 23:11:18 -0800
From: <deepakx.nagaraju@intel.com>
To: joyce.ooi@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Subject: [PATCH 0/5] Rename functions and their prototypes and move to common files.
Date: Wed, 13 Dec 2023 15:11:07 +0800
Message-Id: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Hi,
Moving the standard DMA interface for SGDMA and MSGDMA and renaming from
tse_private to dma_private. Moving read-write function prototypes from
altera_tse.h to altera_utils.h. Commonize DMA for upcoming altera Drivers.

Patch1: Removing unneeded assignments.
Patch2: Fixing indentation warnings.
Patch3: Moving read write Function prototypes.
Patch4: Sorting headers in alphabetical order.
Patch5: Renaming function prototypes.

Nagaraju DeepakX (5):
  net: ethernet: altera: remove unneeded assignments
  net: ethernet: altera: fix indentation warnings
  net: ethernet: altera: move read write functions
  net: ethernet: altera: sorting headers in alphabetical order
  net: ethernet: altera: rename functions and their prototypes

 drivers/net/ethernet/altera/Makefile          |   5 +-
 drivers/net/ethernet/altera/altera_eth_dma.c  |  58 ++++
 drivers/net/ethernet/altera/altera_eth_dma.h  | 121 +++++++++
 drivers/net/ethernet/altera/altera_msgdma.c   |  38 +--
 drivers/net/ethernet/altera/altera_msgdma.h   |  28 +-
 drivers/net/ethernet/altera/altera_sgdma.c    | 138 +++++-----
 drivers/net/ethernet/altera/altera_sgdma.h    |  30 +--
 drivers/net/ethernet/altera/altera_tse.h      |  71 +----
 .../net/ethernet/altera/altera_tse_ethtool.c  |   2 +
 drivers/net/ethernet/altera/altera_tse_main.c | 251 +++++++-----------
 drivers/net/ethernet/altera/altera_utils.c    |   1 +
 drivers/net/ethernet/altera/altera_utils.h    |  43 +++
 12 files changed, 447 insertions(+), 339 deletions(-)
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.c
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.h

--
2.26.2


