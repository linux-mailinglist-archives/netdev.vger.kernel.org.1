Return-Path: <netdev+bounces-63251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435582BF86
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47281F25E1C
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ECF6A012;
	Fri, 12 Jan 2024 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="pFCs5Q8Q"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2163.outbound.protection.outlook.com [40.92.63.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449267E9E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvWvaKIA/O8zi5nCbviNZNkqR/FsDs6znfKo3+MffA99SmSdZz0s+Bm7FmhcYeAxpILvNDK9fK4gNpXtAwbCUsSMqWBzm+m9W7kxi8zxBKZzY1sdyD/BkrRlMatMa6nbbVyyOcs0oif+etWtkir+RZNie1E+NSo0NcPSZM4tTSqHxdM5O5KudcevsXVnnKBxfgDHRmIaNi1MJZFW23m81D9Iq2brfZS/8x0w9Cgf58FZ1f4pTxWfLEFCVqYWkv4M6EB8cm2xm8XDbRJmDp+JZn4FKP1oYTMSl23mrBx0Sd5UNNygEqtZ0uxZli7SvfinFdomv20Hon7gJB+XKQUNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1DPtkg3/qXlvNgj8ywU/TgzFyOo6SEvHJ6IbGx2vX0=;
 b=CGnbTcsUt3/bHbVDQoexCGqtOirxKKQ1L1KmcwErxY8rjJvBZ02z0yQazXb4MGNPIajCMpJtU111GUadJnDwpPBz7H8KTht8c55XXl9duEVEKPs26picSimlfKYyNWNHWyL+gQcf46h+9uRFf3euOp3BbK5nQXIh50978D4sGDAPZnKDVbfbX5TOSCEgXNyrAscnVcphSfzAGfmvcTuMfb2VEAUWTgxbZS8qQnj1fGa3GNjRiSDwsqeDs1MVI7bX9SyuBehlPxjPhJU6hFHxkKGU4dpiQU3Na4aIKiPDg0BlKN6nAfJe/CUvlVSJmvFooq61qjSzcr8ZqhrUiI/ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1DPtkg3/qXlvNgj8ywU/TgzFyOo6SEvHJ6IbGx2vX0=;
 b=pFCs5Q8Q4or5gF7wQpzsJMLAJpRFWzRz1s9XvGQXxB7ZS9THGD7G7j/XjEIdVlio/AYDjfNm8qEtrCAc883oZfpDf16z5oop3sBZ04kckDxC00JExBFWJus2+HW04Oig7zDS8zjKkps5cqpat9sJFFrU8mT8iobG5WJTzPHq5kWJJB9/2akbEXbpmR8bCk7c6kttvYRSDQjTBuECcTg8mjV0fMB3i1+sjuIoPSpZ60mUY1OFWl+LdxbuB21JTxys4IFNniwge7NqWJy7y8/l3jQ7qGBLDyj+tc4OKTKuw0+BW0x3k7vY6F4w3PWvVznDLB0Awji/N5Gstax9sAGpBw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB4175.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 12:00:39 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%5]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 12:00:39 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v4 0/4] net: wwan: t7xx: Add fastboot interface 
Date: Fri, 12 Jan 2024 20:00:10 +0800
Message-ID:
 <MEYP282MB2697028CB05CA6D1C9C7B9C9BB6F2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RMyaX+D8pD/+wKaYlIZJAhQDC0kZzKpY]
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240112120014.3917-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d1c606-d423-47fb-afe9-08dc13661767
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SUiU0+/TtwvPG6aB+ur6LNF2MC9sQOdIJTiG0e0DGuV9kX+pyfZnN3pgb/G8ReO8G0MXLeq2GB0feNEA0R3BQ7ALDFCjXlHLUkEGpBN+fi4EJkiEGDSE0VeByTmcTlZfE7OMRmqsbe1Ym97nVS144mxhSmARXK4GeCdB+IuTYHIhz1AXffhBgfuM10KwNAUfzqrMtQ6c9r5+cMiviNGiBK8cxYq8JUGqouvK5JENKOXg5jWvTKaUxS7AuvkF8kzafaudm9qG5btJWOKOph3CeyzXHJpyH7Nx3X2ZxLw0weai+4yWsPfsduflae1y2aYmZjw4WDXIZstcbhpxTEmYCJiVVvaMnXE6YFNp5PB9moD1hf+y9Hoy4YyJ4pBMK0mh6jmaBamuCG9yRgX+yRgA1czFq5TcbiaV5fXRVJM/xP61L3SZzoZrqWiPlWOErROUvO5zoBDWihB+izmsliHgOq29M5l3OajZO4USw9LvW+cH8eDpUAtLl08ZW8cuyOx3qDI5DGefo5jtfyVtpzuAQhcCL/5hfOLWP2LbFkNC90cnm1tJF9h7yyuEarenYV2i
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vctuP9D3A1iyjsKce7feLfOb7CLdpI1JXYxaHjOZR2LyMr9gtWb5g+lxJ9yi?=
 =?us-ascii?Q?xJWib4wA9TQM1JTFx6VIN5kne3j1Nd02LAlhV80R3eC37A0jkoXh37OdKi+U?=
 =?us-ascii?Q?toATtqk/FwZmGPs0wNZ4y8p7uT9bQ+dq43WxzEQf+kXT/4ZsARZyMY4i/Dde?=
 =?us-ascii?Q?vb2QsTEr1Fqaym/+JZIG3CAbR/xQTUOHhJ9QrM4QXbYdTnQHGImQZg4VQp9H?=
 =?us-ascii?Q?HY2Z9LOMaocn3DU32wS/Kll5SfhjrWx06QnnSzqrtQxOokc5ThI+qxPhw+f5?=
 =?us-ascii?Q?0Bn3D8fJ44pL12nbLWL/dPiOT4cc004EiZ0j7Zod5EKsXUHW+9JvoRPrqnK6?=
 =?us-ascii?Q?xj64eWXvXX4M7GUWCrbQuBf/S28dqg2b+y71mukn+ZIeoYgAqVtDCAkhd8Os?=
 =?us-ascii?Q?o4vfwUzhGUE4nRochIftirL/EsqQRzmKgQKrZ7TAaxHeTgHtC5FwkTF69tp1?=
 =?us-ascii?Q?lU8xHC8eG4k5zjX0dhtruUyEFhoJZ17Nfyp73+E2CeuU+7OG14BLep4FtgKM?=
 =?us-ascii?Q?WTAEx4a65nBX1t2EO16X2T+xUBfwu1JH9P7rgjG6C4JBA/aALL/dobwr77K8?=
 =?us-ascii?Q?V4DS+7r1AWclAWMaqf63jwDiskUm9p2T0DYq8cJ6xDb7DnSEO9CbPkhFQevF?=
 =?us-ascii?Q?Lct7tt1LdValLzv1CWM02jDvtaiqBFRW0GssbQ140k1NJzQDZmJhbcETtw8z?=
 =?us-ascii?Q?4vTmLM70skh5za6tQLyfuoREk3PoCbYrPGdXchF9SyPO2qGtjNbAOpD/pwzI?=
 =?us-ascii?Q?oxQdSe8dELKWWkGrhlji2g/Vwg5BmFx7XMvLZK5QoO49oq+3hxwzcM4GxBM6?=
 =?us-ascii?Q?cxtOK0cKOihAJcBye6wuDoAvQK2DJuhw5TTPu0+dMa9fLmcyZ9HEteL7/zDn?=
 =?us-ascii?Q?PvzNxYAx1lshTjnOPm0PzEHepAhH9k0hqBjQDRUnk4fWDk5WY4CEzXrFrftj?=
 =?us-ascii?Q?kCPlYtRu5ncaX0uSRJG+7t+zmOxiyV/eo32qTvrj//z/DToopoeCUs4As+U/?=
 =?us-ascii?Q?whN1heLM5jegrZMB7xQigZ4vpcY1A7Yg6wJNQlId6kD7p/e+kByXIzwsUOL2?=
 =?us-ascii?Q?mLhpOIP9/bGZlOusW+YBcUSZ6G4A+qQDHq8+S7PPrMKZ4wnhYY19JxOhJ0qK?=
 =?us-ascii?Q?SqefNE3PnpjKRCPV1zF4H2y3rmPE5f65K50eAYgkOF90ym5l2YwnJGLxlDCs?=
 =?us-ascii?Q?ZO+AzIDRCQo7uewkq7rHYW1NeHZ1Z3JrrTltGbMdfJVsKnzH3lpED6tmXDc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d1c606-d423-47fb-afe9-08dc13661767
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 12:00:38.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4175

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for t7xx WWAN device firmware flashing & coredump collection
using fastboot interface.

Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to
support firmware flashing and coredump collection, userspace get device
mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

Jinjian Song (4):
  wwan: core: Add WWAN fastboot port type
  net: wwan: t7xx: Add sysfs attribute for device state machine
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Add fastboot WWAN port

 .../networking/device_drivers/wwan/t7xx.rst   |  42 +++++
 drivers/net/wwan/t7xx/Makefile                |   1 +
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c        |  47 ++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h        |  18 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |   5 +-
 drivers/net/wwan/t7xx/t7xx_pci.c              |  96 ++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  14 +-
 drivers/net/wwan/t7xx/t7xx_port.h             |   4 +
 drivers/net/wwan/t7xx/t7xx_port_fastboot.c    | 155 ++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 108 ++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  12 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |   5 +-
 drivers/net/wwan/t7xx/t7xx_reg.h              |  24 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    | 128 +++++++++++++--
 drivers/net/wwan/t7xx/t7xx_state_monitor.h    |   1 +
 drivers/net/wwan/wwan_core.c                  |   4 +
 include/linux/wwan.h                          |   2 +
 17 files changed, 605 insertions(+), 61 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_fastboot.c

-- 
2.34.1


