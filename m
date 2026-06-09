Return-Path: <netdev+bounces-297284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9kDWCVWBKGpVFgMAu9opvQ
	(envelope-from <netdev+bounces-297284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:10:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7314D664347
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:10:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="HRJpYl/n";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297284-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297284-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04684301F1BA
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272843DFC99;
	Tue,  9 Jun 2026 21:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728493DEAFC;
	Tue,  9 Jun 2026 21:06:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039191; cv=fail; b=SA7S2gHAsuBll1jLAuIBE9EIAxu0pUYK3Coux2EOb+R/u+56H2wckMQR65N68pTFYFDwG+OvvDQxthPDtXYLaWKYFaoJGuL6p8LXpks/M9GxUyOoZuMHde24GMeOMSoI8DyBRnivQUhaFj/S/UeTfI/XBL78swRrCgazCqOmIxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039191; c=relaxed/simple;
	bh=SpIPfbEcWULWlkwG9dkpSu+PzcXA+36vf+h+lPauTj8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBiOcZh+sFV8o0PqmQGzmsUcQZJzasrXBTHqVkYTanJS93v7F3p6TWHFD9q5QAjv0V4JzflBrSuIzQbRowrcpA0ITMQPd4ltMoIsBA+CAz8jlcPpI9NFfDbELo4kCbWSBgHp4rZVQRSfbrJ1LlosIRHNPuQhtsDiw5FZ9PZ0E7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HRJpYl/n; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q62N7Y9PkQkggt0ktpjpg/b+iaD8/fVGCkOG6qNT3+tfXXZruE1Al1S1j+to64U9M6ZesIFW8vY6iE5fjQw0CaHOZ0+WJELrS3WyKrTLNgbKa0HFGcQr8BN+BuhttTn5H3zFHpvTdKt0G3zNR/5e5aGpFx2otZPuqK/ZaGN1+9Ey2c2/7+G4txKurZ3n6QOAYT0DxpNa13ScYTQ9HWLlGJupxP9oIOjuR//WN4HLxF52YP9hkEUY79DtL5WP6sMxqeQLVRdgxII0VqmuTN4H7N7OiVUXN2ISOjJVrN77ZaY/XKDcw5hwsjixYNamISt81zgVytyloSchmaf1j30VNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLPD2UXoJIUXc9MzaTf82sWsh9+J32jeJN4Crei3W9U=;
 b=gQdpx0Mh06os4sIJpWmKmiasDQhqqpAXnixT6c91CGrJ0HL/vpu2xyME7QeC3o8nfMumM8YBv9FzM63EtPeM5qlpYXi6jAGtheJK35zIJEyeXmP+a0JLpo6EEPIb9shpj8BndtLh1Ph62+UwzEcZQ9KqU2vwUuFlmEEIYrOAT0MP4tQVv5DhWch7NOkI/JHybqDNwVFOVDrb8Wizep6y6EOQm19Y/2N3InLpN3s2QXkvXH/zvxBiDgSib8XDc5nNPqxeJqdhkCTC90czzoy4l6/Lh4VuvaFUvoq13SuK3VW3PUgUttUx3ji2dKr4JVyq64foMt6XVEJ3533nlz1XzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLPD2UXoJIUXc9MzaTf82sWsh9+J32jeJN4Crei3W9U=;
 b=HRJpYl/nkztm6c9QRzMfvovbppS3Z5pjO0G6WyRJYFsTKY7OsPayhw7I1ANtVwUqAhalWOCSZzOU4HbrAbF7BhP16+sk6NXZb67BB/eMUKHaF0uyRQsGbmUZUass1L1YyQ3wrxA+4Hi5mkGEuD8uHpbnyk4ywEdQrKleWtffziE=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 21:06:24 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::4a) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 21:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 21:06:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 16:06:24 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 9 Jun 2026 16:06:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <djbw@kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v27 0/5] Type2 device basic support
Date: Tue, 9 Jun 2026 22:57:50 +0100
Message-ID: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 634c219a-0dbf-4dec-72ce-08dec66af6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	u3lZBxhxWvDWI+O+tFJEjg0qFxmuXjRhfFeSGmRAWdPqCLiz9aIgU6rc1P2tFMLC+cnPd2EyK9DC4dTfLAgQGeBHbhTFp7hyVQ53mKOq1xCmKx4bb3E2h1/Ugm7xKPWRit5TORUo8S+DMGKGdxAYllmZq3bpZJ/yd3iN1Xg3Uo1FsuPtgBQIATsBHe5Zxg4+gT/WHQWmbjbNatMqeoVLbgm9jHUHzlK3sF/x55vAuniDUCad1Q/5Hx2v1bTLixrAVzSVyGRCHyZoZIK6QAjRZAe/HNPDJiSoJJdGrnZwVO0CBaurU6by/9wcBYSpWbTncqxS1fZoz1elrKQP13t2n3Gw/cGhtsPdhnfdBTZWjYL0jxtaFFKn1HB5qSgEvE//zuQvqoiu6OPZivAaPOnhPKCYZIWjCpoieVM5ZRUGHZgFgMGbR5n/WdYnD4MX80uvcC8m9BxbyG+l0kUmIribkPEQ3dGJcY4JWcPrPrwoIbChQz/iuf3n/5FyQIsEKeBwwpnwZLR6BEJ4N/x4IwdWUqZgKW9SCcRlvyu2fX+K6oizA+7+4etsoe9Ue7zDOJVTp2P0WltOIsmc22IfFJ2cFCv6VVyFZ5wY6tcDmU8YFvLj37PdkqqGNo8/gmEKWnF/v9xbm7NuWv5IFjyf6GL+MQpWwA6XehQWX0HiL2++XDjOkmBDEH0AlytVkwBH6CWOIBwwG1KFgr3MuaqW4jKaeJCJErY3/J8T3LhiQJuS1Zs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F8lECafpPVT+/obh66GYkyJXS4+f5dGNGZijKjG+BJDq/rP0qHRF4huPOpclQ82k5DcSTYB0qHS/nd8tBBpdmdJUxLNVBGFVsby/ukQEOdx8hdSdGrVGEEPkfM6pKOJrMxSMIAmp4GzH/7ofpnWUR1/OS5E4NDmL1NFrrASaIgdAqWsaYwc+O+01Q2dOof0t7fC+FktutBVecyJY+gucBcvDpJtvyo5VWWR1b0YqwU2HPmdDZ+JzerRGepXZCms/NobIuCQWBd4gh8Q1R45tjFWVuup5KmxRwV9iumYBd1G2//HwYoTJVv8kqmrKVy5ov+z2qqYepnfdxJip16e96G4mlxyG7o6a+nDZpypMxhVJeeXQXychJbmb6bOZGES4nTTLdY6eycaOdsMHQ7Qd/NXJnlWL4agQVP3/ymYoVmT2B36NGzW0N3PyxG+WP+hu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 21:06:24.4437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634c219a-0dbf-4dec-72ce-08dec66af6fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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
	TAGGED_FROM(0.00)[bounces-297284-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7314D664347

From: Alejandro Lucero <alucerop@amd.com>

This version is likely matching better the series tittle than previous
ones as:

 - this is only supporting a Type2 with an HDM committed by
   BIOS/firmware.

 - No region creation except autodiscovery.

 - No interleaving support.

 - adding sfc support with the last bits in patch 2 and 3 for the kind
   of type2 the kernel will support by now.

The series is therefore simpler than previous tries and even simpler
after using Dan's patchset for solving the cxl devmen probe problem
racing with potential user space actions.

It is patch 4 the one bringing the main change, so the one to focus on
for reviewing, but after Dan's work, it is quite trivial and removing a
lot of complexity coming with previous versions. Of course, that means
that other Dan's series requires more eyes on it.

I hope this is if not the final version, one really close to that ...

Alejandro Lucero (5):
  sfc: add cxl support
  cxl/sfc: Map cxl regs
  cxl/sfc: Initialize dpa without a mailbox
  sfc: obtain and map cxl range using devm_cxl_probe_mem
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/mbox.c               |  51 +-----------
 drivers/cxl/core/memdev.c             |  67 ++++++++++++++++
 drivers/cxl/core/pci.c                |   1 +
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/regs.c               |   1 +
 drivers/cxl/cxlpci.h                  |  12 ---
 drivers/cxl/pci.c                     |   1 +
 drivers/net/ethernet/sfc/Kconfig      |   9 +++
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  43 +++++++++--
 drivers/net/ethernet/sfc/efx.c        |  15 +++-
 drivers/net/ethernet/sfc/efx.h        |   1 -
 drivers/net/ethernet/sfc/efx_cxl.c    | 107 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  32 ++++++++
 drivers/net/ethernet/sfc/net_driver.h |  12 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |   2 +
 include/cxl/pci.h                     |  22 ++++++
 19 files changed, 312 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
-- 
2.34.1


