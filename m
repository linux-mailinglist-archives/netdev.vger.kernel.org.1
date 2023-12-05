Return-Path: <netdev+bounces-54115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE30806076
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF7A1F21667
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C16E5BB;
	Tue,  5 Dec 2023 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOI5DWCu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E26C1AA;
	Tue,  5 Dec 2023 13:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810783; x=1733346783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeJEGG5sFogcxVYcE4xCnsdCdmkxF2xsMcIKN/Q4UTw=;
  b=aOI5DWCuvGuD1x/kbumGMkTB/a6R32bWBC1mtNaSWtOb4K95wbTTXhdO
   Tukb+bAiSd2q7Sfwz+Jqqe2FTYEPJgTOLgfE9sShQZaisvQyoUaOZToHB
   y0GD7UeLtjDhFMnsO7DTH8oIAOg3W6zyKf0wnBIyzl8ZPiaQ9KsUtV2ei
   aECNBSabMxgFyT1Xxr7IUs/5G8D0Q49Ni+23ne9h4CSwY7Pkdll9g0R45
   h6nO3TT4e0ZXqFTXoIouN40tpkMg9G4DVqtNKOuXTiyMvkN1GIqkOstKm
   yYOZeUT7jIofyEMI5+sZoKYfI/ZWryochd7opwa/JaM2UOGN6GTG3b8cj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391126836"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="391126836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944406838"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="944406838"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 13:12:59 -0800
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
Subject: [PATCH net-next v5 5/5] ice: add documentation for FW logging
Date: Tue,  5 Dec 2023 13:12:48 -0800
Message-ID: <20231205211251.2122874-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
References: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
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


