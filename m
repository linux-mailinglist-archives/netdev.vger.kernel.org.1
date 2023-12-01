Return-Path: <netdev+bounces-52799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F5800400
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A6E1C20E5F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B959542;
	Fri,  1 Dec 2023 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgDpfdgj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C9DE
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 22:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701412554; x=1732948554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ccV9n/QYxmvF9ocwoEezg0EWSufO2UE4fRwBUjAxZRI=;
  b=hgDpfdgj3xk+QY4nzaXEwBZ00C1jAdXEZ4wKL0Tos+YRdgSPyotnhpxr
   SNh6vQ8Agt9b43poq6gu53ThoptGlFp+m5F6177gFPxwtWk8l9pWZLlb/
   UpY4WZ+Wx8sowEdLXFQRnkURRfyi+uiuVd/kYiBisH51Zq/ZkYKtkDrD/
   uqPLIU44iubQhri0xGAsvTm7UQJI+q3UzycmkRs/zzsMQCEd+Js6EcDyg
   WLQAHX4OvaALwFMpsc6YloV4goMDlP6vzHkWzUy5mDP/w8M+CKKcAL5PV
   gJbzCMJ1WgnVXHdhoNeuq+xfJCB1LwP2PVQgVxmDmHA2kmiXjJAucwbUr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="424597671"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="424597671"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 22:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="860457970"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="860457970"
Received: from wp3.sh.intel.com ([10.240.108.102])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2023 22:35:52 -0800
From: Steven Zou <steven.zou@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com,
	andrii.staikov@intel.com,
	jan.sokolowski@intel.com,
	steven.zou@intel.com
Subject: [PATCH iwl-next 0/2] ice: Introduce switch recipe reusing
Date: Fri,  1 Dec 2023 14:25:00 +0800
Message-Id: <20231201062502.10099-1-steven.zou@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series firstly fix the bitmap casting issue in getting/mapping
recipe to profile association that is used in both legacy and recipe
reusing mode, then introduce switch recipe reusing feature as new E810
firmware supports the corresponding functionality. 

Steven Zou (2):
  ice: Refactor FW data type and fix bitmap casting issue
  ice: Add switch recipe reusing feature

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_lag.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 211 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 6 files changed, 197 insertions(+), 32 deletions(-)


base-commit: fce82d0f94e9c1ca953d950ebdb66c6c7f9d53f4
-- 
2.31.1


