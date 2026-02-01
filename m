Return-Path: <netdev+bounces-255642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGsZBbB4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:00:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A918C662C
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D413055624
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04592580D1;
	Sun,  1 Feb 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V3NdoqNj"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BC2472A5;
	Sun,  1 Feb 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961330; cv=fail; b=un1dHG8AkWNfEgZ2Hb41UbhMsMPZaJ3yVGvhLePYIyxRbnfjaW76FtDJaZZAmbBb1Dz8v7RJv0kH90v8WGZkwSWqFRtY7RqQTr+W4qHz3lcRI7+VKQTvywWr+aZkHxqipZTrg4570rGsw5Hw7xlAscJhwzvtiUJFcY/59T+CTqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961330; c=relaxed/simple;
	bh=rE9d270vVmS2As9tIhVYiUfMPpoX2FMLauzaD7UjpbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6H7XGHuKqYwPAY9yjVSo4QOKWCoKtpUy0doCZLk/6oRu2Z7hlBGos6Ak0eayt58pKFqqmM9bXiIGgHfamiSElFaCL7dibbQ1O/hdJ9gtm7jxm1LIfYuG3bc9LCT23PaoC+hbfZeXMR51LPDkn4Z7ZndCC4UsAXYumbeI3jrI9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V3NdoqNj; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8vD8t068IsJgyJ1HfPf3SsmPyDYXOMVd9Z1rGipBG4VGLoG4xX3jn1BMhXceWL5tt6cVZ2pLYRgIozE+VkpJYXBmV+rBSo6N4Tr7emE+6jSCcgMH6U/9jgFBp1NERWvJPTYzNX1/ijjEHY2YiBN8lzABLWglszMd9dYgc0yEhoa/yZR/fwnuSwZHoodnV+xwkhT3qR4U2EZd+eORLGPPJo8Q9xgSWC4CqrDnOlNO0c+C1LRW0arC92vA2AaunDzKCt7F4U/N1TNi306DKZklDa4FibJjGo/jut3Xgy6BNZdH0QlFHvS7DE48K7eJFd4tEwGlP5T1tJfUQZrqUhttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFshNZYZl1S8XAP2kuM8cVPJwHqf7PJ7rWETmnG+IbU=;
 b=grU64t0+zjb050rQNwKmvTwkMpnGM0K4GP71DAlM/N4V3zIyAWplwfzNMqJHeVBpnG4M0vcV6U+wt+OQBBn2r529MxnuciyNU1ZkHA5StFZbOs1F4mSff5MwD6foa5wEFBfruZ5wMh+zDDJmLs533HVo+TclDMNb/uwfaI6Jzzem89sFwTJsKtz9gHwH0gnzA80K+3YwI8s4ROwsemHbgdGouv5zYi7c1pIUHxGu/x750XqgfMnf9KcmN+3Yri7m7pwFaqmz1bNNR5iFrOabCY4dhhS3PDVqY7hlK2F6AisTlzMEPmSyCCJ7sWpxzVHat/oiNqfjlzjnnGlvNECuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFshNZYZl1S8XAP2kuM8cVPJwHqf7PJ7rWETmnG+IbU=;
 b=V3NdoqNja3WfW6ulyd5mr1Lp3v05zyFYTWeM3SxuV7ux5P9naW26r/FsDhJjilPULC+/m4S2R+p3rKSxRp4Tzw7r6k8+GURkxtPfXNa7UfEUu9I13S9KCl1fa8tLHapKzLGIu7kUJH/EN3Ik0GXeg9E55k6Gbiuj72cSZc5BVA8=
Received: from BYAPR06CA0040.namprd06.prod.outlook.com (2603:10b6:a03:14b::17)
 by SJ5PPFE4FC9FAB3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:25 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::35) by BYAPR06CA0040.outlook.office365.com
 (2603:10b6:a03:14b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:18 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:17 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v23 20/22] cxl: Avoid dax creation for accelerators
Date: Sun, 1 Feb 2026 15:54:36 +0000
Message-ID: <20260201155438.2664640-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SJ5PPFE4FC9FAB3:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ee7ae0-fd94-4e6e-3ef0-08de61aa503d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyvYbfHZhmYZITNKKRluHLSM1F80442Qzb84wV1wr4B9uI54oDCS18f2Cz4m?=
 =?us-ascii?Q?voJUiWa63fzVJA5hPSSAOYYYRjY0C4MGSQM/iYmyAWX5x05tvMc0O4HUd9j6?=
 =?us-ascii?Q?Xox5s++YJhABroOzQeY87/XmTQV7W+OTX7W9EIowWSxbj2bY44A7aR19RBb+?=
 =?us-ascii?Q?fc9+KO1/zpBj1VEP6O+SOv+MSffvle9L6TXUwT2PdFDyevAf+T+WTEk5ETzL?=
 =?us-ascii?Q?vqzIjKeWuV+RhDMoV2I3nnqReFH7G2soWFEDiJT8wx3srgiFt86LQ4GYVcrl?=
 =?us-ascii?Q?OaNj3P+tUoNlHRwrS2XjhwS7jXjjC8lMhttgSXjx8d1RFRufQFPrm2MxfVG3?=
 =?us-ascii?Q?v/2ZKq89kNB4OyTgVfWUYdYVfXwW5tTv4PBPHXG2cnnr28FQ4MCIIKX5+3G6?=
 =?us-ascii?Q?fmw9cKoTgXb1DKhZdF5jEnUL+kuo25zKYlDuUobGjHKS46brFEJoyl2iRlru?=
 =?us-ascii?Q?Qh8v6WK4/yGaZXqD3H3yOk5oo8AjzIW7qAzj8UE2wlZ4/NnPjkm5j+sZiZ4R?=
 =?us-ascii?Q?jMdj+uk8pBVmP9XdTU3Bc2Pg9zdDiwadt5HwFRYgxcBXNFSeVg2WH2w/OGk5?=
 =?us-ascii?Q?9HC7dmBsBe9TAT10ouppWL+t3JERqCT7sW5PEqqx5ENarWcTpY4OoGPv3mAw?=
 =?us-ascii?Q?xY4k7aI4haQpjLs0TSQH1ifTDSErpAW5q6ouM2q81XEnMvEsM8Bzp6bPD4rJ?=
 =?us-ascii?Q?6bvWWl3LTqs6O23N7UexS0BJtdrd51J4MJmisGAiDYvzrVrPAusNsqCNw5wU?=
 =?us-ascii?Q?67xxkOUDrn8HeGpKNacpEUUu857S4BJGnd6HCSxjReZhXWeV5smmXwGD8zi9?=
 =?us-ascii?Q?DYMJbyV9Jga1kpGsi1fiMMuMZnYa1H1TpGxzv97tDCUnfBt5ykK2W7NGS/xd?=
 =?us-ascii?Q?qIFr3qj+r/L9niZOznoJ/6KqABOVcr+TQg2pB9lIvrAoX4KvWgxQpuNnoHs6?=
 =?us-ascii?Q?qWRkmNwjSiKzwtLflStyopXRXy7VnLtfZ4Slcd38uPmVFO/1hJPBtU5vz5Fu?=
 =?us-ascii?Q?FhEjXeOLcAF3eLa7EuhyhBE6PFFar8FXtjDXz/MnZji3/ZafkqGEaV0yamCP?=
 =?us-ascii?Q?8Mfec8ugRPWCIJLHOv4Xm9BEqwjXmIV/Sk3DLC7avooWn79oZn6aogP8DUVP?=
 =?us-ascii?Q?EFzJKJrN6VrYXIDbAmCyYQZjaY1zsDoliwow7HSC8Os97PfopGrIdjksSZpC?=
 =?us-ascii?Q?ASmJMidHknVy6wU7NuAvJ+5b0V3ilgQIr8zPsjE4c7r99fkTGZ162OsZiP0E?=
 =?us-ascii?Q?oEMFEKm4vGq8Ib5AHUL1kRc1VXXG5Gto0Wb8ICq2HTVF/dD6Ynh5uw7qDilb?=
 =?us-ascii?Q?f5BLPJ8RuppTvtNuVZVnGg1YHxvowjFcs3okoldeL5nwEnS1MnK0H/AsqDtC?=
 =?us-ascii?Q?NDiT+0+4/v8nXfdocUq04xaZDJf91N+8GWR1kTEdNjEOtKWLBmcuUPyV03w8?=
 =?us-ascii?Q?Uj6owdL2M5FKQsqeRD5oNbOZkgdiQeyw/1PWLpkTi/Bz841IkUij2lxdqiq9?=
 =?us-ascii?Q?Yc1qYrCwYGHPevKVdBXLG+sBsK6aIynMoXjOCmRr+MibDKLvQCMPPIS5fc3W?=
 =?us-ascii?Q?gKkqJpFMPuJ+bBT4KF69JGFvpuPeBAmlh2sovJKiLqJjpO4dbdC1WvP5VDm4?=
 =?us-ascii?Q?CKNsFHlIrrCm/QvZBtoTCbftrDtTIuTEBA1PZNZm12+/d3f34UMLQMGfUtLk?=
 =?us-ascii?Q?EU+b1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3x+cX/u8skX+EUto+l0odZVXYAvNAGehVJgmSj9ifwawqZCGQO8+VnauZi8PvYR16dEe98z9KVRxJdKHRihdCs+UGfJ+qcetdMEPx2uElmjys9roDq5QUow+3El0Evg9jnqOkZZZgA5VfGH+aHCVYFC9RM95hntexqhWBeMgi1UqN1ue6xz5iI8f0W8uZnxNdA7b9TbcBqy0d0TU9iGMn7ZQ07bh/QN1COPOB6JATF1jdVkCBx+JMc5fbSnunDkixXe/Tj0ZdcveK+bTgmYx/+ezzYZ/yJiaQHMJORCO56hvbbYcBydlJEuF7C0bKsdvUNFI/VMxlCUvMnsuOqCpLVManqgTIO6XiduZjKkWPIe+XQnA20JJbPyyLI5aQVmFybvUysrAGe/kMYqlnZFv3IHiz25yo6WD1MYQdd+z32aMunxiV1DZ+0+tFM+GHnU9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:25.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee7ae0-fd94-4e6e-3ef0-08de61aa503d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE4FC9FAB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-255642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:email,stgolabs.net:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8A918C662C
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 293e63dfef22..12df717cc881 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4441,6 +4441,13 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
-- 
2.34.1


