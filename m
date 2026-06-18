Return-Path: <netdev+bounces-300508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 39R+DdQpNGpnQQYAu9opvQ
	(envelope-from <netdev+bounces-300508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1E6A1EBD
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:24:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=mWcrFe7V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300508-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300508-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E5853037437
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8652EAB6F;
	Thu, 18 Jun 2026 17:24:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC24D8CE;
	Thu, 18 Jun 2026 17:24:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803473; cv=fail; b=L+4Mf/IMkSovR3kMHhIEoKFA9TbCDUO12EDtEbBWnlokHsHYkF0ho99vbO3TGEiwcHhVQZ4yzjJcBkSM/cajzJASeL0F1hLvsSdqlf1UWFF9xziHwFdEiIQOsafQVcs3oy5/pRV6I69Z9pAHvE7Cmsz+050KrauNcH1P9rE/IvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803473; c=relaxed/simple;
	bh=+6CwJlBptDeXFGCldN3wkTwBHQVaO8U64/w9xyZVy7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqkHF17VCgAWDzruF5zGp+hkjGNAjMj/I47xQHG+zruvSUKxetp7kYC89b5dYpWJICLetkSBLpeRbB9cKPVzMP48Cpw/9LMpzEN1otYb7mFNwp4NqMEUwNbXkd12osef3dpM7pFtgarfPCogZgZjg/VZWmXMsGoC/vTcwUnlv8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mWcrFe7V; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh9FlxVgRwfoVVpeu6YwH95orFES61Afk+1iS14TTU97KroWMEmMEQk2rHrDyeMsHEY2mGr98OkSGSh+xHtA92QkxKG072ihltluK3Q7szlv8+pvWf2pmKBeJTcOvfd++srBaOgfbJDovF9Ji0V4JXHeXgTak/fewz35/6Yl1uNo2DA4fZHRGEy/V+JW3dL9NjxH2wG+V1bwBSZts8BDanDM1zW2eEMFi9DXKDoSYRq7Mfj5ymIcifnBEVD3obeKf1E0eIx5QAiKgk8zl20mQau2CnTZVQZiENTY/a/Nime3Uq6rgOS0x/nHlA2t5OwgnWwKlq6gcm3GZsJFUN1wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARRokEL9IP2EVu4sYSbmk3TC7pYOGiWnBDRZtGUJ9Uk=;
 b=LtLYk0vQSATCVqyIN12fVPu4VvFHHTPa18qRwviJj+41AcdqLGlq6RPRhClJYqhvTchHkLWhZ473ubLzZlOsx0JQGPMh7t+ydW2TEurry3+Zp5F12Y1tjdlEM3xhbpGOqQTYB9w05qRHjhXwvLh+qMkJMUhrtfm5xKdz0mlOTyV9bzlYLpsBH2R9TO1r1VEb0VcXgJeM6ChK1JRLsvFmgU/nF5NBapCJNf8IpdFVRwkLcuNJ2rPlOK3g8UJ0eH43yFmGdXSpWc0qSOQOEf9Xpwf9B9M/E2GuH2LFXWukc5ukKkonB0fcw8h1TCIib7dsW5+wNTGDxy3zG6Gte2rHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARRokEL9IP2EVu4sYSbmk3TC7pYOGiWnBDRZtGUJ9Uk=;
 b=mWcrFe7Vq9TYF9SwLpcjp4K9oc29eiSil92r8ziDyEIEx+RSMXX+2/j3UGUDEM2Gg0VxtwnAxsdbeyt9EsRZz/4TTdh6/3EncWELWpYvYEnEEWGcL7bd8wlh3tkX5AKOpjQp7YhglnJ3efTG2Y816KolodCeXl9PuuDiUgQFpeo=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Thu, 18 Jun
 2026 17:24:25 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8b) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 17:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 17:24:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 12:24:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 12:24:23 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Thu, 18 Jun 2026 12:24:22 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <djbw@kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v28 0/5] Type2 device basic support
Date: Thu, 18 Jun 2026 19:18:01 +0100
Message-ID: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e50c465-e56e-4594-3424-08decd5e71ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ROZoaU3/sw7Bl2svzulurbpNvdAfsEfEzd/KMfiX6sx9dt3BdhJp0Zhd5LqpooWjqBQTjtKKPh1jDbR4BSddWpzvBvi+wiP9raBke8WxpUU+x8F0JHgl/iQSQq7P6JgsoBtSoDEm9pd5aH4qee9LJAJXXlXJxKlixgyKOsPmnN+kjDGo69FYKi0U7C/ig8WBihneA6QbG9oUn2wWV2FUm8c+WMcyfp7d7Gqkp955lQFsgKH1LWueW0+0Z/MHIDx1IEUhuHK6eJUVEsfHYPXld745KrSAlX8fnxzOKC9vHnlNvysBpcDjYPFm03ZWdjTHiVgrlp2i/RcIasq/yARtN8p1/ysuySPJJE96wemH64eTGfIem6FJVGTlFlNStlGbzJBTPvDN4f0id0N15QWepNAgYcDFhVSjfKtkH9BDZ72PNweMjcPAwqNAyIxEYLtFSV7GwaE8adDUryA8OU0KV8bf18tr54uDsTWRP1sSNLKmWKrLhj6YkwD6XNoD+M6PXILMV84Y9pR1vRHWTMHjZxCOJxV5tOtl40IK41OLMvEDIj4fEOT35PKQN26uz4D1fW9bWI+RsccBRxjP+8w3eNXsSlvwF9qOrK8eNI8ZxLhdnHtJgWiV1TMAKOK3MoN76qx61vOfZTNv7RPYBWVops9rVFZIgCKmWfdXBbYSb72ns3w/Hpbv/ElX0XNXjOBD7V7GJo0QWakOw9NMiPQOHgGxg495/0e6KHq3YoLg4p4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DOBoIrsy5Q/82O2A3XiJ742NUOg1a943xuxJyFiG0IDhAZIn08gIy4fHC0f3J2yrlRlX06wZWg6zF/tz2wWzvutLIXYqbNlHuMvTOEUkNpAc3hE5/2FwyhND2Bw4iVTEp6E32vxjq6ZRwTFLX9KRwdJANFjUsv1/bnOZgVGBb7oUYpvl0grcZfsSxRPkKotrtW6lkD+uXICVSKBbzt2pLYyWqA6FmPSvx9RtVvvCusY/qk7spaTQnQ0c5INoTZ2Tn/2qChs9SfHQG0QwB98clCmUcvKteWdGisnCyroj15O0oQdN2g0tDi+bwpBVIoMYbwQqxbXlnqSAsCeOICqV/DFigSB7e4T5uBy/Zgk9j6FRTy4/dKml9r23soKhp3XZOu4t7EM2TvO4cVrEJf062I+Jvd3fqhj1sqxdSt0QF+2r+8NpEVdrkMzPQEpPZIn2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:24:24.9576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e50c465-e56e-4594-3424-08decd5e71ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300508-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81E1E6A1EBD

From: Alejandro Lucero <alucerop@amd.com>

This series adds the last bits for allowing a CXL Type2 driver to obtain
a CXL region linked to the device HDM decoders committed by the BIOS,
with the driver being the sfc network driver.

Changes from v27:

 - patch 1: make driver probe failing if error in efx_cxl_init (Dan)
 - patch 4: add unmapping if error after efx_cxl_init (Dave)
 - patch 4/5: move cxl_pio_initialised from patch 4 to patch 5 (Dave)

Tested in the cxl_for_7.3 branch.

Alejandro Lucero (5):
  sfc: add cxl support
  cxl/sfc: Map cxl regs
  cxl/sfc: Initialize dpa without a mailbox
  sfc: obtain and map cxl range using devm_cxl_probe_mem
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/mbox.c               |  51 +------------
 drivers/cxl/core/memdev.c             |  67 ++++++++++++++++
 drivers/cxl/core/pci.c                |   1 +
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/regs.c               |   1 +
 drivers/cxl/cxlpci.h                  |  12 ---
 drivers/cxl/pci.c                     |   1 +
 drivers/net/ethernet/sfc/Kconfig      |   9 +++
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  41 ++++++++--
 drivers/net/ethernet/sfc/efx.c        |  18 ++++-
 drivers/net/ethernet/sfc/efx.h        |   1 -
 drivers/net/ethernet/sfc/efx_cxl.c    | 105 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  32 ++++++++
 drivers/net/ethernet/sfc/net_driver.h |  10 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |   2 +
 include/cxl/pci.h                     |  22 ++++++
 19 files changed, 309 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
-- 
2.34.1


