Return-Path: <netdev+bounces-23869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89E76DE9F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE471C213F4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735936FDF;
	Thu,  3 Aug 2023 02:58:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C464187B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:58:41 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2148.outbound.protection.outlook.com [40.92.63.148])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543F19B9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6SUpCK4FoXvT3sUJURaMZDgmlmGFmlkVdoGUENH0Bng7gFMLqZCwvGul3mGxg7HmTIr2ivE3m1QIZ2qfQVz5G3ObpS39DeEKfUlxZY5WCN2Kg4XL9X4eh00PmS4UkoWlYbDPajKXeIyRfElzTnV1Mb4ipcKmk+4JbZXXQihmHr/tAu0AKJ9uf+Zf74RrpUYiwcGMTtISN7abTmxXtB9wKBugxkX1nTs2TdNF1q2vZxRe2RoZrSnBWD+CagDAmh5u17f//FqulisKSMZTgpDYk4/K30SlK46FsTtnu4fyEiJJ/3yjUp4d0t+Ge3BTtCZQnIxXCczIxKGs3YfB4Qbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COPIrw2CHcrYMn1rw8Y+L/0ycgUBIofmFzOnreX+/kU=;
 b=XK8PWxvrbbW7G+DnXOe9n1Y/pSBfEVw7bHFTCqQLXkCNL8TAsBpX7bdk8OeqbvUDa3OiEMLGGUaldA5OGkAf1GM0lOsSlzUyHZP5u6K83f3zyoFayus6Pj+aXqF9R/07PRZS6yV0eg5yhvGDXP2ZMQ4R9jeMiy1E1XUuyErSkJTwWjtFikdFgbkLM5CXOTT5+BYP/ZxYC20nb3/qOo+aLswB0YKyUFDhRqtkvr64MNdm8mD33u89lcp6L+8yjSffqTjENOBueaNF2baLYmgqkmfgeyxacSll3Pb275Okel9gwDZfLXwWeJiT+a/ig2+R/4AKlzD7YrOoPGa3KSrELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COPIrw2CHcrYMn1rw8Y+L/0ycgUBIofmFzOnreX+/kU=;
 b=QltkZwmoGIHiRPec2ASp0tHOefGUrwqt+Hrv1KBbjZYuJTSPFw2LlTvt0ohW/QK0JUYTWZ0R0+3fwFcO1WLLKOUUDG7B+JzDHk3+M9M9KvUNcn2nWYM3Mkq5mGezgrX+/HVsmZ9gbIgGOwjxOUep414Cy/8cXASH4bU/V7PzvkuH6dht0v0YKjki6ofHdU4UWgycCpizaWvF5ihpTcFiaB/UI2c1L9dnDZwAQHCunL6c2B/KWf1IXqoAD8cG1o+qK6WYoElgY10bQf3TWOkv5ox0fgoK4mGIjQP9bvmuDDDSuhNxFPh8b6e6JMQmG1Xfnow/44QUEIxSCAnWThknRg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME2P282MB0113.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 02:58:32 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 02:58:32 +0000
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
Date: Thu,  3 Aug 2023 10:57:59 +0800
Message-ID:
 <MEYP282MB269704AC80ED447B365356A9BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8Jzq6U40D0O0vUDoI3E/TF5RlF85tz3y]
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20230803025802.3534-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME2P282MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: abd4933b-55c5-40a6-b98f-08db93cd85d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3DDxXKe+TnB921dDSIyBE0YLV8s7mzRUGA9QOUB9p4t4dsapW+Lgtu7r9BznQDYZBKQ9t7vwDjWXFiP2fRCKpJlI/L/jjUtAow7RDQHHKl6tXAuQ0FxHg8IhoKaf307pU05I44+kVemoKj9FORcc9qigOD7voA+AvWIil40WMNtMsGSgXykPdSK2x3rOQFWY5KfWm+/Tgpz1sdkmln3VOXIq/M9vfhHVOVtLv5olT/vj9qaMe58RqTUdeokkuo9kDULWuJ42/kiZQNTLChwbbweeQKcFZcM2kdaITPHSZ14vBlCpquK4BXMDEyDrnpiIR+LTaVhpQ81QAZUhYZWQFfbCE8dMt704UVBJyWN7kFqE20ywwLIhEIISS+5quzhXH7tEp3HG1xxyX1qDKES9KlellB74u6XYIUNfzST2zJldASjrKiRKTLAyYJfJ7UFhekyrs8uajJkx+ciOf2fQGhB4lCIL2Qwqn6SiRdKZdnQWoJNcM9W4tixeuCwFFifnzHDhFCOn4DTwcoS5xYoTGQHIisWEYDpM5LORTSaZc32mt0hozw7/6o8b5+Lb54Gn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pgN10rp/xGp/IdZ6pYhR4uMMdxGoxJdf8FlNo9olWPEZv54DY0wpYwM5SRDn?=
 =?us-ascii?Q?9UcNb6ycXM1zCx4d4k8IghoqCXMz75gK8bc+14orFiC3y0wlZjAa7UADFSnM?=
 =?us-ascii?Q?OFBLrRUOmoUisjEA3LWAoJd6yjsWOwvO7REExEixRSBrOdAu/5M5e5t91Rwp?=
 =?us-ascii?Q?YlofZtXzdsdxawiuhdPo4Pd3/n3XSuubckVON9o+L4RTLZJpGKFAMMB9Ov8Y?=
 =?us-ascii?Q?Eb4HNOGMTAY20e9NHCUA9uOUVsD/o6gbUavOQbdScfB6n/sj5YXouM/wNylG?=
 =?us-ascii?Q?/g0bY03xM9Tj/NgB8zCRSPOE0J8NijnDilASV8U8mGhubbfSwp9ZqRJfzgjd?=
 =?us-ascii?Q?gOK2AevuayXrHJO3eax1Z9/Xjbby2xm0+5PnRo7xFGsDY6t1EGJMknaZyVBK?=
 =?us-ascii?Q?k8yCypDC+x+eYucCn2rzAds2uKJ5zEsIBRa66wtJjumJfpp5dwAnlTBX/ynY?=
 =?us-ascii?Q?M+CBjbGQ4WWHGNXfE8Q0VG5WHp4lI55V0m4MKRX7K9yAGhyHByBfF60/502j?=
 =?us-ascii?Q?L39ul85ERsyv0vaac2q1c4GFumhllrErnzW60txZVZ5pQaJOEZJZ/8WvtXdx?=
 =?us-ascii?Q?h+FmH3DzL3XW/xum2puqdHy7Hz3aP+GG1Hvk1HgSluCb7e8dxdtSrmFhsYdM?=
 =?us-ascii?Q?qJ3tonbzAQh+poYZ7UC/vJTFIizYCAWAP3/DwCiWNHwhiYD0XZh/v04sMu+/?=
 =?us-ascii?Q?AYCxOF87AbCBc5C7YwhWeyGF19ywBvE5qahUPek7RnD0jPXjA4fxT/ufVc3O?=
 =?us-ascii?Q?BE4V6l984UN5HgSriyHPrpg8BLIu/7oNfvi1ztXtKeM8Wax4J8O2vWpYa3ti?=
 =?us-ascii?Q?isCFFnX+ZQ5NnDlX2tWyAKYVl4ePPeOMGaqvP90OXQl8n1C/bIwpN7/r9jTo?=
 =?us-ascii?Q?/ofhF23gEjbzK1m2j8adrkr3SVwo476v36hmJDTN+iRga7lwmBJTZsXF9O5U?=
 =?us-ascii?Q?IT5BbxDawKlckSHbSt7Pbh0uIzcReZep4HlfAW8E3/+vhcGirISgXDe05hSh?=
 =?us-ascii?Q?Ic6mKDC7nDgWgsC/wJPnFKj7LlnbTuuU/ZM+Izv2nzW7vcy0+fnpLmmYuKLP?=
 =?us-ascii?Q?PbNi/yO6edBG2cznTgNR+qJ/2MUzmeFgxNEw+W4uLbua7sWYaPGpVYSDrS8g?=
 =?us-ascii?Q?0G9ElywDahsRc3xIVOGEeEl12RfBD2jG5fhqbQ7xns8P5AxotdT+wy4rdzUI?=
 =?us-ascii?Q?tCO8C+/qAHUDhRE7ejvAsQ6xYWQ5kKnl7Pa+HjAGYG35Kb83EeXVnbP/fRM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: abd4933b-55c5-40a6-b98f-08db93cd85d1
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:58:32.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2P282MB0113
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


