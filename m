Return-Path: <netdev+bounces-37809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62357B7428
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 27CBFB207BD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA13AC3B;
	Tue,  3 Oct 2023 22:37:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2534379
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:37:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D52A7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696372632; x=1727908632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aOUhICtDxgkA+LGLGRGFxn8T/mIsM+uO7pcnlpzNSEk=;
  b=JQOGiyohL53cFRPHvpsreiPL8B6xHjUEf40zCrhY+r7kBX4VRopyRQi7
   8G00lBo6NEQQdHT2zAY+uR116RkYidffdiN7HpgSSpHP5LD1p6Bs6Fkwp
   k89E2x684dDgktBKo83zzFbfjakoQpiGIOLfVqmvTF7CSqRRhbKaAgiI6
   bgn+g+rF6zGa0ZFiQJkOQ3zuznPX8uQKK88T/+otZKpcblCDYhH7VNHPf
   W31cArrVr/On8ReyWqUVZRyz7IGTipRZ/EGm0pbCWFgI4YOPKx/hZsLYX
   J2I3LFUapYX/BHFDLNDd2p9gimOUcFmB49UN5btLBVYN+Du2W6VbAZrWB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386865658"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="386865658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 15:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="751057786"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="751057786"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2023 15:37:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver Updates 2023-10-03 (i40e, iavf)
Date: Tue,  3 Oct 2023 15:36:08 -0700
Message-Id: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to i40e and iavf drivers.

Yajun Deng aligns reporting of buffer exhaustion statistics to follow
documentation for i40e.

Jake removes undesired 'inline' from functions in iavf.
---
v2:
- Drop, previous patch 3, as a better solution [1] is upcoming [2]

[1] https://lore.kernel.org/intel-wired-lan/abf8d279-b579-4a03-9ae9-053cf5efec3d@wanadoo.fr/
[2] https://lore.kernel.org/intel-wired-lan/20231003183603.3887546-2-jesse.brandeburg@intel.com/

v1: https://lore.kernel.org/netdev/20231002185034.1575127-1-anthony.l.nguyen@intel.com/

The following are changes since commit 8989682a1cb600bac1149ed17b1ce929ab472e79:
  Merge branch 'documentation-fixes-for-dpll-subsystem'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Jacob Keller (1):
  iavf: remove "inline" functions from iavf_txrx.c

Yajun Deng (1):
  i40e: Add rx_missed_errors for buffer exhaustion

 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 18 +++-----
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 46 +++++++++----------
 4 files changed, 33 insertions(+), 36 deletions(-)

-- 
2.38.1


