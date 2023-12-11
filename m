Return-Path: <netdev+bounces-55919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E980CD96
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26326B20A1F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A0495C0;
	Mon, 11 Dec 2023 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dq4IW8l6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414EA271
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Umv1nmPhnCVmeS2ZZLXzQk4dz8sRpS1/gtN3sDNmKP+iOgOc5QzoBP7QPcCxWole1zqDYPqCzNMXvVfCAaIZTga7RXMovDbEEE00xaxo7dZNkV+znYt4fDPVRguA5vbDDNw1oxWeMOYHf4AZr4rwCcEvre8ouco6OAg1xdMX2/Fix2SDCQLH5ScTOcgDnrjPiN/l4fpeFMDUIp2ow1iktN55ARJevHlzgEsCiyn/zlEES7/1+6WbYIwmjwuFXsY2H1E0bK/AGE7mRvQXBWXFJNycInliOoOF6LHEsmVTdGXjsPeMj6vePQ6idGgH8haJCy2m9RUMzsiok9lq0fKShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8R1UQsiA6dDOkuokHfnYZDxZ0EZG/j2KbSFQ1QdATY=;
 b=ZJ0tckOLIH/q/CBCF5PpPUDkTRRvkHpiGRsL0+cephoGtBoNNTJMP2cvtpog8icEFzVhECC5MlkcJbF3hNeQN8QUZTXxfcI7ihcAf0Nap3AeurLpD1G9VXDnd5AlDzFUpdT5R++PHSDY7QAj1kH0KN6Zz+//OjboTzJ4l1VHjauVvdedZsu04zHFfhyWkmxyYuvIT40nAFPdguXRTFBbrKBtRUj0Tqs60HSDVxqECF3ny7DNQUJZNnBfdphtUt2r4/V3OqStqIiSO3OlxsfoA8Uj0Iqwr57k20v7WqACV8JHrkIrQg6FZFYqgIFI0FNiEK/8qCtJRikBl4uSdvskbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8R1UQsiA6dDOkuokHfnYZDxZ0EZG/j2KbSFQ1QdATY=;
 b=dq4IW8l63I0AE/ZdDSFNdGXwIpKHN45P3RN79DAqZ3R1pbyexowQx+pDDA4ULe3dLNF+rllhyX5OqWMRiZONIyBE4g53mfh5IS+S94+eYJKBMkHxj/6SZYkygrVtC0vaXOQM3OvFSZgQWPR30gEM4zyjBPpgRnJGTNZ8bSp7r/UYUYVbYc6zuFicFekswjI67eiENQqcuinmXDNz4tAa6JAguesWRskosJ8rzaS6T2XdMhzZuF26GKpESbyNTdXXtiuQFXd3NqSc4/SvnlEh9NtWDflUgsDnX88Y++ilTXnirxXnuCS7ku/HYAqSZa76tlQA1EUn2AqRclnb0nadHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:07:56 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:56 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 04/20] bridge: vni: Report duplicate vni argument using duparg()
Date: Mon, 11 Dec 2023 09:07:16 -0500
Message-ID: <20231211140732.11475-5-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::24) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 756999a5-06ef-4ba5-97fc-08dbfa5292e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	05sQqyS7dLAbj6gpdiD5vDZncjqHE3HtXc2rs1ZZTsDAvthFcUyoIvxZaHBA6b11uR5rI4oTvtxF4DUz+mKEcM5JTqtA9izRrg/MNBzTxi81N7krCUJ8Ay5QW9t2Bw7rPjGgK9of6m9WtN1fGre3afW1cKJI80lWPhIdVOOtDxFOd7bSpZbB8MY/e1Z8laL/taMf4zOFEB+Wezb/k4qpVEBJ7lvMg0lselDwKBmifJDb+lK8jb2tugsw2QyuX5f4fFypqYN6O6TZjpG9rkCc9U2vpCNQxxfz4gI9xilW8RZXKQqsn0Rz22XjFZVA0SKU//aHc9Dfrx86GJ333JB/L+k9E5Tx5wB5Y42jhz1NB51GZQSyBUkhg4rRVXE8wiwskWeR/zfgCoLD9nPgWtCSyHLCJuOpOV6Y+Kqt/AfGdFKUae5lcju/biSHuenhIzjmpyT/ryKmqYa1paAHp+aFtzdXxjn7OeDDyXzVUJc79CdYrG5UPXRjB8ksYHwvSHMFSWgoFNkTxraFHPWuk6dq46KT2wfbTMCnPrsCJ+z6HWoXfsWmf7ZehXVfNGjrHQSN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(4744005)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pqVzXjegoOvLijk2nTGvI08EiX7T5lHfMLed1ZLYCtl+DX9RuT1tfTCu6R6+?=
 =?us-ascii?Q?YmX9Ojs8u01GcZFESjy496ACzFyKQ2Dh73ENsdrCtWqPEzFsEK58pLFPtWqX?=
 =?us-ascii?Q?BPPRbKyWYHVSg/eeoYNZbGTyylz7nqFJkoYeQ/oBdAcXQsUxDpGk0U1LDDYy?=
 =?us-ascii?Q?hhSrzsg34jqidL8xBxXQ/e8MhkAvjD31/QPazdneFdayHDIsLFG+hj87oNWt?=
 =?us-ascii?Q?WSZnq/TPRYoRHSlTq/WdZfqqAyt9DZIf7QrkfjiSJBOyhkVpZbN+kYNZOBn2?=
 =?us-ascii?Q?U9El/LW86c4mOIQCZFY1+3ESZy+5+bgjVX41aXpTMOPvem1EZWPLH5hPRB5m?=
 =?us-ascii?Q?OBJ0GWgYbVcKRhQqyK5HGPJPpqGyxxnGy4IvAqMArde2lyK/M1GjWxYPgW2l?=
 =?us-ascii?Q?jweRDWLBtGArDy6VjnXjsXGEvbFgMF3getYtNq3nGY+qRPtHGBGbw+JigB4Q?=
 =?us-ascii?Q?+iaaQ7FT60dcK2d6Yoht53HHCoKWRWkWkuzpBMdcSc0iRqXxqZ55DZU/POHf?=
 =?us-ascii?Q?roWh0pqpMKPXUEDygEzs4L4mmVExxHMhA2ixQaMQYOUSiPaoLRbvQK1azCTG?=
 =?us-ascii?Q?jF3vXdXDQonBkbxrkM7yRNdDgKVPv8oNw1LMwFbJDIb1LNy19wepUahGW3Pc?=
 =?us-ascii?Q?7UOunwC2RGfwlxHsK2A7gsSIbVXj15W4TkH42DdTAliWFXTOVtOSHzLCT2VA?=
 =?us-ascii?Q?a9CsD1bwoM7P7IEPPq9Qv5VwJRxVD//XDmD6W6NzBDnPkiCM56FykkyiAmgH?=
 =?us-ascii?Q?wCO7V9wZtMFeHVTAZGA9W36JeVX075SsAVV9Hr8olAyfKC+GflAuw62KOjcG?=
 =?us-ascii?Q?UiM6DsFwggUBYBWKF+UZpZStyV6NBymCyIWJ2cI2qIP0HPyFNqIg+UajA2aK?=
 =?us-ascii?Q?aA3R75SA+H+rL72TO+m6YKJebTQ45SIjluQRMQaYEKoVrI9B0GEypPUf1R1l?=
 =?us-ascii?Q?lTuyPJ1WsBrkXW2meLkcmIg1edSomIBWK5FYg7AFs4EIpUeC+mcVJRQ+ahri?=
 =?us-ascii?Q?GVb9iAy1qYePI7I/Sj3samHFKZwKrvoRjitnR2QK90GNvGlJcMXNCyzHsUK5?=
 =?us-ascii?Q?kEcW/yIO4wAh1uUew15tyVsxs/5oFFYu0oA97PT4lViJw21lbaOUzjTafpiQ?=
 =?us-ascii?Q?do5ty9TcWvYOyKGXROtlGR5OpkxY91LXXIBQzMCi+BVcASiCiNMO36+I2yI+?=
 =?us-ascii?Q?C/5oifcBnkPHeCQZIDuTOPcKfgLg5rXM9NCbufFb5/DLhuTLceHu785RxHX+?=
 =?us-ascii?Q?8Q70rYNpECPJJPlSvTigb0sDrrPRf5tSbhwDsEqFtjAGo007h+yFOF79r9P1?=
 =?us-ascii?Q?qAF7kPhB7MoDmbAxdjVenJeh5Oh2UbAGEvmbz2SMSt0xwj9TUNMlfM0MK/s8?=
 =?us-ascii?Q?xoLjQmSeMzC9PtwjxZ9QFeJC0Q2LIz21Ap3soFYWPStCw1VW3/5uxEOYeLTd?=
 =?us-ascii?Q?9AZZladfGgdY6AFiu0ozigcP3zgUWiCHfxoz6q7Mqq+v8JnkAhfkZoJOyjwe?=
 =?us-ascii?Q?P7If+5fUJ8VW+vjR5pqONF374xf7DWOzVDHNYrDsF8OiWAFAQMuiq4JVZm79?=
 =?us-ascii?Q?96txN9U5iIO6oeT9IZ0M4GLwvFZKyRiY7h6l1Fku?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756999a5-06ef-4ba5-97fc-08dbfa5292e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:56.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h7MYV2byyT1BSCfRVpTvblUu6P9K0Y9FSou9aIHwNRNCYsWe3w0JNVl4SqB8txAdDDPRyz5y9tnwZOsg/XN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

When there is a duplicate 'vni' option, report the error using duparg()
instead of the generic invarg().

Before:
$ bridge vni add vni 100 vni 101 dev vxlan2
Error: argument "101" is wrong: duplicate vni

After:
$ ./bridge/bridge vni add vni 100 vni 101 dev vxlan2
Error: duplicate "vni": "101" is the second value.

Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 56def2f7..ecd4c2b5 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -104,7 +104,7 @@ static int vni_modify(int cmd, int argc, char **argv)
 		} else if (strcmp(*argv, "vni") == 0) {
 			NEXT_ARG();
 			if (vni)
-				invarg("duplicate vni", *argv);
+				duparg("vni", *argv);
 			vni = *argv;
 		} else if (strcmp(*argv, "group") == 0) {
 			NEXT_ARG();
-- 
2.43.0


