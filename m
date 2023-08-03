Return-Path: <netdev+bounces-23872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E580676DEA4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DB4280E34
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739127486;
	Thu,  3 Aug 2023 02:59:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6456105
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:59:02 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2160.outbound.protection.outlook.com [40.92.62.160])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1A10A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/tVOSNKTuyWqsg5/kIfiGMGL+OikpJe3cRGttEJ0wuxmUdnUHf7uqUyWH/pkKoWW+6BbI/5GsWGeSh0HFORNbhWMNANuDh+ajkoRD+3a6fZLQYZS7bZU8/NIdgtSw3tyozg/r9mqi1TZ/u3Pm4Sz6Z6uFNBHRo0fTqu7OoaM0LEKR/zTiqmDtbGnAbffMKxP8mwSM5dLZvZodIxzp7Vjecs+Ez+bsyB7V07xel1i3r99js8qZ7IDDBJcGsjTMOEVRwEzZuTegf0g1HUQhtfMIYnQr1pPsrSejiTm96T8evPxyIkmZfrDBG2ttGhttN616DZCsevfC9/g8coQulxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbb2137+Um2SBCJLfyA8j7g0pN7Kfw2jjoEAmW+S5/4=;
 b=Cg6Bi600uucawNhT+ImgMP96HgG8myai7SCmrz/dfUc/JpN5cmD+JskujKC051fQOo1Sh8Fx4JZ2jneXiK1cx0D2h+iZilRNxUPQlGe6Ag318leIF0BCAQiwE2vixj/f/fCQlq1SnwxPFK305glnGlz5RV3rYNiIDsyJmlHyX/sseIDEi4VU5N3q9hULK9ZdczLQCfON3TwDVBOWYfSGxzQtYIQ6ppvxGuygUilzLgRNMn8JbgV3HhClG8pTbmiFZ5FdoIT7X7khvR9GH3e77+lu6mERAugRP6Duq7BmMEmYx/5/88etea95V3J8CaKTSS51OoYow+ODEem9EhdzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbb2137+Um2SBCJLfyA8j7g0pN7Kfw2jjoEAmW+S5/4=;
 b=NPFm+Tsve7R6vC7AWGziV3vqzWYb0cpt1KoUuGtC41uviEPLm3pjiAtT+EmUn3mDba7Nw7Px2HusZl8GLBFAfNG/MHC+f0r5O/0nry2m/nTEpNMquD0BgHbFyXRRrWFW9w4kbpqr3Psh5p5M+tGMd0qvCxyYuiaU/uZF3jKSYmyA3SoWH7XLtHGyuGjITOExqZVj+lLC+wQBgmSHkSTyslgo0SDeZC1ZApgv/PbhFZJQ/gEzQMq2mW2Mffja8Ha+GySWzpME+DNXH8gPt8utBzLMRFkwts5djIy//lEtfhoHsEFiwXUMIou91jnA3ZGqww9woUpsXNYdZ7lp5mZ0rg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 02:58:53 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:58:52 +0000
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
Date: Thu,  3 Aug 2023 10:58:02 +0800
Message-ID:
 <MEYP282MB26977195B1E77D53F9E24568BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803025802.3534-1-songjinjian@hotmail.com>
References: <20230803025802.3534-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2naFLzHyfuYpjV931z+Y3cc1cJ1qqRmQ]
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803025802.3534-4-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SYBP282MB2963:EE_
X-MS-Office365-Filtering-Correlation-Id: 7435e630-cd3e-4738-3f1c-08db93cd91ac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XYXwLAqa9mejhPwuhgkDIGB0mHBHOHMonU3B2DRG2nJV7UAdhP1+Zqt0CH76w/NH+QO5QSP/1pj/1bEKt8DC9hFLt78yKGIMMpNSvoRO5xhJp8Php96d7VY+7l0d0AcWQcjOX23NJAyvJyBWCYkx3FjylcpRd7stXU5Bcx+22vrGCcV8QNW3z0XPRg5VRtrteV7q7jv/WgdG6RLugkzBrn0mx7WfCFWAgYmMuood7vRtm7sC93k5cFYMtzyLHcS/eY0fMrD2jSNS8Ot+k0Zi/SBKodmRoXcw+ZjRrEJAWowO85FZ8/6muROhqfEhm05czz7cTKoOQy7iHMl7jLZQHdPspM51MIE8/XdCKtP0qOz7VRfz/Y3lLUXfz83+lQyTgWsa1i0eapqiIVlGe26qe0yDY/vA97/vDeSdlnvtPZEWw6/UKYIzymhGxeEyNKnRKvQ805ONLDHw9N5iUQeR4dRoWhvG9inD60o/YvVlelFVy2AihlaSHsmK3hJ0qXh0Zl8pYubpv/+vOKo5zqYozXlrhfKJ3aNXfTa9xPuIH/g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXuJcYcBp78AkUbzc7RVxdLtQ1IWj1/F0Km2KuQhKa1sTFaKea7ngUvhOziy?=
 =?us-ascii?Q?4QIddJhx0E1IKM/ZaJMCHV9Jk5LyuSK3MZWJOTfl8pPyjEZq9aBkFgOMuYA+?=
 =?us-ascii?Q?hpH6xU1ROFnOkj8+XlrK/f5GC6T0H+/mWrWhqG0v9BKv1012Tg5EjLn6ZOqd?=
 =?us-ascii?Q?+ZnzDb79PF6FQdcf4kj9sZQupPh/ErpUta8wpFY3QNDETNjWP/+KfYwI0LvY?=
 =?us-ascii?Q?mgFOv6AeIPN+bLNkhRS9Q4wkN9MG3q/pJ4p+cZ6TK9be5BGgB56JLpQeqYBF?=
 =?us-ascii?Q?8kMOjsubacK98y5T+lSaTtc+GiVVP53XtYL9V/RST9ufCMud+h9+c79h1U/+?=
 =?us-ascii?Q?zZzisfo4uo1KrwsWjO2Q8eBo1WKJ1xEffRCIIWCzqDo9gbZj0DUj3znB+Q8C?=
 =?us-ascii?Q?Cl3KlseaWqoIT25rCQfyqIGVpYfVc+s3rESYaEQHTu+lEWUOxDMXRN8bKVR2?=
 =?us-ascii?Q?FUAW/DxP6WDCCoOVqDYJTOYylHNdANYIT5eKvXuiJkg2G2kRVZ0czyTLu2gR?=
 =?us-ascii?Q?WYs7PnOvnShHmzQOlxPd9kIGvSt9RvFXQFXDzdVWowZt4hWUcnj/uYxI+87l?=
 =?us-ascii?Q?FErAIx9gm2KYJ/ljUrr5vlc8edGAX2Q7oXglfxHE9iifa1yf/Liu2ZTpOW8S?=
 =?us-ascii?Q?BL6OJcvc+44HcTYXbJFgqbijGcFKfjGISPZjivhETfysKNMrrE9++Uzxxgia?=
 =?us-ascii?Q?Wd/uqLSrMbJSoUZEDZo92A2mjNO4D4RaQNT1jQAND/wi/3LYsTtcVzVPY5zZ?=
 =?us-ascii?Q?2JA35d1Js/G016wDa7rIsQFs7rN7eHINXmT8XWP73qZdg4zDlbRPm35Xn6Dt?=
 =?us-ascii?Q?JzX0KPQTvqrVYIvAYtFy0/2xdPqrbwCvCm1O6sJvx0yFXmRdtbE/SedyMJMj?=
 =?us-ascii?Q?kmiqKSe9Jy7XxxIsCP3ZJ795GDaOR9SgprdR+qBViDFoFev/7ICpQKIFwBkO?=
 =?us-ascii?Q?IljcYHzj7VNgcsrgXIP8JqcxwR+AzWFiY4w1CdO+qUfgu3ImzhZFddou/9Rx?=
 =?us-ascii?Q?m0ylgVLSIClBTADY6wj49i7Sd0J5MW7x0jCbLgcnvjm5Ize/LqSMfWENWung?=
 =?us-ascii?Q?WWLO9rJOyhx3XicQyw0zUY8V4kqgo5Tn1mO8tWgeBJPQLzmAHUZ4PfDPPnbJ?=
 =?us-ascii?Q?1Rujqq1ANZpRazr5JlwDxOoISWAdVj+3ItMVxFrgsvpJhuNrswp5csxLgY0C?=
 =?us-ascii?Q?7pS3NkA/QQn/GFh1msAuMCQAMfoGeXQR20liAu6nak9vjrP6wCZrawLuA+g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7435e630-cd3e-4738-3f1c-08db93cd91ac
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:58:52.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2963
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


