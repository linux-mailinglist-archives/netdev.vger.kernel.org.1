Return-Path: <netdev+bounces-37255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E900B7B473B
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 13:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9A0112818F8
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E221F9D2;
	Sun,  1 Oct 2023 11:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5604439
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 11:42:31 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2129.outbound.protection.outlook.com [40.107.20.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC6BD
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 04:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLcdJQ2XAiBnSumLtGY5SZPI1BfqP4xRyJlrZhIeysQRr509l1Bo1yiXxGt05RxPiQ9yIJlvOS3SXIeCxZSL7nLioBaBRV9yiTYodSJ4QBfGdfh/C+mQNWAhyHVKLditNLstNaphWBZV1YjU5ofgPgf/omFiLvBSfpCLSn82QRpJ+2cjk0FbgN9StS+v4++cgYFTMMLg4UXJTYmDQO+A2aV0t/mNZeamOT/+GsdlASVM6P28DlhoKZO/+N3uRZHVuc8rF/Q4HwZMdCFVN2YrVKKfveSc/qxTX6yFoD3o8UL4HjnOManeA36EWKsrzDey2Fz8GdV3pDhOINlKc4xCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgQJGjfehrQUX4I4Xn55O+Rw2UKHEtbGnfI+RzINPJ4=;
 b=Ae+NM+37vXB6xR66UJMT0MYJo6dYitlpEsGO8SeD93IoS0MM1fZTliQ53IGiyCtW+Y3cQr3BqsizzUX2OBq8vjk36IsEjpHqWuzF6pT0tm7RBm3ZwUERISSJYwc9c2kvA0VEEmwNroro5gPNAa3V+9AS33FgHCoUkrl/fOv2jXml8a1WIQSzbOuH7nVPQDTnONZ3LcjZupi+2Im0p/KwL1sEIhj8JzOdRPK8i+fooccU1a705PB6SkLtbCwHbLlv7hb0Iqic1rwaQifOn8vYmOpVu7I1BaBSxD8YAw8Bseaign7ja5yQHkwajIzutfb83HqcL5MYYQ1/susJa40B5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgQJGjfehrQUX4I4Xn55O+Rw2UKHEtbGnfI+RzINPJ4=;
 b=aqXF12n0lSZKqHOJoSHhxSjWCvq3aAX6pJb6gu4n5rVo04OBvkbaOHnJp0wCDJ3kvci6wQCJDVm0n6JFs21INRhpoxV0GGAl2FXl4+CdZeJxUS0lShr/r6ugPioRPrH3ZCHxZF/EisTseeCXLUrm3l/5OhaieP9IoNYxKfpPkTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by DU0PR05MB9679.eurprd05.prod.outlook.com (2603:10a6:10:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 11:42:27 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1%6]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 11:42:27 +0000
Date: Sun, 1 Oct 2023 13:42:24 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, hawk@kernel.org, lorenzo@kernel.org, 
	Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, mcroce@microsoft.com
Subject: [PATCH v2 2/2] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <uupabbfdmaxzkglgpktztcfoantbehj6w3e4upntuqw2oln52t@l6lapq6f4g4l>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|DU0PR05MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: bac318b9-4231-4b2d-baca-08dbc2737cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HNLeavGVtzB/V5f67gm/sY0pAL+XcntLz68lJX/351t0WkoqlfIxczmpAV724BLnLUlQ4EPDvQ0KvZxN1Fj69/x50RmK/I/UhMlDdmGY/jj/Ze+2q6SXgsrNzdJs9e2P0sfMt9KSQwklR1Q2jO4UgB6g8wga1cXcPS2NF/ffIqWHFXDkdhugSTy/7F4abvwB8vxMxNoZu3FbvAb/QRoRPHBSH5NSNU75LxJmPxq/j07wSFrBuGeP1bNBdydNuNMw2tEE4o+/fI8ZGUeHXRr7vIl1uMSJWvPg6WmO9U/NtTr1zA/w90YIYgaPDOB7irQ/+8o6aT0ttBSnX/0uIieRYsyIwskP8THwkiGd1EM8f5RbFatZIsfD5rI6OsehPXN7/OJclSPxpbu4s66KsU40J36Uh5AHm487Xffct2YR1xWBMIn6in3k2Pb8o8Fcwdk87vNjQYx+e39cn/fz24wdhBjjKMTNmN4JDtls5lZ4JXp7bWzci8RD2B8LSgdnc5iQylvBblDMl7P/l0rloIkUm8q+2gnSgBaEmMkRe6Omsv0bccEh1Z9CenkjaG7mZndi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(39830400003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(66946007)(5660300002)(66556008)(66476007)(41300700001)(44832011)(6916009)(8936002)(316002)(8676002)(2906002)(38100700002)(33716001)(478600001)(26005)(86362001)(83380400001)(6512007)(6506007)(6666004)(9686003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yGQCPPuwB/EBmLxSyIo0aHnT+fYbp2NhZ9VNUPGdzLmigsTA+Uk0UBj7f8If?=
 =?us-ascii?Q?9TIqXgDrD0crJETK20Z9aDTtws3+rQuGQJi/Tpk798QPJ5c8z1ZjDmCxZsXG?=
 =?us-ascii?Q?9yAX/yjG9RcKLKVWVGSlj4j0imFogiMDE8GtIZ5+n2wqcQm/ckj/2JepxFui?=
 =?us-ascii?Q?i7UzY8y0O1N2eg6eSh4DiI6Hflp6pk/t1hA2rb9ZJDQUe7hYbugi8T2HhH/y?=
 =?us-ascii?Q?ERcDG9kRaVc9Gc8qlbrfXAyfLtsUnJ6YpWN2pbU228Cac/o5hxoJ8rnvfzfF?=
 =?us-ascii?Q?JJkUI+aXz5CO0hMvhm1sp+SKSMHEUvhTfmGpfp97J2sveYBMf0xKG4p6Np1U?=
 =?us-ascii?Q?5iuaCGWN+8mTEFirVbmZJcwHL4ZjUKM4rCYytKy+etaZLW9lrq9VefXlmcpW?=
 =?us-ascii?Q?0mAn159pWhxBEq+u6bZF8c+1Kr4vlxU9zyBMhBDKwMwEcZ32IZOtLiLRnssU?=
 =?us-ascii?Q?L+rINvQV3YyV1EfeN5vxYrFRkUqmhNYc3FO9PA7nE5xAko1PRSVEIK/Tyz5S?=
 =?us-ascii?Q?ag+4FcQDw3M8t8/1a60thkMzLUorCH1gEgtJZnqP18k8pgFyB9h4/lp5wXsR?=
 =?us-ascii?Q?ZGBK3DUaLbqmcS1oFovIBt5eTUZmBHwaY7Wtv6PQ3L6wX7t6NkwwrzFt0RK3?=
 =?us-ascii?Q?py8cRylNdU+EpuC6JmIZUs9H4899A+62KNnl/0Ctr+kMhJA/g1uXw0VYuN68?=
 =?us-ascii?Q?Q6O4SdbC+PStGJkgttNtUBXJ2W4J38JddPtS8kPHv54hLSRWO2a2ibAeEfK2?=
 =?us-ascii?Q?lzTA8ZmDl/QWoQ1T5ivd5zU63tjxe9l4NA51GYwr3zvMuWFbgWn409D9PNHC?=
 =?us-ascii?Q?VDbgPqu2IgpDJglm9il6NCuMHDg2ML5dWFDrNyPwyZJ6dG68oNil2O3XNt/N?=
 =?us-ascii?Q?qA0tqBBrJa558tIv0euZlw8NABl3t+/6ko7rnZUP1Mebb77enK5w4rtf42z9?=
 =?us-ascii?Q?R6zC6vDbM8sic1OtNFQzi3ORR6uaAXlN+jRJOohu7WstJqm3R3nOjm4AzMnx?=
 =?us-ascii?Q?YU1IXN4R0eXZisWy98wGXtWMJJ1o1xp7obb1SGI0FnEEyQVNdWiDPumnQwvM?=
 =?us-ascii?Q?IuSbjXuk9qJqIVVOTadLLOtth3Q9fZYk6pD00ycvoN9Gj6uHIRMu0FajAuM4?=
 =?us-ascii?Q?MUz5BmP2IvImiiXINT1CzzcJdYlDTg5rlmE/6Qm67XKj0CGUTaGtrSGOsxde?=
 =?us-ascii?Q?ZdcHR3PL4m1g3DEkPJ64hOFcSGIwov1cxB4rt5HnKhSRUN81xN62HAqBx31u?=
 =?us-ascii?Q?rZ4Oo9lotLUdEHiVlcIlTHzCuJgfAdnAotq7ywyGhPoJ6s3i7FfPamb9A0Xa?=
 =?us-ascii?Q?IAGaT8EAOBJ5oG9Zg5PFjIiTub9sxlMKwi7v5RcXtgNWXtrYJfqUJivp+Toz?=
 =?us-ascii?Q?M6hQxszG5+LM/BIFdTrMz2m7tGqn2wSs5E3HLZUJ+++i3lFFLsXhXFetVyZ7?=
 =?us-ascii?Q?qA8mtOwkiY6IUUkSJmZrcWz9/ekG+EzovrPxQ1uuJPoSPPs3AchYbLWUMmK1?=
 =?us-ascii?Q?wGJ9BfIHbzbE9uBi1099HRMIFyhYdlJvXrArLK8U/x2ybX7Jnv3I+Pr1C0Y+?=
 =?us-ascii?Q?fCb1VoFFX6llvP8KvC9TfsZfBaAVkwrLij52Xj3a+Qc1+R7D29NCXqoSIy+c?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bac318b9-4231-4b2d-baca-08dbc2737cca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 11:42:27.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgoSvYYM519HABawH3R/42W5mA/qdh6yY2yA4LoJi1P/8r85quNXBnR2jmtioAJz2Oy3lkaYc4hMGN/ZN94IaT3g57HJfumlh3SAHdUyEt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9679
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>

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


