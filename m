Return-Path: <netdev+bounces-303583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6uQPOovvRGpK3goAu9opvQ
	(envelope-from <netdev+bounces-303583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F54C6EC519
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:44:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=AMN9U1DF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303583-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303583-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3C603005799
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5F14192F2;
	Wed,  1 Jul 2026 10:41:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D952413D9C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902498; cv=fail; b=apz3WWGH8ReqFSgo+3H29gbx3olpXseRsCgUDP8PW3oD8RlEW6G2vWaeeeEltapus9o4XxCTeG02C6RjI3ZK+hTBGPY8DIaFzY1ah7g4ZU5vGQiQp/IRyHQF2rWQOYZ8+PDORiRXWg31mDZl+CX3gNj7Vgha9qAsksjvYo4Qy6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902498; c=relaxed/simple;
	bh=Rn4du4+t/+4Dn8aRWovzN69qTRj0JL2HlbdXHcXUyC8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PjXJb9zW/1AgKWWdn1KFrhD8CHCipzXLXkLkOzbR727EHvjl0d9Hu3IeiN1Pk1+MqfjPO54Uh2iQNHHwF4a9gor1NIN3Vjdc10w+EJt/qjilnaxajtyZkQ4BJDSTOEL/9GYRBQwgnkF+qcuJsxpO4hzK3v7/8+yTAlrvwoyvs3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AMN9U1DF; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0tNSMIEItbwL+L5EZUblXI0grcZWtOh+AF9AUixZg0dwJuktlz83nARZcSBP5gZGMDL2YcVhG9alAVxDM37k747mRu6DffbzZYfsM5HEo99Qdrh2LVeHcXgKZJfh5WKQLHcOV/03Z7TuwzsrYbErg883jyqhUrst2i5osXZ1wmJG9itQtXwqoMBd4pAYyDPTNijl8Qxd0GXL/SXvsI3mIJZiqyTnKNqUsH9SUFB0C/Zy8rvxPDoPUF8xFdNXyIPrYB7GWa7uzrjaWjAfaugCQcnIDe6Ln4UWEfpGqRwkeVknqhSR63Uq/I+cXz0XxUYHmrCYm5mZgpb0KhhduO9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8nddcQaFZToWb4S1W15Ih7zdKlmSk0PZbQLlPYg5Ak=;
 b=k1o1tg3do1jc1T0HyzltF1yL5v0g8n2ard9EviY+7rMl7+GvyXRcL0lOGk+6c0UlwL5HY+sYgX28YKALJ95oFT+giZV6mNMJs4E3v3C1NczUiYHZiCgUmiPrkCy14JSDoy1ekuuOeK86MSAJ3s87AVFYk7RssZLRqAFE2eCE7QDGTFivtwVB3miAAV7Oh8DDW41aqeRpm3a9lslT5Wp59Harr6WGLEANdEshU4DNRq+wzfkIsUKVrRLrizeVeYVBWCb9oSw1Uov7BFGOl2hiuoyfMrDsdZGkQV+L7lsNEW/pbPm0x6eP/dvQPPxzrb4VnN8sUGUDaMaV7gsGSRp+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8nddcQaFZToWb4S1W15Ih7zdKlmSk0PZbQLlPYg5Ak=;
 b=AMN9U1DF0Kj7VrQK/HOIpnTdJQgf7pWFLHXGGR5Xu2/APfijH3/UBMEebgwmG9YlO3M6vJx0ZBR2IBWk/k5pXaIPZ8ejtTaOfV4HVTCju0MYjfFbikvd9UiZgmR5GFjnFwojrWbtcP+A4DLYtL8ugGAsbA3eoS/Cji+LOZAF99U=
Received: from SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:41:29 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::a0) by SA9PR13CA0127.outlook.office365.com
 (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 10:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:28 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:27 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH net 0/7] pull request: sfc 2026-07-01
Date: Wed, 1 Jul 2026 12:37:58 +0100
Message-ID: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f559b2-7b66-4f69-3a90-08ded75d4edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|11063799006|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	Fi80SbUzqqf7rdRlrmkqx4Y1Qa/08ghXIpMYszBdWvUwCQA5lB8jVD9r+QVkdC/ci9VVT+iVS8SCslrIMMdeJ5h6DdFI91010p8HSt14DN7gvAeolA5YkjECdAVrDFm31aAq5sufHOjMLO2NATpFyjDEgvBPRXDVO3M4zSK8+93Az8ScJ6GOXjqEsQeQlvsNLGcpeMRqUrYLka8YDOWgTaw2c7Bq0u4ZHbDcDxVk5hw0FkOuO1318SoWhX6X5cgaezZaTecGUyOIOB36QNVuXV7IbUA58FJeCZRkQsjFA1HFmqPeZbCvLsHtfC+QwLSmu4v5B8LZdUqHXwSXoQ7uYL5e7U8R1uRsD8Pi5EsUmQgo/N/u75gf346F35iMfEAOjOH2FdnI/IqDZChw4qYRqORiDHv1Wc09v4+M+4gw3e83TRA6nVHEjWNeH1FivOuqv0tkwfLOku9e174NgAWC4dksRVeEl74VQJRpHodeJuzjFjQnOil+xz5l4e7LDcgVManKqqqmKp1wQWP4zkMfNrUvqOUGfiSkFZvLO8Ee1kf4UojUEohBBNn5DRCR5MsGgBy0vO7Ha+hoTzIExajI1dPewmDpKQoIN9ZKK6GBt3JK43aovzZeaq1itDUwtUdHLNkqsJVwguS1+UtmTh3ppEYylMSPMsF1JdR+B75mf7sM+uX4MIlKrf3KNN8RefB+WFcVshnRBr88Zn3Pn+1jGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NQ7rYr8TWKzsnnB3c9aCdv895xtwhkghuJQvNR0dVac+MqZGGn45XNCpxzRc1LZTVN7ZbtP4grLc6wgOjNU3UGFxhJi7CLVwwq0piK6vdsGbDt2r4uUP635gAjmIShgawBw/bMdgvQRvROshVB6k7/jitwc8TW2DnwmmkWBlZB2htFvqndReuv/ks3h0QycELV9i1mSq0qtt4nMtZYnmuYiZle9bGmlpFBjp0Alo/2Pb8vixeZepTNdXJeHCQz2hlAZ0mLtWlEEbXasY0J2kPYVuZzs7hKmBlFSzKVltwjF8NvhxchX9ZuN56wy6yK2auz1zOgf8mUdsyHb7cZzqLPFJXIaNCOBB0glUeN6Kd3yW1ImxA9NjH+plrka2dbwX9MNJQDSQjKzPaE0jqINeRLuZ0DOdAEyqgcrowNN3PDws4Bq6Qq+Y4sta6gX2OHMv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:28.7850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f559b2-7b66-4f69-3a90-08ded75d4edc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303583-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F54C6EC519

From: Alejandro Lucero <alucerop@amd.com>

Dear net maintainers,

here are the last CXL core changes for enabling CXL Type2 drivers to
initialize a CXL-capable device plus the netdev sfc driver changes using
this new CXL core Type2 support.

Please pull or let me know of any problem!

Thank you,
      Alejandro

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/sfc-net-pullrequest-20260630

for you to fetch changes up to bd6550bcdb0c0bcc6e29706ffe2e64708192342b:

  sfc: support pio mapping based on cxl (2026-06-30 15:24:16 -0700)

----------------------------------------------------------------

SFC changes for CXL type2 enabling

----------------------------------------------------------------

Alejandro Lucero (7):
  cxl: Support Type2 cxl regs mapping
  cxl: Support dpa without a mailbox
  sfc: add cxl support
  sfc: Map cxl regs
  sfc: Initialize cxl dpa
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
 drivers/net/ethernet/sfc/efx_cxl.c    | 105 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  32 ++++++++
 drivers/net/ethernet/sfc/net_driver.h |  10 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |   2 +
 include/cxl/pci.h                     |  22 ++++++
 18 files changed, 309 insertions(+), 70 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/pci.h

-- 
2.34.1


