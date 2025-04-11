Return-Path: <netdev+bounces-181677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B77CFA86133
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C657AFCE0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C511F418D;
	Fri, 11 Apr 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="iRxZkQ7s";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="beJqAcd2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A81F1507;
	Fri, 11 Apr 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383870; cv=fail; b=YmUBS+zk48RAVijw/99Jpsgs24G3Ts72Ub2jw5aJgnQIazFpUfRsbGzzxIgyFJu1OItFHjYsVxh24fZWcvZfC1K3ZWR2ceMvLN8K2vnC0S9e2yzpmB2NarTucjAEKu8614Kl1+Rn5KZQo6uFEWZrodFcFNRdmvCRb+xJmWKVNrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383870; c=relaxed/simple;
	bh=o7ekdmSec1uG+SY2ox9TG/JYcxbx4/K/H5Hpdnoh+5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JME4qrux4072lHaKDgA54LHexUzR0jBFZdmr8aCP1ROqc9ZKDKDNWF0MR9N0okM33k1kG2a4+6D3dfXn1/EiM9Jw88IZfsIZ5fppKlDBXcN3fj6Hy9iyNIKkZlauBtuitYTVTquLIJEwiymUXpfFuxGk56zjseQLcJY1UnepLi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=iRxZkQ7s; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=beJqAcd2; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BBrK8h016231;
	Fri, 11 Apr 2025 10:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=GTXY+//rNOZKU5Gpvh0oUFhh7rB
	x4kKcEYpv5A387eI=; b=iRxZkQ7sLy9L+ZPZ9gGOUt4I9pL1o4Una4EW6n3KmjX
	aRQ7cfCQT6gukiyDXRZAGV9VkVx79DBizTgd1rs2v4qzT+aFgy4uTmoBvAXVeaat
	r8Sl6krIwIzoHJVX+cHDA9yq6BYVMmiyDMbolGoiKySNcXr8TYZHR9N28fKCujBo
	I3fTPo2r3YjNb3bDc38LS49dIYL4SNBileUzV8wuvPOmVlp3bX57Q2f5uTIBqUa8
	lurCXGkkeoX6BEc3HyYd1lWECiZqqJgbNQHYsiDVISpO38LCL0KIsO6MD4VfUNqI
	nt4wBtiJWRQt1zhO+OmSuMlUvoewxBRggeXR+UH8omA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45y2apgbtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 10:03:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZeD8jEv363/2Ft97BcDonRGsFAY4M44wMBb5oAkMrQxXADzOM7Dqw/nz0APDvQBWWY2uH2bBA8/ivenKhndsSMPX8jIjXOZuZ9UmxzuaTdGc9KxZANUvKXEDQvd6Z2suROBjl6tLCy1I4DqPMV39fsN2Te8smeebmBgIGTXFrdOhOmzDVv7L5AMoPxBdFoTs46hZQhKB7h+RB9UZQmo3PG3ZHr4SDsLVm2392tNiKg/LTHQZJxZMP83jICkqyAtr6GF9weAsxqDfxjROyolteRT0YRbGaWcDI8sRdmR/TcIVzslVP+4wnhXpsCAKifD2rVpJq68UaA1J92CVKMy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTXY+//rNOZKU5Gpvh0oUFhh7rBx4kKcEYpv5A387eI=;
 b=rKadBZyil00I/MnE0IDJDlCZYyXx9bnxpaTs78ucSZg9WQSUfGTnomGdB9Imqv0KhHvoMKpBJpoqmN8HskJH4CAyJ7S97wSCSnxKOYGGIR9QSFt8TC40y/tFFo4+V+lDHLHQMXgqIA0qwoBBjzgYsWqA9Z/fgJZRaoWrX0oL52uV/fSuerkLapo2AVGUE81eT4kLzN35KeviJkYUqAeP63PbuQIXAnCfepCkRJn1pJeMe6Lwc9FDbneqg1PMb7dlVpBOsCu6bK5//PILAof0nsiBmT5Qw5lbZYl/m836QLwiQ2hOd0NhGXv4bI1c/vwDU6yRjWn3OMwcEHHkImm1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTXY+//rNOZKU5Gpvh0oUFhh7rBx4kKcEYpv5A387eI=;
 b=beJqAcd2yim96Ns2ywGs/bvt59A3svnqP9/UFdQv2eVUIXPFZtEsEKFCQIaA0hU1x+bRaU04xIU8+8Fl7Yzls6Prtkf9gMPtIyLW+DM3ZS77lAAluLZ6QOXMA90sTieVnoWpKB7KH2ST9xMoQ4vuunExLCYCLsZiopF66l0sIZyfCQUc85JQ56aVoJHM4alLrPxFSsGBRqETmfAzn0i6XvU5qBPdut0trAqnk0tyrvi+IzZFuTp2MBTvjW8BoP9NUN9gJT9SPA/8pBpDNamleBDpY+6yD8nr1Mx7CaUdAqw0Y3ootm19slNG4EH/l5K36o7cqKzI3QUKyi0oDrZQtQ==
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by LV3PR04MB9250.namprd04.prod.outlook.com (2603:10b6:408:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 15:03:53 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::7) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 15:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 15:03:53 +0000
Received: from kc3wpa-exmb7.ad.garmin.com (10.65.32.87) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 10:03:35 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 kc3wpa-exmb7.ad.garmin.com (10.65.32.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Fri, 11 Apr 2025 10:03:36 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 10:03:35 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 10:03:35 -0500
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
Subject: [Patch v5 net-next 0/3] Add support for mdb offload failure notification
Date: Fri, 11 Apr 2025 11:03:15 -0400
Message-ID: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|LV3PR04MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: cc418523-7357-4bb5-a2e7-08dd790a12fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9s/92WNi/C4s9KZfYFhp3vGL9jBTqAvw33VmTrM/8UgKB+wd/M85atTywa7?=
 =?us-ascii?Q?2Ik4JKQsGjnEC1tne4PF3BAy7W9MXT7w16mpyrcjF5z2dS4AqNRsTg0PJ3qO?=
 =?us-ascii?Q?YSHJ42ilqGXo3pmfoJ6Jri+E78318C/m0TjkefwcitGk4ilZes25A0tqVrgV?=
 =?us-ascii?Q?P651xpTPa1xe/KXOwX/3aJD09AvxnLH5/Uxv1IFD9HhhI5ufF1FugIaDycMf?=
 =?us-ascii?Q?kWd2s8LDaiiy2R3ggjRGi0pVbZQP+Q5JwPndiAPR9KPZ14YWEsaXy1RZWaHQ?=
 =?us-ascii?Q?f6/t4U6TSkOfc9W1CA4UMAY2ZjW/5U4k0pgsC7M5U+hEncTa44i4qgP8U67v?=
 =?us-ascii?Q?LTA2BMFQlR8+JA4vgQ9mXbh8NhxavhK2BB7XjuHqibgEbR7kFLhY55xR+W+O?=
 =?us-ascii?Q?JAWmwrKvPM4hvHB7Z3r+jMuFjxLpBOKSSDfove/L1SY1XvpEfKwhNY8LJdVL?=
 =?us-ascii?Q?puaaxcl1kkZh97MuixDvulqDo8+xoHgqG7noVdON+qApZbvBwKx/jJ+Ff0Ay?=
 =?us-ascii?Q?8L3lcxv/QrH7Bv54dKnpz40mI1YB8GapadmhZvjThxSxrZNUvZp7TxHQoikW?=
 =?us-ascii?Q?JBaxx3iQ/vVJnHXLR5pZHUt2CIyuBpXP7z62QLW3HU38dZALD7SDdlhKt5aa?=
 =?us-ascii?Q?ylhEuZ2xmtgZjLXQj/aDBSl9O8fpcG4wDilweB761/LgrtgOel5XEpFzlpyc?=
 =?us-ascii?Q?O5xoVdhT6eow5SJ7pD5FbdIh/HAZrNtKYAk3ZbUC1Gc8kEp65J/ee9gDdRG9?=
 =?us-ascii?Q?yZRs8SMY33hcrJIh/NRYttwMMV44YOCqjukK88TRFahXtyF+5mrzCLTx/8XY?=
 =?us-ascii?Q?qn9VYSKlZrL1x/X1Z7U24vRg4vhuVby6QSOEH/l11XqDqUTQCjbUkyFWJaCS?=
 =?us-ascii?Q?00Kx1SKQtPwTB/6ls4WEJM5tLpy49NM+Mw53ePBFRWMQYbnBpgoqYh3rmk5m?=
 =?us-ascii?Q?mS0FySBv4wN55nHp2gFi3s0gJRK4CHae6s+lB15oPoLB4Q+xbiweSBIdkDgd?=
 =?us-ascii?Q?Va9Pcp/nEUydfNXDP6vt+ZHEHe6X+TlLASuhzb/pWUF5YylG+Grypnyt3fuD?=
 =?us-ascii?Q?ShMlAc47bBtluB/IV9RXIpUqF4SdoNewIgCfYzqiRfNEPdzQT39h2GdD8azj?=
 =?us-ascii?Q?Rd+kaMcsMrUJTX9PdyF8fRxDRfkTVMNdFibqRzj5lG17xejjhrNQDNy7Dg0i?=
 =?us-ascii?Q?csDySP0vP5HCnU1OgdS4TaCu1Pta5IGBu+GoEhi2nKaxdffrW7pK39zvv/xU?=
 =?us-ascii?Q?7hrJ+Dc81wuPlaer9r105Ybj1FP4E9vCzn4WsVNQnZJ/SPa6kbIFSUPzTsDX?=
 =?us-ascii?Q?4PQWJIDk5YuBNAnYWa9flpj/wlYSQCQhzkeHMYqREXCQDNBlbgq9/qHRzRhS?=
 =?us-ascii?Q?z4AUxCElEwBPfVWy1NAI9t/M+/1TjY7ksmkGW9lHzM3r8hANNDbDx+72wsNW?=
 =?us-ascii?Q?nkWLM5uUYZpycZsUL1yjv5Pa1OKSPhiaFn3XU9yvTR1cFDBk3GVSWRdt2bEk?=
 =?us-ascii?Q?JgUpXO+vulafQpycOkcJPSfy0zJlPiJ0wZZ6?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:03:53.0540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc418523-7357-4bb5-a2e7-08dd790a12fe
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9250
X-Authority-Analysis: v=2.4 cv=JOA7s9Kb c=1 sm=1 tr=0 ts=67f92f5b cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=tssK5cnJvUZjZf1PWA0A:9 cc=ntf
X-Proofpoint-ORIG-GUID: keLE-rckkqxMXMkV-_G9pmV3h5hWqRt0
X-Proofpoint-GUID: keLE-rckkqxMXMkV-_G9pmV3h5hWqRt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=930 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110095

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
v3: https://lore.kernel.org/netdev/20250404212940.1837879-1-Joseph.Huang@garmin.com/
    iproute2 link:
    https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
    Patch 1/3 Do not set offload flags when switchdev returns -EOPNOTSUPP
v4: https://lore.kernel.org/netdev/20250408154116.3032467-1-Joseph.Huang@garmin.com/
    No change (re-post due to merge window open)
v5: Patch 1/3 Change jump label notsupp to out_free
-- 
2.49.0


