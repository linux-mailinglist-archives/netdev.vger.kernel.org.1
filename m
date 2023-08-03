Return-Path: <netdev+bounces-23867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E986076DE63
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D069B1C20F99
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF05383;
	Thu,  3 Aug 2023 02:41:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F7187B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:41:49 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2151.outbound.protection.outlook.com [40.92.62.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA94E2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFEDHZ7eRLhgKLnvvxR3wgISq5i3vC2LVyQGyl8YMoiT36g7wQOy+JPsRuhtegcjVmUTsqIi7WXnlnB/vWceUQvzgKpP6O5ry/6wrgCzO03XQVlS2ldpUqaSGORh7CsfKTW4qr0GmSvbYQhqaA3zNeukn+UVL0M8G3dHRq0vN5J5+CaYF0tr1YTsphdriwiyzWStN0IfSkJBkYk1daPP1KCri4r/gT9rYD2rD23TaoQl8/GGgsPQJnUoY5N1hrzkoz9mufKCS29wDjoRDvKC11HdfOloc3bZATuainScTjehQ2ejBXrnv2O6zPFLzzTag4L3WGn0newRyDlqaILsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbb2137+Um2SBCJLfyA8j7g0pN7Kfw2jjoEAmW+S5/4=;
 b=L2LBbMHS4BMX0hIeUZBsJdHjGsaji+eEjq5tmya8PBEcIK+VVzXzeYeaLCjzldYyIt7JZBSo5IVdfa3kwMtmzDO8Wowv9DmN6g61PniKhrTGRED3kn/UTIY+yT/SdD6sfdNdVO+YdWiBqAYvOO0woCdVfeg/ix0n3RVf044EguFErhmeLMx6lPihzsUsK8cBQx6Hrx1aVC1Q4teRZRntEIMQvSm4zxGz+yfx9iTSBPy7xnf+WZX+3wbrKDnR0cjZQGiDv/mhu/wu4gWF26k12FrOaXy1hfjqVw1YX2km53RHz/KPscnuCW5WqJ+I+XvdsHPaEwiDxEhxKdqPIPn6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbb2137+Um2SBCJLfyA8j7g0pN7Kfw2jjoEAmW+S5/4=;
 b=OCnOdwryx1t2Wgf/Nl6sUMMqlPobP4wrV8QZx5vhiaV0zK5D3bd4LBbns6zyZyDtOq0LG5pB20OawzBA4uGcs1azG/DcZMHt7sQBDHv8KjEDGk5G3WzwIV7xfLkdOT2JpV3jMHZDdljCa/3fo5NdkQ3LPcH8W+Atdxe8dtmxPU9D/iACYj001UxLz8yVZyvfkrCn5DBgxxRPHIMH02pCiHRgoJjfioDcThEAnxkrNRBHuSRdIDXH77nsd3JxEePrI8cPYBMau5A4ipXE5s2Ekzr/KgQUybnbiO9Cj8UrWb3R9v9o/FKDO013B89893bbaJ7VGS46YzU+4PJmHAoXPA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3585.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 02:41:39 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:41:39 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	johannes@sipsolutions.net,
	ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	edumazet@google.com,
	pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	m.chetan.kumar@linux.intel.com,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	soumya.prakash.mishra@intel.com,
	jesse.brandeburg@intel.com,
	danielwinkler@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next 6/6] net: wwan: t7xx: Devlink documentation
Date: Thu,  3 Aug 2023 10:41:07 +0800
Message-ID:
 <MEYP282MB269764FF815272CA2BA19067BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1grYUK2lcLrpAzrai2zSgwY/tos+rC4M]
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803024107.3480-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3585:EE_
X-MS-Office365-Filtering-Correlation-Id: 33785683-70bd-4451-2100-08db93cb29db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cOSr3MNsMvRj9R0zQw7uGZ/KCvf39EZCsbnCnoh5rQbaLuNBU7OHb4uzZbAckI7BkzG1TglyV7RHPeocE00L6kUujv4kZ1Um2kamAL74gJY1lFLyNnQp/zXHwDOHqGJ4BrBZJYsV46PLPVhc8D4eNt9SYTN5OqzmcRahQRe3HZzhcm9Fwn6SSGzwCQgkbyEbNJqHbuVOjT17Zey5YklD5sGYJKIV0uZ3awzhI6gWQje0w5yeSQGq1uETRMFJNfge/Z1EZpeggjJxoHc2mhmBWU/S3c/bw+WZAtvCVfeMX5XOgCLZVrgoN41sXfjTE6PaZSuja743njhTZkjh8nq/CO/JF01QLeCMnr/Er0h82/+pwDH6Cn60dv+j6hFUN3gIu8io7l5fmJcMGxLHq2a4DY7YV9luo7xC77jdf2vNgNsvS80izDWwowGyq4/p2X2FgD5tJbNE33nq7RlboHec8mxsSESHag3Ikcg1MSO+zhQGNmhd+M9rm+xlKikBkVUdlvNa2ByjQpTsF/JZ1Q2pHOYm06oYx9AqTMfk719o0/U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2WGJDaEYYgyUebBCSL35O2MewEyu2NrJY9e1pQE3XxEqLmjD55arL9CQ2WA6?=
 =?us-ascii?Q?DRe64lgkaxSEb5G0DrYHELJK5TAU8WH/vHd7IiPmf6KMtZrdbHNxl61PXjOp?=
 =?us-ascii?Q?w+F73ZRXA/3asdq/67mW5MyeP2tRJJa6oaFSpzZXj1NnpQ6KY1leihaBgKZ3?=
 =?us-ascii?Q?lteLRBvfcvUp63yR4kx/r9Mn9uAO+dQcJ7VqnjAvQ3W4H00AFWPdpzpGk3E8?=
 =?us-ascii?Q?mBgUCKsBlADOQZVvG4zpRECBbJov8yr+NDiHwq5PA8SdnK62NaqbErFPoqzd?=
 =?us-ascii?Q?UvCSyR8gwTK9eDGoEqW4kZUbQrhhWwXm0EIlVLVZfEWCjeNOtelhPjAf4R6O?=
 =?us-ascii?Q?K5BUU7tajv6lngubgSDV38t99asZrvMtlX1LRa1fldwlK+K9PlIave2Jksgu?=
 =?us-ascii?Q?oi/jHNlKGgTPOP9cCsjE+wqrangekqz0Pq67ncVQFeYqTDv1iPqn6Dp4GweI?=
 =?us-ascii?Q?07iepvDcS3mBpua903zgMSpTRhSXmHPVqFHweCiw84xXnkor/EIFoMgcbpOQ?=
 =?us-ascii?Q?mk6LSHW2zL/r+SEXpQGj6fQMfj2ckU7I5+SL4LrtggY7eHb6mfnWUt60WqwF?=
 =?us-ascii?Q?mYxWwvlfba9XLerP7orD0xbEtYh4+Lgw6gj2YNBpUn30Ds156uFOibHCDGuk?=
 =?us-ascii?Q?Ntjblr5Rrwyqcc9GGA9tehfGjSE0enW/XPMUon5COBn6GkmBf3yqEhPKlz7i?=
 =?us-ascii?Q?4un50tcoVuMZWlM1q8eys74O4BUTZR/rrvWjkAsgHQBiZ5BhKADiE2XSI6WL?=
 =?us-ascii?Q?EaQSmHzoVHgbkdT2NQ/BJ7AkGiAO8gcYxMTmmAETiskRn9YvlszOA1QIR2q5?=
 =?us-ascii?Q?ACsy9F84jK2QEPvHGWqd5l38HJkvVxb6mmrnMrTPIMvNxxF3GFMpibSqLZRv?=
 =?us-ascii?Q?CO2qRYRCpX6TBb5h3a9Tg333mm9QMcNu+3qekilvDMU/sPa61+ZVTrG2L8UO?=
 =?us-ascii?Q?1QLxwzv036oUcfZvClO1DlXNLrurjUDJHSjcgqcALAR/cOZFgG7iXijd1aFT?=
 =?us-ascii?Q?0BkUi7Mq4NeZAH/3TLYkFvCSZVuMEqDnD5i20CLgq8UksZLRyrSpjjBDCRO9?=
 =?us-ascii?Q?O0dwmPjmfqvldXqhspIQBT+Rn8kY8f45/7kpiKQFtEd7v9fCmtRENyHoM72I?=
 =?us-ascii?Q?NIp4/Bp1mNEaYMnkG/UiiU7BU97fPKe3Eit+ikVgoG7qWvugutfxaXFwrV+c?=
 =?us-ascii?Q?hzEtX/AKq5Xmouv3LrmKAu93CO7/GVjPvm5F9zKxmZCDBCmTOLrRnRHReCA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 33785683-70bd-4451-2100-08db93cb29db
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:41:39.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinjian Song <jinjian.song@fibocom.com>

Document the t7xx devlink commands usage for firmware flashing &
coredump collection.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/f902d4a0cb807a205687f7e693079fba72ca7341.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 Documentation/networking/devlink/index.rst |   1 +
 Documentation/networking/devlink/t7xx.rst  | 232 +++++++++++++++++++++
 2 files changed, 233 insertions(+)
 create mode 100644 Documentation/networking/devlink/t7xx.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index b49749e2b9a6..f101781105ca 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -67,3 +67,4 @@ parameters, info versions, and other features it supports.
    iosm
    octeontx2
    sfc
+   mtk_t7xx
diff --git a/Documentation/networking/devlink/t7xx.rst b/Documentation/networking/devlink/t7xx.rst
new file mode 100644
index 000000000000..1f5108338ef0
--- /dev/null
+++ b/Documentation/networking/devlink/t7xx.rst
@@ -0,0 +1,232 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+t7xx devlink support
+====================
+
+This document describes the devlink features implemented by the ``t7xx``
+device driver.
+
+Parameters
+==========
+The ``t7xx`` driver implements the following driver-specific parameters.
+
+.. list-table:: Driver-specific parameters
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``fastboot``
+     - boolean
+     - driverinit
+     - Set this param to enter fastboot mode.
+
+Flash Update
+============
+
+The ``t7xx`` driver implements the flash update using the ``devlink-flash``
+interface.
+
+The driver uses ``DEVLINK_SUPPORT_FLASH_UPDATE_OVERWRITE_MASK`` to identify the type of
+firmware image that need to be programmed upon the request by user space application.
+
+``t7xx`` driver uses fastboot protocol for firmware flashing. In the firmware
+flashing procedure, fastboot command & response are exchanged between driver
+and wwan device.
+
+::
+
+  $ devlink dev param set pci/0000:bdf name fastboot value 1 cmode driverinit
+
+The devlink param fastboot is set to true via devlink param command, by
+passing name ``fastboot``, value ``1`` and cmode ``driverinit``.
+
+::
+
+  $ devlink dev reload pci/0000:$bdf action driver_reinit
+
+The wwan device is put into fastboot mode via devlink reload command, by
+passing ``driver_reinit`` action.
+
+::
+
+  $ devlink dev reload pci/0000:$bdf action fw_activate
+
+Upon completion of firmware flashing or coredump collection the wwan device is
+reset to normal mode using devlink reload command, by passing ``fw_activate``
+action.
+
+Flash Commands
+--------------
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file preloader_k6880v1_mdot2_datacard.bin component "preloader"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file loader_ext-verified.img component "loader_ext1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file tee-verified.img component "tee1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file lk-verified.img component "lk"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file spmfw-verified.img component "spmfw"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file sspm-verified.img component "sspm_1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file mcupm-verified.img component "mcupm_1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file dpm-verified.img component "dpm_1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file boot-verified.img component "boot"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file root.squashfs component "rootfs"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file modem-verified.img component "md1img"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file dsp-verified.bin component "md1dsp"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file OP_OTA.img component "mcf1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file OEM_OTA.img component "mcf2"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file DEV_OTA.img component "mcf3"
+
+Note: Component selects the partition type to be programmed.
+
+
+The supported list of firmware image types is described below.
+
+.. list-table:: Firmware Image types
+    :widths: 15 85
+
+    * - Name
+      - Description
+    * - ``preloader``
+      - The first-stage bootloader image
+    * - ``loader_ext1``
+      - Preloader extension image
+    * - ``tee1``
+      - ARM trusted firmware and TEE (Trusted Execution Environment) image
+    * - ``lk``
+      - The second-stage bootloader image
+    * - ``spmfw``
+      - MediaTek in-house ASIC for power management image
+    * - ``sspm_1``
+      - MediaTek in-house ASIC for power management under secure world image
+    * - ``mcupm_1``
+      - MediaTek in-house ASIC for cpu power management image
+    * - ``dpm_1``
+      - MediaTek in-house ASIC for dram power management image
+    * - ``boot``
+      - The kernel and dtb image
+    * - ``rootfs``
+      - Root filesystem image
+    * - ``md1img``
+      - Modem image
+    * - ``md1dsp``
+      - Modem DSP image
+    * - ``mcf1``
+      - Modem OTA image (Modem Configuration Framework) for operators
+    * - ``mcf2``
+      - Modem OTA image (Modem Configuration Framework) for OEM vendors
+    * - ``mcf3``
+      - Modem OTA image (other usage) for OEM configurations
+
+
+Regions
+=======
+
+The ``t7xx`` driver supports core dump collection in exception state and second
+stage bootloader log collection in fastboot mode. The log snapshot is taken by
+the driver using fastboot commands.
+
+Region commands
+---------------
+
+::
+
+  $ devlink region show
+
+This command list the regions implemented by driver. These regions are accessed
+for device internal data. Below table describes the regions.
+
+.. list-table:: Regions
+    :widths: 15 85
+
+    * - Name
+      - Description
+    * - ``mr_dump``
+      - The detailed modem component logs are captured in this region
+    * - ``lk_dump``
+      - This region dumps the current snapshot of lk
+
+Coredump Collection
+~~~~~~~~~~~~~~~~~~
+
+::
+
+  $ devlink region new mr_dump
+
+::
+
+  $ devlink region read mr_dump snapshot 0 address 0 length $len
+
+::
+
+  $ devlink region del mr_dump snapshot 0
+
+Note: $len is actual len to be dumped.
+
+The userspace application uses these commands for obtaining the modem component
+logs when device encounters an exception.
+
+Second Stage Bootloader dump
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+  $ devlink region new lk_dump
+
+::
+
+  $ devlink region read lk_dump snapshot 0 address 0 length $len
+
+::
+
+  $ devlink region del lk_dump snapshot 0
+
+Note: $len is actual len to be dumped.
+
+In fastboot mode the userspace application uses these commands for obtaining the
+current snapshot of second stage bootloader.
+
-- 
2.34.1


