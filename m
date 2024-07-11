Return-Path: <netdev+bounces-110908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCC92EE8C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5485F1C21BBF
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0316DEA8;
	Thu, 11 Jul 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gB165RoP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3616DC27
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721607; cv=none; b=MQL3cL6Lr4bgK1H6vG4Stiuwp4n9f3fRTP92367u5jm5XBC3DPqM5uoURt6M4+YBoiWflNBj+nvmZRDuWK+PbhAIS8NMdPjatkHyLwdKpS8oiAgbtHNa5G2r8TyeQWtLVhwUNO8sNwFNLXmd1e1osP/cme/15cq9kUp9+CVRilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721607; c=relaxed/simple;
	bh=0Gvi6H4c6Bq4OP7Lk6+qm0JsyazjALEwNl5Fa99xpTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twIAoji6Fzdu/BSuLC3yyQIrrMxoAN/pfVzHQlTsrvyjEp1GK9rG+dyFJNLYRITG2Jc89hiCjgcmkImz0YrDnwViPV9E9v4mditHuEX8GpoP6Pt3p9xFWynDabIDH6YEYadIm86Ej/MsKnIvabHINimER8QyRSROhbj1JWrCTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gB165RoP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720721606; x=1752257606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Gvi6H4c6Bq4OP7Lk6+qm0JsyazjALEwNl5Fa99xpTw=;
  b=gB165RoPBjShehASk40Ca1DINIs6xd6xlm8r7PfkbB74NGKsbv3EwZ3F
   d6vTn2r3pXmE1OmzmIOAlyv0CwW1Zqt5KkapiRcvVYgj8Y/Q2u/qVtiYa
   Nt2ARTjCpetCEFYaZ+sV7KQRUPBd/qlJfj7PZNA7RpwHPsrSWD9xWdFbC
   FIPid45LNyY7eOUVTOov3D+fTTAi29/yQpK6WPIKPgjbo+2O65Hudlck/
   TGUZqiqpyEWrNbnQtb+9ntR0lLRwh7N/41vwInhNlkVC0sjeRdPxuH3Ai
   NKqjCkT5mxW16Fq4q5OHBFMmkJ6DiA3o36jehZx6dLv+/g5jyhPH3NP8w
   w==;
X-CSE-ConnectionGUID: FpqNLH52R6aysCNEqaMNaw==
X-CSE-MsgGUID: tlUoC8AwR4ylDE1MOQNK8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28720919"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28720919"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:13:25 -0700
X-CSE-ConnectionGUID: GFoNJ+edRVC7RgRB7e02DQ==
X-CSE-MsgGUID: e1xBWQiSQY6AWXrX3oFEpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48390884"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2024 11:13:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	marcin.szycik@linux.intel.com
Subject: [PATCH net-next 0/7][pull request] ice: Switch API optimizations
Date: Thu, 11 Jul 2024 11:13:03 -0700
Message-ID: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marcin Szycik says:

Optimize the process of creating a recipe in the switch block by removing
duplicate switch ID words and changing how result indexes are fitted into
recipes. In many cases this can decrease the number of recipes required to
add a certain set of rules, potentially allowing a more varied set of rules
to be created. Total rule count will also increase, since less words will
be left unused/wasted. There are only 64 rules available in total, so every
one counts.

After this modification, many fields and some structs became unused or were
simplified, resulting in overall simpler implementation.

The following are changes since commit 58f9416d413aa2c20b2515233ce450a1607ef843:
  Merge branch 'ice-support-to-dump-phy-config-fec'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Marcin Szycik (4):
  ice: Remove unused struct ice_prot_lkup_ext members
  ice: Optimize switch recipe creation
  ice: Remove unused members from switch API
  ice: Add tracepoint for adding and removing switch rules

Michal Swiatkowski (3):
  ice: Remove reading all recipes before adding a new one
  ice: Simplify bitmap setting in adding recipe
  ice: remove unused recipe bookkeeping data

 drivers/net/ethernet/intel/ice/ice_common.c   |  11 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |  43 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 674 ++++++------------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  20 +-
 drivers/net/ethernet/intel/ice/ice_trace.h    |  18 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 6 files changed, 272 insertions(+), 496 deletions(-)

-- 
2.41.0


