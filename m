Return-Path: <netdev+bounces-18027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC67543A8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38BC1C2163E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30D20FBF;
	Fri, 14 Jul 2023 20:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDE1371C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:18:39 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469430E3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689365918; x=1720901918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/LZcqc1Pgi6BXW3TmIuVYbyW2/o8blhZJqemO+v4cv4=;
  b=U26NwINeih/OldhJOYUtZAXEkUOyLpzp7LZ63O04gBY9t4jPOJkAAgJu
   O+57bUP5l+ZIPu6qDl0o+ZVW7mv46RmGW4kWc4fpzxlnuV0xCwufGjYSO
   6pFbGrHC1JS9q+U5chGZj7pcuX2xNxsCkT2lDDMM/kiTOa9tbEZyRhdwJ
   VCwCaOytBgPIIQzHQZl3tkpfC/5Hx+DQf3hKTuV2fknYWspala/gMx3FX
   /ot+hlC5u4wJXt0nrZBhyQPfErXX50FiKh0KLw89UaoA0Y5+ExdyG2eq+
   Y9DEzNF4iZgHg3Y1PbAO8h+/kfwbgf06i2/L+P0c7hcmOtBlwSdIjGMtq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="364438484"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="364438484"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="722521105"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="722521105"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 13:18:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver Updates 2023-07-14 (i40e)
Date: Fri, 14 Jul 2023 13:12:51 -0700
Message-Id: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to i40e driver only.

Ivan Vecera adds waiting for VF to complete initialization on VF related
configuration callbacks.

The following are changes since commit 68af900072c157c0cdce0256968edd15067e1e5a:
  gve: trivial spell fix Recive to Receive
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Ivan Vecera (2):
  i40e: Add helper for VF inited state check with timeout
  i40e: Wait for pending VF reset in VF set callbacks

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 65 +++++++++++--------
 1 file changed, 38 insertions(+), 27 deletions(-)

-- 
2.38.1


