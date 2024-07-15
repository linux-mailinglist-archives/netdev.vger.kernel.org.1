Return-Path: <netdev+bounces-111534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB59317C7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF5B1F226DF
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9418F2CA;
	Mon, 15 Jul 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsDK6jY6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31718EFE7
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058040; cv=none; b=eQInntL1qnDDKnOVW+5RWI0Waf5Vu7fDikLzzKH3+I3b6+hGDNCbbzT2mFJ8EWxPRd6IysqnU692VmM5j3mSMzfK0V6Uq+tepa+kr53WLBU0UicheW50ejzH69BzQk4xgKEDkefpVdEqxEPExEVsIOKY8hjRO9j6HRsbD7HRwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058040; c=relaxed/simple;
	bh=jo84ICaHy10UrO1fRMUDuSkAbckqXDDruDCEpkIxL3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2Ayme3jyQF1tZUMuac322veM+UPY9TNlqa6edCef8MAK0xTskntpcFlvn0Z9uorjMAEfogntOa6AUno9++hZBiwhG5xmylF9FmEMameG9cXzuonl6kMprlbxdrDhB4TWzxM6+Qt8v+N3yJyM0asXqc9DzElryzqsab4jL6tGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PsDK6jY6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721058039; x=1752594039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jo84ICaHy10UrO1fRMUDuSkAbckqXDDruDCEpkIxL3o=;
  b=PsDK6jY6FavJ994HXewp0z02GRWSF0ZiaYbBWHglurPGmiAv3izkCIW1
   097QsHDS2T8QZNomLdr+kYlIRo40tlZSxvNM/bBDhBOooqPx8afAPnrL3
   HxlXYi1sh7fLpp5kyUsohMZzlQsS9FXjL44bxxNfFuU/dG4e/PPOX39of
   /biQIZguErBbpe2Bd52XYLFqPJI5It/bCGsOfOywXpr00imfFFE0JBgkZ
   mV6VlzduhIo7vHa2gYbOkXahlo63ys+GIc+qFwlX6zIlev05qTCBrZVDC
   GcpuLDJjB63vyETzmkIUds1GWIQjoOOoE2nTa8iQarhAghFbj0Qlmtorl
   Q==;
X-CSE-ConnectionGUID: LzFEy2HwTym1IuXufIwHRA==
X-CSE-MsgGUID: S+T6/49ERx2Hc+6BWCaykA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35987670"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35987670"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 08:40:38 -0700
X-CSE-ConnectionGUID: sVLwtx/1QgWd8g64ansT+A==
X-CSE-MsgGUID: 4nPAqMTeTbeN3XkwEaLAgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49408479"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jul 2024 08:40:37 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-net v2 0/2] ice: Reset procedure fixes
Date: Mon, 15 Jul 2024 17:39:09 +0200
Message-ID: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes preventing possible races between resets (CORER etc)
and OICR ISR invocation / PTP hardware access

v1->v2: Patch rebase

Grzegorz Nitka (2):
  ice: Fix reset handler
  ice: Skip PTP HW writes during PTP reset procedure

 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 4 ++++
 2 files changed, 6 insertions(+)

-- 
2.43.0


