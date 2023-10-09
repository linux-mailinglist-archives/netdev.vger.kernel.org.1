Return-Path: <netdev+bounces-39060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB0B7BD96B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4037D1C208A5
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30690171BE;
	Mon,  9 Oct 2023 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNh/ZjDD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72616401
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:19:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DD399
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696850379; x=1728386379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6K8pWikUstQKj+F8Jm1uStsmaJZC1g9V/vhezfXLRoI=;
  b=cNh/ZjDD5yd31ilu8B3VmBACxX+RZioeyDDbsO+6G1mjF+OG/I4+CMCM
   N22bdE7Msz6dn7kqJ6UsxbyKN4cgbFOvCraT8Kf036CJlBpMG5UGsQ1Nb
   /Zew7IxmEw+xIu1801pK/sMO+kzF47t33dAshyDAS6zCgPgMGCH2L6ddr
   mFmjhP3NH0CfkN+MgDwXMiO9cX6WcYuZKvVSNs+xPhza5U3YgsyUjljHm
   /WVUeuJWldu2hTNGtODc71F640AQKRI3zNl0c4Pw4mC7Y5BZ4IS6GAy2k
   z7rcY2vlrydNb+zHWlX4Xf29NvPXlGJ1pTsFKjlyb4EEkQVz+SbX77xhb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="2718288"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="2718288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 04:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="752987819"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="752987819"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2023 04:18:57 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 822283741F;
	Mon,  9 Oct 2023 12:18:56 +0100 (IST)
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
Subject: [PATCH net v2] docs: fix info about representor identification
Date: Mon,  9 Oct 2023 07:15:44 -0400
Message-Id: <20231009111544.143609-1-mateusz.polchlopek@intel.com>
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
subchapter. For newer kernels driver developers should use
SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
callback.

--
v1:
- targeting -net, without IWL
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


