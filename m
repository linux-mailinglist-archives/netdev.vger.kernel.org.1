Return-Path: <netdev+bounces-55917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F69980CD94
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45ED91F21963
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D048CCC;
	Mon, 11 Dec 2023 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTV6GZQd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9041BCA
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWAh3HTu1wQwC/rvq/6BDwU6Trc1L2QH4ehaC3etwySH5RfR24QRQV8AmOmxyd1RshcFam+gMQfaJMi3+2jvlOIa1lcTs4u3FGiZVuiNf6jf3GaHisrgI1tDgsb4gol0NXUhh8QJieZRGxLUnkQSDe6W/1vMNFWYW0UfxNubBIGWpM3xNG/KcERhFsWwTJ/vgHu6Qfmb544d8yT4wzyhNQ/08PtlF92sHnnseKfHxOlQaBjkspVrjowq8oKpCgNCmaAmZDyN/AxdZrf0dsOAgxp7YD/bHaBa2f8hD3UppVvBUrXoR6bkfRRqE1BPqCzrEQE48RQ15F3f6qnLYzaGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEwRKsN8EMPkjqPsv+9VR5Q6j8mT9OXVY+QH/OTEIOM=;
 b=dGcCSSNtzK9xIG6iNsVRdQNcBtHQyjaIZIEAe/J9kyF7n1W8lgJKLDSdipRkrmrZa1ROYvSXq2cl9VjoM8XCHGhGmpZJosnSXziHeGFv02uyDw/R+fTPXXlFVGM+kdfRgUEF0Y9ok7JoMP4YSqYoKCqx32icAkAGCs7PCLGq2vADp0Te1g1Xvpq+RSyI0fUx8oo8fy5pArMXRHD7spqIs5gPELGOmSj0FkqHnaCZBmrour9nRg5b2WJLh6GNZJglzcwDJ81cBUDP05PJsuYqupZxZ0YplZEYyEVixATPYIUNg1+L3Ybdo1f/mqhHYdu+pMuMs6+JhzDK+FvZIrlMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEwRKsN8EMPkjqPsv+9VR5Q6j8mT9OXVY+QH/OTEIOM=;
 b=GTV6GZQd/fLXxkmBW2mUKrXZNoXGwOCVEd7fAzMky3MwBBlLxEwjs58VIAcx3HPLIh09ILRYt1JaiSyibZe9HgXfiVvh0B/Elu8GH26ebetTBwGWxMj5KqQh7LQHwiHTI9BbCGLblGiuBRFie/K3j5kmxa3LeaoOGCckfCsNaUy8cEKrCPElJOl8Vtaz8SS0FfeMqI1oDhEKTGKJjccB718WXNVUVokR9NyA3NDK4QVsJV4o76UTH+bJS0WOyHee5EH8SVh5oGyEX1h+Ga9bHr9neQ8VXU/QdDd0nQkLEyrEnSgsrY9IKt9yMZ7RPEa6+9wW195cUWFeCVQBBhSLaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:07:51 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:51 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 01/20] bridge: vni: Accept 'del' command
Date: Mon, 11 Dec 2023 09:07:13 -0500
Message-ID: <20231211140732.11475-2-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::9) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 278f7bbc-a912-442b-35a3-08dbfa528fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ROFfiTgSw/yqM/wSw/jyhuuDUS/SrjuJeSDgbVt3VFjW8nJEF6jHKXKMxD6Cb4fUGOzKFmmavzkvhlJouXcUFejquIcAv/uNp2nNNTNZBe9wD7kceonNMeN+SXo9clMhfotGm2QMJ06q33GbKR7YS3WZcMx+nB4TvZDVoTJ0m81pNbFmnP0Q+OBWOjimqP1o0v1WSWaM0O0YzkD04XsobW2ndKOnjZDqjfnCH9I1rXVbXRoYX0OU56TOgWpLT2FdOSeVJPPIWOH3S6kWII5TQtRsrETBBdk25mkw0Ofgz770RtqEjdrNRvjMmj6DqxIAtSbJoIl0Az0cXczzc7kRj3uI1OjIiYGRFhX5tGb1PNgk8c1pI7UA4tNDDZcrE3fe9eQkVBir0F2ebXEpU8HC/0/pT5NThBZt4tmZxTjWx+6OMjliZpdzPwubDVlPSuN+GumusBYHNgL4dvPnkOQ7a25YoUlcsCoxZEg8NTELur/hNfv22guhuSd1UILWuVve5p8o9GCtQ2nsukee3v4/3/KR/SI77fF2KuxTinQ8IjVhi7KefVt88xeCyRD1lwai
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DgYDhR1mLPttuHD1kOckLLFv210i7AKibs2NOe5fais1aRHtUIUL3lbpzQQ6?=
 =?us-ascii?Q?7fzwl6BjRDkLTTwi1DUOdWGOimxIFiGC9fZ21/SWe/i5XqDCOi8LSItDvV17?=
 =?us-ascii?Q?wwQ2Nz2qcxLBh/iKpYEEh/Adgn0vscbHohFMSHoVFXJG6yjgIL4FmPPNn4b2?=
 =?us-ascii?Q?+v1zOQ8Wqd1Vrk/N0LpEzxjDTL2xN2t9+x4S//f/i6Rz6RKOCskcUtmyoMfD?=
 =?us-ascii?Q?hn7KKNlm4s2JYbirfXm4TPoS2L0HgbvvpJqZGk2TY3MW1nQgSwlbFqygQYkh?=
 =?us-ascii?Q?2h/roDoFarMMpXLlJWj23LMlv3onK/MjXxlOrjFw6UWSrLLTYCNyivL9dBoM?=
 =?us-ascii?Q?QvJY8FsBzDOlrskNE/RXrJAtAa0rEZ1BkZ1mSrPgmugxSkAu2P1LdfHuIAbj?=
 =?us-ascii?Q?5YPrkPUttv8K6WpO5HqDsIp80389oYjhEgycnzsWRiJEBun1gyzGQBWuG1l4?=
 =?us-ascii?Q?TMr/HhUTYJfUHxa1PIe76iUFEvvUqwlMtVCtTSnQWLsTvUXsld3YJezl7rNj?=
 =?us-ascii?Q?4eobdGR8GJosLwARz9uhL3asYVnLRYGJROk8CJG6fTH9aGJ9Y38fiqH/8okn?=
 =?us-ascii?Q?J6PKL+5FQwworVhdYx/lo8PiT7QWruKNg8n8ghfcvzXkcVWWCwEmgqi27akZ?=
 =?us-ascii?Q?X1o9StFdTZXlGDckUadyocLv8izFxp5sviYVTSTGL3MGw8nFrgu0D9rNC1Tn?=
 =?us-ascii?Q?YmW+ziibGKE9w5zb3JKGnFaIJBHUjCbVRAxQgfsQK9q+O/XFs0h8domBSZcC?=
 =?us-ascii?Q?RFs5zSqnQuAaKhuP/ZzOrNDRPqC1H4pvL5BmDopVX+2FdaZ1ilU4U2T+EzKt?=
 =?us-ascii?Q?CzFJtdv5G8+aUb8GxmKbUW2A+dLveBU7GMvAF38rNsLhlD3lTkzrL3f71wXV?=
 =?us-ascii?Q?SS66yb1786U9rdQ8tPDuFHZMfPoF69WDvcV1w25KMDhE/+xkWT6G2IhRWyT0?=
 =?us-ascii?Q?z4pOPRCRCbag3MHTDHPY/oHMU/X31y0Yp/tYx07US6Jyi5RZaI0jcMOPY88Z?=
 =?us-ascii?Q?Ht25/eyldYlnzOcqxl1CXjvFTHsdJ4uZGC9wqPcxlwdqSGxBnTMjaTaj5ncC?=
 =?us-ascii?Q?CtwQVbkdx7KmoElHrhsFDiGWJ6rev1oia5g6V2zm9LzsVe9C9l0G1Dcgzut0?=
 =?us-ascii?Q?ZeJaUTufARK0R6mTWzsHzINrS1FnlZLF2kXpyYD8qyNPhX02t0ZysBV7+ifn?=
 =?us-ascii?Q?8UUb63p27ytfOtKnXTdW892XvDFJTjL1iSyLjEa/12wOaYT6VBB/q4ZdZ7tX?=
 =?us-ascii?Q?xobE8YalmWMd7L3ksdvKaVpP+qzbpBwLTPemTRUoTH5RJvskm+4llSeXIDVx?=
 =?us-ascii?Q?I5ZYqU4cU9VkcmmOEmN9EpFMqz5xxrPthb3MQbnq2UFKcd4Y9eOguMsdZoLL?=
 =?us-ascii?Q?Jm2n0I76mosEQeA3GRtG/y5P2M96kFpHZbiuXen25c1tQWPR2Fw0oKol9cvi?=
 =?us-ascii?Q?nhMEeN0ykVi5FDnZ+hV6l6RxF6Ahq+UhpT/o1ZT4aIx0kZwmQu9lX4waT4Be?=
 =?us-ascii?Q?+y9O1pwF1AUfnpKjVea2dyeSSPVvH7C7BzlwBFimxS63FoTkG4w8cgqfqFeE?=
 =?us-ascii?Q?/lH3Eke/Zy4IdrjfdusQ1zsueB6ROEvlnNAG/qOD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278f7bbc-a912-442b-35a3-08dbfa528fec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:51.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ou0BzTeyLrGckE1VSczNHK1DLvp9rUpursQdU6qWdtP8w20RPBc7zE0ve7j+508AZXLWyVU2HHRimhJm6YaJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

`bridge vni help` shows "bridge vni { add | del } ..." but currently
`bridge vni del ...` errors out unexpectedly:
	# bridge vni del
	Command "del" is unknown, try "bridge vni help".

Recognize 'del' as a synonym of the original 'delete' command.

Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index e804cb3f..6c0e35cd 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -419,7 +419,8 @@ int do_vni(int argc, char **argv)
 	if (argc > 0) {
 		if (strcmp(*argv, "add") == 0)
 			return vni_modify(RTM_NEWTUNNEL, argc-1, argv+1);
-		if (strcmp(*argv, "delete") == 0)
+		if (strcmp(*argv, "delete") == 0 ||
+		    strcmp(*argv, "del") == 0)
 			return vni_modify(RTM_DELTUNNEL, argc-1, argv+1);
 		if (strcmp(*argv, "show") == 0 ||
 		    strcmp(*argv, "lst") == 0 ||
-- 
2.43.0


