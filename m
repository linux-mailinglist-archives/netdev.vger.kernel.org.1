Return-Path: <netdev+bounces-101783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAC900102
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8049D1C229AE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD415CD72;
	Fri,  7 Jun 2024 10:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04C156972;
	Fri,  7 Jun 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756465; cv=fail; b=Uu07jR3b1IiBm8IjpzB4wHDkmUTWuzO1wSsqn7K7DMEepYN4jKsStaLIktpHA1gGkUHhl3Pn/h4nr5xNWYGAcHxq4kdqNI1C/s5Cee5IKmqfL+K+wQiP6J93mSHvpzaCBIuRGGllvtPhCpLU/YkQg4L+0wy2wh7rE2R60GbPto8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756465; c=relaxed/simple;
	bh=rjZaXyjSausDnFlBhxOIDTpAKHQoXaReIRu3ZorQmfU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F6FIBjuk8T7xMnlkFB1Xz2IKouK5nep374ItB1xwegP0Og3iVekLOIf1L0b9Tb8atB+urt47R5q+SXbLe2i8rzfznfnILkCzZ4gCbCXiGOnJRh99HR7Lcmkxpeij7pan4Mfr8gtIuOpAZJF1NE3+YRTvyoYVbjQPj96ouDUUIkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457AM6dh020553;
	Fri, 7 Jun 2024 10:33:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yfruxea0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 10:33:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P05tDPfStYc3s3lgO456eHJxNNbZd2ulWLrDHci+di2IQK8KoqviZohMKM/G31y0lxfDloUAvUweCkcZkVw8pJ/nUTEA0zkNsNzN/sTxZYCslsMBCJ5WizYRpRcd42We/yjyridLAXT2ZLnsCfJ3mFrTTpTgSz4zIsFeQkMHifnvh6dptJtOPv1zlswqM1a+xFLRjjijKLEs5AmZlQqUAnudpSL7H8PXTHSZGASeM6fQsaKKfTF9zeSVx4mbmIVT62MMEvMCT8/TmdLUhOWyxbO16FC0e65GBZZxSUw5i7kl9vEf3gBZC+0pPp5GYo0DI/ij6cEhWrr7H7TgS+4OJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG9vdgK7W6pW8fRdx3UMmAkUSvhpemsSO7K7VMLOQug=;
 b=GiXFOj/LSpUvZvHt8dYWH8aGFGh92Mgq5yGaP9O+iFUwU7Ve1F/N70NGC+3M3V4z9przOE4A7DSJH6+3hM8gpXkFWHo0mUxIXzDprfsQYWq4I2J622UCyBq0kmF2KJM7IoJY2SbQg5dzKNH9BTDtPkgGyMhGsmxNnJHuS9D4LjZcVVvEPB/7afAfg2afjsUrcaba5W4T4swHlLyFz6y8xuCiXeScrY1CHnGZqY45IMFUNTVbw31AZ6IRc+3573SVvsugBTxYls/V+GGRoAPCppwSso3uMm0i3pb9CbYmoECi5Ni5TLEWCHUE9ku7jvJgLONVP38Z9HidQTJe62dYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 10:33:49 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 10:33:48 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: olteanv@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [net PATCH] net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters
Date: Fri,  7 Jun 2024 18:33:27 +0800
Message-Id: <20240607103327.438455-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0190.jpnprd01.prod.outlook.com (2603:1096:403::20)
 To MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CO1PR11MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 6945d9ae-9fbf-4745-e520-08dc86dd50de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|52116005|7416005|376005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sD7o+/fIrEA+ODTSUwRO2FTkC9Hxi4oWMtI6iKQncLWFRI87euaKImio07hc?=
 =?us-ascii?Q?LWe0ioRokHDfwFR7WGpOs9JbdfmUH1jJfAGv03B6MOpjhPcZFkSayFLw5WUv?=
 =?us-ascii?Q?MW5Oqf4WlK8QP0P0c/u6xWwmvVrXML5uyzk4g6pew9+9PXIp3aj2neHLPI3T?=
 =?us-ascii?Q?2HGRsgnbh7EM/1sQut7mbmktb3mW4cPzhTVEqeQPLVQbFO40RF+ToPsIxS7X?=
 =?us-ascii?Q?XZqiC/dxsvWSodrywpLRsWiZodW2/q/jisNO/lEcimySGhoHJ8ZTCluzD4aJ?=
 =?us-ascii?Q?Bw1Tv9jtpuL2s9GJY/ikCY69WxzthQYtYUZat0Di0M0p5exkyaZTx+dcqX5S?=
 =?us-ascii?Q?aGZV0o77dyAE2Sft+JaV6v5MX2NJrFyhtpOWcAyVuXqPpQyC1K39OB1K+HYu?=
 =?us-ascii?Q?6QoIKVJzcW4mHv/5ihns5Omg4H1fg/H+7xwO0bd5bH+Kc3bofdcuLbAI1A8f?=
 =?us-ascii?Q?xLTkgXMfZ+IHBDgRhTDV733Ovj7wk+mCqUJZDeEf6SqZJyFR5lAic0wftyh6?=
 =?us-ascii?Q?NQTFxnzZlyb5WbJWF9RKHPuY0udc73CL9QVyXu6w9hK0iZtxxcfRVWRK1GqK?=
 =?us-ascii?Q?Of5imOrXOkS8vhr/x4zi4d9A4h0+6cxKgwKKx3++tvFfQn8mGKH5YydcVg60?=
 =?us-ascii?Q?JtwRWHuA8ZB1PKY6suOyCyyJIYIicT6BEw5LwaB8mbvP9SR2EWLK14VsznwR?=
 =?us-ascii?Q?yedwe3YDbab6NNawv98DsvY+le4A5HCO6PRS8LX83lh4lX1wg6d9P1X0utkv?=
 =?us-ascii?Q?yfUTM52QYn5ChpqDt7uCwe40HeDSHCJ71dssF5bg5MNO69Iwhe2Yfd9SFWxc?=
 =?us-ascii?Q?Vge9vVUnKJ7os8C5SszKFsuTUCORMG+UA7QboZduZyYIiduF3/b+p1KqVsq/?=
 =?us-ascii?Q?GaUSSqTpOQoOqhgtay6AwxqKLTdupEKstNihaDaorwgCfNUXqd1eTrD2xOIs?=
 =?us-ascii?Q?nNO9332d5KUCG4PCa7gwny31AVRwwhjepXw6zEmPbmz2SQG1Ojd9+ay2rRXU?=
 =?us-ascii?Q?2TTVTfN0g+jlvOCr/E0T6YO84eRI8mN3B7fR7qOBOalt9uBL92K4FSsvrtwz?=
 =?us-ascii?Q?+x4qix1a6/c1FMQAjOiwWVMhmXOXvEtQaY+QpszG6AiVLzQZlERbfdReJHyf?=
 =?us-ascii?Q?3HTNoCIRxWbUGwQBUj18h4Dmi0/SKjExcuXg14sRUiwPq/hahb1TPrSIzZFI?=
 =?us-ascii?Q?oPJI16B0dyrwyvz19RWiGmNlh+Id+1yU3gXdsX8qMU8sYd/lkrLPgdIzIPwb?=
 =?us-ascii?Q?2mFYpZOKD1e5w728gAEuPZWbSVrv8eZdtu+NlnxomTJlPiB9G12AD8A+wusF?=
 =?us-ascii?Q?ZErmNmKg6xYQ5zsDEc4fxUJW3lpm01o8PiAijz65jnUOyEytu4yd4gWoKnZG?=
 =?us-ascii?Q?r2w+w90u5MoagxvK7bmP0Oma8yuV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(376005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nm4pWV1jlcfnFdSDVlHczStbVm6T8nJwvPmxoWzlMEJrTuDS2nC4e5gzOTaX?=
 =?us-ascii?Q?Pwq2EkF2H3Q/O/dSuRBVckzgWLYhTEsZ/mzrxSyuKVFFduMFjuQS/gI8CBsK?=
 =?us-ascii?Q?/qkBC/YLDmbYP+StjAMMqUkLk62isJ1SknwZJ71X2DCWAjeGgcg2Kq1mdegK?=
 =?us-ascii?Q?SRYpsW4KHyS6J1jCC/+qWbSYsmzBwria5p39BeT00oZe6wHw5wPNksIYQyXt?=
 =?us-ascii?Q?uKv+7966hUAofdPC07JjVFI3r3l6GUjyEynjWH/Jv5sYtPx5k1U46nbx7xMw?=
 =?us-ascii?Q?/ERWPMFGTO13Z5ZsAYwfUJnoCWdYwfd3T7zlcq+Yw1tch5PsAjzgw6KUtkYR?=
 =?us-ascii?Q?bVcPmHMAQllIJWZ5W0A+HdQj7GHKM21sV1K8nFVUxwhJxHwWdTGi0XNAtC+Q?=
 =?us-ascii?Q?InjCV0XGGAnIi6fcRk1fVxQn7GAJYSqEz9US4GtkrIPyuyIQIrw5ZyIQEKPq?=
 =?us-ascii?Q?30M1huojbWe7sn2Hl+5+PYMmYHpVx9LF6we1KBBd9h1aul+XCK6vjirHAmm0?=
 =?us-ascii?Q?MyUdVJ/uTK1EFUCzvycSxdzOzkPSPqs0B8BaGmseTu1LEQoX4pEA2enOhTgl?=
 =?us-ascii?Q?KSP1Rb1k5HqDi7MQn2ULWRMUwQKlxaDLSjNMONWUCmXIjHW+SkSC0NaGWL7+?=
 =?us-ascii?Q?HXUKbz2c8dq+kiERvaWlm7ey85OciobIcN6uDWGWP1Z0dnn69zF9Oj/5/RwQ?=
 =?us-ascii?Q?W3rnqiEg1v8Ff3tzcrHbyCCQjWTmq6UmN8a143xrf5cgsGlqs2FW6mnyi7gp?=
 =?us-ascii?Q?sijg+d/HjHWWgJsiESp9IqXpaNKwiMiKRkNHWxCXg9FpJ5BMSet2qA1nGzQC?=
 =?us-ascii?Q?TMPsK4ZbXGuY8hSPD9qIZTc+TMCmqxDkQ9VH0ai+FDayDKiWqamFcbegKfDf?=
 =?us-ascii?Q?rlB4VgcOFaX8YhyLLAD+PCLHq+PhUEI9hlvct8hUXzwYi/YPf+mrrrhOi9zQ?=
 =?us-ascii?Q?MNy5WseGtw8UYOyy4YJ7ZfX7vgE77+RblYawpbGp9vt2zfZTYoc9koXkzLqR?=
 =?us-ascii?Q?Z89Q2cVPR+Pd/XtuVYOO1lt33vWKDAHmlRKHboTu7AqcEn/g6sQDh5aVruhY?=
 =?us-ascii?Q?7AdHJyqx6WGyDVNOu1uqum6jxfcteTsF34qYDSL3rNFzb+EtFIdMrKKZxtBZ?=
 =?us-ascii?Q?WnFZ99IoumkCKvdodxl4NhYepG+C9tGxuO+l/KIyagPvgtraeC9IXNXZTdgz?=
 =?us-ascii?Q?9TMlakhist5Dz85F1qV5ygM6ysBFOargBgzISqU+LOUW1tow7Z8Kl5SoOZQW?=
 =?us-ascii?Q?6xASZ270PfC3iFxLxP1ReuroQaWRxtfzpb7WMmkgT3m3iPSXG5dKaAeoHKtn?=
 =?us-ascii?Q?CbBsqFJ0ncpuuTWnzR8D6KavLeAZkVBLZO4elIiJYxGEel6XBlzOTudbQ5ji?=
 =?us-ascii?Q?T95achWgH/xKM8fBzlQ6SHs6FF4L96OgtFpsjlBoVQvnxRFSSAaaMyLY3nse?=
 =?us-ascii?Q?fX8u3gCB7RQ/U21BfFmH92pNv1MNciYPmeNnAe+f6ZCwxfPga/h+5o+QcVbO?=
 =?us-ascii?Q?PMSlLWdyoF8PgSUC1PCYrpg8FMTcG/dRFgEnp0QxSpW3+ewrJKMkPtPujI5r?=
 =?us-ascii?Q?1BEanPZ608qlfk9TAuB06ffzFcytZsTbkmRg1IKHHuv5I+6Ce7+HDMQ0LIY4?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6945d9ae-9fbf-4745-e520-08dc86dd50de
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:33:48.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJaagEPUsLQPvJ4YPpsdra8A4UdCe15Olm0Nm2PC/mIRoPbS6ublBstF92jy1qJ7G9E0YxPdqhqQxujGssAbT8ALaiIquy4pEfTdamD4jQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-Proofpoint-ORIG-GUID: xZnOx9tPZMxnhTbQp3AwyqzWppBwN127
X-Proofpoint-GUID: xZnOx9tPZMxnhTbQp3AwyqzWppBwN127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_05,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406070075

Since the given offload->sendslope only applies to the
current link speed, and userspace may reprogram it when
the link speed changes, don't even bother tracking the
port's link speed, and deduce the port transmit rate
from idleslope - sentslope instead.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 222540b55480..48500864017b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -348,6 +348,7 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	u32 mode_to_use;
 	u64 value;
 	int ret;
+	s64 port_transmit_rate_kbps;
 
 	/* Queue 0 is not AVB capable */
 	if (queue <= 0 || queue >= tx_queues_count)
@@ -355,27 +356,24 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
+	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
+
 	/* Port Transmit Rate and Speed Divider */
-	switch (priv->speed) {
+	switch (div_s64(port_transmit_rate_kbps, 1000)) {
 	case SPEED_10000:
 		ptr = 32;
-		speed_div = 10000000;
 		break;
 	case SPEED_5000:
 		ptr = 32;
-		speed_div = 5000000;
 		break;
 	case SPEED_2500:
 		ptr = 8;
-		speed_div = 2500000;
 		break;
 	case SPEED_1000:
 		ptr = 8;
-		speed_div = 1000000;
 		break;
 	case SPEED_100:
 		ptr = 4;
-		speed_div = 100000;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -397,11 +395,13 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
 	}
 
+	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
+
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


