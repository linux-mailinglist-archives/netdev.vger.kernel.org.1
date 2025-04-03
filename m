Return-Path: <netdev+bounces-179221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08DA7B299
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435E13B923A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE65C1DED76;
	Thu,  3 Apr 2025 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="OCcywpF1";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="pzdcheih"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FD1A5B86
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743724510; cv=fail; b=hFS2aNVNX37GyG3nwlmQLKquXytKzGybii/ZzWetBaNvPOdwm4pY/f0les24uMEKymky5MW0H33sHaDbUN4bL5uBGkiXb1To0kMq+q1MKUOl0hNjO++sHjncJf2W26u8iBOOl0jrMzWelnnS4pA8cT+tWM0BZtMuMfc/4NvTVzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743724510; c=relaxed/simple;
	bh=vj0KMaotdBb0ETEuIGoEPDfeyxL+IFIQFlZZDqBAGrk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o19i4kIv8R71qe+XvqW2Ij2XrOhJV9tnjafwnowAXZwYSrdaYlUUnpoX5dcW/FfunijquEL+BQG83OzAowXNRRdvB1xFsTRB6fK63FaLa6hS1l3dh+ucEGuvMA9xwly5yvDqxJKa/HqoM1lxG6cnETrTVpGeRFDdpwu5fn9JdWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=OCcywpF1; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=pzdcheih; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533NnXcg014568;
	Thu, 3 Apr 2025 18:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=pnF4nFL9LwkG4awe0v6WFiRHh7M
	d3Dr6mJ0G+Kh1sPQ=; b=OCcywpF1EoGr/qC8MTYWHybsLt0Nc382bPhSUQ3PxSu
	/dAlqV7WT7pCMvSW3ZhVefbk14xZNPeWedn94oQ802CMQtqkktmcFN4xN6Y+qAaI
	RSFV2qCCD7+YXyz/3OnAErpeSDrcYbxPXs9pG73E0C54GOq30QqWtZqD5lXzx4S5
	l5D+aorqlcmLYlf3G1bqMOiAUt5Fsl9DQ1YkOcFz6ojqebOpSMEc/ojhpLWKkhiY
	nfnM9YmtOByIgES5S6ephOlxX6j3ZXBrB8JgEs6aZ1NQ48BDMuqZn3k4V8zLxftF
	hHvEwom0fKY32zrCvmqzqMRfljd1BcDtDzi+Umdk1Xg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012035.outbound.protection.outlook.com [40.93.6.35])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45sx7mrnwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:55:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2ESAOJmXTEUWZ/2gpz5azPnX20fmrwvoipKbr2adBpGVOyJu8HGy0rbLZQxGy4rxMS8X0hA86okNfplVp/zkbCbdM37phdK3uazIBS377IxchDdJC+j1nzT+QS8Jx7nQ8BTHAD0BkVhbdu4ihZsCVzEs5iz7cvMMD33yo1oY/gooAFQt8TJxyCyQm0CWNLZ/nZ38bNvDmkgm0dNcfOXYhXvx14I1G7fk4pzHXyo/0mzZfyKaW+1My6Hub8KJ014Gtjn8S1mncDLHNUn5fXXGOePmWdUkG/06yAJ1P8cVThEp0V4IfmR05lGV4ARHayEKr8W/k2eAseW0othanNKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnF4nFL9LwkG4awe0v6WFiRHh7Md3Dr6mJ0G+Kh1sPQ=;
 b=yJFoj0UVwvVWSDrCGWBOXyDF8+K9ZD6QQtWJd0DuJIyU4p3FR/mLMpNcwYyXrUb2FzL3Caev4/vFl0i/yPP3tMe8OHWly3Gh8Vd+IUBfNRXLI+/P54ZC2iFTSR4mCptgwhyjaVjGTBxRCSfggc6Ewxn4wLacZA9H7X3cYdVGdySmQ6bzDE6nW3FL8ObZ8ha6gSvpD5kGAZ6K2x5hl2RxQs5AMhqPddxr9VhJEDoNOb6KnmRfmqXnpoQTVMDtKPTfumOEqn4fzgfjRrlGSZRvrsYWODRs+Gz/Mm6b3g1SB/sO3GhKWeFlCMqYXWmNzRo7GE3z6NcGVIIkElhcDoZNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnF4nFL9LwkG4awe0v6WFiRHh7Md3Dr6mJ0G+Kh1sPQ=;
 b=pzdcheih/8n2NLYoMqR6pXEVNaTeEdSJJxQBOS+Z6abMcfO/EHsj3vqN7ZmCzJO6Mhwdo1tC33AJLBvB7hk0ON4oz5YzLDK2gRZBPRYqMeB4l0rQE+inO7pqFp/kYYzwy+GpwDpYiE2F4dIOOamYZo+/NlPHuWVcr1gPzM+5+j9azX0afipNiTvEKaALpW62t01/5+ubAbhMb6CxKx4wCCKqa2DBbL0jRYrxm1B2hvEudQ275hzdAQQXmBC6m/5P0ysq5a5yJg6sIfH3arLv2JXL/f02e3b+dH/8767eXhXEOLbmUyOgU+r14QbyVKoanGa3e0SNAPhE1BbatQwm3Q==
Received: from SA9PR13CA0071.namprd13.prod.outlook.com (2603:10b6:806:23::16)
 by PH0PR04MB8387.namprd04.prod.outlook.com (2603:10b6:510:f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Thu, 3 Apr
 2025 23:55:04 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::19) by SA9PR13CA0071.outlook.office365.com
 (2603:10b6:806:23::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.8 via Frontend Transport; Thu, 3
 Apr 2025 23:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 23:55:04 +0000
Received: from KC3WPA-EXMB5.ad.garmin.com (10.65.32.85) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Apr 2025
 18:55:01 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 KC3WPA-EXMB5.ad.garmin.com (10.65.32.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Thu, 3 Apr 2025 18:55:03 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:55:03 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 18:55:02 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [RFC v2 iproute2-next 0/2] Add mdb offload failure notification
Date: Thu, 3 Apr 2025 19:54:50 -0400
Message-ID: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH0PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: c67dc57f-d184-41c9-893b-08dd730af4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLsob7WI6N7IbHuRNWC4R9ZRNDXEYiaTYp+zISrKdlIV6/zvitjiPiyXLGp/?=
 =?us-ascii?Q?zGK9sds9tPWHZRjQHwZVIE+VOZkkWKFrayYIrQ7UtraTgS6ofLQsAvpB2zZH?=
 =?us-ascii?Q?oMlBkItBLvlPsGpEBwLvPVhs0JT79ae2zPGusRbAycvZ7s3g+chrL+WwcLq+?=
 =?us-ascii?Q?4M/g/K03zKz8e2UK0RG8Hzl4ribQeR/V2frSCMBXK/YZsulipyYy/nPAa4lJ?=
 =?us-ascii?Q?CwtbKTwVZeJxg3pwDm7sXGHmFCaDIvgzIL9IpsPEt0pIX51/i5hak/95M9SB?=
 =?us-ascii?Q?PQza0fM71IdvczuNiq2SSgLwsbI773bFVoeM2MOoLz0LhLmhDFYCOVhpKE4M?=
 =?us-ascii?Q?/hZ9PCvmrc+ZJCXBuw+fxWEir8f/pONjookw4Mw+w+GOngky7qAyVAzZUF+5?=
 =?us-ascii?Q?lUeAgsnzwPBR/I9tDpQIGx2bC+03Wym73I45h01sGQlVfyLNeQmFPEUvlnrg?=
 =?us-ascii?Q?M6IeMLtikOxj9XG0pT6JFsehLZTXc/EKSYUgcgCA3g2l3GPPzMbXeO24MaQi?=
 =?us-ascii?Q?WOSZrWsRc3gatPtqaM6Om/Jyl2lcO/ZOCWBbWVzCzhq8lbkJR71NZ9oTUWTp?=
 =?us-ascii?Q?zQrSSbS6o3RFsK6fItNGLfCAOkjoagdkrLlRbDAT5ZgVC4QCt08TUlcbc9YI?=
 =?us-ascii?Q?7TYfI3M4M7COUPl/p4QYjo1fu4WQKpXDCT4Sd3nkCHpE2n7s2cVse+J2JZSf?=
 =?us-ascii?Q?zmizz55fuDa94TEOWA+68yd+iIQzU9DMs1kIXpQWkvE3VhNUgYHVAt8hBWn+?=
 =?us-ascii?Q?lqXaE+9hHsFhkAKjH4B3e7enES0+hVDpDlAduHf7qSifkk5HtIMp2vM9ueXg?=
 =?us-ascii?Q?t7jjfiRFAEiDY6D0gHzAt2WJWdSmcVoBh5cVLawGB4Pg0a9aSkdm0Yc73vLD?=
 =?us-ascii?Q?CJuMnFFSjksbNshqnM5jc1gYmRaOIs6z8Exu7pr+f1GseAoTeWtV6xUngs+w?=
 =?us-ascii?Q?ZgO/AZ/+6HUmbhmuYYZNDm30tB8yExmRnmxWBnoVXNoCmzz0MczkTehxs+zX?=
 =?us-ascii?Q?jwJGMduPicu0J95ETEhechARby3NZ4DpLutZPBzgeZazrWHjy3dVuCYUAClr?=
 =?us-ascii?Q?xZiezVxVi4gVxZnapJeZtCqdtji4pxX4yRqgPW9u+Io8po6xDTjVgWMPD958?=
 =?us-ascii?Q?PRQEdjYfyTTNHsryfBT8ONlHeKTSeErCNtj5rdPoI2PlMbeJ6ak97YDqK4zx?=
 =?us-ascii?Q?Z5rKJ/lFWNfImHmm85WWS9iQL7I2EL0DxVOXljfYdtDPExeCBqbm1xBG3Y8N?=
 =?us-ascii?Q?5hD/uDkliBMZHVMdkp272c9gVBtxazAGhqmKRfsg9VvXICTh0gW7UHa/Kr6I?=
 =?us-ascii?Q?s2fxFMH20lj/CHa5Y3U2gGugnV/FrSg4TupRLG9z7QTTqP+ECcVbCOpSZ7SX?=
 =?us-ascii?Q?li8FtgImyczNXvuqRubbjOcvkH5EHX7QcBXy6ZGRqrG1+Zbi2jgOtOCjG6Co?=
 =?us-ascii?Q?I0jgctb8ffJVcgSch7DkBUMwSmLUOiXCINdMAVEROUxQC4KOkVPQaqdiSgQg?=
 =?us-ascii?Q?kDs/JAgjRhmbzZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:55:04.7462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c67dc57f-d184-41c9-893b-08dd730af4b0
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8387
X-Authority-Analysis: v=2.4 cv=GagXnRXL c=1 sm=1 tr=0 ts=67ef1fda cx=c_pps a=PqLCZuQUPt6kYvSH6Xjk2w==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=uTJ9VrSgIDDRKCPko7YA:9 cc=ntf
X-Proofpoint-GUID: ZMqSM4HjGmVZ0HWASRoymiZkGsdhR_fD
X-Proofpoint-ORIG-GUID: ZMqSM4HjGmVZ0HWASRoymiZkGsdhR_fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_11,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=612 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1031
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2504030127

Add support to handle mdb offload failure notifications.

The link to kernel changes:
https://lore.kernel.org/netdev/20250403234412.1531714-1-Joseph.Huang@garmin.com/

Joseph Huang (2):
  bridge: mdb: Support offload failed flag
  iplink_bridge: Add mdb_offload_fail_notification

 bridge/mdb.c          |  2 ++
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in |  7 +++++++
 3 files changed, 28 insertions(+)

---
v1: https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
v2: Change multi-valued option mdb_notify_on_flag_change to bool option
    mdb_offload_fail_notification

-- 
2.49.0


