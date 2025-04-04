Return-Path: <netdev+bounces-179395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B1A7C583
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC463B8961
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3419D07B;
	Fri,  4 Apr 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="SyEIdBhZ";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="GhFeLYCN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8742A87;
	Fri,  4 Apr 2025 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802235; cv=fail; b=b7LlMSH6EWKSjkLDI59fnNxBfdwQwbm8bEMUvy0zm+X7n93n6zJoixNvwJdezvuWjTrAOZNFsu5Bu0aI/M9NNfOuR/7+9+ZM9nTUZXevgZYlm8yFzr12dWqTtOwyz7w+7QsBmJLYG2oD/NmHfLfykCSdqkZUhBJK70bRFosG4jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802235; c=relaxed/simple;
	bh=zJveOBI25zvAHWd4I2TMEifMpZzmlWzAI6h8hTva9Xk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oB5mKr5v+AJS5ZZT2lCPQhSvUAD8vrT/tCYNFIHcTAjiqAMDnvNrwvrYQx9I3XwiuoEmdzmQN5p57AUpcdq07sKa5ecQjlOLu8LjeAwFyuLI+6C3dHrkGyHNzVV/dNOLM7BJV5mgSt91LgEtRhPSiyE5XNW7tQMbRo1WSgRgdA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=SyEIdBhZ; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=GhFeLYCN; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534JkMSk019721;
	Fri, 4 Apr 2025 16:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=ze1Md5S4o94OHfCSPlToD0Q2nVz
	7jqXB8oW6LrI8cjU=; b=SyEIdBhZtuqDKjxbzbar6yaHbLodTsrqLRF1dcD0S9c
	/dMtcPBbfN8UNV7zR71akact/4x6OvCBnB3RH2NeOYFleKWC09liO1ezLnrXF6lw
	ibd+JGHhxy7AON64St8s5x45TmeicqjqKgAyb+uY/j7j29nA71F7cn2j4qoH2Zdd
	nfIBmLyUMF30uctUwV9xM4X8M4vOfy5qAnW3Q7pdhwZ2vufxWhAfC7T4EQz1u/gl
	wzIThUtNp5Kox8c/pF6HfisPkxn2DUz/koYWxqjcAuVe0vdqetov9tKp/TstWvBV
	FLRcD/JwSuNSF1x0QPvjzMlb2OlStWbl8gm8uo3ukiA==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45tnsn04dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:30:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1WIDihTq+KSj7qXcc6OE0NRdh7u05Fr+GLEzQtCzLbcPXD5rhuZ5R8ab5VP8ksWyolpWXJPq3w9GcfSeCYUAn8s2mIAvklS8MmVfisi8x6Rw1Cwy0S4+HDMOYBjsaSVrMOMdBVCa0AL5lBYTooSqxvlN1vZxHfFTgz5DobEcb0cknwdqBjvPLRnCDDRn9RNMOe6I6piUZzbDm49G6PujInrzkuatqYYesglloLMfRW38Grp+fIxbnbxBsXm67UBn1Awh4eXQ6itCarErSkPa4Ny2WShs8bYfYCcnrpzE+m/L6pasoLvhwOWEdlJYnauPn4pJt/ynaH0ycvW0Napng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze1Md5S4o94OHfCSPlToD0Q2nVz7jqXB8oW6LrI8cjU=;
 b=e5P12KAYo525L3kmmChCJC8B+Av1VbNYx+lHGBtL04HfjSpMkFnPzdDtEMRBP7UxgQFNB3TDATL6wv2mWyogoo/NM81wVGeAOgoHPo4M8w2PAeXy5z8vNActWZrrxzppljUYbASqyRA6rjVhavbpEYy9GGDujeN0U6Z4P5t0TZfEmsA88V5CJA49rlUftVlc+8zCuTcR40uzM/jnIxrGuNmZowJ2gS/flDF4hzjHBliDsFXLLNt/SLZI4B2B1Gp12vAM1WnLtxawpLakLIQUY0kBtxyFKWMpZhtSwTBZUxLhA6aYsiR9UYTefKpNAwIX61s0norCHnz38ToRkyFaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze1Md5S4o94OHfCSPlToD0Q2nVz7jqXB8oW6LrI8cjU=;
 b=GhFeLYCNBNHyvqJWhX6l2FeyYVYJzikeAzJrjcgADqs0nyvRAkGZulpS4chxc6G0VxpeSeo2KTiqANZXP3uELuJZGPNDh9XDadvQU7IfHEGWrDmw2bS4PKpbCZevC6P2xPhj8FBGBW5hGBe54jfXNFdSWDVlzFCpreQIZJJTfbYv4YdKemzac0uUfUTzRv/bySA/0pDF8aRlFp8cTUoDK+MEi+5c+RCx55FayecJDTDkM+EItQurWvKWXjyZ3vLSloJhmEeaRJ0ddHrb0+5H9BAFPDvR3crcHh1Fsk+QrSJC43y3OtCIh5SWCB9h7ZNQSejJ3264nulL+MbKmEUEmQ==
Received: from SA0PR11CA0209.namprd11.prod.outlook.com (2603:10b6:806:1bc::34)
 by SJ2PR04MB8985.namprd04.prod.outlook.com (2603:10b6:a03:560::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.44; Fri, 4 Apr
 2025 21:30:11 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::b4) by SA0PR11CA0209.outlook.office365.com
 (2603:10b6:806:1bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Fri,
 4 Apr 2025 21:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 4 Apr 2025 21:30:10 +0000
Received: from kc3wpa-exmb6.ad.garmin.com (10.65.32.86) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Apr 2025
 16:29:55 -0500
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 kc3wpa-exmb6.ad.garmin.com (10.65.32.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Fri, 4 Apr 2025 16:29:57 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Apr 2025 16:29:57 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Apr 2025 16:29:56 -0500
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
Subject: [Patch v3 net-next 0/3] Add support for mdb offload failure notification
Date: Fri, 4 Apr 2025 17:29:32 -0400
Message-ID: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ2PR04MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc8e2c0-dbca-4dd4-6bb9-08dd73bfe119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5tMVB34JUPH1z2Z91BkfyiHoTPjTEJiK/LujvtyYD9PVhAivfRnVxr7Crek?=
 =?us-ascii?Q?AXA1zlUBArxcJCxoFyzzSVjxfVoctsfwvsHGX4l6vtu6jwrIXUsGPKzMGHr3?=
 =?us-ascii?Q?Dp2yEw4pqPQb+N9FGZp9uCJQQAch4NKYNYTMf/+t5WfNWQPKNGtDCpoy7JyC?=
 =?us-ascii?Q?6ZAM/1OWWsN/dxJ0+vg0cKvdpQoozbjSDJefPw94m87csIG657NI+a5U3fud?=
 =?us-ascii?Q?CHGBu7NCAyh8S0n9AH4LdvLDDIxOvPI/YRyFYjppVkn0X2YmC3N+pUoanMHK?=
 =?us-ascii?Q?pVGpJRGYcyVloSSqMavZUxDpoUo+/aZk6GjkW0zCHFIjFhP8ZVhyIHTOfKzF?=
 =?us-ascii?Q?mcPlfa4TQj6+J0O7xkLV00jLx7HcIE50/oWadfWCB8wNYjgeZL/WsC4hQV9h?=
 =?us-ascii?Q?e2VbsCF1N3HFjA997ODgqfh7If7ASgOnnZEUvZ33TugaWJD5P/sng7qs76I5?=
 =?us-ascii?Q?kviG5yzJ3Pg0Rm6byuzTWGYve9ad+kFTQsx3iD/rD+ALCzcy2JbFdpIaDtEj?=
 =?us-ascii?Q?MX9CEJtRkOtPVU+gOxH55aqgM2NcfjMGmthbAf2aoprDKrecuooQ8ycAZ1tp?=
 =?us-ascii?Q?/RFwoTMIgduw89kpYXm2FckZWY/NzBDlKPzmmzhXBFzIFlyyJvRLQt7YNhHl?=
 =?us-ascii?Q?UPoJMnU8Anab+vrRYFnPE+F3L9zzZZEHy9lzUajdcmx/lQfEhxRv5kH1gWK1?=
 =?us-ascii?Q?unOi3L3ZGCWq4w3bZRwyauo5NOglCm4xrUVqLQYGuIJih4b5/Q+9cbMsmoMb?=
 =?us-ascii?Q?FqI2tl2Pk26jrqhZzWsyMJ9dH69mg5ibULNBfN8m+l2jerNcNuu4vByqAUVU?=
 =?us-ascii?Q?HNRygYPbO9RmA+8Lm2JHXJtPN50zsZ2432gtzXTW6jfSo+HjY/0kJzePvsgx?=
 =?us-ascii?Q?+DRQKhN0OmmqPOmKHKADnBRf1bJ9ze/MnTwu6Dzk9wihRvRfula9P6KgeEBI?=
 =?us-ascii?Q?zxPJx8m+Pi5odrM6qf8cQB23XISB1qcir2um1ewnmVQ/OgPPcqjR8Xoh6rqB?=
 =?us-ascii?Q?lnhOOfy4aAAeSzidudy1Qnxf2XN08KbHQZZwG0K28U8IkVRE8RKvm4LUy7jL?=
 =?us-ascii?Q?sQ38fbXzSq5AwS3qp39t7BEnT+fQLQbOGXZDZpTumiX7kSPRwXLSk0C2JpEc?=
 =?us-ascii?Q?WUL2U/WgIId2t53BiN6qvVBy5m42xUhlj9AA1fUyaFJmscKEsfDYl4WFpKZ4?=
 =?us-ascii?Q?4M2eYxODwmYuJ29SpHfibBbBwOuPmSzwRDSkOz6FWYlFjMH+2nt+l6XGoqpC?=
 =?us-ascii?Q?n0f70/fk1WM6QlqT1rJpz+r2e1Hdy3onNINspk8GN7knOqKMUmuANnHI7sC1?=
 =?us-ascii?Q?1gP+SR1V93ooJiKo/nm0CHnIC0D+nbQOwxXeVOS4yOpEFu0QFrvqn/4T/Vus?=
 =?us-ascii?Q?C52N27wHXMuhg+CxPR7fodrMFRvZuv/W/479SDv9zM5QJXWQ4zQRmQXMtCl9?=
 =?us-ascii?Q?8sBvHZ/aaOGQezTI9jJULlR5ZIyTlD7RyYeEQDTY8HFxVqZxhiy3Y3QO3H4j?=
 =?us-ascii?Q?py6IlrnZnzyW4I4=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 21:30:10.6622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc8e2c0-dbca-4dd4-6bb9-08dd73bfe119
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8985
X-Proofpoint-ORIG-GUID: XVkZfmVm4sflSzRqYyXcH9FECkCvyYoH
X-Authority-Analysis: v=2.4 cv=OvZPyz/t c=1 sm=1 tr=0 ts=67f04f65 cx=c_pps a=GHJUnOcs406mhZkDzxAeiQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=nms5tGoDfQjFp_ETsZIA:9 cc=ntf
X-Proofpoint-GUID: XVkZfmVm4sflSzRqYyXcH9FECkCvyYoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=904
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504040147

Currently the bridge does not provide real-time feedback to user space
on whether or not an attempt to offload an mdb entry was successful.

This patch set adds support to notify user space about failed offload
attempts, and is controlled by a new knob mdb_offload_fail_notification.

A break-down of the patches in the series:

Patch 1 adds offload failed flag to indicate that the offload attempt
has failed. The flag is reflected in netlink mdb entry flags.

Patch 2 adds the new bridge bool option mdb_offload_fail_notification.

Patch 3 notifies user space when the result is known, controlled by
mdb_offload_fail_notification setting.

Joseph Huang (3):
  net: bridge: mcast: Add offload failed mdb flag
  net: bridge: Add offload_fail_notification bopt
  net: bridge: mcast: Notify on mdb offload failure

 include/uapi/linux/if_bridge.h | 10 ++++++----
 net/bridge/br.c                |  5 +++++
 net/bridge/br_mdb.c            | 28 +++++++++++++++++++++++-----
 net/bridge/br_private.h        | 30 +++++++++++++++++++++++++-----
 net/bridge/br_switchdev.c      | 13 +++++++++----
 5 files changed, 68 insertions(+), 18 deletions(-)

---
v1: https://lore.kernel.org/netdev/20250318224255.143683-1-Joseph.Huang@garmin.com/
    iproute2 link:
    https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
v2: https://lore.kernel.org/netdev/20250403234412.1531714-1-Joseph.Huang@garmin.com/
    iproute2 link:
    https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
    Add br_multicast_pg_set_offload_flags helper to set offload flags
    Change multi-valued option mdb_notify_on_flag_change to bool option
    mdb_offload_fail_notification
    Change _br_mdb_notify to __br_mdb_notify
    Drop all #ifdef CONFIG_NET_SWITCHDEV
    Add br_mdb_should_notify helper and reorganize code in
    br_switch_mdb_complete
v3: Patch 1/3 Do not set offload flags when switchdev returns -EOPNOTSUPP
-- 
2.49.0


