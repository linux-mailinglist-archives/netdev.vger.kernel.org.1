Return-Path: <netdev+bounces-29945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2BC7854D6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9591C20C6E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D999AD52;
	Wed, 23 Aug 2023 10:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CEBA2E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:04:28 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2121.outbound.protection.outlook.com [40.107.7.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9ADF
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gthxmorNZPP83x+9wkR04eaNHEL1HcDSCtJGxzbhIfmCtEtG4xjKCbhFYoiIyMxDr/Oz2P4fDKVLnmlRsqZiBD84gC2FVmjz7YDw4oCKtO0WblX2ELpa8d9LPbvcuqBmjnCnUWRU60hOm9RU6h7TvZar4OgbETHl0G9srXqtqfm2kBnjd9kOMRLJ1F6K8agV56RTmN96IoTs53D7cTyXLH7WQTECPCUhzW8ex6vMFbTmixPzRWu+fSVfnLSOBDNPR4SnqH+spoaTN+hpBuxMiuQnR35SpOZIugP4q0/U+zij53epCgrrEq3vZsOnnlQfKV9++5kORilRu8zBqBMvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRkSuePn8+QLhy5YKx7h4qlDOuzYQfzFtHTDwMtT1Ak=;
 b=oFbb4xRMJ9uQ6NU68E/na9aEtp9M2QR3T/GFKxnTHPNbmAXvcaOBhEqkPNWc59fL680ss4qZ07s7pD1Kl8H9Hbf0c106ytbrq3X36eSCD96Dv8PkdAkZQxXk2pqF36ZGSOIONUmGEMnnndy3frYfGv3ygZm9NkyEpCWbSrfyU6i2QIn2O7z84w2llREtAsQbmkn4yiQYh36SFPGH0/hviKiyNmSjkaa8xiNJkc0sKAsky9uRVOqKFQJBTjfQ7mCN2DJG6dIG16qPuJj9T4Y7tFBRiGJPK3qO2LCbWHClTCs89p6ulSlKgN3EQYXKAJDJ77GPn634QXYrwIbXoMvr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRkSuePn8+QLhy5YKx7h4qlDOuzYQfzFtHTDwMtT1Ak=;
 b=kup7ckb0ebbDpe5lS61PZQjQhEqgT2OaJnOsSr9de0fIbrhj34zKWsCAnTV3aa6RekHbWclAd0rmRAEonpRljfOj74wrgbZi0So3NoPQHY++tKKIzezk9dexltpYIiNS7GveO180OmGXUykTc6zvxTs4vllZ8BiRclwtogDb92mmNzMCmLoNpKZkiB2dJL2QJo/iKT+5SCar+pBHVCE0F43B+C37dnL31ctwSsEk9F82szOo/u5e31jjUzaa7iYrNA1alDXDVaB52JoLnUpfIwEz6itDg2JZTpXT7kIeWMsssL2Bj/+zU887WXgUNBkUMBY+x5xc4igO5dgx8J2kcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAWPR03MB9668.eurprd03.prod.outlook.com (2603:10a6:102:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 10:04:20 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 10:04:20 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	Francois Michel <francois.michel@uclouvain.be>
Subject: [PATCH v2 iproute2-next 2/2] man: tc-netem: add section for specifying the netem seed
Date: Wed, 23 Aug 2023 12:01:10 +0200
Message-ID: <20230823100128.54451-3-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823100128.54451-1-francois.michel@uclouvain.be>
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PAWPR03MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd3a23a-9eee-492d-70a1-08dba3c051a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K1dt2TeFg76BExNBXBYZ0uLlx0CirFhxZzYAUhrpgarwmtBBxfyH00DbqFrGmsUS1n9R0CMNW9i3x5lnAEUeHN6iHRlHNNKV4O3aLZrMxSZinD8KkpFloeZXCZq3gYZIxCuW66ovMpUlJY7gK/Jli25U/4Fm1GTDQjbTP5VNpv3utO7KyxEyTmgja4KB01SFB1yGqPwMlt+Zlgsddz2zg0RJS2cwqewtMGrTqwdFlLcZ8dUCtDfgllMdMSBCrRH2snwI0AKM4vnabmt+ZmVjUG9Et9H7EmwSCJxuup7MORtom25lm4mj5RR7R8OO0khYheiXpuZAOvR3Uv80CgyRL5LwbrSWxSW2OWr0qnaungkWbourARf2urG25m/Ham4KD81qJgpOncQrfQoHaRDiGUwEI/AO6OijLaWQHXyWQwuN341H74Vh0KZRCwmy12WRJlLZF+2C6Xy6XPWo9rL1VpDfTTrpZgy7fEm8j8+yEw0Ivhp3N6SvMw4BNOfxHPHFiUWpdaJyoNHNvjIXmI0/K2TvSfg/TcAO85yiPDEhf8VK/XqF4RKRRE6lJfeSCYbwbhDA3xHLfHHmhlSbmBgxary2rjAMMBXKMIsLz9ioD9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(109986022)(786003)(66476007)(66556008)(66946007)(6512007)(9686003)(316002)(8676002)(8936002)(107886003)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(52116002)(6506007)(6486002)(83380400001)(66574015)(2906002)(86362001)(5660300002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0sxK3JTU2dtMWxsN1F1aDNBbmtFblh1NXM5S25jaWdvSnVJY0tzejNmeHVE?=
 =?utf-8?B?by9nZ1o4cUlwa3NzUUZ2WmU5OUlwam1VbnJUVk5YdWV0a2VTbXp0ZzdDa0hv?=
 =?utf-8?B?VEJmUDhrekdLTmJjbDA4RUVBbEFiY05mbjRDazZGQWpUUU9aNFRzcUUwMDJj?=
 =?utf-8?B?Z3RaeVRLS3NyeFdpL2p3SC9pSWhBamc2TGNjK1FCdlNEQWNJaHJxZ1p0cno2?=
 =?utf-8?B?dU9OcHpzRTRKOUF4cloyNnNoaUVIaWFMdk45b09lWkxhdnJWK0pod3JGbE5L?=
 =?utf-8?B?ZlJKOHNlRUUvWXkzTjlhZXAyazZzRmtXU1kyOEJ4ZklNRDVwa3ZhejBoTTla?=
 =?utf-8?B?d3JEMnUxK1dlalk1WjErQ0ZiYWtobUlBdmIwSXNNY1hvZ3BNR1Y0L0xpVUV3?=
 =?utf-8?B?YWM2NVBPS1FkNFlJSm8yRVU3M0hDK1ZUTzBJTk5PcW9oTWR2Ukw5aGRpU2Vq?=
 =?utf-8?B?UStieGJRQUFaV2JFQXV0bS82SWVTeENZRXZkcUpIZ3hvb0w3dkplQS9SZEdw?=
 =?utf-8?B?bTIvSlNTTmlsMmU3bW51OXlMZGxRSnIwVkVVdTB2b09rUzNabll3WXF2RkZP?=
 =?utf-8?B?c0QrT2N6M3dpWGlQV1lEa29YRDNwME1HQ2p3V1ZCM1g0UC9vbU9aTElhNEtz?=
 =?utf-8?B?eUlaUk82cWJNR3FGQjVCeVZLTUorcWRNYkVZczdYZ2dWY1M5RUZXNDZUQWtT?=
 =?utf-8?B?b01SRHBnTkFNYW9XR2dZZGpIdjFLRTRyK3FaUlVOdU1nem5xUkgrc1BjVU55?=
 =?utf-8?B?eXBwYVJmM2F3enlManZJUDh0QnVWZ25iNWp5a01wdU9OQ0hDNU1SZUttTGp5?=
 =?utf-8?B?OVpyeFFPelMwMU9EdlVRRmlUdWN4U1pmMUFzWGlGVnQwTm5qbUViWHNlbXFv?=
 =?utf-8?B?K2pLUEFaUHdkT29lOHBpOG9OV0tZNDJFb3dYanNIZW5LYXB6YmdIYkVKZ3d3?=
 =?utf-8?B?bFRlZ2NxaHZZbktaV3oxVTBKZmhXaUlaeUY2R0pDclNmb0ZGWG1BZmwvdEdD?=
 =?utf-8?B?TXZ3V0k4aW1tTnVZWlE3Y3F6U24zdzJMVDlId3UvWlpEQkp4Y1NxODNlc1du?=
 =?utf-8?B?UG16QnVLZ3RFTkVwWHJjMnVPSXpPQ3NvNVJ0a1dsTldqYVpCbnY4c0NaeXk3?=
 =?utf-8?B?Y0lCb2ZrY0VUd3lFOVl5U1BHU2VoaXBDV2ZtM2xrcld5QUdGclNYaXlSejJ3?=
 =?utf-8?B?Zmo4bStXbHBqTWlieHJualozYWRYbVNkdGJRMndHTGJ5d2tOekdIYU1wTnJN?=
 =?utf-8?B?NVF6MUtid3dyTGY1TzJMRGtCUDZZYit4Q1hpeU5HMFRWbEM0aG4xWTcxWFdm?=
 =?utf-8?B?NDhPYTJUcjlOVFgzUUovZ0lFVmplcGpSWnRVWGgvbUlkVXVUakhxRTRKZ0t5?=
 =?utf-8?B?OFhHUGRIZEhpakVYdjRQNVlDZ29JSW9SamxUQ1lxRkxJZUNPcnRtU0JlL2ZR?=
 =?utf-8?B?S2VZNUZ0TGJLQjNSbVBib1hvUjZIZWgzU3Y1LzVQVGhvcGg3SStQcS9mNUp6?=
 =?utf-8?B?RHR4VlJMK1Azdis2aWF2REN5eU5IcHdiOE1JTHgxb2s2MlRpMFh4akVXUXpJ?=
 =?utf-8?B?YklXdHowMGw3Y2w5cGZ0MXIzdGZBS045RjF3V0V2M0cwRTRoSW9WRExWeVlC?=
 =?utf-8?B?cUcvR21qYjdoU3BCazNVT2xQUkhtRHdKT2pRS0V1eFdJOWE4ZWllamFGd09u?=
 =?utf-8?B?Z1JmMGNkajVwZzBGNkVOVjdHN2NoaThCd0NDMGYrTndKWjV0Z0ZCcTAreUdk?=
 =?utf-8?B?b1pUWTIrN3RYMm5qM3pKUStOU2x3Z0N2dWJWOXFtc3BuT2FNaU5kNFR1Nllp?=
 =?utf-8?B?Slc1RmtIVHQ5ZkR4L1BzSmM0bGxxcWlzYkNEaUNDeVliRzdxN1gzV3VRQThY?=
 =?utf-8?B?VjdqRGtrN3VWZ2dJYXlwNVdSUjB5WHgyR2NEbWxQcUpEL0FCNEJOa2V1QVpj?=
 =?utf-8?B?RlhIdHJYK0RwM1ZBU2t4NmJtRDVoRGR6T2pwSFpYN2NFYWtPT3A4d3dnVzVP?=
 =?utf-8?B?OFN1TjZhVFNoekJiM3p2ckJVcFpqVVQwcFdIS1QwbnlvZUtURnd3dnZrejdX?=
 =?utf-8?B?NDdvaXpyOHRuUVhFK1RHaUF0ZUpvdFpMdmtvUjlKYUdBWk5aKzEzQVNFWHVS?=
 =?utf-8?B?dWRGS1JucGl2dVpCdG91blBWZzduVVhiOVhzMnVUaHltc21hVXVsU1k4TFNt?=
 =?utf-8?Q?2e9FZoDzfFDY5q0isL4Inq6VblcfZHeh4SoFVA10EokX?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd3a23a-9eee-492d-70a1-08dba3c051a8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:04:20.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpwX8NhsIOWm4ecu72V30137YozBKADra7RMSP3S03AFw5cNT+e3LRS8MoaO8VWlmLyCN/QCYeE5UTYcnAxxG/FJy5E3APwwOZXGWXL7ln4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 man/man8/tc-netem.8 | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/man/man8/tc-netem.8 b/man/man8/tc-netem.8
index bc7947da..a4cc0d61 100644
--- a/man/man8/tc-netem.8
+++ b/man/man8/tc-netem.8
@@ -9,7 +9,7 @@ netem \- Network Emulator
 
 .IR OPTIONS " := [ " LIMIT " ] [ " DELAY " ] [ " LOSS \
 " ] [ " CORRUPT " ] [ " DUPLICATION " ] [ " REORDERING " ] [ " RATE \
-" ] [ " SLOT " ]"
+" ] [ " SLOT " ] [ " SEED " ]"
 
 .IR LIMIT " := "
 .B limit
@@ -64,6 +64,10 @@ netem \- Network Emulator
 .BR bytes
 .IR BYTES " ]"
 
+.IR SEED " := "
+.B seed
+.I VALUE
+
 .SH DESCRIPTION
 The
 .B netem
@@ -240,6 +244,11 @@ It is possible to combine slotting with a rate, in which case complex behaviors
 where either the rate, or the slot limits on bytes or packets per slot, govern
 the actual delivered rate.
 
+.TP
+.BI seed " VALUE"
+Specifies a seed to guide and reproduce the randomly generated
+loss or corruption events.
+
 .SH LIMITATIONS
 Netem is limited by the timer granularity in the kernel.
 Rate and delay maybe impacted by clock interrupts.
-- 
2.41.0


