Return-Path: <netdev+bounces-252081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMMiKRHCcWmdLwAAu9opvQ
	(envelope-from <netdev+bounces-252081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 187DF6238A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64C176A20E2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6243E9F8;
	Wed, 21 Jan 2026 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kcjQix4G"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086043E9D4
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033295; cv=fail; b=g8LiLz+7NQ+M7uwk8dSQdZmt1cCQXCi6wmdaAp/MPORV5Zd8xZjVe7qbkTz1ZVqXzczwC45LUIRM+OHZgujSjf7i1bDcp4g4ZlWYSYeQx5hkOWEd0y/lP2AV5QWmcm/HjHKa3TgVrycMo5Jm2eO4f5BZ3D3DlMd2K8HWtlxkPKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033295; c=relaxed/simple;
	bh=Glr560URxqKTZYR1B/4JTyiFscURg11/WjW/lOK0Ll0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+mypYoU/gLZtOxdzMzzsOnmHU9g7SnHGZyMQLZngcYzbtYL9yCuEfG8mM54Ycz/QjjhYHb8M8FfryrgOkv0YS2B/Gg1O6DixPKupVvCybjdxZjlqYmCHLaq1bBKaotWvKkD3J7aHKC39shxCnBSICFCtVdhvzIhIHar/ABvgPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kcjQix4G; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMKqhAZlD82G6YVz7GJgDUvgH01h9emkiLTieSRGyDCAIfwVHL+HwCT1FwvCbYMsPImaGyU6AuCv8vtGgcnWjHQE/KGEOqwOaFdbXi1vLR9rH+iMfU/NBSKL04Cm3F6IdP51JA8AUU6AQAigpub8ULhkYMS2Xwsb6KiY21bcXZKj9P9exU8bXszEwxkggDiG0+Gx1A/vBJpsZUgkGOO8NRSySVGiHWJEE3bY2X+MUh66OtKKNumLjzBjqze/0mapTsviKmwg2Wbx7gLmA3c/q6X7DeGrR080T860bXwHP7PJ/yD/fU6NOBVUin7mCPI1RPWKzw9ar8d7JAW9gNsp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=ny9lLdHt1XCqaP1asCe85RbtYrMX+F929Ko1MC/QEOUXppkRtQoLj6qlkKcTzPAIQT/AH1E6Q1dUxgtl19NyIIeOVpaL7LU3wSvpHjvK0hZ5sdWlqLNrzyMTkylvX7ukypTWGWvjZkOeygSic0HtFtDxOGQwWitBSJDFsL8OuNDSf70e+ETqi/Y3mVuKoEElA4JxkZ3LBHBzq9XmvCK6vV1kC8O5b4lijvzVtf2ZHijXj0bpRxFIu2IC4Xz+1boVgvgYGsi7hCIbRBm418qwsFEDaQDOq/kr/QR8PkvHmVSQqab9zRiYR0IqL88wfYPl4XuR8Wp9QshCppa1Dx9iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=kcjQix4GHhJb3FlFlECK5zVDmLzIgrZUrdfeMthL6k5DDlTJ9wrHvV1Z/j369qtJUccRmrdKXUUer1PlEDvDRyLvP/SJUg7+tWqh0oFS7SYpzKnhbREE2/pxx2zZHLWvWLkMK7k7PLnCs2h71Xu+ClIAnfIg7xW97ApZ7+kufTI4jxMSZnjeaKjCyDrN+FdhAmGawfpY6gaaV4VcbuavOnUEkLpWJ40zShnH+ElAYF3RfQlaElcBuFnMsoYmjk4te4KORsVYVEUGDwLTClR+toPVZW6r9yKixcTiCh1ehtGsoOc+K4P8RtF5WlonvU5i7Y7OI8wKsVEb1CxxXvYB9Q==
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 21 Jan
 2026 22:08:04 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::b0) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:40 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:38 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 04/12] virtio: Expose object create and destroy API
Date: Wed, 21 Jan 2026 16:06:44 -0600
Message-ID: <20260121220652.894364-5-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccdd836-b55a-4fb3-18b2-08de59398cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6vDbT8SwhJ1mohHR1pxQ+kjmVo9umqsV+Cta+mOTH+8so1vmsikgtZaTugr?=
 =?us-ascii?Q?LrneR9Klh9tiQTcD9i2dvJICCX77OCibFRSoV21feNzibBRezLG5b0+B8YqP?=
 =?us-ascii?Q?5fFHLCs+v02zz+26ZBZQBKwaRNXST4+uwDNfdv3WMQHRKMu7bb3deUHFbFvV?=
 =?us-ascii?Q?ugJ96wJFAEI+m0gVQ+nWu/DfW1ENE4eaif3ZKNvcURK9N5q6oGwUI+geZaMA?=
 =?us-ascii?Q?01hCg4hCyXen4xCy5NF2Fc5Il2YYEb5UpGn0Iv7SqrvHNr4Tq9p3IXGrokLb?=
 =?us-ascii?Q?UMZQ987zNDHm2R9K7wqJJbnUz6LFJTMlGyMUPKttCWTeCVq3g44ovKj+XkI1?=
 =?us-ascii?Q?aSpaq72e4LktGLO8OXgXvgt/6T1Q3o4zu8bbVOg10HXJZxBfoH/Nul6spg/s?=
 =?us-ascii?Q?oUO/WBer8LPW6OwY5+1IYdQ8XZTlamC5x4WxRLWT77EDH3f50o0upauHjUCF?=
 =?us-ascii?Q?/u+EM/eXqNVXtBjPSBI97xdAaue8A+L2XPl4TodLinwLSMzjeiGDyWPImFG9?=
 =?us-ascii?Q?kEjuBcGN7D7/CMJFnPgWYec/shffKyvzr7zWi4mUCji1gfiM6tS8VdCpVLLO?=
 =?us-ascii?Q?7DJRymfLkpuzpXzO5wF8b91uSFRJIUh6cMbsvbFQptbBA7j173/y1oSkg4vM?=
 =?us-ascii?Q?0H0kwo0BD/joFyMJAYw4wn/x2883d98Zqsi6BKvsSb2mdoRK7Vxby9nMZ4NW?=
 =?us-ascii?Q?FlcRwIIBvKjUx6jjUM7VfFezUXqtJNP4VDCtxHV+1yMW6HcpCFHjyaau3lsq?=
 =?us-ascii?Q?Dr9DmKbHwEBJ4k+2nQmVPJCCZ++Jn4ye9FyvSnaOXXuOyrCT/joXyE0gmpKC?=
 =?us-ascii?Q?SMlCMsulf/5vM3Yj3SWHay8D9gyoubo/WoRZ43ghet+i7WN4EZHfG+qLhlS7?=
 =?us-ascii?Q?dtF3Dx+Xa27PN7AOlHch/IdRGxB+db1C0SAsCW6Iamj3ltkOsqxZeCYy8T6K?=
 =?us-ascii?Q?rdNr8leSbnZVClV4a/c+GTPnfjJdf9E6l6QkOPhmCPx4salJblFp3nn3A4zJ?=
 =?us-ascii?Q?ybRqBRpanMQCsBM9kWyvKRuRDFuVGwkpNYenAUkCc1sEI6aLfslNgzbYb9cf?=
 =?us-ascii?Q?Mjioracs/SQ4rftnsrlqgTIerx7MWJWWBLjvlACnL/asS1ZSmuxcfH708/Mo?=
 =?us-ascii?Q?H4rn4PKLd7qPnkl6S1H67xZSShOXF0bW7rSJTL3K3zCSQoLttZPPDPUFb6sF?=
 =?us-ascii?Q?vKNowZDKwtGlckamo9rv9tbm2Dt9T5XMT/8EQBeehu3/QEdUwMmXJI8uuD3P?=
 =?us-ascii?Q?hDXyD4B3fHel1VQvH/RTQw/lhbvJYzHcN9f+GWJd07pIwNQIVz+CmyPmt6uC?=
 =?us-ascii?Q?M6PH0OoZlNzckil3q1S91KVJk4tCjFcuYVqw9VGDrrhDLgAk9IEwo9FojP8M?=
 =?us-ascii?Q?ZYJ0gQlPm3/pgzARZtcPSTJOYIWa6UImtaV9ArcBC8xQ9yHcCgOcZvmW+nwI?=
 =?us-ascii?Q?rpYsyeV/bzsA/3fr4IgErmrMOoy587zNhmFKfPQbtVDiEg5rNVil1hjm5lLw?=
 =?us-ascii?Q?S5trACzpQT0WAOabc1uSjO+mSQs/0ZrqXSIYzU9IUqku9JFlVAHSdSUYVnb6?=
 =?us-ascii?Q?XoLliEjeg8kVxKip0XrXuM2v8EkBBtc3/moRDgYm9pWXEP2LyOcQJxf7UgwO?=
 =?us-ascii?Q?3qF6lo+YuNuzeY+0aWQLvFm0VSD5tRY5g4Jyal1X4I33jGk3U9mgErP9ik/S?=
 =?us-ascii?Q?eKVRjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:04.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccdd836-b55a-4fb3-18b2-08de59398cbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252081-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 187DF6238A
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
index cd000ecfc189..557df1caa85c 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -92,3 +92,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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


