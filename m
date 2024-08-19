Return-Path: <netdev+bounces-119918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB09577F6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B602C283B33
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AD1E210F;
	Mon, 19 Aug 2024 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="lLcRj612";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="eId3v114"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE41DF68A;
	Mon, 19 Aug 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107490; cv=fail; b=FK7TAqoohkTGmnbVDzX/wKnXtYx6YSdnPquNKLoqh6uBSRICsK3ejCOlgvc5vhUnqS3EdZkGDjVVXLl89XowrDXJ65nc04IWULvFgG2z4oahVl/hwWpGFSX2eYPJIIVJQXrtzJKolwzX7l6R2HlVACX8WVxjqhExpH7YQhSTF3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107490; c=relaxed/simple;
	bh=JcNUPBa0yUfLmGkCyN86lHBcACxIteer9QsLdGWCx7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d5ozbCkl680sEqyE6A4vs+YXuoI7kJo47KKOorTKDBTGLEDoYOlN1GTZmyFxL2CVgmpUU2UIQRFxsEgc6A4EfQTutjvkXx0YVAcRZlISIO2XIeZIWdY6rBAT43AVuAGCMSSfImrEkB82Aiw063cY+8JHJB04zOL35Qpd5Y4pab0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=lLcRj612; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=eId3v114; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JLsPNA007527;
	Mon, 19 Aug 2024 17:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=6txOXufq+uLSTxnBX4DlTQc+SzU
	ZlPqpD7pWY8sl76w=; b=lLcRj612g/RaL/bcHlR67ewFuugz2qGZ3WUkFFO2fWM
	rlgsPyk0Z+aphOCNJ/L/+neoT5QPbYLk2RjZknxwlDzn7kSXvUf4vEtcBpmYToMk
	r3ABIGpyV8PKHVjC7ZF0c/489eDQA4soHgINu0ZrECfAOsmDJP1ACm4yRAIKS7us
	fSzqITZTnRIUVVGRuvGndlDy6//pgo/4vkZrG2q/M+fkEQzKIfA0K8J4lSTyKNP/
	RJeKVSoMiAligpraQqnVII2niWCaPKDcOHoa1AwrF0ih26wF8GIbuQLGvoHuq7z0
	xhuYnf+7pdA/MlxAmBOlx7Fe1TwET/xflUne//fcPFw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 41455216sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 17:27:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg06MmStoxJWJIJioyBz/MKcLHT3sMkWWds1grZaBmi+ox0I+8ltRUClrlQ8/n+6y8nrjnXEhQGgmLXJ+XURG2qlwulrb65bK7yTkNEQARscEHHP+xKfVxpgq96ZndDbA+swnwfDxhZdsWtX/UccHO7jVKmIcKzz/kd2YlewYGv24sa5c33U8JH61wtOlGA/W3iT2K8N3C2xhFM89tCA4BvO2Wwqve6jgi6Kc84JqtteHghdBpTwMZEvk4C2oMR0jkcwGy8isgD4QQERPSS5c3nA2xRkF3ZwvRVpRUAvPqrQhvC/ldSSBDSTDdH8BIlLQ8/y2nAplM9HuJyh1CAPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6txOXufq+uLSTxnBX4DlTQc+SzUZlPqpD7pWY8sl76w=;
 b=otJWQWdVHurOsrEN1+7f2TRBvULqGynR11ZyquuCdiqzMkU378+xlkjqF4auPQ2l5qQVGFlSASPW9htYu2kFWO34Sv4OUL0cZ+TFg60JxCJikbqQ71sZHmp/lW4ezMZZUqnq3/iDxG2VSnkFgKO8wDOKIVbzzPdnj51vxBRYseOIC5V/pda2hR+KcN4bStZswGVEr2LAH4N82xovPG0ZyC73ADXiSDYb7AbjxYBpWNlCM5ds2UDlF+9haubNYHA6PQIsIF2A6PXXoO6wHLIY2QERS83MhwgiJayHgDstOpkZrE12nGEDPEjcGNistadXgvTcKF8dO9l9hX6z+EvJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6txOXufq+uLSTxnBX4DlTQc+SzUZlPqpD7pWY8sl76w=;
 b=eId3v114SgVlFt+VIxWQ6Ou2VM/mvad9+hocc0+erp61a6zxiYHMQzSWl6i/QHBj8SJuBGWwW5hkbZkaP9y4nSyUome2JxpI2/Ntfwt69mt2lN1Ulgxy+vM8tAJ+an8c8JbFDI02O/r0iWe804NJT6/Uy9qxpEt9hrtvVcUxO1HujPIlw08YKk5RNpbgT7vojkTancyV/6xPAQczN987Z3NY9QFvo2ckflpASVllReU/1tw2kcYhmYIGMObo+urpPZ1rce+yFzajkQqYsYsi9A4clY1O2Pp07mKY2RhsypfOQ3gZEcmn+y8edjcG/zPH0Aqn1vo/DY+LvC71M7e3dA==
Received: from BN8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:408:c0::35)
 by SA2PR04MB7660.namprd04.prod.outlook.com (2603:10b6:806:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Mon, 19 Aug
 2024 22:26:59 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::a) by BN8PR15CA0022.outlook.office365.com
 (2603:10b6:408:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 22:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Mon, 19 Aug 2024 22:26:59 +0000
Received: from kc3wpa-exmb4.ad.garmin.com (10.65.32.84) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 19 Aug
 2024 17:26:56 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 kc3wpa-exmb4.ad.garmin.com (10.65.32.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 19 Aug 2024 17:26:56 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.34 via Frontend
 Transport; Mon, 19 Aug 2024 17:26:56 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
Date: Mon, 19 Aug 2024 18:26:40 -0400
Message-ID: <20240819222641.1292308-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SA2PR04MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: baaaf131-62e5-426f-2fc3-08dcc09e0a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JlBO0JWdrW01ABqPeYUP2tADk7Sbizo34Tn7JABuV8tn6vCs9IIzK06ElNJo?=
 =?us-ascii?Q?/gDgFGdI3ozIv0ZJEe0Q9trzJjP9Z3MfzElqURIi7j2z8+qDfhEpGbAMRseU?=
 =?us-ascii?Q?LuWriwS4FtqXp6HfVMpfr2b5xYIWC/6RKFkGDGF69WWUYmdBgahYzuzXmkw4?=
 =?us-ascii?Q?k/9vOZN5KQyZgcNM75LA0xv++Le4DLR+zQvCdmkypaQKKOxaYThxCTk9wfNc?=
 =?us-ascii?Q?A71tTpHAK9UVs9m1nX9549VaWOP+Mk+gdCTEpxeeYo7cV/fapwhbeB75hWr0?=
 =?us-ascii?Q?2KODDJQWSu99wb3q3TPCI6AkuyeuFpuM6jFClviXVAd3gNE4e2Zl9RJmEsNY?=
 =?us-ascii?Q?7BgUZmQ6DJG0+qOHEZJ1H2UBaV0IdB9rePQmhQIK3VaC28MrbUJm/NQzQ5/p?=
 =?us-ascii?Q?LgZDUO7R0r7hZAgJnHYzyI4fRwa41REnrzGBlKFGIIVq7OlSdRXde9beSyPY?=
 =?us-ascii?Q?n9hBQ8U27V4aEo5Jp1c2PebH5VfjdXKrjqOC1b8j3jxlz05Z9mr1Tr0veHzo?=
 =?us-ascii?Q?QVS17ScMKC9aWUSt7zfvZO1rTnqffGpJaGGNXJs1ctw54Z+PaXWC9iNzoCub?=
 =?us-ascii?Q?lMxqAJGEBY7tyPPwgZKBhoopl7veRI8k+VArfedahbs9xdc3KCqxD4FR8DyS?=
 =?us-ascii?Q?Xf+Zk+a+mmgdO41QlKt1UXt0xvpaZwp0UPFr0hsRrLj4x7+3tbS+GJTQAo6e?=
 =?us-ascii?Q?buubvB8n8Q5mBiSgmdAVrEpW61ZIc3Id8JKWezKeLpwC8LDRXIuF0jfBDOMN?=
 =?us-ascii?Q?uftq4uKICWAjZeE57t84NubHM/dkiyarlNmjDnF4BSl9KRtTcCo0SBJe7GyV?=
 =?us-ascii?Q?Fzb8BqXqcqk0MEVzLdEBhO7yjpH68cOdPkHzgmLw0qVfLnQkU98rWAUFlDD9?=
 =?us-ascii?Q?hyAh7I9LdvNVNfSxLYEuzTciE1CLdE8xh00m9D88eSMpTEItwFUIzfvGQ8XN?=
 =?us-ascii?Q?vFG44va6FJiRQCIWPS9h5iRU4aoEKi2wtWhvxL6YdM7snzLaR3y9hQYgEIK9?=
 =?us-ascii?Q?SwGVbShrpc3gIhv8bwfu4aPzOIVCYZs8k8EmKGgc+qZxnuQpTnbi9i6nGIJ7?=
 =?us-ascii?Q?j5Bqj6THBbb5GLPvSZpZjKAk2Rrshpr1cJ2BeHFX+geNe/ICvE+6ekq45Dok?=
 =?us-ascii?Q?BiturZoNxGCXEdLwsauyPwx0HBRNJLnAdofybVg6yzfv4Gs4iVBIiqBaEosT?=
 =?us-ascii?Q?DzhQZjohuCQuuW96oMfRfRFTAgefz+RQkHWI+wEyEfWp1jfHC9rMpsm+M4H4?=
 =?us-ascii?Q?QS2/1+IY9osHbrM327mjvGEmfdiv5Gj2sJioMvSg1dRb4CR4c3v+MQ8181wc?=
 =?us-ascii?Q?Lg16oZyNptSbos47oEIsu9qrBbev3QgowvyYjtmR885IL8ktfxjE0eglJBrL?=
 =?us-ascii?Q?SJw8rQVl0H6Q1qhxWSaBLkTvHhcdS9xzJC/N8ER+9q74A982qRd0p6NTc8ke?=
 =?us-ascii?Q?ixxKX2huBs2oIySwsHr9NM2E2Wh9cJfx?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 22:26:59.3669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baaaf131-62e5-426f-2fc3-08dcc09e0a9b
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7660
X-Authority-Analysis: v=2.4 cv=U5/ADvru c=1 sm=1 tr=0 ts=66c3c6b6 cx=c_pps a=28bFCgguF5sZfysLuYgbMw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=yoJbH4e0A30A:10 a=FS7-D2N0u7gA:10 a=ShUJUk9rLtwA:10 a=NbHB2C0EAAAA:8
 a=PTDLi0RsCyGZMGRiyFwA:9 cc=ntf
X-Proofpoint-ORIG-GUID: WVeUih0WIQlau1og8iM4_Vc452PV3Peh
X-Proofpoint-GUID: WVeUih0WIQlau1og8iM4_Vc452PV3Peh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=924 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190149

If an ATU violation was caused by a CPU Load operation, the SPID is 0xf,
which is larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[]
array).

Fixes: 75c05a74e745 ("net: dsa: mv88e6xxx: Fix counting of ATU violations")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/global1.h     | 1 +
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 3dbb7a1b8fe1..9676e2d42c9e 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -162,6 +162,7 @@
 #define MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_AVB_NRL_PO	0x000d
 #define MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_DA_MGMT_PO	0x000e
 #define MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_PO		0x000f
+#define MV88E6XXX_G1_ATU_DATA_SPID_CPU				0x000f
 
 /* Offset 0x0D: ATU MAC Address Register Bytes 0 & 1
  * Offset 0x0E: ATU MAC Address Register Bytes 2 & 3
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index ce3b3690c3c0..b6f15ae22c20 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -457,7 +457,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
 						   entry.portvec, entry.mac,
 						   fid);
-		chip->ports[spid].atu_full_violation++;
+		if (spid != MV88E6XXX_G1_ATU_DATA_SPID_CPU)
+			chip->ports[spid].atu_full_violation++;
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1


