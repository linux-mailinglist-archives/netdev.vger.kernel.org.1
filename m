Return-Path: <netdev+bounces-37498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B147B5B07
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 50C02281CF4
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3B1F5E1;
	Mon,  2 Oct 2023 19:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336ED1A719
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:15:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA6FD7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696274155; x=1727810155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qbzfL11k6TP1LY6qmOSpxFejVAWsg5+koMYXbNUSpNY=;
  b=Rri/gcVK5ycaQCtMRQVzJP9yokZm/2HPy0cZsttUEW7jT6eDXu1Q0sto
   4mi5ZjYEWC9wVqEO0e23Hhmoiw1vW7DXmU75Mw44d6m7RfdyN9nZgMxAI
   JRiCHfpwUzpkJtWM7yIGB0sf5CcpwpW2uTGlTzu6F/5O/Vxku/8BCtMXO
   AYZaiephoHJ9swpYqjGlpBbaCVfs9aMfWX2UrXr4sPbG2y+UpAWhXZQDh
   NvftOrdn3/BsykXP1R1ikbXWoqjiAsluUdQq+PzAzxhNwFr21/00QkiP3
   86VIk2wp+eOGd5BMqxUl9gLRJjv+NMmrvZB9PBWMZDvi0nMngt3Njagxh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373055023"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="373055023"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 11:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="780011933"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="780011933"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Oct 2023 11:51:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates 2023-10-02 (i40e, iavf)
Date: Mon,  2 Oct 2023 11:50:31 -0700
Message-Id: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to i40e and iavf drivers.

Yajun Deng aligns reporting of buffer exhaustion statistics to follow
documentation for i40e.

Jake removes undesired 'inline' from functions in iavf.

Christophe Jaillet converts memory allocation to instead use local
variable for iavf.

The following are changes since commit 436e5f758d6fbc2c5903d59f2cf9bb753ec77d9e:
  Merge branch 'mlxsw-next'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Christophe JAILLET (1):
  iavf: Avoid a memory allocation in iavf_print_link_message()

Jacob Keller (1):
  iavf: remove "inline" functions from iavf_txrx.c

Yajun Deng (1):
  i40e: Add rx_missed_errors for buffer exhaustion

 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 18 +++-----
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 46 +++++++++----------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  7 +--
 5 files changed, 34 insertions(+), 42 deletions(-)

-- 
2.38.1


