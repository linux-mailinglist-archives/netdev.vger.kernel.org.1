Return-Path: <netdev+bounces-28113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53F77E405
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2FB1C210B2
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A53D12B70;
	Wed, 16 Aug 2023 14:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A31168A4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:41:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC72D5E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNu+LlX7tXGKL+CG/2T1hmtVa4rDxr48PgIC/fWR240GiLWy+ZitVa3yzUGLUGOe7J9ihEgCbfJmomKAy5ls+zHC3ZoJmLnIqeGIbijN1oJirpYuQif6oh4ax4Samu6wodgJHArLqA37G3tG1usnOs9mR6+rGQowjBJGryEGyTgB3/Io2rAiP2eN3vF2UGC4Od7scIXuFcUO9nmIXhyYQZdrgAV3Tln4XvBEvLDuENwVOvKzlSNMZ42e3GOw5U83l1ZNDyjw5Ey3TuQQn5batZ20YDjqNOUK2kM8hPrf6KjF3E6eNd8TVA/V3Xr4TKLSQdgHzoyg1cqdTBatQugJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELJ3sWTRsSpdEgU8Di/2sJRLaUZzkG7S22/xcW1snb8=;
 b=JFbzFnfoBs91OxSxv4S06QuYhU2cowPdtfdQzXpVkNOMEOYTbObMO/tkkezpmAhqDBJqef3KtZS0qQcgSwZk0tOtPd4zo2vcZ+9J2XWUKBGr/45w0pNROzSXBxXDB3i47f8D8e1l7pnHEeMRIxCTeTz7Rd7V1O1Hl8yFuF38RbMosSx9isVG3tyb/PaFYdEMewDBV0iSueU8Ldx6C9cApb62WtPRjlUH6UmnifeZwgw/I9G/6Znf5bIBfEEiSs1V8n1qnt5h3nwOYmgZ22fDpFhREcIEqv4ciE47VXKlMaoGpOnjnJKDYF6bdxqdkwaFsUuHXlaGm7e3CZuRXJUY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELJ3sWTRsSpdEgU8Di/2sJRLaUZzkG7S22/xcW1snb8=;
 b=BeplYZ+xz24+H3YX02PN0SKfWnWhY2b+2LNajpoMP9J7EMv6NrrH7WwveKnkDvNMAYBbgbkdmvELdGVDDvMIDUMuDEWayOt0Bj6JZnTscPG2sCrHipWdYAYypqVAya6dxUqrywFhAkUiSWXoRULIeYEx7cr5WhYM1qznLdnK2So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5004.namprd13.prod.outlook.com (2603:10b6:510:7b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 14:40:35 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:35 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 12/13] nfp: configure VF split info into application firmware
Date: Wed, 16 Aug 2023 16:39:11 +0200
Message-Id: <20230816143912.34540-13-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a92424a-c439-4067-2612-08db9e66c040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6E8wzr8uZFn/OfG7hjCNqpJ4BLvsJ0EEEZHY+Yt07JF220Uy4iTvZXIbNfcxcLqHR9wqFhxubdeQPDZxg/syZpm3Gu58dY6cut1ssohhWfrYG1xDSSAf54TLQQQ0GKXkj1bFs43wn2/3vO2xjnLiQNdqdjLe9qNqqKz8cKZCXuEGjFbSsYZx3GvrVNki7B8PjpaLgvRlwhI7+KUHL/QUY+FNifZVYZGH9WIsD5tsINRiYWh9c3AA1dihsPQiI6RLIZdBKxDd+O+zLlQgEmO+4VpYaFcbSPOf34QasOPvfu9KdvoIp6WnIuHs3rYXfClva8igmluEpFhn9XHhC3ZUytg15s+xUmoPEJ3CHYVANyRwrkZc1wSBtPo7l0atQJYg/Fv6Rp8Lvr18b4AiOE5j5uBYQzkCWlCclJZw7jl9Igga1hmhm557kjlnvilPU9w4+Mdzu15tG4x88IrMc9ur6l2YLm0F3/2TlN82IxVO5KMzOP5svVpwBpNK0vhQoUVFdvq3Rlz8F1Ra8cYg6ylN3/CzWQpJ7bvN/hlgyywUkyE3mB8imOPcrnKna29kCqa4F+mx31ElEm5ngo9CfsQu2F8Ffkr8zL2JI7jTzB2IUVsBy0bNqBZlGu1u9a7Dbyhwz2GEbwRsSTxUJ8BgjikTJ0POmOv0ugyd+K4W66FX5iqcDmwqr/kgB1t1ppNoygVKa5AP/LJiNMQADnffb4pdEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0p3b2ZsWHcyc1gwRlNMbmNERko1WWI3V0pWREY1SEhrOGdCdkg3RUd5NHJO?=
 =?utf-8?B?T0Z2bVN6MTM5Qmw5U211TkJSdUFkMG1YVFBMdDJkSXJYWmJnWEZKZ0RqV3U4?=
 =?utf-8?B?eVJma2RpNUJaWlduVDdzNmlUL1ZOaEJMRlNsWk16MnFVSmtaNEpWdVloSzlr?=
 =?utf-8?B?TVphWDFTQkc0UjJoTm1CeFp4MmQ3OHZuaCt6VmkwOTdubzkveU5TbVNvSFVu?=
 =?utf-8?B?aTRVckFubkp2SXNOendaWTA0WGJqNHZJTU1FUGJpTjNBUm4zOXpnOTlqWmh4?=
 =?utf-8?B?Ym5UWVFFMmxPYU1wYTQyWStYK0swdFFGcE8wUGQ0NGtOMW4rcmQ0dDRHSzV5?=
 =?utf-8?B?L21uN2pJcGZ0V2c0cCtsVnFjOXJYRWlQbXJXb1prQ09RZGxKR3cyK05sTWFH?=
 =?utf-8?B?MlJIMFRFNVFyQUc2T2xzVWMxS09YOEl4WTN6TGwxM0J5U2FIMmYvVUFYNXJN?=
 =?utf-8?B?U2Y4T2piRHh6UmQ5azM4ZlRac1JXV0dhdWVGaGJWNU0xcTlCbW5LQjJUcmxB?=
 =?utf-8?B?clFCcGtqUXY0SGdlTldRTjB4dzBwMmZRNGRNVzVkWmQxaFluSXFvU2F6V3hG?=
 =?utf-8?B?dVN4SmhrVW1rNUNDQnJIQWdRcVh6ZDdnN2JEVFhCaW8wallWaTdDeGxVZXNV?=
 =?utf-8?B?bEF3T01EZklkbWppM1NFM0dHOU55QlorRWdpc0NTbUM5NlpxOHBTUlB0d0tt?=
 =?utf-8?B?TkR0Mm81ZWtLTURhU3NNeHErL2VIYVZJcmYzbFF2aFBWYmhyYjN5TWg2S3pV?=
 =?utf-8?B?cng1MFU3WGRtRnd5YmlaODBBVmVPVm5GVkFpU1Z6SUg5am0wZXUrOHFzQ0xX?=
 =?utf-8?B?a0pLS01Ydkgvb0QrdXlab0pXaXJ2NFR3NFVROXVLTzFmUXZnbkVRUlpwVWxI?=
 =?utf-8?B?M0ZsZlBVSXVNQVhhSC9OYlFxVFdCM1BheThkNkpkb2p2UVBqRHdYSTlaWmFP?=
 =?utf-8?B?bmhSZm1QWUQ3RkFLcGExemtEL2haazY0MzFzSXdBbEd6d0VNN04vdGRXWC83?=
 =?utf-8?B?Rzd6VjJ6V29Yb21QZ0pJMGlMemtVaThIWlVSSkdvRlpQcWgzMnJlVDNBSG52?=
 =?utf-8?B?ckIwOFRzT21HOG5DdDZKVDhOemZ6UUcvbUR1SGpueHJXS2pmMk5YdFVUM090?=
 =?utf-8?B?L0l4K0dtM3c0L3dQTnc2VWgvMmFBRHk5RGhmbHJiVlg3UExMcGpkbkNVRyti?=
 =?utf-8?B?b2g0Zk5OYzE5WU5CdjJxTVZpMGg5REl6WEhUSnpGR3VTWTQrZ1Q3QmVEY3pB?=
 =?utf-8?B?NmIzejBoUFRhVWw1WEFIVjY2S2pDSFlCWTMwVUdwbS91Q2VJcmhsc1NIT3E2?=
 =?utf-8?B?SUE0WFIwSjlKejNGZDllbDhVdE5lSFF1YUx5QVM1TUtydER1K1pjcHphN1Rz?=
 =?utf-8?B?RlFKeE94T2xnRks4SE5sRUM4N1hKRi93cnBJbEVSNUhHdnoyU3NGTWxHUENO?=
 =?utf-8?B?MjFwWDlCRWI4TkVER1Z4b0hmSkE0dXVCZUFCTG54NjdNbG43QXBTZmZwZ25I?=
 =?utf-8?B?RkFSQ01telF2UXlNSEFzMFNWNWp1Q2dNYnk2bkZ1b0huNFhZRkVkSFkzY0o5?=
 =?utf-8?B?NzNQTFFTUG9NY2FQYnIwbldJZmNGTGZ0VDdTNHNHQU1CUURuU05yUmRsS2VM?=
 =?utf-8?B?NXk2Y29EZ3BPWFJGS0o5MDBsdVlFQXlUMERMYlJveUx1c3pPandQNmVvdmIr?=
 =?utf-8?B?cmZ5N0EyZ1hFcnBseCs1M0h3REkxaTQyOTVDcDFOK2RuVGVYV0dYQWtNVEN1?=
 =?utf-8?B?cnowWCszK3Z6L0lUVkd2UlpIYUxUZVI3T0p1SWF0ZFk0SmpFSnZhNk8ySTRp?=
 =?utf-8?B?R1lUQXE2SEVZaVlZaUV3WVZKU1J4L09PNEQxRWY2NFhaWElBbHVMRFlBekhy?=
 =?utf-8?B?NEZxOTRuYU9USzVoWlZnZ2JMUzg1bTRWZXFEeERtN3BwWUpXY1NFUzlkU2Nn?=
 =?utf-8?B?Qnl4WnhmR3FvOUNxOWQwT3dkVllBM1pjcjg2Slk0RkV2S2pBKzBycDNpK0d6?=
 =?utf-8?B?eHIvQ2tzTWhLZGZkdDArQlZtRCtwZW5CYi9EcC9Dbys2MXExU0ZSUmRGZUVn?=
 =?utf-8?B?ZVFHM3pJeFVwMkJBeTd1dEJtV3Y4SXI3ZXBSV2EyWE9wR3dyWlRScEJKR0hK?=
 =?utf-8?B?bW01OExEdjNHSmVTYnA4TG1mTjUxSXZPRHZxbVVrVHJFUWFXenlmR0JyTi9m?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a92424a-c439-4067-2612-08db9e66c040
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:35.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZmiu7caOWEcFGicBMMhuUSJzOYcjZuv/tNRFCI9GnAnvBqvGw3ByAbT5Dxsgu7LYC8ikb0neypq7Kg3EBH4nbTeaiySLPzSU89BDNODg50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In multi-PF case, all PFs share total 64 VFs. To support the VF
count of each PF configurable, driver needs to write the VF count
and the first VF id into application firmware, so that firmware
can initialize and allocate relevant resource accordingly.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c |  1 +
 drivers/net/ethernet/netronome/nfp/nfp_main.h |  2 ++
 .../net/ethernet/netronome/nfp/nfp_net_main.c | 16 ++++++++++++
 .../ethernet/netronome/nfp/nfp_net_sriov.c    | 25 +++++++++++++++++++
 .../ethernet/netronome/nfp/nfp_net_sriov.h    |  5 ++++
 5 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index b15b5fe0c1c9..70e140e7d93b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -254,6 +254,7 @@ static unsigned int nfp_pf_get_limit_vfs(struct nfp_pf *pf,
 	if (offset >= limit_vfs_rtsym)
 		return 0;
 
+	pf->multi_pf.vf_fid = offset;
 	if (offset + total > limit_vfs_rtsym)
 		return limit_vfs_rtsym - offset;
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 4f6763ca1c92..e7f125a3f884 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -87,6 +87,7 @@ struct nfp_dumpspec {
  * @multi_pf:		Used in multi-PF setup
  * @multi_pf.en:	True if it's a NIC with multiple PFs
  * @multi_pf.id:	PF index
+ * @multi_pf.vf_fid:	Id of first VF that belongs to this PF
  * @multi_pf.beat_timer:Timer for beat to keepalive
  * @multi_pf.beat_area:	Pointer to CPP area for beat to keepalive
  * @multi_pf.beat_addr:	Pointer to mapped beat address used for keepalive
@@ -151,6 +152,7 @@ struct nfp_pf {
 	struct {
 		bool en;
 		u8 id;
+		u8 vf_fid;
 		struct timer_list beat_timer;
 		struct nfp_cpp_area *beat_area;
 		u8 __iomem *beat_addr;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index f6f4fea0a791..eb7b0ecd65df 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -293,6 +293,16 @@ static int nfp_net_pf_init_vnics(struct nfp_pf *pf)
 	return err;
 }
 
+static void nfp_net_pf_clean_vnics(struct nfp_pf *pf)
+{
+	struct nfp_net *nn;
+
+	list_for_each_entry(nn, &pf->vnics, vnic_list) {
+		if (nfp_net_is_data_vnic(nn))
+			nfp_net_pf_clean_vnic(pf, nn);
+	}
+}
+
 static int
 nfp_net_pf_app_init(struct nfp_pf *pf, u8 __iomem *qc_bar, unsigned int stride)
 {
@@ -852,11 +862,17 @@ int nfp_net_pci_probe(struct nfp_pf *pf)
 	if (err)
 		goto err_stop_app;
 
+	err = nfp_net_pf_init_sriov(pf);
+	if (err)
+		goto err_clean_vnics;
+
 	devl_unlock(devlink);
 	devlink_register(devlink);
 
 	return 0;
 
+err_clean_vnics:
+	nfp_net_pf_clean_vnics(pf);
 err_stop_app:
 	nfp_net_pf_app_stop(pf);
 err_free_irqs:
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
index 6eeeb0fda91f..f516ba7a429e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
@@ -14,6 +14,9 @@
 #include "nfp_net.h"
 #include "nfp_net_sriov.h"
 
+/* The configurations that precede VF creating. */
+#define NFP_NET_VF_PRE_CONFIG	NFP_NET_VF_CFG_MB_CAP_SPLIT
+
 static int
 nfp_net_sriov_check(struct nfp_app *app, int vf, u16 cap, const char *msg, bool warn)
 {
@@ -29,6 +32,10 @@ nfp_net_sriov_check(struct nfp_app *app, int vf, u16 cap, const char *msg, bool
 		return -EOPNOTSUPP;
 	}
 
+	/* No need to check vf for the pre-configurations. */
+	if (cap & NFP_NET_VF_PRE_CONFIG)
+		return 0;
+
 	if (vf < 0 || vf >= app->pf->num_vfs) {
 		if (warn)
 			nfp_warn(app->pf->cpp, "invalid VF id %d\n", vf);
@@ -309,3 +316,21 @@ int nfp_app_get_vf_config(struct net_device *netdev, int vf,
 
 	return 0;
 }
+
+int nfp_net_pf_init_sriov(struct nfp_pf *pf)
+{
+	int err;
+
+	if (!pf->multi_pf.en || !pf->limit_vfs)
+		return 0;
+
+	err = nfp_net_sriov_check(pf->app, 0, NFP_NET_VF_CFG_MB_CAP_SPLIT, "split", true);
+	if (err)
+		return err;
+
+	writeb(pf->limit_vfs, pf->vfcfg_tbl2 + NFP_NET_VF_CFG_MB_VF_CNT);
+
+	/* Reuse NFP_NET_VF_CFG_MB_VF_NUM to pass vf_fid to FW. */
+	return nfp_net_sriov_update(pf->app, pf->multi_pf.vf_fid,
+				    NFP_NET_VF_CFG_MB_UPD_SPLIT, "split");
+}
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.h b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.h
index 2d445fa199dc..8de959018819 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.h
@@ -21,6 +21,7 @@
 #define   NFP_NET_VF_CFG_MB_CAP_TRUST			  (0x1 << 4)
 #define   NFP_NET_VF_CFG_MB_CAP_VLAN_PROTO		  (0x1 << 5)
 #define   NFP_NET_VF_CFG_MB_CAP_RATE			  (0x1 << 6)
+#define   NFP_NET_VF_CFG_MB_CAP_SPLIT			  (0x1 << 8)
 #define NFP_NET_VF_CFG_MB_RET				0x2
 #define NFP_NET_VF_CFG_MB_UPD				0x4
 #define   NFP_NET_VF_CFG_MB_UPD_MAC			  (0x1 << 0)
@@ -30,6 +31,8 @@
 #define   NFP_NET_VF_CFG_MB_UPD_TRUST			  (0x1 << 4)
 #define   NFP_NET_VF_CFG_MB_UPD_VLAN_PROTO		  (0x1 << 5)
 #define   NFP_NET_VF_CFG_MB_UPD_RATE			  (0x1 << 6)
+#define   NFP_NET_VF_CFG_MB_UPD_SPLIT			  (0x1 << 8)
+#define NFP_NET_VF_CFG_MB_VF_CNT			0x6
 #define NFP_NET_VF_CFG_MB_VF_NUM			0x7
 
 /* VF config entry
@@ -68,4 +71,6 @@ int nfp_app_set_vf_link_state(struct net_device *netdev, int vf,
 int nfp_app_get_vf_config(struct net_device *netdev, int vf,
 			  struct ifla_vf_info *ivi);
 
+int nfp_net_pf_init_sriov(struct nfp_pf *pf);
+
 #endif /* _NFP_NET_SRIOV_H_ */
-- 
2.34.1


