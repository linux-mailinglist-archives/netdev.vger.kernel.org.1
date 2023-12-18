Return-Path: <netdev+bounces-58636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48751817AFD
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EEE1F2289D
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914927144F;
	Mon, 18 Dec 2023 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BT1jUgHH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32151E530
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702927634; x=1734463634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Z9vIhOOUOiDLE7ObPbPKTS8pFOb9/Up3iTdTR/WL3k=;
  b=BT1jUgHHEZOZxQ4HMd/XwqVlY9pML0WOb/zKrv04hLbz6IU30kRYnYKa
   B9XbbREIp3LAQEo8MfxvSLolm+FyFp+qpwCiO2WanTzHlMbfstWH2FiA+
   PAQNmV9Lr/pkQ4HQigkjCV5CTXuRda3e6rjebtTim7/aK5jcl/3OPf2xg
   SZPpL0pfpSWa1IuN5L2Lf5uLHisYlmi/hTUuSUZnAjktxD+HWeHKY0DtK
   pd5ldUuCmLB8WMNZOnGA9QhhWPTORhJVtfbH3QxtqKaMD+k2Asc7LtPXF
   D5J/w+NUct8TgHCDreMtaDX0WgKoq8E9+zeLuvmUxQzJqGYlkHGBBEeUo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2377428"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2377428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809940491"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809940491"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2023 11:27:13 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2023-12-18 (ice)
Date: Mon, 18 Dec 2023 11:27:03 -0800
Message-ID: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Jakes stops clearing of needed aggregator information.

Dave adds a check for LAG device support before initializing the
associated event handler.

Larysa restores accounting of XDP queues in TC configurations.

The following are changes since commit 979e90173af8d2f52f671d988189aab98c6d1be6:
  Merge branch 'mptcp-misc-fixes'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Dave Ertman (1):
  ice: alter feature support check for SRIOV and LAG

Jacob Keller (1):
  ice: stop trashing VF VSI aggregator node ID information

Larysa Zaremba (1):
  ice: Fix PF with enabled XDP going no-carrier after reset

 drivers/net/ethernet/intel/ice/ice_lag.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.41.0


