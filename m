Return-Path: <netdev+bounces-20325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76175F133
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BD3281436
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4EDDA3;
	Mon, 24 Jul 2023 09:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F719DF4B
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577C30E1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at3ZOR3UzeYjY03ZwRK7wy4jove9kNYYygwFUYee3LvL4chlHycTxEg/GCg0UVG3Kvx3ocRr31JWI12PiGXiLpSd3wKRaym6lisWAhVgF9M761UbAFYev06OCvS68A5aLxib2dwoF9+FzuKzA2fMBKl1mRRXMfeSAvCRYOC3NFTz2CTPWiRzfCKUEB8Sn++VzkaK5hWwTDvLXI4g1+pOn5n4tSzyw+o+FoT6eMlPrQfTyoEuQ0kCQq9IdfQeKZ+IfwP++kubPCSpfvXZCReBwIt3q4sJR1911X5PMgRKCge1JqECaebP1Y20NeCZV5UihEUqEewt2TmFelMsa7aJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBD580DaiUnSfTUN87A8oZ7d1leIQpq4MQYDC0Ch+CU=;
 b=W63ZnyhAWPYJvQDI2ZckfhANmgPYxnDfsxtmE6TMckp6uMA/i/0gLbHlDMQhEAHvDtvsBkTA71gCysBF1ksIjm8WtIUUtsFma56yD8kepzgeFZywXmRzJfR8u0X61PpNuH2G1w7DwNivon67iOAenkY4Z07SnPg6KCycw8mjIY1hrxVV2MpYgqyfQVUV4HgyRpizlfJQv3MH3yDF8oq3QwVm7d6bZ2iqJHtgQ3wW5yqsIZopxVi2TQoqezMEBZxNKuvTxF6w1LB4uU0vwayBDcTVcb86kZkE3AE2bH5d78csi5X2sFA/ksn+T+anS3wTyuvjkvLPR66ytlwnAodvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBD580DaiUnSfTUN87A8oZ7d1leIQpq4MQYDC0Ch+CU=;
 b=sEFYFNixFcga/gZkO02P2wWse3+xlGCM5UVJjTEldrT3oOJK8iejj9jwIna8r7GgsbzvGbE20qJpzi6KQ/+/YT2jfXWR0BsNSBamzQ5evaQwmKARFuA5LGuTybUnAifLxOG9vYSZ+kqVyicCGfngcJ2+caF8NBfOxNw3WNg+x7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:15 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:15 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 07/12] nfp: redefine PF id used to format symbols
Date: Mon, 24 Jul 2023 11:48:16 +0200
Message-Id: <20230724094821.14295-8-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1266545c-e27e-4837-e445-08db8c2b3e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/h2bcB0If6pBrNTMXrzXErejL2v0wq2bgEEkp2LMJHkOMJs/7h/adElU2cFsHgXuO7gppSkzgEVJ5g8JGpO0uE9RQz93jivVY3MoNxU8vTaQXmKQ/P9tX4CF9VciZqU+O9jZnToeZ0D3bGuj8TrZCq1wPQsLzaa437d/LNCXWn0THGIhdPKJlZzDNEVd6QWQnaf235nICjBoJjM//APZlJVazJrk8TDUaki70l4Ea9dpYNUCcKa7GfkO8n9ztmjQf//7FK9YFp97X/ncB4RxLOevB19f00EOURUkkqpeepP/H5+zjAfGwWyQUsphq6y3yOfldlyaqprT1T8NbzYz4YBeGwO0KecTkytgDGEB0YoCAFUeQlWfiaYBzWp/zENom1aGkY7z1zg7M7RvdrFk7/EmYP+5KkM7SwG88YR+edxUYrGEpce7CZgI3IwoIMjN81nfIAXEVkowFOdrmQsTf5+eGcTtiFrQJd6Lxjel/2fUF8axTH0t9Nf8dS/2p8PF/tLzJ9HjCcvwtcqZVBvRmyz99Y3pYzwt1OIGzCpSOqPCuIeH82IXVAlnjfBMAJhItfxEmsHpcVO6evg49PMfNPUQUkml/VjeW54k7azGZ3Oj4wBVxsIF4m0P/K54+4+Lp9ZnGdQ9u/IrIMK46bjoQPgyUlOGdswVu+u7nUyTLV0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjJmTjFoa3I2WUJKaFZSU0RKejZFd2hQN3E0WC9mT2psbGVzYzlKVS9GaVFl?=
 =?utf-8?B?OTJIcjRoZm92QjV6WW5zcCtNQkR2dWVDK2FXNUxlQ2NkSVIzQ1RHbkZQZzRC?=
 =?utf-8?B?QU9wZkwvZkY1NHpibTh5am9ENWhFT1BnYVZVaGphMUpkVmN5OW5ZWVV5MjdS?=
 =?utf-8?B?dWRwdG5CZnFmMUFoUW9KRGhLMmVHUEgrWWJPaThaZE1md0JJQjBsWGF5ZnFD?=
 =?utf-8?B?RmEwV2U0Mlp2UWRoSG5MMHRGQlI2TGxOSGRTMUs0UlVGUWZGM2hBVXg4RkFi?=
 =?utf-8?B?UzVkc3BGazZOZXp0RVZyMWR1RXFTaS9scU0rTkM1eGZiQlZjYU5zM3BpNk5o?=
 =?utf-8?B?Y0dkck1SVnpwZnh0Z1hYdWh1d3hubFdCZnNNUDdXODFISWYveEtXRktjWE5G?=
 =?utf-8?B?d2k3eUpWZzRxNSt5TlBIRmh1R0NTY0ZVdGtBSDMwZ2R5MFcwOTJGbURQWUFw?=
 =?utf-8?B?bStxRjhtSDBmd2RtWGxvU0tKdDhvS2NTandxbVo1Nmt1aDRQek1vL2t1ME9J?=
 =?utf-8?B?T2xkSnVzWHRiOGRXdmtVblV6dVhIbjZMTUhwME84MUYySmJMTzU3TDQraG9t?=
 =?utf-8?B?Z0FRNGZGZm5zVHJjSjUyaStqUEtLRjFUSkFqbllLTVRoaHhOZTFoNDhwUEFj?=
 =?utf-8?B?NDQrZ1oyN0xjMEFWTDJ0TXErNnhqNzk3cjB5UHJyUEFadUgwVkZkU2J3SGlN?=
 =?utf-8?B?ZmhsejZGU0pFeUt4Z3VXaFlPN3kxWTFGL0Y2THVCS2ZQa1BTM0dsb3VybE9W?=
 =?utf-8?B?eTdhN2xFN2NrUGdEYVFieER1V2dycE9keEhTUFIwTmMvRmdMUEcxbDJjbVEr?=
 =?utf-8?B?TU1NdGl2MEFCaXJyQVdlTkdHV2JSUzJXeDQ3ZE5LU1hNQ08vTFhlMGYvbGR0?=
 =?utf-8?B?SDdrTWJNKzFnSHQ2UkxYOGVjbWxXRmVDUms2UlpjZ1dlZGFEdm5tUko1eUhY?=
 =?utf-8?B?NXZKZmZlRytCVnRtcW1qSjdGa1VGK3U3a0tBbm9MeHJvMEdqWG1DYnB6ZEd3?=
 =?utf-8?B?WnE1Y1RPcFd0akFTbHpNREZuTU9uUFdWZTByTy9lWUdqZGd0d3FmdFlmcjhC?=
 =?utf-8?B?WCs2K28yWnZhUkNvUEhwRVpCYzl4T2ZNSzRFeGxJR0lPS0RUcS9aODN2N0l1?=
 =?utf-8?B?MkJrd3Z2bDNoQ0xNZ3Y3ZXgwNTFIcDUyVWhyREtnL2plTDRwNmdEMW1nSGVa?=
 =?utf-8?B?NlhiSnRNRHBPNVhmZTVhUTM1MW0wMUxEZnJtQlRQNzVrZ2pvTFc1Vm5rbkFk?=
 =?utf-8?B?b29mMlhMWmZtS1lDUDlDYis4ZXIwWU5YYkgrQys5NWl2VFZJQm8vVDl6Tnlq?=
 =?utf-8?B?MzFsSW40THZ3aFNHbUU2aVR1L0Z6U0taUGljZjJGRlZiLzk1dmd4RVhGSU0v?=
 =?utf-8?B?bmE4Q3lCWU14RHc2RWNFaGozOFU3dEpGeFZGTFpSSkRDTERYZXRNRmVxS2ZD?=
 =?utf-8?B?L0JtaUNVclByNHpvV0tackZCNWFuZDJGTFVLV1BOV09nVS80TjhWbVdJdGk1?=
 =?utf-8?B?ZWNEbi9yUkZ0NXJyYXFYMERtWUxjSHpLd29CRXMwcHYwV21lVmhiZGV0UGRZ?=
 =?utf-8?B?RGxVbGVnRkFZY0tKak5relp0VmljSTNRc0RBUzEzZlMwZlZEMmw4dTJzMkFB?=
 =?utf-8?B?VnZsZURxc3Vicmh3LzB4V1BzN2kyYmkybUUxc0EvYjdGLy8ySTEwUjA2OUcw?=
 =?utf-8?B?NUdqTWVYUTBvRTh5K0FZbFlzY0ZERS95Z1FYVE1BVmhFTmJBTC9UL2dnaFVl?=
 =?utf-8?B?NlArY3N0L2V0eUlld0J5enFpc2k2M01YcDBPbkM5dHlQYXExRXRUNFl0anBw?=
 =?utf-8?B?WkdZUUhZRENQSVpmVXFCOC9pclRDTjNEblk2UHRmUGE2V0hlWHU0bnk5SG1Y?=
 =?utf-8?B?d3hYSGpRLytnbkFuUkhUdUFjMm9UN3dDOVMySlNuU0FGZGc5VWNqbUVJUmVt?=
 =?utf-8?B?bG1OeHprTGlIR2YvNk1CNVRmOFd0SWtFS3ZSbWlJaUZ1L2FCb1BObEV2WkRy?=
 =?utf-8?B?SXhDQ2Q2QjIyL3l1b2dacWxpdk9PdTRjTzcyUGRYZmE3VEIyZFgyWk0rSTVJ?=
 =?utf-8?B?RUtPV0F4eWNjVHJ1R01COHl0UTVMUDZ2NDVVWDJkYXZpSnFDYlNkSzAwOWdD?=
 =?utf-8?B?R3BuK2dQRjhLOFZFVWc2c2J4Mmc1NHpRdzhCVTZHYXYrMjFhL1RHbmRwd3ZU?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1266545c-e27e-4837-e445-08db8c2b3e00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:15.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EKZ+6sfAQlZ8c0q7lF9eM7suF7Z5CakvjedqjRYLQh57rPvDhQaLMLlYqXNasVOLk8IZVusWBx5sne1xNkWapGe49JvF97O5yHzkFXPeTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

Taking account that NFP3800 supports 4 physical functions per
controller, now recalculate PF id to be used to format symbols
to communicate with application firmware.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/abm/ctrl.c  |  2 +-
 .../net/ethernet/netronome/nfp/flower/main.c   |  2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c  | 18 +++++++++++-------
 drivers/net/ethernet/netronome/nfp/nfp_main.h  |  2 ++
 .../ethernet/netronome/nfp/nfpcore/nfp_dev.c   |  2 ++
 .../ethernet/netronome/nfp/nfpcore/nfp_dev.h   |  1 +
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/ctrl.c b/drivers/net/ethernet/netronome/nfp/abm/ctrl.c
index 69e84ff7f2e5..41d18df97c85 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/ctrl.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/ctrl.c
@@ -362,7 +362,7 @@ int nfp_abm_ctrl_find_addrs(struct nfp_abm *abm)
 	const struct nfp_rtsym *sym;
 	int res;
 
-	abm->pf_id = nfp_cppcore_pcie_unit(pf->cpp);
+	abm->pf_id = nfp_get_pf_id(pf);
 
 	/* Check if Qdisc offloads are supported */
 	res = nfp_pf_rtsym_read_optional(pf, NFP_RED_SUPPORT_SYM_NAME, 1);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.c b/drivers/net/ethernet/netronome/nfp/flower/main.c
index 83eaa5ae3cd4..565987f0a595 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -378,10 +378,10 @@ nfp_flower_spawn_vnic_reprs(struct nfp_app *app,
 			    enum nfp_flower_cmsg_port_vnic_type vnic_type,
 			    enum nfp_repr_type repr_type, unsigned int cnt)
 {
-	u8 nfp_pcie = nfp_cppcore_pcie_unit(app->pf->cpp);
 	struct nfp_flower_priv *priv = app->priv;
 	atomic_t *replies = &priv->reify_replies;
 	struct nfp_flower_repr_priv *repr_priv;
+	u8 nfp_pcie = nfp_get_pf_id(app->pf);
 	enum nfp_port_type port_type;
 	struct nfp_repr *nfp_repr;
 	struct nfp_reprs *reprs;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 489113c53596..74767729e542 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -69,6 +69,13 @@ static const struct pci_device_id nfp_pci_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, nfp_pci_device_ids);
 
+u8 nfp_get_pf_id(struct nfp_pf *pf)
+{
+	return nfp_cppcore_pcie_unit(pf->cpp) *
+	       pf->dev_info->pf_num_per_unit +
+	       pf->multi_pf.id;
+}
+
 int nfp_pf_rtsym_read_optional(struct nfp_pf *pf, const char *format,
 			       unsigned int default_val)
 {
@@ -76,7 +83,7 @@ int nfp_pf_rtsym_read_optional(struct nfp_pf *pf, const char *format,
 	int err = 0;
 	u64 val;
 
-	snprintf(name, sizeof(name), format, nfp_cppcore_pcie_unit(pf->cpp));
+	snprintf(name, sizeof(name), format, nfp_get_pf_id(pf));
 
 	val = nfp_rtsym_read_le(pf->rtbl, name, &err);
 	if (err) {
@@ -95,8 +102,7 @@ nfp_pf_map_rtsym(struct nfp_pf *pf, const char *name, const char *sym_fmt,
 {
 	char pf_symbol[256];
 
-	snprintf(pf_symbol, sizeof(pf_symbol), sym_fmt,
-		 nfp_cppcore_pcie_unit(pf->cpp));
+	snprintf(pf_symbol, sizeof(pf_symbol), sym_fmt, nfp_get_pf_id(pf));
 
 	return nfp_rtsym_map(pf->rtbl, pf_symbol, name, min_size, area);
 }
@@ -803,10 +809,8 @@ static void nfp_fw_unload(struct nfp_pf *pf)
 
 static int nfp_pf_find_rtsyms(struct nfp_pf *pf)
 {
+	unsigned int pf_id = nfp_get_pf_id(pf);
 	char pf_symbol[256];
-	unsigned int pf_id;
-
-	pf_id = nfp_cppcore_pcie_unit(pf->cpp);
 
 	/* Optional per-PCI PF mailbox */
 	snprintf(pf_symbol, sizeof(pf_symbol), NFP_MBOX_SYM_NAME, pf_id);
@@ -832,7 +836,7 @@ static u64 nfp_net_pf_get_app_cap(struct nfp_pf *pf)
 	int err = 0;
 	u64 val;
 
-	snprintf(name, sizeof(name), "_pf%u_net_app_cap", nfp_cppcore_pcie_unit(pf->cpp));
+	snprintf(name, sizeof(name), "_pf%u_net_app_cap", nfp_get_pf_id(pf));
 
 	val = nfp_rtsym_read_le(pf->rtbl, name, &err);
 	if (err) {
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index c58849a332b0..7f76c718fef8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -208,4 +208,6 @@ void nfp_devlink_params_unregister(struct nfp_pf *pf);
 
 unsigned int nfp_net_lr2speed(unsigned int linkrate);
 unsigned int nfp_net_speed2lr(unsigned int speed);
+
+u8 nfp_get_pf_id(struct nfp_pf *pf);
 #endif /* NFP_MAIN_H */
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.c
index 0725b51c2a95..8a7c5de0de77 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.c
@@ -19,6 +19,7 @@ const struct nfp_dev_info nfp_dev_info[NFP_DEV_CNT] = {
 		.pcie_cfg_expbar_offset	= 0x0a00,
 		.pcie_expl_offset	= 0xd000,
 		.qc_area_sz		= 0x100000,
+		.pf_num_per_unit	= 4,
 	},
 	[NFP_DEV_NFP3800_VF] = {
 		.dma_mask		= DMA_BIT_MASK(48),
@@ -38,6 +39,7 @@ const struct nfp_dev_info nfp_dev_info[NFP_DEV_CNT] = {
 		.pcie_cfg_expbar_offset	= 0x0400,
 		.pcie_expl_offset	= 0x1000,
 		.qc_area_sz		= 0x80000,
+		.pf_num_per_unit	= 1,
 	},
 	[NFP_DEV_NFP6000_VF] = {
 		.dma_mask		= DMA_BIT_MASK(40),
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.h
index e4d38178de0f..d948c9c4a09a 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_dev.h
@@ -35,6 +35,7 @@ struct nfp_dev_info {
 	u32 pcie_cfg_expbar_offset;
 	u32 pcie_expl_offset;
 	u32 qc_area_sz;
+	u8 pf_num_per_unit;
 };
 
 extern const struct nfp_dev_info nfp_dev_info[NFP_DEV_CNT];
-- 
2.34.1


