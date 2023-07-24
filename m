Return-Path: <netdev+bounces-20326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B542775F148
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB4B1C20ABE
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671479D7;
	Mon, 24 Jul 2023 09:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63387DF4B
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:51:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::71d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7730C4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P67L3GTkP5uAk7wIKW/wjpXBtvYZe006o96iZ+DC71Itb5vUBnkBDA/7VJOaaCKT0V3PMxNvflt6hx/MMqmnBggEcu8WTY3piWJRlITqlL8FJQlIQGWnCHz0MoE4yKOi2kDLeHw5BcfnFJVQW0ulQdsYmqnPYFPCJyEqq2knv0pI2Fm7KCXUlhRz3WARMC2ICIyqfExvVA+GuOn63iKTTb+Oh8heLaI0Os/pnUig28Gv9dTqLAKnC7ExTNtHnxKFHA+joUZgi0U513zkILGynoucVRWK3T/mcEIvpM2ZM9z2IMhpAQuPwy9yGOQAm4Z5U4ermvyA3zZXIvnuAk5EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVUFfMqVp60K93bqETr9AAhjfji0GkRrh5Ikr8sz7F8=;
 b=Mxj6xBGWaxh/MZA4qcu2bpmZY4XC9aKCNvU9XI+LuyOxeKjKVPkLK6ulvqcF+Nh3cYEatlT86K2uDARLkXee6qmKKsE14ppf0AB+AUPY5UEu+0PWtsppOaAEt7rSu4X4TykvvPX0pc8JhBfwd4ifFVq2QhtsIYLwCDSXhEPH11T1n+t7WGHucLe9crYAvo48naSJY9MH6KbaJqgh8xIg2vw60djDXJ8NcmJLsDdqRBMSG0qSFeX1JMCchylpqLx43DjXCfSuW+y9uVfnPhYsWW8BP361elx19LXIZjlmfxWbPYKTDCOd7Mpy+PjfYB+InqAlFbYRPx04JvKFoB/P1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVUFfMqVp60K93bqETr9AAhjfji0GkRrh5Ikr8sz7F8=;
 b=J37oC+1FGxhhRNcIo8BuwjFUTFhFexnnnSvv5+y5ZUqsEMKcbFI4k7ZtOaMyJUOwYzTCbwOIoSWNRwScQAxSqq3o45adpNp4cnUZaSdZnjrt5VaMFZ5jVDJk7XsSUhBBo3ChU87oWXifVo64VcX1eibSOKqQIPmsGvJv/gdB48A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:19 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:19 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 08/12] nfp: apply one port per PF for multi-PF setup
Date: Mon, 24 Jul 2023 11:48:17 +0200
Message-Id: <20230724094821.14295-9-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: d159dc55-b5a7-4c53-110d-08db8c2b401e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e698Sj3Nx5f+4VBDjEPl03kjN6fILtznxDzEbGLI4/CPOUSLlmQgBADM/d58sFVvYKuBqgLBoGkAElYzmfAO5QQTtlNeM/03xHoigiloRjI5fleeCFxDoyqPHdHWqrhN5ZcPyug3Yo4fM8K4nz6+H7OIzapvKz8Sh8w6UaWEuTC/1ymOJUoMl/PV4BnP+faYXszqmlFdoDiqOCkadYFEPx9OS/H3Uc0FpK1XVqi9EkABmPvdGCV8zxZJcziDm/mmMutlbkTiOOrXR6RLEZI4YHPsuxFO4xWNG6gsxUH669+DybbPSCVPZdWAjdipCdroq2arqZJLJYOr/a1ImPKTP2sOpHm8usWTCRuaSofkgiegjTOER+NWcAkpMes+tQ9vmmPqntA4Xn1NEliyAB6PXFp4IYCmQsIM/3yIQQ6/xV0fKFSgok4A60lDiBWEFtPpgfpZXXdTiwljXMvI3EwIRNlweDmAfoGIDWoomFd+NEdbfw5aykJxeOM7UhbF9e3YMeY2vw6Ayyv9/eXuaSrb3BBG958K9nShmFJxUi0XfHGlamBWdCrRtjFNNOPqDPs2HFgP7VctWyArUhMwhDROh3kBTVnfGsMQEO4nc5c+338jAT4mB7h2sbdUCJRdYEZJi+LOM86FSpxYbXbKjQGxqSmFSU9ymXnwWAJRv2JIpkg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVV4VEFWMXo3MUR1blQ3N2ZjMjh4RDJDKzM0anRWd2EzQkZqV2ZuOFZXVkNZ?=
 =?utf-8?B?cVRnelNJZ3cxTVFFZTNZUy93NTl3dE9sazUwa05zeFpleFFFbzJGdEZwdmxk?=
 =?utf-8?B?MnRmRDI3dVkzdUdoTkdRWStOZGZHa3pBcm5mUUMrQWhYa014YTlEK1ZZdElw?=
 =?utf-8?B?UnFRcmFTQktmc0VIemJpUlRNendrUmVxZHBnc2RLVmdIY3pnMnFpTFZWNEdF?=
 =?utf-8?B?NjRpZTdFZVpQRmhva3hMbkZ3VTZEOUI2ak1QZDdTNFNES2V3Nm5MTjlGMGdJ?=
 =?utf-8?B?S2xvdlR6emtESUtQcjdzc1QrWER0eXo0VGZPbXQ3M2pyamZIUUF3SG11UVU1?=
 =?utf-8?B?ZngvbVcvbW04ak8zT2lLMGo1VDVsOEUxRTBIWUZTeEluZkpWZ0hEYWptRkF1?=
 =?utf-8?B?N1FucXVtN3hPcGgwRjZ5dEVjZDVpUGxSYXU3Y0lvTzB1d2pWRUYxRW4yanVk?=
 =?utf-8?B?Y3BEYUQwM0R3WWJ4TDNmZjloMkp5Nzd0V2Z5QTBqMU1TWXRhTCsvc29UZUxO?=
 =?utf-8?B?bVE2ZjhTRDBIYmp1Wk1NTlFBam1XNC9weC91NS9DanRHeHFVTXpJVTdnQ2o0?=
 =?utf-8?B?eVYxQ2w5TFd0VzFhRG04cGdldmV5QUIzR2w1UE00bjdqT05GL0lydUN6eGtQ?=
 =?utf-8?B?YndHUzk5WHZwRXArbWt4ejAvN2lEcjlGTjdmZ3VqMk5IMk5JUElPVVZJdlcy?=
 =?utf-8?B?WjhEVU1oWXZUZUdUOWNtT3h6eXJyWnIxNzRMZmpBSTlQVVJsdmM5SC9BaFY1?=
 =?utf-8?B?dlNtWGpwdzRxN2hIRStqUUhLZEdKbmRYcTlCTDd0Q2VtZWpSbEUycHNBMWRP?=
 =?utf-8?B?UExSVTA3a1lWV294bXc0S3p2UzZ2MjFDeE5KT1NJbGNjTnRXSzZpcTk5WTBV?=
 =?utf-8?B?V2lQbWpVditlSDRVM0Z4MTRuK0VVc0ZtWEFHd2JsV2xmVmNQSy9QSCtjSTJp?=
 =?utf-8?B?Rk80SGovY1RqN1pVV2hmNmZIVjB1TGErcFVhUlh2K0lBRzZkSU8xQWxoeTNr?=
 =?utf-8?B?VStSbnI2ejlRYzJ5eEQxU3dMekpyNWRGSmpuTWVqcytyMUdITUhZQ25mdFZ0?=
 =?utf-8?B?WTRZUEVvdjNaRGhwSjZlNENCTDgzOVNYRGJlSmZSb2JtWXlkK3Bmb2R5ODFU?=
 =?utf-8?B?RXJyV0VyZmZ3UnVJaVQ4eWJYa21UUW8vd3lkbjJ2aFBxSENyWVh2TXNqamNJ?=
 =?utf-8?B?ODRTOFZiRGVmRHVjSEhrR2U2WUVRSVUwajduempRUWRSaFdXT0RaM24ySTZh?=
 =?utf-8?B?bUl6TFJLd09WMTBja1oyUUdoV2JpdHVqSE1qZUlTYVFWZnllaVNmcTRRbW5r?=
 =?utf-8?B?ZFBPRjFGaDVEb3FKN1hiVkdwRVlEK0Rja2ZFVXJGaVVFQU5NRHFkNno5WHJZ?=
 =?utf-8?B?bEd4SnhMMVVOa01tcGN0NUN6bWFITUExZXVCRGUvc21RYlZ1Q3pwd1NMaVho?=
 =?utf-8?B?eTBjNUJGUDlXUVhHKzVOQ0JZbExVRHV2T1A4UGlSb0kxcW10S3JTcmNZOEJT?=
 =?utf-8?B?ejRPTGI3bUlBRUxxQy9QQWdObU5KRTdOSDlYQnlDK3JMWUQwVUoyN3lzaWlQ?=
 =?utf-8?B?bnczZHBidWUyL0RabG1uVlI3bFE1YmxwQ0hybHQrOEhORnc5RWJmM1NEK0xN?=
 =?utf-8?B?dEFjVnFGUGhkSVVCNk52UVBGZnFEU3h5SmZwOWpQbGNqNytLTHd0RzlGc0tk?=
 =?utf-8?B?Nit4SGh4R3BjNWNGTVc5V1JsVUFXUUliaE82dEY5NEY1amZZeDUwOHNRY05C?=
 =?utf-8?B?WWw4S1dQMzhZa0ZMYVFDSGhQOHE4Y3lqelpGSW45R1VmZXJWaUI5NjBSTFZ0?=
 =?utf-8?B?VkkxTSt6UXJyUTBnNUExRW42MXRYdDR4TW5NWXFvdzFoRk1SOUduWlArL1JF?=
 =?utf-8?B?QzlZTzlLbzhMa05SY2FQeUs2Q2ZUNWlYdU1JTG1PTWtERmhvbGF5cXNlaDhM?=
 =?utf-8?B?NHdOeDhIR2tPZnFYM1liZE9SSkJnTG1xWkpvU3BwaWV2dU1XcXF0SXBCRVI2?=
 =?utf-8?B?eURobFhPelRQam1vQWg2Z3o0YTExVjBMbzA4WkVoaDgrZFJ0dEthVVZPK2Ro?=
 =?utf-8?B?UkNZcEtnOENZVDN3SG1mZHk1V2dYYWNvL0hmZGlrR0hMNmF0NTBRYlE5MVpF?=
 =?utf-8?B?SHNJQ05kQjladDNMMGtXTDg5Umd4NGRPY1cwbTlFYWxmaER5QVh3VEVRZEFE?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d159dc55-b5a7-4c53-110d-08db8c2b401e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:19.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxjBvkfd7bMmXZR9gflIZ42mAnpysfj4aGpnf7RU28j3E6suCNie+QIZ2KeHKvcZtRMgsqdX5hjSkJXM6Ar+MviZ51AsjtU6/RmcEyr9EGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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


