Return-Path: <netdev+bounces-257351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIqHIVAehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D2F8338
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FDED3032665
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED223385A9;
	Thu,  5 Feb 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QsGk9wAu"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55D3376A9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331661; cv=fail; b=ZLzzng6qC4h1I/KfKfBPVWetF9H8vJhHMzRIhCR8pYo0YAKb/MZbduc4VDIykvBuEGUqsNMUwY6L6frwNfxdVVKhii27l790EHrTQOmdaAaWG+oFzKlzycG8NgbGcfO6jgkwbAC40N4Jdm6xGvO0qD7n1FAT6LpcjfIbblGIce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331661; c=relaxed/simple;
	bh=Q7jwogH4HAzXhwKXwOSVgPWx+XlBKLc8CMjdy0U5OTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcc/OpLUlYmEeamptaX9tDyfW8ReXaOpG8x3PyKZ0OO4rp4/DIFOs2/r2BejyqzPfnN/cVoTjAIbQMPyHkviuMR5qmuaW3ST3/4CDSv50dm3yGgZ2Uv/sfZndhNzIcPyjmtSd+xIeINpSKJ20TwsxrAloeqNPYEZbaXQVeXL+EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QsGk9wAu; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWpVxYFGdFnlTkiHjQ/84iAXF3fKMqUBlRKtKJO0nuFxEZsLFjV8e/4/MuaSJO3q6CyheHbAL7oj5JPkmtF8XDHhPZhGq7zFAGvxpK71z1oHEbBQnDAlbN4DcxO5MDNlbAhcxm6458nJ0zwEWXDDkgrkIeIdEHJAXDnB3ZR90qVOQY4PWsucEunb4qtUGAOZxxP8fjtecGuO1NvMdFlOj6+/42UE0tICGQbJ1d2wGONcJjA/5LM78W7Xz7+VJ2/3Nuae1tAZ8r2eYMSgALf8gJs75fTepS/kyBXx7thwxdbJMzmKoJGbdgB/IZt+ByGHrSvl4VdH0W9MnywRcm/RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=oo5ZzqyqMVCSKdmITcqTVSohBAszOc27uAz242eESPTbRMt52ahJMvQRNnlwj3mA71oo/Zb/ENyxzLauOSSRzRc4ak0WvbS5PSVKKpTV5VQ1iJXKwmMzkfDzU3++Am4DoOav6oTucHk41rabhqqipPgmyLlL7drN+2izHaVwfSKPevZ7HN6rjBV2vjNTdND9APloYbIE7cTwzCI+V0OK4mKmok7up2vR+KUhINp+O1T3BoP1i5noHtTTJRGukSBiQdwuXbV6+WoRqURC6hKhnGGjLy07QdN7lq8ecqYn8K6ROWKiIjpPxF5nIw/Lx4o19GgOFTsE3BAI/tFF6UFGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=QsGk9wAumt5Ez9Pj5DmvL85N8PM49bsuXQHGmY/nM25yCLxC3KMxmXS0npTVkwKuJCpwA+oaEFggrdcsbG+jr4leIdtDWwlmpaW0QRMPQZSbOn2a4ZWpzvbSyP7ZjzsSGLfbz/ecJNlBP5rL46tTORPPIGPiRVAXcsZzb5GwjQnSn1RytVpgk4kTPeEXPKvXV2MOWRZ71lk3U4ti+MLpuL0pvTI0hhqKOQqbPn6XJvz8sz0MzRj1TOYnPsgSDnKeZrc7PKnAB4Mvq757iSlow0SMIuAeiKsnSenu8WtTbTxBjudfbeFmIA1tR6gwgPmTYMeB3YTetDjzjV9kcvEyJg==
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 22:47:32 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::27) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 22:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:18 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:17 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 04/12] virtio: Expose object create and destroy API
Date: Thu, 5 Feb 2026 16:46:59 -0600
Message-ID: <20260205224707.16995-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e41c6d1-5661-4106-9170-08de65088c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BOI/DXFtL6Toi0bxIsJewkIJ41n3ipCVRS9A1DBEpGeWqrNKBaJhEYrmYN+K?=
 =?us-ascii?Q?iISillJwcO9sKE02TtPpCDZBjmKdLhkWWIWvCkp6rcwAWK6YBU13Yd3m0ipV?=
 =?us-ascii?Q?uA2JX1bk4hEGWJ46ap051O+CITMeWKPSx/8fX3ufkPwR9JCUXCiBGhMDoIaz?=
 =?us-ascii?Q?3Y0B2y7Hq27viJAmGGltycm9TSPZHo6P/oVKRAoFjY2l94Oug7rmUHj5GS+4?=
 =?us-ascii?Q?TOw2dGqqtUK2BJd9O2IV3hxZvgA4Sl937MV2hmU7k4pT+WTfFVBbvRHqsB3w?=
 =?us-ascii?Q?eU1Nh72Z3k5vmkkvENBUZZF3CNiffiitoYy0/FmwWIDZrr/U+/OvBMDLvfS5?=
 =?us-ascii?Q?3WP+IzbnbI6Ek+d+KGiA1Bl4Ld3fU7OiUVIGOd10HtHPfiiQMjdBmdV0c4v5?=
 =?us-ascii?Q?PZ/qhllDpkGU+Jlg3PmiU6zoq+bwBIiGi2ooYh7gtljd6MbzLpAYqMM2uf6k?=
 =?us-ascii?Q?lO0wKcB0lJjW7yqv2DFiumEPHxOw5RehVoBuwH5NW2LGErJcKYOv+HMjZEU/?=
 =?us-ascii?Q?BN/G610QoOzjw54MUndePO28ox9H2uoLLvhvHtTvFeHB0sq93BZq4hDoW510?=
 =?us-ascii?Q?6Glp7AuocHoSdvm/G/Qds/U1S040F3tVGkn2iYRrAOHNEjD4kTdqqwRlboZs?=
 =?us-ascii?Q?TZw+vCwZwaieVjVGjDw1oSjCW261KZTWwpT+CKkCWWHf3ZsezuJ99ME84o8M?=
 =?us-ascii?Q?EF95MijzBNswYVkaqs4mIP1ok8s0GrEOSM6A3MZQAqd4NixdUFK35L8Wwzjl?=
 =?us-ascii?Q?mPsPlMyJkL0lRilI0Hu2WZZN/kGOQtjYNKYpltiJKjvOKCpcTs469yPHDESp?=
 =?us-ascii?Q?KG5rbvnSaBJKoG+lez/+xHL1AdNbrRSYkxppHi4Z1teDX6MdCPrKcX7QICRm?=
 =?us-ascii?Q?g+rx1xzBrHZMqi4fppZqUAnIJUcKSbC15xmd/Y8ovJD7Z0m7rZqXoDDVgKtk?=
 =?us-ascii?Q?rkFeWPcCItBIeNtNq4EgYUDCTWE/whxDuWXKb/BqR02w7XTmYbfN/lFx3drZ?=
 =?us-ascii?Q?OiXve7LSGhYmmugvNxoI16Y2IBbT2KyB9XfQCopZLBJCFcS9A3lCUEFNbhcv?=
 =?us-ascii?Q?43X7YTvlB/mBACYDZswWCR7aVdzWAnKsUhuRV7sk2uiaMtrVZ2ir6lYrHKvY?=
 =?us-ascii?Q?quVErnKPh8GZztNwYEyqH+QYDFxlrfnuuZm1nc7TlUwOgCJTytihDWToyQUi?=
 =?us-ascii?Q?kDYIlleXt7tnBedWe8nWf9V+2bE946x+uVZtxHeWLG3Ug3YsiJT0yVkcUzSx?=
 =?us-ascii?Q?iBxMmLj3DPMq1h9tK4KcHZqdncn/wtVz0EbPtJxc1SJAHLWC2ztkGOqrzPCQ?=
 =?us-ascii?Q?+pzzJuF7fNTn5hJNojkNj56c/pkwgzCpEOYf5VrH/78IDaX3sGnpkmUJlAao?=
 =?us-ascii?Q?+7ZBXIoRlaQGIQePb/6NkTA00MfelqnpeEt1FNVppqJPcitrpxXru9cYuFB3?=
 =?us-ascii?Q?FRtw0zi4uDKt5FihrWMniAxrIIHxvq91QUQUS8TjytS+Frr9XHYkQCv4763u?=
 =?us-ascii?Q?LC6c5RbMJE9FrKTCM5PMeNyJfHnT/U8mYE15nem4XRT5CWZWAUdSBFzCIAgK?=
 =?us-ascii?Q?vvUYxOcNs2LSZci2Ckecr2smuWXfcl5uYNM8sYjNvvYtdoEosDd0b6v8Hz7V?=
 =?us-ascii?Q?+iyIwcv0j5hZwZCTvHayUYcl1liDXmn7GU+V4oxl3nEnl96bt6DB28dtsM8e?=
 =?us-ascii?Q?QwjMQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LTMDfPiCjVxtVAs4FAIuNVLyXYhVS+3Q2ZM6gMhfSKE1djhTRb6cdCCzRkxh9LufCACXTLPOp6rVCMRH2IzVS7AXEUtFN1Pc0xiXpu2lJNFkUi1MmX6Hdd1YMLDdA8Rc5R4N+MDob8YfqDxLKHN7byjXT9fTvmzfv0l57zity/dPfb3tWcL2o5qND1O2BW7XtgNy85YI2y5pOFKmlZ/IDN9UKltSKCALwP76sfpHHzJwk/lPTfvEKrAah9j2mlGps0pmrPuhW09UKtM5lCHpdqeOO+weKM9MjavIgDfKgqnCBPJZ3z99fJiTpPnxIwzce1zhjVk7d/CSmXI5q+Kz7LHFTgjc1pkY/QpnGh+aKc1Hj0kxSg8ejAZAkYDDKJxdqOuhidmpLYZLSw9fBK8DHOvv4bLago1G+t1ytP2FFT4GvVIGAeJGnoVebt2/rBIZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:32.0613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e41c6d1-5661-4106-9170-08de65088c46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257351-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D55D2F8338
X-Rspamd-Action: no action

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
v5: Added missing params, and synced names in comments (Alok Tiwari)

v13
  - Makek obj_destroy return void. MST
  - Move WARN_ON_ONCE in obj_destroy here, from next patch.
  - check_add_overflow in obj_create MST
---
 drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 41 ++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index be9144b25d84..d9b65be2d09b 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -94,3 +94,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
+
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size)
+{
+	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
+	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	void *data;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	obj_create_data = data;
+	obj_create_data->hdr.type = cpu_to_le16(obj_type);
+	obj_create_data->hdr.id = cpu_to_le32(obj_id);
+	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
+	       obj_specific_data_size);
+	sg_init_one(&data_sg, data, data_size);
+
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
+
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->type = cpu_to_le16(obj_type);
+	data->id = cpu_to_le32(obj_id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	WARN_ON_ONCE(err);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 4ab84d53c924..1ccdd36299d0 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 			 const void *caps,
 			 size_t cap_size);
 
+/**
+ * virtio_admin_obj_create - Create an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to create
+ * @obj_id: ID for the new object
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ * @obj_specific_data: object-specific data for creation
+ * @obj_specific_data_size: size of the object-specific data in bytes
+ *
+ * Creates a new object on the virtio device with the specified type and ID.
+ * The object may require object-specific data for proper initialization.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object creation, or a negative error code on other failures.
+ */
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size);
+
+/**
+ * virtio_admin_obj_destroy - Destroy an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to destroy
+ * @obj_id: ID of the object to destroy
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ *
+ * Destroys an existing object on the virtio device with the specified type
+ * and ID.
+ */
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


