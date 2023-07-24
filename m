Return-Path: <netdev+bounces-20333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2975F17C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9668F281246
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749AF9CE;
	Mon, 24 Jul 2023 09:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5117F50B
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:51:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::71d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39C59E6
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMV3EDI1AVMFmjHpjFWId1DiBXSZtTJyelg9uWnuRG8/pLGfOjqftsrAM9GutYLyH+37OQSI41Y4bhrTZVJsweRNuSnykkP2RRHJt68xgCY7ylhda0PbcwlL38CSMieD4ZfyadOwwOUUVgoAECB49W5ugs9ysZbl7vyotBCOGiQsbRvXT5KHRCjvMOXj5/lplWCw50ESbXivWENaggPgHriWLHmhvEC7Poi8ZmoiBiB5vbXqu9uhJ5c+JXr8tA7oCerlFw2dhYncUpJG7a8JcHcWcHPkqWXgM/34FHK3/64fD6OnW4giWrnfj8SHVFwxgkncfDcCtcml3g1Fqr1oRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELJ3sWTRsSpdEgU8Di/2sJRLaUZzkG7S22/xcW1snb8=;
 b=EYMnUIlZ9tLPqSwLlI/99B1QTW8Nfl/KHfOTQ6tFuVMf8TLdN6pPX0D/n9aTtJ2oxNZYy592+pGxVvh2mz4mqMCyI4lL9eYndJEI/Rk6v2pmnkj4YYGESLELFb5Xb/mtCrcp8f9Cq+gaQaWMS0zrYV4zOHGHl22FfOeLn6nzI8GT7ozJ1wSSlFeg+Gyf7Tdx2SKdAMQFPc3RZkvMGTQZUlRecvlPs1OvhtDgLwoLsq9WguCu09FosbBHnGp0ShyApQ74tmmRgVAMvKQEe6xfJF73SJxtGpJnGioKPo/Ud3dsswxUoR3FvJMUTb9ggxGHpNFxdDiJIra2jcRTP6nPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELJ3sWTRsSpdEgU8Di/2sJRLaUZzkG7S22/xcW1snb8=;
 b=apJQQG4BlUENFWFo+m/gfWUSAX2DZEHuDdMlM69auFMV75APFKYpSICdlme9PRGDrRPyiIIUeuYHzr+IFZ8x0RqJY0UlMk72yWB00EGhiLBQioZfnNBGQPPrkoNMR77vAEmHYGmINXZnImf+qOQpeqYFkr/4+5rsTSF0ql+P7ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:30 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:30 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 11/12] nfp: configure VF split info into application firmware
Date: Mon, 24 Jul 2023 11:48:20 +0200
Message-Id: <20230724094821.14295-12-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9879199-5e31-4362-95b7-08db8c2b4694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LYwKVGXhdQTTdwffJWk3Xq57pEUs/2V5AW2JZY+HyWI3DsdW+JwOgFOFcojTdx0c2V+RlWCiyfPQmC5HBaYJJUCX2NT4e/PCchqqJmxCLRpbOqWUGyRWoV1aV1e1fo6R37QTiJ0f9X1pGiyMpo3OIbfEJL8AIJnxjklHtuBn9DR+RmKT3FqojtUdVcm0eFaYuli/H7InZonL1iUszmIIvHTWBVzsqB4yHf8tjyJWAONsvcNCDQgR+V+kX6Bd59asvLsG9gqe9fD5057qSMdUUpELA9O1pm4dSBIbFZKnQYMDuFgNOrY6W/v6X1DxuoSYVfEjZ8ixLPQTZegKCWxlclpne0sUvs3Z3tQmf2rabi0DtHFob29nxnEN7CKzkFx3G65XRbqR5LFD/tlf1VY8IG3/eWi/EfCfK15zTSzt388TgrcmRCMBcpls2ZOxgyS2MfxKr20CbXk5W61fk88M0A3Fn9fZ7UEHWd1ubqyo3Av8TcGWB7xEBKBYcuQ/DA3krPzOCB0b07wIa6oja6IMnM2Xq6B08/2a2W7hScE5dxoRTgMMUJDk2x8DvTON21UjEX5CM0DjtcfL1PMyDWW9DribAlyLH4nktZarMFRzDriRk9PV95gpojTDbOk5iM7JBJRK/SO/8ujqLQUhgKZNRJLGsPr33dKTWxruySkbJqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0hJVDFFb2JSa1JIRHBuc1NLbEc3NzFFRHRuSmxOTzNXQ2k1eG50MUFDbVQz?=
 =?utf-8?B?YThEZ2hESTl6VFFVY3lEVlJ6cWhnVndBVlAwYmNxOTQ1N0lEYUI4MWRUZ1BC?=
 =?utf-8?B?dCs5aGk2RHdvRm9QTUUwK0pzS0I1cnd0YlBINWtqa3RQRFBzUTArbitGb01m?=
 =?utf-8?B?V1I2NnZNVXZ5SFhzZGRGcFVWd3dVMmVsSG1kYmtheXNYQ1dGRk9ieDExamIw?=
 =?utf-8?B?SDQ3a1pFRERRZytheGJlczIvdkJhdGZ3S2VTTXJ5T093YUg0TWcvcmE4Z1Zy?=
 =?utf-8?B?b21hek1STyt3RjlkWjVXb1ZGd0VpNFByMjVLcEcyWnlSN2VMUWo3STZaemJl?=
 =?utf-8?B?aGlNb2poMTAyeVVpWGROazljWHpCdFM4STZ3T1Vzc2t2YXZBSGJMTUVZUzlr?=
 =?utf-8?B?NS8rRUpSYnBCZW9SNHZiaHlLUTc1OEpGN3JtQnJuNE9tSzNrZnkwZ3FPMUdY?=
 =?utf-8?B?ZDBHWnVGVmJIQUUxVGlDNG5jN2ZqYk9BODY5R2VhZDJTSWtPNlFieHZJNDNo?=
 =?utf-8?B?OElabWc0NHRSTGhZdVdrUHJvS1BwUEF1MWw4clVLeWQ2V0dyVDd6T3lsbyto?=
 =?utf-8?B?UFJ1ZWV2RkMvNWoyK2Zsaks4eTc4RUwzUTlJVGVoZXQrNkR1a1lydDNDMit6?=
 =?utf-8?B?ZkNVMTN2OHV5OStJN3lMS1NhNjZ3WlFFS1B0ODJXTmd5MVVKZ0VpaitIVGVt?=
 =?utf-8?B?Y2NMUHdlK25RWFY3UkVSZmdkNU9EMEcvUGVGaVY4NGZzbG00SFZ2Ty8weHda?=
 =?utf-8?B?R0hYczFhQ1FSRjV6aFkrdnlrOE1mUkxldU5nUjZQWkMrT3R5MGZ2YmJrQWEz?=
 =?utf-8?B?WHZNUlNjdU45TDBEUis1TSsxTzJSSVdoRHpTb3IrQXVmcEVyclJtVHh2dndh?=
 =?utf-8?B?UnF1bDRYeWxRK3J1d29iazk4VG9oMzdRclNHakRFUWZLMXZFMjR5UkluR1BD?=
 =?utf-8?B?RDNZOWhHVHpHNHIwaTR6OW1NUmRWRWo4RitXNFZxQ2VSTWVPRVd5OW41V21I?=
 =?utf-8?B?Z3lUckNkMXk0bFdZV1VYWGZqZm5MaXF3NEZKRXpxTFFUWndhZFptOWRMUzZu?=
 =?utf-8?B?cmJmbmd6dHNhK2tqVVAzZXpxb1lhekNIVE5Tdnd4eVV1dzFQUy9rNS8xNWds?=
 =?utf-8?B?cXUrZStvN0hCUU9ibWw3UmNqV0RxdjMxWUNzVDlwM2E0L0trbmxhOWNJTHI0?=
 =?utf-8?B?RmdhOWRMd3AxTGw1L0pySlc2MERqWEo0ZE9UQVFEdWpVZEhxVk91dzFoRlhJ?=
 =?utf-8?B?bkQwNDVTWGlhM2VDa2xhMys5cGd5eUdrV1h4Nm9CQ0hBUWg1RmZyeG43emRP?=
 =?utf-8?B?WUJIQlA1dUtZMHc5Y2pHZEI2LzI2MUVObVlDNW9TeDVCblYrbElCSitrTGhO?=
 =?utf-8?B?VVpzV0I0MlczR1VxRlViU0lmSUJjakR4THFYNzRKS1VvbXYxcCtFTHQ5YWxY?=
 =?utf-8?B?WUdEZzE1WWVBd0VTS0JZdktZRTFTcXl6OG1DNkk4dDgrWSt6MG5CUUNGWlBQ?=
 =?utf-8?B?eXFUSjUyN05YS3NtdTVWQStDV2QxYVdYK1ZsT3JITVk3Wmpuc2ZEaUpHRE10?=
 =?utf-8?B?TDZwWVJvRTREM3hqbkRPUDhXaVRIQkZTbllMdHlrK25zMGt5NnpwQ0h4c0V6?=
 =?utf-8?B?bUFwSTgwZkd4RmVsSXMxc0ZudEJqQ1NiYlZnYVBVN3NJUW1xbktiUXpLZW9l?=
 =?utf-8?B?OFNXaCs2Mmh2blBQZkplbFBKa0wyUnJsSTlWS3F4UjVUMkV6QTBDSjRTRkRy?=
 =?utf-8?B?VVRVcURZTVNaYXUzenNDdlkwWWQ2Q08vbWNxYmJ1ZnJFZkM0bmphSGRybHNE?=
 =?utf-8?B?bFZlRCsvT0kzRlVXR3FzTkp0VlF4UnpLV081endzZ2xMYjNYWEIxbldiUGVw?=
 =?utf-8?B?WldyMSswYm1ra3RRdXpJZHllQjVLcTFlaFNDdHdrdGh3dFFBZUN1OEt0aWV1?=
 =?utf-8?B?YXM2a21rZjQzZ1FhREJ3eDZBM3BvY0dvKzlwYndWSmc5b2pGZEg2UXRZQTJ4?=
 =?utf-8?B?RlYxRUxSZUVnTGNSVGlpR3NLTUJtTml2Ky9MMHc3RW94Z3dib05wVm1lcHFq?=
 =?utf-8?B?ekRjY2RyNjRlUkdFZmQwdGVFYVVGTThoVEVLSXpuZHBLdkpDVnJHamc3N2lr?=
 =?utf-8?B?a2FHQllzOUkyRzVpQTVPRUVWNDN5TENNMmwyekl2ano1VzQzZ045ZnA0emx1?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9879199-5e31-4362-95b7-08db8c2b4694
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:30.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddPBgw2vMnXTEuaikWjKSvZpaNKxdxrX6tqrWR1tZVsAwPQz29aEloBh/BHYgCaEB7TrB4oivoxki7PZ0zqpUQbT3vUGoBJED8XzTuL9tls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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


