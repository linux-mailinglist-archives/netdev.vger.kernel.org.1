Return-Path: <netdev+bounces-303588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X9cUKjHwRGp+3goAu9opvQ
	(envelope-from <netdev+bounces-303588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:47:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808F36EC58C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="Hz/i8yvr";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303588-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303588-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FB47301A046
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E1C421F12;
	Wed,  1 Jul 2026 10:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B641B351
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902504; cv=fail; b=kJEyO7PoQLs8gtrufqFXV3zU/4Vp5FY+7ah/4Bo70DfsB8WiDVQADwyxqANJAivah0KkiYSfN3rm31kil1az9rT0nff518f7b0Zm/nq202yxehqEOXWSzADrDe6uDN3KDlSuBaBAVGkR163aZUm6swbnZ56KT7ygwI+CrlaoDY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902504; c=relaxed/simple;
	bh=5WN1PcY5RCzqiDRSHw/QzA4HBRnqCe2CIBN2FSSzovg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBWX6FvzsqKdlbiXbJuEBwpTge+1rpxKx2oCRy4J91X+XoTQTo5FUJrXzFX6WOaSI4OSRvKP5ggLNYucxOJ7JEiP0nrtGg2F8xW8smrTNYHl1m4uef1r1XtX53OfB4UHX8OBEzKRmcHcBCyMCt4z4iSFNOThjaQxXMRSpOkyeLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hz/i8yvr; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWJBo5D8EPzNwkpN045inT/ymX6g8HPVZkHK0nFgnFsW8lwVcpL1ZAvjUfASpaVyo+Yq2+dTnqZY8Kvet4n3kWKal9TmQ2igTNSlrNsvGKtklIpHsDxmqM7Zq1AvIPraG1S7FMqMtgtP7JE86LNFJeZxSE9A8v48vSkgtUa/Gu1PKj3PzNzglcV3H+whr8ngCzf8o93L8RVo7ykbKBuw653FdAHX2/m2aDXq7L3T2Y91Dn6mVJvykw2jX4N+hdtkCSWZelTEJH9AU3k4prtSgPkgBs36A3D7F7l1M2k5k69WMgTEFJa0HjuimEfk8c5C6E6+DqTSSMLP9eXwBiKcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlCXv/y2aYg7u+/O53I44MHU9+PqF8FfGZvsl0Nbctg=;
 b=woufZLvDi8czf869hixUtl0vzg7lMbksStfJDd5U5kIucCE3klydL+ScJecbJe2hU3fC2Pmvyz+18bfJZ8ViGDwkaJAjbQAQyJBzS7ZP+cgRCXojBBEv5iNU7wD+mOvF0rOq3DtoXqYd0a+k1FUb32wFcpiiE4EhQ6voE3WvZPqY1cfVDRNsEVga44GzRlxrKALSdhuAEaAl8fqEK3LkUN11UGqvOHEuu5tWyklaOIG0s7Mt8SOdwIK3UM/PhkZ2TCu61ccjI+DVBDRj7cQ5PcWEYud/FYJJmMBZjwXM2EyuHa3HQWVqW5JNQe5C8MVHdG0VLgGJDgmcKXTVCSEV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlCXv/y2aYg7u+/O53I44MHU9+PqF8FfGZvsl0Nbctg=;
 b=Hz/i8yvrRA30Fr9Z9CUG6i6XRoEE6Fg0vHJb9TDln1BFqMmEe1JTPo3RLn9hHilOqD90Tw6yoIpzcRz7vezQJpGzbmfVguCyeh3kCcb6uAAuXE/EBEmYCJPnHeVMFGpxMv2dwDUr4JR/y9Od5z8CrpHxLyiMcNAxEa4rRavo/ok=
Received: from BL1PR13CA0174.namprd13.prod.outlook.com (2603:10b6:208:2bd::29)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:41:38 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::aa) by BL1PR13CA0174.outlook.office365.com
 (2603:10b6:208:2bd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.4 via Frontend Transport; Wed, 1
 Jul 2026 10:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:36 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:35 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH net 5/7] sfc: Initialize cxl dpa
Date: Wed, 1 Jul 2026 12:38:03 +0100
Message-ID: <20260701113805.14072-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
References: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: ee39f019-59f4-454f-7b3a-08ded75d53b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|6133799003|56012099006|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	OTs7jaLn7PWD/bPAysYmBR/46vSYEgvWaXa5aQ2VsBVZPab0AdKo7DPhUQKzMyZ6WAaRGZ5et7gBCU8q8V9PpJ8hR3z9a3LPnD4ovX5c9TOiKscV5xEqjaqiGvun0/OkTbLu2UDTFodbpt5gTaTUxWrXXZ1QvUidhDGQNb1EJc6hKc6lnoFc23qhjysZ3QHObbKyqlg8fb3KsiG2gOwPbga/qttbvsme3FZgvx5iusTqHpIzkcx+Y9+mx4b/NrWtJB0KJBG871Q+OSwbHflMrJlBkzjrZg6zEuR4GS5E9TL+Va58Ew8kS05ixWWBQUV+a8R3KiGM3pFjvgso+Eqz4/4czVvab7YzbY5bBU8OLXVMHWIpRlp4KvNF1go6/lwIpTuybMaM/vuhMnny+wpHf5fGStZsmpRHXtX36CfcKatUhTUPDfdvdjRVDaZ5/AZyaVDLdOsnPBAx/RUNmxIKadaNcF6bHHle3kVkoZD4rMB5JWoW1uem1Ui8/4pfjg1tnCDkejBPU+ABBimB2skaRFBGvfOthXJswZRDGYabK1BdWb1DHsV94c2gp3aGWhO+NTJRniXAquWyztaTIrVA/U9M/9s6XVEIUYEIvigqCExYJKdCDybvTegdS+++YTWxeszHluOUuu9/kpv61BHyag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tawoUVPiZfPUQGyTjWOWFQxioAD5sB/V3xbtQhP44uqNcYtIBGSMQTmS+VFZAi6wCUsF/nf37zHU7ne+ACAnyYi59igWm4CdaU8EHbMFYxiAsEPmR0fuEXyLWzRTNcumoys8+16KecXhv7zISSBJXihooKuOSI3Y87oaL4UmufFCMr485gfIpzFPp+58H2vsh+C6ANcbroOUZSPs+d9jkILkD7urQdesqR1+LRAkv6wH1m6muqbSq1qAymIcEj/rooD59uBh2QleazMeTe5R6aLRr1WfWmoOYXeCoMjYRIfyFxLFP6gSuIMhqDDt2F7EIz1ptsThRhzU8fR+sL3n7oVml8ko9tyn7GGBPKP6Tt7UFLg/ADo4PNsQ5tTRTHjM2hMlnWbL/L9SbLVHeQOv4MAN9zTnwGRSje1wr7Ew4aPya8id4LxOqv7GFd3xQujj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:36.8817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee39f019-59f4-454f-7b3a-08ded75d53b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303588-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:benjamin.cheatham@amd.com,m:Jonathan.Cameron@huawei.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,huawei.com,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808F36EC58C

From: Alejandro Lucero <alucerop@amd.com>

Use cxl_set_capacity() for DPA initialization as no mailbox is
available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://patch.msgid.link/20260630151346.31201-4-alejandro.lucero-palau@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 704b0ebae937..18b535b3ea40 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -68,6 +68,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
+		pci_err(pci_dev, "dpa capacity setup failed\n");
+		return -ENODEV;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


