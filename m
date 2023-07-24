Return-Path: <netdev+bounces-20320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7D75F0FE
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F07280E3B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB129D313;
	Mon, 24 Jul 2023 09:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DFD308
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDC10F0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXtqH3+J9ARcC+rcozfelrpSYyyNifyP0qd31mx+yxIP74wO2amqWQE7CiQEYOzUa1Lx2tCFxJ3jKgGIijqhCr6DCp2auRgDNGEOO/ZTr7PvAwuiy2OInT/3yuC6Q8pdQ2yNabdGwvU4IPS+pp1zIOQ3E/UIJOuEfG03FbIheaejeu5DR6ILhxZzoTvsT/iXeXquzPJlKfkQT+eDJVMAe5eUXVJoqjw1ZESDdmVISM2A5d+pupfPZlPLl44a1beLa8a4hE2o5mzUEtecfxVsaFV8u6gn8IaHdxZ+QvmHgcTA7Iojqln0s3duYQ9hRH/FCUzUkMkws+hU3tudqqA2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hky2hlzBaIrna72eQV+HsK0TOoTlRixOijN6JZRYRs4=;
 b=G/g3TKIwJlubsYBxr0Y4ZqVbmoc4xCXDy/dNG+Qa1CeT3tvAGPz2SJYCsz4+hjKcQ95ZRJiJoYJ10kynhQ0qrcLStgx72jhkAGRouIsQAY5J5Jd2xRt8YqF+xnpiFIkwMPx972uOUM+4/N6Tse8yw/yd8+t1cUZzE+/IehdH3y0EifblbyJfF2LGmB93f3ylHbvUk0v2NGIlH78ye7dJibcyyq6h0CZs+VF8cLxW9QMSu54JXhMJfIYgcuSp3cmU0jYsggU59pSeaK8pSZv4DU0ZabYnz1NwI+Zy2Kj2FW3LDHvdahhmAj+PbK5N2fWCSXbVgrsd4soNkV2fETYznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hky2hlzBaIrna72eQV+HsK0TOoTlRixOijN6JZRYRs4=;
 b=oRcWxPD5zxawPTBuFzor0nebur1z8z/ZOzWidiSO8DSNnV/bfRREFD/BvttmRMvBDE6BBqztx2q8LV6FvfPt8cOcBW4HF1kzLweibSJe/KFbfp9+4Wdqw5VRQRNhHz6/iv4sX5vkGm0o2wcCh8iA87GOjVu34YbR+BMzEuZf68U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:48:57 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:48:57 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 02/12] nfp: bump the nsp major version to support multi-PF
Date: Mon, 24 Jul 2023 11:48:11 +0200
Message-Id: <20230724094821.14295-3-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9b7a1f7-f616-4d8e-7fe2-08db8c2b3308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4OaOp9O3It9eEwT29OkzNhhHZp3jGgrjhgQ17QATuM0vK+7/ICwJjPU+pUXMGu88vVB8w6ms7xlph+JdKnuBz3lzasFi1q1H6CjcbCOdeqP37AprTJ66ELPU/ALGmqyJFgjD1v6yDh72qpIYSVLtBt6U6wCn2mC/flOaX1l7J1wLvNSV1kjo+SGElS9f8iB9OLMLYOibXEQVHuYCTd2b0+L04QLQ+0Ek+0kwSo4OGjEwCbbhoa1r+6726K6Knq6cLGR9g2iEfi58be7DjUzyJWRTUXHTQQH8xMSJWXkkMjZ8JhSIbJarWPUJM61jwO1VEzUiB8NG305sgzabpedtteokl0LXuHste1BZFHGvgi/Z/QLQ1wZDoAb9BRIcWTeXPewQ+FO5DoaWsctXnGvsdBVYMZBMncIKgaOyj/PAqAbxAxmQ0tVZvJn+8cRkelMdmQLySMOYBH5RxL3XiLfqDInbhMlffvZMi9ey21zBEbWAnJZdghjSCPbOyIqZy1YG3ShYz9B+pQik6DGOVM1ZCTvVjHne9jc3MzE6r7Q8GKF4tpKcMAW5geVKE876P3Bzyv0ZY6YC5KzlvCBF7+5a5yVxzdFYUf4/QVs08PO4GKGlOLNiuNa0FZUyageahHyRDU3syXIbOHpC2Yn850dDmpjaaPldz7j212R3ILT/x8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amxLUkRER2cyWjNsZTVrQlc2Z2Joei8yU2NqUFJDeDRFZVBNM0ZsQlJERitQ?=
 =?utf-8?B?eVZhaUN1dTh6Y2w4NnFPYW1ZdzhVd0hoVklZcVV5RmJwWGxSVnVsNkdLMEVj?=
 =?utf-8?B?Q2Yrblhia1lBdnI1Z0ZYSnhjT1NEb25aZVlMM0MwdlZ4Q1VXajgzeU9oSTBN?=
 =?utf-8?B?SlNJMXJ3dGZBbmFDclZnOUxpQVVTUmxDTzVERVFwUGZRZEpUWGMyVUFBdlBq?=
 =?utf-8?B?WEtWN1pEdG5rT1I0ZUtXSXpQMFkrdkJZSTE4RGJDanptOGlzV2JCWWlVdGp6?=
 =?utf-8?B?azV3QzZvUnVsaC9CZng1TTREK2hBTlFvNE5lQTVTZS8zQW90WnFiakJKOXdx?=
 =?utf-8?B?S1dXUnExMmdlTDJUczQ2MGxBcE5VaVk2N25mVWVKUHVXNzdWdDhOUXppaTM5?=
 =?utf-8?B?OVJpZDRxb1dQQWE3eHJESnNtUUNZODQyQ0t4UnBYTERHWStwbmd5T3JWc2p5?=
 =?utf-8?B?RnBtdnBUUW9wL3h2dnBucVVZMzh1ZVFjc1lyN2QzY1RSa2lSczJLRnpwajRJ?=
 =?utf-8?B?dm5CdUFRNVRyODJWdVBPWEROTXZRT0VTcjB5SVVLSzcyd1M2VFpvaHM1SHNm?=
 =?utf-8?B?N1ZvREV6eTkwSGdlNk1iY1hHWjlVR1pxT2RPRXFoT1pMbzhkVkVjZmpYams4?=
 =?utf-8?B?Z3BXRXFlV3BxNDNCMXZnZ1lWMkJMQ3lsUTRSVnRrd3d1LytCd1RjbkgxQ0ZY?=
 =?utf-8?B?THFVS3o5TWdob2dMcmpDVHI5b25FSUorcG9MQ08yOUpWeXJpeTNBcytNWVRF?=
 =?utf-8?B?WjlBL0E1MXV3bUhmUUJ2ajEzU2U1SGtYbkMzcE53Vk5QVXJXMmhQZmZEV2Ey?=
 =?utf-8?B?MXhjWlNycDI1Q0RjSnNOdDlndmsxeS9Md0xRa3BsZnFGeDhERlcxbmdaZS92?=
 =?utf-8?B?MlVuLzhQQ1VHcmpSYmRZaGtNeUhLR0lOOEMvRk9qWjI5ZUJnMU1rNmpIWU5i?=
 =?utf-8?B?MDhXemhob0t2eDhKbFVaKytSYVQyelpmT1hSRStaemFVT1NHMU92dnlrWmg5?=
 =?utf-8?B?OE5XbHB6QTBWeVBSaWR5dnpTUytOeXZBb0hpZHdlMk13SEk5ZUUvUHZ3N0FT?=
 =?utf-8?B?N3JqT3YzZm9mUi9IQjhSbkgxeDh6QjIrblUrT1JRKzdzSjJmL1RCSTR3R0VG?=
 =?utf-8?B?d085aEo3MElnRVRvcEtmS0Z3M2s3M2FYSzgwWHFzUFZJNXMyQmVkU1orR0M4?=
 =?utf-8?B?RVdMZ0dMeSs3S3hwWjI2M2dkZ095NXQ1VDJkbVlZSkJRMXNiNi9WOFBMcHNy?=
 =?utf-8?B?QUY1VmJBWUc2ZHlLMmFoZmlBakU4OU9TcmJsdEFFWlgxRFNVOFFMc2lTUHJT?=
 =?utf-8?B?NUJYTmg2QU54K2VRb3VzVDh3Z1ZyQUNTazFEZXp4bTM2SCtORTVYWnF3blNx?=
 =?utf-8?B?TWRuaEgzWUtTYkVUbjRpSStwRm12M1hDV0xDRFRjMmwvUTNQanFQTXpCUFFt?=
 =?utf-8?B?NFNScHN1UGlYNlJaUjNhNFhsSTJna0FhSjRWR25aZTBNRTNtd0dtbHJxWWdN?=
 =?utf-8?B?VWVsVGNPV1JXNFVqaG5IV3B4c3g4NExZTUQvRVJFL0tJOWdVN0gzVXUyVjZ6?=
 =?utf-8?B?UHVBSDdkSEQ3Sm11VXNnTmFqQkVHRmxlb1l0K1lvNEZyZnpXT0pPSm9tbVd2?=
 =?utf-8?B?QThtdGVDbTJiYVRpMGxRQ2hHL0psc25KbEZOd3BSZU1XQUtlS0d6b0k4eGhz?=
 =?utf-8?B?aWluVy9FTjFEZmlyNm9VVmtWS1RrVlJmbTVBcmdQRk1wVWVUVFRnYm9zZlpo?=
 =?utf-8?B?dG1CS2xYK1BxSFdxbVVKZWM2SGx2RC9mOFE5Ry9TUkg3VkVXZ2FZdkhhbGFv?=
 =?utf-8?B?UmloK2tyZllEOFR1SzBrVlBOT3lmQ3dMTGpNTDZvOWxDdXdrZHE5Wldmbjl6?=
 =?utf-8?B?Tk1pNUpqNUpNOWpwSWxkZ2NCNUVyYkJGVzJaYWRxY210dkhNNm40WHNiNHdX?=
 =?utf-8?B?allXR2RWbUIydDhzVHVGM2ZyYTNDWjAyKzF2VFJuZ21oZXBHU1dRNEdyYWwv?=
 =?utf-8?B?ZlBTRCtYbWg0Y0Flb2Z0RVJuQ2MzcGpva3p3ajhHRmd6bm0yZHBWdTFZUXJi?=
 =?utf-8?B?NW5QbXRzUENKUEpTL1ZvNWxKTGE1eU84Z1RWNm1tK0k4dTBuM1VoZWl5Q1dS?=
 =?utf-8?B?azBmbnR1MmpnQ2g4NFBGY01HY2R1Q0FpQlZkV1FXR1h4NXRCM3VKZGNSc25G?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b7a1f7-f616-4d8e-7fe2-08db8c2b3308
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:48:57.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRTe0AZNk7BrR0DUr1CBq6ExrNsLIIVKJXmd2z2i1It4kqkKAK10pssAWQnfde7m3JD8mJ8dZ64f7k4XTTkxBgcfBfGrhquJ4+N0fKK0qqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tianyu Yuan <tianyu.yuan@corigine.com>

Currently NFP NICs implement single PF with multiple ports
instantiated. While NFP3800 can support multiple PFs and
one port per PF is more up-to-date, the management firmware
will start to support multi-PF. Since it's incompatible with
current implementation, the ABI major version is bumped.

A new flag is also introduced to indicate whether it's
multi-PF setup or single-PF setup.

Signed-off-by: Tianyu Yuan <tianyu.yuan@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c      |  3 +++
 drivers/net/ethernet/netronome/nfp/nfp_main.h      |  6 ++++++
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c   | 14 ++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 71301dbd8fb5..39c1327625fa 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -625,6 +625,9 @@ static int nfp_nsp_init(struct pci_dev *pdev, struct nfp_pf *pf)
 		return err;
 	}
 
+	pf->multi_pf.en = pdev->multifunction;
+	dev_info(&pdev->dev, "%s-PF detected\n", pf->multi_pf.en ? "Multi" : "Single");
+
 	err = nfp_nsp_wait(nsp);
 	if (err < 0)
 		goto exit_close_nsp;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 14a751bfe1fe..72ea3b83d313 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -84,6 +84,8 @@ struct nfp_dumpspec {
  * @port_refresh_work:	Work entry for taking netdevs out
  * @shared_bufs:	Array of shared buffer structures if FW has any SBs
  * @num_shared_bufs:	Number of elements in @shared_bufs
+ * @multi_pf:		Used in multi-PF setup
+ * @multi_pf.en:	True if it's a NIC with multiple PFs
  *
  * Fields which may change after proble are protected by devlink instance lock.
  */
@@ -141,6 +143,10 @@ struct nfp_pf {
 
 	struct nfp_shared_buf *shared_bufs;
 	unsigned int num_shared_bufs;
+
+	struct {
+		bool en;
+	} multi_pf;
 };
 
 extern struct pci_driver nfp_netvf_pci_driver;
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
index ee934663c6d9..3098a9e52138 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -59,7 +59,13 @@
 #define NFP_CAP_CMD_DMA_SG	0x28
 
 #define NSP_MAGIC		0xab10
-#define NSP_MAJOR		0
+/* ABI major version is bumped separately without resetting minor
+ * version when the change in NSP is not compatible to old driver.
+ */
+#define NSP_MAJOR		1
+/* ABI minor version is bumped when new feature is introduced
+ * while old driver can still work without this new feature.
+ */
 #define NSP_MINOR		8
 
 #define NSP_CODE_MAJOR		GENMASK(15, 12)
@@ -248,14 +254,14 @@ static int nfp_nsp_check(struct nfp_nsp *state)
 	state->ver.major = FIELD_GET(NSP_STATUS_MAJOR, reg);
 	state->ver.minor = FIELD_GET(NSP_STATUS_MINOR, reg);
 
-	if (state->ver.major != NSP_MAJOR) {
+	if (state->ver.major > NSP_MAJOR) {
 		nfp_err(cpp, "Unsupported ABI %hu.%hu\n",
 			state->ver.major, state->ver.minor);
 		return -EINVAL;
 	}
 	if (state->ver.minor < NSP_MINOR) {
-		nfp_err(cpp, "ABI too old to support NIC operation (%u.%hu < %u.%u), please update the management FW on the flash\n",
-			NSP_MAJOR, state->ver.minor, NSP_MAJOR, NSP_MINOR);
+		nfp_err(cpp, "ABI too old to support NIC operation (x.%u < x.%u), please update the management FW on the flash\n",
+			state->ver.minor, NSP_MINOR);
 		return -EINVAL;
 	}
 
-- 
2.34.1


