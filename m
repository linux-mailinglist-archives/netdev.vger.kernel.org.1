Return-Path: <netdev+bounces-305993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ex3+AR7ATmrQTQIAu9opvQ
	(envelope-from <netdev+bounces-305993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:24:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2C072A82A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:24:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=AikSYYH1;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305993-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305993-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34163039809
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357B3CF047;
	Wed,  8 Jul 2026 21:23:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56593BED79
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:23:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545800; cv=fail; b=E85t5sD6NcVgtDSyJfCovO1MkV2dGHb3NiJ4bennCVkpGY4+EtNgfJqGVTwqjwdbEGrt4wRJo36yqC7d0lWclnEt5pK837LcALytoyTHfuGXrU5j6kmtsIAZsWdLykdElYNmF/qcpFqitj5GlESKWu+fQWYtFA4r0ZT9HANMOjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545800; c=relaxed/simple;
	bh=7GLGb5/wu6SLTt+SnmdrPTSWHQILW2GBSqnMai7xmxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uilpcu/sMoWMlgCHQFXoSigNjWSz8WFYOCxN7idoMftscSxMD88EpbnqUhtBcw3hkBP5SEfh++FaftjJ/vt3pTe3lO3cJE4PQMW/RHbv5e9vimgIqixy/qng1//fp4m9Mdr2VO45RMehXARp6sMbXUh7CCippck/Dpl/OCXEyF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AikSYYH1; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCnROFfhOj9DVqjtvKrCDz94ALwzM0kTEP8jo2VAqiDH/u6lF3jRlTNrQobN5AMoa3QhV89Fz+VUW+MoWi9e/PfyLKIRxPZJtdqRKmw10GbKUd4VufmIVY/ldWzLs2fBVONnYuqz1IXJP15PW+fpz0sY3gODS7Vj4AvRFpPT7AvGowL7qvL7TGkiiURvyfx4Cl/EsOOpx1wznahqxk3hev87+XWd69pjcsK5bJEA4DyguRNkwp+z+oRl2A75HxIdpuNQkCEFWghc06n5zmOz7W3hwjoF38GMMbnaOqsP0r0717YVlsKgG9w5UzWfjFiVSs8HwjTjk2ExdhQ6rN05FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEJsLO+XFF85Y9qtO9nRBBmEynPd0G11eLYO32U80QU=;
 b=fszAnz0qVl4EorvJwX4iHmTRbwmuUHHU2pWMMJjaGbxy7DPv+RA/Uo8rM3H9HpPtfM5/CTclrnIN7N4RzVUHv8LE4TRVlZd0eZA9WF/kWLicb4fLCebUH2IJlgPJw9yuFnVT45BVXo1fWH2ifIZjJmhK4l0T86SEDE9uaGftN+U5M+7ehNAa+SbYWu5aVshr/EdPY+DQI8mS912gvtW5f1dZlBOV8aDVy6l6xRaNpQphIXTe6x98N5SY6IRb7xk+xbTzdNpt6vXoD1tAOWARmvCCPZZePr/qQJ5z9veITgwB2xS9uA/O8RqMOqlZG2XQQtGLzcbHrBC7RBNdEpz5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEJsLO+XFF85Y9qtO9nRBBmEynPd0G11eLYO32U80QU=;
 b=AikSYYH1M/mP7EWSdCg1t6SHb0NGjia8Qi3IFENkRIGXRqwuJgMLLX5ZQ2CwlXBtfUntjY8JtwPKS2wq5EIkJeaNcWlpFO6uOASvDyPxzgoy5vVFfYxNkRTFGOYgVidERSTda4E664lWtSj7wjNVOQS8nc+1/jzw8XAVZ5M5QS8=
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by CY1PR12MB9581.namprd12.prod.outlook.com (2603:10b6:930:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 21:23:14 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::a8) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 21:23:14 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 16:23:12 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net-next v7 0/6] pds_core: Add PLDM firmware update and host backed memory support
Date: Wed, 8 Jul 2026 21:22:16 +0000
Message-ID: <20260708212222.296202-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY1PR12MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b14e51-e118-4e15-5c65-08dedd371ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|56012099006|11063799006|6133799003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	6QMj87b9E4P29Alz00PmUS4xjACUFEO42lNu0NNdbofFmZoAyLEgnujqGKVTN5Jgkk3mY8ICSrQINABckBqMjJ7UUl0JSEXBP7aSFperR2IxyzY/x4VaPkNuK7IhwYBJtWOoCrWKGfqA49V/0fhmBGOVRiHzoTJDC2/7DClhwvwFCquRTWC7Q+BmIe8OzW/cToxFLD3ETV1k8CyoIOrFBSRjx94bHrVTNs4wGo9tabjWuP/gVGej4LimhcWoG0i7paP4/f/uKnzpMPe8bIANlTc1+ts1qlNEdrW6d6ZcrAb1JkcGkBHpvVhW4l001usEUbRo4vlioW47/c3EHJoofPiMZ2THj0ABQu7vx+EPfQKxAxvChorRCMT7YG4wnzmTiI79E/F5cDzqWEwiYG3RcjSrHYHrVbFxRTsK1HyV/C+nhc/IZ1rAPSMCf31FuoPwndzbSrN9QOm7mqOjN0GcmLnIjcj7K6OGkRnA+Qcm+SucnZ+XPNnt746xiBpvFoZ2IQ+Ew2hslTvt4RR9U3O/2fZFjPOcX2o1ArZ4nFglWUzqztUU7VmiToVYB1raNRdJhOChg/VhWCoMTlqfPCSeHd3cUrHRu7DAEYAOOH/zpsFACBSGwm4iNf8R59fn3tIauz61OfktDs1QEMo5JI5nx86btIEp8VSQyAMmeWW7BwB6bSMvOQGJZyH+0hK5ePzFWD5tgPpjsUGtpBw/zU2Xcw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Ap/5imP0jQFJam3O0TFmXcNzgBt2kxm2cPv+LNP4XlFGi7MN/3j80WjjX3M6HSCNirBBOk+y6sCoi4Fy8nzvujxS/kCg8pjK4pE4gevTOsGurxDt17+gVEhGPCgdI+MN3MXkjjqqeoEoUDu7QDh9MNDXJ5K0EoATc7jHq/1M1peal0zfrHiIwqwXtEj5yMEnd1ge6c9MMPgWfUrxRPmnhODT+2kuKSFbDrRrS0eupiI6W/vtNxB5m69SHnYaJHJ2+Q53nCDRVx+bFUm96i5YbCebrwtJJIEat1OnTFVWqNb4I1bAyVGb4IhidOS3cn7R1dihqaF4PxIXtqS+YdXeA4mYoDoFjYFzEImc3JzmWnkwKQWyB0XO7YRGpWuOjRZYuWb1LbGyE16vptcgvH6T77W47fc3xs7sc7XAuCbSw2W39jCDDVq9AfLUY8hQcl2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:23:14.1501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b14e51-e118-4e15-5c65-08dedd371ebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9581
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305993-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C2C072A82A

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

Changes since v6:
- Patch 3 (PLDM firmware update):
  - Add config space read after pci_clear_master() in teardown to ensure
    in-flight DMA has completed before freeing deferred buffers
  - Use list_splice_init() to detach deferred DMA list under lock, then
    iterate and free without holding the lock
  - Add NL_SET_ERR_MSG_MOD calls to PLDM error paths for better error
    reporting via netlink extack
  - Use PDSC_FW_COMPONENT_FULL_NAME_BUFLEN macro instead of ad-hoc buffer
    size in pdsc_flash_component()
  - Simplify finalize_update loop condition to `if (err != -EAGAIN)`
  - Reject devlink flash with component parameter when firmware doesn't
    support PLDM (returns -EOPNOTSUPP). This depends on a fix submitted
    via net: https://lore.kernel.org/netdev/20260708163649.128620-1-nikhil.rao@amd.com
  - Update documentation clarifying fw.gold is not a flash target
- Patch 4 (component info):
  - Use READ_ONCE/WRITE_ONCE pairing for num_components to get a consistent
    snapshot; avoids iterating zero times with no fallback when recovery
    path invalidates the cache concurrently

Changes since v5:
- Patch 3: Changed "fw.suc.mainfw" to "fw.suc" for System Unit Controller
  firmware to be consistent with the "fw.mainfw" to "fw" change in v4
- Fixed bugs identified by sashiko:
  Patch 3 (PLDM firmware update):
  - Remove stray kdoc fragment in pds_core_send_component_op enum

  Patch 4 (component info):
  - Fix fallback to dev_info.fw_version when pdsc_get_component_info()
    succeeds but returns zero components

  Patch 5 (host backed memory):
  - Expand PDSC_HOST_MEM_MAX_CONTIG comment to clarify why PAGE_SIZE <<
    MAX_PAGE_ORDER is not used

Changes since v4 (sashiko review, Simon Horman):
- Invalidate cached component info in recovery path to ensure stale
  versions are not reported after firmware changes
- Fix v1 error handling: propagate errors from pdsc_dl_fw_list_info_get()
  instead of masking them
- Fix v2 error handling: fall back to dev_info.fw_version only when
  pdsc_get_component_info() fails; propagate devlink errors so partial
  replies are discarded
- Clean up max_fw_slots comment to clarify it contains component count

Changes since v3:
- Changed "fw.mainfw" to just "fw" for main firmware (Jakub Kicinski).
  Gold slot main firmware is reported as "fw.gold".
- Removed redundant memset before alloc_pages (Paolo Abeni)
- Changed dev_err to dev_warn for alloc_pages failure (Paolo Abeni)
- Only report dev_info.fw_version for identity version 1 (version 2+
  reports firmware via PLDM component info)
- Fixed checkpatch alignment issue by extracting pdsc_dl_info_get_v1()
  helper function

Changes since v2:
- Use driver-defined component names instead of passing through firmware
  names (Jakub Kicinski). Added component_type enum that firmware populates,
  driver maps to stable names like fw, fw.gold, fw.bootloader.
  Added documentation of firmware version names to pds_core.rst.
- Fixed bugs identified by sashiko:
  Patch 2 (identity version 2):
  - Fix comment using wrong macro names (IDENTIFY vs IDENTITY)

  Patch 3 (PLDM firmware update):
  - DMA-after-free on EAGAIN/ETIMEDOUT: when a command times out or
    returns busy, firmware may still be accessing the DMA buffer; defer
    freeing until a subsequent command succeeds
  - Use dev_warn_once for incompatible firmware version (ver==0)
  - Clear component cache after flash to show updated versions

  Patch 4 (component info):
  - Fix min_t(u8) truncation of max_fw_slots (u16) to min_t(u16)
  - Fix F_FIXED early return skipping F_RUNNING flag check
  - Don't fail devlink info if component query fails; use dev_warn_once
    and continue to report generic fields (fw, asic.id, serial_number)

  Patch 5 (host backed memory):
  - Switch from adminq to devcmd; fixes both workqueue self-deadlock
    during recovery (adminq completion runs on same wq as health_thread)
    and health_work re-queued after cancel (adminq timeout re-queues work)
  - Remove MEM_DEL from teardown path; fixes both MEM_DEL sent twice
    for same tag and num_host_mem_reqs ambiguous semantics (now only
    tracks pages to free). pci_clear_master guarantees DMA quiescence.
  - Fix PDSC_HOST_MEM_MAX_CONTIG to 4MB constant (was arch-dependent)
  - Not fixed: pdsc_host_mem_add() failure ignored; partial host memory
    is acceptable and firmware handles fewer regions than requested

  Patch 6 (debugfs):
  - Move pdsc_debugfs_del_host_mem() before pdsc_host_mem_free() to
    fix use-after-free race with debugfs readers
  - Use %u for unsigned types and %pad for dma_addr_t
  - Remove "file exists" check (now dead code since teardown removes file)

Note: The following fix was submitted separately via net:
- DMA in flight during teardown (call pci_clear_master before freeing
  host memory):
  https://lore.kernel.org/all/20260604213637.3844317-1-nikhil.rao@amd.com/

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

Link to v6: https://lore.kernel.org/netdev/20260623-upstream_v6-v6-0-3bb64e0dc4f3@amd.com/

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Brett Creeley (4):
  pds_core: add support for quiet devcmd failures
  pds_core: add support for identity version 2
  pds_core: add PLDM firmware update support via devlink flash
  pds_core: add PLDM component info display

Nikhil P. Rao (2):
  pds_core: add host backed memory support for firmware
  pds_core: add debugfs support for host backed memory

 .../device_drivers/ethernet/amd/pds_core.rst  |  89 ++
 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/pds_core/core.c      | 173 ++++
 drivers/net/ethernet/amd/pds_core/core.h      |  54 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c   |  45 +
 drivers/net/ethernet/amd/pds_core/dev.c       | 140 +++-
 drivers/net/ethernet/amd/pds_core/devlink.c   | 147 +++-
 drivers/net/ethernet/amd/pds_core/fw.c        | 789 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c      |   9 +-
 include/linux/pds/pds_core_if.h               | 469 +++++++++++
 10 files changed, 1893 insertions(+), 23 deletions(-)

--
2.43.0


