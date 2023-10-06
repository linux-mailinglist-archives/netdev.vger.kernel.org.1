Return-Path: <netdev+bounces-38548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F117BB5E9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1741C20B80
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38781C68B;
	Fri,  6 Oct 2023 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7ww8Nta"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA951C683
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:05:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C390DDB
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696590348; x=1728126348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1ZFwZorx5Q6/aXcIfmXrHZm47jo8kxB6IGrZ9z+pJs=;
  b=j7ww8Nta/0YrD2pYhmjfhmT1TS6ohHNG6S+bm6voEQWrwWBom+zNtAhf
   nwDOS46+bJxtdTvz0b1uHHxx01al8fSEIrMHuFMhO+NpGn2WXu4aaPcQJ
   k61hyrP/SGC4FJt0RHs/QxnsgE+mrawk6t7vVhNFZRoEVJS0n2BObRXom
   xz6/MUEuTrAp+d5mtOBMrw3gHMDKJa/DV2iUwKXXYohGZdKOz7dOhohEA
   2jjK45Tl4zAKzF9mvaKoQKEfD3I0uRautgOQ4IlBIpvkskuSSwF984k/P
   pEQWqpXAp/Xwz+ZDfV+jCIdzI5O9o2RTW7k5sxryz94HOStVJHXFLi5uF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2332747"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2332747"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895844432"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895844432"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2023 04:04:14 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EC73736345;
	Fri,  6 Oct 2023 12:05:44 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v2 5/5] ice: Document tx_scheduling_layers parameter
Date: Fri,  6 Oct 2023 07:02:12 -0400
Message-Id: <20231006110212.96305-6-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231006110212.96305-1-mateusz.polchlopek@intel.com>
References: <20231006110212.96305-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Wilczynski <michal.wilczynski@intel.com>

New driver specific parameter 'tx_scheduling_layers' was introduced.
Describe parameter in the documentation.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 Documentation/networking/devlink/ice.rst | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 2f60e34ab926..328a728d197b 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -22,6 +22,56 @@ Parameters
      - runtime
      - mutually exclusive with ``enable_roce``
 
+.. list-table:: Driver-specific parameters implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``tx_scheduling_layers``
+     - u8
+     - permanent
+       The ice hardware uses hierarchical scheduling for Tx with a fixed
+       number of layers in the scheduling tree. Root node is representing a
+       port, while all the leaves represents the queues. This way of
+       configuring Tx scheduler allows features like DCB or devlink-rate
+       (documented below) for fine-grained configuration how much BW is given
+       to any given queue or group of queues, as scheduling parameters can be
+       configured at any given layer of the tree. By default 9-layer tree
+       topology was deemed best for most workloads, as it gives optimal
+       performance to configurability ratio. However for some specific cases,
+       this might not be the case. A great example would be sending traffic to
+       queues that is not a multiple of 8. Since in 9-layer topology maximum
+       number of children is limited to 8, the 9th queue has a different parent
+       than the rest, and it's given more BW credits. This causes a problem
+       when the system is sending traffic to 9 queues:
+
+       | tx_queue_0_packets: 24163396
+       | tx_queue_1_packets: 24164623
+       | tx_queue_2_packets: 24163188
+       | tx_queue_3_packets: 24163701
+       | tx_queue_4_packets: 24163683
+       | tx_queue_5_packets: 24164668
+       | tx_queue_6_packets: 23327200
+       | tx_queue_7_packets: 24163853
+       | tx_queue_8_packets: 91101417 < Too much traffic is sent to 9th
+
+       Sometimes this might be a big concern, so the idea is to empower the
+       user to switch to 5-layer topology, enabling performance gains but
+       sacrificing configurability for features like DCB and devlink-rate.
+
+       This parameter gives user flexibility to choose the 5-layer transmit
+       scheduler topology. After switching parameter reboot is required for
+       the feature to start working.
+
+       User could choose 9 (the default) or 5 as a value of parameter, e.g.:
+       $ devlink dev param set pci/0000:16:00.0 name tx_scheduling_layers
+         value 5 cmode permanent
+
+       And verify that value has been set:
+       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
+
 Info versions
 =============
 
-- 
2.38.1


