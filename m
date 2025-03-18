Return-Path: <netdev+bounces-175922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8040A67FEE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56653423F00
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF9207DE2;
	Tue, 18 Mar 2025 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Xafjq/HD";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="AXfpqnbU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A142066CF;
	Tue, 18 Mar 2025 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337848; cv=fail; b=SNGeo93ZwXwTRvKKVu+pDa0d9gPpaqdVHgtEL7FPIv3Sb7FijIKyHcZdq7gC6tqYzvXyL6kjfhpo3hFjXNeKqU9L/Ic9vrd6CJ12aH+RRm9OCh252+vCi3nq+1wS3X9VzFpFuF6BdDRR5fWNAXK12uKPpRv8ldbyuohNYas31UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337848; c=relaxed/simple;
	bh=WYYh45jjfcFjhGoxjq4Ra4ipSVczxDvwhM9gk9b5hnE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGKspks5Vd2fQ5k8B75yZwEV8NKCy3ET6k8BHzlrkT5KZfJPJv0XE+0MNcTppHV8KBoFcLMAmyY4tjr7f9eAeiJNS+BkEXNzsmqFMFpVp7PEGggIogMzREGwOp11NfiES58Bh+amsaw409AkDFWRg7KCrmvrVp80Yaq1NAcXRAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Xafjq/HD; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=AXfpqnbU; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IFLbHH021869;
	Tue, 18 Mar 2025 17:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=0VMc7GCuZAK/pdflI8BZMlvsJLo
	sAdAlIFhNbvJsssA=; b=Xafjq/HD7j1vCn8i17KHVFV0cD+x3uaxxREgQOciLp5
	hEazyanWpYnbOG0tCghnT8ZJ5EKMtL1Yww5JdWCi38eYA8f80BbtbdxaqOUdqOM0
	CQUwih7J/k8/Kc/iMoUMxq+dab9V/4M8AusrnXfn+sbfEnq3RpKUMkbxusoy59wf
	zRcPg2GpcbrZ3zlBIRNgK/1w1WnpgLTuhoYkeGw/ygqx1McVzPGADgsRPJ5mOIBb
	NJBzcmbu2wGlAS0QAg3hjdrotRzrvEX4kXm9HQffV7L3Zkh2JgD6g1pH7PAcYAc7
	DDl0CHi/vpDDeBOZftst8V2c2ZVD7Rw+7wRlGvYDEGQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010007.outbound.protection.outlook.com [40.93.20.7])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45fax20tgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 17:43:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gID5SYQKIsV9PyErWX7jV05CGbvOIifgWJBI5CN3yWMjhsBl99TGuXua0/APGC08OB+AwkNcCdwCvD15ysy+HNLEQMbM09PxUWsVVyvyk0zYdgkTMJ9ZKipL6qh+u3GJHzoawsT0eLk1JQHXnx9M8PMolJ0+P7ULo6U7kxFRLtnh8BIcmUjATwIYvQzyIP3hjnCwBR9g2YmPtsbkQdeMAfJhCSBpMA0VbIAhmFShvknt+ck46OVz7vdxskHMW61a/biyncyfyA1cPn4JB40IhqTIg4K3yGbPsomOpVxwNqVNPJCVN5f+thDAj11O2AR0JtH3Wk10LpyN7/phfZ1fhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VMc7GCuZAK/pdflI8BZMlvsJLosAdAlIFhNbvJsssA=;
 b=SeAS2pv6UI/ub7BrxGYbluuzTNuBBj99BuiPXyIDwAX16c1uAS5YepkkeXLyISJ5rm/aAevyabJ5kDZk0UHMl4bwKTTRObTNnNsgd31vmOA0YhLOiCYlo8wZ6nZSXH5ENDoUgsi44SZ2QKHqtufx2yBenLV17TUM/7dpmP8M3pQwWYJdbTOOYsS546zWHRE85tEjbE1JuUl9PT1v0DsyAp8W7ioz3ka/b/pkUd+F0kx5CUzdc0YDMp6OAGlJ8Ga72udXlonld4r2vaPCqTJLapXQS7KmImUIdcZMnhMirRvZ8+niFdWnkOp/8CvXHMQedAncduTXx+ImP437yCVgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VMc7GCuZAK/pdflI8BZMlvsJLosAdAlIFhNbvJsssA=;
 b=AXfpqnbU0lUeqVWWSLZysmrIXRp71hfozt2C52fD1RrKk13iSJ1kNHpvas7RBKahDfB9v9pUbz05W32dV8ClX5jvbpDfYEEp1Cj3xySgH7yVafR9oAItjRWLRtHx/p33nOWXxonuJQXXe6OM/UKiMN4mbdoMXDeXwkGSyXw2sQdL724NW5vnAB5KqdUsjtd+HpRd/pWL8P5QLTfvTgk+fAVB2g05/wKRYhOL2YZohA0u8NmJZNR0lJIl0m7RQOIPI4VKZ5gZIDcef6iycwlYkAZveqUHdfFaIoS5ape8uqoQ+1gxoa1BBvnPrIscQ8MlnKeLe8CTBX19A2zhW/s8Ig==
Received: from DM6PR18CA0027.namprd18.prod.outlook.com (2603:10b6:5:15b::40)
 by DM8PR04MB8054.namprd04.prod.outlook.com (2603:10b6:5:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:43:39 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::17) by DM6PR18CA0027.outlook.office365.com
 (2603:10b6:5:15b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 22:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 22:43:38 +0000
Received: from kc3wpa-exmb6.ad.garmin.com (10.65.32.86) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 17:43:25 -0500
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 kc3wpa-exmb6.ad.garmin.com (10.65.32.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Tue, 18 Mar 2025 17:43:27 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Mar 2025 17:43:26 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 17:43:25 -0500
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
Subject: [Patch net-next 0/3] Add support for mdb offload failure notification
Date: Tue, 18 Mar 2025 18:42:45 -0400
Message-ID: <20250318224255.143683-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DM8PR04MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e23af1-247b-4308-227f-08dd666e5387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5syNWT1J13aCGy/XSnjXjd+FWd3oVtvtx7Opo1G2PaKtd3ies+sEGOO36jO?=
 =?us-ascii?Q?hJCYDJjqmwgwHOp03AhWIvnU1SCbl57KFZ0JHDvGWj0XZ09i8WNNP+1Z6BBG?=
 =?us-ascii?Q?tL51caVn8jQAyiOZirsgtdmog5AaiuY/C+Mv+Bw/4y7BB31rcTy5LtiploTf?=
 =?us-ascii?Q?hk9w4cvSCu7gH1oUWRk+/78RMRywlQPOlSsRzD64LpZzvtz0FNcp0ljLPxj7?=
 =?us-ascii?Q?PYDwaTwjlLIZ+pkAroN5EXjp90/uTGBYie+myxu8M04yM58qlhBYYyxV6kmj?=
 =?us-ascii?Q?KV/913wsni1Hc4gdWSCEds7sLKFlhixsR9GX6fuU2Yzcumflje6Qfk1blWOY?=
 =?us-ascii?Q?aZgVMGs8HpPJG1XtjnK2upwO+qq8v84iO99PTsiY/JCLtrFKAJamab+etU4p?=
 =?us-ascii?Q?ov5LxM1swl3yQjHkdfTWkzk6jEoL6zAfJIUZqKb4c4vt33DpyPfVzyRne4Wz?=
 =?us-ascii?Q?qwS/Vwp8yaB2z2Sz3qt96r6AU3Lkg76YKN7rjNJBfMxK5I2gzN/ROIRgbGgs?=
 =?us-ascii?Q?7mvEO8cPVGc2gR3krv1c1NeU8u3VBojZMuzr4eQU0D8QjONr8xW6sfFnlDGo?=
 =?us-ascii?Q?CjRPQZ4K5wXaMU+6sFt99c4Vxk0EAuid3pFGfFqGvBmkbEqgxUqHgflQFSDA?=
 =?us-ascii?Q?YEsOlgCs4msTrKfe6crf1CeHt0HX2/gcrDN63oAMsDW3g7oR1r8bsEK6O+PT?=
 =?us-ascii?Q?yQwFiu7//R+/9WmS2FdAIfBRN3A0v27HlBqXKJK8cUPZRHeIRv7yE6HS4Xof?=
 =?us-ascii?Q?r1/bcIlCCrZ99fnYPJuqkBczPNPlpaQduahIvg9LUEFHqsqqFnWFbp68rWTb?=
 =?us-ascii?Q?KxxgBz5eGAa6C+vVWarfgFGVgSm/fb88s17sUQmV2ENh5NtApYOihqSLqi4G?=
 =?us-ascii?Q?Elkt0UCRtG6tICULD1GqMGJsceV+b33TNxQ+P3GOkKcaENb1xdsEWIvwmSFt?=
 =?us-ascii?Q?rLEYo42UmsMb6rR2uXVLacl9GLSAlRkqNaTw0Eu3Mf3zdM65h3rviJ2NEOyj?=
 =?us-ascii?Q?/wa/hBstsRxIrIVTURbvSSJEppWPcX6RZ0/B3utXfODgfisdA217rhbBfBjB?=
 =?us-ascii?Q?kWP5Gd3UaYwn0wftluNaphdP4FVhc3RM2FCqWJD8B6K8aO8jk9A1YDg3BZwu?=
 =?us-ascii?Q?/mvSMLA+Z/VPSBnJwa26mreGiLloa0ju+FhPbGg+Lzr7icArbX/JHywwnxRI?=
 =?us-ascii?Q?k8xQhA9uMJuy9uomDSNx/DsiQ/iXzKmBIL9SP3KG4OBU99CP2e59N79+78fZ?=
 =?us-ascii?Q?Dyo65PydDEVgjy1S0UhAbEAD8b5MdgeFNvcbIG11Cka/tWcgVgcOJBjNe1iP?=
 =?us-ascii?Q?qsNQ+SQlxfqlqx4//KjkCvJwBMSsRQKY7RZGc4qPqYN/1jlvR4wOxo//QX6+?=
 =?us-ascii?Q?CqOe1TWjAi6m2fgfpA3kg/oixmaDrD/V18sHEgo28D3Zcvl1nK2KZZ2SHzxF?=
 =?us-ascii?Q?apQ3iv1H0bDcsVef6TdYLzcqcSaLSEGKpxS2vc67t2rwK+5yKMxFXveX0YzM?=
 =?us-ascii?Q?fPE0OaLm5nepK7U=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:43:38.6373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e23af1-247b-4308-227f-08dd666e5387
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8054
X-Authority-Analysis: v=2.4 cv=BrudwZX5 c=1 sm=1 tr=0 ts=67d9f71d cx=c_pps a=2D6/CIrCIWs5X5ruZf5FWQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=MrIui5EZAAAA:8 a=aMfNSo1IPVqh1VC6cVUA:9 a=QwFSjxlF8r7T8Kp9ipbm:22 cc=ntf
X-Proofpoint-ORIG-GUID: MSfbSk35fSYAFbE4caKCw9ETBsKHTjIy
X-Proofpoint-GUID: MSfbSk35fSYAFbE4caKCw9ETBsKHTjIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=824 mlxscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2503180165

Currently the bridge does not provide real-time feedback to user space
on whether or not an attempt to offload an mdb entry was successful.

This patch set adds support to notify user space about successful and
failed offload attempts, and the behavior is controlled by a new knob
mdb_notify_on_flag_change:

0 - the bridge will not notify user space about MDB flag change
1 - the bridge will notify user space about flag change if either
    MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
2 - the bridge will notify user space about flag change only if
    MDB_PG_FLAGS_OFFLOAD_FAILED has changed

The default value is 0.

A break-down of the patches in the series:

Patch 1 adds offload failed flag to indicate that the offload attempt
has failed. The flag is reflected in netlink mdb entry flags.

Patch 2 adds the knob mdb_notify_on_flag_change, and notify user space
accordingly in br_switchdev_mdb_complete() when the result is known.

Patch 3 adds netlink interface to manipulate mdb_notify_on_flag_change
knob.

This patch set was inspired by the patch series "Add support for route
offload failure notifications" discussed here:
https://lore.kernel.org/all/20210207082258.3872086-1-idosch@idosch.org/

Joseph Huang (3):
  net: bridge: mcast: Add offload failed mdb flag
  net: bridge: mcast: Notify on offload flag change
  net: bridge: Add notify on flag change netlink i/f

 include/uapi/linux/if_bridge.h |  9 +++++----
 include/uapi/linux/if_link.h   | 14 ++++++++++++++
 net/bridge/br_mdb.c            | 30 +++++++++++++++++++++++++-----
 net/bridge/br_multicast.c      | 25 +++++++++++++++++++++++++
 net/bridge/br_netlink.c        | 21 +++++++++++++++++++++
 net/bridge/br_private.h        | 26 +++++++++++++++++++++-----
 net/bridge/br_switchdev.c      | 31 ++++++++++++++++++++++++++-----
 7 files changed, 137 insertions(+), 19 deletions(-)

-- 
2.49.0


