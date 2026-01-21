Return-Path: <netdev+bounces-252079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHC9G/5OcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:11:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 290425E8DF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10F3B72573D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60D43E4BC;
	Wed, 21 Jan 2026 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n7JtW6QN"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057333C51A
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033293; cv=fail; b=GIAiWFvSMSicQbBPlh7n8bdP+UTKxfosEAmO3GRe7DOr0PjGu1bl3qFu+S3llNk8CIxrdtqjm28/oAn+J3SoB3jpCgmsQZuPxTaRwR/fEMEBufGFktgb2xWrBaF9PPlfFqwWbSyS/V5D+kI0Dj5H2vz7lMH51gcFIdfSx43D4Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033293; c=relaxed/simple;
	bh=ak+PIZQjAFLmbBCmpSPROhmvlXP0L/lSwj3H9aaEK/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuG4yElqeHfKCX7NOf5kNen4UUe65b+C0KBFBbL4lOAnhkWcAZtGzBheTfTBjl7vXab1rYD8Kau6uQnD3XvHa+XrQQTkcGZIPcZpGFhYyLqao713Ak7JzKOYmYtg5xzwFgmGfsT/+ZEg6gIdVnxE8attC4b/Ppk5LngsA/Btd0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n7JtW6QN; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4OsXQnkjHkckRDhsTO7ctyeCTq7ilbbGOQBKTKEASNogu6t1Vxp6/aRxp2F6dWPvo5IbqhFcMCjdVmG3SS7wCeZTRCv2Sflymth7nzuHa+kVkGOf5ngvTKafHSfh3XYWCAJt03s5Qy/EICd1bchJVc0R/nKnk2yVQ+fmgmDHmV+l/8HwtfEbuZ4/FEOS4nxltMOuqqO/hHbX+S2HY5nknMyQdidp6kl9D1VktGXxq/2aup5PLV7bLznO8yWHqtMkJwlzhvexcHqjaGylyeAkkdFZ0eBFZvrR+5IB6VQ16RZA/AxHFRGLdhEWNiRkKThdXSQIlfY7x8x60Jbf7A/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spZ5GRTncB1F0sUzJg6kf7lsXHtKW3qPI+DQFVw7PDc=;
 b=VIASi19XuNudOR29QMls0jC795wdWtLNI2ZhLkWWi9NaTTS2tTCaQ2qmNNDndP5AdtrpR4pVEIeSKWpnVx4poP6eHnSUTjoJKnnTgpXZCFBSSOigN3la+idfarOShjS1oQUzxDdBHlVEjaeX7IRL2/pqZ0M0Dae1ecO6Kjpfl00l2n9H333HmB8HK2UTymUQ8yffl5p09IIU22wlDNxlbYADnPoJ7ztEcJC4CFbM3l2YRBVvLg+22R7fAMAmoaZUPJsHl1jMJIO7pMHwhweFC5yXIZtFGdsIJb6hiAsPscwAjOz6dBvx9tUdrFGFnVtm6I7ZZxlVr+3y6wl0NM8JEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spZ5GRTncB1F0sUzJg6kf7lsXHtKW3qPI+DQFVw7PDc=;
 b=n7JtW6QNuVPoStuTuzcAob3PujHKl/Ho5iMij1qWFu85jNWfnxDB0zuH4P19ODJCJOo14rR9W4IoQ63YZE69abyCKEL4hdyhdLFZ9TQi1XbqYpmz3Nfp4kA7fi4X4nnfWAhtMYxKYtCR2k1icOiV0brSVBp4ptHiphJOcJjr/IFUPCjQj4hctgahCR5dPKLEH9Mxm7/JgaRZv9g1X+wu9GxW6HVXYazrJYTM0hqSjiF5aap327nMWwLJiAAbISgZu8ixNkiWjcWz0Th25nI4tdiu/OQ/y59nuaZzedgfauz6ChecYUzlP0s27rQgmOj1lkLxD7S1FcNtzyA97TtOzQ==
Received: from BLAPR03CA0126.namprd03.prod.outlook.com (2603:10b6:208:32e::11)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:08:06 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::8a) by BLAPR03CA0126.outlook.office365.com
 (2603:10b6:208:32e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:44 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:44 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:42 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 06/12] virtio_net: Create a FF group for ethtool steering
Date: Wed, 21 Jan 2026 16:06:46 -0600
Message-ID: <20260121220652.894364-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: debd8db6-5676-4db0-fb01-08de59398e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7B1DtCCKiYLyqA/MG63MkUhZzLD9b42diJM9q0+AD3OjPRrU4LWmpvymdOV?=
 =?us-ascii?Q?2ILzpuJWvkjM8QZKUnwnWOQ+A5+KaJpBQh578da91GdFWz5dKJUQwAQoct0v?=
 =?us-ascii?Q?aH7SA9vGyEPKWFfoddPwkm+PJSvphlcLBexL33Z31tXqJqIAc+UXFVTH6Bz7?=
 =?us-ascii?Q?hHv38qakmE4+SH1538c3GS0O5aiJtlj+bb0imQ8rtv7NMzqG4gJrJzl6mSLS?=
 =?us-ascii?Q?4oe0s5eXDYoWhYo4SFhjCKeavsB8BJOJr4LGPjsxOqrcXvdoMBuOpYyR8rlS?=
 =?us-ascii?Q?nhJTW8V/kr012OA2G420fv3zJC+fqJnW3ZPUi9mwuWjtn8Hf08VEGMTaNjvH?=
 =?us-ascii?Q?b6t9s5w1fafgaLoX7IpNZP1FdOGoPi1bolB9PpGczuHJMQzy5OtWfNEXL1Ks?=
 =?us-ascii?Q?cmuOswCj67c64/8vPw4Oixv4QaNDeIH++QAc1+Y7MlqN2iu0wyS0VdH9XMfX?=
 =?us-ascii?Q?/nZuwT4hvfeMqBe2gSsEwksov0WatJNel9AwWuy4vMrRcTRBtLzY/qDevg3N?=
 =?us-ascii?Q?KBAecWeCD7FGI74op4+GaiRpp63pCLL+AZqx2nn9vGY53g67ctNE+ensn/tP?=
 =?us-ascii?Q?eYHR9QsFXHvD16czAdD56JqmIpdno3gpuIIqxHLiBRF62e5Jh0x8Jkgbwlc/?=
 =?us-ascii?Q?QCv0vjDI8wOjJwyN+fOHvOCScMiowLqMriBsohSo/0W9iiw/PdY+D9yYQdHX?=
 =?us-ascii?Q?WzZN7iZZpIqXOOb8nmQCS7f6XV3CkWEF17NXrPickxNy3dkOCOlKbnmiuJu/?=
 =?us-ascii?Q?nDUcJ1FWbKSab26kRfy58xf40LyHhXvzbO0+wv/rt48vggKAtjHNuFRTRQOC?=
 =?us-ascii?Q?TO7N5v07GXHUYbgnFD/ctDegGJetRmnIfgzuJvRN3aYUjiXmTLRaGBxnq4uC?=
 =?us-ascii?Q?EC4Y0idzAB2Y1xaq6FlLT0YiBUx+63t8kJM2sYVK+CnapxOINXzcBPgYZivI?=
 =?us-ascii?Q?dnvz6LkvYw6TaAuxSMeOMavMGEWi7pf3fD8/GSy6Zh3F0uZZAAV/D7gwCQqT?=
 =?us-ascii?Q?MIO8a8eySemX5pkaoYvZ+7SqwLOdqOPANUQQMy8lT+qdmB4SFMv3xquwAL8X?=
 =?us-ascii?Q?DXlxzJCeu8nhuiVfc/m2pij4FTYbBTm+yEY4wjJ7MEyNJzwZ1UsoxR64nTWm?=
 =?us-ascii?Q?fpzLqwrClx+Y5hCfbLuAY4nW2zZUlWDu1FBCWjaNKBylh768oxGC18652lLB?=
 =?us-ascii?Q?SKGFSjrbgblDQ9KuMJ3EygKcl8Xc/e6L5N7CnaqDrItdFKQTx2LXwXOkgC6U?=
 =?us-ascii?Q?gaif0m/qb3amC981ksAyuRVJSAhPU4l+cM7MbSpSLiQNE4MUwu9tO9R47WhC?=
 =?us-ascii?Q?uPBpj9NuO4CPIhL3u982HA7hQCV8+unsLvoYxrrII/x5cCGcT6Fi+bX8ZgBn?=
 =?us-ascii?Q?euZXdO1B0Npinbh8CVpD5XT80/dF4cLTuhY4xXHuYjjdC5lNmIin1a5PdTP5?=
 =?us-ascii?Q?nlyP7vAJSyys8S6sq1FHb3+HdEzLJtoXFWldy2fnzBo5ti54oHWYm+gzF1Ss?=
 =?us-ascii?Q?bEbng27W6BcLTuZB+CYRn4u5v+XxyF1cJaIiexX8r9ssXmkLErYHIpNaRQbx?=
 =?us-ascii?Q?gM3qoGfOYYCnpeSh6UjS0fZpna/NOusmHfXlNUC4KPuNbB9ytYuncr0f78cF?=
 =?us-ascii?Q?xR8Gd+R6K+FS2rPb8SyzxLjEfffWRwHLlRiBD2BqPEOSQYlBjJvJK/+7O09r?=
 =?us-ascii?Q?ZEoRSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:06.2852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: debd8db6-5676-4db0-fb01-08de59398e11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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
	TAGGED_FROM(0.00)[bounces-252079-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a01:60a::1994:3:14:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[216.228.117.160:received,10.129.68.7:received,2603:10b6:208:32e::11:received,2603:10b6:208:32e:cafe::8a:received];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	DNSWL_BLOCKED(0.00)[10.127.8.14:received,52.25.139.140:received,10.129.68.7:received,216.228.117.160:received,2a01:60a::1994:3:14:from,40.93.194.51:received,10.129.68.6:received,2603:10b6:208:32e:cafe::8a:received,2603:10b6:208:32e::11:received];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 290425E8DF
X-Rspamd-Action: no action

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Documented UAPI
---
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 03bd3d2c2b0e..b406f5f1c75e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -5724,6 +5727,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5808,6 +5812,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_admin_cap_set(vdev,
 				   VIRTIO_NET_FF_RESOURCE_CAP,
 				   ff->ff_caps,
@@ -5854,6 +5864,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_admin_obj_create(vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &ethtool_group,
+				      sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5881,6 +5904,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index d025e252ee26..66af9ecdb674 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -11,6 +11,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -87,4 +89,17 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[];
 };
+
+/**
+ * struct virtio_net_resource_obj_ff_group - Flow filter group object
+ * @group_priority: priority of the group used to order evaluation
+ *
+ * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
+ * administrative object. Devices use @group_priority to order flow filter
+ * groups. Multi-byte fields are little-endian.
+ */
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.50.1


