Return-Path: <netdev+bounces-36965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CEA7B2ADA
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 06:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C6F8A282D2C
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 04:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DC79DF;
	Fri, 29 Sep 2023 04:04:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8169747B
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 04:04:37 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2100.outbound.protection.outlook.com [40.107.21.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF319C
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 21:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm9IUxrPuFEc1P+PHrCoRMFZeI5ypoIoM5fFwjfxMtJBPRQO13hf55Fue8vh8TMVJy4JN+zHb5CM2Es5dUmlAJ3v5dD53jynEHqrDb/B1SRDKsawpVub1K509XPbfL7Yly+Q6fZCmlheXB1pdnnNI3WMOEX9mZ2eWN9ut5TciIX1ORIlARWOS10RM2Km/keOISToMmOIMPeMSkZj+bhFvRIvlzkxBgPtuv7jemv/ZqexHJkCm8VrLYV7etycwz6lR2HagpCoeu+P9w1FIJePOTjMq7AmOgjUWcaPlYfDo+Y0nMnLK8nRR4U01rSLLLT4nXKXZZWy0Mj8qwRuhbe+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ne9fSetFHfKDxYxw/jSnHvmzthkv0K82mrcfoa7cg4=;
 b=QP/Qm4qZbslaElxBvja+RedVP5aopvWbAtEt9yhfRpeeOwK2IsWplfJO5emjiBy1sPIWSfBd9y+p5C2VFqChjPDNCDe26YCjR39mVWqrvCMIOaoa7I3M5Y7kdz3sb/h29O9WyRGJNWfUVzTFxOlSPAmpTAqe1bJ9sm3e9BY9dL4RTJUT0fT5+8VZ+LKPypaUohClqOBrCOAKBMJXksRPnVfszFjZrtWau7uh0+F7r8v06nHg3A0nBCW5vCxmnAP4tZu7nS6xEahZp4U0m9evaNOHxv5s9fsAI9z7q/TKD408U7cf3OXNvVFiI6Gk3YbhuHDNBGSQVR0rq41WJAlsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ne9fSetFHfKDxYxw/jSnHvmzthkv0K82mrcfoa7cg4=;
 b=B+6PDroCrx2dvckpMkDUS35UVXWOrfeppRVdCpgYBTNghu8XDbDUXvm2/NaN8iBpFt+FfR63QKc97SvSU28UoxSavHR2mYWYnvl5Dwto18Yc3+HKBSyjVo2gKSaUzHtNF/woQ3EWRrVOeYnC6MvycW+wK7xjY8MOLVNxKjUpHQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by DU0PR05MB9744.eurprd05.prod.outlook.com (2603:10a6:10:40f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 04:04:31 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1%6]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 04:04:31 +0000
Date: Fri, 29 Sep 2023 06:04:27 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, brouer@redhat.com, lorenzo@kernel.org, 
	Paulo.DaSilva@kyberna.com
Subject: [PATCH] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <lagygwdvtqwndmqzx6bccs5wixyl2dvt4cdnkzbh7o5idt3lks@2ytjspavah6n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|DU0PR05MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 343f8618-43cf-4c44-fba1-08dbc0a12ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jxNM9+izAtzlf1965npXYKUbiVZiijnxEyMmOKrwi8gUrRQOxGr7Q/IyBBLZUaL89cvdGbWxWbrlSih/JyAjHi76Ko4KqhA/Z2AzWj6Fch/IdHbUP0kCr22DJ33b6mNQ2I+VmtEzwzlfJ5gZpKxKDCFIaAJqGU34A5p2BwsKih2nrvU4S9VKDzfWq9XN0Lq/Vb9fbtQW3Yw/T8r6VbGUeN5yD/8W85TYeB7mQKROXFWYErCS57/fMjZL2Oqh/Z+l6dnLfNbJkcf5zxQ49bEiJ4EnCBRrJw8WnDb8d6BFqrgVaGZeEFx9NfwfBSVC2UDoP33OZnuuowhR7rybquJ02t7ZX7V75KstFEROFWSUWR7+oM+CM41+r2YNXLz7MHFjCMBGtnwwNCqBgOsixXp9avXC5QYUbKSaxh3GA+NJdmiGk/pZiJ9B2u49v8YDLulWnq2xH31xZCYDZFpWlU/A7tcenFkYfLdkW0XOfQm8uP1Sgz5+SWmJ05a7Y7M0BEUVDsWnfZAHNeKrrv/dYOPmtvbIzl6Hl5pH05gLaxu3SUfoOQkl11AdAX0UQTwMsUDm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39830400003)(136003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6666004)(26005)(478600001)(83380400001)(86362001)(33716001)(5660300002)(6506007)(38100700002)(6486002)(4326008)(6512007)(9686003)(2906002)(8676002)(41300700001)(316002)(66946007)(66556008)(66476007)(6916009)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6q92eriqnHde01Hwu97I9pkEpSFmnABOPFcPeNIyq5Z2WUIEbD3j26cnWsfH?=
 =?us-ascii?Q?dWJjFVbk+hUMpDK8m5v9bfaNSXuv6Lq6/KchhUCigvxkN+B6l75NDFRk6r0m?=
 =?us-ascii?Q?N4O9EwS/w1O4ONP7SgkSZ6DlQ4G4m3H6QFzY/gO0Wqe7Bdv5lTZtl6NxeDal?=
 =?us-ascii?Q?vKc6ZEhoq7YxK51YhpNI02BDdCy5efRvRy9kJl8du9Dy7Ru3WVLjGPe7q5di?=
 =?us-ascii?Q?rE3Fw05ualsx0rhGRedbvFnJjuuDtxPDLokicet45aDmN9KcvfWln7uHa25+?=
 =?us-ascii?Q?Ks5SZhkhOJqXUziUuBWVyJM/6jJuC0dbnx5m+Ls1qHu/PZTiJ8BbA5BwKaMk?=
 =?us-ascii?Q?A9lLesZL3virHcGXPU7EFg0uyi3B3prgm4ctIOttCi4ESwrpV1n42995MTn/?=
 =?us-ascii?Q?OHAfW/k1U7ZEY7EASmuOQX6/E+GCOdx7mc+0g6IwjSwET8D1zp7jwCQ8IU+b?=
 =?us-ascii?Q?AoylmvKP5IW1Pfqej2wQIIup6wJuDLWCNGcw7ccA3tJtEzVXXsGXqHE1+vYy?=
 =?us-ascii?Q?oYQmLTMolczqgTYuEgzj8F3OGY8jjY+2qFS+Sv5tyqd8F10Y2CR0aMP1oYWK?=
 =?us-ascii?Q?cM0QSvM8yC8szvb/nVtWsuHhVaN9azYotgCQ+zIMr2ohOV7DrFDN9TcE24/o?=
 =?us-ascii?Q?Eig6kjods2/vlnv1he80BV4Xxa61TAchI/BPYBIwKNzyDkEEiY/DPani59rB?=
 =?us-ascii?Q?n/pxOr5AUPn17UtUb94jwNkjednfgtJhS0Mw/89x0YBsBC7RIg+KJjYGH5ka?=
 =?us-ascii?Q?pL+LqrmruwMsA17IN5FaOLsGT8jOPEJGKMUu/GCvbm+lJa8eh4YOOVc895W+?=
 =?us-ascii?Q?WX8Lo27eqDiM/J5n4XeeSY8adZeuF+BjTYWSXGV/TQpCfezuxdSeM5fWClqf?=
 =?us-ascii?Q?UT6FzFrsxByzI9z1gkAWl11Uk+IR+7IqJSoaofUnbuk23X0jcr0ePUOYgwTV?=
 =?us-ascii?Q?qxpqFOW4GLWFsLh+8w33mx9oBegyMq2TyiF2aRjIrkPc8cCP+X/TRID1tK+W?=
 =?us-ascii?Q?XKCxSpJiNiMA6sBgsObIMLdkeEi5c8XKvtdYhFiPHRPLvba7TVZhvLb5+uLP?=
 =?us-ascii?Q?yc9E4J+H90AkY74XI7+1bUSOzZJYmgkYD+7O74Kg6HjwkedXbw8twiF5Z0qp?=
 =?us-ascii?Q?2p2UuGnzpEV6YWqFxcCXsNksKfpaHLBtEhITo4ZOvBqTvgGY5tSbuani9WLI?=
 =?us-ascii?Q?rGXkOMJx0sSZbSUIQMw+vdw/UgTCwRQszja4luq6pPn+htO0U6pD1Sp+Cgzo?=
 =?us-ascii?Q?rFJYMAUZv3NF3H3V6vK3dJ9VDxYosUf1be2vcnMJP+MsCM4Nx89+COWpTNvI?=
 =?us-ascii?Q?Uf8jNfY0MU0dMdCBuS6WnhfwWA8Q4TkUMXXWB7hXJUyY0oiVfD1akIu7gvrr?=
 =?us-ascii?Q?4HnpW9+V8HwluGsA2m3BrUe7cEgKIax1adfy4+fI0ZZ1aOYaPC3MPtPslRLa?=
 =?us-ascii?Q?Ohn++vJq3vxeA3KwW/RJ5K/K+Thpg1KfK6uW324gY11Paig73bDcpl2gCD82?=
 =?us-ascii?Q?8DuMXx/1jM/fl7UapB33gJuxzTXr4I+YqbVrvljdJsH/oEMcWraZ5UMEVORS?=
 =?us-ascii?Q?iuF3LE9PDYUEzgANo/7OJQgSnqsGBjOaPHlZz0E/RhHEkwiRdGmOK31eW/sI?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 343f8618-43cf-4c44-fba1-08dbc0a12ed9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 04:04:31.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYlWYHSvpkxhOO5qJ7vceN5CRibO8DxHZ45q++VsIaf7HtpleHhHUl6V8ufqNw4Gi293BSpkS3UMFj3Bw9YQd93JFILmoxe7zGKYjiJLOrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

Fixes: b3fc792 ("net: mvneta: add support for page_pool_get_stats")
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Reported-by: Paulo Da Silva <paulo.dasilva@kyberna.com>

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d50ac1fc288a..6331f284dc97 100644
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
 
@@ -4858,8 +4861,10 @@ static void mvneta_ethtool_pp_stats(struct mvneta_port *pp, u64 *data)
 	struct page_pool_stats stats = {};
 	int i;
 
-	for (i = 0; i < rxq_number; i++)
-		page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
+	for (i = 0; i < rxq_number; i++) {
+		if (pp->rxqs[i].page_pool)
+			page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
+	}
 
 	page_pool_ethtool_stats_get(data, &stats);
 }
@@ -4875,14 +4880,21 @@ static void mvneta_ethtool_get_stats(struct net_device *dev,
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
2.33.1


