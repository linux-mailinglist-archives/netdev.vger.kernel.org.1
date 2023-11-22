Return-Path: <netdev+bounces-49929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAB97F3E5C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 07:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F59281987
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90E154B3;
	Wed, 22 Nov 2023 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZc85BNq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15111BB
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 22:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700635971; x=1732171971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lnk0AR0iJLU/GDfM/FT+r8pH4x2MEkHin41VaFUQH9s=;
  b=UZc85BNqHrjpxDDftYHLnUHW0UvxV/FX9QsEL1MrjCzIi+mE/jlOGCGX
   T4Jo/G6VsF6+7F/mAhbescHsWtbItdHDywx00XQFFgN/qNRs6kSSFsg6c
   G9NidCK6l3dws6XmI4ZyQZzRtqIvyKGBFPbCMd9w5NtEC/9vp911NAH1E
   3B7R4huA5pQmhF9r2SxnjMzckSYyNsLkYsE4AkKbeI79Z66K3oKk14ttf
   +ipQkNpcOS44X+VztanNMmaDXzztrNmKq0Luh5tKBtbdOPkwH24wptKwD
   9POUnLqmhQ8rkl6x5bfpm2dOyAomG+8X1sOicX/iqN7uuzbypwjIcoMgR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="394831194"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="394831194"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 22:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="770492390"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="770492390"
Received: from fedora-sys-rao.jf.intel.com (HELO f37-upstream-rao..) ([10.166.5.220])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2023 22:52:51 -0800
From: Ranganatha Rao <ranganatha.rao@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ranganatha Rao <ranganatha.rao@intel.com>
Subject: [PATCH iwl-net v1 0/2] Introduce new state machines for flow director
Date: Tue, 21 Nov 2023 22:47:14 -0500
Message-ID: <20231122034716.38074-1-ranganatha.rao@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes current design flaws in flow director by introducing additional state
machines.

Piotr Gardocki (2):
  iavf: Introduce new state machines for flow director
  iavf: Handle ntuple on/off based on new state machines for flow
    director

 drivers/net/ethernet/intel/iavf/iavf.h        |   1 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  27 +++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  15 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 107 ++++++++++++++++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  71 +++++++++++-
 5 files changed, 198 insertions(+), 23 deletions(-)

-- 
2.41.0


