Return-Path: <netdev+bounces-26481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C498C777ECF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE1282289
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610E1E1C0;
	Thu, 10 Aug 2023 17:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F621503
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:07:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B92703;
	Thu, 10 Aug 2023 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691687274; x=1723223274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dotDLlo/a9YsWNlJpXd8Bf3iFLwvIMCiIU+o/OVT2tA=;
  b=k+G4ymWBjiKLCv9B5n7GdJAgqVB1RWxQkpNHTpr5S+B5WAmAMu/qNvCY
   K2euYCOUxznEcl+fRnjSVEXx54PFdrsB5o8FJfPDKzL7Alo4pSpg3PyLK
   5Y31Lkmjn/uRBh5wFCGCxlnp6IoIcQ4Nwx3i9bUf+df2W5+Dot1FXj1cc
   1fz/P6gQXPmNTpn4mgBlFqTrBDp7c2PZiKWJ+Je5cuhBlaiOJzm9brGcg
   UKsnmMvGDYgtH/1I1BL3PS30tIecZtjnzrgsUJSGSf49dvquDCG5KBMfv
   Y82ql7PrXQaXtWJylm31E/lMU9YBwRRQNq333r4sHclW5h35ivI5N0Lzm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371476134"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="371476134"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709234186"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="709234186"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 10:07:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 5/5] ice: add documentation for FW logging
Date: Thu, 10 Aug 2023 10:01:09 -0700
Message-Id: <20230810170109.1963832-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230810170109.1963832-1-anthony.l.nguyen@intel.com>
References: <20230810170109.1963832-1-anthony.l.nguyen@intel.com>
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

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Add documentation for FW logging in
Documentation/networking/device-drivers/ethernet/intel/ice.rst

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../device_drivers/ethernet/intel/ice.rst     | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index e4d065c55ea8..3ddef911faaa 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -895,6 +895,123 @@ driver writes raw bytes by the GNSS object to the receiver through i2c. Please
 refer to the hardware GNSS module documentation for configuration details.
 
 
+Firmware (FW) logging
+---------------------
+The driver supports FW logging via the debugfs interface on PF 0 only. In order
+for FW logging to work, the NVM must support it. The 'fwlog' file will only get
+created in the ice debugfs directory if the NVM supports FW logging.
+
+Module configuration
+~~~~~~~~~~~~~~~~~~~~
+To see the status of FW logging then read the 'fwlog/modules' file like this::
+
+  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
+
+To configure FW logging then write to the 'fwlog/modules' file like this::
+
+  # echo <fwlog_event> <fwlog_level> > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
+
+where
+
+* fwlog_level is a name as described below. Each level includes the
+  messages from the previous/lower level
+
+      * NONE
+      *	ERROR
+      *	WARNING
+      *	NORMAL
+      *	VERBOSE
+
+* fwlog_event is a name that represents the module to receive events for. The
+  module names are
+
+      *	GENERAL
+      *	CTRL
+      *	LINK
+      *	LINK_TOPO
+      *	DNL
+      *	I2C
+      *	SDP
+      *	MDIO
+      *	ADMINQ
+      *	HDMA
+      *	LLDP
+      *	DCBX
+      *	DCB
+      *	XLR
+      *	NVM
+      *	AUTH
+      *	VPD
+      *	IOSF
+      *	PARSER
+      *	SW
+      *	SCHEDULER
+      *	TXQ
+      *	RSVD
+      *	POST
+      *	WATCHDOG
+      *	TASK_DISPATCH
+      *	MNG
+      *	SYNCE
+      *	HEALTH
+      *	TSDRV
+      *	PFREG
+      *	MDLVER
+      *	ALL
+
+The name ALL is special and specifies setting all of the modules to the
+specified fwlog_level.
+
+Example usage to configure the modules::
+
+  # echo LINK VERBOSE > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
+
+Enabling FW log
+~~~~~~~~~~~~~~~
+Once the desired modules are configured the user will enable the logging. To do
+this the user can write a 1 (enable) or 0 (disable) to 'fwlog/enable'. An
+example is::
+
+  # echo 1 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/enable
+
+Retrieving FW log data
+~~~~~~~~~~~~~~~~~~~~~~
+The FW log data can be retrieved by reading from 'fwlog/data'. The user can
+write to 'fwlog/data' to clear the data. The data can only be cleared when FW
+logging is disabled. The FW log data is a binary file that is sent to Intel and
+used to help debug user issues.
+
+An example to read the data is::
+
+  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/data > fwlog.bin
+
+An example to clear the data is::
+
+  # echo 0 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/data
+
+Changing how often the log events are sent to the driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver receives FW log data from the Admin Receive Queue (ARQ). The
+frequency that the FW sends the ARQ events can be configured by writing to
+'fwlog/resolution'. The range is 1-128 (1 means push every log message, 128
+means push only when the max AQ command buffer is full). The suggested value is
+10. The user can see what the value is configured to by reading
+'fwlog/resolution'. An example to set the value is::
+
+  # echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
+
+Configuring the number of buffers used to store FW log data
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver stores FW log data in a ring within the driver. The default size of
+the ring is 256 4K buffers. Some use cases may require more or less data so
+the user can change the number of buffers that are allocated for FW log data.
+To change the number of buffers write to 'fwlog/nr_buffs'. The value must be a
+power of two and between the values 64-512. FW logging must be disabled to
+change the value. An example of changing the value is::
+
+  # echo 128 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/nr_buffs
+
+
 Performance Optimization
 ========================
 Driver defaults are meant to fit a wide variety of workloads, but if further
-- 
2.38.1


