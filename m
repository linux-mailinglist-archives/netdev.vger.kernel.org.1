Return-Path: <netdev+bounces-252078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EyfKuROcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:10:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 290675E8D0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50BB9864755
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A743E4A1;
	Wed, 21 Jan 2026 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+qYUcvC"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AB43E487
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033290; cv=fail; b=mtAJEAVB8nwSH4iwsKdwWO4XSlIa5CpVTPPwXTUarBeBfjdCPLpCMjQ6ygSWTivCmxsQac+RhxerNempIyzRA9MLDD4NmcHFOJ09TG1ZE6PIAmsGHe/eY25fP9xUKKu+P07qZPoa6XnHdGiXbnQG9vDVpSa9ODv5O4gyxxbEHrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033290; c=relaxed/simple;
	bh=0bWuarCUiNnoQxPleCdoxJ9YcFfWjBBEhRGev4p3GAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xk3PMJH5TDJx2pN/V7r870c8s3giQtKxi6u2nNUG+fhYBfIUh2OjYUPkSyNNzMJg5wHlFwognWKfg0qApeL0X3raZQVSGOdMBOTG5cQ0foxeHx7gc/MfD+PqzeA9DsCXB+LOYfg1CBJXlbkffgCvWDRff+Qx56+ZpSpb45GqLe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b+qYUcvC; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc8DKpbrF97IRRwiHITwmLVtP9FvcoGqKuc1DITiWRLNSAahUjKVcp1Pr6kaaKGBFA97I6wZy7xaGkTu2hTRaj3bqnP2oRXf8orp6Yj9iJbGXqpF9QV6lKWndyEOQaUDON09JIcwofk0TW0Cy6HyBglhBIndV9W8/TyKcGH2B7fFP3GtwCrAErKFMhrw290kAoUHQtS+QsxK1SDfE6bUnxkxp03JFJng33YMbt1e83O9mxHehYQSxbkUBjx1Od8AQqmfGK8TOeXsFBSAPnyHHo7Q5Q+dnwLMnFzLeH68Ndo4bkLDmoHuP2Qc/0xy0w7jaoyaDTLQXkxFK3ZmtoX66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKOVoiZlKR13Tn3fy65jnxa8LUb8kjFUg4/pvU9csUk=;
 b=s5a1AJ/KtKmhf+y4/J0t6W0iwhg+45mDNZ4JwOFsm5Xid1am8JVbXZe0XHFrT7Tgk3TIKLhPtdQH68W80FrbfmdMkcRI+ISaBNM3hsCpPWflKdmrVLRARDaiPrmDVK0pCAh4ie5vfZKdvb8mRkxthvGcnrx8LXkV4zJwn/dHrKIYdZcqV1DZ33ktd/la2MHcIDwmtEN0AM+UHfHme3RuCgww6VYgVXpeEa5sxhQJ6qaZlR4pnOULsaRhO/CbtxiBpDg5IjHtxibuAFkSj0GrFsgxa45r9xmE4VRlDccD46WzbM1aNfxomQTwsRZRk/a8ZHEcPYr8K7t752wI7zLWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKOVoiZlKR13Tn3fy65jnxa8LUb8kjFUg4/pvU9csUk=;
 b=b+qYUcvCrP3Vm4+vxovWOruNidIxUse/4N5UGKCKac8095ednxTBYziowwAs9J65zMxlaJdRfnjK19B0v6M+lWxNrpBqaIpQNeiP3At1ebAJbOAlQu5T2CfP0TpgJuB+cWg+JsmzY2Cc8E4W0aR4ndFjnCWbidjYyD5hDGQhi4+E7BcYq4J+xIC3ne8CghZySdzxkIaOaF8dXAIV40pHOvZbihURDwtR5boqe1QuAaijI0bTfUUi50G2Ym5C2RJEBkuYmUKWmzlSYXE7sgXA6EZr3HJIJSqjAqhdSA7c+pib3WR/zglL00eBwAED5Pzm8rIcW+wxPhQXtISpEk6o4Q==
Received: from BLAPR03CA0172.namprd03.prod.outlook.com (2603:10b6:208:32f::12)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:08:02 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::ca) by BLAPR03CA0172.outlook.office365.com
 (2603:10b6:208:32f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:38 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:38 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:36 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 03/12] virtio: Expose generic device capability operations
Date: Wed, 21 Jan 2026 16:06:43 -0600
Message-ID: <20260121220652.894364-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121220652.894364-1-danielj@nvidia.com>
References: <20260121220652.894364-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6585f575-5bc3-4810-18d8-08de59398b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYYchdeScSdppaX4DzghsXNnMnykwe5W9zIWYFjvZ204J5NwUpO4PVjqgRw+?=
 =?us-ascii?Q?NjL2hIbPWbz1A2xbO4UYcFUQSY0yiivcvqv+lQpTz+WbDZqx+BvmCVB6E2Jf?=
 =?us-ascii?Q?UAQAyYW2d7yscLjZLgiDpFYbyKBklgSzUFKnG/dM1CNYswgUi2U/qn5g1MhJ?=
 =?us-ascii?Q?OUFmG4WRqdTrNG5f35j1ZpPSl1KcNNQjMcLNaf5htr1CF4i6q5t1CWuPY3vZ?=
 =?us-ascii?Q?ad/gWRRUA7Wpz/x9dDMFoT1CuB6rONVKjCWbKB+L6csVTAWJe+TL0bpDPsoG?=
 =?us-ascii?Q?C458Z0heEREWBGVzgLyT+I9Kcm/BszUDtZWBkv5W+dW3zTe7cwYACWUlUnYz?=
 =?us-ascii?Q?mg/wKe+KXXxPEuYAZZZ4T52vUsT7gV8d2Km/2F9XwR1OvXPqHw/rTFiGhX58?=
 =?us-ascii?Q?Tn8K5hejjFLuuuYxMpNmacgzoKkRKX/Pw2ZYJOSSphJB+ViC+k4onrXhNBRU?=
 =?us-ascii?Q?lrIGN4C2lYPFPFBn8YkYIG+E1z8uFTzj1F8XabGLYli4Wf8z7Dfmep9xOJF/?=
 =?us-ascii?Q?B1Nv7xF+qUPwXaJEuhryqv7VdaNhjnURDIff/TzcaWSJbp0qaNlGP9IaMX5+?=
 =?us-ascii?Q?7R9+hqWamMx6oO++7KC0T5WmhI6CdE87dcqPAjLBqXN/WpQuP/DTaXjfJN01?=
 =?us-ascii?Q?SqppHXSnC6HlVPrMrFT02zsMMzLOKOD9cjL0z77edDOAuuFw6rbEvHUzsJog?=
 =?us-ascii?Q?KIwr93rsvmZ11uYKVZxfshzscR0HilfVMSaPr3chNO9vPZLSYKshL7lWdJXe?=
 =?us-ascii?Q?7gfP7bQzMQ5PSsoN/xP1I4XRA8RZ9PcLYhaDTW7ZbhRNUcRv94JndYq+rr/z?=
 =?us-ascii?Q?yQVBWl5ChepJzKZeIrlSG0DeEsanG3DokIxJH+GuCHmR1Y/jOa5rYTFF7ZLB?=
 =?us-ascii?Q?85Y3gbT5aS23VXfXsAPLyZRFC7+BFxb92+L7SM54VTCdNHMdSTSZi+JzXdpu?=
 =?us-ascii?Q?tuKr7/o844l8nBJ7HBjG2ifgVbek4hxjcOKm1o3DJhiod3G+IVB4tX76B+Mh?=
 =?us-ascii?Q?WBV4DIZU4OPfb+93AEP3XESfxEYvcaNzfy75kxst1P35DDxeZOP1S+Ge3b4/?=
 =?us-ascii?Q?Tb5c2ZTMjXam9LZqHXU6yYIty2aj8SRyznG40UQH4dngtfihL2NnyYyT4DGA?=
 =?us-ascii?Q?JRlK8pzaIkcpn0KYMuIpoonI57A3hlbdcdCVyaO3wzaY9BVmXP1ULj0pCyL/?=
 =?us-ascii?Q?X6cIerwAMtEwKtE529infVk/457emg1dq//Dzi7T/cOgKcLYaSkHk8kMg3bK?=
 =?us-ascii?Q?89mI4pgd9wFnCh2muASwbDmxUUvhw4C2n3q8zkyaKfZMBNuIiEsxvGX0YKne?=
 =?us-ascii?Q?BX32+XsyPop3HSEz60zLUzx7Hi1QO4UmtJtLybcCZCol/0zHRdBrzKUYM1gY?=
 =?us-ascii?Q?oZJn/U4wzdNSaC0l2WWxRcFoFD9xOgYBiJm4ZG+OT5zN0+MNO7OrjXj72ws2?=
 =?us-ascii?Q?REq0L81pRJQ95ugSxROrWTY8WBeW0XmICED5Zg6vgaoDPxntGX1msPxyh0dK?=
 =?us-ascii?Q?eQ5lppsrScllMK/3V1JCVOKFMnmearQrLxnVmGOjhvxIKN86ozi1e8DxDUUS?=
 =?us-ascii?Q?6+CMysSLb8XLRjlDBdLWgGDD27dgftmif8tAw5P6jX6SHROGU/lzwN50SZtj?=
 =?us-ascii?Q?8mf5FoI+g7Tg8mnupsCVjYfeSGNBV1Muq1KToFOBgRLfd6YuPA9fmGdK0iHA?=
 =?us-ascii?Q?ZsTXmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:01.9576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6585f575-5bc3-4810-18d8-08de59398b7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252078-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a01:60a::1994:3:14:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received,216.228.117.161:received,2603:10b6:208:32f::12:received];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	DNSWL_BLOCKED(0.00)[2603:10b6:208:32f:cafe::ca:received,10.129.68.10:received,10.129.68.6:received,216.228.117.161:received,52.25.139.140:received,2a01:60a::1994:3:14:from,10.127.8.14:received,40.107.201.12:received,2603:10b6:208:32f::12:received];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 290675E8D0
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
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 94 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
 4 files changed, 179 insertions(+), 3 deletions(-)
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
index 000000000000..cd000ecfc189
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_admin.h>
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


