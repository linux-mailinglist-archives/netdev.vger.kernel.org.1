Return-Path: <netdev+bounces-60454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512CD81F66B
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 10:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033A02824D2
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D363C5;
	Thu, 28 Dec 2023 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FBDmtFGn"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2161.outbound.protection.outlook.com [40.92.63.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121E63AB
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kto5VLSJErrAkHZisKw3vCINbF+QMM69i0IHKJelcEjiiRoST9SP6VRyd0+cecj51otpA0VEElIwak9/udmlnLdNshlASRdu3oMMQib+J5bJ2TssUXHTEnBNFVcII3UjUFzOTFzwDIEh2jLt9UXLaM7t4TsSHEI3ue/6QEp74lhWdLGNSf1M4HLZiVucp5xMmMp51NWSveRPWuGAs1UEnIu/IXwZgJtdERoKqgnZ2qIe2QJ3E3iD6yo1CLt/A3X29p/VVwa8kL+uLo329yLbMlNzlIngaqFMqw3DqFGBBcj+L7l/O85xucKLijiCjc8l2uKArAEVDR5wNSksIs0CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK8UtmH2Cx1bsvmv1VxWrnGsgIv9PdLCwmvyzgGymvI=;
 b=cV4ie0ob1LQ+97V4mPBfEMYJ+Su5/M/e5H2kBnrulvtWIP/vupnExF/9j/ODM96hPOyukamZ2qSB/n73iyM40y8qGMMhz8PK3T+YuRjtBcRCtHU4qs1NP1ZXBOUCU6UDPnCGPfAjBCt1thVt/93RzlIDDQvfwwM4BA4fuvFKZz/cpPj1SnWv3MIoffLFjQyZeERI+zKUMtq8cpX+QUciCp8TvTeNa9QeU4QVKxNLnxnzPpHAmZcSSgnKaXMEAZdbW1HdaK3lTWdkCP4lFryjYw7eGqyw0Dy0kmgWLukXUKHoKU4R4BRS1zJoMH6ijVNfzLsOOgomXRMeWWGd5hq5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK8UtmH2Cx1bsvmv1VxWrnGsgIv9PdLCwmvyzgGymvI=;
 b=FBDmtFGnfxpZru8vZLCeEvcDOh9hzjnq4CkjR+E5BUghhxvyzIu+zWmnVGgVXzozb12uQqNDQczo2iQ9qlUmWIamQDwrAWK2q6Yl1WjTVg7VIIL9C+9j/r9kU+j/W63Dd1hDlGIhHR5/LykSTRGP4Zyfp7HxThW7GAn76u1RJdEhvb6YmWlqvounSh2QPqsbbqeajHw4src92vdGOXC5OcYCskN2QH/Coj9rQ8Ri9m6gjDq3v6UDCqSaapAp69Vrzsr8dwGs7rOu0sun6w4isQ2zEfS5wshEVEE0kPH7skSRgwXmHGLA1E/vAIUn6gKgMPYGZGPU9JHP2pAlVkvR3w==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB1497.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 09:44:43 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:44:43 +0000
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
Subject: [net-next v3 0/3] net: wwan: t7xx: Add fastboot interface 
Date: Thu, 28 Dec 2023 17:44:08 +0800
Message-ID:
 <MEYP282MB2697AB1903F289B38F25CC5ABB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QJwIRoDbirCygRcLEZSIopXIJvAgggcC]
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20231228094411.13224-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 3431c48b-7f7c-4c5e-6c71-08dc07899e38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q1Z0ZN1MTQochTxq05+AvZtUXCKY8mqxZtTu5qCoN4F8dAQnPEc4weAOAXtd2zS4J/Nm1ZuwpClf71EH/UyL9NSVwwJsBkKHVuujEwgFlebnRQAdZkZueYXyLrXXDEYumNK+tPj9pX1qsISaEn9bWz+HacxZJUm4PS7GQxWKUokjxXc0e7+4eISZ8gcygtJF6y9WOTZW5unMeA7dCFWKyoWXJSv6zWx6yooVYQQywVEpowwNvkqNnlxz7tMtnGx+/pvzxGhLu9UuBu/EmNeoq7zUfOJcLjuZk97hZU0lPaOZNZy0jVhl/MGSfIm/6mHBnPZL9NjrPT+/uBcp83a0HLWTtQn0AUsrVBJJ9BpQiWCewq2Im5SkfUq3SdcO1phDVpfu7iuY5DyMNUBz8gfvGgCmF6kVBCPJcEOZGyCVWKr/LB7986KTdSvISKnaHEwzIW0bDXW1ZVuO2i/8LTY2bX89H/tWB5A1HDkWvXQ+MbXqryqRFQCYSdHz51CYY/OJpauC8R0OxbBZjFGT1TKpYqKaeR4NELQebY3ZlTKPNKos6dLw2ADxJtt32pQOiyt2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gmf9pwZ4GjVRlxBLZBHLwYy7mvhJL2mX1a+oHv6Mlte3wmq/yNartX9iUmxf?=
 =?us-ascii?Q?aG1Q3pLu1w23f+3sa2QwgOc5mBoPGe0VMIx2VDaPokYTE/9d8zmbev+TEsPz?=
 =?us-ascii?Q?a54BfJ7qWtKy2HxLY0jE1mdhnqX4H9ao/gDd0BPQvVNIWGjwMXld/tz4TH+k?=
 =?us-ascii?Q?H2oKvpiLLn232hriwyIIMcbhTRoC6u9Pw3zSGZORWNzEhBxUj1h1z1icOu5q?=
 =?us-ascii?Q?uxWran+ukFRXS/70bzOgYNcLmpx9sAnUZCa/z+EcAn7uu1kAScTT1qrhLM/G?=
 =?us-ascii?Q?K5Dmbdpfg4wTv96QGCcBfD+9DIWf2WN+TJ14lWyPOL5ZSr7+CcL8X9/01wbh?=
 =?us-ascii?Q?uwYAXgC5wyZrSGXCHVlGlJXWQQw3gKE/0W0hdipzi/JYVGeuPTD0n+OrT0W2?=
 =?us-ascii?Q?4yQgYPVa36u33Dllc0KlLPXxGlgTk06Cvb5XMAoxVvegkPoQyntC72SaNxJb?=
 =?us-ascii?Q?vGFzn2O7NpSiTKS3HSFJtcCJLg7Z3krWem4RZGoQMmeHQ1QBfmPca2uhk0L5?=
 =?us-ascii?Q?cCB+EvYOMFJznbYq20E/gf20uYHAQM9gycP6DFEbWaed11gtfhGXbjezv5OX?=
 =?us-ascii?Q?lyjxYaRWSztLGwYC4LJDnSBze//JMW6TuReOGx4Ay0TXh4ICxUtVxj5yXFYv?=
 =?us-ascii?Q?275ClBl7Ye/s4nBw4q0guAwQNvxnRP5ikU0CnV40JvabFw1hTMwmfT1zqNhX?=
 =?us-ascii?Q?/gvq4SPyqM437nfEMxic/ffSZh9huHc8byuipVhO2bTvmVflG9iogjCmtu4P?=
 =?us-ascii?Q?kX4QpJFQFbBTdJaIWEGOKjsVPSV7kq5nAsLenP26Gt3n4pR4Q0QBQvdEYb8Q?=
 =?us-ascii?Q?aYXj42XHlw7qMhKy/ZGJX1bNBdD+PSysIKzw1iXodoGORM3S28q8AYz9p1Z8?=
 =?us-ascii?Q?qlLE3sYgYUMP3/dXQ8wSiM7f2VQ5mLHyh2ccGh8eg2SASG6w5VujwWeELqYT?=
 =?us-ascii?Q?qFkcwJ1V9Pgj0lFCBYIJPs2TuBFa55nL0ZOG2cQx3w955cY2xHojxHVEXaQB?=
 =?us-ascii?Q?yXEcJthFnYjo6dI/ZHB61eRE+xd0EWWyQ52FsvAY99+CAzeGodCFMIlgE3mG?=
 =?us-ascii?Q?2FqWY9U9QpQbMiBgbkwVatEAtrvwhEN3hsSXbjpcx+u99XadzOJSrSWUk9GL?=
 =?us-ascii?Q?anjYMkWNQvn9sLeOJ29lkbQLXfLv96EUDfMrMXoZCy9kV1mgj+2Xzbub/sdt?=
 =?us-ascii?Q?t30MLDPLRVvmQ17koFgsDRUunS5QzEMmFRjcnFK3zTRJC+dS1yzOSqfQmDg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3431c48b-7f7c-4c5e-6c71-08dc07899e38
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:44:43.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1497

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for t7xx WWAN device firmware flashing & coredump collection
using fastboot interface.

Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to 
support firmware flashing and coredump collection, userspace get device
mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

Jinjian Song (3):
  wwan: core: Add WWAN fastboot port type
  net: wwan: t7xx: Add sysfs attribute for device state machine
  net: wwan: t7xx: Add fastboot WWAN port

 drivers/net/wwan/t7xx/Makefile             |   1 +
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  47 +++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |   5 +-
 drivers/net/wwan/t7xx/t7xx_pci.c           |  88 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h           |  11 ++
 drivers/net/wwan/t7xx/t7xx_port.h          |   4 +
 drivers/net/wwan/t7xx/t7xx_port_fastboot.c | 155 +++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  89 ++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  12 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c     |   5 +-
 drivers/net/wwan/t7xx/t7xx_reg.h           |  28 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 125 ++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |   1 +
 drivers/net/wwan/wwan_core.c               |   4 +
 include/linux/wwan.h                       |   2 +
 16 files changed, 537 insertions(+), 58 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_fastboot.c

-- 
2.34.1


