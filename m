Return-Path: <netdev+bounces-134276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B1998979
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C091F265C2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FCD1CB511;
	Thu, 10 Oct 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gn5/csBS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719B42A8C
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570193; cv=none; b=cGnnpizcIdrs4b0JtX8FQ8RHUowdMQdn1l0a6FN5yxhy2zWQwRQaY2NVA0lVpYPXTOLL3Q5QYB2H587clIQda5cz7JHombuJNbpDMIz5AGcU97Eigv6e7U8bdjeJF8e0poXsphAEwrXnYCBFLj07r4z8X4nHN/ZjbCThedyE5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570193; c=relaxed/simple;
	bh=0xZO2lp6VcDxW0Dou79Y4m8CjL7bQyqt7vDopJMgQRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqWmbci+LZe2KpL3mbgwYL7fopb2x1UsYw8mmlpSgFU5DiEtSYKU2njh75EiHYajcZGe0Ynv4nrEoxXMDylVL/uVgC9+K5cV+FoLEDqYSwxbihwQ1kiFH1qZy1ryoOqGuaAE0s8DesbOveSKjn/HQK1Ohr3G55NSxUswGCwE/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gn5/csBS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570192; x=1760106192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0xZO2lp6VcDxW0Dou79Y4m8CjL7bQyqt7vDopJMgQRU=;
  b=gn5/csBSW56WQt/2HZRj+Km3NKRpl5ZcCQ9De5oum2ISnkqBsByC560J
   d6esnj7hKCUt/ew7xinZNJL3t51xh36JYE6qut/pGspsnVHEBlK1IfW+K
   197bCkFG5TutPEhNl7jZtgGBSHMIG7/VtpsGA4dVuZ6UIb2qAtbSY/0vX
   0i0tgzED+vRho1B5NpMEYusibftaus3fPg4CzpaA9KLlB7zd+CplIm+Vv
   uRDZe81DqRY3ulQf7UiNcrQFq4JxjbAfr9lck9W2OiwsOG0NdwgQHZjBT
   wXz3gWixcZ4dksDXXNKdk47y3sFXWgmBdGHpGfXePgPVwu6xiyqhp2lZl
   w==;
X-CSE-ConnectionGUID: 0gqShKj+QFSzxUIIUMKCpQ==
X-CSE-MsgGUID: 6figM3d1Rl+bd563u3B1AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39321091"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="39321091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:23:11 -0700
X-CSE-ConnectionGUID: nUNLTj/3TmuvRdjbIxLgNw==
X-CSE-MsgGUID: /SrTfLOPSVWe1XlAEzNhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="99937486"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2024 07:23:09 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-net 0/4] Fix E825 initialization
Date: Thu, 10 Oct 2024 16:21:13 +0200
Message-ID: <20241010142254.2047150-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825 products have incorrect initialization procedure, which may lead to
initialization failures and register values.

Fix E825 products initialization by adding correct sync delay, checking
the PHY revision only for current PHY and adding proper destination
device when reading port/quad.

In addition, E825 uses PF ID for indexing per PF registers and as
a primary PHY lane number, which is incorrect.

Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 drivers/net/ethernet/intel/ice/ice_common.c   |  42 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  77 +----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 281 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  40 ++-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   7 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 10 files changed, 243 insertions(+), 240 deletions(-)

V1 -> V2: Removed net-next hunks from "ice: Fix E825 initialization",
          whole "ice: Remove unnecessary offset calculation for PF
          scoped registers" patch and fixed kdoc in "ice: Fix quad
          registers read on E825"

base-commit: ab8024f0207eec0f376591c958b5bd30a03ae370
-- 
2.46.2


