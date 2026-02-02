Return-Path: <netdev+bounces-255942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B+wLLzbgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:15:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BECFCF71F
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6513056272
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46E385501;
	Mon,  2 Feb 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YBwFFFNK"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA13816E0
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051962; cv=fail; b=XnIpGxdjRCXGJZI8y9eY5pOxpOEDxg9pWPF4Ej3hwpmZAH1Wsq72DNcI9m4U4M82nloAcppiAsoIZe9OxoLXDoGXMToiCbotiH4Z6fMXoTlqZDkN8YoYP5m3Lf/HN3A+uq52eCfaTtXzRBWBFSa/yzbmJ5u78+CpeRBggsNiTkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051962; c=relaxed/simple;
	bh=t2FrcKiaN++GEbf6PPdtMeEU3iJH+lARm9vGC8IeWSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmuCV2iZ7BlK7+0EVfmqhuD5raeE/U7zHVlcEpJUvVrDSbsxdMkldbCik8v2lkkla9hc1c0iGSVvDsDi5ONuf3eHeV5I0L7zvWR4IHlv6WxPeo6D/aDxJ/wk7EikijWDSvi8X8F22Mv2n+7sWmQTnPr4FbK3MAoeIvLm5k4n/CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YBwFFFNK; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7L6kqJHw6E/Z48ol+zMDgfqKKF+Zcil1ZZGBihtz1v4GsuZuSoixD+sqUMkqcHcii+nvPIH80v4el198LYAAoN6CU2jzRVCMxJXL5UNlKYJz1Ssam745eSDMYIUOU4Nxt/8P5/pG/C61EHra7/lfY72RWcvCnGM1GKRo0nH8ZqGnDuWs1jyT5PlXOJBZnLW3VwOrAijS6HBhUBhQrJbeBn5VqSBaXPINhLgaIkGihy1STu+2AIZWQF5LZznRGiYrB7LB8TiWDkUk0ND1l4mgXpEV4XFCDeWxqvFZlXdQCe8vmUnZB35MG7uhJRHCl3qws6Vi3eya3vYNMhTRxXr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=q/lpAUPRsoPB9pSsKTjrckdm07DepHv+ENr8mXfyGcYB77XKqqQBaWObDmZgnWaCTbGLsDsDEPCdWSViJZLwC9/qoG8mHVJkRAtHTQkXiJuhtXfi8OzQR4f6PmiWk8AISTVDD/m5G515juLZQQyXNIgNIfY3zpRhBKmmsg51g8tkR/+Josg+alTWNBavXQ0c0rMcitIjrcLNT+rDXGZ2S74poXs21bi1Bix+s1e059I0ON+nUUe91eZWbTQWHmEzRhUkWRXAraE+ceQ7jw1l3XfQhlC0spMVIkhJ6bUrmBy7IV8n12XX+XfUKSlMJcDIC2pW9eigRSjeFAvA9OZbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=YBwFFFNKoG0MolJDi5j9+qbu7EvBNXepdnJABjbjb5d8Lp5wUMIuHDIMytkM/X5Iw6kAv3d+ZEilc0K859ZWmBFc8PFcQCdLpf9yW2Hfl8sXOdecL9nxhEw2wEi9/B//JzQmakH+5mynFZzR+/Viv1jadd/DCpUckMC3AxvBff2a6nGIyLwbV7jM2M50N21ltsoiHXlCBnacRfGXSeQ4SZqMjsbu6U7q1jShXpRO++cQ874osrhLCWd75+esY26dZVQVs49wwauhv0cOm3ox5o5UusZjGwDmPgGa704uEKfUZ9Gg8WOMZ8bnTJktJICWE8OkHqfyPoMt8eG2fmfOfQ==
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:53 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::81) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 17:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:05:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:31 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:30 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:29 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 03/12] virtio: Expose generic device capability operations
Date: Mon, 2 Feb 2026 11:05:09 -0600
Message-ID: <20260202170518.9076-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: ec74bc45-504d-484c-0749-08de627d52b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JGhW879BzrK0gFwmfejYKaR04f2xjxbMGjMsiIEz18EoOBf7T7GrZgXwA/7R?=
 =?us-ascii?Q?zEPdJtgLbQpjaMwXe04RAlgbz7pd9Z4spEpbF7uAW/wKAm8deOBiZPkPfwRW?=
 =?us-ascii?Q?w1DOILMs1fbV9TH+EhDq7lwiwNCoFP5wNQR8quK8oAJf4geaGt2gjnAUV5bm?=
 =?us-ascii?Q?tx1cJxv7X4h8VM/QdgSM/HHgWF7A3OuR8ftcHR9QqjtJVu5ZurUFUUOIUqWv?=
 =?us-ascii?Q?BwbO5hWLNBs1SYrtaMcexsy7E797F1O5mjeMxasjbqJOsr2neLmtpuEmaVM3?=
 =?us-ascii?Q?se3ETeXQBoVsoI8Ah3qbjkVXYtEt8d9N+7iAfQP3KilFmXDRvcwvwHOgOI7Z?=
 =?us-ascii?Q?PEakXxMdOsUcAzjZQvqzyzQ9PBT+cA2ODwbywO94FhC6iEpjHkakgeCMnbvv?=
 =?us-ascii?Q?2DwEgm0k5hIN5WONj3s0n/GI5gAvtZH8xv5Na5HumWX+1QkhNdsj+IBPUpcd?=
 =?us-ascii?Q?P9++S1Gr/p5XfuhgqjGAAoeUX+v3Nmpwe2/n2piPPTL+9S4XncP/NtORzAZy?=
 =?us-ascii?Q?RTR193U5CTSx/K+Fq7X2NJJnBrwMTlXqsj0VZQitX8HlrJ+tWZniCZySifXu?=
 =?us-ascii?Q?b00DosIjmXvKehub4N9BXrOHuzrUpbbfbpAabUghZxTueiIA44jb1tg9vILd?=
 =?us-ascii?Q?frF9fd2/O6xstnJAiKtJhZKYXmR9Qx0L0TgWFr2ZIxOOzJr4YOKeKkJdBQcL?=
 =?us-ascii?Q?XcZraMSyWS4+95R6f1LFX7h5M/EvtGv/E1AYQSvL7r45N0Gc+TYKv5fyp1+q?=
 =?us-ascii?Q?JCxBlftXtFQeVNv9cl967OxaYxhylyvdEdm0gaMtQq+GKNq2cwENE1xtKbr1?=
 =?us-ascii?Q?rHTtcM7CCskGv5I8I8VawVMcquBXGeU7GUchZMgQW0076bF8XoTMZ7m6XWfj?=
 =?us-ascii?Q?PN7hvPxXf/gh+DX+Juo4b5mda8QX2ztbkSxsFfsWZkpdXSJrQLGzAXkGl2xZ?=
 =?us-ascii?Q?Y08QrG34ahMYnTzXnE3tVVLsntEK9biW0/WOc/145dGqx0sfIhpIldZZKYua?=
 =?us-ascii?Q?FpZZTbZTI3CZaIl5s3R3JwAIDRlTvf9iOVaSrbfxq0yXi7ivDUPLK+ysMj5r?=
 =?us-ascii?Q?Dw90F6gNwgV6XR1sb5RvRigyzDv1No75VtXbxwyliR2mGzSgtYvRsNHykb9+?=
 =?us-ascii?Q?wWg1HxETc9VT5TE5iZKdoZDfik21iYkqy9fTaEFcgXrxnbBMoFXmDiqRpF0s?=
 =?us-ascii?Q?jkiRsem8it3htkPVZI+cm53Kn6ItbZYinbkJkAIucdfUozNvdx4lyKncfz8R?=
 =?us-ascii?Q?NV/VMm0U6HLwdNzLo1+Cnh4U8q6HIm5ryDKYfZ3JbCZPvxMIBCp7qNKvecUp?=
 =?us-ascii?Q?XnfyjnDo570OF+3AEFJ9NOiKTXwt1UasClzwmWKrytSYk0GBouhe+ZdHcZmA?=
 =?us-ascii?Q?5ss0+5tlcgXqifxpJiw0Zz4fIbAWu+uhKERxewnAdOIWPdsN1vrGGmaZ1+KU?=
 =?us-ascii?Q?57ebcyfSjEoEteZEpaQl4MMmqIf3lQueIAnuPtzUIYYCyPIQDtmSvyVdIoeh?=
 =?us-ascii?Q?RuM/QgDep9gQBE8PJ6C1A0lttMjkBqUohwoaBmKmgYO5EapcNimGA13qDi7z?=
 =?us-ascii?Q?wefh1T1p7J36561+dSpTB/mqfXS2FcB8URas+FWOLWFtSe+gpAIPvjC1nF2R?=
 =?us-ascii?Q?VV77ZZZ8Fw1nY1dD+LiJKOztzk2a+Gfb0o3RA3K8/OppzSUOms7e0dT5JLdU?=
 =?us-ascii?Q?rtwhYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P1PqvCYydgarc7OZ0y5c6Thv8Z9BQwYv5RP+DKZ775nf7oFHE0wtaIF/BtuPst/IFQQy/Iz5mevWqRYhxOa6Ow3w4WEG3N6N3twz7EauUTtNshSrcYUd01XB2ccc7PEUHBKacZmFFNTNGwzRBiQdjn0JOiQbZm5Sw6okCA5eh7ZqGV5eTwzgCGai/BGQQihGSg+AC53xHi7S7jUdyA0hXO7dLk8joWT7ynp1yvi/s902Lr7vqgMTM2DcUjxmY4YvnSIziKsmCrDjcCY7ZWlHnurt9aT+ZTnZJ9AnE2ekx2bMIegmi2LcAGNlYk+ZGLO/wtco8OA01SrEIzpq3+FJn8twWPvbWJz/9vdf+B/ou9E+Bx7+rzJOgEVPgfUXOmmaJzBO2ffTldi43rXtM+/JMou/hcpgOtY4CLg5JP8FPSul9vhtYuw0yiXODTufxiC8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:53.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec74bc45-504d-484c-0749-08de627d52b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255942-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,alibaba.com:email,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2BECFCF71F
X-Rspamd-Action: no action

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
to do because this data is written by DMA, so a newer controller can't
overrun the size on an older kernel.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.

v12:
  - Removed uapi virtio_pci include in virtio_admin.h. MST
  - Added virtio_pci uapi include to virtio_admin_commands.c
  - Put () around cap in macro. MST
  - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
  - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
  - Updated commit message

v13:
  - Include linux/slab.h MST
  - Check for overflow when adding inputs. MST

v17:
  - Added missing includes. MST
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 96 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 80 +++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
 4 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index eefcfe90d6b8..2b4a204dde33 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
 obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
 obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
new file mode 100644
index 000000000000..be9144b25d84
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_admin.h>
+#include <linux/overflow.h>
+#include <uapi/linux/virtio_pci.h>
+
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data)
+{
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	sg_init_one(&result_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.result_sg = &result_sg;
+
+	return vdev->config->admin_cmd_exec(vdev, &cmd);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
+
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_get_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	sg_init_one(&result_sg, caps, cap_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = &result_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_get);
+
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_set_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	size_t data_size;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(sizeof(*data), cap_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	memcpy(data->cap_specific_data, caps, cap_size);
+	sg_init_one(&data_sg, data, data_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = NULL;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..4ab84d53c924
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio admin operations
+ */
+
+#ifndef _LINUX_VIRTIO_ADMIN_H
+#define _LINUX_VIRTIO_ADMIN_H
+
+struct virtio_device;
+struct virtio_admin_cmd_query_cap_id_result;
+
+/**
+ * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
+ * @cap_list: Pointer to capability list structure containing supported_caps array
+ * @cap: Capability ID to check
+ *
+ * The cap_list contains a supported_caps array of little-endian 64-bit integers
+ * where each bit represents a capability. Bit 0 of the first element represents
+ * capability ID 0, bit 1 represents capability ID 1, and so on.
+ *
+ * Return: 1 if capability is supported, 0 otherwise
+ */
+#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
+	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
+
+/**
+ * virtio_admin_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: The virtio device to query
+ * @data: Pointer to result structure (must be heap allocated)
+ *
+ * This function queries the virtio device for the list of available capability
+ * IDs that can be used with virtio_admin_cap_get() and virtio_admin_cap_set().
+ * The result is stored in the provided data structure.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability queries, or a negative error code on other failures.
+ */
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data);
+
+/**
+ * virtio_admin_cap_get - Get capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to retrieve
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function retrieves a specific capability from the virtio device.
+ * The capability data is stored in the provided buffer. The caller must
+ * ensure the buffer is large enough to hold the capability data.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability retrieval, or a negative error code on other failures.
+ */
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size);
+
+/**
+ * virtio_admin_cap_set - Set capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to set
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function sets a specific capability on the virtio device.
+ * The capability data is read from the provided buffer and applied
+ * to the device. The device may validate the capability data before
+ * applying it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability setting, or a negative error code on other failures.
+ */
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size);
+
+#endif /* _LINUX_VIRTIO_ADMIN_H */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index e732e3456e27..96d097d3757e 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {
 
 #define VIRTIO_DEV_PARTS_CAP 0x0000
 
+#define VIRTIO_ADMIN_MAX_CAP 0x0fff
+
 struct virtio_dev_parts_cap {
 	__u8 get_parts_resource_objects_limit;
 	__u8 set_parts_resource_objects_limit;
 };
 
-#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
+#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)
 
 struct virtio_admin_cmd_query_cap_id_result {
-	__le64 supported_caps[MAX_CAP_ID];
+	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
 };
 
 struct virtio_admin_cmd_cap_get_data {
-- 
2.50.1


