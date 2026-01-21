Return-Path: <netdev+bounces-252076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKSEE3ZOcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:08:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2325E838
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3225065A0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29103A7821;
	Wed, 21 Jan 2026 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bdJHXolN"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E043DA26
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033287; cv=fail; b=CWDcrFktjbbiOnQ1lu7x5JwSuTye4laMljcTDFVVJpU31uI5z4ou63wSvNcBt8D83NXePTlFesErXVyJyF/zD0PMFiEeyqhEdFDQ2+B4Ma7BQMCpD1O0ed3AQs2vScg5pm9f+zSTseUDDsq8ppceob4l9IR5dRHkfkNTsbqQ+YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033287; c=relaxed/simple;
	bh=rV+BYBScHZrwQo5VCoLAB9GLWd98W0R5QYE8DpXG300=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLTWecSd4Zz3lUPSJRTTIxnJYoDhF6devEk7h70EnHkRt5vldkBBoYDT/u222i0ipaS51MwkG9yrSdi/94SmBQzrTcsUMSmmBJOcDeFTPfmHrDjpKDAOuSiFZtlIgcdqSVShqv9fwsfsFXqOWVTCHLfiexrUktp8X+EY1iTtoow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bdJHXolN; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvTodrgcg0Vg3yLRQeSpROyK88FYq5KDT1MZ3yw+5TRecliqyWw/XfepfglMuzeby5/nQLromaBX7+fy38Y0cjY7R4zh6W+dIPiwuEiHbH6LS6nl86i+3go57tkCvdVc50oSCbDN15GqOtyi093Q9NANmgBXVEvIVt7S79l0vRYKoGOmy1VBno0OVY1/RDmuYz76aPpCzPcGm+XHwhBXucCxZT/4ABDyO7DSA6yYHELfb8li1+fsVO+jKl/2QMrUtaJ2fElwsqpTUF8dCZO3FQr54mTs+zxrjTdMhTjJ/tf9l8qNgxnCWy6xe5GkByDBOw8uFwfEvF509cl6AA4Jfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=XKBW9sfnYRdjz+AOBNIlqBIQeHILttXxsajsC/O3n/d3GnbQrQtPZA0GCWxLvQKnDm39Pb0rsTUVngl+9lRYz+OHsYQTxOs5tas8RkblT1UWihExbKFZIg7sZ8L9IQqtyH09lEQwvaRCPRRQjawqXnkBtphA9qcDKSdht4AMWTu+gNRC/8Ms/jFvt44Wb7wf7uyrd2567glWHUjJkFX9Mn3IE8RYhAdfVAVyLBf1ObEnvJfpQmBRdAMvXLMF3Sdp6y9HuszK8kORBaXLzx1KvyEWLyjE9/TAPZqc9acnsMw5pqlCgBdlV7X06KaxnUdTZX4hPa/Xy9R3QOXmHjfw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=bdJHXolNSb4l1fhzfIZnv5NX9F3ojtSrEvK5ZW/B2x6+dhx8IRVBEuNU58ua+A7u2HhUP21jpiYpZoSDroVxCu8Z23Q17RIqWxzRnlwB7Hdo2QrkPb675ONVYoREA4wvg9h6MasYVQS7FAi+cBI22Q0u/VUE3JEcxc4bw45lvz0KcpTIIFtoAjAPO3IQxrYDHCeckon9gtpaCFxezqK3zgmbNFhsr1Sq+jLNkIsDPE0DAb0EeQMlIueMYP6xvdICvf7wAtaD+uT4TM2Y5HXcEYajORDMXko2cDm/67S0G8LrjBlN2REM4qRiUsQ2Vxh4P4kM88/TBzk9FhUO5Zjs2Q==
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:08:00 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::81) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:36 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:36 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:34 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 02/12] virtio: Add config_op for admin commands
Date: Wed, 21 Jan 2026 16:06:42 -0600
Message-ID: <20260121220652.894364-3-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 28681a4b-0c0f-46f5-e0ec-08de59398ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqvhoeOOdFkNdqHlALqf5bxkiwhcIlVC05gHY2BV7PEU3tlqDQj4IE8shAY1?=
 =?us-ascii?Q?6TL0KlLl68mkw9O38yI6y5KguYtqTjIs/JmBeO2IYFG/dZIqzOPANbSleIvD?=
 =?us-ascii?Q?rB5wczGtFnR4JaHLKKPC/T6VwIh+E1wqZ5jKrKkmIgMmXgQuwUY45ZymMtWO?=
 =?us-ascii?Q?7v24puAmpcwfU1Tf6tO5+1hFZ30Gtuhj2gCNePhbNymX1kUn4QNyAT+5JkX9?=
 =?us-ascii?Q?GmsxpDIBjtQbRFatPmgfwr0R0ha/rGykmG4EmcnW3Xeyyf1Qpn/eps3x5hak?=
 =?us-ascii?Q?3w6h8bh58FzR7KF/z0yBI8n0w2HcvZmH5+KelW3+V/IuY7GEedjYCYBP3NdB?=
 =?us-ascii?Q?TKq9vfL+vw9BemyIVQxaCVBBx6OX4xybYnw7+mWcCh6hpBzLxxlygEtBLvxN?=
 =?us-ascii?Q?gl1IhdUzN/hOB3J1lGwremVAlarWHq6vRdK6o3IYvmPckFaQv36dSZVF9WdZ?=
 =?us-ascii?Q?7ElDENHyyo/FLPkrAhhgXs75g7RF5KgMi+Ef7L/uBHA4z5y1AQFoj+RScEDj?=
 =?us-ascii?Q?8rBVfZM20hQ5S/0rDAjicbY5w9H4TKHUyWVswQ7HuoUfK7gr7CiLsXk/M3LT?=
 =?us-ascii?Q?O/dgs/C/IeBmTxNQlNGjEuO36GSVs1PMnnpJidKkz+gO5+XwGM42ld/gM+0J?=
 =?us-ascii?Q?shpH5Qkw1J4HYguaB/bq6stdgs1hc1OmnvQsMsSyGOSQBydvBdx5Se68v1/i?=
 =?us-ascii?Q?8hsPo1uZcMiyEHENaMUcwkR6UhXHFowSVEO4BqBnlryya2kUcR2bTrhudg3n?=
 =?us-ascii?Q?cbapgji4mQ641fQXuMPEIeR1CEnksWLnKOBqBxXIHY8sunvm23Lq0LbxlZRs?=
 =?us-ascii?Q?DXyQjdd2juGz+KMVi1ut2WMSEyfgwDIxpCOMSO2C1x5CH6kMMsgS1vi+pLHs?=
 =?us-ascii?Q?HNXRAeGTT4GtC5jq1/DUOpFXkj7kGkVO2nAPztjhLsSh7ueeRZreDkOUQni6?=
 =?us-ascii?Q?Wc1YuT2eZvVcm/cyacHYKuAJD3TA3E8Thw2Iy2rKwXHl7jdjKnIrB/ulXwd/?=
 =?us-ascii?Q?Qhcol2YOqX79VHVneGExZnMeEb2wWgGEAuWEHVhfLM6oe+PNZiM8nfs3pj71?=
 =?us-ascii?Q?wreMky9Yv/kDClfG9wfv+7y4n9MQzygP9dggQVYwcenrO0o+wYAC1X6zNCZD?=
 =?us-ascii?Q?ZeTFXbspZfElbslq6xiyNhiPwHnG/rZ6Gvl+6rXpVL6jPp7eZytX6BEWql1K?=
 =?us-ascii?Q?HC8R5UmEuVzirpHrHFpq8q+T/RsjnmKXeNsck3QdEALoZddOVdakpmy8rGQ+?=
 =?us-ascii?Q?S+4GfF8Zi3DC704JWiqPSLXNXKV4Ro6GpOEJCspLvqo2tJMaknvE2EAaCbOA?=
 =?us-ascii?Q?pK0dZEoQAu1p3zGitxfCAsUTBK7diLeOv32buKINl/T2g6bjTyzJPht3pEiB?=
 =?us-ascii?Q?sY39z/HecrUXeJx5LrKACpHsLgEhD+W8OVzYqIOVjAyiWr9j/RkmzM1rnf+5?=
 =?us-ascii?Q?wiRSbte4wRu+YkjLog8iEu1X6I2KumISdf3kMaJS7bIeVOg3Y4/3gQ7PBB5l?=
 =?us-ascii?Q?tS9JhvfPnjiB/qmwkP+NwN1CTV2KGkL+WwUGrvLnzLIBVawvYsicNV1xrXpX?=
 =?us-ascii?Q?Sq6cS6AJGKbwPDfWbTca9dicVTNgerEScf5Wxlpesy/dsQOn0Rl33G4f3prZ?=
 =?us-ascii?Q?Nr1JQd676RcXiuW/XPvrsA58Dy7lrnUKY6pMbjfiRoB3XE818fORb5upQUgi?=
 =?us-ascii?Q?XJeEBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:00.7589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28681a4b-0c0f-46f5-e0ec-08de59398ac6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252076-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,Nvidia.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BD2325E838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4

v12: Add (optional) to admin_cmd_exec field. MST
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 1675d6cda416..e2a813b3b3fd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..e36a32e0a20c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command (optional).
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.50.1


