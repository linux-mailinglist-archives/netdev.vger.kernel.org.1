Return-Path: <netdev+bounces-57639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7129B813AE9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B05282F8E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41276A320;
	Thu, 14 Dec 2023 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCmMDKsp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A36A011;
	Thu, 14 Dec 2023 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702582900; x=1734118900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeJEGG5sFogcxVYcE4xCnsdCdmkxF2xsMcIKN/Q4UTw=;
  b=QCmMDKspDcbAuPeQERIfCMG2hqmqkpPg7vdeqAhsjWoHax743ZQI4SOm
   TWuVVGRAzfFKmFDljJVV0+T9yWPDD2+p6zcDJlcycH7LwtAjFx30e6hCQ
   uGJc7U00L7NsDJMPWT0TvyueM1N6a8DOdrKAHA4THnN+UNsg64Z942OzQ
   YiE0EAInQpmgS6fYtplLfFvnM2R7vzHx8knOOA7yMWoTcwM3Ai+AiRoMC
   bhe1CgD4vUzFGYEFFsu32SCa+U3fiDIZzmAeB3qL9wiRAZo490uoGYVJO
   9du9bGxUIbMfifcOCB1PtY/GBur5sKno/7M5lpOvu84OWP/GU6IirX8g0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="399013871"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="399013871"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750666558"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="750666558"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2023 11:41:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	vaishnavi.tipireddy@intel.com,
	horms@kernel.org,
	leon@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	rdunlap@infradead.org
Subject: [PATCH net-next v6 5/5] ice: add documentation for FW logging
Date: Thu, 14 Dec 2023 11:40:40 -0800
Message-ID: <20231214194042.2141361-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
References: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Add documentation for FW logging in
Documentation/networking/device_drivers/ethernet/intel/ice.rst

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../device_drivers/ethernet/intel/ice.rst     | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index e4d065c55ea8..5038e54586af 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -895,6 +895,147 @@ driver writes raw bytes by the GNSS object to the receiver through i2c. Please
 refer to the hardware GNSS module documentation for configuration details.
 
 
+Firmware (FW) logging
+---------------------
+The driver supports FW logging via the debugfs interface on PF 0 only. The FW
+running on the NIC must support FW logging; if the FW doesn't support FW logging
+the 'fwlog' file will not get created in the ice debugfs directory.
+
+Module configuration
+~~~~~~~~~~~~~~~~~~~~
+Firmware logging is configured on a per module basis. Each module can be set to
+a value independent of the other modules (unless the module 'all' is specified).
+The modules will be instantiated under the 'fwlog/modules' directory.
+
+The user can set the log level for a module by writing to the module file like
+this::
+
+  # echo <log_level> > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/<module>
+
+where
+
+* log_level is a name as described below. Each level includes the
+  messages from the previous/lower level
+
+      *	none
+      *	error
+      *	warning
+      *	normal
+      *	verbose
+
+* module is a name that represents the module to receive events for. The
+  module names are
+
+      *	general
+      *	ctrl
+      *	link
+      *	link_topo
+      *	dnl
+      *	i2c
+      *	sdp
+      *	mdio
+      *	adminq
+      *	hdma
+      *	lldp
+      *	dcbx
+      *	dcb
+      *	xlr
+      *	nvm
+      *	auth
+      *	vpd
+      *	iosf
+      *	parser
+      *	sw
+      *	scheduler
+      *	txq
+      *	rsvd
+      *	post
+      *	watchdog
+      *	task_dispatch
+      *	mng
+      *	synce
+      *	health
+      *	tsdrv
+      *	pfreg
+      *	mdlver
+      *	all
+
+The name 'all' is special and allows the user to set all of the modules to the
+specified log_level or to read the log_level of all of the modules.
+
+Example usage to configure the modules
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To set a single module to 'verbose'::
+
+  # echo verbose > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/link
+
+To set multiple modules then issue the command multiple times::
+
+  # echo verbose > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/link
+  # echo warning > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/ctrl
+  # echo none > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/dcb
+
+To set all the modules to the same value::
+
+  # echo normal > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/all
+
+To read the log_level of a specific module (e.g. module 'general')::
+
+  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/general
+
+To read the log_level of all the modules::
+
+  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules/all
+
+Enabling FW log
+~~~~~~~~~~~~~~~
+Configuring the modules indicates to the FW that the configured modules should
+generate events that the driver is interested in, but it **does not** send the
+events to the driver until the enable message is sent to the FW. To do this
+the user can write a 1 (enable) or 0 (disable) to 'fwlog/enable'. An example
+is::
+
+  # echo 1 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/enable
+
+Retrieving FW log data
+~~~~~~~~~~~~~~~~~~~~~~
+The FW log data can be retrieved by reading from 'fwlog/data'. The user can
+write any value to 'fwlog/data' to clear the data. The data can only be cleared
+when FW logging is disabled. The FW log data is a binary file that is sent to
+Intel and used to help debug user issues.
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
+'fwlog/nr_messages'. The range is 1-128 (1 means push every log message, 128
+means push only when the max AQ command buffer is full). The suggested value is
+10. The user can see what the value is configured to by reading
+'fwlog/nr_messages'. An example to set the value is::
+
+  # echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/nr_messages
+
+Configuring the amount of memory used to store FW log data
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver stores FW log data within the driver. The default size of the memory
+used to store the data is 1MB. Some use cases may require more or less data so
+the user can change the amount of memory that is allocated for FW log data.
+To change the amount of memory then write to 'fwlog/log_size'. The value must be
+one of: 128K, 256K, 512K, 1M, or 2M. FW logging must be disabled to change the
+value. An example of changing the value is::
+
+  # echo 128K > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/log_size
+
+
 Performance Optimization
 ========================
 Driver defaults are meant to fit a wide variety of workloads, but if further
-- 
2.41.0


