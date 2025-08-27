Return-Path: <netdev+bounces-217419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AFBB389D4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AF11B27311
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063CB2C178D;
	Wed, 27 Aug 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9vi8xvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9F1C8632
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320822; cv=none; b=CAjhkEXFcHVTb+5i5ickdScyl3nDzwc4Moy6qoz/dXfphN3NvMGWAvmXf7ayfAQThULuIuENIlJ/pzrf5Sfqu1hlM4eP8lwXYiBTnBGNkEirSYQwEjzYibd8/4ISUOA4e7Q6jyx5jXPSgxgMYqq4hPb4AQzr1QWkaV7w744Gc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320822; c=relaxed/simple;
	bh=rhBvuqypf5LHhK3Z0/md04qrIWQLJc20kETHaLtkhz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocGoTX2hXgyjihMCo+6FSvTQQB1ZELu37Lw2vIIJGndgPfwNVXvTJyuIVsP+l0m+y2MeVchyJO2m+tcPl77WDqfyO3X9aVmZswl8mnue9i9KLoXIPWJkXBX34eg7FuToPAyl9gMcQ4RAPNuLiz7sdxKadzkMj5IXnO9jkycqbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9vi8xvZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756320821; x=1787856821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rhBvuqypf5LHhK3Z0/md04qrIWQLJc20kETHaLtkhz8=;
  b=a9vi8xvZrMCH5WI8VJJAntx8Zc13nQ65pCY7+uNnGkIp1eGSJgNupQAT
   aOMcDEo1jtjrPilpE+cxWjQwvcYhlBZBaYMRw5ed17Ez+r0lXz2wCUAqM
   2XL8TsNI0NxVRG8QQMjWIXkTqoj67ygMsA5rYyAyAZvs1makZhdErWncb
   eRkwf/Z3l38yKM1zVFmUDkyETo3ojpLU5ooOkksaRSC1LUwYAaOx2y7Bz
   Po6xWbjo8FRwXn0Ox7f12ebOeWHC55rvebh8VzITcAdF7l1ki9T4wMlZy
   O8GYwz6fE9avlTtsf6Buv0TnA9dRhT0fBzuSlzej01ov++TBe80D7rWY0
   Q==;
X-CSE-ConnectionGUID: tiy1aepLR2GTEpSkGOTQkw==
X-CSE-MsgGUID: xkusy/CPSKy/hepRhQFsdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58677608"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58677608"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 11:53:40 -0700
X-CSE-ConnectionGUID: I7pMfCksRmSwdptczJiuRg==
X-CSE-MsgGUID: qNRYP25ITxqmkwmXA/9QMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169846080"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 27 Aug 2025 11:53:39 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	mschmidt@redhat.com
Subject: [PATCH iwl-next v3 0/5] iavf and ice: GTP RSS support and flow enhancements
Date: Wed, 27 Aug 2025 18:53:33 +0000
Message-ID: <20250827185338.1943489-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Receive Side Scaling (RSS)
configuration of GTP (GPRS Tunneling Protocol) flows via the ethtool
interface on virtual function (VF) interfaces in the iavf driver.

The implementation enables fine-grained traffic distribution for
GTP-based mobile workloads, including GTPC and GTPU encapsulations, by
extending the advanced RSS infrastructure. This is particularly beneficial
for virtualized network functions (VNFs) and user plane functions (UPFs)
in 5G and LTE deployments.

Key features:
 - Adds new RSS flow segment headers and hash field definitions for GTP
   protocols.
 - Enhances ethtool parsing logic to support GTP-specific flow types.
 - Updates the virtchnl interface to propagate GTP RSS configuration to PF.
 - Extends the ICE driver to support GTP RSS configuration for VFs.

changelog:
v2:
   - reduce much repetition with ice_hash_{remove,moveout}() calls
     (Przemek, leftover from internal review)
   - now applies on Tony's tree

v1/RFC: https://lore.kernel.org/intel-wired-lan/20250811111213.2964512-1-aleksandr.loktionov@intel.com

Aleksandr Loktionov (4):
  ice: add flow parsing for GTP and new protocol field support
  ice: add virtchnl and VF context support for GTP RSS
  ice: improve TCAM priority handling for RSS profiles
  iavf: add RSS support for GTP protocol via ethtool

Przemek Kitszel (1):
  ice: extend PTYPE bitmap coverage for GTP encapsulated flows

 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |  119 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   31 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   89 ++
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   91 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  251 ++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   94 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |   20 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   48 +
 .../net/ethernet/intel/ice/ice_virtchnl_rss.c | 1404 ++++++++++++++++-
 include/linux/avf/virtchnl.h                  |   50 +
 11 files changed, 2070 insertions(+), 128 deletions(-)

--
2.47.1

