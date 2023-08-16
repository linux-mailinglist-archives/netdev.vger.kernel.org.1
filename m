Return-Path: <netdev+bounces-28107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D877E3F0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362A61C210D0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27D16404;
	Wed, 16 Aug 2023 14:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938716400
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73524E2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at+zCVHaPCOE8S/ESb145492qzCpYNdLv06SB7+/gcKBOiXDJRsY6UD4u5ElGN185WUw1F8T2pppiQIa6mlI0vGmjO9aEPQo6PMQ3yLfeJJzkNdrCWXfYGj8D4Tu90BOJ+l0qe3HOYlqUBPcihJnnoYKjHhb7iIfmS/qakmY5pgAXbfcnUWE2Payz8Hx1r/B/z6HeMdwQ1vMtEzJKswGt9A+ehb9jUzMYqS0XbAD7I7faFIuHpkLpcvuaEaabJCiltN4Zqu3CGT69FU24f16Wp7MFJ68hWElZsZ7/f54mJyjD9LPxSoodVrReFx9dVewjVXWC0Br/pJaY7A0s82zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBaCd1M8cGniBmbrxUKvcUgFyV0fqOdb+LDNHqazl/w=;
 b=Mpp4Z1YDB3RCTpVOHRPtm+U7rjvkakLQMuYHNb4mnYY17W+UGe4AE4cSTVbHWBxyHc07NV845NLWnym+oMB5zRXNdST7g3w+0Fp/2JZ4Q4KiJWsR/xGbSJlPLqCYxkFhgjb6R7pKGCgB0ZwaVoZdcgMaTR/TbVBwov1/l4vX6V1odXAlVkgkWwyGYa6bS5oniT6iucYQ0iH8XQmWN5c6CzKnOSfUzIpAN5KzSgS6U7i8Y2DgLIxEnh6oOjEU8ww3XCs8AFRLRL6F95LBJTIhQIok5xDORrjp1atFHhQFeQ0U0gO2n2tQQ+lcOfZmHv5pir65KnFEnCo+8E749nahtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBaCd1M8cGniBmbrxUKvcUgFyV0fqOdb+LDNHqazl/w=;
 b=LlpqvNWCE79fRMIxuN1rdZwnxP48m6juKknF6PC10kirjF5Qy7pfg0fiku4jwLmUGOwDcrmhUbKk3XBi2JYVgelTcsoSdw5wEOn0yqmr5n6OP/pcSYnkj9KD/sjDOuxWXtjds0Twb9OsmY7yuIDk8l+KM/gLy6xCtxmmkZ34HoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5004.namprd13.prod.outlook.com (2603:10b6:510:7b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 14:40:18 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:17 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 07/13] nfp: avoid reclaiming resource mutex by mistake
Date: Wed, 16 Aug 2023 16:39:06 +0200
Message-Id: <20230816143912.34540-8-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143912.34540-1-louis.peens@corigine.com>
References: <20230816143912.34540-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 32febcce-b8c2-41dc-1c2e-08db9e66b5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h25xjBykcoEj3qhc1b+ySYz6+PRCDXXMUjfbBD46KjPfqiRebcyL8lCH6F4SvM9Pukhlo2Xzpn9f8q5c+KhRTABDYCNvZOwV2vpuQ2svWbCvkyInUOpnk58pyoVnTEYezTyDRA1F5uSYujguVJIsWwbGNM1Ya1kTR+QQ+5t90ZouhSM3qsqTsEmvZ5vvTQfj23OhNclcQh63o1Lj8AQWfvoekEWovrk7c/L64UMY3xBnTCr8fxV/BZJlGpAg6yhUNpZRkNir3kH+d+oM8yCPCbZQsF8QanIrYvtUCbmbHAc9/7btrtoXVaSRRTKa3P2dmZELIR14k7TzVCNzNcLZDqsnbWBgLwimzesVIIcMIBEJqcvOdKo4iwJKJxXsRkH3D7nl+qiuLmMkzu4V4p5g0UBAP9lyvTlgj+i+B8RBn1NTk+jk+ni8cTh8QhLh8yx+2CwIo5c9X2KOMetOI4EWkWHCy0hR22mjmywCIIiaKKG0b351LZESjSjrNpH4diC95+uLWMSaqsVLQvuSWIJ57IEhFAvL73WOawQr9E0tBDVux+8M/56YjJiuMOF2PSdKWiH8UQwZ0vaYgmQI2pNZO4HOL5xIzy/mDaNRha+sX60p4nUQeShnbscyyZgbw2Pf/fzcG+RwpAmAf/XwQaWVGNT5tx+UG+hAUidrMigcXhtm3IzU28K8pxlPDmKcVTRi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVFLc2RwYVhTUmU0aHR1SzJqNXRUUGRhbFNhUVl4bnRTNHYzcUlZd0VBMlRu?=
 =?utf-8?B?VzdHZy8rMXhiZ2xUQStMMlcrWjZDTHorUThIbkZxNERMOVNBeVBCZ2grMW8y?=
 =?utf-8?B?MWh4WW93eFk1Skx0V1A0dTRGNFJEUGpKb29rZmdnM2pDZGZGN04vUVM4QVBa?=
 =?utf-8?B?dVJhZ3dCTml4T3dFNC9WK20zMWdmNGQyeVV1RG1TRnVBYlRWQW1xMWZKL0t2?=
 =?utf-8?B?aWZEV24zUVh6Y0NUb1pmQVFjR3hJQ1B3Y1c4ZGNxTnNJOEJCeWdZREdnTG9n?=
 =?utf-8?B?RTJBVUtVd0N2UGZLN25kd1FGTXU4a0E0WTJFYTNmeVA3NzFYSzlFUFA0V2hs?=
 =?utf-8?B?cGxDZUFsWkVqVmNhejg4TFdVQXppckxnclFhWWFuem4rUGxBQWtkVEdJYmsz?=
 =?utf-8?B?UTYzVXRnekF4YzkvbjlzM3BlV0tNNUJUQ1BzbldDRHRwbm5UcWJISHRGTWNS?=
 =?utf-8?B?N1JJdmUxMGl3VUlwNjZoWmxxcFFoU0RnYnltOHowenZQMXFpNnJvakFJU21w?=
 =?utf-8?B?a1F3eFdkU09hOExZNEI4RUUyQzJCWFczQXUwejZ6TDFRcEhCT1BsYXIzYUJG?=
 =?utf-8?B?Qi9ZMW5HVW9GTU1HNnA2NzROemsrTmRMWGJjRjhaVS9ISHdsZWhDUHFXSklI?=
 =?utf-8?B?SjBUQXlmdUpQMGxJTEVoNDVZTE9rRGc0LzBYWnNLU2VuQW1Zek92WSs3a2xJ?=
 =?utf-8?B?ejJuQThiUGUyS1BZNXZQM0dMOWF5bmphZHM5RHV6OWZQeDRmY216YU85SHhR?=
 =?utf-8?B?MzZ1Q1BOa0R5NE5UR3QrNVNEU0dRbTN6YUw4cHI1ZDZLeVBVNmlWMlF6czZ3?=
 =?utf-8?B?cHFSMlNMQlBLZXJJOGpvU21TWEJLRTlIN3IxZmJ2a3ZJQ1NsZ3h3SkZFMUx5?=
 =?utf-8?B?Qy9nbzhZNk9jdnlaQk5ObzhLemhVa3g4U0ZrZk5xUnlPVVZvSTNRTi9mbXZz?=
 =?utf-8?B?bG9HZU92eUhIdmxJZW5sWFdkZ3Q4MHAwTmhvcHNWYnhmVUlTbVc2bkVWL0Fs?=
 =?utf-8?B?WUVObXI4S0h5ZndhR0x3WVJ1b1lzVTlhamNjQlEvQVAvZjZlV2daN0tRMHlM?=
 =?utf-8?B?czJIci9mY0xYeUFZTGxFWmpVcCtsSUtWRjBwamhHWVl3aThacnFGOVdNK2Rj?=
 =?utf-8?B?allORDg1d1RZNDJHM3M4VFBEb2gvOFF4YWN2Vkx2ZEdzZDVoNHVzOFV2dXZN?=
 =?utf-8?B?SHB3cDVDRTljcFh5dnVRU2ErM0dDR014U2psK1JpbDlSZVVZek9QN0FrNGJs?=
 =?utf-8?B?Z0ZweDl0Zk9GOFZkVHRiV0NRQ0tMSU1MVEJpNlVxWDVhR2FIN0RTYmEvNTVx?=
 =?utf-8?B?UFR2bVhVdk9HTyt4NzF0SWVSVkF1aFBsM1A0SkloNTEwajFXQTkwcVZJMSt5?=
 =?utf-8?B?MjF6MDRBLzNwT2IyOHNUWERUUnJGRU44RG5sQUFkZlpvZzdQbHNZOHgwTTds?=
 =?utf-8?B?YVZVK250RHRIaTBJQWxPakF3c3pBMjJ2SGl3bzREbVk1SEZpZC9lV2ZRblVh?=
 =?utf-8?B?cXkrbG9QT2MxemM0UjNJeUJtWStRS2trQzhtZEhSR0M1SGZ0enhqdHhwbTN6?=
 =?utf-8?B?bVJreXkra0gvcVpxMGpra1dFaDNRT0VSMXIwWjVKM0J4NG9BQklNOXlmWlVS?=
 =?utf-8?B?VTEwTVVSV2NHUnBTWE9DMTk5K0ptV0d4bHFabEQ2MDZPYzZmT1EzK3dqS0pD?=
 =?utf-8?B?eUR2OHBPNlpTdmdEV0d2TGlVd0hsUkZCWVJDdzRLVDRDVHZNamJSWFpkOXVk?=
 =?utf-8?B?NExqcXFmNGtQNmFJYitzQTdkQWljQlhTS1gvbjAwZHBGZjVGeVNFeW00cE8z?=
 =?utf-8?B?VWJUQTN1djBUdzdOZ3JaREFXQnc0VkMrTXBHdi9wdFhld1Z3UzZvYWFUa2I4?=
 =?utf-8?B?YUU1UWhoc3lYZU56eHVjbjIxVC9jSmpYaWJNeVRPYk9aZ3dxR3J1OGkrbmk3?=
 =?utf-8?B?YmxCTjNFcnFCTmFRMHBKWVhhbnBjY1Z1dXFmZG5YajIrdjdmMGRVbTdzQUdT?=
 =?utf-8?B?VDdMQjR0YUdQUzRqMG5BOE90aFpvbk1qd3NCdFZBWjE2L25vdUdkQzRJbm9w?=
 =?utf-8?B?cUpWTGNpeC9IQTc4N3E3MXp0RnBLWE5ORmNyVm1qZEdOUElmWllnbDkrRGRB?=
 =?utf-8?B?THNZOGFiWjlZSndWOVp2OTlKbGZ0dHFjRjlwYjNjOUl1Q1ovbWk3cHVIc0ZJ?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32febcce-b8c2-41dc-1c2e-08db9e66b5c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:17.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZCHCx8nIku0MtL20zVqt7zB28ZK+O8WRBg7mw/0+tlYElCLL5eHrKvOneXeRQR7GvRVvadMNQSn1qX0ZC7Mq93K2btHCXqMxMbLHEOGPY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

Multiple PFs of the same controller use the same interface
id. So we shouldn't unconditionally reclaim resource mutex
when probing, because the mutex may be held by another PF
from the same controller.

Now give it some time to release the mutex, and reclaim it
if timeout.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../netronome/nfp/nfpcore/nfp_mutex.c         | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c
index 7bc17b94ac60..1b9170d9da77 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c
@@ -343,6 +343,7 @@ int nfp_cpp_mutex_reclaim(struct nfp_cpp *cpp, int target,
 {
 	const u32 mur = NFP_CPP_ID(target, 3, 0);	/* atomic_read */
 	const u32 muw = NFP_CPP_ID(target, 4, 0);	/* atomic_write */
+	unsigned long timeout = jiffies + 2 * HZ;
 	u16 interface = nfp_cpp_interface(cpp);
 	int err;
 	u32 tmp;
@@ -351,13 +352,21 @@ int nfp_cpp_mutex_reclaim(struct nfp_cpp *cpp, int target,
 	if (err)
 		return err;
 
-	/* Check lock */
-	err = nfp_cpp_readl(cpp, mur, address, &tmp);
-	if (err < 0)
-		return err;
+	/* Check lock. Note that PFs from the same controller use same interface ID.
+	 * So considering that the lock may be held by other PFs from the same
+	 * controller, we give it some time to release the lock, and only reclaim it
+	 * if timeout.
+	 */
+	while (time_is_after_jiffies(timeout)) {
+		err = nfp_cpp_readl(cpp, mur, address, &tmp);
+		if (err < 0)
+			return err;
 
-	if (nfp_mutex_is_unlocked(tmp) || nfp_mutex_owner(tmp) != interface)
-		return 0;
+		if (nfp_mutex_is_unlocked(tmp) || nfp_mutex_owner(tmp) != interface)
+			return 0;
+
+		msleep_interruptible(10);
+	}
 
 	/* Bust the lock */
 	err = nfp_cpp_writel(cpp, muw, address, nfp_mutex_unlocked(interface));
-- 
2.34.1


