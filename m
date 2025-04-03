Return-Path: <netdev+bounces-179218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C856A7B277
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EBF3B98D8
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0F1D619F;
	Thu,  3 Apr 2025 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="kcR9YlMT";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="qFyhadxE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC01E1E1D;
	Thu,  3 Apr 2025 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743723949; cv=fail; b=C9c68B85DhQ3GCFWbCTl34RMmZ1jmk2sDtGAMjkLx3YUP4UIr/DPpgJB9WJlNRHmCCUIzBjDqH12UjV93PITR+HvOTPwd4RWTN3bHgTT4RVaNObmbzSrhUWNk/WbYTlWQ7F6IVzZJJYO4pdW8N1i3ZfZ+Y9n3wjpAtPIeOtHuhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743723949; c=relaxed/simple;
	bh=sht7hCuVP96+TXrm+FgfKiYMOECjdthY2RBiEffnajo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6pBRtqYQRchBAoy4BsOI/x2hnUtBzgAkS1asUWBhHBCYBdeWnLvLVWteHiO+Jq1GHj77Pwr4pFuxr9gKCobV2dChurS1xACb9NsKofB8WuYLCVwtItvHNZFEYqQ7aNJSqIKseEwHhCUqpwAYZs2n9fWX7i9zCjwXeg55ItSfsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=kcR9YlMT; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=qFyhadxE; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533MmHjs015844;
	Thu, 3 Apr 2025 18:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=4ayWq
	1Pc4/lYNQ6f4Hg4uwlz6l+9elHdAv1G4skP8Mc=; b=kcR9YlMTEp2xVmM1nCVN9
	e7MXxBYT8bSOY/KlEPrxtvcRWknQjAXU7hlS+Yx058i3R2qQSzAhBWJ5/Xg0w0+/
	jfyFwozY+Pr0NXmrOwKZczKsSekZflhyGX/nOBGUebdY9dt0RJDn4/UksqTXdNIj
	ZwPWh6it4S0niMAETVkKYIcUUb9kf+5+aRAXJLKwl7cY0wRMSNJaNDa+XGP7cEFc
	Uht2uqh/GC7nvJRFevddby8S8NVlr1+ojV8l4YFk+A1NQiFQiIDHSEArBHgU40I8
	6MqQDlcqZ5jnhw6c96A8JbsRSscAMgqhS9n4Ban8mSn3tjJQ9U3bGL9S9N5bB9Xs
	g==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45sx7mrnka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:45:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goyjOPlSTJdrHtG8uWCCxhCQ1iQD+RJeI82P1PO9R7SRQnnbqrUu34wgXbl2Dx2NoFu2jEtY0/h5SIPOmXaN8Fh458OeH1r6SlJBDJRZs/0XlIrphoH3+7labud1U4VN5rNGAephu+DvuDLP7XTVfJmU8dU8hNQNtyIg6Li6jz6eKWCfYvM7vuiU5AId6UbICJCLfB5Mt5qFegfRcUv9PJI8S1ld7X2BR7a1nkkPvrQAWged6Yqp1ahHmOtwsfJaacOqjuizcXnQN2XkN8dJBi32CvU5i36ws9ZEHrAH0yVaV8XrV0TCiCLQ8J8TzOFElT+xQyx+2Gs3VcKIWyN7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ayWq1Pc4/lYNQ6f4Hg4uwlz6l+9elHdAv1G4skP8Mc=;
 b=pWPIC0bMFgG4/d97BECpI8wuQalUqdVCqkAVTZPUR9+G3J68t6QDtLPVsbWQannCAwg3VT6jNLBjqt5bPcyqnDGxoIjNvm1iDwezGYW2nFx1qIsDceVc+OvUfrMCdbpddRvJFHBHgcjn03qWJ66z/2v+KgK1zkw54u//xKLRyXq8pVRfOpQ1/B4bLBd62EU7sZB0aIl+nrECXqqG8l+8xoYznSWXe2Myj16MGpQ76UNtHe5PziDXEyutmoTDYZxYGFY8YFjiwNfejYZtCXEWaEh97mTrvNtD6sT88L7X5/ZKymwtgSyGWtQ9335H2psKrIwy+niy1rCm3LPufDmuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ayWq1Pc4/lYNQ6f4Hg4uwlz6l+9elHdAv1G4skP8Mc=;
 b=qFyhadxEZnMsIiFDr4P2+LttWsG0+xAIOso0ZBn8i2yitwsqSijkS8nZrQ66ATYs0RdGHQTMtHiglOCemYW4CfQEBq99EXZzFRJCQSsP4vgWCyQTy+gOm4jWemxWu/JilPOd22faTfmwD9Y3egs5I496wNSeZ2prh1h1Msa/rzRTjqCk0TFqHkBQsMXcnt3MBc92gAfvkZ/aXg5OYrMbJv66gnmFdHgXziI0t8boKhcO0c3zp7sgcq/xLeAsvri6Uo+jrwj6mTR8dCunktHpCiPQLS8Nng8b61xNEmIWZmfnIA0mMbdQel+3ofkkt5Ix/eazJzawdWSEDRbHix8hlg==
Received: from DS7PR03CA0192.namprd03.prod.outlook.com (2603:10b6:5:3b6::17)
 by SJ2PR04MB8457.namprd04.prod.outlook.com (2603:10b6:a03:4f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 23:45:16 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d7) by DS7PR03CA0192.outlook.office365.com
 (2603:10b6:5:3b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Thu,
 3 Apr 2025 23:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 23:45:16 +0000
Received: from kc3wpa-exmb6.ad.garmin.com (10.65.32.86) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Apr 2025
 18:45:13 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 kc3wpa-exmb6.ad.garmin.com (10.65.32.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Thu, 3 Apr 2025 18:45:15 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:45:15 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 18:45:14 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu
	<roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux.dev>
Subject: [Patch v2 net-next 1/3] net: bridge: mcast: Add offload failed mdb flag
Date: Thu, 3 Apr 2025 19:44:03 -0400
Message-ID: <20250403234412.1531714-2-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ2PR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: d0af3f62-1118-49e1-1d04-08dd730995e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yWQi2Ku+aNUzUnJbUMEo4OgycjntrejNgNeANmwVTFinTZDbA4EwGlrClNfX?=
 =?us-ascii?Q?4ClYL6CbU+JNCgCNLfq7AnFYpVi3Wm2MTitae1Xudm31uWdPgePRPy7hVZok?=
 =?us-ascii?Q?iSZMfBAQSxlicnaHq67ARbdnXUYfLbDGgvsP/SC7FhvBwX0ZVrT3PRuTHb0b?=
 =?us-ascii?Q?VjpRtdaXOvrgKGwedpVNuJq+9BwVU+SBDjhJsaqVus2zmD+M/sTwID0HzpSx?=
 =?us-ascii?Q?vWc59k6rm2R1ZWGhoAaYj1mxYwc6BFR3kwWrVkt6x56WPfusfR7QoSLSsE52?=
 =?us-ascii?Q?f+wO17eCoDid3oPmuD7GODZRp+ybZGN5Iyqyv9k/aY66JHwgc/0bgbSE5jL0?=
 =?us-ascii?Q?FOykvelzYKXhm6bJKjsL3/pJ6jpiRmVdRvrx/qgnZN1ghfPdepu9JWvD8G+s?=
 =?us-ascii?Q?5QkLgfptaurQdZWItWz0uQoMsdBipPaAgjqv0oOHxOU/VMJe2Xx1hK3Y/oPr?=
 =?us-ascii?Q?if36xK1Dxiw9yOW5eMM3Dfy+2TwyocHgb9EBe1XL+OgiVzzF3omYjhupX9Ck?=
 =?us-ascii?Q?Cchq0BVzNJp1l9ZDefr/6ThGxvldRX9dkwXyGUt0fNFIc0tmM58tJy7KJLRz?=
 =?us-ascii?Q?yr767GGlzO14lMwCLjulCH9vod1TYHE6xXs/UbbNQmkMHWE+GTf1Ver8HqeB?=
 =?us-ascii?Q?IegO3cx7bjPyUJgVQL3O2xGuywrOP/qyVDl8778tfUsoWauKPHAIpIMeHc1K?=
 =?us-ascii?Q?4zHuEX8R+h4QQh3sbedWwd7d13j7OnyoDzLfbBBB7WEmXAohMTTV4dK8TrSw?=
 =?us-ascii?Q?ZReukmQWOlZfRqsUBKCDP0OHfBhS7v/66OQpvbjgQpaZc7AL5AlpaIn7AKbM?=
 =?us-ascii?Q?UAvcrye0rJBsuE3HNWE7/5T3hpoUGjFD/85ohoXNVdL8FWl5HmheJa1+ZzA4?=
 =?us-ascii?Q?KkVIbrFVVUbgEKCWWLkcfkiTwmQsb0kVu6ndZaXEwtzGsPIb9EoYY4XDBnRr?=
 =?us-ascii?Q?dyKrKlPN412+XwsA19F95+/U4cKurv9nd6nOS4e5jbKgxEZ4692oUmNchUE3?=
 =?us-ascii?Q?FLy0JTSuoxUvb4QFp8G+i+OwxAM1qlebaL7+MwDnIKai61JZp1UQpoZoEmmU?=
 =?us-ascii?Q?zddNdODPIXoix4MANNAcKdzhi+xOC3bFTu9TPSA8ISWE/zffdI+kOi5ajX6s?=
 =?us-ascii?Q?klOflHPF7XU+w9kXk3sB+4TEmtvKvCSeyIBygg3bEM9Vnp90gBrSMiv/YHGI?=
 =?us-ascii?Q?EyJzSOKt5ptG+rV9CKD31V19MrVbMzyqnN/1VyJSLHvi7Jjw76WRVN0UJzfS?=
 =?us-ascii?Q?JXyXz2ahgbrAKvC9aEUZj1CzJVCBlk1g0i/bqRHSGo7l/GI4nupz9z+TW+eF?=
 =?us-ascii?Q?/NzvwzPOaN9fkn3lEiMDlnTpWwUpRQyHSC62ujcaZhthTIDf7lC1R3J+i7qK?=
 =?us-ascii?Q?9TI8BSzLKapV+hP7GHWQ04F6qy9nhMWs/owu8YJpJdc5vY2ICqsmr7DQ+GmO?=
 =?us-ascii?Q?uPL9SAj0a1hkCJu4RejeYZV9d5OquKQfAGqqtOqO8mxyt1DwUMHzDICmQJwN?=
 =?us-ascii?Q?FJ7opZIeza1gk6I=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:45:16.2195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0af3f62-1118-49e1-1d04-08dd730995e4
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8457
X-Authority-Analysis: v=2.4 cv=GagXnRXL c=1 sm=1 tr=0 ts=67ef1d91 cx=c_pps a=Ku5Q1SXtyGRHaGBacwLxwg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=fs3JY7tD4Cos_Bw3ZwUA:9 cc=ntf
X-Proofpoint-GUID: GHdQifvYXY-41QMThiQuHLaJx4aa_JEd
X-Proofpoint-ORIG-GUID: GHdQifvYXY-41QMThiQuHLaJx4aa_JEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=940 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2504030126

Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
that an attempt to offload the MDB entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 include/uapi/linux/if_bridge.h |  9 +++++----
 net/bridge/br_mdb.c            |  2 ++
 net/bridge/br_private.h        | 20 +++++++++++++++-----
 net/bridge/br_switchdev.c      |  7 ++-----
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index a5b743a2f775..f2a6de424f3f 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -699,10 +699,11 @@ struct br_mdb_entry {
 #define MDB_TEMPORARY 0
 #define MDB_PERMANENT 1
 	__u8 state;
-#define MDB_FLAGS_OFFLOAD	(1 << 0)
-#define MDB_FLAGS_FAST_LEAVE	(1 << 1)
-#define MDB_FLAGS_STAR_EXCL	(1 << 2)
-#define MDB_FLAGS_BLOCKED	(1 << 3)
+#define MDB_FLAGS_OFFLOAD		(1 << 0)
+#define MDB_FLAGS_FAST_LEAVE		(1 << 1)
+#define MDB_FLAGS_STAR_EXCL		(1 << 2)
+#define MDB_FLAGS_BLOCKED		(1 << 3)
+#define MDB_FLAGS_OFFLOAD_FAILED	(1 << 4)
 	__u8 flags;
 	__u16 vid;
 	struct {
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 1a52a0bca086..0639691cd19b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -144,6 +144,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
 		e->flags |= MDB_FLAGS_STAR_EXCL;
 	if (flags & MDB_PG_FLAGS_BLOCKED)
 		e->flags |= MDB_FLAGS_BLOCKED;
+	if (flags & MDB_PG_FLAGS_OFFLOAD_FAILED)
+		e->flags |= MDB_FLAGS_OFFLOAD_FAILED;
 }
 
 static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1054b8a88edc..5f9d6075017e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,11 +306,12 @@ struct net_bridge_fdb_flush_desc {
 	u16				vlan_id;
 };
 
-#define MDB_PG_FLAGS_PERMANENT	BIT(0)
-#define MDB_PG_FLAGS_OFFLOAD	BIT(1)
-#define MDB_PG_FLAGS_FAST_LEAVE	BIT(2)
-#define MDB_PG_FLAGS_STAR_EXCL	BIT(3)
-#define MDB_PG_FLAGS_BLOCKED	BIT(4)
+#define MDB_PG_FLAGS_PERMANENT		BIT(0)
+#define MDB_PG_FLAGS_OFFLOAD		BIT(1)
+#define MDB_PG_FLAGS_FAST_LEAVE		BIT(2)
+#define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
+#define MDB_PG_FLAGS_BLOCKED		BIT(4)
+#define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
 
 #define PG_SRC_ENT_LIMIT	32
 
@@ -1343,6 +1344,15 @@ br_multicast_ctx_matches_vlan_snooping(const struct net_bridge_mcast *brmctx)
 
 	return !!(vlan_snooping_enabled == br_multicast_ctx_is_vlan(brmctx));
 }
+
+static inline void
+br_multicast_set_pg_offload_flags(struct net_bridge_port_group *p,
+				  bool offloaded)
+{
+	p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+	p->flags |= (offloaded ? MDB_PG_FLAGS_OFFLOAD :
+		MDB_PG_FLAGS_OFFLOAD_FAILED);
+}
 #else
 static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 				   struct net_bridge_mcast_port **pmctx,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..40f0b16e4df8 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -505,9 +505,6 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
 
-	if (err)
-		goto err;
-
 	spin_lock_bh(&br->multicast_lock);
 	mp = br_mdb_ip_get(br, &data->ip);
 	if (!mp)
@@ -516,11 +513,11 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	     pp = &p->next) {
 		if (p->key.port != port)
 			continue;
-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+
+		br_multicast_set_pg_offload_flags(p, !err);
 	}
 out:
 	spin_unlock_bh(&br->multicast_lock);
-err:
 	kfree(priv);
 }
 
-- 
2.49.0


