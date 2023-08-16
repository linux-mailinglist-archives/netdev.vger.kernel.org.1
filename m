Return-Path: <netdev+bounces-28101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DFA77E3DD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E041C210BA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F441125BA;
	Wed, 16 Aug 2023 14:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B8125B3
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A412717
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMyUAHmRdkOq6QLDp+zUzbNdTnszEPl4F6XzchmsIlUDtRNK69BK97+XgVu+Ow7yfx4Sk4M7yiFLOMkY1S+fWEEMimttPgNaYxEVd+cS2CQcgoXQk4wC5TrV9rnbEfL28KPU6WiHOTg66fQ4YxYV2lYut4Grz47iYjLgQsA6fr1eozAfTe14q5JZN/kh9E7jxOFV+1qmMHZjDufdXiRIHPyHJUdFZWWBfa1PF05/JuoYDQ8pOc5ntX3S6Ntybxf1vCLmusrC2Ew7fxo5ih3hDISimaVWwXYptHq/Y/KPe6DzVzIf41Cd8zIy/aWWlmJD1huWGJ7GoUUtVVgSN6rulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8MxMY83xTcM28F2igMdsKW3tVxvw1ogvn7+Caroqqg=;
 b=ffjTT9qz3/sjJsa1LeU88N3UAdQemr2WGc9IGaTwCWBs7u4xP8D2tcrMv9OCg7Lv8pMxTj9X9V2gM++FRvXVhQxW78z3EsbnRj4mTngp/JDe8Nam795nQLN8e+g35yTbtVgGshPtMXzuHGoHLphkFphq5PGILVS+SZ+DrZTPB1tuAoWKixDKdxeNcQNNPjjCX0YjH14qzfkXr9tCy7R4JuFD81uLGfgvTE0fQZsGVTB2C+304i2PKZtE1onmdAJ5h8giNeUDqUK8B24ovyCJca+O+JhxLmhwfZV25kuS3zYCtqwSyS2d+qRmgWk73xDF26aeoV61o2XTmmib/Gn7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8MxMY83xTcM28F2igMdsKW3tVxvw1ogvn7+Caroqqg=;
 b=r/chQkpy7m+4hR16w+yc45ijcofe3jYyYQ2jppxN0t6EINj4GMle7/Fjl3OLObL2t08y6XGhiR0wbMxWOJB/lA41dEBmnvg9Cwgoyt6AjuTNH3x5zjU41ZuW2UU0pGe0P5IRu+6dcDKLZXCFAvVVS2eFK0TWj6YV92LKDbx/yUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB4097.namprd13.prod.outlook.com (2603:10b6:5:2a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 14:39:56 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:39:56 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 01/13] nsp: generate nsp command with variable nsp major version
Date: Wed, 16 Aug 2023 16:39:00 +0200
Message-Id: <20230816143912.34540-2-louis.peens@corigine.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|DM6PR13MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: f435d6ef-d6c8-4797-c227-08db9e66a8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fAIXZyQBl5LUHQNaVDUH060JlS6VKN1zoJl8xKpVRt/eloDtCGdh3NWUWtBF7XfPftYTj2LMvt6Fq5gl+AmBLHjivfzlKDHGmHx82Ai7HEt1QWSwEroTZmO8jV4nHR1w4UjsIpqgUg2heAqsp+hC/iSWKo7CXqK8i5ErPaBqZKQZRfnUzO2kBpGHZQPTCw77uduzuPerC1sOc6FryqhkN/kcwLABFPW3nS1qO09kQwc4d2SF3+vh6VzEsKoKYd9OSPZvyBTieXAa99upU42F6zJQDfv5ys9Agaug3bDusLQpm1weq89t1eYbQSjJYa/0QNF+IOeUI67hlYYOl5XHwD82IjVPXUSdCliEQDEJ4NUAn170XSms9AWPgPJOtNxVuo7Q4XALpxLtD2Om9zzL96bJB27hGKtRM8a8x24TZBTquBUKNZ2Q+jt37ol/8QIC4uVoE5j/Qz4NAlJHnkjzM5an9T8Vj486uXX/fVXOldaWnNNgTOsKxsKriHc/JS1SFbeC9NhB7nTne5KErDRqimqhFIvnlCCEwVmNKZ1zpj5cDr067p4WdRd6MoWPPkJ87F6uBfvFPuwgdUkZZP+MjCnLDcwlxFotYr8jXkq8WAY24BYD6/Zkoq6cd7bKd7SEeygbw07Cea/DvtG0LvPjqcY22f5T8AqPF/VZAxmDy6NKoazR+jSXTVCPX4Jk7GFkpWEzgGSZTJl6Ic1M0/pokA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(136003)(396003)(346002)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXg0NTEvUUVTMnVtQllXNmVWZEo0TkpPb2VJYnAvdWRXeHFpLzJ5bGpraCtW?=
 =?utf-8?B?MVZHamVPOFA0WjZXT0hVOXVMZFA5UW1FRHJ4VjJRUW55VkVYa0FHRVFiRCsr?=
 =?utf-8?B?cGdkSnVHRG1aUFpVY2Zrb3YrZ0g4TUlnSk5BWkpsa1FPYmNXMlBrNjllNlY1?=
 =?utf-8?B?WGo5Sy9TdFJFSDdJdEVDR0tTZ0hYUmpBNUdwdWpLZ05MaEZsV2xqa0w5TStV?=
 =?utf-8?B?YmU1NldUNkpNVHIwV3Q1WExYUnhzZ0NmK0c2TzE5RkJPNU5FN0xiN0plcUw3?=
 =?utf-8?B?UE9GYnM1K0ZYeGN6Q1BBR2p0dXVlMHJENWJMb3lOaElMR25VNzNSa3MxbW1h?=
 =?utf-8?B?MUUyMVp4c1N4OHdyeWlpdGkxVmhrcTZNaXdCclNFTytYOGl4ODdMYTVIbFlu?=
 =?utf-8?B?U3I0Sy9ycEs3UmFEYVM2TkFqNUhNZEptSS9taWV5cVh3TEhVa3NFZUxCYnc5?=
 =?utf-8?B?bGdCV0lRUHdNR3k1UmRsMVl0WU9WdkNGTXRETG1pWE9RTmdUbzVJaWg3Vmtw?=
 =?utf-8?B?TUZyZTY3c1ZGMHRsNk56MHBXYjlycUk1eWFidjdMbU4ydGo4SGoyTjZVdW13?=
 =?utf-8?B?M2xxandkSEc5eHU2Y1lnMERLSTJOdm5TdEhvVHV5SWM0R2FjNjZNaFFwOS9z?=
 =?utf-8?B?SThDbktqZDhlVG1sbVc2djZoWEtvampVN3g1bzc1WHBLVnFteEpZQ1JvUXFi?=
 =?utf-8?B?ejNEdlBGMTdXQkF6ZWdoWHk0L1FUQ21nalhCWGZhai9QaEt1RGdqVE1NVzFx?=
 =?utf-8?B?cXVsbGJpeUFyVjk5Q2VSN3p1cXdrcWNwS1hJcklpUDYrbEE5cWtwWUZRRXJk?=
 =?utf-8?B?V0NFRVdsZk1yc240RGdXMzYyRXZYVzZPeHI3b1JkeGVZa0RGUGpZbjBkM2pQ?=
 =?utf-8?B?U3Z3aXVLZW9XK0xiWXZheCt0OE9tc1liUEkrWDQyYjU0U09ENDlKeVJTZ1VH?=
 =?utf-8?B?YjA1Vi83a25xTTdjYWF5K05lTHdHSGZkcGxXTVFNaC9mdVZ2Mmo4dUZEaTBB?=
 =?utf-8?B?VWcraXBVL1Erdk45ZlRReW05M203VWFTWUxIM2M2cVo0b3dUb2JMZityNEJx?=
 =?utf-8?B?aXpjK1h6cis0Z1BPd08zcGRZOUlBWVRiRG5zbFE2YTNDR0lRVVBaYVJkbVZ2?=
 =?utf-8?B?S1JsS0JheElxTVJYZ1UvNFRMcUNnZHNyNzBGY09JcHhUTnp6WjJGb2hicm1W?=
 =?utf-8?B?WEJ0NlVwSGZ1NU1sVjhLZlYyTVo0T003Ty9SSlZsZjUya05WUlZBOG1VKzEx?=
 =?utf-8?B?Q2xkekFpN3J0WW5oQm5pUGhXSWJOLzdlbFJzNmNNTDN5ZzZpSmNTZ2tlNVpw?=
 =?utf-8?B?RjhrRVZqb2s1c0pYMG4wSGJvZFFwSFpwT2xDL0MvWDY4c3NyY3JrWkcyNytr?=
 =?utf-8?B?SHczRUhtbnIwSzlicy9MaVVSTFdLaXpocjRKNDdVY0RNLy9GT2pJelEwU1dW?=
 =?utf-8?B?T3M2Y0lnYWVVejVZbXdSVDQ2NEdndUs0dmRLeHF3OGtnL01IQUl3WUREaVFy?=
 =?utf-8?B?Wk1BeGgxajVscmZUUWtrN3lpZGs4NUFOem54TzlLelBjK3hRUlA4TTVDdHRq?=
 =?utf-8?B?SER6Yy9oT0xvN1F1aTJNcXNHamRkMDVicitQY0dNU2c5K2ZmSG4xemxRRzF6?=
 =?utf-8?B?Tlozc0JXUGEyY2RLZ21xS0lNTmxxbzM2Q2I2VnNZbERieVlUWmFpV2d6R1Zx?=
 =?utf-8?B?aTRIMDdBM3RkSkFMbmZEV2p2QUxyT1dkUHh6WUxkcFhlbDlGeldRS2JNeHBZ?=
 =?utf-8?B?THM0M0Y3K2ZsR0YxcWpIMHpJbm5XbnFnT0hVWUxWclVHTHNZVi9lTjRHQUM5?=
 =?utf-8?B?Vm8yUkNxTExRcVVtbUZ1cWM4ZjRpL1g4SzEzY1kvTzcwZFY1UkNSa2sxdmpa?=
 =?utf-8?B?OHFDTUw3UE0vWSs4bjdhZmxFQkZHU1diTDJsZlJmQzdldzRCd0RwNmxMQjNS?=
 =?utf-8?B?Nyt6aGErTysyWTBaLzRyaTM5V2VjeHFkZWh2RlZ4dEFEekVEM0pqQmp1UE54?=
 =?utf-8?B?dWZPWXVSMGllK1RBMmhRU2c1WTk5RWpnNEU3aVFjd0hIRUlnVkc5OUpwVFg5?=
 =?utf-8?B?Qy9ObXg1VzNzT2tDK214Uyt1WlAyeEpNU2NWeFRJY0pucFRleWdxNGF2Wnph?=
 =?utf-8?B?N3VubDRZSGZCeXhIYlBHbDJRZjVWR2Z1Z3VsWVBTRW1ka2FRejBUaXh2ZDF4?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f435d6ef-d6c8-4797-c227-08db9e66a8e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:39:56.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKSKYWEqRDZhW38MtyBNorfDR4OffSG5DMobsDb/oELKJfll68w4UapthXi6TQT6erGF4GRjv7GcWRrPuqqYzyO2/eBCh8BGjAeuKxSht1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tianyu Yuan <tianyu.yuan@corigine.com>

The most significant 4 bits of nsp command code should carry the
ABI major version so that nsp command can be responded correctly.
It is working well since current major version is 0.

However management firmware is going to bump the major version to
support multi-PF feature. So change the code to explicitly contain
the major version into nsp command code.

Signed-off-by: Tianyu Yuan <tianyu.yuan@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
index 7136bc48530b..ee934663c6d9 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -37,7 +37,8 @@
 
 #define NSP_COMMAND		0x08
 #define   NSP_COMMAND_OPTION	GENMASK_ULL(63, 32)
-#define   NSP_COMMAND_CODE	GENMASK_ULL(31, 16)
+#define   NSP_COMMAND_CODE_MJ_VER	GENMASK_ULL(31, 28)
+#define   NSP_COMMAND_CODE	GENMASK_ULL(27, 16)
 #define   NSP_COMMAND_DMA_BUF	BIT_ULL(1)
 #define   NSP_COMMAND_START	BIT_ULL(0)
 
@@ -380,6 +381,7 @@ __nfp_nsp_command(struct nfp_nsp *state, const struct nfp_nsp_command_arg *arg)
 
 	err = nfp_cpp_writeq(cpp, nsp_cpp, nsp_command,
 			     FIELD_PREP(NSP_COMMAND_OPTION, arg->option) |
+			     FIELD_PREP(NSP_COMMAND_CODE_MJ_VER, state->ver.major) |
 			     FIELD_PREP(NSP_COMMAND_CODE, arg->code) |
 			     FIELD_PREP(NSP_COMMAND_DMA_BUF, arg->dma) |
 			     FIELD_PREP(NSP_COMMAND_START, 1));
-- 
2.34.1


