Return-Path: <netdev+bounces-39538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 388FB7BFAE2
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51E4281B95
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484219467;
	Tue, 10 Oct 2023 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDHR1hfj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A096120
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:12:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09CA4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696939922; x=1728475922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=khKLLEJqLV4SR2zv4U+OwXvxYSWEGMnqMuxifuxeBX4=;
  b=hDHR1hfj6BUuJu0S1gkFJ+J0n+IDXMwTVvOyTSRCIZXxdWMQ3ax5bcOh
   +16h26idphea5HuiPb6ckbUt6UP28veh3yLBfETnZnkzMAYraET2Hs8Ah
   iObLl8O9u6A7x04KLo2Bsn8iGIi2kJZ9GEFXljFI0METDrscSa839PYWM
   ckU49bTqM2jHBj1xJX3jJfpIDll2pLAR16qq7BW2mCNo3OsPesJrcvfuY
   bRSvXKz+Tm7V4oqRwLfJvaFXDn7dGU6/CAjaCP7OTYwShmt7HNd630qJK
   qNjZmY1oweYff1891mCXDTMGBu6x7AR1dSZ9Vxk9D6sDfb/xbicInIryb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388245492"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="388245492"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 05:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747053298"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747053298"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 10 Oct 2023 05:11:59 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BF786386BD;
	Tue, 10 Oct 2023 13:11:58 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3] docs: fix info about representor identification
Date: Tue, 10 Oct 2023 08:08:45 -0400
Message-Id: <20231010120845.151531-1-mateusz.polchlopek@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update the "How are representors identified?" documentation
subchapter. For newer kernels driver developers should use
SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
callback.

---
v3:
- fixed the lack of hyphen in changelog

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
 Documentation/networking/representors.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/representors.rst b/Documentation/networking/representors.rst
index ee1f5cd54496..2d6b7b493fa6 100644
--- a/Documentation/networking/representors.rst
+++ b/Documentation/networking/representors.rst
@@ -162,9 +162,9 @@ How are representors identified?
 The representor netdevice should *not* directly refer to a PCIe device (e.g.
 through ``net_dev->dev.parent`` / ``SET_NETDEV_DEV()``), either of the
 representee or of the switchdev function.
-Instead, it should implement the ``ndo_get_devlink_port()`` netdevice op, which
-the kernel uses to provide the ``phys_switch_id`` and ``phys_port_name`` sysfs
-nodes.  (Some legacy drivers implement ``ndo_get_port_parent_id()`` and
+Instead, driver developers should use ``SET_NETDEV_DEVLINK_PORT`` macro to
+assign devlink port instance to a netdevice before it registers the netdevice.
+(Some legacy drivers implement ``ndo_get_port_parent_id()`` and
 ``ndo_get_phys_port_name()`` directly, but this is deprecated.)  See
 :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>` for the
 details of this API.
-- 
2.38.1


