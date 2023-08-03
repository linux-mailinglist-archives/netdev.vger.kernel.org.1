Return-Path: <netdev+bounces-23854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216E76DDF1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC201C210C5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7BD4C67;
	Thu,  3 Aug 2023 02:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A077F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:20:27 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2175.outbound.protection.outlook.com [40.92.63.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30343A1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkhp/BtbmOomKp7tnbG33Y8c/s53VFW2z2XxcorxAS1jwUPoIBMkJHr/XbPKUCUgD8Mns/gnZLGcW25JzbHKpAl05zKAbsxzmt57iqmdTVB1hw/VUdBxx/d7i8k5NlPswDw++ek5YpsHSCXyqzuBpU+bbgC5AZQr8Amayol0k1H0VZdna65VoaFYhXe+IEbY/aR7un3kdRxjlNpKiqx0+WKXeQI8bbiAE0V0xXY35UxJ8GP0ZABM5EwzhSqxOsGCzCzRRamzvpMafT72Isvukp1byIwbc/de6BUFc6QVDxSrjF8iJco84GrRDgzxCGX6WegO1bwTuDiW9pWsdpOfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COPIrw2CHcrYMn1rw8Y+L/0ycgUBIofmFzOnreX+/kU=;
 b=HqQemVRYkqimnmEAqR8jxneBh1W+NgJvjmtvXy2kEwR/QtHaRJ4sWiheL7lqByToaiFB1NS6UwAViJV1fRZ5gmNyP+bITqgY1WBebs1ZcQDzpGRzBucGibf4Pu136BAm/fRupzRxvrQyr9A3Vgnu50uz6kTTJhKohG7rPVBjTWfk1b/2RDnXjOfLIqT5KElvUbsxLLJC1Cwm76uKc3ITQEBZe0EQG+FGAoiWq0A43WwOZtLVmDs91oygB1rXC6RdYpevAsG2WQJ5a0+TP9wnwXxK0FLeCqbUmhgAQtunak6r1tDyWceRnFpI01QL0PmWG/juScU1wP7oZDGl5uyZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COPIrw2CHcrYMn1rw8Y+L/0ycgUBIofmFzOnreX+/kU=;
 b=F6qDAbLdZe3OhHdiERTHIQrZcwqY07CnhuruOT8phX0L+SYFlnFWToPUs4L+qii+MH/VVuCE9L+O/ohn880FjEyQlFn9C1O0FHXFFpYTpu0zJZAQQqObKi1nSqS7N+S/8KZ8F9bFbEgB0s7rXc1UqVfwF6ivIwgIitt8QS6ucuxHAy17MaxGCiRgzbQ+K7kcDbmbqfNTitsR1rpF+xuGLb1NIzdMny0gge6E14LM5/SOzpBBQ3RsIK1l0D5N/k/FONlgM2/E4A5prMlfXrgyD1JwbCJ0kniug0M3aGl6SO0mfhMRSbpNMFiaRff7mfGtYpl6XvQc3PqxNrwNsf2agw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYYP282MB1823.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:df::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 02:20:19 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:20:19 +0000
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
Subject: [net-next 0/6] net: wwan: t7xx: fw flashing & coredump support
Date: Thu,  3 Aug 2023 10:18:06 +0800
Message-ID:
 <MEYP282MB26974DA32942DE35F636FA41BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EHCJzFeMsuohlDqKy0RySTuq8bCrSRXP]
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803021812.6126-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SYYP282MB1823:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d7d1c3-ed05-4677-aa1f-08db93c82de6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	agCMbe8t2QzQr3K4JCZj2UGOsShR+GRyBe99HVw6H1xb/ruDvinr3y3m5hcGxE/RDz1LKUKR7uQaYcZ9iDSK/Bd7fIo+ho9qtY951hRLIWkcDFa1D5YzuUKzsNFOEkMhPfPobnZwiiXnWmGi9hpBccA0i8Dsb4nXqwlElEqL5hCVpS2SSvz9ESGdzubKn4YYnaHNlcsbzJdSwIEqlBQCRjWD41/Di3AK/RPy+REGcdtWaVXjaPFn55FTCNO7ZyZ7aFbHoRl45zaEeCTGGiCxvlgKmPZxCSpUqovX0fCL9e1MXaX9Isv0lQD05SiAqldGcBinVLi4IcHK4qqFU/XhNPlfwDN5fjznFpaIa5zmzW2vQbJpARG62rgRM5MKNcZTBpzEdSa1zUrxqgIjUSP3y2LnxWcm5aG8eGHfLh7qc/Q339T85G6l0NjNPMqdr7cuFFQGltgX9y+NXL8ja9wVW7WTq/82xS++IM0p9FKTXymMKKanIRqIgkgTkbu9Zgv4FgKt0ZUDijVs3Rd042afHm2jyKbchdtvoSn7Z4yRK9Fs+rvLQvgzCseALMljDGbN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZVG0YMInR9BNRbFS+fHP/r6i3Unui2aU1u4vvveRp/hefWY4gdLb47IXQRd?=
 =?us-ascii?Q?6A50zEHqieUNCyllSp7ON6DUTfsrCqyYbqTWXNuUud5WGauC6vhlFApa0aqJ?=
 =?us-ascii?Q?ubt4n36HG+/CWBHdayy4ZIV1lyUx2y8YGJlj4beb1wrEWUYzjgLgtTWkZU41?=
 =?us-ascii?Q?tEb19CQAM1HYJY+plFpXwt9XH2hiE9r/vzTo2KtuL6rDk+d/ly4FueOm66QH?=
 =?us-ascii?Q?5sWDxMzNYbrb+MVfPKUeqZd780JcTE7F5TsMSCGGOnzwfs2vtAuyNp/SVGHn?=
 =?us-ascii?Q?/cn0QpvLAQJBmSRRdC3JyGSYbcjiuqz6szGIrTyesA2eO30P7p9enzx9KPgM?=
 =?us-ascii?Q?bWHEGNGUd8VY63hKWJ2fK2N3ETQLLfRlHdMfvcTkwaV6/20C9YSCjRNDAf7z?=
 =?us-ascii?Q?Qlzcdhm/GUxUf7i9cJFZ7vbGBc9U2vgpE/8BnZZoAIJh6pbPU4MltZiU1J2F?=
 =?us-ascii?Q?F6ys9smxuLBVnksLBZyPX7XwWx0Rp757av9Y9KePPnDYpH6Zg4xArkF6UFD4?=
 =?us-ascii?Q?p02SDVu7c2ae0yMdS9KBShRwJ4Ym7tlLrFhUwK7jSLv2fJ8ODF3t8qyVHNFV?=
 =?us-ascii?Q?XQcKHffTyxgCWEiq3X0VIHEGzaVlrsWqMHfb9GhHDhs4dehgf4RTd2gRX8Tl?=
 =?us-ascii?Q?7F9LnNlTjen7cueYAj7b3JK8hVnmK1n537L6QIJHKrIhjdNIVrMPkYkZy1q+?=
 =?us-ascii?Q?hMN8U/cgk8YjCG+emDL9wNMMy0TvVMyKCqBVRkKjV+lkNqv9iFBpBGm8QkbH?=
 =?us-ascii?Q?EM8mNE4nIeO5de38TzoPdpiEVznY+hHYCiTuktnLgBE47MtZgwYLSWACGezx?=
 =?us-ascii?Q?Xhaws2ijwNOc5WwxxTcARGyGJNUUTVU/R5N0hzj6I3e/dWjrHl4y9vJQokVk?=
 =?us-ascii?Q?PHx84z+JiPcGbXnykrXBXApA0jQYyr9KnBG8peoX3XyT2k8xuuKJEQoqWL29?=
 =?us-ascii?Q?hKEwmNTPAwpJ9oA7dnKZh9omr+hJM6LS8z9BBRZ8ZQr0AH90uq0+hRU3z4xW?=
 =?us-ascii?Q?kfH48ypbRxDmymjdvKTE7hdjtq7whpS0pTS6ZrJohAvZQsz0KdEXf0L2AHCt?=
 =?us-ascii?Q?zSpO1T2JGW10OCX1Tq/gXY/Ui7cRrYhjO81lvaft2Shk/EbopSHRFTsiz1+H?=
 =?us-ascii?Q?wJiM2AFttlb4i0qzr0l5QWE0SGNgRsSfYFiBkfRaCyMXAFrhREapS41WWUZ/?=
 =?us-ascii?Q?J+NkzKd992mR1ig9SikipTd4gW/FJ2A8ydvNB/VSB5ALyGyKYLjwDH5vLwI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d7d1c3-ed05-4677-aa1f-08db93c82de6
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:20:19.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinjian Song <jinjian.song@fibocom.com>

Adds support for t7xx wwan device firmware flashing & coredump collection
using devlink.

On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
tx/rx queues for raw data transfer and then registers to devlink framework.
On user space application issuing command for firmware update the driver
sends fastboot flash command & firmware to program NAND.

In flashing procedure the fastboot command & response are exchanged between
driver and device. Once firmware flashing is success, user space application
get modem event by sysfs interface.

Below is the devlink command usage for firmware flashing

$devlink dev flash pci/$BDF file ABC.img component ABC

Note: ABC.img is the firmware to be programmed to "ABC" partition.

In case of coredump collection when wwan device encounters an exception
it reboots & stays in fastboot mode for coredump collection by host driver.
On detecting exception state driver collects the core dump, creates the
devlink region & reports an event to user space application for dump
collection. The user space application invokes devlink region read command
for dump collection.

Below are the devlink commands used for coredump collection.

devlink region new pci/$BDF/mr_dump
devlink region read pci/$BDF/mr_dump snapshot $ID address $ADD length $LEN
devlink region del pci/$BDF/mr_dump snapshot $ID

Jinjian Song (6):
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Driver registers with Devlink framework
  net: wwan: t7xx: Implements devlink ops of firmware flashing
  net: wwan: t7xx: Creates region & snapshot for coredump log collection
  net: wwan: t7xx: Adds sysfs attribute of modem event
  net: wwan: t7xx: Devlink documentation

 Documentation/networking/devlink/index.rst |   1 +
 Documentation/networking/devlink/t7xx.rst  | 232 +++++++
 drivers/net/wwan/Kconfig                   |   1 +
 drivers/net/wwan/t7xx/Makefile             |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  47 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  18 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |   5 +-
 drivers/net/wwan/t7xx/t7xx_pci.c           |  79 ++-
 drivers/net/wwan/t7xx/t7xx_pci.h           |  19 +
 drivers/net/wwan/t7xx/t7xx_port.h          |   6 +
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c   |  78 +++
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h   |  11 +
 drivers/net/wwan/t7xx/t7xx_port_devlink.c  | 723 +++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_devlink.h  |  85 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    | 118 +++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  14 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c     |  27 +-
 drivers/net/wwan/t7xx/t7xx_reg.h           |  28 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 137 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |   1 +
 20 files changed, 1556 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/networking/devlink/t7xx.rst
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.h

-- 
2.34.1


