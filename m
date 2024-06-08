Return-Path: <netdev+bounces-102028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5569C901213
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4AE1C20A97
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5B17A92E;
	Sat,  8 Jun 2024 14:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F617994C;
	Sat,  8 Jun 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857380; cv=fail; b=g//j8war/ZGPTWaDR/7cCZayGBTE96dLC4ZlBEka97VGOz6qLdGNfmpsMYP+OdzvM5hO3k76icfvK57cD17mGIWU9ICYWFPFvbb7AtuiKKD3hrU6lyRGN9+QukwSZzSZvfdOAwur8eaXmwPiZ0IibYLxOOTTjZxiWMNC6oWxCH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857380; c=relaxed/simple;
	bh=humLBxJMcxSo5n/9wrWKE89K7ThNARFSNKhpvAOTMoI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=djNCTMWyNNZyJ3UXf7EtY/zgAmCTjBG9AwN+vmsvoHsqrG3UOxGStorybfVKF/ydnYlvsAV4h7AmGpGkBDqLndhd9cWfnPxhsvnBNGDji80IyPQ4RGMFgTzcEMPA/LdN1ub90SbqAObRaVSNwyPJSrGgP2CpX7aJEWabO0Scq8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458ER4mj030089;
	Sat, 8 Jun 2024 07:35:47 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymptg02dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 07:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3hW28OPCci4sb7VW1aUasE9RzhYoDucT6B4jaIUhJG2D+n5K8qlJRdksxsy6Q/zSzh5RJHVvF0QeBsAGOJ+43v89CopwoYIsB/7iOB4YAUwPX9J0ll4VhD340xNSW98hjs8qLWvXyJU5qsQ6BffZraQcruhVRkmeTHvdFYRSCsB4GsdLPym3oOO6qpAHuGZ8yNCLBwTTM+VXW/tW1NseFesry1ktZwJEr3mzJLBEDRPR9ZKR03dItWVEZ3o2e15i319pwQVkC3v0UvtxzOwvgTKjjUgcZPVTbEgSGdB064MCNmoi58PApH5ctYTDMjqo5G1fduA653K3PSDHgKJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFJEl64zBMSAgZ+Z+2VWJ8FB4Fnp91WtS2ddtwyfWjM=;
 b=n2V/dHRyc8f1C+G1IpwH4jBMI5S0L9OMiD/C1JZHZp9BPyNL/oTN3oAony8XSlfjhIOoFLGv3EDVXuVnPTUTxnRwcHIv3jSBGRKvt1/bRLpcxwW5qemDKVmY3uyEJpnILC+X28c7Apdbsu/eE4RSL2wCDWiJdk1YFvmpfPJuaBfqRoth3BBIzJ05weKpIN4Sofbt5jkm5Grop80/VlQCRiMpiJMwIWjYS+1aSo26uEpMexb8wZZIPsZ3nlZ6B6GYHNU4hwDyTLrLEAqpZYKfa5d76qfNZulHvkvnKd3RIkW1srV4LDJQnPt6zIPXVif1LwcO7XuyF95E+4FM3Dxm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Sat, 8 Jun
 2024 14:35:44 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 14:35:44 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: olteanv@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        wojciech.drewek@intel.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [net v5 PATCH] net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters
Date: Sat,  8 Jun 2024 22:35:24 +0800
Message-Id: <20240608143524.2065736-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a498f1-77bf-4eb3-2f96-08dc87c84795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ULbgkA4yGR1jRqPLIZ22u5SeZ79vkDC/6ifv+l3IxUpx18j9aBiJolXa57bg?=
 =?us-ascii?Q?rKl6N0mPeBofVSNrds6kmZjlw5VaIyO2N2mfz51o4Da96RJB1oO+zeTuEaVh?=
 =?us-ascii?Q?lPvj687JyLxyUjHD6Krfi9+hfbLarK2ai6sHCRAtIIW8GCVTKq8Pd2gbGcwN?=
 =?us-ascii?Q?usDWYJqOztPB66bF72A1LN+4hhLNSVI09L3sT2rMNH6f7QRLkL5Ua7pDQjAI?=
 =?us-ascii?Q?tUP2mvhWz1XnWLCgc+Yik2HqA4X6RT7G6aiSe/10lviPePqvSFlMVNdX2XvQ?=
 =?us-ascii?Q?tc3Kf2sNXOJ4E2FJN4aHhqw8RNN6UrWG2jUGJeQeGDeWpZBZ27xkIj23KNhE?=
 =?us-ascii?Q?+nOqautVGOIriC0cF7FWWqisqUv9OIwZ56LRvhhJIg5wyNvGco8xIe4vDVZx?=
 =?us-ascii?Q?SKPNRqi6fxg2fj3cK3zzkz2TXr9D2esNtDwZbJR8SEcr00jQY/v9ZFHUyC11?=
 =?us-ascii?Q?KkxyR9OGEuYlKjJl5fJJarLI6hQQufazSXkDqXT8pm3tJPp0qxA3gWFB9X8u?=
 =?us-ascii?Q?ZbRkEi+++dv3eJ5sPatN7DCvzEOgrORlpseOCS69LKTO7xu/ck+B0AfiJZo+?=
 =?us-ascii?Q?KoYOQPmRI3NYlZ4hspI339two5WA6LjrhVvWUot/Fra60Q7YGPaojjyfTXzo?=
 =?us-ascii?Q?z/hWwRNPvkPLjS4BnketBYBHkBEJi3/sX4WeDQfr8fucYXn9rnV/TEJA4A3k?=
 =?us-ascii?Q?uOFwdGXFEFHcUWWK9xKoXaiojAFj0hHpiZgtWlEQgiMAO/4B4NRbCg+6PG8K?=
 =?us-ascii?Q?imEdDz2Ht/NWeALh94Syq/FFDe+YEFZMiSja/IKh2tw5TBQbQ1FAMiW8hu0Q?=
 =?us-ascii?Q?e5Mj11LCqEkl6bHUGetYCKyZAMQIVvLIeQ+KLzDCGxtUVAvtYT79ObDt/kRo?=
 =?us-ascii?Q?anyZGhWod72k5iYRY96SMCBdqFafPhlobcvhEAMwWlyWZvFijKXNNyFnxKnW?=
 =?us-ascii?Q?Bd25xhaWgDp0u32NMBq8P0UfgWEfqObWaoD0psfiboE72O71W5sdcX1Akufu?=
 =?us-ascii?Q?kV1hrkd8wAJIFl5zM/c3mSk8bKiqc89wx+TTw2+cj9mWimGTDEkLfEcBXkLl?=
 =?us-ascii?Q?dCbZwB8hflp4MQrH02wzTmGogBOnyuCRuDR5FjDLcxHpcPXOKjERYr/TE5nR?=
 =?us-ascii?Q?1EeQZj436NkEM8njL9ctY1OMptZCZ/e3IQzos0W3hod/tykRBjl3dPJhhzk1?=
 =?us-ascii?Q?pq/Fy7YkKew23U2BsIzy511QDY/oaWj+gr2YufxsPIbM/dxoLZrHRmvgaEjq?=
 =?us-ascii?Q?3Qc2XRwBDJYlpfdEKjxHkefzStTWtbYugqlSNnJgKs2HYYCK96aFRVAhX5yQ?=
 =?us-ascii?Q?/RIlnpILquKDNaLxrKZ9WzMvArWU5WE9+Jd5XrYJgVmpOA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k0esxgQ8xYZ6LVEx0T5Ij8rbgVIzjnakxaAujAq0g2Z2XNrjknQaMej3H62k?=
 =?us-ascii?Q?8p+QG2p98JZlmy6AvHCiDN3wBo5uSF+FpzZzBzZt49JwGN+y7YId8U4sqml7?=
 =?us-ascii?Q?HojayVQc9lCbTdVmSmBzEYqc1gvkORk/UVNHXLQhKOXNMEvtoxv0QaHWQ8iQ?=
 =?us-ascii?Q?iLRmg8vJ/Tb0MRrQvWXnZWli5EhnBSZXV8f9IyHhjmaAWNbdGVHqCFg4QolY?=
 =?us-ascii?Q?KbpYEiPRPA9dLo/4ehH1aDLfEFf2wJibt9Mg4Uoi3FlQjZbWYF9CFwtH4dUK?=
 =?us-ascii?Q?AK/isukxt6IybU/d7FfHxgsyh0CAdTfXN7BWmC6kONLE0Ycxq2Q+ogUG/iKf?=
 =?us-ascii?Q?kUUszLxreZUmgdSDpWo1KIRTtCSktEeP3QgYGjdLEtlrL95o19ojOJSOyB1q?=
 =?us-ascii?Q?3MY8Buv20IoiW6tyqWLv7keKiT2CjmzIKF4IR6oXj5vazfKggKY+TZSmOo/K?=
 =?us-ascii?Q?osQsSwcYVxBS7B7RSutalXaiCdZ2845sd8tD1bqPdNwUfciBYbYPgasVV+yr?=
 =?us-ascii?Q?mWChuFkTjJpPycbDCUx8z683o/2hArms0753JMjlvWkECZIgH8sFT5w3lx2t?=
 =?us-ascii?Q?cHSBQDQR0ab8N4hlfyEz3+Z1wm4rlOlbIuOP2bey4/65SLIO9gwHStUdC5lL?=
 =?us-ascii?Q?xlPfAmdPw1CQUAl4QpJSiqJmxFfhPrDjogVbyeKCMbGUD+oQaoAhY099PREp?=
 =?us-ascii?Q?WRpJTratlyGnM/2ji0UDQudTxdnijLswU29cBP4D3GrPt6258QRX83nDH2DF?=
 =?us-ascii?Q?BPg9HUh8aUU3QCYlL/H2/MhcliFibtY5sAKGpcFY1j25SjoilrUCueO3QxOP?=
 =?us-ascii?Q?fd+HCDY2GPla4rGNFx9oWx7zE7oHuKcaPexwkdW+x9vyOFAFFjtORoLHqn+c?=
 =?us-ascii?Q?GSOwclJTQGNsxiwBObx8Gqjrncp92QOZkCOlW7Gf+tGiVLYgtzK1xGM+RN1Y?=
 =?us-ascii?Q?pW/vuG0BRSdkOA7yfLMkBXcG1HOlOTVE3a80DUeGt3utzuFCogZl+tvGgeqK?=
 =?us-ascii?Q?lTAE94KvrH0xy1rAmzKFbgXNKzCJqcJ86PKu0+XPOOvFV5RJG2XRsXp6pPRx?=
 =?us-ascii?Q?7KjbYTMMCeYYc4Tn5TW1R3IfoyPMBCxxMGxMHHvRR9E/wiL4pDEsNUpOKWwV?=
 =?us-ascii?Q?/z6TuGhB/8XH2/tb5jqBS7soLOHsZ6XJUJ3sIdikZbf8WUB2a+CgZUZrTqvP?=
 =?us-ascii?Q?QxgSxcZ5l7c35FIioj+Il5Gelxw+BDdOwunNVrD5wbX8w/o9vCRJcZPcD7wH?=
 =?us-ascii?Q?mxMFFDNNkhabUjDYorZcAw8qzFoFtlN5zIjsZ+IJ3SZZu9RFqFDvZKoE+MNM?=
 =?us-ascii?Q?H47Yrhn2HcBdFiogcJOrQUE3O41UrwgtVER57aYoeKRfBj73iFxQgi89Upa/?=
 =?us-ascii?Q?4MFdFoDXSE8+BQ/04SVSBRJMyOBz9Xf3X0+ABZXpZEKcoqVZm1CGED6g6i/M?=
 =?us-ascii?Q?PBLzpmfM/T9o0TpmadVZZeK8Y07QZbKs9IkrbYysL0R+w6WEQ3gqjBYjN+Ad?=
 =?us-ascii?Q?2fWoIKOyOseQm3JqNQEsU6pqwbrYzVAKj4fzif9fBDe0p9rEaxz52vmsEqzo?=
 =?us-ascii?Q?CAnQiss9clGj67AfCVf5FmkDCl3GMCDMsSuE5cZTJnjhsiRu1rzbf1cT6Bwi?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a498f1-77bf-4eb3-2f96-08dc87c84795
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 14:35:44.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eS1KMmMifW60rLnqA516P2awO/bc8ll314lOnlDsX0rvpdhcr8ZGUrZ9LCP9NpKzoN/Om2SmufDhYE1ey11NpHaOBRVexQFNMCtEY9GHMkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-Proofpoint-ORIG-GUID: 8zXWOovOOEywRzjEMXQFd83gt5BqRgvO
X-Proofpoint-GUID: 8zXWOovOOEywRzjEMXQFd83gt5BqRgvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406080110

The current cbs parameter depends on speed after uplinking,
which is not needed and will report a configuration error
if the port is not initially connected. The UAPI exposed by
tc-cbs requires userspace to recalculate the send slope anyway,
because the formula depends on port_transmit_rate (see man tc-cbs),
which is not an invariant from tc's perspective. Therefore, we
use offload->sendslope and offload->idleslope to derive the
original port_transmit_rate from the CBS formula.

Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---

Change log:

v1:
    https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240528092010.439089-1-xiaolei.wang@windriver.com/
v2:
    Update CBS parameters when speed changes after linking up
    https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240530061453.561708-1-xiaolei.wang@windriver.com/
v3:
    replace priv->speed with the  portTransmitRate from the tc-cbs parameters suggested by Vladimir Oltean
    link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240607103327.438455-1-xiaolei.wang@windriver.com/
v4:
    Delete speed_div variable, delete redundant port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope; and update commit log
    https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240608044557.1380550-1-xiaolei.wang@windriver.com/
v5:
    use reverse Christmas tree (RCT) variable ordering and If the portTransmitRate(idleSlope - sendSlope) parameter is invalid, add an error output to avoid user misunderstanding 

 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 222540b55480..1562fbdd0a04 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -343,10 +343,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 			struct tc_cbs_qopt_offload *qopt)
 {
 	u32 tx_queues_count = priv->plat->tx_queues_to_use;
+	s64 port_transmit_rate_kbps;
 	u32 queue = qopt->queue;
-	u32 ptr, speed_div;
 	u32 mode_to_use;
 	u64 value;
+	u32 ptr;
 	int ret;
 
 	/* Queue 0 is not AVB capable */
@@ -355,30 +356,26 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
+	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
+
 	/* Port Transmit Rate and Speed Divider */
-	switch (priv->speed) {
+	switch (div_s64(port_transmit_rate_kbps, 1000)) {
 	case SPEED_10000:
-		ptr = 32;
-		speed_div = 10000000;
-		break;
 	case SPEED_5000:
 		ptr = 32;
-		speed_div = 5000000;
 		break;
 	case SPEED_2500:
-		ptr = 8;
-		speed_div = 2500000;
-		break;
 	case SPEED_1000:
 		ptr = 8;
-		speed_div = 1000000;
 		break;
 	case SPEED_100:
 		ptr = 4;
-		speed_div = 100000;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		netdev_err(priv->dev,
+			   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
+			   port_transmit_rate_kbps);
+		return -EINVAL;
 	}
 
 	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
@@ -398,10 +395,10 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	}
 
 	/* Final adjustments for HW */
-	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
+	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
 
-	value = div_s64(-qopt->sendslope * 1024ll * ptr, speed_div);
+	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
 
 	value = qopt->hicredit * 1024ll * 8;
-- 
2.25.1


