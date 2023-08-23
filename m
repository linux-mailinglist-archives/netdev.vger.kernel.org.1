Return-Path: <netdev+bounces-30023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE4785A64
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E802F28135C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0418C15B;
	Wed, 23 Aug 2023 14:22:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CDC8D1
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:22:51 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2162.outbound.protection.outlook.com [40.92.62.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71054E57
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9g1wH5LX8Nd4Z6lcuaGvhs2CDX7cf0NRD60mVyFE36ysrN8s4jL8dOeKcSWXLLVGUZP3Iml091Rk+AGxAA4E860jfQGqTg30GecGSwY9Y4JdySdNSulh2yFXjsqKt8jUhe1szsmiBarOTy1j3Cmm2A1VqmAVBk6sJ6LX1swwz0V3yqP7ty2fD4ie0YIxlU0AIly4HbNE1zvl5k3+Xzk4NyDcJURP4U6RWP2bXNYpy2fH61o705tHk8cCZtibtZyim8MJtymC3RV+ySxh6yeLWrx11xzaaVYhlHSp1zjC1HSnBDfBEl+9alkegII8bnkXv2r3kQEKEeqVA4DyWeD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0rxLE1CYxMOZt4mxyDq2A9/WseHQU0yGVRaESTShM8=;
 b=GqNaReR3CHgyrtGJ7yVTtc/tlp9VKUNa0bAno779Ng1NEI44xDVW4l9jEb03uqHMAiDXu2CksLokaT7DCArbBrEcX7YpZ4Xet18gSMP9cTg9XsIW0UhYu+PZ0IoSdNHoZgDI0F29lDa0K3AF8iLYU5Rk8KiD+QJg9NqAb5n+3HeN0s73cbAF2kNWtYuXSimBLTLE2ak5QZkRguLAuIt184RepcNmClXpGAw96h3lBcDU+yurfIF4FHk9UYtkSY3fE7saHjHFot2oimbfCRzzAFRjGzVGcMrVVxVtefabiZbdvRq9rj+8U23yY0nHeCJu2pOXRsC5TNsMb/sfredZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0rxLE1CYxMOZt4mxyDq2A9/WseHQU0yGVRaESTShM8=;
 b=Y2V4dUKbOAybjpPhUPC3ArHHsdt6ZiqFTtqrNoIbVVnMLqX13wa0fS1IVQqqqnniEcqOJWuvlB/4vjRGDJSAK2Wng2GygR6xKJt18R3q9qKnrrVrJEj3psSU/M8OIQS9oVVMzYXH2pOtfiyF1GwN0/fXYNNx8uxi1CjTjJqDkjMmyEU5eQPlEVX01Af6+GXId3umpXeqHX9Yx9aSjsTkdbVcJmE5VLESoo/5mIoBtALUMAyXdspnldFB5JrloMCHc5hhhC1ucldNvaWafjp68uIs7EncoGI9bVAwS8XDHjsUKzRAXK+QvmimFTdcZsfTGQR0jEwlDy9q5Hdzondgxg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3375.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:22:40 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:22:40 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	soumya.prakash.mishra@intel.com,
	nmarupaka@google.com,
	vsankar@lenovo.com
Subject: [net-next v2 5/5] net: wwan: t7xx: Devlink documentation
Date: Wed, 23 Aug 2023 22:21:29 +0800
Message-ID:
 <MEYP282MB26978F449A3C639B1DB89984BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823142129.20566-1-songjinjian@hotmail.com>
References: <20230823142129.20566-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [m6eMh0cxdIXN0dn3TVCV0yPiS3xpdzBc]
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230823142129.20566-6-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3375:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbe9145-ec6f-4f0e-107f-08dba3e46879
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IHnlQf88mFZNmGuoLwDqTl5t5oyO9WVtoNW5Dsd0erMfX2yczdvSmYNQSTRmJqtKyNXBn56Sz99JvD9eDLqsE8lrcDtYjRFKwD/NMuOpdREsga20MzQhN9jWcC8jUIa1SU/pSYERO1RYpCdVFX/r177+q/f8IDzWSmsRUvFGDN50FmrW0zwigKX0rMhVVkHTSj9lgU9kSJdYqotEMuNwgCIWq+ud3QfkaWEXMRh/0ZBwFFVx7V/zFHW8lAFXpLPEkLBFPgXHgF90ITExpZ6zFN1ri8HiAcJemRefJ0ie6lrRZoyac0sL7JTpkOOBsDD3Vad8ZvubPvUEehFh65V8u4d5uLPFns5UQrSWpMlKB4avLcEmbycAm+UnpsDc7bknqzhBKkXwWE+ZEjEtNy+syz5mthGqwEZtxDVNnmkFoEu/9JH2+tWmJYxnrpaL6Wv0rpPWxAZSmNjOUce7XJIYf2dhg2psToGdN/AxiTAd+hmnPsvDSVZf797K5iQp7Q4TsHr8z4zU1u5Ay74vCDpZHvQ5DdnsWfy72CyUlkcXOys=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T8oGBi+lbzZ0WykQFjonvabwJNNGG7+bzfJE4qkiCcdzuzs1ufgaOfAUlXbs?=
 =?us-ascii?Q?H0LtlPg8jTVwSSD8QwL1xS5v4fvZeKlAmAs+glDwGBJQdRhnhQXjtCndAeOr?=
 =?us-ascii?Q?sv4PzhOurKlxVoJqSHG+pm5641WjX292CMz9jhVS0t0kVAFUu/Z07QQVsAky?=
 =?us-ascii?Q?fcSM5k/0XsdrqFh2MiocYIpyDiJTC1dT//fFvKPqWZKe+oDJbyqX4PcJBEvf?=
 =?us-ascii?Q?5kzarFPv4BgwO8yL2CWZPQ36chh0Uz5lfAwS6cOnyd/TjJN9M6m5ivLqizVJ?=
 =?us-ascii?Q?RSE6EfGo4w4KPnU3xF9ouzqnlNzc3zIuXEgdtYP3G5TIT7tomU2BmMBs6z5Z?=
 =?us-ascii?Q?FucnJa9mRUEJ46vX7aQjUPrvV1iJUCZ6mvwTRG6duowH7o48wvBHJD63vg1P?=
 =?us-ascii?Q?t5EgeNuowrA3cIhmBBAkG+qyoNiI2yvQT1uSxe0VK+di2mMUuJy+Tr2sO7VM?=
 =?us-ascii?Q?ufNgDmJcdAMFcXm6VfPalXzLJjn4Vr4g0lgQwsRB5ehLiDsD6BtBeKi+1s7b?=
 =?us-ascii?Q?UWK2HzMk8iA3w49TnuPJYhmUQqyZEy7ncRArA8Rj69qdUA6EnMn8yTgZkoqk?=
 =?us-ascii?Q?FB+uEVOdaVbg4h0mlfWoMgrLoZS6uE/0yfo4/BjRC4BW0tQJGgsv+cvs24Hi?=
 =?us-ascii?Q?cNZ55y7GnwGK8Ctn/28usUza/dmcG7mXNc9eiEAX25dHZqvZPWZVgweFTakL?=
 =?us-ascii?Q?hrlsUUCRGFaBWlIClGlx4tF0JsUGciwIoYjtOxWXrW0To6xGFVXrl5p+FG5n?=
 =?us-ascii?Q?FqEvNA3kVFeWW7cHX3rKYCl1OowjcU3Li/lI6aweQrT9gbWDCQzQTeBQ2X9S?=
 =?us-ascii?Q?Sb5y/TvwdmUNzwOXSLDxQmeHRTzaklnXDP9W3sEzrjrxDbYWgXncsKllWIqU?=
 =?us-ascii?Q?eCO9PIgP00bGKBWLEqI6f9V+2REle05OZUuUTD9C/C2SatCCvBiVeGwxGlNG?=
 =?us-ascii?Q?gHJ/fjkcT0El06fu0DfHjAzWScRc3BRW9icBBTaWhvDYMOYPlt7x6XIrnQcm?=
 =?us-ascii?Q?rLI4Az46VyPji6/j1gi4rhEIMpVB1E4Oxw7rTcO/WlVMZgtqjs2B1Beo4Ri+?=
 =?us-ascii?Q?EAv7NEjp+wchkJSLETOLkfqf6rCONZDAQUiToadjbEWt1EhiRAlmY8YtylWw?=
 =?us-ascii?Q?bGEVBUgBRPrDZg6i0J3mtPC7tqPV1PjkovCZg1ol8LW+pdffYycM9QcT1LAB?=
 =?us-ascii?Q?em/rfOoUqfmY/VD29332IynsSxQJJeI7gRh/GyrruPUB6mGjne8fQT5MFe0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbe9145-ec6f-4f0e-107f-08dba3e46879
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:22:40.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
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
v2:
 * no change
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


