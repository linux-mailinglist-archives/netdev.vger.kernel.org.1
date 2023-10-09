Return-Path: <netdev+bounces-39000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394657BD663
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695B11C209D3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E97156EB;
	Mon,  9 Oct 2023 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKzLqPg6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D61549E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 09:10:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32CB6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696842644; x=1728378644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MIzLj7diT5phwSZEZVebNUI1yGDI70THPkUVrj2bkxA=;
  b=dKzLqPg6T9UjLT7VHGKEHhVTUIGs1ry0coqcdXtQl5pOzsZ076p9F3tk
   DPzwltdQll4Rd4nqTaSYSq2Cr68jx7QIkexq/w42lBbW2pITuqKGiTDUf
   2NsWfmlFGgohnmIbXvvKDGvjR9MdcEaYEbYrEADgvatXhryx4OfndWcEz
   mW2BHa6eW16xyKYs9nkG81vSU4klb+XuftNuSXkRijtiPCsXi+z0Y/+nO
   xL4sXDq4NjHgtuvbGnlP5twcfK9fzyeKuMVxZtXmD1tIMz4qMYMtMoClE
   7g2lxwxK9gNfN+VwqmH1DXI2+nESU2qi98s9Ja5VBuK/zjZ8lZhHg7Kye
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="382978418"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="382978418"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 02:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="843635726"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="843635726"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2023 02:10:42 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 78A99365AF;
	Mon,  9 Oct 2023 10:10:41 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v3 5/5] ice: Document tx_scheduling_layers parameter
Date: Mon,  9 Oct 2023 05:07:11 -0400
Message-Id: <20231009090711.136777-6-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231009090711.136777-1-mateusz.polchlopek@intel.com>
References: <20231009090711.136777-1-mateusz.polchlopek@intel.com>
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
index 2f60e34ab926..dde765313b82 100644
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
+     - The ice hardware uses hierarchical scheduling for Tx with a fixed
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
+       value 5 cmode permanent
+
+       And verify that value has been set:
+       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
+
 Info versions
 =============
 
-- 
2.38.1


