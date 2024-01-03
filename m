Return-Path: <netdev+bounces-61316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC16D82359E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 20:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49491C2381A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820071CAA1;
	Wed,  3 Jan 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n61rwlI7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F111CF82
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704310390; x=1735846390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gCj2R1Gr66PenC8nCHKHSnQqSv59m7JiYD+yK8fPFu0=;
  b=n61rwlI7WH/I3becqHcB0qEMi8p0FI8sEva5dV1ZdLb2jc+1mi4ZWeQD
   oSf05f27pRY+3vEPnekLhjc5EbJ+ogNo/Tnc4QJT0wruWhC8Six7TIdsh
   o+khJX9VCFo0T33zvs3plaPwvdqzI25AM7Njzm6apHagdCcz5FToknzak
   MOx/TuZUNxPP/Avf4r6iB2b/JVeS73/zBzZVUgpzMVW8bcTQUOIRSA12E
   5GGsVxSwJ+j/rJFx4R4ERZsLjIUbtqOtvQKweiAMaxtn1Xw9q08sLxpDa
   sp6/hzgLT8EvpgelGAJvKSGnJR8m2k4GaaUK+OgJcG/5Ml7tfOhNp3dsf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="395927469"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="395927469"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 11:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780079847"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780079847"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2024 11:33:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-01-03 (i40e, ice, igc)
Date: Wed,  3 Jan 2024 11:32:48 -0800
Message-ID: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e, ice, and igc drivers.

Ke Xiao fixes use after free for unicast filters on i40e.

Andrii restores VF MSI-X flag after PCI reset on i40e.

Paul corrects admin queue link status structure to fulfill firmware
expectations for ice.

Rodrigo Cataldo corrects value used for hicredit calculations on igc.

The following are changes since commit 01b2885d9415152bcb12ff1f7788f500a74ea0ed:
  net: Save and restore msg_namelen in sock_sendmsg
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Andrii Staikov (1):
  i40e: Restore VF MSI-X state during PCI reset

Ke Xiao (1):
  i40e: fix use-after-free in i40e_aqc_add_filters()

Paul Greenwalt (1):
  ice: fix Get link status data length

Rodrigo Cataldo (1):
  igc: Fix hicredit calculation

 drivers/net/ethernet/intel/i40e/i40e_main.c   | 11 +++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 26 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  3 +++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  3 ++-
 drivers/net/ethernet/intel/igc/igc_tsn.c      |  2 +-
 5 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.41.0


