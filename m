Return-Path: <netdev+bounces-28104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9975F77E3E2
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36481C21035
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1B156C8;
	Wed, 16 Aug 2023 14:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F30156D1
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC82715
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqdOJtyulPea5UBdfa0EgDIjHG9/8T8NRfTsNlWX8bGQq1+lCfV9mm7l0uTCOiwd0j1ogWapAK9ImstopyBinE2xG/CQlI6pv+to1nhr5jAIqI4/EXuke6fHwypQcrNjAYL5wUQgF1VbrxsUYNOrN+7Q0Zw3N+Jmk5egdl3ujO42AFo9ye89g8g79aNZUMvJ0XPAvhpqfFGQOqiAmmLGjfyJFh4VFGcYHYnx2QCDRTBzyy00+Wu9G62cK+CcFZQXLtHrs9o+7m9S/LLxTmm5D/BeLVo/B1/GAg09KyhSchxp5HsuSSTb0GMnAcoQuWiX5CYFYfd6tI83Iw/w3Z8uKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBUXZqRJXAmBgNMsYWTMWNsnJkPQFbIT8w2pC32UAzw=;
 b=BBSt9LV+loSerSqIwIowMjo8ofr6YzVldhKnZcWCwv2zzNsqLtlp19JK8y0wb2TVNSXEnvuvBRZcN5ROZOuWrz57yyedDC4VoCU+mmaln93TroeN40LCDGh+vjacuB6VUyVlZoprhKvKa5Ux8ugM8pw2+829z3lhRrUh1VY1CZeNO6qwpHgNEOmPoDaCME1IOwwnjGGC4hu6RSrwSF1szyvzgClPBNnSqTVGrrLJHZ63Id4Ip6gAnn53UwJcqfarcesIIr4JzSvmQeITjTXV2D5S6w1VbcSyCpjmiyKeBiN8B7xy9JP8/KW+1pZWlzod19YVdp+Ms8cltVB3du+fAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBUXZqRJXAmBgNMsYWTMWNsnJkPQFbIT8w2pC32UAzw=;
 b=sIozy7YsPe/pNy5Nz2ONEwVMyP5ztDjWPTVMf6prY+Mf3ojCpincilhddIr9x5le0VGAHfE7PO5kobmC5pT2zIYNlQzS/HSlgWVqqRLszDm0QxBeEV/GXFajKGihfR7efFr8Q9xV4qaar4L4c4hJJiHUghIX9DgRR6Hpmao8usI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB4097.namprd13.prod.outlook.com (2603:10b6:5:2a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 14:40:07 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:07 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 04/13] nfp: don't skip firmware loading when it's pxe firmware in running
Date: Wed, 16 Aug 2023 16:39:03 +0200
Message-Id: <20230816143912.34540-5-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: c919b95b-911a-484d-1e66-08db9e66af78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I/+1aufTlL5bTEsFHos+el94BXlj4ObImU8Ot8DcFe3q2Q+p3MS3RT+SkOq6MJSdHGHc31hAC523IBFsTRvCYEs+RUdbE8IKqHz4+iwPmeNbeEaBh3PognYz2NrzLqQ7ueki7pWdLraSvp8Q+nGotJpV1r2W7lie6wFxcAsOReUGQCu1cxEqBkdkWMmx/1ttgqdCrWmjo1bOFg/cLfn1iHE+dt+RLcxEkySBwjEHn3PDmevc0CDf400xCLwCr9bzoSZzcdsBFeQNurHMNNcq7C7OHUnsbGhMvt5rSfEHBy7ygTNccnkeBw9RkQJqxOQ+hIz3Xr1xucdbCDqFU7paCepo6uyvwjhLtTPFYPvzqHwilliF/d4RnDPeB07/WpszJ+qWGogNeWO424bdU+n45q2mXbSY1Chu4DqrjysLdLk9VleWseRjQ0p9viV82qUZlM5k2S3HioN1KuYYTJcvbOcxG1LtsaMQa5HDb4hA8CP0yM/6hx60S7p+0GN+TlblxU6V46D0cZeP0axCnoQjBpO3GEFjmWxibVqAmnV/kBpcx4vpamwmZ2teQ9xl/lZmUh9uFUko2lXtoKMpaME0T8eN2burOGwBIVJapkRDUkm/xuuGQZ7fkKKdsevTDB4lxEN74wBR4mIa9qSRs+02KloiEEx7Ml28qPUvxPcfF5UFrAe38cpSZt3PLp8rSK1evCsbNdeyfBqOeFsgG8URaw8BfdCnjJzbUgopCqPss1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjdoZ0ZFMW4vTllmaTlXT09NemZZR1ZqQ2RtN1pLOVZodXdDNUZucDZiekZn?=
 =?utf-8?B?YXdSaVFKc2NhSS9zcU1RU2l3bHRaTEVLZUpiVnoxczltbVpDMXkxM2dCSEZM?=
 =?utf-8?B?RnpVQ0ViaHVuS1kraFdQbCszQXhCQkhLNjVhQkE3c0F4WUlCZVRiZ0NVdmY2?=
 =?utf-8?B?MmtQbXZHM2dBMUZWeXNWZ1VkVGxOR0FCOC9yMGl1YzhJU0R0dko1MU00UWhv?=
 =?utf-8?B?RFNVUVBJNlBUVHdhbkJKTFRnYW9VZ2tnNUZwblp4dEtwQisyQ3RKRGVlbmJH?=
 =?utf-8?B?RVFjdUUzVU1sNE96QW8rSGtaak95cExoaDRlb0NkN1AxaDBKV3hTRU01ZHRF?=
 =?utf-8?B?ZENPMDEzWWE1T0g3cjQ5U245ZHVwb3JwMW9xUlprcGNjTHlGT1RuLzcybGtP?=
 =?utf-8?B?VXNYdU0rclJTc1FkSjdkRkp5WUxISnVqUWZtcTNXczZLT3lXKzgwaWYremdS?=
 =?utf-8?B?dW9XcGVpcTViZlZoWFByZlF0cUwzOTRqTDZCWFlYSWN3NmlLWlRmSWFFSHVs?=
 =?utf-8?B?aVg2ejhyaTZaNGtWMnVIU3lIaFNKbklPVHI3MXJwcEZFVHNSdWdIQzhjTmNk?=
 =?utf-8?B?YkZzdFAybXJjM1k3TzdjcTJ4NnAzdUgwYjlZM0NiMllzdGZoMFBsWkpPcUE5?=
 =?utf-8?B?VjNIbVNMd3dDczNCaGxuU1VQRWRGUzNFUmdVRVBzR1VDS2YyTm54WnpyeDUz?=
 =?utf-8?B?MERwU01oRU5sTDdYMk9ielk2VTJaQlcyMWRmdXAxN1RneklDR0ZrUlRFZWpE?=
 =?utf-8?B?WW83YytNSFpqdmtVS2ZUaVF2Vk9ScDFMc1orTUVUekJxRlBJdVduMG5zTkU2?=
 =?utf-8?B?TStSRjRpQVlNd3pGbG1ibFdsamp3cTJZZTkxUitwUDlueU93UTRFSTh2VHlk?=
 =?utf-8?B?Zm5Yd3BmTGVWKzFjWFFjaFpRUWhSSzVZekhudk0xUnlLWnhyVEVLRjlhNUp2?=
 =?utf-8?B?UzZOMDZpZjV6VUNBU1h3Z25oUzJqUCsxUDlnQ2pqOXVhYzJ5OUE2SU9HTTIz?=
 =?utf-8?B?U0FqajBRS2U4VUZPdGI3N2tPenhTWjZOc1NzVG8rRzgrTFZ3b2NKL1lodklP?=
 =?utf-8?B?Vm8rdVFCOXQvdlBpaEJma29rdTFZZVNZY1doL253UkY3M0FLbUZ3bGZFSGg4?=
 =?utf-8?B?OUVPS0E0YkhpUzVnZmVZN2VQUmc1MXlSS2ZKK3lOczhKQ29WdmdDdkNOWlpI?=
 =?utf-8?B?bHNLVUhmb1o2VEttZWxrOExROGhQOGY1RDltM1VaWWJFT295cVhBYzgxalZq?=
 =?utf-8?B?TUNZT2NTVTF2SENCNWZ1eGlwc2ZoOFNnVmd1K0tiQzJFdlFkb3J1VTRTaW5B?=
 =?utf-8?B?aEIvekNENGtSZFlvWlpwUU5uN1I5andIbkEvUmcrUGJraisydWhEaGJ5dFBY?=
 =?utf-8?B?eVJ5WnpZcEMyaGY2Z2cxR2lBL1N3TUhuSnpWMjU4ZjlRREo3QVBNNzlDTDZL?=
 =?utf-8?B?S0FiVTh1VXRZSFIranlPaXViMCsya1JPYnZFQnZtUUMvYVJQdDlEN0o2SUJn?=
 =?utf-8?B?RGY0aVExV0NsNHRDTzB5blljWGRBWW1UaEQ0NlVoVWZsOXE4WTVIRWNleklT?=
 =?utf-8?B?TE5PN2p5cmdid2V2WmkvcTdRdW1tR2J5cWk3V1FOeXk5dUl3dE1FcFlKRXhU?=
 =?utf-8?B?Y3VYWlRZWmlpK01mN1lvVlh1MzJpMUJvWGJUZEpXbGszQnZ4K20rUkJudkp1?=
 =?utf-8?B?a1p2RDVkeDV0a2pHYXZVSFZSSXVxSXZqbEJhbGZtWkpHVno0N1drdFZPcEtk?=
 =?utf-8?B?MENKRWtWU01vQ0srQTdwTEY4Zk5qK3NvZW14bFZUYW9mcXBOWngyb0lKNGdY?=
 =?utf-8?B?T3NDaS9IcDJxYzM0MnBkK2lTUWMyMGtPc0tlMXdZZXRETzlHVHRYYmJacm81?=
 =?utf-8?B?RGRGdWF3dHpwa1VGWHFya3lrQnlKaFRJWGppcEpuUmt3N0hXOExnQk11Ynlh?=
 =?utf-8?B?dEIxRWthM0FGbVRsdEEvWG1uNHFxMU0zLyt3d3F1ZWRoSUJPY0NtdnVubU5X?=
 =?utf-8?B?ajJCREJkUk5pQy9hd3BLblBEL080SGVhbEZWM1M0bElBbHNHUXlSL2hlMkYw?=
 =?utf-8?B?VmJaRmZRSUhNcEtleklrT1NhcWNuSjBSVlFUQWExeDhpZDhHTURPNGtzZXBX?=
 =?utf-8?B?bWlKSlk4MjZGTWJSVWhEdHJYd3VCL0VVaW9qZnZjYUZyZVBBb3BCUTd2b0xF?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c919b95b-911a-484d-1e66-08db9e66af78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:07.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CU5rAtctOdHonTPMLnqEldlJ87Z8JdHeTbQBWBd1vBgTOGpMBUnIM1217gneMaOQI4ANTcHQkcqcwQGL03qKeOelMw7taZW6n8vEs8kagr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In pxe boot case, the pxe firmware is not unloaded in some systems
when booting completes. Driver needs to detect it so that it has
chance to load the correct firmware.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index c81784a626a6..778f21dfbbd5 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -469,6 +469,28 @@ nfp_get_fw_policy_value(struct pci_dev *pdev, struct nfp_nsp *nsp,
 	return err;
 }
 
+static bool
+nfp_skip_fw_load(struct nfp_pf *pf, struct nfp_nsp *nsp)
+{
+	const struct nfp_mip *mip;
+	bool skip;
+
+	if (!pf->multi_pf.en || nfp_nsp_fw_loaded(nsp) <= 0)
+		return false;
+
+	mip = nfp_mip_open(pf->cpp);
+	if (!mip)
+		return false;
+
+	/* For the case that system boots from pxe, we need
+	 * reload FW if pxe FW is running.
+	 */
+	skip = !!strncmp(nfp_mip_name(mip), "pxe", 3);
+	nfp_mip_close(mip);
+
+	return skip;
+}
+
 /**
  * nfp_fw_load() - Load the firmware image
  * @pdev:       PCI Device structure
@@ -528,8 +550,7 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (err)
 		return err;
 
-	/* Skip firmware loading in multi-PF setup if firmware is loaded. */
-	if (pf->multi_pf.en && nfp_nsp_fw_loaded(nsp))
+	if (nfp_skip_fw_load(pf, nsp))
 		return 1;
 
 	fw = nfp_net_fw_find(pdev, pf);
-- 
2.34.1


