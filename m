Return-Path: <netdev+bounces-172537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E2A554A5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08A93BBFB4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78BA271805;
	Thu,  6 Mar 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="qNRqwaIi";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="rSMeUdpK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4F25D54C;
	Thu,  6 Mar 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284748; cv=fail; b=SPCZFMwxLjlkBuYo+dzGMlvDxzX7u5HCPwwh7nIETEbwpaoU2gehF10n4lqQh8r3K3PLgjh5NfTq2D/QT8dhRG48/ikGbgZhocj+Tglq4QrNvbLpK+Y2XZ3YVQavqgXIf8rFxwN+AV1OJHbVraaUrw7oB26vT3Z7dASySQIkfy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284748; c=relaxed/simple;
	bh=Uq5+klOCmCQED8gBF+vK0PMvFU/98ZjKBnM9Fh1rHlQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=redHtCVWLgyf79fxQPIVxreI4xQEKokfPk0E6my2Sjg3lc+a6WHwjtJpfupdGVaMNip8LCxYZVhpm4CLLqAZIDYMBnVXHM1qO/TzYJV2NeZaRqijIfZNu77rMLE8914jwx5lPzShldThp9tVZn8/RNifLZbLTMbSMkDWjqL9qH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=qNRqwaIi; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=rSMeUdpK; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526H8GLI013730;
	Thu, 6 Mar 2025 11:23:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=KaxZFZapR0xcfD9TYn0JSS/ejTP
	KlsXFj9QGv/ov0CU=; b=qNRqwaIi5WVfs18eXS7bS6+jb7g5kzJGY5fOnQZ2APr
	0NrtIV8Af7aWMFSiR2eFMMlUJa5KAD7PrRHYBdXlbThRiUX6sTwSUPLpf/Pe6wbQ
	+uPaDO8ZXjg6b0JRmuQNtbHoKeYQuiCpwXaIzh3KDjPSlYWJPQ7FLm78ITcXCklz
	MCpLZDAYrlygfG8onvss6uC6Vw+o1to/qQeOhvgxsq8WwXBSUxx7ibkKxIRV3XS5
	ch4hGjpS4nFc4BK82dZbBVH+j1sKmS5OozQNIx4HQABv5PElTkv1dwmkbtuaKdxr
	rgLghclUK9d0dWsZlbz0OpiodyMQktTk1GwKC0RTM1A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 457b8vgngp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 11:23:25 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5d2koCO4TzC/j8E+Q7Qf5nyzKaDfoOWbnNvcJcuIRtC4YbJC6Gv0apmmJm3tHJzdlWoAZ1WzGX1VHcvGXVjgWLZmzoBwJ2kQoHN2xhqyGiPCFwWUW0YRRmKbQOaSbF3y0rrCB5Cl54j7Cnxd6wWYOHEetHpzZWnfFBZbL5ISU2pVSv3fMFRfsk1ROuF2FLUycJHIYdNeunp9Q7d3bVtqCWZ3a5kJg0poQntIQg98vHa/QJaH7CjR3EDwqaaZM/c8FEXLCO9MKgFZ9+bfc9BmqqW7EjnWa7/E7kyUh0/sNPPeVjAy5Erwmf19e0/xaNFcwLWPl0ZPP4JA8ZDYxA5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaxZFZapR0xcfD9TYn0JSS/ejTPKlsXFj9QGv/ov0CU=;
 b=D/t2wcIByb24ht4i5T4tDXJbCLFNitG6vG96/5vpumV8WcpsX6pJmSCuBvU/l3cfPVoI/mP0reu+gjGhZBEmf061lVyJS1sROBlvauXHVMHY5rdTo9ekjK3LnCR6Plbt7XBTG268flQ1yKJwNiuBA3U2g8nlSClhDy2tUJEjieUO06yXc/U39HKSv00p5D+lVmA8C9PjJycV1Qk2pfnFAGY0A50dlFMMWQ12D4vb9De4jRZUDjqqAcctklBdAWBKhQUBoQnA7M9Zdv8S0ZJTVIjw+HJ/9FRmz7pC/OGLKq7TKwgByYifRlZzI9jE72nFQ/Pwy5z2S3aQ4iP2OplUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaxZFZapR0xcfD9TYn0JSS/ejTPKlsXFj9QGv/ov0CU=;
 b=rSMeUdpKyRddbLCcY2qz8z+ZGgtvoXNblRCEfKlQMo0Wu9i/tLRG8lK063/DIhqknN2+VYyaB0CiM58O6h4aRUbT3tYEeHQnz1I0r0L2u7BMYR1AIdzMF9vddKycBAD5xWap1li2E1GoQQiZJD/cohfa9xCXXstgbRQnoaADsa7ZW+7A5kvRYYRjp332zszoOBI3wKZOg+o/ObFTMBPFB7AHAcQbJGMS5aNTcPOnJl+jC7uFHFdlfgMHRe1ySDnMg6tbaElJOCe3fg6a99DgfRNBzGRYG86dx8a2E75tZfqC04KUgx+CAbmZp0qVgewOvYC9V5fHIsyn38CZwc5fdw==
Received: from SA9PR13CA0150.namprd13.prod.outlook.com (2603:10b6:806:27::35)
 by BN8PR04MB6434.namprd04.prod.outlook.com (2603:10b6:408:d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 17:23:23 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::8c) by SA9PR13CA0150.outlook.office365.com
 (2603:10b6:806:27::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 17:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 17:23:23 +0000
Received: from kc3wpa-exmb4.ad.garmin.com (10.65.32.84) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 11:23:20 -0600
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 kc3wpa-exmb4.ad.garmin.com (10.65.32.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Mar 2025 11:23:20 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 11:23:18 -0600
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Mar 2025 11:23:18 -0600
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net 1/1] net: dsa: mv88e6xxx: Verify after ATU Load ops
Date: Thu, 6 Mar 2025 12:23:05 -0500
Message-ID: <20250306172306.3859214-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|BN8PR04MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 34732380-ccea-47ee-aa2d-08dd5cd3993e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wsvfABW67AsfVwn99UjqOQT14gHid3wiO1+lTSoZvN/rfKvFDDgX+jPCtk5M?=
 =?us-ascii?Q?bFI+FU8vigtR+pfYSGadNjhNAK0oBl4Q8F80b3zMnTtM70HwVohojfVyfEzc?=
 =?us-ascii?Q?ZmbL5qHWfWD1T+nhHI2jE4S94UoUBE6vVO7ITj5o/4iwwdvzFUki968ts54F?=
 =?us-ascii?Q?VaukJg5S8+X3noSnH16WiclTID6ImdAjQ39p9AiNpZWne6iYNm42FbBXZvLj?=
 =?us-ascii?Q?5KPYe2p3l3/FHbnH/SWAs9cwl7I5nooQlmSU7qztV3pC241xudTsKFyZXGP1?=
 =?us-ascii?Q?WmPHKRTEYD7sPAEOEZfuv8KrF2yp3PVpxyWoVeAofhfMh3c941jwqbgpHlkE?=
 =?us-ascii?Q?w9CweqiahGPxmD1k7HzJV3AjbwaViEZclOfbuBOX6XrbC4BObWlQANPZi5OD?=
 =?us-ascii?Q?6JDFJaM8n12Mr3k6RLbnRLH3PsvfrkRt/ap9m5aYiKAGRpc72BBdHYwVWYHT?=
 =?us-ascii?Q?UBmJbAAMXmSTb6glJ4Iq6sp3BvZveHUL+DG/GhhMwlNzHHPGBJpL5fIppOPf?=
 =?us-ascii?Q?MKHksnUlWAHDF+MNpXSN1msTGD2qOTCbcriToDBB5wQkGErS20ptYjYmI45R?=
 =?us-ascii?Q?ToQoxAmsi82afa7Yw1MLloiFoxoFHmVI7Uhwr5XLrzcw0uAT7SPJGk3fvMti?=
 =?us-ascii?Q?to4kRpUqStII1kzfGEgiYmXw11E3e/ZG4lB3UiJz8fEMYO2nP8xsReBmxFLL?=
 =?us-ascii?Q?9OSfOTvlj28RJEHIa3THTqeH6s4l9mm3bOvtuy7XMb8h62jiC/VGRLEcKCtj?=
 =?us-ascii?Q?hRG/RQBLDoEm8VlcgotwEV//oiaMffFyyBPSz8uVeAPQZ5WcmQReaWwwjBcV?=
 =?us-ascii?Q?aevBRixOqoDTCapHfPQAKS0CECommD+tTLJ8hz2OZgrV+pwHuwJlHq3tCquC?=
 =?us-ascii?Q?GIZpzz/4qgTakne1y+URCqR8+IQLE12uaz1bpFq91M+NigNzf0REHpJ/Gw0s?=
 =?us-ascii?Q?0qftisDWwmLaeRPAwaMe01ef4aErspFwpxDNp1hmDW3ofHQuX5q9ypKVyqrs?=
 =?us-ascii?Q?spXOgF0hkh7TYeziiZZ1A0mPfabkcEvUDLifha20vvPm+qkwHYSBVqajLzZD?=
 =?us-ascii?Q?Tk8vvqBDpA/BQE5tICoKsFJDvBygnqYZTm9CiFuksNjRhragmKCwukMsB/IG?=
 =?us-ascii?Q?J21NN0EDZO2optO08LI+/Wma2hZZoU6W19E0BflpDrwQEz8TV1qCTlmtFUfm?=
 =?us-ascii?Q?XRxLWVfk6IXTLmT3YSBg/6bkifjufYVCH7ECrzxKp5B9w29z28mXw+/XEiea?=
 =?us-ascii?Q?Q2KzgpuPVCw96JrODZgD5+BZTyH87K6IEA6IAjJtSJUsLSGzJAmYxh8CTdTZ?=
 =?us-ascii?Q?zjNbGnmhg+3oHAXCEGsdcVhggqM9668+AyvkjCDxQB0OVdMjME0gx1Ceb1k+?=
 =?us-ascii?Q?WXAJ793JwLKKYpOyWFXS5IhwhlgDKr2yUegBZDt4DuDFFcNVdze1P5dLzfzy?=
 =?us-ascii?Q?+2P6FVAwUOVWVsGdNbRn/L51LMX0FKfcp16cQwqoTDCZsjjTUpM2ece0lEAC?=
 =?us-ascii?Q?Vc1sR81g/O5gCLg=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:23:23.4416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34732380-ccea-47ee-aa2d-08dd5cd3993e
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6434
X-Proofpoint-ORIG-GUID: tJWnMLpfiSmAAhr8zVp3zcUMMxD2l5hS
X-Proofpoint-GUID: tJWnMLpfiSmAAhr8zVp3zcUMMxD2l5hS
X-Authority-Analysis: v=2.4 cv=CODQXQrD c=1 sm=1 tr=0 ts=67c9da0e cx=c_pps a=tQsPtMi3p37jOgXbkrwZvw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=mfjfP0T1MaGNimHTBpYA:9 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=716
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503060132

ATU Load operations could fail silently if there's not enough space
on the device to hold the new entry. When this happens, the symptom
depends on the unknown flood settings. If unknown multicast flood is
disabled, the multicast packets are dropped when the ATU table is
full. If unknown multicast flood is enabled, the multicast packets
will be flooded to all ports. Either way, IGMP snooping is broken
when the ATU Load operation fails silently.

Do a Read-After-Write verification after each fdb/mdb add operation
to make sure that the operation was really successful, and return
-ENOSPC otherwise.

Fixes: defb05b9b9b4 ("net: dsa: mv88e6xxx: Add support for fdb_add, fdb_del, and fdb_getnext")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
V1: https://lore.kernel.org/lkml/20250304235352.3259613-1-Joseph.Huang@garmin.com/
V2: https://lore.kernel.org/lkml/20250305202828.3545731-1-Joseph.Huang@garmin.com/
    Add helper function to check the existence of an entry and only
    call it in mv88e6xxx_port_fdb/mdb_add().
V3: Lock across the entire fdb/mdb add opertaion.
---
 drivers/net/dsa/mv88e6xxx/chip.c | 59 ++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 68d1e891752b..5db96ca52505 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2208,13 +2208,11 @@ mv88e6xxx_port_vlan_prepare(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
-					const unsigned char *addr, u16 vid,
-					u8 state)
+static int mv88e6xxx_port_db_get(struct mv88e6xxx_chip *chip,
+				 const unsigned char *addr, u16 vid,
+				 u16 *fid, struct mv88e6xxx_atu_entry *entry)
 {
-	struct mv88e6xxx_atu_entry entry;
 	struct mv88e6xxx_vtu_entry vlan;
-	u16 fid;
 	int err;
 
 	/* Ports have two private address databases: one for when the port is
@@ -2225,7 +2223,7 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 	 * VLAN ID into the port's database used for VLAN-unaware bridging.
 	 */
 	if (vid == 0) {
-		fid = MV88E6XXX_FID_BRIDGED;
+		*fid = MV88E6XXX_FID_BRIDGED;
 	} else {
 		err = mv88e6xxx_vtu_get(chip, vid, &vlan);
 		if (err)
@@ -2235,14 +2233,39 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		if (!vlan.valid)
 			return -EOPNOTSUPP;
 
-		fid = vlan.fid;
+		*fid = vlan.fid;
 	}
 
-	entry.state = 0;
-	ether_addr_copy(entry.mac, addr);
-	eth_addr_dec(entry.mac);
+	entry->state = 0;
+	ether_addr_copy(entry->mac, addr);
+	eth_addr_dec(entry->mac);
+
+	return mv88e6xxx_g1_atu_getnext(chip, *fid, entry);
+}
+
+static bool mv88e6xxx_port_db_find(struct mv88e6xxx_chip *chip,
+				   const unsigned char *addr, u16 vid)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
 
-	err = mv88e6xxx_g1_atu_getnext(chip, fid, &entry);
+	err = mv88e6xxx_port_db_get(chip, addr, vid, &fid, &entry);
+	if (err)
+		return false;
+
+	return entry.state && ether_addr_equal(entry.mac, addr);
+}
+
+static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
+					const unsigned char *addr, u16 vid,
+					u8 state)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
+
+	err = mv88e6xxx_port_db_get(chip, addr, vid, &fid, &entry);
 	if (err)
 		return err;
 
@@ -2846,6 +2869,13 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
+	if (err)
+		goto out;
+
+	if (!mv88e6xxx_port_db_find(chip, addr, vid))
+		err = -ENOSPC;
+
+out:
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
@@ -6614,6 +6644,13 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+	if (err)
+		goto out;
+
+	if (!mv88e6xxx_port_db_find(chip, mdb->addr, mdb->vid))
+		err = -ENOSPC;
+
+out:
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
-- 
2.48.1


