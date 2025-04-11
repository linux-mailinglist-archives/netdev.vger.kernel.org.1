Return-Path: <netdev+bounces-181679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A3A86140
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C948C77D8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058F204840;
	Fri, 11 Apr 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="AocUT/WW";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="ZgBVEZbf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF91FBCBE;
	Fri, 11 Apr 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383894; cv=fail; b=jWidfYYYZcQ126EPjK0oWPHoi0P37dFaQ9f+9sBZkQ9OQaVsUGYjDOfs/smspNeVF0DDW7mm8xNiz914qEBlC1NCCsVbvgDNLW+cZC4FPMUL4Vs6WIHuIpjGs3Q/p901w4o6v4BJwWachiMhUv7oe1TZLoL6wu/42ShPJkNcbkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383894; c=relaxed/simple;
	bh=BVVBpa3x9tins8KUWLlm6NrkQieYoD0NB2b3BdTxNpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8cNg7U3FSWMCvL/nKmepej5EF+dufIjIhImIXfgZ1fHMdMJhogzRDqoHeAzE4cyscIQlH56AEASr8ZnmHXE/Hrfr5ZEUhynnOIUvg9nkwAmQL0SvlW1pNUJe6yW39EsXD9TVPpMHrp5fpqJIupQn0wsYBnK6BraFBnpmGFRixo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=AocUT/WW; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=ZgBVEZbf; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BDrvrg032137;
	Fri, 11 Apr 2025 10:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=LAPdk
	4IKWbWVNG4e99TR1bO0ub4bMqDP88F7DcxUx/4=; b=AocUT/WWV+cc9q+Eoj1HI
	Brfe3MEtSDP9TMVDgIiZtWPeZQ1YXd3ZPK771/O/lx4Pz+NkDwLYQtkpRmqrdvPC
	MunL1RumLRCtSxt9DOxOirtwlH5z+HRk4CQX4ZrIpqU3BJkNT36lqQE0ei/KDSTd
	3ayeH9lK+52/aJbwq+E7LoKAIVUW6BEM4EH1DeBEvV0mhfpGFI2O3KyYaI1jCVgU
	ctnFJweFgTssX2z3CIcFTy8WuRveIuli6TPUIWq5Q+VBtfnkGdjX7yZqaje55Vf4
	5wcTTAp3q20WP52vQFvF5p+VE8KwV++zIffg+5awRPB4p83G3Ms952aNs1JL0lhl
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45y4bn047y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 10:04:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaejWiL7ontO6LyscnhtyrEOKxRfB5VyJ0g4/w1GTjhomc6/3BLX7AUuHwv/ydgpdBwWrUUvxLFcwjLjgcorX7r17hTdrD9e+DYZ1X8CiZMPNiZnLYfRBcoSoXs+PjG49YQuAbbxaW+3a+7exvw8wrBgVGjMPRq5Y+MN4UCQalHNur5CrU+ohWh6esB92AGuDJxSjHhWRFmB3ggVqRRIPxhg3T+e+6AoT6IpXmIo22sptQMCwpO290rI98rdGOHFErWvFPMigl7x3mSI1cHxUQScHF2G5vzAO0ch/1Cm6AzB0fDewLE9e3Y4Pn/QWCrh1KzPRuwr12wg4WXFaZDZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAPdk4IKWbWVNG4e99TR1bO0ub4bMqDP88F7DcxUx/4=;
 b=JKZMs40HpHOMa4lqAHH93gM4HN+feoXMy7F6K4f43Gw9+beIPWFk8pGdOTS0recjE34kpSczxWMSkSdfmDnJbiELH/ZyV9f6HOSAz+sNZhtxv5wq7iq7rMrC1/njxTTiGG5eWOPQxLzag2MUVngD0aUvD4jZY6p2zOOhhgMuTnA8vU5CRfq72erB4jkrHhg0+ZQ1UDnOohNHqmQ70dQpTTtNqfSNNr6+0bl7yjrI3LuF1C7h8ID47ttf5Z2NYLK+SppPmtiuCbOzq782CcoLATTyu4ycXEW6jEAraQSLjca68BsDAMRAFYtPFKmmaMqjDuiqkOEpEyP3xI+YgMexEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAPdk4IKWbWVNG4e99TR1bO0ub4bMqDP88F7DcxUx/4=;
 b=ZgBVEZbfu6W238NGqDjIgxfo6njSpTT8V0gztu3hjacyGirgJWq1KPRNCV5f+mNY4GHj4OEkk17x+Nx5ANcubwQ/wOOiCA9XFk05Xvn7P0NLZ60HLixVDan9oM0NCHiX0I3XxMu9BOdop/ZpwENSWJlKwECsmMiMMe+yyVEzf+h/XIGcL6zFKptAtsQMI7UXA7bOzXF5mcVxCUkrUxZEfkr9pNwO1+e9M6gsz6gKBS8r6t2bQcy83CzNDm/JiQQtYgD6SFZWrolepulBhKemna7bJm7Bddk/S0L//dRqy9cAVfzHDSAnXccrgZO76Tk7oD6tm0ldmekd64pvSB3/Xw==
Received: from MW4PR04CA0322.namprd04.prod.outlook.com (2603:10b6:303:82::27)
 by IA3PR04MB9111.namprd04.prod.outlook.com (2603:10b6:208:525::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 15:04:36 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::1f) by MW4PR04CA0322.outlook.office365.com
 (2603:10b6:303:82::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 15:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 15:04:36 +0000
Received: from OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 10:04:25 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Fri, 11 Apr 2025 10:04:26 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Apr 2025 10:04:26 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 10:04:25 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
        Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux.dev>
Subject: [Patch v5 net-next 2/3] net: bridge: Add offload_fail_notification bopt
Date: Fri, 11 Apr 2025 11:03:17 -0400
Message-ID: <20250411150323.1117797-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
References: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA3PR04MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 19231ea7-b40e-49c1-4e6c-08dd790a2cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oeQ5cw6Z5T9+scVRMgWgtzaQ+GK8ppUTSdp+bkJliY/kBS4VOzHcvZm4P9RM?=
 =?us-ascii?Q?WRmFPDJk+fA3RsW/95Ym0Q2Cd7IP/hnfoBye0d2UCN2GPwHuFyrybTSTlFUh?=
 =?us-ascii?Q?VL607/A4ZUOpMWnBjXp/U7WU55K0IlOP6BxklG4Ci/P9ic0eDscDKcyinNtD?=
 =?us-ascii?Q?/WtiJGhk/5gjvX30ocIG06epXVJt5Y0MYqkHTd02hMAGkD8f3dAEOCw8uR8s?=
 =?us-ascii?Q?fniLwJD8wJvCB+HtR5+X7rEp0xGzVPyK4tCBUzNCSM8pFK4uRS2rQbT57R9v?=
 =?us-ascii?Q?OfUX+2judcFCTv2KfpMqrrq2WemW6luRadpilK1l6+OtifrDgNFVs8mXjvvO?=
 =?us-ascii?Q?gIt4zX0mxXKkze0laRP9BbeVpEsCVkEsA7ov2VCF+Ni6/tFj3/dTeylPm8Fq?=
 =?us-ascii?Q?gqRHIjNAva6MWpwaRcgOnkcncXOGZ3wCZ8vQTAInRz3I1dMx+HL2Vi+GDSK6?=
 =?us-ascii?Q?9EQTZvsNmxWsmOHeAkDC75n/t31HhC50BEvz64XNRsaoL8m5WpzOCZyGcTTk?=
 =?us-ascii?Q?dT2Pjog81VGr3RARpgE+Bf4hzrpq2z5uzAtnpu0H3+CGsDQPNDmi5ZPEG0EZ?=
 =?us-ascii?Q?ALOF/uwgPQ1WAQS8KkhDmmalcSr4GweEpXJBzfNNXlqC7z8oKfXHTpkhbWK4?=
 =?us-ascii?Q?/AES40kU+9ce33tX9O6/+O+p6tWSFisw3cxqMMIiD0/tqK15ij1isHaoyxCe?=
 =?us-ascii?Q?mxo6Vjges+c2/ih2ZKeq4zTDMhl0JKUbOdUDHoVOvJ+8cjngNbD6Xyh17yH6?=
 =?us-ascii?Q?ba4+DIQX2oQd5HZb+e33mrLF6rEtSc0b3ZPuqI8a6zp50aPRl4ZC+6k8V7jF?=
 =?us-ascii?Q?QOcWZVaHE5bS3FU7K0Fbz0N+55bPouIzEl9y44JbJZfx23AIWQ9iTmBpK316?=
 =?us-ascii?Q?oMnRx+Y0xx4vBcxZD8pHrmUYAu3wiUzvTZswnkvjyGjmLZ5pw8Z7drlfkCoM?=
 =?us-ascii?Q?CZYNhiwv+X/azLMO98TthzRzB+9V/72Dms+C1Y8658FBB+6esG1V97qtIkR/?=
 =?us-ascii?Q?t5DSrR/sCIx7bjI1BqnbdR3itHHyihelHuC/7HmSAWK29rYTt5yUXnycaHML?=
 =?us-ascii?Q?Wf0xorNSchptuFw0eVycY1kT7inSY8YoqNmKznluAUOLfE/Khke2tKpvfdeE?=
 =?us-ascii?Q?CVnCayRTbAnCOa5pF8ggFUjw1aq6tHNpndvQh+QVNAQ39ImdiHAmNvZ67w/6?=
 =?us-ascii?Q?icoZuDMytbG0eXW+SPoyEJ59XQEd0iFkyKogR2+aeOvcu3U2CRDxpdgHJhag?=
 =?us-ascii?Q?Ypxld/4FsTk+YjAmrdli7OHdYPbtlSMlj4yITrbDvuTBuTMK2UcQYH9dHviy?=
 =?us-ascii?Q?Lp1n9x+MlcdR0FG7ThPFradA0VgYiLFwiQ5odSbQtRUzIQfIw/xBISJQ0uXQ?=
 =?us-ascii?Q?ZEJuXH9zJEt8lj+QCROOfhxXW2EOR2c/0FpCcevZ0QZUY37XVjMkbGNFXQta?=
 =?us-ascii?Q?NVxWhW5QH6KzLWoqYLhI6pokwPTi/i2TbBIhaWTE9HZmtyeJn1JyIyP7+O2c?=
 =?us-ascii?Q?bdfOQ0z0hDRlLjlDJg2nQXn0j5X4kpz8FTdj?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:04:36.3750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19231ea7-b40e-49c1-4e6c-08dd790a2cd3
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9111
X-Proofpoint-GUID: DAetZAIIjGld1DowAj5LaS7UwKctruga
X-Proofpoint-ORIG-GUID: DAetZAIIjGld1DowAj5LaS7UwKctruga
X-Authority-Analysis: v=2.4 cv=AuDu3P9P c=1 sm=1 tr=0 ts=67f92f86 cx=c_pps a=X0MiYUndXFlT04tAhnTHEA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=KDSQBeb26tfA5DPfL6IA:9 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=859 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110095

Add BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION bool option.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h | 1 +
 net/bridge/br.c                | 5 +++++
 net/bridge/br_private.h        | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index f2a6de424f3f..73876c0e2bba 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -831,6 +831,7 @@ enum br_boolopt_id {
 	BR_BOOLOPT_NO_LL_LEARN,
 	BR_BOOLOPT_MCAST_VLAN_SNOOPING,
 	BR_BOOLOPT_MST_ENABLE,
+	BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
 	BR_BOOLOPT_MAX
 };
 
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 183fcb362f9e..25dda554ca5b 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -284,6 +284,9 @@ int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on,
 	case BR_BOOLOPT_MST_ENABLE:
 		err = br_mst_set_enabled(br, on, extack);
 		break;
+	case BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION:
+		br_opt_toggle(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION, on);
+		break;
 	default:
 		/* shouldn't be called with unsupported options */
 		WARN_ON(1);
@@ -302,6 +305,8 @@ int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
 		return br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED);
 	case BR_BOOLOPT_MST_ENABLE:
 		return br_opt_get(br, BROPT_MST_ENABLED);
+	case BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION:
+		return br_opt_get(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION);
 	default:
 		/* shouldn't be called with unsupported options */
 		WARN_ON(1);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5f9d6075017e..02188b7ff8e6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -484,6 +484,7 @@ enum net_bridge_opts {
 	BROPT_VLAN_BRIDGE_BINDING,
 	BROPT_MCAST_VLAN_SNOOPING_ENABLED,
 	BROPT_MST_ENABLED,
+	BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
 };
 
 struct net_bridge {
-- 
2.49.0


