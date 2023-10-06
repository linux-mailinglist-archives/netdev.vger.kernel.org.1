Return-Path: <netdev+bounces-38505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853087BB415
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD28282122
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE8125C4;
	Fri,  6 Oct 2023 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYiJuFU6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AE63CC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:17:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221D393
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696583842; x=1728119842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GhnObhdwfwqM0XKIYgyPtMRHGdwAaDlIihpQgU3J0HE=;
  b=HYiJuFU6UGS2CeeQeO0xLYUmGeuXBIF8qM2y7hOSEpOMUTuQlvIqnSFs
   X/D4WMay7DJ+VY/lPepQqOxQjSqBsBozZTziYgRvUlo4Sb0E1OJpbkFoq
   hZCFs7z/uPLzvPFOhrGFx/1OONFZed2bVprHyK2OgmGYoI1j7NFSvgAKV
   Fw45Nn4UPdzGkEqTc9sBgrwkQGvhFKiPB17v2VMpYDIxVrC50VKrhzbMh
   t8MCjjcupKYL1dHwzXPES0auihpKBjfSn3sjnb3l5nCi2GN0S17jrZhCA
   JM5ixgKqPnceSe8rIXCVJg3RAaA4pH8kdg7KqFkvHsj4RHIqCi8KDZHbi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368792053"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368792053"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="868276914"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="868276914"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2023 02:17:20 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7D56F36345;
	Fri,  6 Oct 2023 10:17:18 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v1] docs: update info about representor identification
Date: Fri,  6 Oct 2023 05:14:12 -0400
Message-Id: <20231006091412.92156-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
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

Update the "How are representors identified?" documentation
subchapter. For newer kernels driver developers should use
SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
callback.

Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
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


