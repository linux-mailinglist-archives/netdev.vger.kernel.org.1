Return-Path: <netdev+bounces-29639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB778431B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E3F2810D3
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F61CA0B;
	Tue, 22 Aug 2023 14:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B87F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:05:50 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2092.outbound.protection.outlook.com [40.107.247.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2471704
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzDw/4F3QPrg7dIQWmV4m+QqkYxKlIpQ3XNK1YPDbqND6AMvopPEx/NWLTatYejC+fOD9kSCg27TSVgvqWoGBcXhOpwjxmyj3I9PmSplSDChrAgb9kaUg8nIFNgEMqjmqWMJWUsV58Ne+M8ozN7Wfpb34iXGE9FeXEihELXg/BvNqmFbqHrPtMl4gtxN8Y1DiqK1UMl4/Cre3xP5irIp5ObF7vfdxXi7MCijcUzwyfYF0fln1kgzy5jN2MOcRoeO096RRVA+ptHndn16+1QPkwgz4KjRv4uAW8RMikmCeMo446GTB2kWD9o3J4NOMw78KWxiWU2+jEb8+x1T40tyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLIimEySrvMhO693mBUxPskO3vzvyiRk42Kf1qicuWw=;
 b=HUqqXz37wCFnPnuivFA6cRG01FcJpytQkpufRuXh3gkX2ocLKcQHo50Kq0QOu1Fmz1b1FMdvakWRDu0tf69xyjqTnezWqYFhBSyVtaA6965LYFJdelPGPag8rgFn5/dqhHgIlgkjzsqcZqtmSZLXo4AtecYBV+3ruM1ZbxPNSPTMySNFCbdNldmWur6TiFthDJh49Dmo9SESwtk7t2PBDcEEJJgZ3OPQd61bmqvZUrnfKLL8m4haRdCysFQ0XwdaNYqt1cxe/iLDKEnYM23dRWblyJusahDgsVG5WuYnQICtesopoyQdDJYYOAsGmBBwRWS7IAIUJto/EwIMkyVVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLIimEySrvMhO693mBUxPskO3vzvyiRk42Kf1qicuWw=;
 b=kIf8sMS6WVRQzZdFnC+6+CjMqGNf6el+cAwLhBEhPwaBdF2kcxe8wEwfi3Truf70TI7luxJxpcLA84tTrjfBx0DIqFGMzzhghRm4UsVWGKDw8vEd1lKSnFjR0bPh3R91/HELriNs4/gF+Bvcccy6VkDxsRzd0oIO2ntH8wTLirFQDncud4eno6YgH9ZTSoR9iVIgtRjKoOnMdx9AWnRgnvD60yiMsQPnpACYYVm/lc7oWqnEbRsFERJGGi1Wd3p3ShualhfgcblGiVVaLmp0NuO54PwL+xMlDeKhNhjmaUCGh/VTfkyQSbMu+GLgHQg2mzYG8iGmK2l9lYjShlG13w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by DU0PR03MB8161.eurprd03.prod.outlook.com (2603:10a6:10:350::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 14:04:46 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:04:46 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	Francois Michel <francois.michel@uclouvain.be>
Subject: [PATCH iproute2-next 0/2] tc: support the netem seed parameter for loss and corruption events
Date: Tue, 22 Aug 2023 16:04:01 +0200
Message-ID: <20230822140417.44504-1-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0429.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::9) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|DU0PR03MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ba4697-6045-4098-71e9-08dba318bda9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vh7ADniWEB8R2YWVmAtdSV0VkkQqE3Buqgex7EAatzkoI302RLDuuc2ITLyAAmCBQIVIRHHyI2mRfmlJ8VlUuPsJe5Z6alYIrI4OH77l7S/TtVihOdva27cC2FHHwRkF36AE+KRttay/Q7vvxsjzaQNarXaM7rwzG0pEcM4Tx26RaZjX+7eR0F7TqVV20vwo8EAPZawGpQH7mojGdJZmCs87S5vrVE4kkp7a9++3P8YuC3xsVHzmZy7CXPcccpUwr965IxSF5BwPr8d3CKy7X31IHtdvGQjbR+LR7k0BMAN+m/SZnHFu5g9ZbqZ4jQX3Gs/l5iMvftTESMyzsk5Inh7WS/GThliyxlb4xSSIBMrRNoYvZldX5QUcLu+Cb+ZTv8qg2lCudRpT6wBVXbyAzkiVVB3z5+NICON3N4Bpi0sG/8RCS4ysiq3diQNQXu+HZVNqzlvtn7MPcyMFgq2TkBHyS1rdbWTkQPngCXkSS5q4XKBdrVAOIFUlJjgqbYjKOU4qi9bbr1FFN6Iu6xcRBj2E69/0C7esnQh4ZwhFUEDbNS2zR5gZ7ZWWWV03HbUDYnSzp/pSw5zrDX1uzwGWkLu7DP13kxyhxB5dr3b3iVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(109986022)(66476007)(786003)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(52116002)(6486002)(6506007)(83380400001)(66574015)(4744005)(2906002)(86362001)(5660300002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRUVFBobHdmendLQ2FTNXRxbC9tMXNUaVhZb1NESnF2Q1FVTEtGTjc2dG9I?=
 =?utf-8?B?cWd5T0FJUVpEVHY0c1N3UkRpKzVuUVJwU3RGU3VyZERaVkh5bU9oamZPSjVs?=
 =?utf-8?B?ck5YRmo1Z2EzeVlhUUJrbkJKRHZ2K21lM29ESm1lZHIwdllvY3QxclMyQ0pZ?=
 =?utf-8?B?SFp1bEhSTzFtbjhGZ2h1eFZQTDFrN1RldFNxRVF4REZFYmY1Y2ozcVcxM0Mx?=
 =?utf-8?B?NmRoVmdocVJNT1B2eEczSkFKTXdZKy8zT3l0Rmd3MStFaUxLa081RGpwaThs?=
 =?utf-8?B?UmRETVpXeThHeENPaTkxaHhKV0pQMFFCRWdNU1ljYSs5dk5NS29GUjVYTzg1?=
 =?utf-8?B?cnV1Y1NnMFlMM1k3c2FlWlpjWFNYMTI5TWpvV0kvUENjOXZCMDNxWkN3YVdr?=
 =?utf-8?B?Yi9iOWxJOUdYdTNDSy9FQnZaU2xYTmcrY3dxYm9LR2RpazRzN1JxWDJHVXVY?=
 =?utf-8?B?VDhTdUErWTN2NUpsd0tFSGcvOU9SOTd5dzhMUHNCQmEyTWxJL081bUwxc2Z0?=
 =?utf-8?B?RW00aDgwNmdqYUkwWDgzRjVhWEdkQ2tYcjZBS0tqelRucTZBY1Uxa2JtckxZ?=
 =?utf-8?B?bWlNZ3owWnBmTit5TktFTkl3aUFac0RFbVRhYWowd1owQnNxL0QyZnZuQ3pY?=
 =?utf-8?B?dkJCMXlzUlI0VWM2WmR6cUxqLy9PeDIzaUs2VkNkZmVSa0lIdUh2VEdoWkk1?=
 =?utf-8?B?clhQTHVFZE5hRDdIVmsrYkMveXRldC9ka05pMVR0djRuanVNWlJRdTg2c3A0?=
 =?utf-8?B?cWdGTFJYQktweExPZWN3U2sydkVZNDBpZkhZdTJsV3cvWjVTSTl4WExmdW81?=
 =?utf-8?B?VnZhRDdaY2xhbTRKcEVJaCtpOVJ5enl5dlhlYUxaNXNaa2g4Q1BuR21OaVhE?=
 =?utf-8?B?RHlTd3lFQis3aUJaRWRLMHVNeG1KZTJiVzRuZjN2b2MvdnI2SmF1dG45UFBu?=
 =?utf-8?B?cnBza1NFL2dOQUxCQm5NMkRpdFdHVzFlNUJIYUVRMXhOVi9RTmE3dHcvdmQv?=
 =?utf-8?B?YVlncVNLa1JSaFBUQ2l6aVF2ZzNsR0Z5VjlsTWNEaVRvRXBidDFxUnZ2TWht?=
 =?utf-8?B?ZHFRQW8zVHRIdUxUdWF2Rm5ETDFHbHlrZEIyT09rTGJYbGlUMldHOWpxMzJZ?=
 =?utf-8?B?TG5XNG50MVJZL0JMRWMwRFBqaXBkWUJubVZuQUZrTDcyaitVYXVjaVorazU1?=
 =?utf-8?B?UUJQTjhSVnFJSFNwdmRjQkRaTDFGUXU3NW51SHlvQVBuTlJPTGI0Y1U5aERz?=
 =?utf-8?B?YktkVklENDNTZDdxWUlFbDFTMTl5Rkc0bk1jYzc0L2lJTjl0YlJhQzBqRnVh?=
 =?utf-8?B?YXBjT0dQcmNNSnlSSE0ycThUMXY4bVMvdll5SmlnRExJd0M3VzFrQzBIRXZD?=
 =?utf-8?B?QUo2dmlRWmMwZTdxNHVQdXIvWko4ekVxRmlpdU45bFVoclQrRzJ3QVMydW9o?=
 =?utf-8?B?OGRkMGFJQ2VaSXlVM1dRQ2tzSDk2d09ReUt4S0xKOGxDck51dGZ2RFVTZEpv?=
 =?utf-8?B?NFBkeUxnalNVTFZyVmp2Y3ZqY1ZpSHdPeWVtRE9sUjd6cllCMEQ5RnFURWNl?=
 =?utf-8?B?NTN3a1ltbi8ya20zdVNsd2E4ZE42RlhIK2FZNE5DL2YzRmhpb2Z1Wk51N3Qw?=
 =?utf-8?B?d2RtRGdCamdsSkVqUmo5Z1NSYSs4ZGtYK1lzS1BCZmxUeUpmek42dDd5RGtC?=
 =?utf-8?B?TTY0UGtRcG4yWi9LRVZ0dE9YTEM2b3V1T0JTR2RvdHJXTjZrcFpQanI0SjhK?=
 =?utf-8?B?OGdYMEN2MFh2aXpsVmxCUGw0Z0dhaW9DRWNDeUdWYzlSRXpFbXU0VlJmbmlN?=
 =?utf-8?B?ZFJNYlVGMDhrY0dIQXJhOHBjL0hzZXcwMlErZHExTWR2WkVqdDBmWXVZeWtr?=
 =?utf-8?B?TGUydG93OXJ0QjFOVXdWVEZ0bFo2d3VZOGhhU3V0R1RkTnRnZzZqR0d0OUtO?=
 =?utf-8?B?L2RwMFduMHpXTkRhUlo4NTlWSGRtWEdRdUdYUXNrTlVKWmhIYmhDL3VmT2tW?=
 =?utf-8?B?VU8vWEQ4ZVBsQlh4UjJVWStDc1V6bXdQMVVUYXBuTjdOSC9zRHNvSXYxU2VS?=
 =?utf-8?B?UUJYc2lPVmhJMjlSdnBITjRJNVJEaFRndnFyTXlRUFAzSzZoaGx1VjFzYzl4?=
 =?utf-8?B?cDJoR2dtQTJVcktueFpwcWd4Um1nZVVPWHVZZnRlOTZsQ05pcnBTVEZDZGx5?=
 =?utf-8?B?cWZNR04vUEkxVTA0WVAySWpIV0kwS0E4bWJpM1RYejMxMHFOWjBMOU9ObkNU?=
 =?utf-8?B?eHpyWGpIRUhOZ0QxV05PQXN1YUZnPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ba4697-6045-4098-71e9-08dba318bda9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:04:46.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMDlkmmXLqDWn7/zuKA2VZpyIXH2UONACjJoQK2KFtwlJVuoyFC1LN5DeZoMo/1HO+RiZHnk5v91+srjGDEEo6KvEG5HuIy/ZQxa0OyWyaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Linux now features a seed parameter to guide and reproduce
the loss and corruption events. This patch integrates these
results in the tc CLI.

For instance, setting the seed 42424242 on the loopback
with a loss rate of 10% will systematically drop the 5th,
12th and 24th packet when sending 25 packets.

François Michel (2):
  tc: support the netem seed parameter for loss and corruption events
  man: tc-netem: add section for specifying the netem seed

 include/uapi/linux/pkt_sched.h |  1 +
 man/man8/tc-netem.8            | 11 ++++++++++-
 tc/q_netem.c                   | 26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)


base-commit: ce67bbcccb237f837c0ec2b5d4c85a4fd11ef1b5
-- 
2.41.0


