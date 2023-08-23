Return-Path: <netdev+bounces-30018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F833785A51
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F84E1C20CA6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC8C159;
	Wed, 23 Aug 2023 14:22:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F37C2C7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:22:29 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2153.outbound.protection.outlook.com [40.92.62.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A104E47
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAjGvizdSuwlafHUEpLORCAiJoQIK0LBwbsuc7UBjAkLv11n/7AB+4dmxJpB5tfEY8oU8li0hCzYSRrQYq0iSf5tIphSy91bAfIA+2KZmpEbp9B60zD+mUa0qT/nsZBaNpG5QJtLQoi75QbpOrJH9iMtEBV8XgHqYKNhUED7ZPMu7mdz3DJLQW2oSaEwMDFXQ+e5mjqCRotyNoUN4YAb4rMGezCfCZrsb+pBywGwMtFxG/YyYqXV9pUZcZ4nX6zu4I1C4Ln3s8lWV3TTyrFjdmRwQvXXbUGDFqNHg6Mduw6mRYSYfWM5iYDS6Ncx1OQhINOZ5SEyEQjH3hKBtIE6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgT+/ItCgKV5iqqbKWGsCzs2Q6+PfD37ivhEOy1uiqA=;
 b=gPRkrmV5PAlDK1iopWuw/KIzMsrIWxxBiTJECeGLQXA1+WX7qZmNKrkofu/6wU127uOZmI2kbWjTHbnZk3eQJi0q3b9JFJYyS19TFCbcLCju9v75VSCyDiffbiav2Bah7TQu0Do3x3VfvQ5Rfj038ALFXwtIeP6sc3LRm9idhjn3Rw5PpV8t6ABr5fdIZFzddW0AesMh7BzjnhN8kjiK80YZQ2LhPSObIuM9PGP3yeSDlqJccEnfbHMXozt8mwouOyOxPBm64Tfn/gQ0j4EIz7iFf+GLgNmYYSt9cr64YOxivlPEmo3cpvU06RLiZMc99/eSD0knN0BybYPWeOZjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgT+/ItCgKV5iqqbKWGsCzs2Q6+PfD37ivhEOy1uiqA=;
 b=EM4bQOsZ2wZi1weJ3Ypxqi8OV5F5XN1D3HedkPGdp1SMRVLQli/XI9BPCYFGl8Sfs9zpv+ujen1IjfO5eQor89hiUgPA2fmEzJ/5ExMC1IpO9VKvUd3s7JlI7wZaEDZe56Apt/Ob8xrwYRjnnXGH/+Dd+2sHuyMhYxsr912yd96M5kJKM9JXUHtZMdJs2tmuhikzf5edQ3rIrrE4Qy8KtJz+wMP9ttVc6a38wboHhPCQ5MMPefBfG/MUYq0OvmdeP5vuogpxDq93YhACGTtJ7BDqWzmhf1qF0pdB7+X/n4tYOFe2bCWBC2TNWCxr0SLP756i/sXLbUvr09Q2slWZbQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3375.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:22:20 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:22:20 +0000
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
	vsankar@lenovo.com,
	Jinjian Song <songjinjian@hotmail.com>
Subject: [net-next v2 0/5] net: wwan: t7xx: fw flashing & coredump support 
Date: Wed, 23 Aug 2023 22:21:24 +0800
Message-ID:
 <MEYP282MB2697DB6AEB3CB0F81CD7578FBB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [bDAUYjQvq5qqX4Sp5ovnXC8FGROc5xr2]
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230823142129.20566-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3375:EE_
X-MS-Office365-Filtering-Correlation-Id: bc719d84-fa33-4441-a998-08dba3e45b87
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFBti0IhhrCLbaNV/aEqmE3VJusntcImURZEuyR6OYsq2joKHMh8LRmrTpFYh7JvTW7PwcsWnlhbenFCzN+jteWC8nP9SjNxk5byKF1F3yoPb+OaAuwXn00NJ5ScqAEYE9vzMTXaI6OIDxQA965kGKGXGUqQx7FDkWZVUPdHsFjYzGVfpuPFuQfONAjPehoeDCbv5U252aQPZ00Pv2imMc9ABgN8fPdI0QhxNk3jH+GGM7Dy+Dy/o6Bz131cElXjZg7JGpvUc/B7/bDhoK0FIuIj4PrwgzfZmlwuXA9ikki/ictKR/0UhHhsZx7bIV7baWy5mM0gh+mDHbRsIIBW2TUmzSsG42E0dosAbep0pnFT2l+FeJz8JyfiMnMXGqaph1Uw9Fc2U4mx8engTEv8wwE9fsevv1FdhibIcuxNn2LHVno6xmSsjAZOEjiQUoLuCWnqX2SBtw8ZORWY8Py3Fg0AGX96R5lytcLoS2j719NFwd21KCNMY0R7s4rCFu8ntYT/7pJvwWrLeznv9Tb2njirzb2meOo/FZEUOB9c/LmAVCR4eTNI3qF5fAh13ZwD/l3q6INldQ1FwdS0we4CKtUnj+E+N556VmB4UI6UUbBzjjlr1AfQLaYwGyeeEccgW/jprOLk22SP6y+wldqVjbEApA8q2p8Akeqpm7pd5XyREo4usl38K4t3pcQtjsciIvh/OceBpgYfoR+Ut/VvcjggAg/MpwvSXJVhrFt2uJuZpw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r4jRGyLuZCuCSJ/cjfiTPzTVd1EHPlA80jA9DudPCeYYEAB7Mmg1NtGqgnf5UrMO0Q2yoIDtMd8XEh8pyFT2nRSW0zB4sdDHEBvynIJSBZPaDbSJ+SlRfVmIM/C8N5m/bULBOhcSlkDMn2RkkqK9a6LGNrCXG/xeM6OycPG++hbzAp+bny7NgCKa3EuSpCdPMbaisJQa6jZf2YFtEKZMhiXs9XM+jzHc/jUDr31TKvPZMAbb99OCS9Bis85J96+T4wemOEghDR3BiuUi1w7oPJ5oAUVFSNTp27br9mzqGUipREYZ/kBduoQeYxT1IesBlHgcuNTab0b1/1WoQwWsNLfPTze7Fini3sAo8IOc7xsCDwTxfAH+G9A55pX5SGuqSvY1tHCvQRLZGLCSAiBsECr2XQSGECPxxW987A04tD8ImZYJXfbDl7YEGl/yrI1HHfMNqPUidDX+TLNUYbckEctzO63vS1h1eIc4rIRs+Uh3pdGuDL2R/XrHl51oxQnpUCh1vsuxjhiEbs5b82/oIPEXV/dHrk7HpSqs1itwV2qTcrDfIp8g9LG8MqlstbWKgEtOyqhPAagXVQ4U/gfTs5h1NpNLM+rrelsHa2UDDW7fs2e+mEQGbg0O7rly2GBk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBhG2lMAkhltibz7nUcRP6pyQ/58dcxmPKJb72mupujIJNXt6OfF0kgl6iUe?=
 =?us-ascii?Q?qnlbDoNoH5o1kEpcD5+TocPW78z6GVQK3xHF7EUryd5zbCgoO6WWRGk6Y+DO?=
 =?us-ascii?Q?UiP/jLkRt7mvNOSEm6CunV3I5LC5YPALYY9upXq8idoenP0ht2PLp1axtcHO?=
 =?us-ascii?Q?7h90AU5QZoYDryF21fhqjMmRwygGsPeEi29MFfj9/W2ixxRFLxeVV+8ssrqD?=
 =?us-ascii?Q?AZaoAlgL/AvxKqydV8eldxYf57aCggxQVkhpxNsy6R348dOkntw+rdC8Qko8?=
 =?us-ascii?Q?OqDodUctRwMfFBIC+Zn2ZpwOE6l2ML5Ecy4vA3RxnieGKkILYTUK09LfB9CK?=
 =?us-ascii?Q?fL8Y1WRimfTadxVjTJV2O385YLs4Na7tqcDD4L4YoQ9XJZZVM/L0jXgfdIB9?=
 =?us-ascii?Q?NTYh+4WlzUKGbIGmxryzZ77q0w5fqa+JRxVO3WNnrPuIaGmg5PmprZB43EY1?=
 =?us-ascii?Q?WktaOCW1S5+Fl4K31GTEh3kfZ6J5gIWfUd2jg8BnpmnQbWnfxJT4AkMd4mwV?=
 =?us-ascii?Q?cWPA+J0IuQVs5jAauLhqNidLdNIyl5AdNKarOQu9FseElUFBtQZtE19Fde2r?=
 =?us-ascii?Q?cFu0lKfW96jVri6PJLO/PrikF9+rmW6EjON2slv5pR+RH5yIkwqtEhZc9U0W?=
 =?us-ascii?Q?7enYy0NPw951wPKHuvEDujpe8yW6gNPrROkQiri8+8wbg61O8T3vShk3eHC+?=
 =?us-ascii?Q?4mM+Wg9kQEwDPXP12PXK6yG7/MDxB7L/vpmgNYHXfXLYG+giLDz50B4kflYe?=
 =?us-ascii?Q?Q84sOIv2W2e5Vi/Eps9/e0oCEPuHb2HlgYAc29ct1bVrm/WBfA6yaLOFiYbv?=
 =?us-ascii?Q?P/tAA2UWYWoGgUcgg2rggGZqiY8pI7N9SXKYqJqTfZJqeV9WOA+dcXM8o/pb?=
 =?us-ascii?Q?7CX7MM7QFeso+UPzjK3KDjml7yAxAX5Kf74xUZKA6zS4nru0g6OPF6/yA4+C?=
 =?us-ascii?Q?ayjDDVp99zKeR9MIo49RFGtLIgip/a4qQU/7Nt7rcRRWViegZYuPpakQpIie?=
 =?us-ascii?Q?UohlJtKZf6Sz8i5h1+B8cO/P3XR27RJ6fDeT0/7c46hzooNnVp3+EkoEDhut?=
 =?us-ascii?Q?hKqjjhXE5PgcXLENc+m984/o6qna8BQWJv/H3SLlBdBs8nQ/x3/1pG5YOIWF?=
 =?us-ascii?Q?5MFCG+ycAr+vUlWjjLMZuhZ2GZgRW6I+bKUHxFJa/w+WN00MPUS6U3B/RFj4?=
 =?us-ascii?Q?kQheiKvvvl8G+EfcPAlwT9RIXpCHZRFoVqozlUxvNNsGZSuLWWjzBsl7NJg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc719d84-fa33-4441-a998-08dba3e45b87
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:22:20.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adds support for t7xx wwan device firmware flashing & coredump collection
using devlink.

On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
tx/rx queues for raw data transfer and then registers to devlink framework.
On user space application issuing command for firmware update the driver
sends fastboot flash command & firmware to program NAND.

In flashing procedure the fastboot command & response are exchanged between
driver and device. Once firmware flashing is success, user space application
get modem event by sysfs interface.

The devlink param fastboot is set to true via devlink param command. 

$ devlink dev param set pci/0000:bdf name fastboot value 1 cmode driverinit

The wwan device is put into fastboot mode via devlink reload command, by
passing `driver_reinit`.

$ devlink dev reload pci/0000:$bdf action driver_reinit

Note: user space application get the fastboot download event of devcie
from /sys/bus/pci/devices/${bdf}/t7xx_event then do remove(echo 1 > 
/sys/bus/pci/devices/${bdf}/remove) and rescan(echo 1 > /sys/bus/pci/rescan)
to let driver goes to firmware flash process.

Below is the devlink command usage for firmware flashing

$ devlink dev flash pci/$BDF file ABC.img component ABC

Note: ABC.img is the firmware to be programmed to "ABC" partition.

In case of coredump collection when wwan device encounters an exception
it reboots & stays in fastboot mode for coredump collection by host driver.
On detecting exception state driver collects the core dump, creates the
devlink region & reports an event to user space application for dump
collection. The user space application invokes devlink region read command
for dump collection.

Below are the devlink commands used for coredump collection.

$ devlink region new pci/$BDF/mr_dump
$ devlink region read pci/$BDF/mr_dump snapshot $ID address $ADD length $LEN
$ devlink region del pci/$BDF/mr_dump snapshot $ID

Upon completion of firmware flashing or coredump collection the wwan device 
is reset to normal mode using devlink reload command, by passing `fw_activate`.

$ devlink dev reload pci/0000:$bdf action fw_activate

Note: user space application get the reset event of devcie
from /sys/bus/pci/devices/${bdf}/t7xx_event then do remove(echo 1 > 
/sys/bus/pci/devices/${bdf}/remove) and rescan(echo 1 > /sys/bus/pci/rescan)
to let driver goes to normal process.

Jinjian Song (5):
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Register with devlink and implement firmware flashing
  net: wwan: t7xx: Creates region & snapshot for coredump log collection
  net: wwan: t7xx: Adds sysfs attribute of modem event
  net: wwan: t7xx: Devlink documentation

 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/t7xx.rst    | 232 +++++++
 drivers/net/wwan/Kconfig                     |   1 +
 drivers/net/wwan/t7xx/Makefile               |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c       |  47 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h       |  18 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c       |   5 +-
 drivers/net/wwan/t7xx/t7xx_pci.c             |  79 ++-
 drivers/net/wwan/t7xx/t7xx_pci.h             |  19 +
 drivers/net/wwan/t7xx/t7xx_port.h            |   6 +
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c     |  78 +++
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h     |  11 +
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 695 +++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  85 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c      | 118 +++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h      |  14 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c       |  27 +-
 drivers/net/wwan/t7xx/t7xx_reg.h             |  28 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   | 137 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h   |   1 +
 20 files changed, 1528 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/networking/devlink/t7xx.rst
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h

-- 
2.34.1


