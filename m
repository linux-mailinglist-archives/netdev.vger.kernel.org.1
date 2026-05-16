Return-Path: <netdev+bounces-288556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A3bBQXaB2oALwMAu9opvQ
	(envelope-from <netdev+bounces-288556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:44:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89F559ECA
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D953017BCD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A426D4E5;
	Sat, 16 May 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ncaOPrIH"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95581405C4F;
	Sat, 16 May 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899458; cv=fail; b=NJrE2Evvje9Jdp6goCfHv3ySWeHouReUPikYBm4Hbkk4i1vmWS/bWyNUA7GJbiHygnUrvRZozYCpOCXZ3lAtzH9aPMSZES+SpByAcQTfoxCXk0ZYHtchJYeJOzD/0pVAsyBhUyze3SqjkrYQ5GSpO+rfere1uq5OWhZfwoOGm9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899458; c=relaxed/simple;
	bh=YfhznT/ssusI1rWqgcPKVzT1cHCRcFxuJPJ7Hvl5BRI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 In-Reply-To:References:To:CC; b=i/o9VdWhsVrWzCbSgcKuF5PjdXoNJKBfxRUbIY3COOsA2em2/mthwZbfc5JsQT8ZkNGK+M4KfbMYSFJgB2uT3YPrepDti6nP2bSvhLfkxH71hQ/jG52ykzWDH4OXiWbTgoOO5fQZ9RzzNFW+MRg2/Hvn5iI2NOBtKmNplGyl2Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ncaOPrIH; arc=fail smtp.client-ip=40.107.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stEkeXWeazAbh9ZQOe4OrQO+1vrIS0QkpMqbLzkst54rrm+hK7IfzBphAaoj0lc0lFWd+FqhxUnXNY/6c1f0spcAHwLtRbf9mVXhrzdgenOiPkXn2cnkBP3StfLv8Lj9JXClPf0xB1sEjJ/byJx7aK1yyRSH7MUWt4UXRQdD5OsVnSj3De6LnrUhkupmK8AeJY97xJ98b2skrkRbDfyiIf7/N3TpMY2E4qabvM00a2QLm+GjVSVG8gYqq8RgSQTmuItx14bdNJY/qsM/RdqGLtne/G/DmKg/J3qN+fqkTD8zhnw6iVdi/PI8OdP3ymXE/BI1r+xDle67oKEPB7OKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMw7smjsMhaKSAuZkTfq+gVvexSDmMxQncIr99w8ZQs=;
 b=YkM4RuH2ZVCKVBWBXNIOJ8yQNvQIOR8M14y1Q/VZdphona2m2UlOwOgu/PuSlSs1QL5bXxqvyLX0yoNf8vNk9DFx7OrMpyQarCSLnBOy6UJtSCCTvW9Ct1C0BqLFXvwMs5DeVRmJ/eLEbHDOK9b+rhGK873rMmK+cYfyUgJmtNKYe4494Rnnp8w528rU/JEV2QCYYWptjFZen/04gV4D+U+tB8Fqe1/2yAJUfwdM0cu7kGjDRKtjiJWaIPqfF7z7iQL6W/Y1QslJLKZfL4RsIVuWoo+ABWASCJq6FgkmOa8SIykLSbmeA3W1iLZYM6VAC6a98iKq8m91N4Fv7xeRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMw7smjsMhaKSAuZkTfq+gVvexSDmMxQncIr99w8ZQs=;
 b=ncaOPrIH9EMNb48i3Rlg2Cgns5eWD/jvhs8BkUm36e20sD7fEG3m+s9TeW3EuKMP5oVy/SvlqGQZ2WfnWjvV26RURxrNZrzAXTLTHnqIvN+VW7B0f4wWWozyUNo9tbnO6t6WPgFzEuTeXHWDaJv3lrC2Ey65FkMedTC/5HoObyo=
Received: from BN9PR03CA0217.namprd03.prod.outlook.com (2603:10b6:408:f8::12)
 by DSWPR12MB999176.namprd12.prod.outlook.com (2603:10b6:8:36f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Sat, 16 May
 2026 02:44:12 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::42) by BN9PR03CA0217.outlook.office365.com
 (2603:10b6:408:f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Sat,
 16 May 2026 02:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 16 May 2026 02:44:12 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 21:44:11 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v2 0/6] PLDM Firmware Update Support for pds_core
Date: Sat, 16 May 2026 02:42:34 +0000
Message-ID: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJrZB2oC/yWNSw6DIBRFt2LeuDSKYmNH3UdjDJ9HpSloAImNc
 e9VOro5ub8NAnqDAe7FBh6TCWZyB9BLAXLk7oXEqIOBlrQtWdWSZQ7RI7dDooP8IHekrrVC5Iy
 JG4ejN3vUZs2bT3AYicM1Qv93wiLeKOM5eWZHE+Lkv/k+VbmRnxraEdGQ+aPsqakiJam7RnMtO
 KOtfnCrrnKy0O/7/gMnB8OdxQAAAA==
X-Change-ID: 20260516-upstream_v2_clean-33fdeea55b7a
In-Reply-To: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Vamsi Atluri
	<Vamsi.Atluri@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DSWPR12MB999176:EE_
X-MS-Office365-Filtering-Correlation-Id: 1056d80a-7bd5-4941-e448-08deb2f5032a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|3023799003|13003099007|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	/1qpXrGGbDAwVgwoW5BhGAPJ8jn6ZGQtfIyde7Gshw8ToExYfqAz4BCsNtQw8+jgAcmvp2yy+DMzwgeHj+BKnv92HFwh9sl4M8Fs53DDHefI0CASXZklbqWg61edriTVw4f0H2DyvbGlXgy8Kib7tqQ1VUt7FB+HNAVoMMA6ihUN2B8xlZiUodFh7r+r0V9VYT/ojuPeAp/25oq16pL5N4I6bWfUrV7hZOvZeWkmC0SfwsqKy2l7ClUSUSLsn83+3eh0qlWtPA3W+8Qx4adagsErTo899R0CLDgz/RSDlirlQDm8EwsWGKup/3c3j2PoGdK527t0XDN+SL2SbaiFP3WVu8eNHadMFYYiF4CwGoyOK8PkEDp9otjQ63UbhdSAXI0/iAtx31oaiVe5Ax916n4Rk2It/uB9LIom49+GLlGa07njPwkcskD7zK7dIbh5woCPjBk2ftn5J5JaLPwetE4c6vGNRwn9Xrhr0rcofaLcOrgofQe08Lu3xC/WLSNzM6/hwf80NbXWbr+anEagkLAY1E5VV6+fLxE9yWUXz/gDFanI4WlE+F2QX4Deh3ovjM7YRKCc0suJEpY3EfNNEQ5Hfh13RW9iVGZYg/kKkjETFtRcrDvOGcW80G0tuSxxyH0z2ht3dH43qB88MP5dutw/BdpZipzaDVesvkb77VAHFnguUfx9XB7wEF/EAGy6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(3023799003)(13003099007)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WymKxYybp1etD+qYoCNVeKuns4BWUmAH0ti0ItgcJRJC4jv/Fph5g4mCddVNlO1KDhnuddS+/wiBpiUVmJlDT4Rtt1+ulym/EdVog05Z8DWt5MQLPpgmy+tK2BY9lnpTTVdG9CzLZZXNlO6ETSdWIbKw+kwyT6NajGNKUwYFhyhiYk25sakvOZAtAe3tkGI1J17pls9qsh5UY/icAwhn1r+aNxBzYYyIb1yRI1ZpzH9gMGUvD8rEWBp9EVBjNKWRNFc5Scn+5kvh31Odm90umbZ+ugWQ9BgDsuSMu2XO3+z+OvZHBOFZ+X6I+FUNvvMgLByI/bF00Vvx+/4A+XYWBjRBP7Ptqd20626tZmdGsQikIXWTPUdVFsGTXBWRVYEix2C0OsKrK5rpDGsvqCvtGnKFcMovx183SEjqgcGwezNyGwpuyHXxbkc9fBOI92eG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 02:44:12.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1056d80a-7bd5-4941-e448-08deb2f5032a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999176
X-Rspamd-Queue-Id: 9B89F559ECA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288556-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This series adds PLDM-based firmware update support to the pds_core
driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
management that provides a vendor-neutral interface for firmware updates.

The implementation uses the kernel's pldmfw library for package parsing
and component matching. Users can update entire firmware packages or
individual components via devlink flash. Component information is
displayed via devlink info, showing firmware versions and update status
for each component.

The series also adds host backed memory support, allowing firmware to
request memory pages from the host for its operations.

Changes since v1:
- Removed redefinition of __counted_by kernel primitive (Jakub Kicinski)
- Fixed kdoc warnings in pds_core_if.h
- Fixed checkpatch warnings
- Fixed bugs identified by sashiko:
  Patch 2 (identity version 2):
  - Zero data region before firmware commands
  - Suppress expected error message during identify probe

  Patch 3 (PLDM firmware update):
  - Memory leak in pdsc_send_component_image() error path
  - Memory leak in pdsc_flash_component() error path
  - Missing devcmd_lock in pdsc_devcmd_finalize_update()
  - Fixed dma_mapping_error() return value handling (returns boolean, not error code)
  - Skip logic for components with index > 255

  Patch 4 (component info):
  - Added generic fw version display for all identity versions
  - Handle components with both RUNNING and STARTUP flags

  Patch 5 (host backed memory):
  - Race between pdsc_remove and health thread (use-after-free)
  - Set missing index field in MEM_QUERY command
  - Host memory allocation size and zeroing
  - Don't free host memory on MEM_ADD timeout (firmware may still be using it)

  Patch 6 (debugfs):
  - Fix dentry reference leak in debugfs_lookup (missing dput)

- Improvements:
  - Cache component info to avoid repeated firmware queries (patch 4)

Note: The following fix for an existing bug was submitted separately
via net:
- Timeout error overwritten with stale status:
  https://lore.kernel.org/netdev/20260515212907.998028-1-nikhil.rao@amd.com/

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

---
Brett Creeley (4):
      pds_core: add support for quiet devcmd failures
      pds_core: add support for identity version 2
      pds_core: add PLDM firmware update support via devlink flash
      pds_core: add PLDM component info display

Vamsi Atluri (2):
      pds_core: add host backed memory support for firmware
      pds_core: add debugfs support for host backed memory

 drivers/net/ethernet/amd/Kconfig            |   1 +
 drivers/net/ethernet/amd/pds_core/core.c    | 167 +++++++
 drivers/net/ethernet/amd/pds_core/core.h    |  33 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c |  50 ++
 drivers/net/ethernet/amd/pds_core/dev.c     |  94 +++-
 drivers/net/ethernet/amd/pds_core/devlink.c |  90 +++-
 drivers/net/ethernet/amd/pds_core/fw.c      | 727 +++++++++++++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c    |   7 +-
 include/linux/pds/pds_adminq.h              | 132 +++++
 include/linux/pds/pds_core_if.h             | 379 +++++++++++++++
 10 files changed, 1660 insertions(+), 20 deletions(-)
---
base-commit: 543bdc1578cd380631558a884318551a0e9fdab2
change-id: 20260516-upstream_v2_clean-33fdeea55b7a

Best regards,
--  
Nikhil P. Rao <nikhil.rao@amd.com>


