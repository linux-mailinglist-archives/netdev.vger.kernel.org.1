Return-Path: <netdev+bounces-112696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3E93A9E9
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 01:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408CA1F230D1
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAC149006;
	Tue, 23 Jul 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdgJvPRH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337314264A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777568; cv=none; b=YG1pF/wSeizdZ4bkF4s+mcYS5LgwMXbB7pfyoO8NkWabrWkO5s42veHKgt7dr3J0h25NHDuIKNMrfcHcp6xB06N/0KwOWqu8nb2gXKNc0tWYBi26JRn57UktrAXHX5oFuRw25wf8q95s3Fcl7yUwQFbgrXTMpUZTobzWbFbr2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777568; c=relaxed/simple;
	bh=HtkOKDLU+2tXlRuy4sHM5JBTa4pmGt2s2wIZfYXFGaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8H0IGhKJ2qXX5cEhIb8tq4T6wUaCb64seOdGTba2HLx1SGjohPO0rzSFodxgMj0SK+QZOk/QbAqcX+2PyaHBbJUx/RAYNXzpByio8Wagpw8M6vDVrla/rrWXroDNHa08kyvNMUthQMK2YzSdgt5u+WGqXb9IGUdFqgNNiE7S/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdgJvPRH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721777567; x=1753313567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HtkOKDLU+2tXlRuy4sHM5JBTa4pmGt2s2wIZfYXFGaY=;
  b=XdgJvPRHHKR5JrfAXKopLG7oCMKZPL9aCWw/OEdC3ptcO3/06Fdn5m/n
   5mWlkAQBhy5Srqp2co+C+uYq6hAQqBBrz1sgYWzSlWvRRyraRv4fTDtjk
   hWllCbUjICWW4mbAmQHrr0OWFZ8YekefZGe4XENrNNTE+qiRt6WFzOozC
   oMBsvElVNn6xHdQG777HF5wiN8Os4aGItjy9mzChrkaK3mSZ9ehxwcDUa
   b0c8rD5f5kVOdhux+GKzWa21W4HKth599UnMkorur3bz7DhWXDXfkqBdq
   bLHcBJ5AaK/WgtBE/QuRPMxxEpyPQEfARFXaI/AjsV5w7P1dqoxTDEEai
   g==;
X-CSE-ConnectionGUID: X1NYPm7QQiy508ZxRCIWGQ==
X-CSE-MsgGUID: qkaLxe67T72jY+Y7VlPEfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30049071"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="30049071"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 16:32:46 -0700
X-CSE-ConnectionGUID: QdlF9K7qRdODNdnNMy/Paw==
X-CSE-MsgGUID: ov5hz36tTnKL02t9IjjKiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="89847949"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 23 Jul 2024 16:32:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2024-07-23 (ice)
Date: Tue, 23 Jul 2024 16:32:38 -0700
Message-ID: <20240723233242.3146628-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Ahmed enforces the iavf per VF filter limit on ice (PF) driver to prevent
possible resource exhaustion.

Wojciech corrects assignment of l2 flags read from firmware.

The following are changes since commit 3ba359c0cd6eb5ea772125a7aededb4a2d516684:
  net: bonding: correctly annotate RCU in bond_should_notify_peers()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Ahmed Zaki (1):
  ice: Add a per-VF limit on number of FDIR filters

Wojciech Drewek (1):
  ice: Fix recipe read procedure

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h        |  3 +++
 drivers/net/ethernet/intel/ice/ice_switch.c      |  8 ++++----
 .../net/ethernet/intel/ice/ice_virtchnl_fdir.c   | 16 ++++++++++++++++
 .../net/ethernet/intel/ice/ice_virtchnl_fdir.h   |  1 +
 5 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.41.0


