Return-Path: <netdev+bounces-46302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD917E3247
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0493B280E19
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B9C8E7;
	Tue,  7 Nov 2023 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZrr4LPz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9CC2C0
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:36:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643E1BF
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699317367; x=1730853367;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k6sxjn9ft6/BzvvLE8FzITwDVEaWvretTqPR/WO6hK0=;
  b=XZrr4LPzSh2Fb/iFI8rpn+GvMOmErBxiGIFfKnmj4fhZBG7LuhJ645Oz
   p1piH6N1wuSBjGRAL5WxHbYzjlaako26m/4ZH9Fd4aPZ7I+ytWiZdhZQ+
   rbZkpxsOgAP1qiK0+MPfee+W1ASmdQSqhDcLc1SxPmiR/vGzVpYz756jf
   ef1mqrtL+4Gopa0Yy8JiLSSW77fUQyq9nPkfdQDT5EUtPbTb+I4jBuZ+J
   FuiZb0AUhOjQVj6OG6dG19+0UGFdrhR0riffNKGGLwXjDaZrJwxkytIQ/
   sU3VHRALiHryMoak+3MCaYYdip/H6YtVReNhGHA6bkG8cahs2UgwfnSEc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420508343"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="420508343"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="756011251"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="756011251"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2023 16:36:06 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ivecera@redhat.com,
	jiri@nvidia.com
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2023-11-06 (i40e)
Date: Mon,  6 Nov 2023 16:35:57 -0800
Message-ID: <20231107003600.653796-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e driver only.

Ivan Vecera resolves a couple issues with devlink; removing a call to
devlink_port_type_clear() and ensuring devlink port is unregistered
after the net device.

The following are changes since commit c1ed833e0b3b7b9edc82b97b73b2a8a10ceab241:
  Merge branch 'smc-fixes'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Ivan Vecera (2):
  i40e: Do not call devlink_port_type_clear()
  i40e: Fix devlink port unregistering

 drivers/net/ethernet/intel/i40e/i40e_devlink.c |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 ++++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.41.0


