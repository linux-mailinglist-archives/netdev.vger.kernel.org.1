Return-Path: <netdev+bounces-28114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C8F77E408
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2121C20C5B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0A156C0;
	Wed, 16 Aug 2023 14:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C3101DA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:41:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB42A2733
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9eGomKV8IfV7sM0I6ToOrWmcCfQqrMCx/g4s93jxlxtw1+ga5TXRtO3K1FzN6rbDdCk5E8WpDFjKtW6bXR3NgToWgTdi3kUnAoEsYD16KqHYsmFU+5vH+aLRA27tRc4ve+071ADxqKwXAfh3dyM6tjSovWUNPAuFH/E1ExlIMROIQ/UkQgbLGhBx4L6TUDmWsW/mtW052Rizx8l/INW1lrbWuDwCxxrM10PF/M2bw79HGwYv1gQcSEuIwks5IBB7K050OSjngc30SZiDgpr7jDekATtper7DdyL1qkWytq3RCdWA2bNOKP+m8T+zOB8fz3LWP01FM6ztOagnfg5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW5qAoKKOCJX0LvdrXHIuNMF7UNWYwWcedloEMQCH3s=;
 b=NBvnL6yEJfEDRZz5yafn+bzKYtpjjZdlVdvnAALqp5Mr/f3q9BoHGabQSrFIoSZItnrnZ7PeL2tYWTGWO8GIkD4bR4F90dX3Kf9nhc3IlET7TIHzvwSMcWb/WQK3QIvisrXWfX/l9KH3n8e0I3ReasoG4XoFZMZatK2uDLbJAgKTildjGHcYYfhPo5HarO2aKtca2UgQZPTDS4pDcTGZJ4UviDt2kg/Q2orVMdAkELbkx87WNH2WTV47nQqBDoRjQ4+S6syn2Vml7MKETCB4Ddm0jFi+Z0qLDl/oM0uSK4O2Eo6AAso0+nJY4bIq0ONhyKmuP/0Bjf+oLekB4Ql7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW5qAoKKOCJX0LvdrXHIuNMF7UNWYwWcedloEMQCH3s=;
 b=iDorbMdaDSDMG4CubR8ER6p8l0Kl55tp+pmqoe0Jh3UlcwRCayyF1f41f5U8zSWdo+ykpz+UK4RZMWPQurG8fAiVAL7HnZI69TOVSYU5RfaGZDdJJGbwc0+lvipynjL/rZ6K9rBbzmmLcu50pbgATTDRoVU7n/qsG66PD1zLe/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5004.namprd13.prod.outlook.com (2603:10b6:510:7b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 14:40:39 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:39 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 13/13] nfp: use absolute vf id for multi-PF case
Date: Wed, 16 Aug 2023 16:39:12 +0200
Message-Id: <20230816143912.34540-14-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: b521d6f0-8ac6-42ca-2a3a-08db9e66c275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c6zZk2l6XoLQSGH8O8so+SHT4SmBAROt8EGTDmwYNf9Ia8JjFUKFno6TwVodMleK/LIqn4lxvCs7VaBgVhhPo3Gbh6HhWJqB3bFJ7LfNvlTubVs2AAQhKZtFsRgRUt8okURs5hG4eAj3sStxZejA/chWFhPyHh3O7Rmt3ODSp4dGNZ0upLQnWIGMv4rHIrXWC5o0mwwBPr2cqOn/kVpPR49DLVPbY/F3btqKfcd1XjXEQdq6GPiQpPp1VwWteyUHRCVZAC266tYvJiEKzxZWJfnLGQ1oi125pVHPdEjW4W8Qc8yY081GzEPjre+Viu5382bqcnvOtD1mKKuv1skK6Mn6t+ueX+KLrQcOzqeY08k4+SJTTDzWVoVarrbKl+PanYktnkO+vPeqL/SFX20cYcRAq9XejAaY/VO5yolF7aO7du030N4HPff4Kk5K0gzPJR98CITt56Wcn4pW77E5DYD3nwnShd2gXq88o54BkUUa23tb4X6lMzS30D6Hjp0557gec0B138NNFj1GvdHdnNIiQB0weyNkOwF5vDoFC3gAaDXyiixcCmNYeDQ2H6V2fKUCWWJqCaJ9I7Q4NJjRxlDoug+PleUpFMk69D78qJ/ZgmI/Q7MyX8bhTFOP7yhlfjCuJ1655tdWt4UtsVfzOOAnrJQ687g64uxJhz9t711lwdjQ7oiZlLy0roN4XW0X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGhhZ3dpYWlSMG5aZHo3YldxdTFoVjRDNGQ2Qk40c2w2VlRBOVVISFp3SzUy?=
 =?utf-8?B?dDBuYnJTS0Uxa05FMlBXK2NtWFdoZFNnNFBYQmZkYXJUQllGZENaWmlVQzlQ?=
 =?utf-8?B?K1ZkdUNtS3ZtWHRkTHZXdGVrTVVDS25GREdxVXJEdlhDbWJrT2czZkVCdWZD?=
 =?utf-8?B?cjBYbGZiU1ZGWDR0aEFjTHp6ZUh0Q1VkdnRxQWliM3VqZTRNbHhwOFZNVytq?=
 =?utf-8?B?Um9USTV6VFdVLzVGM0x4aEdPOWozUkNYRWZRVnZMNVNhby8wemJ2QXRCejZa?=
 =?utf-8?B?YWhXSzYvNjJzOG1OUDNTclRQQWl3MFpuTUI5NjUvMWlLdStwYU1YejhKL3Zn?=
 =?utf-8?B?SEtZOUZVRm1xZkR4OTdhT3NEcnNEOGloSm4zM2E2Q3JQZWZGb3FJbE56ekNU?=
 =?utf-8?B?TEpBQkJLc3FYWWtrTmNaNWNyWXpKUjhoaTIzQjZsY25MbDdKb0RkRnN0Sldu?=
 =?utf-8?B?aVpqSHZnSmdXeksrMU4vWVY2MWo3bVF3Uk5MNFphVXIzVDUyYmhsVmZoK3RX?=
 =?utf-8?B?K2tTaFhJdmVzTmROdVNuVy9aa3JZZGdzUVBkbVVqWEkzU0JkSzBSeWRyZDJC?=
 =?utf-8?B?RForS0U0M2VESFo3ZnB3V2NTOFZjb1hGall1RVd5TFlYUFViaStncHFtMGlT?=
 =?utf-8?B?d0VDZDlMczdEc003b1dsckk0eHQ1K1lFTW12VmJaOEJ4aCtjSDBtTDBpeE0y?=
 =?utf-8?B?S1BtMWZyVjEzaWFSeWsySTZXdWlSWkxlcWpxUDBQeXVNdVVnZ1BIUlo4L1E0?=
 =?utf-8?B?Rmwyb09PN2IwbFhZdXNrR2tabWl3L1N3SGJvME4xZmRIbVZrMWJlc25QSU9V?=
 =?utf-8?B?V3MyMnpNOTZFV3NxbGFacGl0NmFKWW96blVGR1htUVUwTlo0RGJlOTNDQ1VI?=
 =?utf-8?B?TkViNEtCLzlmVTVpeWVzL2F1SkpzNm4zMHQ2cWt1bXJrRDNrU2JCRWZXUk5s?=
 =?utf-8?B?WDNYaHdVd0RZYmdwSUpjN05GUGZScHJ6VVRSWnUrRWgzOWRPdkF5c0g1akZs?=
 =?utf-8?B?bEJuSTZWTFVqSlZpMy9HQTF6blRzT2pGTmhlem9UM2FGSFZCTTZDMXVrN2Vq?=
 =?utf-8?B?a2F5K3h2ZDhiWXhDRFBrM1JqOUZISTlBVGxCSWR4WWJyS2EwR3ZtZTVMb3Uw?=
 =?utf-8?B?eDVDOWVnK3pUYmpnL1pCZXEwenArTS83L0prK0d1WVNkMXVyd2loaTI3b0ho?=
 =?utf-8?B?MEdqZ3hvZGcyY0Q2SlUvVWJic3FLQXZ0UFlER1BMeTVNRWdBcTVKY1p4K0xn?=
 =?utf-8?B?N1ZDd3R0c1BjZVhqeXlqOXg5WjY4M3dFUk5zZ1pDUElHRE1mK2FscjA1YVpi?=
 =?utf-8?B?OWVyTHlnYktYZWxEbm5JMzRsNTFUd1Yxa2JtZzQzZkE2SjIwRnVJWHcxazNV?=
 =?utf-8?B?SXNlTytiNmozUTZoSi9wR1NsYWFwNjdacGJ3YmpMSXdWS0lUWE1GQy9ROTlk?=
 =?utf-8?B?WVZKcHJEUFdJUjI4dWFEeEpJRjNqV1VUWmw5VkxidDB3eEF5cC91NG9iTXJa?=
 =?utf-8?B?Y3JWT0lUMjNsc2Z0SzdFeFo0UkorbHo1ck9vNFJvSVJncSs2MWFZekpuaUpF?=
 =?utf-8?B?dUwyT1RvMkl0eXowWFFob2xhYnZoeUI3UURUMFhPVXV5dVpDQnoybW1XR1FU?=
 =?utf-8?B?a2Y3NUVLWlJDZVpnSG9LUnVpRy9xU29RQnJRN3lRY0V2UEw3STdhWG9LUVU1?=
 =?utf-8?B?WDhkYXd3dnJJYXRETmdCT1hJd3ZFRVRveFNaYVhpTU80anlBMkVqcCsrM2RB?=
 =?utf-8?B?QUp5ZERpa0tIS1htVm4wR3hTL2dCNzNHTHlxcEk2M2t0WVg2Rnh3UkxZRjRw?=
 =?utf-8?B?RW5xMXJ6Z2FJa2N1NjJHRFR1U0RlOGlnS0NRK0xDTGd4MERtaEQ1OXgxUWcr?=
 =?utf-8?B?ZkZWUTE3blplU29EUmxWQWpJbGpOd1g5aEV6b0ZOZHd6MERtUllISGtibVl6?=
 =?utf-8?B?eUwrUk5RQi9mME9WSGUvbXIrcWlCaWo0WW9lOHM2Zmo2UkZiN3VVa3c0b1hN?=
 =?utf-8?B?MTkyR2hyT1pUV0RvSmhmTGx6dVVtWDJHS3hHQ2NTK1Q3MGtTRWdwK2xsdHcz?=
 =?utf-8?B?QXdjekhhWnVaTDRudWI4ODRpa1o2dDBnamswTGZYcmFFaWloK0RlR3VSb1Ju?=
 =?utf-8?B?cGd4VTNuUnRvWk9ad3VZVGxvTlpiTVFsd24yL0Y5QTBjaXE4RDR0V2F2dFY3?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b521d6f0-8ac6-42ca-2a3a-08db9e66c275
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:39.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDY/GAAgT2DsHIEvvKnutzTxrZkj8v6K3a27KW1eU8ggx8eMKJCnlpBlusZQ5JWxJHwv2fj5IGdJI3hOlTpibM9HR+wWCOBPHxl1rR/cIdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In multi-PF setup, absolute VF id is required to configure attributes
for corresponding VF.

Add helper function to map rtsym with specified offset. With PF's first
VF as base offset, we can access `vf_cfg_mem` as before.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c    | 14 +++++++++++---
 drivers/net/ethernet/netronome/nfp/nfp_main.h    |  4 ++++
 .../net/ethernet/netronome/nfp/nfp_net_main.c    | 10 ++++++----
 .../net/ethernet/netronome/nfp/nfp_net_sriov.c   | 14 ++++++++++----
 .../ethernet/netronome/nfp/nfpcore/nfp_nffw.h    |  4 ++++
 .../ethernet/netronome/nfp/nfpcore/nfp_rtsym.c   | 16 ++++++++++++----
 6 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 70e140e7d93b..139499d891c1 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -97,14 +97,22 @@ int nfp_pf_rtsym_read_optional(struct nfp_pf *pf, const char *format,
 }
 
 u8 __iomem *
-nfp_pf_map_rtsym(struct nfp_pf *pf, const char *name, const char *sym_fmt,
-		 unsigned int min_size, struct nfp_cpp_area **area)
+nfp_pf_map_rtsym_offset(struct nfp_pf *pf, const char *name, const char *sym_fmt,
+			unsigned int offset, unsigned int min_size,
+			struct nfp_cpp_area **area)
 {
 	char pf_symbol[256];
 
 	snprintf(pf_symbol, sizeof(pf_symbol), sym_fmt, nfp_get_pf_id(pf));
 
-	return nfp_rtsym_map(pf->rtbl, pf_symbol, name, min_size, area);
+	return nfp_rtsym_map_offset(pf->rtbl, pf_symbol, name, offset, min_size, area);
+}
+
+u8 __iomem *
+nfp_pf_map_rtsym(struct nfp_pf *pf, const char *name, const char *sym_fmt,
+		 unsigned int min_size, struct nfp_cpp_area **area)
+{
+	return nfp_pf_map_rtsym_offset(pf, name, sym_fmt, 0, min_size, area);
 }
 
 /* Callers should hold the devlink instance lock */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index e7f125a3f884..4f1623917c4e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -179,6 +179,10 @@ int nfp_pf_rtsym_read_optional(struct nfp_pf *pf, const char *format,
 			       unsigned int default_val);
 int nfp_net_pf_get_app_id(struct nfp_pf *pf);
 u8 __iomem *
+nfp_pf_map_rtsym_offset(struct nfp_pf *pf, const char *name, const char *sym_fmt,
+			unsigned int offset, unsigned int min_size,
+			struct nfp_cpp_area **area);
+u8 __iomem *
 nfp_pf_map_rtsym(struct nfp_pf *pf, const char *name, const char *sym_fmt,
 		 unsigned int min_size, struct nfp_cpp_area **area);
 int nfp_mbox_cmd(struct nfp_pf *pf, u32 cmd, void *in_data, u64 in_length,
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index eb7b0ecd65df..f68fd01dac60 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -473,9 +473,10 @@ static int nfp_net_pci_map_mem(struct nfp_pf *pf)
 		}
 	}
 
-	pf->vf_cfg_mem = nfp_pf_map_rtsym(pf, "net.vfcfg", "_pf%d_net_vf_bar",
-					  NFP_NET_CFG_BAR_SZ * pf->limit_vfs,
-					  &pf->vf_cfg_bar);
+	pf->vf_cfg_mem = nfp_pf_map_rtsym_offset(pf, "net.vfcfg", "_pf%d_net_vf_bar",
+						 NFP_NET_CFG_BAR_SZ * pf->multi_pf.vf_fid,
+						 NFP_NET_CFG_BAR_SZ * pf->limit_vfs,
+						 &pf->vf_cfg_bar);
 	if (IS_ERR(pf->vf_cfg_mem)) {
 		if (PTR_ERR(pf->vf_cfg_mem) != -ENOENT) {
 			err = PTR_ERR(pf->vf_cfg_mem);
@@ -484,7 +485,8 @@ static int nfp_net_pci_map_mem(struct nfp_pf *pf)
 		pf->vf_cfg_mem = NULL;
 	}
 
-	min_size = NFP_NET_VF_CFG_SZ * pf->limit_vfs + NFP_NET_VF_CFG_MB_SZ;
+	min_size = NFP_NET_VF_CFG_SZ * (pf->limit_vfs + pf->multi_pf.vf_fid) +
+		   NFP_NET_VF_CFG_MB_SZ;
 	pf->vfcfg_tbl2 = nfp_pf_map_rtsym(pf, "net.vfcfg_tbl2",
 					  "_pf%d_net_vf_cfg2",
 					  min_size, &pf->vfcfg_tbl2_area);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
index f516ba7a429e..67aea9445aa2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_sriov.c
@@ -72,7 +72,7 @@ int nfp_app_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 {
 	struct nfp_app *app = nfp_app_from_netdev(netdev);
 	unsigned int vf_offset;
-	int err;
+	int err, abs_vf;
 
 	err = nfp_net_sriov_check(app, vf, NFP_NET_VF_CFG_MB_CAP_MAC, "mac", true);
 	if (err)
@@ -85,13 +85,14 @@ int nfp_app_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 		return -EINVAL;
 	}
 
+	abs_vf = vf + app->pf->multi_pf.vf_fid;
 	/* Write MAC to VF entry in VF config symbol */
-	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
+	vf_offset = NFP_NET_VF_CFG_MB_SZ + abs_vf * NFP_NET_VF_CFG_SZ;
 	writel(get_unaligned_be32(mac), app->pf->vfcfg_tbl2 + vf_offset);
 	writew(get_unaligned_be16(mac + 4),
 	       app->pf->vfcfg_tbl2 + vf_offset + NFP_NET_VF_CFG_MAC_LO);
 
-	err = nfp_net_sriov_update(app, vf, NFP_NET_VF_CFG_MB_UPD_MAC, "MAC");
+	err = nfp_net_sriov_update(app, abs_vf, NFP_NET_VF_CFG_MB_UPD_MAC, "MAC");
 	if (!err)
 		nfp_info(app->pf->cpp,
 			 "MAC %pM set on VF %d, reload the VF driver to make this change effective.\n",
@@ -145,6 +146,7 @@ int nfp_app_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan, u8 qos,
 	if (vlan_tag && is_proto_sup)
 		vlan_tag |= FIELD_PREP(NFP_NET_VF_CFG_VLAN_PROT, ntohs(vlan_proto));
 
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
 	writel(vlan_tag, app->pf->vfcfg_tbl2 + vf_offset + NFP_NET_VF_CFG_VLAN);
 
@@ -169,6 +171,7 @@ int nfp_app_set_vf_rate(struct net_device *netdev, int vf,
 		return -EINVAL;
 	}
 
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
 	ratevalue = FIELD_PREP(NFP_NET_VF_CFG_MAX_RATE,
 			       max_tx_rate ? max_tx_rate :
@@ -195,6 +198,7 @@ int nfp_app_set_vf_spoofchk(struct net_device *netdev, int vf, bool enable)
 		return err;
 
 	/* Write spoof check control bit to VF entry in VF config symbol */
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ +
 		NFP_NET_VF_CFG_CTRL;
 	vf_ctrl = readb(app->pf->vfcfg_tbl2 + vf_offset);
@@ -219,6 +223,7 @@ int nfp_app_set_vf_trust(struct net_device *netdev, int vf, bool enable)
 		return err;
 
 	/* Write trust control bit to VF entry in VF config symbol */
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ +
 		NFP_NET_VF_CFG_CTRL;
 	vf_ctrl = readb(app->pf->vfcfg_tbl2 + vf_offset);
@@ -253,6 +258,7 @@ int nfp_app_set_vf_link_state(struct net_device *netdev, int vf,
 	}
 
 	/* Write link state to VF entry in VF config symbol */
+	vf += app->pf->multi_pf.vf_fid;
 	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ +
 		NFP_NET_VF_CFG_CTRL;
 	vf_ctrl = readb(app->pf->vfcfg_tbl2 + vf_offset);
@@ -278,7 +284,7 @@ int nfp_app_get_vf_config(struct net_device *netdev, int vf,
 	if (err)
 		return err;
 
-	vf_offset = NFP_NET_VF_CFG_MB_SZ + vf * NFP_NET_VF_CFG_SZ;
+	vf_offset = NFP_NET_VF_CFG_MB_SZ + (vf + app->pf->multi_pf.vf_fid) * NFP_NET_VF_CFG_SZ;
 
 	mac_hi = readl(app->pf->vfcfg_tbl2 + vf_offset);
 	mac_lo = readw(app->pf->vfcfg_tbl2 + vf_offset + NFP_NET_VF_CFG_MAC_LO);
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h
index 49a4d3f56b56..4042352f83b0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.h
@@ -101,6 +101,10 @@ u64 nfp_rtsym_read_le(struct nfp_rtsym_table *rtbl, const char *name,
 int nfp_rtsym_write_le(struct nfp_rtsym_table *rtbl, const char *name,
 		       u64 value);
 u8 __iomem *
+nfp_rtsym_map_offset(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
+		     unsigned int offset, unsigned int min_size,
+		     struct nfp_cpp_area **area);
+u8 __iomem *
 nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
 	      unsigned int min_size, struct nfp_cpp_area **area);
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c
index 2260c2403a83..97a4417a1c1b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c
@@ -520,8 +520,9 @@ int nfp_rtsym_write_le(struct nfp_rtsym_table *rtbl, const char *name,
 }
 
 u8 __iomem *
-nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
-	      unsigned int min_size, struct nfp_cpp_area **area)
+nfp_rtsym_map_offset(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
+		     unsigned int offset, unsigned int min_size,
+		     struct nfp_cpp_area **area)
 {
 	const struct nfp_rtsym *sym;
 	u8 __iomem *mem;
@@ -540,12 +541,12 @@ nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
 		return (u8 __iomem *)ERR_PTR(err);
 	}
 
-	if (sym->size < min_size) {
+	if (sym->size < min_size + offset) {
 		nfp_err(rtbl->cpp, "rtsym '%s': too small\n", name);
 		return (u8 __iomem *)ERR_PTR(-EINVAL);
 	}
 
-	mem = nfp_cpp_map_area(rtbl->cpp, id, cpp_id, addr, sym->size, area);
+	mem = nfp_cpp_map_area(rtbl->cpp, id, cpp_id, addr + offset, sym->size - offset, area);
 	if (IS_ERR(mem)) {
 		nfp_err(rtbl->cpp, "rtysm '%s': failed to map: %ld\n",
 			name, PTR_ERR(mem));
@@ -554,3 +555,10 @@ nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
 
 	return mem;
 }
+
+u8 __iomem *
+nfp_rtsym_map(struct nfp_rtsym_table *rtbl, const char *name, const char *id,
+	      unsigned int min_size, struct nfp_cpp_area **area)
+{
+	return nfp_rtsym_map_offset(rtbl, name, id, 0, min_size, area);
+}
-- 
2.34.1


