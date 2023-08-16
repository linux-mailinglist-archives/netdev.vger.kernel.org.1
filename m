Return-Path: <netdev+bounces-28108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFE77E3F4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278C11C210AE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D8156E8;
	Wed, 16 Aug 2023 14:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E716400
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F05268F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST8ILpYTfwEkMQXgjaYjyLnkYw4FUof9YUoF80bmTByBgycMCATC6b9/dM+TY79xA5KetTFPTEvEzkerQAkz8fGctk+YdZxZgDgwt//j6wgAO4PUv8wz4zckf+pwJf7/s9tVrhO6WhlqyqOzjuLreLb4raIsLemRjHeGLruNwdweUNXHTPEQwoCBAy4yWHW7W0K8eFUoI4xFL4g3y1/G8X6A5PPm6pp6M3SC6AS6+y6oTTQdHuErNNmA2QCQtpwIaZJJbcEUuiZPBMIqtbJ1vL9924T2ySpRl1b6h0zAaf21nHMojGLpZ7AKK2wnYjTMvfmyJPnmZmN7mQHhxgoXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBD580DaiUnSfTUN87A8oZ7d1leIQpq4MQYDC0Ch+CU=;
 b=Aq/0BM1Srbjp/Zy+nnFomuo9NWFXc1+MMx7jFVxbYmqSV5ygDLDAHENd8eW8MHToXntFy/A+G5vcH44He3JuB9MEnkwdsOfJ5jQYkccUEa5t8DIiNeCGx6liYPIn7eRadzS770vHE0P4Gr/j6NkKvbIZeLot2yhmpBLabfFJpeU064ZwyMFFSmTgR2LpKNxJJSK5+QziDhzZp/PeoDOmqPPg8t0k9cGvAE/q2AB+W7eIUQOn64VcBr3kl6PBVIV4+tB8eWOoLPUy86a0gEpYel/PjJjZUmWN91kSfiT4M9KC/9oY5TO4xoZHyxIQ54rXja3tTQfe29Q+1jbBBbAttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBD580DaiUnSfTUN87A8oZ7d1leIQpq4MQYDC0Ch+CU=;
 b=r3Erj/67JpXsqu8bOqo4gt+SCzwC1a4ikLius/VVXLubNP4QKqFXs7tnbY6IcYRlfmZsU0vtlpljH27+/lHkTOMVDIJfeBCI5qC9m4Wd4G36pm8k1PoQxjt5X0CZ6NVpM4hk9eED+yzkS2p0kN0GcJqmp6b+7dXxgesW2Z0awS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5004.namprd13.prod.outlook.com (2603:10b6:510:7b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 14:40:21 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:21 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 08/13] nfp: redefine PF id used to format symbols
Date: Wed, 16 Aug 2023 16:39:07 +0200
Message-Id: <20230816143912.34540-9-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: af30d573-9ed1-4fc6-36ac-08db9e66b7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hvbnGkYJalV9eE9DJsU4zf6cAdX00Dxztdo8VeFBapNPgp6nEav3eovqTWT70gu7ThVUvzdgQG8QGtSspBuPLj4fJ9pGxujMYrxlvgDLA9GLpsWK5ltXaVSKd8Y5xAdQZX4Kaycr1h9Dg1xeq8b1kOhPYU06mKeu6Yfvhq64oUNKUcWdV37lGCwrvBN+AO50yMFaMQVJQRCp04/UTV7mPQiEWaSml1zADdizjq7tpmuQPryU1cu+LtFtQeGifmcvkOG/e+Qt+2YUMG252jHzL+U0Vbyqnkk0s0VMhFPdKxVDJ/pQCLcuR3FaBh/zPxpFfAwH0gkhk/5yveIrFo97hcemluCDUTSn25eHXzhU1cys8jqKQ1Ss+u1JL3uu7zyVswfSweWwmvZOF66BZXhF3C/5GGGTk0C/XW6bXoZ+ZSOTOvqTv1Cd3XlDvfT58zskwMXBMOKvNdhpVmAn57RIJWS6Lgkq3kypzuvHrc967Mqaa9a7EVZ+HnwOepr3LTL4X3dKZnn/BRNta3EFPhGMyEMizmHQ43gKMCapVi8w73ZPn0jdmTU8Z8U0av7SjSOSLrTJG53WCTj6nyHOKrBdxIyQALNgu9uYZgqv+9vRDBN8mG1nRFy3o16Eri6oUtj3uX/oXHDUP829VzvSKyIt8L2UEd/i38UKRzrVkVwdhe1ttDJN1JN5iaCQdXc6u8JiEG/ZxpY0UBc0Jg8SPQQ3cA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVRiNDQxR3ZIR3ZhMVVYOU5BcldJVllYNEkzaTh4QzBFWXI0ZWhCdGF1SGsv?=
 =?utf-8?B?NCszZHF2R1RUcmxaenlMT3ErbFJTZklGR1dtZkZoZXcvd250YWV5WHJzTWhL?=
 =?utf-8?B?WjRFTDhOQ291Z2VHa3l5Z0dnS1I4ajlVR0NWd0VWbFIrNlpHMENjQmJpaDJG?=
 =?utf-8?B?VzJyUmhzV0o5dWtSUG1aeGpTQ1pMVDRldmI3ZndHYm9qQlVYTEtYWEp1b3hj?=
 =?utf-8?B?WXFPcjQ3R1I5OENOM2didGNnaEEva2JMMHFVUHhZbjBKZmxHR2x1aGx1NUIw?=
 =?utf-8?B?eEJSdTlDQzU1UEM4bE4xM05hRGZzT2djUndhU2ZTMVpZM0hYZmpER1VLMGxB?=
 =?utf-8?B?a21zbmQxVHdETWhsZ1Qzc3o3cXRzR0l5WnVVYUdvYlh0Z3loWDZhb3A5UzJN?=
 =?utf-8?B?TDF4bkxFUjJFOFRuMFdGaGtyeDd5bWVOMTkxVU85ZDRFa082dmlEd3BuTVRy?=
 =?utf-8?B?MFFNUTRabHdvZWxiWW1ITDRYRCs0OTZzQ1o3M2JNdTUrbTNCcnBSQ2dobEx3?=
 =?utf-8?B?eFAyeVZkNkZrVXVMUnZEOTQyVEpyK2pQeDZ5ektJYmNiTTdWR0ZPWklnSWox?=
 =?utf-8?B?dGVxeGt0cE04RmVva2p3bnJ1eS9kbkxoR1REcGxlWkQvVWUxVkxRdWk1OUQ1?=
 =?utf-8?B?dkR1WUJySHY3SHlRcXhwMFRScEhObTJabWkzRm9uU3E3UG5yZGVpYXpDTUdE?=
 =?utf-8?B?RFlXVlVzUnUrZlBYVlY1V3A5UzRRS1Fhdk5tblVNWUdjZzY5VXJrK0VlMWZC?=
 =?utf-8?B?YkRiemFKendQZ09OQ2crQ004Y0gwUk0yM1JySnNlbEpnWk9lSW5WMDRHUGdB?=
 =?utf-8?B?MEN6aEwxeW95TFYyQjFwdzhaY09WYk9xdFNFV0tWMkVRVE9QbTM1bUJZVzFG?=
 =?utf-8?B?VkdCdmt0UkJ2VEJpU3hndThDS1hXeW9KWkJqUHVOVzRTMHAyVnNOZHQ4Mm80?=
 =?utf-8?B?VDE1OWdoYnJEeGVTckVEaWl6MTBTRFhpMGppaVZrTktPTEJWRktlVjFYdk9j?=
 =?utf-8?B?K21GZGZnYVh2RjNQVTluK2g4SWRiMjRyMVltSGtPUmc1NXBtMHBuUjU3cGdy?=
 =?utf-8?B?SGNxdlBrUWl4VzMveURJM2xpSStKT0U0MTlCYkNrSXVkT3hnZFlpSEM2Skxa?=
 =?utf-8?B?ZlB6eVNMc0FaNWtPY21OcE5YOEJlb1FhRWt0WVB4eEZ0YWhka0piUFFwb2Mz?=
 =?utf-8?B?cE9STXBrR3gwemlrMWptSUhWSUxIWW9MOTB4aG9yVjlnNE9JRlArTXJkYVp4?=
 =?utf-8?B?QlljTk9KdHdTWDBnSmNFdmJXUWpoTlBGWXBWenhTRXZEbitQQUxUQUdWZEYv?=
 =?utf-8?B?UGkyWHZYNkxNR3FmejJ6SStzUHVndFdJMVlwWHlvY3R4bUlidzNjTVdLaFdw?=
 =?utf-8?B?S3lTY0dLOWZRcld1L3U5N3RvSytZbmVhc2djZGlkMUQvaUc4cjBhY1lNeENv?=
 =?utf-8?B?OUE1d0NBbUFtUFlpQ3lkYkExWkVnRHVETnFrdHZGdnBQczIydnFiTnIySmg2?=
 =?utf-8?B?YnUrVXNhQWJYZGc5SEdNbUltUUFNY0ZkQmREU0lnVkZqOS9vdXJxL252bjI0?=
 =?utf-8?B?dElOUmZQZnpzbDZyQU5XTFhaeS9pVEFsQ2RGZysrblRuQ2NOZVFwY0o4c0ZK?=
 =?utf-8?B?ZXVIT1hJTkVKYnhzL2U2bGxyVnovOUdUZnNjSGRYZ2RDWWt2cEdhVFR4Q1Rx?=
 =?utf-8?B?S09IYVJWQjJsVkJObytJcUlsTnIrcVVldHVZWTdPT0pEQUJDNWp6c0V4Tzkz?=
 =?utf-8?B?bFNuUHFxRjBQZGUvdDFLS2VMbFNFb1dEclRFRHc2cm5qdk8xUnhrSUVsdGZP?=
 =?utf-8?B?SWRqWEVBR0ZLSm1uc2pMdlRsTzZzZ1pPZmRSRzBETVdZeDIzampLdnN6Y3pw?=
 =?utf-8?B?cnNVQjVBNUlmY2ZtMDRHS282TU9vMkVSbmNPL0ZrMHZzLzNNSUVaZUlSN3ZG?=
 =?utf-8?B?Yys0Y2x2ajIvdWRqMEJxODFMUDI1T0ZVUlNnWFhkQ3lQM1dvQmlDekdaZlM5?=
 =?utf-8?B?ZUlTYmdUc3RTQVF4aldCRWE1ZFNNdnVFY2lLaGxGaUN2OG92QTZvMXlZSjF5?=
 =?utf-8?B?NVlzWkd4QkF1Y05LU0lPS3ZrMDlMYVl0ZDYxVDQ3ZStvZUhCMjA3TG1JWnl3?=
 =?utf-8?B?RC9KdmFKNDh4QVJpTmF3UlFJejdoVEVNejQ1YXNMeWk5Z1NQVCtoQ1l4VjdN?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af30d573-9ed1-4fc6-36ac-08db9e66b7d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:21.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJHJXDBdtQZyuoYMurUJKnnGz3tHChBgB+Qdcuy6W7iXy9aGlgNjPVqdGQBvsf+vt2/euK0ju6HtvrYLq3iVExSOl5t1YarABy56S7Cgo/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


