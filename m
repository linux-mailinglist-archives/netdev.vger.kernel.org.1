Return-Path: <netdev+bounces-28110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307F77E3F7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EED1281A8B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3B316400;
	Wed, 16 Aug 2023 14:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90E11CB4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2125.outbound.protection.outlook.com [40.107.223.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED0272C
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUujMTf6po7vXmMFDpdybbNJzdrH5gtWw5x3aJHJdA4KZVFONj8ED8qY6epKoCqfqR8g2vcmWDC59zH7ZXuD4mRPqEocrlJjIApYXOBBYMdxktz1h+ouEQ0ov1cx87wONZABVnOefVZv7kW7mfJByhCvALIh6C8z/ANsuDQUgzbMH1+1XFttX/iFK/Fa9jnHgLl1MawGZrFpurQWNfL10pj5O98xHkfEGB/o1LOiQ0mKMEgwEyJ3xdrj60A5dtdeRsbkNJCwWago+aA2iUiKufIRP2k1mt/i9mPJneEJ+NWePk908ytNwfQwOXM0B9PbzPOfoQNWanzIslPkeB1h7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVUFfMqVp60K93bqETr9AAhjfji0GkRrh5Ikr8sz7F8=;
 b=O7jyOYD9SPQ42KdnwAlJahG6yF6DNiQpK2NzU5H3afQg1qDFM1T5ml55MAclYkY1yDb5cIiUrI2wkO7f28utDFAeUCJpXH/OZKjcyf98eR9JBiz5KKdDe1u+tqWjwYmVTJitmsNXXTxxB0UtkEuNXOELlUbee4RXKnosjMmFv0pdrKEwKlUua/AxW1qbnVJOFeVUWDN+sftka/OU6dE1STVbJmIgsNBe0krgoN4QWqrzzqKikPWb36/fIX8AVxV5p6swi72bfxfc7Wb5LHfv+i2SM96L8iZ+4V/mDtQgml60vKrhfrQduDvebawUD395Yux30bvwoMVbCDxkavrIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVUFfMqVp60K93bqETr9AAhjfji0GkRrh5Ikr8sz7F8=;
 b=Y/1MuXm15KpjEx4WNLlzG8fxf8sPykiVicUfGxrEc3NntSNP3JSqyifZ4bzOjc9LWZXcE7EkRv9uVRzf09+uLrVljT9rUu3xTj9jDfL9zkCMwomL4Mry79+04qDqi3XtGAVgWlM4aGlGTPRYY9yRIo3xomRvfiW2xhJiDeq8eLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5004.namprd13.prod.outlook.com (2603:10b6:510:7b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 14:40:25 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:25 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 09/13] nfp: apply one port per PF for multi-PF setup
Date: Wed, 16 Aug 2023 16:39:08 +0200
Message-Id: <20230816143912.34540-10-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5d305a88-a00e-4dec-7627-08db9e66ba00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/BKW6zQZC9L/FJ+5OSPRIMBIl+7CcHbitrOZv9ONt0wuBQRleHRHFyU67u41FtjiN3MZp/yO9y63ro1PkHEAmE8m1vJjgvZv3xdFERaHvAvaffxbJhH4Cw6IAJxLgbvbd2D7Vy+Kt7ikrohA3okYqz4t/Nts/ZoUHXi1i8EMIrm/y8Do1jD4ELvE1eBrfwX2SODTmpbW0MFjxm3fMd1le2L1K3H7aiBQpHBSCpqnZfPAxB6SZbcXlxsbsnPsAdHRuAf9pN7VMCZxEqByuXErZ3MK2gVzjHcYdo26DguML1QAR8TBZ4SRkWlP4y72yMtZoUTSxSUQxfxeBWgas0bYLM0DV0RkFyqivA/M4P3CS8uA/4sLcM31KbvBekO5hS3xcaCHxH4e8l65JwU7KrLx87XjNEe6NArSCFyi54on9Ebo2/ZeywIQJKf+NLifh1NVWoUtPC9aH3pKC0/rQRE9r0iesDsbYw7RM7C7/e6GnjjHMDVilDPZ695Nnar03MJ5aLfRKKW+2CbfV2T68ephd3wJ2+rEZP1H8rgVjDimBfpekhsqxIHO5cKCZCUtygb3PHl9UzGc2xBjcR/P6xZVvu51y4F4bzjZW3wPoJyNIthieAe7pI3or8vNEvUAuB7+PLzvyAntpg4VSnHFmiN9xDo/2kckOoIo2PHSlwMfcO6s4pro5ZDIHsYHQMsCGfwq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1RpaERNY3VvWERTbHdUblV6S0E3RFdEem0vSEhRQjZvYXFHYXB0VGF0b2lH?=
 =?utf-8?B?N0EvOUUxc3BodnhnSGhUbXgwMkFkVEs2c3JSTjlORjNvbVl3WVNjTFpmNWZS?=
 =?utf-8?B?Z29oZEdtOUxQZHhpK29sWDJucXlLMGRlZ1N0aktIcGVKaUhLbmZsM1VsNmJl?=
 =?utf-8?B?cjI0NTBvYktiTWxIcGg1bnZubkJHSGlPL0FIYmd3dmFBeUFxS0RpTDM5eXhX?=
 =?utf-8?B?dHdpRWRaWlV3WU1DeUs3Q29kbXNaYUpOVmwyUERoaENtenVGWkJlY2owemNF?=
 =?utf-8?B?Ymp1UW9YV09CWFl2TnhZdWN6K3RxNkRKS0VIUm9NN0NIbUdvRWpCQkx1ZlJt?=
 =?utf-8?B?OExFOWlVK3FRbjdyb1J2YitHVE5kT1djM2w0dy9zdzRxdU55RFFwQTVvb1dH?=
 =?utf-8?B?YjUyU2RTVHBURjFDakFLaEdqYWQ5MjVOOVZMck9aQWNla29FMGNHei9objVF?=
 =?utf-8?B?dWtvd3hpVGJaK1hnNFZVVUY0NVd5N0cwZmJkaXRRSGdvWDNPMU05NFNrM1cz?=
 =?utf-8?B?MkpMRmQ2ME5nSnkvWGZOUkpZdCtxb2hXeFZNTEVNODVDdHBuNGJlRGJOeTNC?=
 =?utf-8?B?Zm90SUhyWGtZNWtpRTRXS2pJZWtSQ1R2NklSelA0dTg0L1RrNXozcUpnektr?=
 =?utf-8?B?NktUSEhGY2NON0c1MHNRbFh5ZEFEWWxRajliZFpvRnBhQzNJTG1iTzdKakdC?=
 =?utf-8?B?MWdtaHNtUm1XNWphR0cyWmFXRlV5Sk9DcForS1B5Qnd1bE1wdm01WFd4eGtK?=
 =?utf-8?B?WXlta3EvZVdSSU1lRnpzbXEyMmtUQUVvWlhLb1ZIOHNFMStEM21EMlBFa1hT?=
 =?utf-8?B?bkZmcVUyTzdQTVhmL3U5TmU1ZS9kc1lZT3VkUU4xZm9zYS9CYnZNa1VkVUlp?=
 =?utf-8?B?R1Q3UitLRXVtUnFpUVN4REozdkZ6M251eFVBVWtwSzFZMGg3cEUrWWNHb2VM?=
 =?utf-8?B?SlAxUEhTSms1SUc1RkxJcUkwNnQwVXhzS0VhNDRjengzNWlIMC8xNEVVOTh0?=
 =?utf-8?B?Nmgzb2p2YzUwdEJyL0tnTnRubVdlMkdCaGtZME54NzN4TWNBMDhuOXBGVzBP?=
 =?utf-8?B?Q3FVb2xoYWJSdkp2cjFOTkJJNk1WRjFySU9pSDJoWkFqK3QxVklHOEhJMlE2?=
 =?utf-8?B?c1MxbnNoYUx6T0JCZmgyMlZLeW9FOGFMYlJ5cGpvQTl3NGZHeFMyTnRqL09j?=
 =?utf-8?B?S3krWUR1RTRjZDZoM0xrek5ZR2w1RHF1WmFPa0s2OGp0MU5TUU5udWcyeEYx?=
 =?utf-8?B?QkJmUTBYQ1A1YWNCY0laQTY2OGh5RnJwYXpCNFR1QkFwWEIwUUhuMGRVK3FY?=
 =?utf-8?B?NVlSc2V6VEw3eDBaTStoOTRrR21ybys5UndOa1RkWkM3T0ZHenVEOEwwanVW?=
 =?utf-8?B?MElHTmlRRWlyc2xDWDhvSnNYME5qMHVqbmxVQ291UHllMlZkSG5qaXgwWWxy?=
 =?utf-8?B?cnlzUkE1aE5ob1BqWjNob1J1TFF4enlUVGRpMDJLM0IxOXZ6eTdjTVludlB6?=
 =?utf-8?B?bTU1Sy9uYXJPamxBSFczbVZ1Ujl6Wm8wM2xNNEtkV0xCRHFiTjc2cUFObFlV?=
 =?utf-8?B?Z1BnTmpBY3Rra3Q0d2dTblZyRUNQcURaRUx1bDR2SFhRR2J4SnVQSzJIVFQy?=
 =?utf-8?B?cCtqK1p0dnNkOTdJbURlM2FNMjdwbzdMZHV5Sk1udkNFWnV0RkJFSXp1Rmt6?=
 =?utf-8?B?N3ZnRTdZUlR4dHVObUt2Wm9ieXFZUWxveVZIZGxQQm9LWnk4bHVlVEpka2Ez?=
 =?utf-8?B?TEkrTkdmWERTeWd5Ukk3bnNkb0djcy9FdStxZ1VXd1hHRnp5LzlkbTN1UnBY?=
 =?utf-8?B?bHI4cGRjVVlpUG5tQXlGQUZtMWxwd1oxbnVIdWV6UzhVT0NiU1A4OXRCWXlm?=
 =?utf-8?B?NTViQktDa2ozU1FOSVZmejRSc0F3M3FUM0wyNm5WK2FSYlhiTzk1KytuNXMw?=
 =?utf-8?B?OWRKbWw1MTlUT1REYmhJUCtkak9DZGFHK2hGazZxZmJmYkxGWnEvMUhuL1A1?=
 =?utf-8?B?b0k1V0dBL0pDbEdpWUFoZDBTSmlVRGdKV0ZUaUlyMzhHS281UVZhSE4wTGtu?=
 =?utf-8?B?UDIrVHQvUWw4bTFmZE5mbm5SV3k3cGhwZWdmbWFmV0NITnZvUkZ1Yzd4cFpp?=
 =?utf-8?B?bGpSYjNSVmhIZzFQdi8rUlk5NUpUQkJXVDZpZWFOMFUrUEJTOVBvVk1tNnRj?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d305a88-a00e-4dec-7627-08db9e66ba00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:25.1645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6K6pvfSlmKHTTNgAMUuu7ISI/qBZIj7+sMEIi2Mbk9++182SQFck86IclShmHlFlHxUXg+CN4WCPO0Ug1opMCifAoTyY2KkStpk15jQgxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tianyu Yuan <tianyu.yuan@corigine.com>

Only one port per PF is allowed in multi-PF setup. While eth_table
still carries the total port info, each PF need bind itself with
correct port according to PF id.

Signed-off-by: Tianyu Yuan <tianyu.yuan@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/abm/main.c   |  2 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c   |  2 +-
 .../net/ethernet/netronome/nfp/flower/main.c    | 17 ++++++++++-------
 drivers/net/ethernet/netronome/nfp/nfp_main.h   |  6 ++++++
 .../net/ethernet/netronome/nfp/nfp_net_main.c   | 11 ++++++++---
 drivers/net/ethernet/netronome/nfp/nfp_port.c   |  4 +++-
 drivers/net/ethernet/netronome/nfp/nic/main.c   |  3 ++-
 7 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index 5d3df28c648f..d4acaa15629d 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -451,7 +451,7 @@ static int nfp_abm_init(struct nfp_app *app)
 		nfp_err(pf->cpp, "ABM NIC requires ETH table\n");
 		return -EINVAL;
 	}
-	if (pf->max_data_vnics != pf->eth_tbl->count) {
+	if (pf->max_data_vnics != pf->eth_tbl->count && !pf->multi_pf.en) {
 		nfp_err(pf->cpp, "ETH entries don't match vNICs (%d vs %d)\n",
 			pf->max_data_vnics, pf->eth_tbl->count);
 		return -EINVAL;
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/main.c b/drivers/net/ethernet/netronome/nfp/bpf/main.c
index f469950c7265..3d928dfba114 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/main.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/main.c
@@ -70,7 +70,7 @@ nfp_bpf_vnic_alloc(struct nfp_app *app, struct nfp_net *nn, unsigned int id)
 		nfp_err(pf->cpp, "No ETH table\n");
 		return -EINVAL;
 	}
-	if (pf->max_data_vnics != pf->eth_tbl->count) {
+	if (pf->max_data_vnics != pf->eth_tbl->count && !pf->multi_pf.en) {
 		nfp_err(pf->cpp, "ETH entries don't match vNICs (%d vs %d)\n",
 			pf->max_data_vnics, pf->eth_tbl->count);
 		return -EINVAL;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.c b/drivers/net/ethernet/netronome/nfp/flower/main.c
index 565987f0a595..2e79b6d981de 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -428,10 +428,10 @@ nfp_flower_spawn_vnic_reprs(struct nfp_app *app,
 			goto err_reprs_clean;
 		}
 		if (repr_type == NFP_REPR_TYPE_PF) {
-			port->pf_id = i;
+			port->pf_id = nfp_net_get_id(app->pf, i);
 			port->vnic = priv->nn->dp.ctrl_bar;
 		} else {
-			port->pf_id = 0;
+			port->pf_id = nfp_net_get_id(app->pf, 0);
 			port->vf_id = i;
 			port->vnic =
 				app->pf->vf_cfg_mem + i * NFP_NET_CFG_BAR_SZ;
@@ -496,28 +496,31 @@ nfp_flower_spawn_phy_reprs(struct nfp_app *app, struct nfp_flower_priv *priv)
 	struct nfp_eth_table *eth_tbl = app->pf->eth_tbl;
 	atomic_t *replies = &priv->reify_replies;
 	struct nfp_flower_repr_priv *repr_priv;
+	int err, reify_cnt, phy_reprs_num;
 	struct nfp_repr *nfp_repr;
 	struct sk_buff *ctrl_skb;
 	struct nfp_reprs *reprs;
-	int err, reify_cnt;
 	unsigned int i;
 
 	ctrl_skb = nfp_flower_cmsg_mac_repr_start(app, eth_tbl->count);
 	if (!ctrl_skb)
 		return -ENOMEM;
 
+	phy_reprs_num = app->pf->multi_pf.en ? app->pf->max_data_vnics : eth_tbl->count;
 	reprs = nfp_reprs_alloc(eth_tbl->max_index + 1);
 	if (!reprs) {
 		err = -ENOMEM;
 		goto err_free_ctrl_skb;
 	}
 
-	for (i = 0; i < eth_tbl->count; i++) {
-		unsigned int phys_port = eth_tbl->ports[i].index;
+	for (i = 0; i < phy_reprs_num; i++) {
+		int idx = nfp_net_get_id(app->pf, i);
 		struct net_device *repr;
+		unsigned int phys_port;
 		struct nfp_port *port;
 		u32 cmsg_port_id;
 
+		phys_port = eth_tbl->ports[idx].index;
 		repr = nfp_repr_alloc(app);
 		if (!repr) {
 			err = -ENOMEM;
@@ -542,7 +545,7 @@ nfp_flower_spawn_phy_reprs(struct nfp_app *app, struct nfp_flower_priv *priv)
 			nfp_repr_free(repr);
 			goto err_reprs_clean;
 		}
-		err = nfp_port_init_phy_port(app->pf, app, port, i);
+		err = nfp_port_init_phy_port(app->pf, app, port, idx);
 		if (err) {
 			kfree(repr_priv);
 			nfp_port_free(port);
@@ -609,7 +612,7 @@ nfp_flower_spawn_phy_reprs(struct nfp_app *app, struct nfp_flower_priv *priv)
 static int nfp_flower_vnic_alloc(struct nfp_app *app, struct nfp_net *nn,
 				 unsigned int id)
 {
-	if (id > 0) {
+	if (id > 0 && !app->pf->multi_pf.en) {
 		nfp_warn(app->cpp, "FlowerNIC doesn't support more than one data vNIC\n");
 		goto err_invalid_port;
 	}
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 7f76c718fef8..4f6763ca1c92 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -210,4 +210,10 @@ unsigned int nfp_net_lr2speed(unsigned int linkrate);
 unsigned int nfp_net_speed2lr(unsigned int speed);
 
 u8 nfp_get_pf_id(struct nfp_pf *pf);
+
+static inline unsigned int nfp_net_get_id(const struct nfp_pf *pf, unsigned int id)
+{
+	return pf->multi_pf.en ? pf->multi_pf.id : id;
+}
+
 #endif /* NFP_MAIN_H */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index cbe4972ba104..98e155d79eb8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -141,7 +141,7 @@ nfp_net_pf_init_vnic(struct nfp_pf *pf, struct nfp_net *nn, unsigned int id)
 {
 	int err;
 
-	nn->id = id;
+	nn->id = nfp_net_get_id(pf, id);
 
 	if (nn->port) {
 		err = nfp_devlink_port_register(pf->app, nn->port);
@@ -183,8 +183,8 @@ nfp_net_pf_alloc_vnics(struct nfp_pf *pf, void __iomem *ctrl_bar,
 	int err;
 
 	for (i = 0; i < pf->max_data_vnics; i++) {
-		nn = nfp_net_pf_alloc_vnic(pf, true, ctrl_bar, qc_bar,
-					   stride, i);
+		nn = nfp_net_pf_alloc_vnic(pf, true, ctrl_bar, qc_bar, stride,
+					   nfp_net_get_id(pf, i));
 		if (IS_ERR(nn)) {
 			err = PTR_ERR(nn);
 			goto err_free_prev;
@@ -707,6 +707,11 @@ int nfp_net_pci_probe(struct nfp_pf *pf)
 	if ((int)pf->max_data_vnics < 0)
 		return pf->max_data_vnics;
 
+	if (pf->multi_pf.en && pf->max_data_vnics != 1) {
+		nfp_err(pf->cpp, "Only one data_vnic per PF is supported in multiple PF setup.\n");
+		return -EINVAL;
+	}
+
 	err = nfp_net_pci_map_mem(pf);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_port.c b/drivers/net/ethernet/netronome/nfp/nfp_port.c
index 54640bcb70fb..c1612a464b5d 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_port.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_port.c
@@ -189,7 +189,9 @@ int nfp_port_init_phy_port(struct nfp_pf *pf, struct nfp_app *app,
 
 	port->eth_port = &pf->eth_tbl->ports[id];
 	port->eth_id = pf->eth_tbl->ports[id].index;
-	port->netdev->dev_port = id;
+	if (!pf->multi_pf.en)
+		port->netdev->dev_port = id;
+
 	if (pf->mac_stats_mem)
 		port->eth_stats =
 			pf->mac_stats_mem + port->eth_id * NFP_MAC_STATS_SIZE;
diff --git a/drivers/net/ethernet/netronome/nfp/nic/main.c b/drivers/net/ethernet/netronome/nfp/nic/main.c
index 9dd5afe37f6e..e7a2d01bcbff 100644
--- a/drivers/net/ethernet/netronome/nfp/nic/main.c
+++ b/drivers/net/ethernet/netronome/nfp/nic/main.c
@@ -12,7 +12,8 @@ static int nfp_nic_init(struct nfp_app *app)
 {
 	struct nfp_pf *pf = app->pf;
 
-	if (pf->eth_tbl && pf->max_data_vnics != pf->eth_tbl->count) {
+	if (pf->eth_tbl && pf->max_data_vnics != pf->eth_tbl->count &&
+	    !pf->multi_pf.en) {
 		nfp_err(pf->cpp, "ETH entries don't match vNICs (%d vs %d)\n",
 			pf->max_data_vnics, pf->eth_tbl->count);
 		return -EINVAL;
-- 
2.34.1


