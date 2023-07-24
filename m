Return-Path: <netdev+bounces-20324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D920675F12C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160271C20AB1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204BDDCF;
	Mon, 24 Jul 2023 09:50:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7EDDA3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FA524B
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecddcKqQMO8pD5W0FzwLx9/xGUskgCm1A+2IqGuB8XJES0hX1qKpVnWOW4wZyyMhHF/oYxFTLqA+M16WYVAosPW45zBksIr3Q2IKrzrQaON/Tdc4IHSHCwrs4Ab4fbB4jThQHhSUQs/cQRNch04B9zW9203tMfxVwRe9x4SXw84PnTuw26SMQ8/whTsDsCVsyg71n4llmdiONnWds0VZQ9P8cUOoM+bkaIeiVMk3/0MmMkKZAxen7X7Ps+CovU4U0UVAdO0NlobDdgMxHHssxoNEyDHV0OmR70gil5PPRorETvkGDte2uixHiuKgUQceJrw2DRqBEDZzedLx7AuqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBaCd1M8cGniBmbrxUKvcUgFyV0fqOdb+LDNHqazl/w=;
 b=ZsyiphrVYmHKHwpjabLFnAnyjaSmiPiRKB6rFTrfie8I3WalBQzFLc6pHOUFs89gQKB7eKE9UP9WIV2C6bDrGtk3zgIXrkhZ7ISUTyIVU4BGK3I3SKZqBgfrsCoOqYxRNN4fkrfvTD1IUqbZwky8tol3meQzOyK4Mq4SycZV5GGDbwerh6krPre/Dauniy8Lf27msiLWrvgGRnK1ayRsI3GiFwjTaRdO0HvhNwQd8+1tVkqkSYUaFWbmnUt1kZuCcNvin6EUMb456CuU2HiEvIkwi0AI0oMC4ntTfmZLiS4pFUNYNShO7HHPAl2g3G33X6HLPx1g//WF7d0hTb2Kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBaCd1M8cGniBmbrxUKvcUgFyV0fqOdb+LDNHqazl/w=;
 b=iajXpYhqhdlvtAQP5avlf3G7CKBhGP/cFPJYa1e0vlAB4RRCj7ab2/MgBiTWXccVRbEV3lqUHzvmq2CoCJWQ8CsJVE7pgPRllVi75J8VHefz8M5WrgT+maDa6gSGSWoariISiHXnEp0lG0qdnwnYKa1XLw2u19bJxVga/CCppbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:12 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:12 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 06/12] nfp: avoid reclaiming resource mutex by mistake
Date: Mon, 24 Jul 2023 11:48:15 +0200
Message-Id: <20230724094821.14295-7-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3cc9b96a-b9ea-4e7a-8e88-08db8c2b3bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tP8H2o5oSA4dsiLN94Qsxv1Nq6XVuzOQoY6fAGkCvjai7hXHg0Yi4pSSf1TIq/TRbu4uyuXKKSqS1R+mSYS6JTRQErmmicJXgSYSskaRGDhBvk0EuhiXz2mBsvIMiJ476YWBzCV/l8aFfbLMPa2kcy/tLB9sa0Kka7gXOAwjoI79zRTQvTWymg0SOYzJYgqAU02vlGrSCVR38HWOcQEPW8qAvQ8mVyC3NWsZilUkL+g58M2UAAFo/RB3gNMv9JAfhNJhJf9ZwutM4T7a5nEJZcEo9Vnhb5s3Uc9WkHbqsUFCwPdIvFC6+0EtnfK5o7vx5sU4K6WZZqSbTqOnBjcpE+jduWv5tMUaTwcTQUAKF6bt4o0IpJtmsMYFMW/8/x6Y//hh6Af+GFQkvmaHxdadfWNgGi/0k000jX98tZYcRbdQI6F+fcC3UBnVuL6LKvctGynJx51nyBQ/L32xjR88IDos89zx/OuLe4aJZW8brcDoWe61ftTIHEw1OhJn5o34l341i/sm9IBrMpfbOCHaEFwjlCZCLwCiHoOyjW4NeqPLoXZckkzgcF5WVp/oNL/mYzjwbFDegyZY2c4je9s9xvtL34d7oTBavRZK47QhIdCzKN6hf2Q1xenBzCiHap7zRhenBB4wnWYQ0qPo5790Jy6XJO3GE/vTCuTf2T71Zjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkhxZmtMRXFHaHFvUWFIdXI5aFJNTVpaNTBhRGZqd2ZLQUhGaVpvQktSSDA4?=
 =?utf-8?B?UHA2MUJVV2lOdWdFUUlvd1poODEzODBrbW5wazVmclN1Q3pxREFqT2w1N1ZM?=
 =?utf-8?B?RGtGdkFobm9KMnEzVUhYWkdrV2NEbG1UWjBxQzNNdGtab1daTDRlT1N6RzJJ?=
 =?utf-8?B?SHd1RFRON3ErV090Z3VkbWttZkFXem5XanJkSVFIVHlxeG9SVDVOTjBVTlZX?=
 =?utf-8?B?aUE4d0xKRHVGQ1JjUTIwczN0OHQ5QjVxZE9kT1Uyakx1SzBrVms5dFBMSGVq?=
 =?utf-8?B?Nno0T1QyeXdDSmpoamtlS25VZW9CY1UvNjJ2QXhnWTdNOEptaUwzRjFDUzZK?=
 =?utf-8?B?YVNlcTVYZC82UzQ4SkhDMVZxN1VLQWhxU3VDNThISWJoT2d1MmdmYnJEY3N6?=
 =?utf-8?B?SzlSZ0xBTmV2SU1PemFSVXJ5dUxMeWo0ekhkdXQzaENGdm44TFJxNm01NXI0?=
 =?utf-8?B?K29XK1pLejJLZERoL0w4RXk3aURjekNlMTVQN0lYbnNZY2ZyZ2hmVk41RUVQ?=
 =?utf-8?B?TlhsYm82U1hTelRCWVZTWENTNi85WTZnVTgzSWxGRi9Sb1FXdEFsZEw1ZjNU?=
 =?utf-8?B?dE5pY0lwcGtKUVhJQnhvZTdTTThhQWtlV2JIOWpnSUxVR3JhQU9tTGlObENl?=
 =?utf-8?B?QUQreXZUNS9hbzhvdXRkeDJRNG0vVCtZbTl5VG5ubDJkVC9ERkhrSkkwZ0RP?=
 =?utf-8?B?RTFVM0ZaVXlrdEEyUjllamozd2lkVmtpS1BaQ0lUeHJVVWNPN25oVEdZVVVO?=
 =?utf-8?B?UlkzeVlrb2l5WDFoUmtjQjE0QTN2T28xS043bS9KaGg2N0NRVnpVb29ldDdp?=
 =?utf-8?B?TVppQmgxS1FiWVVPMHdzSm93bjl2L2tuMUtsYnV3MHRxNmpibGlmRXBQdlRK?=
 =?utf-8?B?VHRqb2ZiYXpnVjArVktBbXR5Q0pwK2M4N1V5REYwZ0lJclNZRUcyZTBsT0d0?=
 =?utf-8?B?TU4rUFNIZ1dxUUFEa0lqelE3T1I5eEgzWE1aenhsZWsxWmwwMmNZTnlCd25k?=
 =?utf-8?B?SWpYZWhwZFJjenFLUTl4Qy9NdE9CdXVYbGFZSXNRVERpTlNjSDhqTVFML1FX?=
 =?utf-8?B?dkpuRSsrRjMzV1IzeUk5NTB2UU02WnRCVHkzVEZnN1ZtWHNtcndCbFYzZ0xM?=
 =?utf-8?B?ekVJNklUenBRUW5CRjdYWGh1WWlVV2tuekNPb0gzMmhhS1F6UndNdzhHajV2?=
 =?utf-8?B?SUlFanhrL2V5M21FeVE4RnpXVkNYSGk5NE5uZ2RXR1hVQWhtRXptWVdYZ3NT?=
 =?utf-8?B?UXBJWmhtb3BWYnRic055bjlVTC9idDR3WXJsbVhnYmlmbzVFNkk2bnFwRzB0?=
 =?utf-8?B?MkRjRmtIb2Z5bzVmU3JydjVoQUpqR2R0R3hJRGxTVHFyS1NqQ21pOXhrMm5T?=
 =?utf-8?B?c3RCZ0dIb1l1TmNZZmdNN3NRckJxWEt3TFAva1ZiOVYrWkxlSEJCOWpBbmYw?=
 =?utf-8?B?ellmVEdXUFRWZXJLRFhCQ2ZDNVZ2cytKZy9hRlhVSGhmSnhBdG1LV215eVlE?=
 =?utf-8?B?RFlQOTYwcXd2TElCOUNSR2l2NmQrL21WSGRqV1diaHBqR3dvNlQ0Vm9ROE1S?=
 =?utf-8?B?clJsNEVFSC9mZThkUFUvWHdUTWo0aEx6YSttTmx3SlBDTFFFQURqZHp0MWgv?=
 =?utf-8?B?cGRaeks2ZEZRT3lMbFhwZUlnT0JkOFpVWjI0MmRPVTRMQzdEZmNONWhRbm85?=
 =?utf-8?B?TWxPcFhpTS83bWQxRGlnblZ1VnZVdmlrNUJMMDF6TWJPeStWUEtyMTZXUWJL?=
 =?utf-8?B?SWdYSytOS2tSYUVLTHB1dVVjV1ZLR0hkWFMzMUhob0NlK24wYUNsa1hKTDY2?=
 =?utf-8?B?UFlrMXJWOEFkQzVBOVhGcFljb2YrWmNSYWt3NmhlbTdlWCtGRHhsT2dzUzdN?=
 =?utf-8?B?aXNEMzlKWkZBWGZ2WWtpcHJuK2JueUhaWmQxczNxNkZwRWVhMndjMzJINFJk?=
 =?utf-8?B?c3cySm9VS1NCQzUvR1ZaUUo2eUUySlJOcTgzbUdHcTRyQkRvT1lWWWwxeXNF?=
 =?utf-8?B?T2NWQjdoSWJCc1N0a3hYbGZzVUd4Z0NmT2RGem4rTGFPcE1WbWJQRXM4Z3l4?=
 =?utf-8?B?ZkplZm9jM2ZUUWp3aTE0dkN5UUYrQ0FGKzVvcWdyU0xWRVdoMGY1VlNZVisv?=
 =?utf-8?B?T1YwWC9DdUZjQWt2STA1bFFSZmYvQVkyNGlET3o5K1Y4Zm9wbVNGUi8zMEp5?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc9b96a-b9ea-4e7a-8e88-08db8c2b3bfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:12.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyUQfQBtzQmw+TiQ45zGVm63SrGdoGt+/FFSu4byZRmJQEpP/XOH314tXheuM/GN4E9XKi/Pj7k6Di1tM9jkX8vLR8uR2oOTFfk9ea8CESI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


