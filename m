Return-Path: <netdev+bounces-40355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D527C6E27
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07B21C20F63
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CBD2421D;
	Thu, 12 Oct 2023 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwE4S3ng"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF38266C1
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:34:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA80B7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697114092; x=1728650092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCgJXvRIM8UKT6SuTH43ahQNseXCq1L0JSy5YfhVEmM=;
  b=CwE4S3ngPMXSB/cVMkWobCv5bpGaT5NoOvX3dqUCF2XWwnUCO9d4A/cE
   49wgW3T4MySQw4JFIPvoMOEFXoJ/49+LnlVEJg0HedpXd/VGoHL+vnwZg
   IH4woWSr+C3cUKdzM40O3+sXLHbuXAe2L+7qYTl3U3c0xIW9TSbiw5xDF
   CKm6cGgC3+pbSA6L02E/bP02OqYH4Rbgn9i7sZKwgBiVGyBSFZSGPAgI6
   BCCtrrg9e/Yx+HeNN7I2YRnLp8SJbbrcTUFIkagRNphOXARpqxOgabnV6
   Pe3bHZ+I7RFMtNPl1Wt9g6b3o2ecJtGlwjzy5AkW1c7X+syon1IqutgXT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364274303"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="364274303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1001533795"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="1001533795"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga006.fm.intel.com with ESMTP; 12 Oct 2023 05:34:49 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A1D73332D6;
	Thu, 12 Oct 2023 13:34:48 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	ecree.xilinx@gmail.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v4] docs: fix info about representor identification
Date: Thu, 12 Oct 2023 08:31:44 -0400
Message-Id: <20231012123144.15768-1-mateusz.polchlopek@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update the "How are representors identified?" documentation
subchapter. For newer kernels driver should use
SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
callback.

---
v4:
- changed the docs description

v3:
- fixed the lack of hyphen in changelog
https://lore.kernel.org/netdev/20231010120845.151531-1-mateusz.polchlopek@intel.com/

v2:
- targeting -net, without IWL
https://lore.kernel.org/netdev/20231009111544.143609-1-mateusz.polchlopek@intel.com/

v1:
https://lore.kernel.org/netdev/20231006091412.92156-1-mateusz.polchlopek@intel.com/
---

Fixes: 7712b3e966ea ("Merge branch 'net-fix-netdev-to-devlink_port-linkage-and-expose-to-user'")
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 Documentation/networking/representors.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/representors.rst b/Documentation/networking/representors.rst
index ee1f5cd54496..decb39c19b9e 100644
--- a/Documentation/networking/representors.rst
+++ b/Documentation/networking/representors.rst
@@ -162,9 +162,11 @@ How are representors identified?
 The representor netdevice should *not* directly refer to a PCIe device (e.g.
 through ``net_dev->dev.parent`` / ``SET_NETDEV_DEV()``), either of the
 representee or of the switchdev function.
-Instead, it should implement the ``ndo_get_devlink_port()`` netdevice op, which
-the kernel uses to provide the ``phys_switch_id`` and ``phys_port_name`` sysfs
-nodes.  (Some legacy drivers implement ``ndo_get_port_parent_id()`` and
+Instead, the driver should use the ``SET_NETDEV_DEVLINK_PORT`` macro to
+assign a devlink port instance to the netdevice before registering the
+netdevice; the kernel uses the devlink port to provide the ``phys_switch_id``
+and ``phys_port_name`` sysfs nodes.
+(Some legacy drivers implement ``ndo_get_port_parent_id()`` and
 ``ndo_get_phys_port_name()`` directly, but this is deprecated.)  See
 :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>` for the
 details of this API.
-- 
2.38.1


