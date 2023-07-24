Return-Path: <netdev+bounces-20322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E875F114
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69CC2812D8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065EB79FD;
	Mon, 24 Jul 2023 09:50:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673FDDA3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::71d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1179530C4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+nC2yKHZ7X4r4ZzeLB+gESPaw1LV3YsIgxVKGzltyZ1MJ1dimaSQ5m8Vmf5pp7npy9FoKhHik+V27jH6GrowfPVvcOtSJNRQS1i/9uG6ayRbOU+qJlIfS+EBEGwhnRo/LlCI32qmOj+Q8/rFsp66Q4P/0g0C+PTDTP03DxV5s3+yckC5YsjsQH1Fk8mT9Z8lUjwZNY4WqvdyuR605FdsxrPhfoFxFXbr/mfm5b8tsEdcfH3JFmpzn3KSVV8/QtytDBebqo93JHyjqqSDD0s8IxASTZsYdv+f3HoPPGFixbJlf3msQcKYSwe3NlBB+v3mi2cbwcO++rMFp3HS3MdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sCbGh+9x4dpbOD+eyONtMkfEGH4E1zjjEigSmOSLPM=;
 b=KRiCPn4E+UqJKjeqewxo39sybJg6e3o0UbHMm+9Qtz4AmbZc8AfKw/vsKyDe5FDotpMg+CRAGU5jB4Cr+6ukXqrXhap45U6y7rB8LICKGywIpUGAOaObv0qSoovpuf96WQoykj0Os1Nk+fZG6qn5QJP3cw8WihvB9daI5fXEa04kHF59Xq0xfq1MbQHQ1ZSr4UpQAm72KmXdkW6faTtCx99BR0JbYOjp4ZChmN5cPpKuFtQf5tUbHe/N4ynR9lK2lsgXUDbxjUAu7fzJVPIN7sUFG2+mLgLeDTYZzh7v8PkaTqkR+xHVgLPCs5STfS+tBlPID7LF/1LFdMRUz8CqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sCbGh+9x4dpbOD+eyONtMkfEGH4E1zjjEigSmOSLPM=;
 b=WbkTPxnt6+HZwEeK6ryGEzs8mBfiiOlwy7k41ieEXOf7IyvlnIjRBtF7AwyH1T+xmKv1xa49bZdT3kjc4ERy45zfc2sDLnK7hOp7FnmGNWSoPxRU9WQmtiuDa/lTCgGdE1IYDhNeuSM1st5dyFGRst/nRw2AlZu4Ab5JQ4NhyQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:08 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:08 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 05/12] nfp: introduce keepalive mechanism for multi-PF setup
Date: Mon, 24 Jul 2023 11:48:14 +0200
Message-Id: <20230724094821.14295-6-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5dd36d2b-9067-46bc-2a20-08db8c2b39a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8oITnIMwiytzEby3/bncONGr3N2B/Fa4TGsQUPon7FcalVWJkYEcQxXzufJ5b5m5v5wRvACl+ANM5llirosfi56DegExs8vXM0VMPJ3LsM5ILrz+fpxonyc363tacxl0zfLFQrG1lhK1fePNB0d173T5+jqg7+7OehQ1/cLKPqEpPOxoV50Nqy14VNT9yitfkKKS/sGJv8umKup7g7efwjthC9UKINCSNXzidK0IAWWAZu3r7OyLLvHyOXB1zzMiedy4JjM80O91cdLy0bMUiXitlUzRfS4zhHt/TBVoK9lNdAfxF5bWFRT/9ywziL5YMbWO31MtO5QNO5uF9NeUJEqJsDCkO0SVZiQpKEwzx6Ksa1jrMSjeUD6Z0zOVntq0kes41OLCZDNBNtSOeFfKLcGn9pWTEHDzoTiXXbgE4YW3AV67vHXB4Lbr6dLRbdBvO33Dls25ojlSUe9Y3PD476ch6o/iahumMwGX1l1aONOiuAObBpXgpMrEXz2EZOEHJy/avgR+iEbyKv+UxsyPlby6WSYQl8tFFFJfEkjZjLok9zSa0zWe14W3bnFZfMTBrdnACjL30tNdSQ3FntglnV6Zme/7hXSTPqv9ksm0JgBy1RQ0WGRk0btsoCGTH5lo57JA644X91ne/LnfjG79LSN4tZY6+0HAYgDaBXj5anQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHpuQjhML2hONUtuR1hqbUJRMzY3MS9NVEhXd0ZZTThsQkRldlVVRTBPcHhH?=
 =?utf-8?B?akZmSVp1eGFnbDByTWhLZVhKNUd3aURhbm9XRmswNUlDOFhMMjB0UmtORm5u?=
 =?utf-8?B?QkR1WERlVTdBNVdneXpEUzVzRGxiNnFoUlRMbGJlSkxlYmtHc2dnREVRL1Bm?=
 =?utf-8?B?WTJIMmpVVDFOdDJnQ2xPYm9rTzF0Q2FzKzNsTzRqY1ZUb3RQVUlQbkVWRG1s?=
 =?utf-8?B?U0ZQUlF4a1FLazNqRmxMbWxwdkoyYjdBTGVsdHFzQURhZFhEcFpvN0N2M013?=
 =?utf-8?B?YmZpWVppb0VzMHlJUnR6djVzYWQwYTlOOFJrcTdaazk2bWdyU0xYYnVjM1ZX?=
 =?utf-8?B?d0NQOHZHbDZsTWdsdWpGekpTYkk3cm1CYmJYOXdhYlJjWUsrWHZKSlZDWGx2?=
 =?utf-8?B?dHhXMFBPeXNWQ01mc2xsK2xNRHVCcWFMSGp2eVNsd3pIRlRlMktkTEkrQXl4?=
 =?utf-8?B?UVFLd1gwTHpLVGRMQS9KZTFnV0ZYdFNXeE9nbHgzdERyTVBjb2hoN2x4R1VD?=
 =?utf-8?B?NjZvc1FEUk1sbld4SzRBUXNiZjAxUGRWNGZ3ZjFFaVI1TEJ4Ti9sT3JRd3lE?=
 =?utf-8?B?ZnhQSGh3WkNraFNtalNCL1NVNXppOVA1WFZhbHpndnRlT29NcUVDd3BsVngy?=
 =?utf-8?B?Q2d5S2pxSllWakFkcUlCSzVERGlGdWpKS1pJTW0vSitPUXA3RHE1bFlGUm5P?=
 =?utf-8?B?OXdsYUk5a0xJcG5ydTZYNjBBQzUrR0h0dG1kdDdqMGV3ZHczYmJrRDVjdW12?=
 =?utf-8?B?VzZTRm1nbUJNNHFzY3NaN2xjTTJ5VjI0MTZQUTBPY3dVTEdTWW9mTzF0cENp?=
 =?utf-8?B?L0Z1bzFJVmU0V3M4WVIvSmw4YmszTFZWMklJOFQvd2lmSk1uNC8yc3Erd1p2?=
 =?utf-8?B?K0crcTJFeHhDM0pVQVc3aUFLNGlnakV3cDRiU2Y3UmRXYTFpRVh1UXRyOHN4?=
 =?utf-8?B?ZXM1dm9hYU1zdVUrK1BIZHJWYmNlbllXZkVBV2UzWmp3b0lhb3NUYlpEZ01H?=
 =?utf-8?B?YU05STlmTkt5a05Rb1hBVlpZY2V5Zk9nOG1aaUV6TTFHVjFpM09mbDZJb1lm?=
 =?utf-8?B?UzRONDJmS3NFcWQ1VXRPT3hNa25UOFlvWnQrWmY2Q3FvbG42OXNLQzJkRHhT?=
 =?utf-8?B?SmZZb1JNUzk3VVZ1Z0oraTJlZE05UUlCUW5DY0ZEUnNIb3FvbUxPK1BlVUM2?=
 =?utf-8?B?N3VsWlMyMUhEVGtld0VNTlhHcU9ManplQW1UVVhvZDE1SE5aYkhXRHFQenEv?=
 =?utf-8?B?b3VjK04yR1RyeFZPSWpmUUgzUmE0RTFuOGdBbklFSmdMNy9HRDNnazU4aHlX?=
 =?utf-8?B?Sm14SERFYWVWOVBCaXNnR2hkY0ZMdDJQMC9PbU5TYS8yQjZ4UkMyYkJDMWM2?=
 =?utf-8?B?bWJ6cGp5WDE0enROQ2hma3A5b21PMVhNeFVYa1lXWXhSZ2l1K0pMaXBXQ3RF?=
 =?utf-8?B?bkJTWThXRThxcXc1UmN1N2k4TTRBUlQyNDB3RkdRd2V5aVgyRmJ1bFF5cEx6?=
 =?utf-8?B?cVA4T3dUTWI2NS9rVWhMSHIzekI4ekN3Mmk1YVd4LzlEcVg3R1d4WU9jNW9G?=
 =?utf-8?B?dmU3bkFMR2hhSjBKb0ZuN0ZYejlsaU15N0xvSjhEUlU0WnI2d0dhTjJCMGcy?=
 =?utf-8?B?dVBTcHc3QTYxcFF5SldiWmVFNXgvRmdoYzVyVjVQMldpUzdqQWNlWklhc2lw?=
 =?utf-8?B?azEzSFdub1g0bFBZa3ZpQnJ6ZHlLb1MyYVNvRGNnTStQN2JuRWZNcGxXbnhP?=
 =?utf-8?B?anpxazNER28rdlozdzlqblNSQVBGcnh0U05menJDajdtME15WjBSMDBxdXI3?=
 =?utf-8?B?WTl6aFB3TnlnUjUwdmgybnh1d3B1MEpuQkxwaWFIQlFqSWgrdWNLZy9yVnN0?=
 =?utf-8?B?ckFHUVpibUl5UGg2S05YZmZSRWRETDFDQ1IwS3VjVVVjQkZDWGlkeGFWeW0x?=
 =?utf-8?B?TWc3cnBKUU9zTXJlU0VVaUp2cTVIM3d4N0NPak1iNVR1SldGNU1DWHg3NTRh?=
 =?utf-8?B?QWhoOFBIb2NhM1FhVzJlWVcxYzJKZjhWeVFYdHR0Y3daZlJPSmQwKzZZd2Y5?=
 =?utf-8?B?akpVWU9PV01oTVN3VHRLQUVRY2lHMDFwYmt4MmlmeXNIVHdZNVJEUDB2YU1t?=
 =?utf-8?B?bzNxTCtWZTkvaGx2bTgyb3FzU3ZTcys2WnZYbktSVE9VU3F6WmdPRGNwZlRY?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd36d2b-9067-46bc-2a20-08db8c2b39a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:08.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWIZX/5evBPTvu2358psi1xQjiSKl69QjEWEoSVyjdc/B2JvCLjGHP62x6YDpFSSzQX9eCoHNJ6HNBB5mCdJVOSildHXyHBMrEQeELoHCqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In multi-PF setup, management firmware is in charge of application
firmware unloading instead of driver by keepalive mechanism.

A new NSP resource area is allocated for keepalive use with name
"nfp.beat". Driver sets the magic number when keepalive is needed
and periodically updates the PF's corresponding qword in "nfp.beat".
Management firmware checks these PFs' qwords to learn whether and
which PFs are alive, and will unload the application firmware if
no PF is running. This only works when magic number is correct.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 88 +++++++++++++++++++
 drivers/net/ethernet/netronome/nfp/nfp_main.h |  8 ++
 .../net/ethernet/netronome/nfp/nfpcore/nfp.h  |  4 +
 3 files changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 778f21dfbbd5..489113c53596 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -469,6 +469,77 @@ nfp_get_fw_policy_value(struct pci_dev *pdev, struct nfp_nsp *nsp,
 	return err;
 }
 
+static void
+nfp_nsp_beat_timer(struct timer_list *t)
+{
+	struct nfp_pf *pf = from_timer(pf, t, multi_pf.beat_timer);
+	u8 __iomem *addr;
+
+	/* Each PF has corresponding qword to beat:
+	 * offset | usage
+	 *   0    | magic number
+	 *   8    | beat qword of pf0
+	 *   16   | beat qword of pf1
+	 */
+	addr = pf->multi_pf.beat_addr + ((pf->multi_pf.id + 1) << 3);
+	writeq(jiffies, addr);
+	/* Beat once per second. */
+	mod_timer(&pf->multi_pf.beat_timer, jiffies + HZ);
+}
+
+/**
+ * nfp_nsp_keepalive_start() - Start keepalive mechanism if needed
+ * @pf:		NFP PF Device structure
+ *
+ * Return 0 if no error, errno otherwise
+ */
+static int
+nfp_nsp_keepalive_start(struct nfp_pf *pf)
+{
+	struct nfp_resource *res;
+	u8 __iomem *base;
+	int err = 0;
+	u64 addr;
+	u32 cpp;
+
+	if (!pf->multi_pf.en)
+		return 0;
+
+	res = nfp_resource_acquire(pf->cpp, NFP_KEEPALIVE);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+
+	cpp = nfp_resource_cpp_id(res);
+	addr = nfp_resource_address(res);
+
+	/* Allocate a fixed area for keepalive. */
+	base = nfp_cpp_map_area(pf->cpp, "keepalive", cpp, addr,
+				nfp_resource_size(res), &pf->multi_pf.beat_area);
+	if (IS_ERR(base)) {
+		nfp_err(pf->cpp, "Failed to map area for keepalive\n");
+		err = PTR_ERR(base);
+		goto res_release;
+	}
+
+	pf->multi_pf.beat_addr = base;
+	timer_setup(&pf->multi_pf.beat_timer, nfp_nsp_beat_timer, 0);
+	mod_timer(&pf->multi_pf.beat_timer, jiffies);
+
+res_release:
+	nfp_resource_release(res);
+	return err;
+}
+
+static void
+nfp_nsp_keepalive_stop(struct nfp_pf *pf)
+{
+	if (!pf->multi_pf.beat_area)
+		return;
+
+	del_timer_sync(&pf->multi_pf.beat_timer);
+	nfp_cpp_area_release_free(pf->multi_pf.beat_area);
+}
+
 static bool
 nfp_skip_fw_load(struct nfp_pf *pf, struct nfp_nsp *nsp)
 {
@@ -550,6 +621,10 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (err)
 		return err;
 
+	err = nfp_nsp_keepalive_start(pf);
+	if (err)
+		return err;
+
 	if (nfp_skip_fw_load(pf, nsp))
 		return 1;
 
@@ -620,6 +695,16 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (fw_loaded && ifcs == 1 && !pf->multi_pf.en)
 		pf->unload_fw_on_remove = true;
 
+	/* Only setting magic number when fw is freshly loaded here. NSP
+	 * won't unload fw when heartbeat stops if the magic number is not
+	 * correct. It's used when firmware is preloaded and shouldn't be
+	 * unloaded when driver exits.
+	 */
+	if (err < 0)
+		nfp_nsp_keepalive_stop(pf);
+	else if (fw_loaded && pf->multi_pf.en)
+		writeq(NFP_KEEPALIVE_MAGIC, pf->multi_pf.beat_addr);
+
 	return err < 0 ? err : fw_loaded;
 }
 
@@ -666,6 +751,7 @@ static int nfp_nsp_init(struct pci_dev *pdev, struct nfp_pf *pf)
 	}
 
 	pf->multi_pf.en = pdev->multifunction;
+	pf->multi_pf.id = PCI_FUNC(pdev->devfn);
 	dev_info(&pdev->dev, "%s-PF detected\n", pf->multi_pf.en ? "Multi" : "Single");
 
 	err = nfp_nsp_wait(nsp);
@@ -913,6 +999,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
 err_net_remove:
 	nfp_net_pci_remove(pf);
 err_fw_unload:
+	nfp_nsp_keepalive_stop(pf);
 	kfree(pf->rtbl);
 	nfp_mip_close(pf->mip);
 	if (pf->unload_fw_on_remove)
@@ -952,6 +1039,7 @@ static void __nfp_pci_shutdown(struct pci_dev *pdev, bool unload_fw)
 	nfp_net_pci_remove(pf);
 
 	vfree(pf->dumpspec);
+	nfp_nsp_keepalive_stop(pf);
 	kfree(pf->rtbl);
 	nfp_mip_close(pf->mip);
 	if (unload_fw && pf->unload_fw_on_remove)
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 72ea3b83d313..c58849a332b0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -86,6 +86,10 @@ struct nfp_dumpspec {
  * @num_shared_bufs:	Number of elements in @shared_bufs
  * @multi_pf:		Used in multi-PF setup
  * @multi_pf.en:	True if it's a NIC with multiple PFs
+ * @multi_pf.id:	PF index
+ * @multi_pf.beat_timer:Timer for beat to keepalive
+ * @multi_pf.beat_area:	Pointer to CPP area for beat to keepalive
+ * @multi_pf.beat_addr:	Pointer to mapped beat address used for keepalive
  *
  * Fields which may change after proble are protected by devlink instance lock.
  */
@@ -146,6 +150,10 @@ struct nfp_pf {
 
 	struct {
 		bool en;
+		u8 id;
+		struct timer_list beat_timer;
+		struct nfp_cpp_area *beat_area;
+		u8 __iomem *beat_addr;
 	} multi_pf;
 };
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h
index db94b0bddc92..89a131cffc48 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h
@@ -64,6 +64,10 @@ int nfp_nsp_read_sensors(struct nfp_nsp *state, unsigned int sensor_mask,
 /* MAC Statistics Accumulator */
 #define NFP_RESOURCE_MAC_STATISTICS	"mac.stat"
 
+/* Keepalive */
+#define NFP_KEEPALIVE			"nfp.beat"
+#define NFP_KEEPALIVE_MAGIC		0x6e66702e62656174ULL /* ASCII of "nfp.beat" */
+
 int nfp_resource_table_init(struct nfp_cpp *cpp);
 
 struct nfp_resource *
-- 
2.34.1


