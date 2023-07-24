Return-Path: <netdev+bounces-20318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05F75F0C6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D994D28141B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E72E79FB;
	Mon, 24 Jul 2023 09:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45F7482
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::71d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFEB4EC3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5vmb4218M0Prhi0yUPPjRQo1Lgzn5TX4O9a8QS1zba1clDi62QmUIm71qiMmLhR9/ntG+/WxIsIDvr8CK8a72Fbv27oZBKcCKjqEXkvgrUn/j0YEUBtUcxc4+GWVojlLXBtEM5qtdoAZngFRtao//HWZyp/jdkHANVF1Ep4F06Ib63H8k6GRQHOv6OeAO+Jjbv8kakI3n1eOQh1lrGr7xhNLgcu/mEe29FCr2STTimsX1pxVPtShncxryFZohDaSYJxJQOE9mDXsvkwGxfPrNa07wVJDYZJpXw6DuyUwRaHRPC4bim8WIV7rTxDhWG4Xay0ahDAQ4kTxL23ys7/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8MxMY83xTcM28F2igMdsKW3tVxvw1ogvn7+Caroqqg=;
 b=enc2gQNoyKw0O58vXvrRfMVzaKRc4NfcnCHuCneUyC9FplRtKLdZQdb2N0J9XBc9Z2+smjKPYWllmrBEtBZ+QL+aSQWax1323gHWb0Eqj6foHohRLPlCIiP0oMj0ZfDUY8BBk0fbRLU9JW7EPIo1JIP0ybKHBIL8ogwsoXu6l1wuctJF+IIFynArVMl7MLJ2cM9uCj/2CwDsIGoA61UB1dQA8osYg1KrYgoCBO2JiSWVAT1M5eLlkwhEgpaNKqaP3BssV+kT6x6CC6xAwTi2sLjkBCL4BJxpRbxD9onWE7cQfLZyKoh1X+DouP18Alui3zx6SlS/FvnbTDZBJJTqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8MxMY83xTcM28F2igMdsKW3tVxvw1ogvn7+Caroqqg=;
 b=tk3+EkjJImyfAZWs5YtgD2obI9mvDNqAg2Rc1k6OmW4Ri9YmQjEVg9NWFLqiTMZjHFlk7Ijw+8OlVPqFlMjmlRRyfi1xCaCchGhiLGq9fZWGMA7RMGI4rWWxIYm9KMrV0b+Otq8ZlVCuCU8v1WEFYrCSyrm39RVC9S1rhCVuOvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:48:53 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:48:53 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 01/12] nsp: generate nsp command with variable nsp major version
Date: Mon, 24 Jul 2023 11:48:10 +0200
Message-Id: <20230724094821.14295-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724094821.14295-1-louis.peens@corigine.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b8a594-d378-4029-a0b2-08db8c2b30f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bNaAaCH3YRoSc2XUBTPtPlDZAgjDw89sHiTdE4R3HSChcoSpPw9hHGFZ4bU7KSN3XQEg9lpu7v7Bn7HRiOD7j//i6tIdUl3YNs5RrtiHyoGVWcQB6RAs1L1M7xjTk3xKXsfIni2iW62Bj/vYrdM5PkGntuA1KBdXp8JNs3h728YN1HDH1gaMtT7xJIVMzzRgR6C2Sn22V8DAF1Yqrrrqwn5HsJMb1oMqJc0AJWgASAOwTLR6YwULuwTI+M6Ya+Mk6BVxtjcnK3O0zXGPB8oOTUtzwwHDlzNV3ufy+W7JZOc5/7xYYfxS+/KUTExo1HAN3F7QMumW+KEYlogRWE4+CMoJnidJF59QiRU5cKGsmB9Q5uhbeqAhY0PAGLpFT6zwZNy+2HPxyTxEP0HjBGcl0xmba3xlrEC3qYK2IqWcuiHlmxa0/XaG8fCyu0jeFqwoB/yj3TqgVopjklzJ33+/V7GaE0VrbBw5Fbqyj4cwbVsHmL1vUgE9wliSWyGohEEQVHRTi5qOuHn+g/bFfhOGZ/LXVXSTLNLp45qoLF2aoUI85o2khVb911vyGbOYB3Nnt+wbR6MJQaAU4I1wW2gXo6q1WHwkPBLhe2sdatZnz44rYCiMD7XrEUvrd5KUp0zu/TRKBdoGb8im445ycwONR82Qm3BW1XRBGzAa+gMtKVI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJNMDVvOTRFbktsR2pKR2RPeEdtY2U4ZTI0RXJXei9wZUlhckFjUU5xMWtX?=
 =?utf-8?B?TTNGZElseDVwQzdoS0E2KzZycURVbTlWSUlQaDlnZmZpOURCRDBQY2VBVzBF?=
 =?utf-8?B?M1cyQ0xhVzg5QzFNZ0tzNXd1ZkZRZ1FSSDlsNWZQY2tETUhweCt1eGFzN1k2?=
 =?utf-8?B?M2JnelNtWGl3a05qOVQ2b2tiKzg5UUtBSVhtbk9WbTJFR1BpK0hYMkdJNVI4?=
 =?utf-8?B?VTdqS0NGbW93NjRUSkdjWUJucXZGNlVCMDdsaDZtdkh1Rno1bHZxZ0JqMi9D?=
 =?utf-8?B?VTJTWnR5c3FHMWs4K1VCamlzUmRJbk8wVGVIcUxVSEpwWnlTYTU5TVRWb0sr?=
 =?utf-8?B?MURqL0RqK2VPMG0ybUdvYVdzMDcyK3pFT3VWY0h3Z0VmUzQ0YW9jaUIzSmVP?=
 =?utf-8?B?bnpkNlh5RHljQnh5MTdrUEwwcnJ0UkZYYWxoRlRBdnhVM3A2RCtRZENkRjZt?=
 =?utf-8?B?aUZWc1hOVmV6Q2RkTXpMQ2ppR1E4MW5YK21qOHhhSStHTFBsNmFEOHl0MmR1?=
 =?utf-8?B?Z2REejFEcE1xRjZXYlFneFc3b2dUc1FQbm5SQ1FrV1VVRnZHbFBmL3VCWG5Q?=
 =?utf-8?B?MlRvTTZtNUxkNlcwRUU3TzNFV2lFT3BnRmd3MEZWajFNM2VkMEovTjIrQjNl?=
 =?utf-8?B?Y3UwQ2QxY3o0eFJvNlFGdXlFQWRXcW0weUZGU254M2dPZWRDZm9Uc2hTSkZU?=
 =?utf-8?B?djF4UVV3MzZ1aWtpM0tTb3FYcXd1UFRCZGJYNER4bHNUa1dTRHE0WEV3OWtP?=
 =?utf-8?B?dVF4WXh2VSt6SStzR2VTTzV6MmVqbGFXOFZDSHBCQjdRWE1uNm5EalRkZVRk?=
 =?utf-8?B?dy82YWh2WjFFcmlPckJ4MGptMnBaSDFuTXQ5ay9mQTJ1ZUxOSlB1M0p5OGJp?=
 =?utf-8?B?djhxcWRsb1dKbkxlVGFueWt5WWxCWXBwT0FPQzluUVhuMUoxdDlqSkhzRUhG?=
 =?utf-8?B?d284d2szVGJ5Y25SUFhzNjBzcCtzYlZVRjVQTHVlTXlQaC9MeUV1N21jNGZo?=
 =?utf-8?B?ODg2OEo2REJ4aGJHT1YzeitsSG02anlXNmlmZ3hmM3RSUzd5VGMwWXhweGtt?=
 =?utf-8?B?SGwxRXc3eWVEUEtIcHloRnpZNE51NC9PZXRmckJlZFNYclNBQ1RyY29XL0RN?=
 =?utf-8?B?d2xONFRucGYxYnJDaFZYVkJTVm9LakRHY1pGek5MaU5zbW8vZ2NYWU1Zbnpu?=
 =?utf-8?B?VE5VNzl4cndVcUNpbW11cmx2ZDhPcVgrR0JhNGFGVzNTd3ZIb3BScE4zY05P?=
 =?utf-8?B?dlhDNjQ2NzFPNEkxTHJqMlJDQW1XTFVpVS8xNjJSMHMvVmhyV1E4WmVSV0Ey?=
 =?utf-8?B?NmUrQXVXMHJlMzBmMEoxUGtrMDVUT2hZeHVkbXZ2QWxCbnJlOHYrdXZmUTJR?=
 =?utf-8?B?UFFxSW1NS2p1YXdLYkFPMFFzaVpuUFR4dCsyWWlkbDlCSi8wUk1TNUFpeXFj?=
 =?utf-8?B?eC9ZMUVmOWIwdUdLRlAzMGE3NmJvdXNEcFlScVM5OW9ua2ZuWmxlQTFOL3cz?=
 =?utf-8?B?QVh3dXVKU09iQ0NNL3ZxcDFsb3BWdVhHY2FwbnR3SGxIZS81S1NxT1dCVHhK?=
 =?utf-8?B?NXAzTHV1dmNvazlaTlcwakk0RUwwNHA1b1EvbG4rMGtQNE5wWFd1dDhxazUr?=
 =?utf-8?B?REpNRGJVakNYMWpJVXlZRTlwS0RHblE4bjlHRkNxc0RiZ1dZNWNrUThReDJi?=
 =?utf-8?B?a1RBMlhYd0daenBXL3g1RG5QUWIyYitHZjZ2QUNTNmVyVjlTVEYwT1I1SHNX?=
 =?utf-8?B?ZmVYNG1DbjhDeUMzZW16eXNRK295OUV1anBFdzc2cVBGeUhjM1FJcGVsYzZ0?=
 =?utf-8?B?d3hWUTNiYXFFYnEwNzczc2ZMRm43R1pEaUtNZWtZak5vSThjNGFobkl3ME9M?=
 =?utf-8?B?dGlPK015VGswQy93SVBGK25DZGMrcDUyWkJMeCs0MFAvRGlCMU1NZ0ZRbWh5?=
 =?utf-8?B?Q1l0NGNxcGxZSWFyYU1ST0tzTTRYZFRxeHBVZXJwSHNUQzVoaUJnekhNbmNS?=
 =?utf-8?B?TC9yN1hLSlpTcVByTW5pRVcwVEhkd2pOVVNZemZqZFZuWWd1VVN3bEtUZTBl?=
 =?utf-8?B?TVBzTHJEcW5FWStoR3RoZ0hrS0JHWUQ3WkxEMm1zR2g1eVVvdTQwWEowOGVR?=
 =?utf-8?B?clpUUlFhdGVFQWM5U2JWSzFXSG1LNGlQdTc5UmU1UUVmazVqLzlIY0xJVkJG?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b8a594-d378-4029-a0b2-08db8c2b30f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:48:53.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5KzMn90bD0vGiNJ99EPwd/LockjwhjYP/Z5kUqQ3ttDSjDtECi9qGcaySMQwd+dPVOH5oJkO6wuBhwoOVbpm79MO+Q094uA4EPtPm/NH0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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


