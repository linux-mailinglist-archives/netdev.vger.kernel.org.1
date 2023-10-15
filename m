Return-Path: <netdev+bounces-41074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445AC7C9901
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9771C208DC
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0A63DA;
	Sun, 15 Oct 2023 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="JAYBjXgR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BA6D19
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 12:37:57 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2117.outbound.protection.outlook.com [40.107.104.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC16DC
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 05:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgBl5D2a6uT+B/4756x4XWJf4YdjuhCnu3n/A6YwJOWhuuwVH7ZXl+EPH+0yFjr2sWjzAEipYrKycD5aD5XSLTQUh9faQ0azim5jJgEKfTYb6I1Yr5b99gSx5txu/oaH0ICjPVJ0WZQ+KsF30bIU9Rk89U8OPM4wCU4ka9b4FTEzvet+JBLQWIdLtM9oIY2q7sKhzQqUC2mCnpR7wzdaOsdqtjCDcZemJgif3TcCIWsgRyVzWGqs5G1GYwaePQGN5hS2+GrQ6Go/Rm1lBn6nBEIQMqRVoXTLyo1b6Hnd457Kv9+IXY9QLswAbodBIU1lZy2NDirgFJEI5HC11RDzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PT0EaqOb7ceInDfF1kSh3qzMIjQHAbBp2PxZmzHAiQ=;
 b=W+r6ZO6+7o0M6Jg/C8gUZ+Lt+hPM0pLafWKrSSuddDFS5H5VsfFcB5jUuW2/6VU2//ibTKZIuVQAaR+CJisvCQjEqKkBgicvFoGAcP/bXSq1aCQmH9HD6M11WDLesSrbCOsKjcD5T1owZymVxipdUIV1DcF1CHHpaKBPizKAti47pwoNP2XHccSiqHVEZSYK0e7dlyDcJFoqtlnB4mM7wjLApNgI3qQl/i48cDtiEsDPGXyCkfxUbcsRV1D+nvEcuSC2BY0FJvBqlm1ZhhIja32uZlOSV3VmFLllNNy9IK1EnmLa+alZI7a/Np1NZ29VLUqIUbfikdyln/7l0ns1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PT0EaqOb7ceInDfF1kSh3qzMIjQHAbBp2PxZmzHAiQ=;
 b=JAYBjXgRQ/VJhOd4dK4zpne+62mGwgFrTVK63VeO48M5+lx9VqQ0/+A9JjRXTFSn7CFQqqVSFP3kSqhudYohgzYKhOnP+PM2XW+bxUGDxJRt4sB6SaTHcQUVMm9umL/tGeYSnx7/kfWk3gLhwJim0Np9yb8MxHRuwQiWDuvm148=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by DB9PR05MB8123.eurprd05.prod.outlook.com (2603:10a6:10:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sun, 15 Oct
 2023 12:37:54 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::cd64:d5c9:2116:1837]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::cd64:d5c9:2116:1837%7]) with mapi id 15.20.6863.047; Sun, 15 Oct 2023
 12:37:54 +0000
Date: Sun, 15 Oct 2023 14:37:50 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, brouer@redhat.com, lorenzo@kernel.org, 
	Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, mcroce@microsoft.com
Subject: [PATCH v3 2/2] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <5kcf3pxkzor5p4lvzfgbszthrl33fzho6qonyvznxrjdde4gci@vt2nakbgdpfq>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|DB9PR05MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd18618-ba93-4c5a-4926-08dbcd7b8d4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3XcBW1F3G2EmUsvGPsUzJYNjo8DCvzH4wpEx+6ceVKt5it5w0GytGKx262VQ76mfOFZew1IMMKsujxS46W2asECYDFKvHVuQcjk2itg/3ptzB2ApFDuppy0GF8Q92ymG8mXvkm2D6q0R+6GbljO0BD7pMOLAUWT2vGqRB7F0XpZamsqpybGCDQpHndPuoIF9g9MDU4qUpijQbeV5WE19iDMM0Mm5qRfJnVx/vv/bSCXvy3Qodp/0STP5pxp9H2k0Q/YYXdmFiUTIwk9q2scc9G9GKSJOGeC/YPAT2smBNCR4aXASOjm4j3rDbe6N+NlIw6zhopA/1HEOW9+budFG2k7wvWqWpH64uvI8SW7KXN9jByyJVtoX1AJ06W6VBCAP7gHRignHc8fDCSSwLIt+RRH8TiCfGqHL1w26wtzJQTm12YrBZ18qZyUcPqnGm8+uwYrdtVChrgsX2LjrlvrmzpyHRSyas2tNyzxsJJiujd1zl4BCeVRKpeV3KYidScIHlHt+/rwQap7/Vq2m+p5wKfMFHytFYH/PguYmZ7UW2G2Egrh5spjGVf2l8iygrTty
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39830400003)(136003)(376002)(396003)(64100799003)(1800799009)(451199024)(186009)(6666004)(9686003)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(6486002)(478600001)(83380400001)(26005)(6916009)(316002)(41300700001)(66946007)(66556008)(66476007)(86362001)(38100700002)(33716001)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQMQ+XAJuNXNdreF3PbjE1PpN9okKqTD6Dc5NMEeyll+kiTZLcFgifSzJUw8?=
 =?us-ascii?Q?6wtH0vTcZXItddSJfEEE33GHpdZefoFPB9JJ6pMpcMi78mCCznoVFcIW95Nr?=
 =?us-ascii?Q?t6W1TIkXQuRzfUl8V+egoqt0VX2Qz8enak3QjVTw4Hb9u1W3RKKB1XacgtK5?=
 =?us-ascii?Q?4vyCz9kwc2tWjTjc1oTpDkMcbhFuvGhoa1HNDLD4NyjrfaYbIPJhYTtdn/MH?=
 =?us-ascii?Q?uQwzrdyPvqaonixGA0KFBLwjDPd3yzyRPbBZLtczJ+wtwhhEsuLPzcYRmxS2?=
 =?us-ascii?Q?HwTzh5i5M0Z7RSmL4FijYNCCskrL5ualHIAxwEwd44PRtLBRk0EqY8dqXX+T?=
 =?us-ascii?Q?7wsnvwKXwVCX35LVWIe4QTj/icpb7aivGwqWW7/oyB9N4atkxG/4mk1XLGJa?=
 =?us-ascii?Q?iVwx4kxWUkimRUTq7eM3BP9/Kejcj/tZ6L5ekGfDKK7WJVzbyMT8waBZm+Z6?=
 =?us-ascii?Q?EhHa/ssHChp8Eq/DhzllJGptDvKWWyx8V85oQ+So14Ii5O3PCAdS/8Kk7Hrf?=
 =?us-ascii?Q?1JZWnluuARmqmN11LhWfcqfizhw/Yev0bKKHsN6C3IuxMFfHg5m8bjy5iI9Z?=
 =?us-ascii?Q?19Qka+x5q9Lhn5QW4CY/KAUa9bmOk9+yeDSGeAMO/zuv5+lAQKphoKEbXuJh?=
 =?us-ascii?Q?IhYhZDMKAn7cn4JkSbq1XCl5nShjhLYIvxjb3fITAIQ6ovvsEj/VQbAvkKfl?=
 =?us-ascii?Q?265P4d8cui+1NOm0XRkDoyqjYwV623AYCk52p1OQXPIvo4se50ma3thZdmEf?=
 =?us-ascii?Q?Re5i7lhetPUKjRg6nna0x3nT6r8jcXcqGUSqTBLyz8Xr2h/olgjRurta3n8d?=
 =?us-ascii?Q?k6DVQ4EPxNbjpTOIZiTnFBEXJqzA4N/Gwp8nt9QMqz0Xl0Dcc/3tNQQ+kgaU?=
 =?us-ascii?Q?cDXiQ6BcIvutzKUSIWhBZz+KEZDTwKslubPcMzs0yJ0cruWU7HIPve3f8zUv?=
 =?us-ascii?Q?E09es1VKKANGnHIOqDmgdWIrnPD66WImngRerRuViR/74RzctiBL2UQucLSh?=
 =?us-ascii?Q?/+Yeb4FJPWdlAg8jtP9EzawLvlSH9zHOiKGJtdqWpFCRySU5oYC6Prw93qVo?=
 =?us-ascii?Q?pmPuSaPsN66aRUXx+r8lMWZgzuSlfqMcniYVASLqnCatcTzniVQXCu6uOSDQ?=
 =?us-ascii?Q?DH/z/WXp5xLyCpxTrBcqXI/74k4+6FtSKjXxJ4RGFrP0nF9PFQ30JxwJ3gS0?=
 =?us-ascii?Q?aw1t8+GM9cYCiLMUWjjVZTOPWp8NSGV9hLDdyTcEj0Hrs2cDKS3SlHzHWO5a?=
 =?us-ascii?Q?PB18K66iscK1HjQaFqVXWAfMlWIC2RjNTuSGVJlklUC9jlpjPS1ArjcYLOry?=
 =?us-ascii?Q?F2aukfPlicvOBwoZz+VEdJTx8iv2wdlN4Mjt5VqyzvNA2LWwqnVt71t5XixC?=
 =?us-ascii?Q?SzuzUMbOIbhNd+millSlmG4YWBthK7lJuDb+uwQYMq5GQYRkVMbFFrJXe0GM?=
 =?us-ascii?Q?cIN8CtUWUIyHbexqKMHW2jPesqvk28fY4oAevKLMtKaKeViHUL7IcnqfNPoq?=
 =?us-ascii?Q?+sMoMUeCxU6RWyX/h+wRT5tSvEWc3F3bBBm1FH1oEggDojrzAmrE5pVULxq8?=
 =?us-ascii?Q?WfptcyQrlwJ+jMjVQ8t/HIeGyR7YxqUTRoloqsozRcG8bejHQQK/wT5lMz0T?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd18618-ba93-4c5a-4926-08dbcd7b8d4d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 12:37:53.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhO6CY9L72JkGub7emouteqCgrp5I0PD2U8Oeobkm/ZqFdTB9MgsgNuvq5sTPTKo9J/DF8HzU6WEPz+KfTw/ggBrXoII8kzqdKqjHsdOhQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Calling page_pool_get_stats in the mvneta driver without checks
leads to kernel crashes.
First the page pool is only available if the bm is not used.
The page pool is also not allocated when the port is stopped.
It can also be not allocated in case of errors.

The current implementation leads to the following crash calling
ethstats on a port that is down or when calling it at the wrong moment:

ble to handle kernel NULL pointer dereference at virtual address 00000070
[00000070] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Hardware name: Marvell Armada 380/385 (Device Tree)
PC is at page_pool_get_stats+0x18/0x1cc
LR is at mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
pc : [<c0b413cc>]    lr : [<bf0a98d8>]    psr: a0000013
sp : f1439d48  ip : f1439dc0  fp : 0000001d
r10: 00000100  r9 : c4816b80  r8 : f0d75150
r7 : bf0b400c  r6 : c238f000  r5 : 00000000  r4 : f1439d68
r3 : c2091040  r2 : ffffffd8  r1 : f1439d68  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 066b004a  DAC: 00000051
Register r0 information: NULL pointer
Register r1 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
Register r2 information: non-paged memory
Register r3 information: slab kmalloc-2k start c2091000 pointer offset 64 size 2048
Register r4 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
Register r5 information: NULL pointer
Register r6 information: slab kmalloc-cg-4k start c238f000 pointer offset 0 size 4096
Register r7 information: 15-page vmalloc region starting at 0xbf0a8000 allocated at load_module+0xa30/0x219c
Register r8 information: 1-page vmalloc region starting at 0xf0d75000 allocated at ethtool_get_stats+0x138/0x208
Register r9 information: slab task_struct start c4816b80 pointer offset 0
Register r10 information: non-paged memory
Register r11 information: non-paged memory
Register r12 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
Process snmpd (pid: 733, stack limit = 0x38de3a88)
Stack: (0xf1439d48 to 0xf143a000)
9d40:                   000000c0 00000001 c238f000 bf0b400c f0d75150 c4816b80
9d60: 00000100 bf0a98d8 00000000 00000000 00000000 00000000 00000000 00000000
9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9dc0: 00000dc0 5335509c 00000035 c238f000 bf0b2214 01067f50 f0d75000 c0b9b9c8
9de0: 0000001d 00000035 c2212094 5335509c c4816b80 c238f000 c5ad6e00 01067f50
9e00: c1b0be80 c4816b80 00014813 c0b9d7f0 00000000 00000000 0000001d 0000001d
9e20: 00000000 00001200 00000000 00000000 c216ed90 c73943b8 00000000 00000000
9e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e60: 00000000 c0ad9034 00000000 00000000 00000000 00000000 00000000 00000000
9e80: 00000000 00000000 00000000 5335509c c1b0be80 f1439ee4 00008946 c1b0be80
9ea0: 01067f50 f1439ee3 00000000 00000046 b6d77ae0 c0b383f0 00008946 becc83e8
9ec0: c1b0be80 00000051 0000000b c68ca480 c7172d00 c0ad8ff0 f1439ee3 cf600e40
9ee0: 01600e40 32687465 00000000 00000000 00000000 01067f50 00000000 00000000
9f00: 00000000 5335509c 00008946 00008946 00000000 c68ca480 becc83e8 c05e2de0
9f20: f1439fb0 c03002f0 00000006 5ac3c35a c4816b80 00000006 b6d77ae0 c030caf0
9f40: c4817350 00000014 f1439e1c 0000000c 00000000 00000051 01000000 00000014
9f60: 00003fec f1439edc 00000001 c0372abc b6d77ae0 c0372abc cf600e40 5335509c
9f80: c21e6800 01015c9c 0000000b 00008946 00000036 c03002f0 c4816b80 00000036
9fa0: b6d77ae0 c03000c0 01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
9fe0: b6dbf738 becc838c b6d186d7 b6baa858 40000030 0000000b 00000000 00000000
 page_pool_get_stats from mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
 mvneta_ethtool_get_stats [mvneta] from ethtool_get_stats+0x154/0x208
 ethtool_get_stats from dev_ethtool+0xf48/0x2480
 dev_ethtool from dev_ioctl+0x538/0x63c
 dev_ioctl from sock_ioctl+0x49c/0x53c
 sock_ioctl from sys_ioctl+0x134/0xbd8
 sys_ioctl from ret_fast_syscall+0x0/0x1c
Exception stack(0xf1439fa8 to 0xf1439ff0)
9fa0:                   01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
9fe0: b6dbf738 becc838c b6d186d7 b6baa858
Code: e28dd004 e1a05000 e2514000 0a00006a (e5902070)

This commit adds the proper checks before calling page_pool_get_stats.

Fixes: b3fc79225f05 ("net: mvneta: add support for page_pool_get_stats")
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 8b0f12a0e0f2..f368bcef725a 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4734,13 +4734,16 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
 {
 	if (sset == ETH_SS_STATS) {
 		int i;
+		struct mvneta_port *pp = netdev_priv(netdev);
 
 		for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
 			memcpy(data + i * ETH_GSTRING_LEN,
 			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
 
-		data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
-		page_pool_ethtool_stats_get_strings(data);
+		if (!pp->bm_priv) {
+			data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
+			page_pool_ethtool_stats_get_strings(data);
+		}
 	}
 }
 
@@ -4875,14 +4878,21 @@ static void mvneta_ethtool_get_stats(struct net_device *dev,
 	for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
 		*data++ = pp->ethtool_stats[i];
 
-	mvneta_ethtool_pp_stats(pp, data);
+	if (!pp->bm_priv && !pp->is_stopped)
+		mvneta_ethtool_pp_stats(pp, data);
 }
 
 static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sset)
 {
-	if (sset == ETH_SS_STATS)
-		return ARRAY_SIZE(mvneta_statistics) +
-		       page_pool_ethtool_stats_get_count();
+	if (sset == ETH_SS_STATS) {
+		int count = ARRAY_SIZE(mvneta_statistics);
+		struct mvneta_port *pp = netdev_priv(dev);
+
+		if (!pp->bm_priv)
+			count += page_pool_ethtool_stats_get_count();
+
+		return count;
+	}
 
 	return -EOPNOTSUPP;
 }
-- 
2.42.0


