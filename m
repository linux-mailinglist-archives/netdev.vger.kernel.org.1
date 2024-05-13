Return-Path: <netdev+bounces-95834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D68C39E9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F3F280C14
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87013D304;
	Mon, 13 May 2024 01:45:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589112E4A;
	Mon, 13 May 2024 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564703; cv=fail; b=sSxH/VmBkdVrDJbI6NVICIUi7oDCvkeU/cklIW6jurnIoDo9XGs7d/NnzS1lA9qRQYA7LAde8p5l7Uq2b3xKi+dhDF7YqZ06JP8AqoC5u1XQDmqj2m+Az56MD24X8oXhFhZ43besBdWtczVq1wwh3KQEYsX7F1W05KpJsSKY2+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564703; c=relaxed/simple;
	bh=fHKe9SF+VpxWdi2ZqsmUJWNqFb1ktLyX8Ffq7Rlp1og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbUbdf563jF7nvCIwbZn8S4E7MCqyHz4nkTQMTal7XbLWQ/MywDHgplboqk6RlHnI9Tr6Rc8dCL+HjNlr+BSGoDnyge3clqbMuBoLFSPfl5RZrHAh+xD6j1PWp4EX/VfJPsU04hibqC3Ei2XeP5XEmvcVbFWOUTUZxXAQYclG74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D1WjZx026985;
	Sun, 12 May 2024 18:44:18 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y286frxrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 18:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu7Pegy1Cx/w1f5AeZU54NilcKlGiXBbxfVZZFZhyV1BDSzzA9mGZMM1jWWNnqSzJELMJI9MJnJKgqLOlIh/zAPNg2YcHneUZ/dcifXdKvrQEkQ1OlSRUheSqiu84RRiMafv+H+8Jf70YJMBWIM6RNa57H760tUf2cjB019Gi7m9fyac17/R3UEoi4+R67E23T+SsPy6eWWTAisvix81ve+GIseUGqOL9m0oOXXNmqSeXpNYK2gfMhpO8XYxEIk6/elhR9nXyKjm0vcZzAhARxjJJcVXpBWOaaEdlN5TKNXgPBdRNNadkg91n+yEI5VlR5l8BiPXasFvJ1HZuXKLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z+HR2dG5qVR12p2+7Ib6LqM9ccp2WvkFUBOkQ681Kk=;
 b=is6PTPCE8aBNXBl84yoUCO0WKwK1wSZr93exGIW6b+plV91d+VeRmWmw55x2W3NYxBVZCDSSPuirRG2tR7BTM3ObYLcsXmiPB5+9gnv1zOKfznp1GsEtp/vclx6RvWwWcUANzCABEhS/l0p45R9pqbme93v8ntYGLwFMjx8aVx75vXpeo5rLGseQVkD1Blc5/hSOhz45eofhV6jCMRyBNENwBweGZF3oBzI6V1N5t2kRC3G7iYzqP97sFQMkRFQPxyb/iFL5KZ3w+CKVu6IiFU5xetyWuqeBH0CEYMAZzFAuB7JfCbzVOE0vwVFWgjWthcwR1qcJyl4iV9qJWvlIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by PH7PR11MB7477.namprd11.prod.outlook.com (2603:10b6:510:279::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 01:44:16 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad%5]) with mapi id 15.20.7544.046; Mon, 13 May 2024
 01:44:16 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com, ahalaney@redhat.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v6 2/2] net: stmmac: move the EST structure to struct stmmac_priv
Date: Mon, 13 May 2024 09:43:46 +0800
Message-Id: <20240513014346.1718740-3-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
References: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|PH7PR11MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: f21b92e9-f6b2-4ab9-3054-08dc72ee32e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|366007|7416005|1800799015|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fDgssn/pGQnbWnIm7fkiXEZGW7spxJ7tvvYpvNSFHIykwaxUcZXjtSHYG1YK?=
 =?us-ascii?Q?XfJiYV47aaXziTQdrhS0QBPzSqv9S5gZj/vTRWoY0byUPa6VTL/luQbsqPe+?=
 =?us-ascii?Q?E8wQqEcXqwRFODesZn7FFriDQXpSWEvVPe1anSTbJ71l3nrY/HoDu2+MF0Q/?=
 =?us-ascii?Q?dcVD8m4DDEbD0eswDQoorVbqruanwuLx186AqnLqNI0fP/RsTGP9Y5V/OJwB?=
 =?us-ascii?Q?HVYd1PCj83Y3Zek9cPgm60qK1ktcKNiUlwlNmxOPHD5xPvx0xAFQ57gjwQvP?=
 =?us-ascii?Q?90n55E3fUOVDPiGdChv/bLFNQmEjaf6kglJTy5e3fuL/yp4bkzijb+VJFYna?=
 =?us-ascii?Q?xhgpg544SFp0+gtwS0Sf64iSLNxv/IOMsLVQxLVOG7dLgnFECB+gE22woGBE?=
 =?us-ascii?Q?Hja8jXfAlVcN1GZeSNtaJGLq7HPuj04cFa1EnsJm+M8wtC2xd39f0i8vTT7u?=
 =?us-ascii?Q?ZcR3WQkb/FOI2yBOho3shhhzQIAxASrnM7n4I4o1wCTr7g6DRhVncq430p55?=
 =?us-ascii?Q?gaLBu0zteHNWMMWlmeeup4JRZBQyb3wlbf54XFgrOzhFoIkDUAW+Mo9XViXg?=
 =?us-ascii?Q?j1Bt8u+4qswlKzTQORcsTDNpmUeKZLkMPAciV9aQD+qs/6vLgwd1vd3fHql8?=
 =?us-ascii?Q?z7As9wNLW+pdfwKjkW/jpj24DUTHdYbGApJh7dLKZ0pFO1WFCqho8uLsf+5R?=
 =?us-ascii?Q?GnJnk654Qy5K0eJXi7prnINkVl8hFDRLyORIU2oDS5AI2DH+m5XrGhc9h1UF?=
 =?us-ascii?Q?9TxzvEACZuwyXYAbFL6ZZQkE4ct9hSNZplZldmVRJVuY3w35GbSXVEM31toJ?=
 =?us-ascii?Q?VfKP8uYXDXwRSqBgpUZydLVeSBs8gUIO3TOR7Py0+cf4jvEFcvXEmRtPJhqJ?=
 =?us-ascii?Q?G6rlO5AveIxwXWXtE7eSeo4jD4K+bkc2o4KppOtlQGhM4wD9fOIBdOoeiq83?=
 =?us-ascii?Q?B7SdrkPRrbfO8eXIyc4OENP6waysPY4vT9WtsLcEDlKS8vLoDDRNrdREHvwY?=
 =?us-ascii?Q?VGR+1oJCy4PLor73w0T5e3Q/jlw/BCQR5dQSzzsO2Vybzsd4/WGDi4g9Tf3J?=
 =?us-ascii?Q?b1WoyL6LCuGZQpXJY5hv3ZNqhD2t+rIHIceVR46LoxdUPXI2XitkweJ/ufBg?=
 =?us-ascii?Q?DwPr2uzB1odTPkW6cfklNTCExDsKDRgeEe/+ymovJpxPFrQ+fUbSw02pS8A7?=
 =?us-ascii?Q?vJXAm0mBAVLHwEclhGV78GQdOrcdH2/Bqa+y5u1bp+goT58hL8sRiTZEkoLB?=
 =?us-ascii?Q?P1MqoD1Ftxx1EC/bNj55LAzfe8Nmg9eSIAQ/KiVrhTdcumRMB7MBnW7Hb2tF?=
 =?us-ascii?Q?n6PvFwF1ZgKZZB8+8FwsU+oSWwhKI6aPsmES1BvpepGeMS4Lz+dLSLqVdKhB?=
 =?us-ascii?Q?qMJUfwo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7hKTS5fN8qoIPRBuLl82pzFWr/b0PjwfB1AfUkC/y/EABaDz3itatwl/uodj?=
 =?us-ascii?Q?tNxJZZWFC1OLyI/JezYM5vcTKc0xVnWk85KZ/GGyEwR5l9RUok1R67ceYG9L?=
 =?us-ascii?Q?wMPXfBconlbSERtglXDqiKz0UBTCrncrUrRj3V19UsqBPKIP+6lf8LEgcX5S?=
 =?us-ascii?Q?G86e0IoTMJRckFM75IoZ7ESPa3FfAMMDx0WNNsDWa9Yx1kDmSpH1c/CyETCZ?=
 =?us-ascii?Q?ROT5HhfbhHVP5e1BFjz0YfBD5l5ckxt6/F4Gp08NPvjeJJBhS6b2hJhSfGkJ?=
 =?us-ascii?Q?043PXBFz56OFTH1o50aVnocM35KCi+MUBC9uBJFFP4TcsQRRxGas554dVQ8q?=
 =?us-ascii?Q?knLcxB1siAUzrknvpv0YzRm9V6WZ1OJthIRe2c85JK04bYEqoxg+A/f6D82f?=
 =?us-ascii?Q?IQDprmPB+RqbjycVQMBxPVSWL1O7V6A542ZRq3Lo2p0Vu8/zBa/q+oEYuHDu?=
 =?us-ascii?Q?7EUCuaMaMPqMEfyIRv1Db302eyROSFprpeq4CDDgnuLIwTlbtLqBK9L7A55g?=
 =?us-ascii?Q?V1EAF32JZg6IjCRpPDlSbwJ+nmw9uBOgVsmUzhEzIrds9wIhGO+DKA+jwtGx?=
 =?us-ascii?Q?KuvrvraDcwYao+ZFnfEDWTTTyngFEKfUk+M/r5Me9xbtqgPCZn3TgmjDBvqU?=
 =?us-ascii?Q?T7G1AVADnrSlORpllrFZuAzyx/wZ1zCRb9YpTX3Vs4EHwjIYQ4u2Cq5AwoWe?=
 =?us-ascii?Q?/VbB0VJKMOUaNmj1HbQFRj5GiubMp4uHLOC56g+3XEDp3fBJe66C0WQFD7I2?=
 =?us-ascii?Q?RCCSzzSG/aNGgBcIeqJ5ZhWulc4IuQXbXOxSkTbKuhtNNKj1mye+wp7ZozUr?=
 =?us-ascii?Q?w7BzOufdOmKe/1YBl6P2VibEG8/7Hi0Ns4FN0/b2cDBdDna92oTcrNYSy2n/?=
 =?us-ascii?Q?6HeqruCKINY4tWXqwUHMJbaCJVRvi0feObJ5bnMwoAVQJgt6ZM5gk2xpuP/b?=
 =?us-ascii?Q?gD4HA7w+7Ncs8q+U0PaVYzgBFZDBniuGRPJuMxVrqAhfi9duLYBSQ4Ig2kRU?=
 =?us-ascii?Q?1lVuhEUDTjt1va4neuTreDKEhSBxwxWK/vrb7f5oQWoJOOKQ8B+XOf6l+ro8?=
 =?us-ascii?Q?2dtSZPPdUJH9WWtHHw8XCKo190FNhxkZn98rIbikRzB2LP6QyhJPbqVY6IrB?=
 =?us-ascii?Q?BobDS3oX2eiv+ClgfSHk7lhB+99bckhT8TUEz/H87ZtdbIA16agNAaSno0Lt?=
 =?us-ascii?Q?A3F9GtdHiEYF6WQuBSwdvuqGvvuSG51oEKjjBKCRaAPhgKfIGIOEMQIB2L04?=
 =?us-ascii?Q?ZfeXBCuYVlJIv+QX3jxVUqrfUpEl1nMuH3n+l/j5M1+IjYr+gU0usECUeVVJ?=
 =?us-ascii?Q?OrfVuE6Pln76PFlYrvjvfXhNss0X5p0P3rxjeV1/0dA68FKJjG27BA10eC17?=
 =?us-ascii?Q?nmZwBiiyY+O2yBnPOBKJHwo6W+QcyLrLhbnGEq4YJVbg8ednO4n7VidSYusM?=
 =?us-ascii?Q?f5e8ZwZs5ocEa3VkKbkpgEDI1PUwtGLksFLfub4f9Cod0oV6/EIPM3T9ZvaK?=
 =?us-ascii?Q?oRD5WksvDspInYw8X2YAfmnfJJ3xplUqNcsZhUChc9BL6QK2j5PgTPFXoixr?=
 =?us-ascii?Q?lIFyaPOsswB8oF2BugTtrw8sa4rYnPN8qO0IcRYGHlgywlsIA7X2F2av1PFE?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21b92e9-f6b2-4ab9-3054-08dc72ee32e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 01:44:16.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+tzT+Bq/6VW/TemC5AcWhPFYoufMlW9RuMRqVev+0+u8gFA0p9xn9+fsrUvz/e0vsvxw4jeuMd/3qPGxSpmcGZFuyzwasdf2H2QHJjlqAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7477
X-Proofpoint-ORIG-GUID: rZgV1wD_InYwmkpXlhbiL23_hdNiQL-F
X-Proofpoint-GUID: rZgV1wD_InYwmkpXlhbiL23_hdNiQL-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_15,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405130010

Move the EST structure to struct stmmac_priv, because the
EST configs don't look like platform config, but EST is
enabled in runtime with the settings retrieved for the TC
TAPRIO feature also in runtime. So it's better to have the
EST-data preserved in the driver private data instead of
the platform data storage.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 15 +++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 ++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 22 +++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 40 +++++++++----------
 include/linux/stmmac.h                        | 15 -------
 5 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 64b21c83e2b8..011683abf97f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -221,6 +221,20 @@ struct stmmac_dma_conf {
 	unsigned int dma_tx_size;
 };
 
+#define EST_GCL         1024
+struct stmmac_est {
+	int enable;
+	u32 btr_reserve[2];
+	u32 btr_offset[2];
+	u32 btr[2];
+	u32 ctr[2];
+	u32 ter;
+	u32 gcl_unaligned[EST_GCL];
+	u32 gcl[EST_GCL];
+	u32 gcl_size;
+	u32 max_sdu[MTL_MAX_TX_QUEUES];
+};
+
 struct stmmac_priv {
 	/* Frequently used values are kept adjacent for cache effect */
 	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
@@ -263,6 +277,7 @@ struct stmmac_priv {
 	struct plat_stmmacenet_data *plat;
 	/* Protect est parameters */
 	struct mutex est_lock;
+	struct stmmac_est *est;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c6fb14b5555..0eafd609bf53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2491,9 +2491,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->plat->est && priv->plat->est->enable &&
-		    priv->plat->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->plat->est->max_sdu[queue]) {
+		if (priv->est && priv->est->enable &&
+		    priv->est->max_sdu[queue] &&
+		    xdp_desc.len > priv->est->max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
@@ -4528,9 +4528,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 			return stmmac_tso_xmit(skb, dev);
 	}
 
-	if (priv->plat->est && priv->plat->est->enable &&
-	    priv->plat->est->max_sdu[queue] &&
-	    skb->len > priv->plat->est->max_sdu[queue]){
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    skb->len > priv->est->max_sdu[queue]){
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		goto max_sdu_err;
 	}
@@ -4909,9 +4909,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
-	if (priv->plat->est && priv->plat->est->enable &&
-	    priv->plat->est->max_sdu[queue] &&
-	    xdpf->len > priv->plat->est->max_sdu[queue]) {
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    xdpf->len > priv->est->max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 0c5aab6dd7a7..a6b1de9a251d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -68,11 +68,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
-	if (priv->plat->est && priv->plat->est->enable) {
+	if (priv->est && priv->est->enable) {
 		est_rst = true;
 		mutex_lock(&priv->est_lock);
-		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->plat->est,
+		priv->est->enable = false;
+		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 	}
@@ -90,19 +90,19 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->plat->est->btr_reserve[0];
-		time.tv_sec = priv->plat->est->btr_reserve[1];
+		time.tv_nsec = priv->est->btr_reserve[0];
+		time.tv_sec = priv->est->btr_reserve[1];
 		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->plat->est->ctr[1] * NSEC_PER_SEC +
-			     priv->plat->est->ctr[0];
+		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
+			     priv->est->ctr[0];
 		time = stmmac_calc_tas_basetime(basetime,
 						current_time_ns,
 						cycle_time);
 
-		priv->plat->est->btr[0] = (u32)time.tv_nsec;
-		priv->plat->est->btr[1] = (u32)time.tv_sec;
-		priv->plat->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->plat->est,
+		priv->est->btr[0] = (u32)time.tv_nsec;
+		priv->est->btr[1] = (u32)time.tv_sec;
+		priv->est->enable = true;
+		ret = stmmac_est_configure(priv, priv, priv->est,
 					   priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 620c16e9be3a..222540b55480 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -918,7 +918,6 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 				     struct tc_taprio_qopt_offload *qopt)
 {
-	struct plat_stmmacenet_data *plat = priv->plat;
 	u32 num_tc = qopt->mqprio.qopt.num_tc;
 	u32 offset, count, i, j;
 
@@ -933,7 +932,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -941,7 +940,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			       struct tc_taprio_qopt_offload *qopt)
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
-	struct plat_stmmacenet_data *plat = priv->plat;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
 	bool fpe = false;
@@ -998,24 +996,24 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	if (!plat->est) {
-		plat->est = devm_kzalloc(priv->device, sizeof(*plat->est),
+	if (!priv->est) {
+		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
 					 GFP_KERNEL);
-		if (!plat->est)
+		if (!priv->est)
 			return -ENOMEM;
 
 		mutex_init(&priv->est_lock);
 	} else {
 		mutex_lock(&priv->est_lock);
-		memset(plat->est, 0, sizeof(*plat->est));
+		memset(priv->est, 0, sizeof(*priv->est));
 		mutex_unlock(&priv->est_lock);
 	}
 
 	size = qopt->num_entries;
 
 	mutex_lock(&priv->est_lock);
-	priv->plat->est->gcl_size = size;
-	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
+	priv->est->gcl_size = size;
+	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
 	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
@@ -1044,7 +1042,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
+		priv->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
 	mutex_lock(&priv->est_lock);
@@ -1054,18 +1052,18 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);
 
-	priv->plat->est->btr[0] = (u32)time.tv_nsec;
-	priv->plat->est->btr[1] = (u32)time.tv_sec;
+	priv->est->btr[0] = (u32)time.tv_nsec;
+	priv->est->btr[1] = (u32)time.tv_sec;
 
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->plat->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->plat->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
 
 	ctr = qopt->cycle_time;
-	priv->plat->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->plat->est->ctr[1] = (u32)ctr;
+	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	priv->est->ctr[1] = (u32)ctr;
 
-	priv->plat->est->ter = qopt->cycle_time_extension;
+	priv->est->ter = qopt->cycle_time_extension;
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
@@ -1079,7 +1077,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	 */
 	priv->plat->fpe_cfg->enable = fpe;
 
-	ret = stmmac_est_configure(priv, priv, priv->plat->est,
+	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
@@ -1097,10 +1095,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	return 0;
 
 disable:
-	if (priv->plat->est) {
+	if (priv->est) {
 		mutex_lock(&priv->est_lock);
-		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->plat->est,
+		priv->est->enable = false;
+		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate);
 		/* Reset taprio status */
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c0d74f97fd18..5da45d025601 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -115,20 +115,6 @@ struct stmmac_axi {
 	bool axi_rb;
 };
 
-#define EST_GCL		1024
-struct stmmac_est {
-	int enable;
-	u32 btr_reserve[2];
-	u32 btr_offset[2];
-	u32 btr[2];
-	u32 ctr[2];
-	u32 ter;
-	u32 gcl_unaligned[EST_GCL];
-	u32 gcl[EST_GCL];
-	u32 gcl_size;
-	u32 max_sdu[MTL_MAX_TX_QUEUES];
-};
-
 struct stmmac_rxq_cfg {
 	u8 mode_to_use;
 	u32 chan;
@@ -245,7 +231,6 @@ struct plat_stmmacenet_data {
 	struct fwnode_handle *port_node;
 	struct device_node *mdio_node;
 	struct stmmac_dma_cfg *dma_cfg;
-	struct stmmac_est *est;
 	struct stmmac_fpe_cfg *fpe_cfg;
 	struct stmmac_safety_feature_cfg *safety_feat_cfg;
 	int clk_csr;
-- 
2.25.1


