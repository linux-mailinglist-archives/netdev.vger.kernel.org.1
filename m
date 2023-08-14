Return-Path: <netdev+bounces-27490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A96177C288
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7891C20BA5
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A8100A7;
	Mon, 14 Aug 2023 21:41:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68337DF5E
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE959C433C9;
	Mon, 14 Aug 2023 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049309;
	bh=9D9D0jWEj9N4XyHmx1PZvD4w5zPKGy/y1Ubhjp+xBXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srIrp4P+QjGvEHl05XZotwYEL905C83NcE2YyEFZmWXepHoF37d5jVP2jgNJ7w+Gx
	 ncYvmsi4NcLHcjC9sa2S6nkqh5QqosinMowjHQIuMTenjt21eh11gJPy1VvK6p6dpX
	 DAC84kKaVop6RfAtjwJOHjafIgDRqUUDQP/b3O4VSUfAdkY9xqwRPjTb2DYNKQ/H34
	 1T738PsNZX0XJ3E3X8GbGNruWfVTD2a7dX/rLDqmkJZIWtF71DeAanKzeyMi/uNflu
	 5FKJsT+7mM8vIGRwNwbqWvB/twbt+DKEAiZlr5HcPLMnrR+/6r1uyLJkh6qvCrA+Ua
	 9gF8TUD9W99WQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 01/14] net/mlx5: Consolidate devlink documentation in devlink/mlx5.rst
Date: Mon, 14 Aug 2023 14:41:31 -0700
Message-ID: <20230814214144.159464-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

De-duplicate documentation by removing mellanox/mlx5/devlink.rst. Instead,
only use the generic devlink documentation directory to document mlx5
devlink parameters. Avoid providing general devlink tool usage information
in mlx5-specific documentation.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/devlink.rst        | 313 ------------------
 .../ethernet/mellanox/mlx5/index.rst          |   1 -
 Documentation/networking/devlink/mlx5.rst     | 179 ++++++++++
 3 files changed, 179 insertions(+), 314 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst
deleted file mode 100644
index a4edf908b707..000000000000
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst
+++ /dev/null
@@ -1,313 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
-.. include:: <isonum.txt>
-
-=======
-Devlink
-=======
-
-:Copyright: |copy| 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
-
-Contents
-========
-
-- `Info`_
-- `Parameters`_
-- `Health reporters`_
-
-Info
-====
-
-The devlink info reports the running and stored firmware versions on device.
-It also prints the device PSID which represents the HCA board type ID.
-
-User command example::
-
-   $ devlink dev info pci/0000:00:06.0
-      pci/0000:00:06.0:
-      driver mlx5_core
-      versions:
-         fixed:
-            fw.psid MT_0000000009
-         running:
-            fw.version 16.26.0100
-         stored:
-            fw.version 16.26.0100
-
-Parameters
-==========
-
-flow_steering_mode: Device flow steering mode
----------------------------------------------
-The flow steering mode parameter controls the flow steering mode of the driver.
-Two modes are supported:
-
-1. 'dmfs' - Device managed flow steering.
-2. 'smfs' - Software/Driver managed flow steering.
-
-In DMFS mode, the HW steering entities are created and managed through the
-Firmware.
-In SMFS mode, the HW steering entities are created and managed though by
-the driver directly into hardware without firmware intervention.
-
-SMFS mode is faster and provides better rule insertion rate compared to default DMFS mode.
-
-User command examples:
-
-- Set SMFS flow steering mode::
-
-    $ devlink dev param set pci/0000:06:00.0 name flow_steering_mode value "smfs" cmode runtime
-
-- Read device flow steering mode::
-
-    $ devlink dev param show pci/0000:06:00.0 name flow_steering_mode
-      pci/0000:06:00.0:
-      name flow_steering_mode type driver-specific
-      values:
-         cmode runtime value smfs
-
-enable_roce: RoCE enablement state
-----------------------------------
-If the device supports RoCE disablement, RoCE enablement state controls device
-support for RoCE capability. Otherwise, the control occurs in the driver stack.
-When RoCE is disabled at the driver level, only raw ethernet QPs are supported.
-
-To change RoCE enablement state, a user must change the driverinit cmode value
-and run devlink reload.
-
-User command examples:
-
-- Disable RoCE::
-
-    $ devlink dev param set pci/0000:06:00.0 name enable_roce value false cmode driverinit
-    $ devlink dev reload pci/0000:06:00.0
-
-- Read RoCE enablement state::
-
-    $ devlink dev param show pci/0000:06:00.0 name enable_roce
-      pci/0000:06:00.0:
-      name enable_roce type generic
-      values:
-         cmode driverinit value true
-
-esw_port_metadata: Eswitch port metadata state
-----------------------------------------------
-When applicable, disabling eswitch metadata can increase packet rate
-up to 20% depending on the use case and packet sizes.
-
-Eswitch port metadata state controls whether to internally tag packets with
-metadata. Metadata tagging must be enabled for multi-port RoCE, failover
-between representors and stacked devices.
-By default metadata is enabled on the supported devices in E-switch.
-Metadata is applicable only for E-switch in switchdev mode and
-users may disable it when NONE of the below use cases will be in use:
-
-1. HCA is in Dual/multi-port RoCE mode.
-2. VF/SF representor bonding (Usually used for Live migration)
-3. Stacked devices
-
-When metadata is disabled, the above use cases will fail to initialize if
-users try to enable them.
-
-- Show eswitch port metadata::
-
-    $ devlink dev param show pci/0000:06:00.0 name esw_port_metadata
-      pci/0000:06:00.0:
-        name esw_port_metadata type driver-specific
-          values:
-            cmode runtime value true
-
-- Disable eswitch port metadata::
-
-    $ devlink dev param set pci/0000:06:00.0 name esw_port_metadata value false cmode runtime
-
-- Change eswitch mode to switchdev mode where after choosing the metadata value::
-
-    $ devlink dev eswitch set pci/0000:06:00.0 mode switchdev
-
-hairpin_num_queues: Number of hairpin queues
---------------------------------------------
-We refer to a TC NIC rule that involves forwarding as "hairpin".
-
-Hairpin queues are mlx5 hardware specific implementation for hardware
-forwarding of such packets.
-
-- Show the number of hairpin queues::
-
-    $ devlink dev param show pci/0000:06:00.0 name hairpin_num_queues
-      pci/0000:06:00.0:
-        name hairpin_num_queues type driver-specific
-          values:
-            cmode driverinit value 2
-
-- Change the number of hairpin queues::
-
-    $ devlink dev param set pci/0000:06:00.0 name hairpin_num_queues value 4 cmode driverinit
-
-hairpin_queue_size: Size of the hairpin queues
-----------------------------------------------
-Control the size of the hairpin queues.
-
-- Show the size of the hairpin queues::
-
-    $ devlink dev param show pci/0000:06:00.0 name hairpin_queue_size
-      pci/0000:06:00.0:
-        name hairpin_queue_size type driver-specific
-          values:
-            cmode driverinit value 1024
-
-- Change the size (in packets) of the hairpin queues::
-
-    $ devlink dev param set pci/0000:06:00.0 name hairpin_queue_size value 512 cmode driverinit
-
-Health reporters
-================
-
-tx reporter
------------
-The tx reporter is responsible for reporting and recovering of the following two error scenarios:
-
-- tx timeout
-    Report on kernel tx timeout detection.
-    Recover by searching lost interrupts.
-- tx error completion
-    Report on error tx completion.
-    Recover by flushing the tx queue and reset it.
-
-tx reporter also support on demand diagnose callback, on which it provides
-real time information of its send queues status.
-
-User commands examples:
-
-- Diagnose send queues status::
-
-    $ devlink health diagnose pci/0000:82:00.0 reporter tx
-
-.. note::
-   This command has valid output only when interface is up, otherwise the command has empty output.
-
-- Show number of tx errors indicated, number of recover flows ended successfully,
-  is autorecover enabled and graceful period from last recover::
-
-    $ devlink health show pci/0000:82:00.0 reporter tx
-
-rx reporter
------------
-The rx reporter is responsible for reporting and recovering of the following two error scenarios:
-
-- rx queues' initialization (population) timeout
-    Population of rx queues' descriptors on ring initialization is done
-    in napi context via triggering an irq. In case of a failure to get
-    the minimum amount of descriptors, a timeout would occur, and
-    descriptors could be recovered by polling the EQ (Event Queue).
-- rx completions with errors (reported by HW on interrupt context)
-    Report on rx completion error.
-    Recover (if needed) by flushing the related queue and reset it.
-
-rx reporter also supports on demand diagnose callback, on which it
-provides real time information of its receive queues' status.
-
-- Diagnose rx queues' status and corresponding completion queue::
-
-    $ devlink health diagnose pci/0000:82:00.0 reporter rx
-
-NOTE: This command has valid output only when interface is up. Otherwise, the command has empty output.
-
-- Show number of rx errors indicated, number of recover flows ended successfully,
-  is autorecover enabled, and graceful period from last recover::
-
-    $ devlink health show pci/0000:82:00.0 reporter rx
-
-fw reporter
------------
-The fw reporter implements `diagnose` and `dump` callbacks.
-It follows symptoms of fw error such as fw syndrome by triggering
-fw core dump and storing it into the dump buffer.
-The fw reporter diagnose command can be triggered any time by the user to check
-current fw status.
-
-User commands examples:
-
-- Check fw heath status::
-
-    $ devlink health diagnose pci/0000:82:00.0 reporter fw
-
-- Read FW core dump if already stored or trigger new one::
-
-    $ devlink health dump show pci/0000:82:00.0 reporter fw
-
-.. note::
-   This command can run only on the PF which has fw tracer ownership,
-   running it on other PF or any VF will return "Operation not permitted".
-
-fw fatal reporter
------------------
-The fw fatal reporter implements `dump` and `recover` callbacks.
-It follows fatal errors indications by CR-space dump and recover flow.
-The CR-space dump uses vsc interface which is valid even if the FW command
-interface is not functional, which is the case in most FW fatal errors.
-The recover function runs recover flow which reloads the driver and triggers fw
-reset if needed.
-On firmware error, the health buffer is dumped into the dmesg. The log
-level is derived from the error's severity (given in health buffer).
-
-User commands examples:
-
-- Run fw recover flow manually::
-
-    $ devlink health recover pci/0000:82:00.0 reporter fw_fatal
-
-- Read FW CR-space dump if already stored or trigger new one::
-
-    $ devlink health dump show pci/0000:82:00.1 reporter fw_fatal
-
-.. note::
-   This command can run only on PF.
-
-vnic reporter
--------------
-The vnic reporter implements only the `diagnose` callback.
-It is responsible for querying the vnic diagnostic counters from fw and displaying
-them in realtime.
-
-Description of the vnic counters:
-
-- total_q_under_processor_handle
-        number of queues in an error state due to
-        an async error or errored command.
-- send_queue_priority_update_flow
-        number of QP/SQ priority/SL update events.
-- cq_overrun
-        number of times CQ entered an error state due to an overflow.
-- async_eq_overrun
-        number of times an EQ mapped to async events was overrun.
-        comp_eq_overrun number of times an EQ mapped to completion events was
-        overrun.
-- quota_exceeded_command
-        number of commands issued and failed due to quota exceeded.
-- invalid_command
-        number of commands issued and failed dues to any reason other than quota
-        exceeded.
-- nic_receive_steering_discard
-        number of packets that completed RX flow
-        steering but were discarded due to a mismatch in flow table.
-- generated_pkt_steering_fail
-	number of packets generated by the VNIC experiencing unexpected steering
-	failure (at any point in steering flow).
-- handled_pkt_steering_fail
-	number of packets handled by the VNIC experiencing unexpected steering
-	failure (at any point in steering flow owned by the VNIC, including the FDB
-	for the eswitch owner).
-
-User commands examples:
-
-- Diagnose PF/VF vnic counters::
-
-        $ devlink health diagnose pci/0000:82:00.1 reporter vnic
-
-- Diagnose representor vnic counters (performed by supplying devlink port of the
-  representor, which can be obtained via devlink port command)::
-
-        $ devlink health diagnose pci/0000:82:00.1/65537 reporter vnic
-
-.. note::
-   This command can run over all interfaces such as PF/VF and representor ports.
diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/index.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/index.rst
index 3fdcd6b61ccf..581a91caa579 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/index.rst
@@ -13,7 +13,6 @@ Contents:
    :maxdepth: 2
 
    kconfig
-   devlink
    switchdev
    tracepoints
    counters
diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 202798d6501e..196a4bb28df1 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -18,6 +18,11 @@ Parameters
    * - ``enable_roce``
      - driverinit
      - Type: Boolean
+
+       If the device supports RoCE disablement, RoCE enablement state controls
+       device support for RoCE capability. Otherwise, the control occurs in the
+       driver stack. When RoCE is disabled at the driver level, only raw
+       ethernet QPs are supported.
    * - ``io_eq_size``
      - driverinit
      - The range is between 64 and 4096.
@@ -48,6 +53,9 @@ parameters.
        * ``smfs`` Software managed flow steering. In SMFS mode, the HW
          steering entities are created and manage through the driver without
          firmware intervention.
+
+       SMFS mode is faster and provides better rule insertion rate compared to
+       default DMFS mode.
    * - ``fdb_large_groups``
      - u32
      - driverinit
@@ -71,7 +79,24 @@ parameters.
        deprecated.
 
        Default: disabled
+   * - ``esw_port_metadata``
+     - Boolean
+     - runtime
+     - When applicable, disabling eswitch metadata can increase packet rate up
+       to 20% depending on the use case and packet sizes.
+
+       Eswitch port metadata state controls whether to internally tag packets
+       with metadata. Metadata tagging must be enabled for multi-port RoCE,
+       failover between representors and stacked devices. By default metadata is
+       enabled on the supported devices in E-switch. Metadata is applicable only
+       for E-switch in switchdev mode and users may disable it when NONE of the
+       below use cases will be in use:
+       1. HCA is in Dual/multi-port RoCE mode.
+       2. VF/SF representor bonding (Usually used for Live migration)
+       3. Stacked devices
 
+       When metadata is disabled, the above use cases will fail to initialize if
+       users try to enable them.
    * - ``hairpin_num_queues``
      - u32
      - driverinit
@@ -104,3 +129,157 @@ The ``mlx5`` driver reports the following versions
    * - ``fw.version``
      - stored, running
      - Three digit major.minor.subminor firmware version number.
+
+Health reporters
+================
+
+tx reporter
+-----------
+The tx reporter is responsible for reporting and recovering of the following two error scenarios:
+
+- tx timeout
+    Report on kernel tx timeout detection.
+    Recover by searching lost interrupts.
+- tx error completion
+    Report on error tx completion.
+    Recover by flushing the tx queue and reset it.
+
+tx reporter also support on demand diagnose callback, on which it provides
+real time information of its send queues status.
+
+User commands examples:
+
+- Diagnose send queues status::
+
+    $ devlink health diagnose pci/0000:82:00.0 reporter tx
+
+.. note::
+   This command has valid output only when interface is up, otherwise the command has empty output.
+
+- Show number of tx errors indicated, number of recover flows ended successfully,
+  is autorecover enabled and graceful period from last recover::
+
+    $ devlink health show pci/0000:82:00.0 reporter tx
+
+rx reporter
+-----------
+The rx reporter is responsible for reporting and recovering of the following two error scenarios:
+
+- rx queues' initialization (population) timeout
+    Population of rx queues' descriptors on ring initialization is done
+    in napi context via triggering an irq. In case of a failure to get
+    the minimum amount of descriptors, a timeout would occur, and
+    descriptors could be recovered by polling the EQ (Event Queue).
+- rx completions with errors (reported by HW on interrupt context)
+    Report on rx completion error.
+    Recover (if needed) by flushing the related queue and reset it.
+
+rx reporter also supports on demand diagnose callback, on which it
+provides real time information of its receive queues' status.
+
+- Diagnose rx queues' status and corresponding completion queue::
+
+    $ devlink health diagnose pci/0000:82:00.0 reporter rx
+
+.. note::
+   This command has valid output only when interface is up. Otherwise, the command has empty output.
+
+- Show number of rx errors indicated, number of recover flows ended successfully,
+  is autorecover enabled, and graceful period from last recover::
+
+    $ devlink health show pci/0000:82:00.0 reporter rx
+
+fw reporter
+-----------
+The fw reporter implements `diagnose` and `dump` callbacks.
+It follows symptoms of fw error such as fw syndrome by triggering
+fw core dump and storing it into the dump buffer.
+The fw reporter diagnose command can be triggered any time by the user to check
+current fw status.
+
+User commands examples:
+
+- Check fw heath status::
+
+    $ devlink health diagnose pci/0000:82:00.0 reporter fw
+
+- Read FW core dump if already stored or trigger new one::
+
+    $ devlink health dump show pci/0000:82:00.0 reporter fw
+
+.. note::
+   This command can run only on the PF which has fw tracer ownership,
+   running it on other PF or any VF will return "Operation not permitted".
+
+fw fatal reporter
+-----------------
+The fw fatal reporter implements `dump` and `recover` callbacks.
+It follows fatal errors indications by CR-space dump and recover flow.
+The CR-space dump uses vsc interface which is valid even if the FW command
+interface is not functional, which is the case in most FW fatal errors.
+The recover function runs recover flow which reloads the driver and triggers fw
+reset if needed.
+On firmware error, the health buffer is dumped into the dmesg. The log
+level is derived from the error's severity (given in health buffer).
+
+User commands examples:
+
+- Run fw recover flow manually::
+
+    $ devlink health recover pci/0000:82:00.0 reporter fw_fatal
+
+- Read FW CR-space dump if already stored or trigger new one::
+
+    $ devlink health dump show pci/0000:82:00.1 reporter fw_fatal
+
+.. note::
+   This command can run only on PF.
+
+vnic reporter
+-------------
+The vnic reporter implements only the `diagnose` callback.
+It is responsible for querying the vnic diagnostic counters from fw and displaying
+them in realtime.
+
+Description of the vnic counters:
+
+- total_q_under_processor_handle
+        number of queues in an error state due to
+        an async error or errored command.
+- send_queue_priority_update_flow
+        number of QP/SQ priority/SL update events.
+- cq_overrun
+        number of times CQ entered an error state due to an overflow.
+- async_eq_overrun
+        number of times an EQ mapped to async events was overrun.
+        comp_eq_overrun number of times an EQ mapped to completion events was
+        overrun.
+- quota_exceeded_command
+        number of commands issued and failed due to quota exceeded.
+- invalid_command
+        number of commands issued and failed dues to any reason other than quota
+        exceeded.
+- nic_receive_steering_discard
+        number of packets that completed RX flow
+        steering but were discarded due to a mismatch in flow table.
+- generated_pkt_steering_fail
+	number of packets generated by the VNIC experiencing unexpected steering
+	failure (at any point in steering flow).
+- handled_pkt_steering_fail
+	number of packets handled by the VNIC experiencing unexpected steering
+	failure (at any point in steering flow owned by the VNIC, including the FDB
+	for the eswitch owner).
+
+User commands examples:
+
+- Diagnose PF/VF vnic counters::
+
+        $ devlink health diagnose pci/0000:82:00.1 reporter vnic
+
+- Diagnose representor vnic counters (performed by supplying devlink port of the
+  representor, which can be obtained via devlink port command)::
+
+        $ devlink health diagnose pci/0000:82:00.1/65537 reporter vnic
+
+.. note::
+   This command can run over all interfaces such as PF/VF and representor ports.
-- 
2.41.0


