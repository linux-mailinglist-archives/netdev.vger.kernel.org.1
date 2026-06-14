Return-Path: <netdev+bounces-299141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T4bdHqY1LmoRqwQAu9opvQ
	(envelope-from <netdev+bounces-299141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:01:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C12796805EF
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:01:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=WLvp2wmL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299141-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299141-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1B8300BC95
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4953090C5;
	Sun, 14 Jun 2026 05:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A430594F
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:01:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781413283; cv=fail; b=mHI6Hnqdp33KCfJ1wyAR1WQuJ392CteAFK0Oq87oG/4nUJHW9R1OqRGpvDZOlZAww0E4Aep43jOi+gGBIU2QMhlMU73sJPVJjhlfRwvCclumoB4Hc6ws0lB6JAeQKzhUdDWrcWI+rmcoM5yARQPtCjjqGDimCbEzQh/IZOo1SRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781413283; c=relaxed/simple;
	bh=uFUrIhybx719C9KIpiaPJwdhSm15WEo0kstC3WS4Q68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gu5XS/YF5xm/B8LZ3QC+LBGl2gaeatgvzQOWC0mMgqL+cpIJ2Ol2K54AvlY3whb2Us14osLXr320KOroJ8hTpTbFFKAGsd1EXmu0tNvHzUSfYNmUQBfhZzdWT2o08EWHV9dXB3k9nloTeXb3aIYJHGxw/j/83YyAWYV1nl0WCnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WLvp2wmL; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upg9NCWbZ/j5BMg1ZzYLm3k9BkrNlGnN6lmbwTA+ZKZW/Fk+5YN7o59PFKVBAobqycGD0NBl0P1ybnEC2LGKBwbgeu0hzBxyIAWm5ryRcv/fcFDB62/4PBiEVDRth3fck17ibb6MdFlgnYamEu0elMbSLJXI5b3gYdYQWweOQnv8N0zE1vBCebfW6OTYQzHrAyzhE+ciXR4Gnbeh4YpImAf7JhFNXrIXpAabBq/V/wZL+Fl/3fFTXpAqIZWNG1yy69T4ckiWmV93WXIbxVVgR6Lc4Av+QTRaDitdETLmDUveQCRpS/ZpHrdXU79aWPoPYPBaEnrylgW0xg8It1ocww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXtylM/Mlxutqa8hbordN0cIPkK/EenKqsNc73zMbUs=;
 b=uGFdKuk8Do8xJxC1JkSakGqJoiLJDYPM6PROPMYO6ElYokYhsl5y1Yl1RqsUcS76f+Ciu/RZa5n4RBbcpfgYH5ziiW/ZkefzVQtMMo1IpKoLEOaDf/TCUvEmqoLXk+Tri79ktOD9SZnvFlsPGKenJ96gp8UcUXV15ZXpfqVvmM0e2rbaZq8OvFBoLDma1kv+lLw8cu4VScHB5BEwK2CZsEol532wxmezY+SDCStstL5gWjtkmFpUjN1x0lASp6Mhl47ifLQKcGGpgrpCLepkSmmuOV/JC2cLqdUkx5Lt28/pJrdnn180NMWXS840uKlEXsLSPlPPZMjhBQgv/fdUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXtylM/Mlxutqa8hbordN0cIPkK/EenKqsNc73zMbUs=;
 b=WLvp2wmLNXkWVZLWxynYC7IA4g0bDVoZAIST/yaiHuwFBaHAhOGAOFNlp0w5QN7lQDVQ650VLeuqlOgSa+SimmB8oKxcnBVrU3xhKbOKEqVABll73BH4iBW3CnZf0FjDlhEdag0WXo/PBaFrM4D02Y0itIzZeP/NwZvhIB8x3V8=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.16; Sun, 14 Jun 2026 05:01:12 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::41) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.10 via Frontend Transport; Sun,
 14 Jun 2026 05:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 05:01:12 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 00:01:11 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net-next v4 0/6] pds_core: Add PLDM firmware update and host backed memory support
Date: Sun, 14 Jun 2026 05:00:46 +0000
Message-ID: <20260614050052.1048328-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bf05fd-f1da-4306-de02-08dec9d1f4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|13003099007|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	7VQtEkmlMligrTfityaV37cI1HCI1gzSwycoSSDW4a1TH3+BOrN3QXJZDURWrtkDRTsTdtg9zxGKfKwkmfALpX9TIac899MveDsl8qQYFQHFAiwO2QmtsP/B03UnQfSB5ngnZUQQIAcEgGozRz/ElFubXQ4ejKTc15n4p8oiA12h155C6/gb6/L8WWvtrKQU2J6t2owEsitsl5ho/HCrjdkjokYFsso0vfMhoCvb8s0VtXiu4BJLTzV/eIxemPyvn68V1rKLdO4TNmC6xMeX7TYrCs2lJt19BLmO3dzrOqCKdUnk7nf8drljTD/pqNzmpB8WiwOpiSZ8rQbdFizTzdvbZSD6rKtnYtIdK2Y1WgrnlgIX+vmmOh/AwyOFLQYoQNYjjenL1RIaqVtlKZd5NnGzd7Od/nq7LZpireLYE1vNQGGEDJ9+SDytChTAVdwR3sw+q+eFIOHj2Y4PPZZwuPNmzQ1H5TbRj2CjVNCnCAQrPg5UGqLeP9efJtsiwjNoAMLOcAb8EXBFnio3D8H+usLVCSBEImM6e8q9SZq3xWIYX4yIMDOoiFeGQEZ11NiBVYZESbvqOJECwhVH5hoKfzeb5VjDOP+Ze9Lpt9y3HPlXQ4I8Ed2LCLFxUnzOxv0fT3yWBHCjMqE8RBWJelFD5+LTAhmG6Ld62SwAxkixjNt9RPAj8q2blbZrygMIjUnQSh1ZnEganVNxGo5VpLRQCKYjghmJZ7u713zSvdHe058=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(13003099007)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PnTALVsn02+H+RgSVDDOMdHWtxRNPffaHuLl40cSHbTjf+sAhpnZKBPelUijA2OY9DSxEOkbIExC8P28p716JAcLEFpDt7XkDlohbpbHfEfWpTZu2FnmlniLNv6S4M7iSG+1had5gLb5YRKVfRZ8/BW9ZX2u10ZFT4p2NXdH6aXdrEyiv0kCv0ZV1yvz5X+qmM+Vlk+OPi0WKOfrBRtaewWh602Kz6x2cPHQg67BkTH8SteL29lluD8uv4p4llUIa0mgjMvkK9ljEtQ9UwIJcp+4VMtrB7iBENmPKRvrMDO1f1X8Kc/SgbfqS8AUKTOacAGo0hjl3xoykIeeoUECktfPdbleowcRrj+jkLuaxTwUdQCGqSnA9O8fl5DtSzTqnT7GYzxOGmNj5Cr16OBELxWxIJikLuYjM/mevp5h3zVfJnPCvKbh/GjHVeubbDah
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 05:01:12.4598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf05fd-f1da-4306-de02-08dec9d1f4ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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
	TAGGED_FROM(0.00)[bounces-299141-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C12796805EF

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
  driver maps to stable names like fw.mainfw, fw.goldfw, fw.bootloader.
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

Link to v3: https://lore.kernel.org/netdev/20260608-upstream_v3_clean-v3-0-7b077cd5f334@amd.com/

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Brett Creeley (4):
  pds_core: add support for quiet devcmd failures
  pds_core: add support for identity version 2
  pds_core: add PLDM firmware update support via devlink flash
  pds_core: add PLDM component info display

Vamsi Atluri (2):
  pds_core: add host backed memory support for firmware
  pds_core: add debugfs support for host backed memory

 .../device_drivers/ethernet/amd/pds_core.rst  |  84 ++
 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/pds_core/core.c      | 162 ++++
 drivers/net/ethernet/amd/pds_core/core.h      |  51 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c   |  45 +
 drivers/net/ethernet/amd/pds_core/dev.c       | 136 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c   | 134 ++-
 drivers/net/ethernet/amd/pds_core/fw.c        | 775 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c      |  11 +-
 include/linux/pds/pds_core_if.h               | 470 +++++++++++
 10 files changed, 1849 insertions(+), 20 deletions(-)


base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
--
2.43.0


