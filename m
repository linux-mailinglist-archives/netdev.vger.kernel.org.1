Return-Path: <netdev+bounces-252077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH7eDN9OcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BB5E8C9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E88645F3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B543DA26;
	Wed, 21 Jan 2026 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gfYcBct2"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25997F507
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033289; cv=fail; b=bIFLnSNAuvxAr0BIGWAVh3F9SsoX2DoEkKIcoBTEvr1xbPkxgnub3/pjHbS36MeIExXvUsEgGDgX3yAwQ4MIroWgaWPRvsf9s8qIIX+1nor9Nzyrl4Eu3W49TRUUw0JjMAHkjhNprDNeZvQi0iL4ON0yl/+2tPEPAGZVuGYgBH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033289; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGJfzOFHySjixFqLqU6YMU6HON8CZrO+mjLAryo3pd9yrDbZy82ltma5HaYkM898IyqRrGjv+hUmvDHe2cvnWRnTmxkN7IrpeCm5/dXyEjcjFkezZrHjw4ckiu/eW7XkuZAwTbf1E3xG/yVm6sMbAKavu4foqE2ON5UWZbot8fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gfYcBct2; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8QbMVwWVwcIBLBszEr/A8BI1xm3JWQJ+gnqb6x1YxjqzmF3QQDBIvY0yzhJNIo1rNlYTXyxSZDzd4UYRLPIrprvBBEMmiLNzndRFpJb8SScDqtrScOqpHyRusaGq7aajhz7L69sN6EuzzZGtZy9N+KKABPTpuIj6CYX9GspGSJ1aPABXsvOE9Zy8gO3Ta66g6czuihLIjLOhv9vGEUAqiezECuo509sdlGUzXn2MVotZsK8GfwytOd671Hg2C66zgqAsipC66X9sWXbcRuWsXFmAg4N0ej9Fk5Op96gpZduWJh7EY9v0lhDQcdlcef1+/qB8B/G+qfgc3KZzmTdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=WtmgQ2vVa6J0s4aoDRCDM8vd9KaQc1B5PaZv4tS/5itC9eEfizoX0a+eAZsYUlmvT8de2T/xE1i1SVrk7OlvT1homF3k9V0lG4aU/mKh22pNaq0/+vtgitSNdA6Yx7B6h+GYSWMydxk2tCp4bDaxZVHoNOJxirUgS2MEhqYn3TaN90jU5CHft8hxzG6UVIxvmBj6TW84xHDJ0nRy//AJFCncQOnagjE/tYrvaqivz32Wf+woRVlqCFOMo0OcVSwHgZsb9vpM1pMpb+kyElKql0/AEWLSvI5PPD2BPntCOnLU961DlY39jhhCf/wX4MSFXrDq+GPZi3nL3LGyGVjh/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=gfYcBct2qp9nSY/5ik/khaAmie9yJ/LpvS45o/6O4Q4CwIg9tCqpF2gAGZDhy7MVhhP/K/+VgiI2m+Z1J0T1iAwXeKI5LaWraVkXRq8Ei1rpGWtVwxO7w0PQy4+gMVNskw9cZSqP2yvnv8RaDuGV+5wI6+no4xe+StUxe36OoUSKsypKvD2yYvLGN/Ed3W0xO9FfOlBWTskQ4KLVwrSdenHxB62Cb++0K1d+S8XmpLGAghLf2jsQD6A/I6YvyuzT9jSogYT1Pftg7MterKp05E3FSpsff1BDrSIg6lcMLfosnb8AqpsPvXj2W7/BwlkdqSF2n51jHL70DabycU96WQ==
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 22:07:59 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::2b) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 22:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:07:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:34 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:33 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:32 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 01/12] virtio_pci: Remove supported_cap size build assert
Date: Wed, 21 Jan 2026 16:06:41 -0600
Message-ID: <20260121220652.894364-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: ce296c0b-02fa-4dc6-cfd1-08de5939899d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wV6OUJSKSQHoq8P3IdyUwrobcEiTRr1QOV9Gpa91oB+T/xe2Sg3e6GIwyYfk?=
 =?us-ascii?Q?oWD1C9z6HH1XH/2VbYXdRXQYY40zTIFfthzXb+IMYH1w9O5BrPeK94ODdUPn?=
 =?us-ascii?Q?JpHKAcmZX6wizVv+DExGB+SpebB0mxtiBqyv1qPkgVOnzWyAYHpYcnz2nBHY?=
 =?us-ascii?Q?E/dha4auggMRUmSAPmTgjomk6ghGs1I3ttgru+SLgwFDbdccvHQCs0GxhLgk?=
 =?us-ascii?Q?VU2/ksgavI6B6Td/5XuYfpcakWMX0RWN0I1+x7rZBGVrxGcJadK4LMNw6nbR?=
 =?us-ascii?Q?CXIuTkaAE0Cjp7Y7V+mb3LGPgXvecmZf4YvHemDk/WR1fMKcmXBysU+8VAya?=
 =?us-ascii?Q?ks7Rt5PuFliqu0KRb9orGydPlLHb8H4EvnWo6WdUoAvaqL5Hcz1hNZ+SDqWR?=
 =?us-ascii?Q?Hbqat80B1knCdJ3BzPthYbfXe5UTPzbXSpNh/amSyRcg3s1RhRo8F41P71hv?=
 =?us-ascii?Q?v0bkZh0XkK/YmcvqM2QcpgjbAraEFmINvRNUIzQLNbmtlqRMqOZ6vKvTyY6i?=
 =?us-ascii?Q?bYsXYNY3JVX+23sdCDsZKs6Q1yQ64y+4Mh9GlciKKLgDDrMS3VIjVFsDsBcH?=
 =?us-ascii?Q?hNVQiW1YGPWiwwKXaKOpWd0aiUBnySgYK31UPIJT4F5u0MqXlXEIm5WHvh6k?=
 =?us-ascii?Q?mLUjc/Gh3FhaQITSStl/yHQWSfLe9/P9gRIfGQ8ROkWsNFOmCcM1SVRuiP+k?=
 =?us-ascii?Q?z2MDvn4feB57EG/JUzVo3vZYULTRc6Txf4dII4181YUBn4ZPCPuS9hGCWnHC?=
 =?us-ascii?Q?vXC6AX3ev8K9TcYBiTJASrkW8zC9rPu84BrkDB+/vLhevnV1Tz1A5i2QNOu0?=
 =?us-ascii?Q?KrnRVWQFb3O5FNOOEjyYguNleedqmIa2fzKxKdlUd4C8ioQhw343He09fh1j?=
 =?us-ascii?Q?BdbBnFcw2Fge4zGHQ+n27tdhcyxiV+3vtw7W8Tu7he6HjmX3BmjcCFb+wTQJ?=
 =?us-ascii?Q?9xrnAVfhCXoy/Kl+dtQSLIWVUFwGJ0z1dK7PvVuvN0UASjccmCDPXpwJkw+W?=
 =?us-ascii?Q?3Auy2ezM717r8J7uzd3Gwq6/kcKGrfQUHr4iM7kI39EXOI14nch3J9ybGxXD?=
 =?us-ascii?Q?4F+Qm7Mdns1s/TtGCQEz/yq7jFyTCNKmYQECMVVCsV08Gm+KMQzC1B0veZz+?=
 =?us-ascii?Q?HFQWC4Px4F1sQYN9xCDZCzeEJjNlOQoJUb/B+o0+HVcNI0WUZDXZHc+w3wJv?=
 =?us-ascii?Q?R0bK/1bLbo51sdMHejKqHjJMjjuLZ9/LsV8S3IIa0ER6hb8/8QBtimH3A06L?=
 =?us-ascii?Q?RI4boHa9D5KnFH7cGaVf/X4GvtUESgi5E0exfl+/wWb19BF4cJi9WLgeKgLJ?=
 =?us-ascii?Q?3fLC0gvdlwNp8PjD7mb2wjucLomeMiPJHNYQTAExmcHi2vF5cBNRmojxzG4g?=
 =?us-ascii?Q?mfhvQawWSaAc4DpRwCWaDjv3vqC3nB1ElTzddaIXKX7MgTcd4e+CoYN3bSpq?=
 =?us-ascii?Q?HvKA5tYj0rMf/BqaHkVBR5P5RObdLGgxHbV0Qq6gFYJ5oKNFIQYgFOIoCW9O?=
 =?us-ascii?Q?Quog2IywO7IOLztnRm/ETG8d90jll/9/9PguSi3aOw1psSC4mG1vX6SlgPGI?=
 =?us-ascii?Q?GwPsXPTu7V0sZyfmMmz59Xtbp1xczkZQilpVvkFo9bN1lqL2MYutMgNIFKLC?=
 =?us-ascii?Q?qd4CCnlBwdwJi/ntDcb3cgBC67t/3vsiJ4aGTGilu1c8QqPUHtISb9Dl9Eq4?=
 =?us-ascii?Q?uay6Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:07:58.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce296c0b-02fa-4dc6-cfd1-08de5939899d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
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
	TAGGED_FROM(0.00)[bounces-252077-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,alibaba.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[213.196.21.55:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[213.196.21.55:from];
	DNSWL_BLOCKED(0.00)[2603:10b6:208:2c1:cafe::2b:received,10.127.8.14:received,10.129.68.6:received,52.25.139.140:received,213.196.21.55:from,52.101.52.15:received,10.129.68.10:received,216.228.117.161:received,2603:10b6:208:2c1::13:received];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received,2603:10b6:208:2c1::13:received,52.101.52.15:received,216.228.117.161:received];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CE7BB5E8C9
X-Rspamd-Action: no action

The cap ID list can be more than 64 bits. Remove the build assert. Also
remove caching of the supported caps, it wasn't used.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for V4
v5:
   - support_caps -> supported_caps (Alok Tiwari)
   - removed unused variable (test robot)

v12
   - Change supported_caps check to byte swap the constant. MST
---
 drivers/virtio/virtio_pci_common.h | 1 -
 drivers/virtio/virtio_pci_modern.c | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index dd0e65f71d41..1675d6cda416 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -304,7 +304,6 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
 
 static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
 	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
@@ -323,12 +322,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 	if (ret)
 		goto end;
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
-
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
-
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	if (!(data->supported_caps[0] & cpu_to_le64(1 << VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.50.1


