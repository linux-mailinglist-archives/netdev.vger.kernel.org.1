Return-Path: <netdev+bounces-257352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mArYB1UehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA960F833F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DC3C303467E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9353339B34;
	Thu,  5 Feb 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kV66OqGM"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EF337BB2
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331661; cv=fail; b=NVy6gmerKKUUaoWOvpCA8f2D2U62osuSK5RrDTB1GxUDB5UvX8SLIbPt8dRXKfRpV/YJtwX3WjcFxNfRxzjBQ4F1AKvqfQgK5oDtD5yUCzBw0+DWw18gaOAWQnEYxYDKWrvcVSQwsANAyddlhuyP0zY9Loa6IRZTlO9g9ZG2D74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331661; c=relaxed/simple;
	bh=Scy2d/NpPRHTdtNC0fIWWtFow5lRM9uDcWZ0PAn9DNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQuYUb/2W+WX5Wkj60rctVKAKfyzgYH/vq2iydvco1C9Y40jSorf/nrYQVOgXhhZkZhEHfjEyLmEfaG/P4awVk8NXzjoSCHoNbVuRgBwuQo4/wYphfIX9wVvWGnQA4SYT6zS/hyKxPlGVXnNUbNOi2MffIybvEt9B1m+vpDpuYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kV66OqGM; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmSRyi9dnceaCxIU3hd6HSQETYogOSlv9xK6byf+xTR6oAF12BG5hLEaU0q2S158Eq7+f9ESFveF2oj2jhDk5lOAQ28XzE4W243VPwCmMwsU4z9nYCY6BaUtv52e/ZN/+ECvod+xtsGG5kr+lyEwyUiR1nHj9YZeRhxqYSlHi2RpoWNtRk9iKjNNlcxaDT+NGR6B//MlrPXvjc/R44ipZ9gXAVlxn1kyY/oOUiGbwh+ze8Z7KnvOZ0ciTYTPwTCVah8zsMApdRXVkF3nUZa2fi5FyeS+A+W1s17tzMDQQNK5f3p8aVOfhIcX5DqnPm+S/jFYy56rl2/l/XKInC3EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2XDxsKDPu50AmTcKJCAdyppWfJ3WwTtp+F0i26S4T0=;
 b=lmw//ks2uyYxic2DcnrYZ6/yPGJcqNo1BFIS4PyN7oDdxuPQ7/IsL5jT/lztn/MFLOcWgecZtOWGSk/b3zknX42f+3SQmUKaqlqi6bFyZp34ls/GmNJb0JG9S1J8+p2PSH7RM0pYE9BywPWeS13x7OeCc/lYHW7BUPz0zi6TWn1j/7ypgz0ZBFFastDXgizdKGpbWJAnLiJZuPbfdzDAckeoy+fKm3dV8uziyLEWQIsD7u7/XYNq4MRYn0ggsrlt9ksmWroirZO4S4GZizr/igvRTlZlVdnW5t3MkuDtcg0qzTS6qcjWl+SFG2vZF2Ze5QCcLoyXr9Ydgc7bMfc8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2XDxsKDPu50AmTcKJCAdyppWfJ3WwTtp+F0i26S4T0=;
 b=kV66OqGMF7TFNKZQ4PyfRq4tavqj/9cRpugZc6LTLXlIBNEhfNzxzno4tqN3I9xCwicL7ZiMTf8jI70jVYZq6o6YaBpLPjTFSaPqf/u5VfO3k+mx2hPphnMXZQ3l5XayrjekQCeh/s0wBQJWlw4e0W24+9TdYj074sK8KmKjYTV7yrv8BOcpnUex/BpB6piD5TobCvaRB+srjNd7kiE2TRpnvQJZBVEVZ85i4Z//BOlHbNJmW9uhqRQy4014cG+9tiTz48NuLPtAy99/45LqzbwXVJrPTRQGmadAJ+NK31SR29YAmuj9NmcWWoG8RNP7dOYYLQQqcRfdIOzi+7+1kw==
Received: from SJ0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:a03:39e::19)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 22:47:36 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::fc) by SJ0PR03CA0284.outlook.office365.com
 (2603:10b6:a03:39e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 22:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:22 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:21 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 06/12] virtio_net: Create a FF group for ethtool steering
Date: Thu, 5 Feb 2026 16:47:01 -0600
Message-ID: <20260205224707.16995-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a6ba79-a395-412d-2fb2-08de65088efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9TCaq6qFMwmfX7APlSoNXNH8YI4+YGYyN5PVxxdRUnqHAiafUvCPMzb3aMS?=
 =?us-ascii?Q?hu1zE71Ca3uyGwH4KpJ2/5JnbrmQ6WGFcZj/qcjmbjgjIxDJi1Ydc9U406/+?=
 =?us-ascii?Q?ZYCq+WUbtRRKHHHw9hNJ0NssmarIgf5Cw8JH6WBu++fNlBRoUBlKal+6GvCz?=
 =?us-ascii?Q?QcvTJLrqI2UeP80BJmOyjNqdDL5lhv87o6eZ9zewMFPyI1xovgNyXr56fgFc?=
 =?us-ascii?Q?8MtprppESbqNlyf51Z96x3Nx9A9waRVwDzllcg2YS2Gd0VDUqWP6mkbVhS1Q?=
 =?us-ascii?Q?qY/g+qrzBYdo3IKDH/aAhnlRAVP8lnYusV/fMG+nH+I8ekpQqDcu+5oRFwyJ?=
 =?us-ascii?Q?rBvz4usP0Mh45Q1WhhtjMsjO5mHGDu5D/zHDs4mthUYLBd1lk8AzzHg8AgER?=
 =?us-ascii?Q?lYmY/uXhMtk3OYkiLt8AYYR7SymVHEgYI15umeB5nvuHwge1awMqkChL74Vo?=
 =?us-ascii?Q?4pcv48LvVs7n5p8Pg+xMg+Zr+rWrLXwmYl5zOGpWjRPkwsl4ZDK39J2ZZJIs?=
 =?us-ascii?Q?d7NFuzkIZsQDiHXrzERJ8gSOhY2qE83q5hrrITZ7KVTqByx9v3M14T23cjye?=
 =?us-ascii?Q?s8UrSWqdrsRVbgToAe8cFFEoIe+ImFSDH/Yw6rxvhG+ff5zAYrd5K9EmXWj2?=
 =?us-ascii?Q?VC3Nt92OdQhwYsdCQLTlA4CFOSL6NXTwJwEdTMtGn3+IXQ6DiJgLK1EE57Da?=
 =?us-ascii?Q?1+qS6IjnUAx/fZqRaMcFeIP5QJo+VpcqNt+GLvYOWPQ1BKLphZMrwiYUJ4dd?=
 =?us-ascii?Q?r51iHMxiU7VLpLcq2eHH7RbRIBgEkm65m/qsqXdJmlkcquv8KmWZaXTeexIG?=
 =?us-ascii?Q?jnP5/R1AnWM05+MkR3agZGGC7chaldWNd82BT5w0apFhvktBE7aOAcgUpeYS?=
 =?us-ascii?Q?PUx1I8Gc4YOAS2vMvLo7Cgl6dJZrjWqrsQBSDVm7JCn8/1uVtFzUA0T7xJ4m?=
 =?us-ascii?Q?OSwBMC2/+T1OAJjAI8agk9drPl5eDq46/1iWmS9hxqoxabSpy3ClhIguhVpr?=
 =?us-ascii?Q?uGiyrmQfAf7J6bcT3rzQDhL9WeUQndw00pulk1Kln55Cdu1iVApek9iQoODe?=
 =?us-ascii?Q?56uIyFviS4yzWt5sfDIxvRE6nqBDS3MZSeZRDVCryOwLhom6TGKv8cF1N7v8?=
 =?us-ascii?Q?ICjzHoSDcRyfuh3VDqR5eTcaJjmq7qReolZAJfVXxXWfGUMz/2j6DbQqKZhW?=
 =?us-ascii?Q?GUnaWVXG6WV3DbsmuD4qVFf5JdaFv2oDTKH7qvmDmrPpHA0ixQXxaz2/yajv?=
 =?us-ascii?Q?QceBm6Ij5B/1tjWlr8tu1vFLt9psB7ECEz1KVWnz2TJsCtN+xw5kUZ5fEw7A?=
 =?us-ascii?Q?vthjOMQCUP7OFPtkJuAIMugC62MAqv5JVawHsx9QNhIhZ1suZ9Emp6J/a2Pc?=
 =?us-ascii?Q?rJ8f2rr9mkI9AkNit81jBdHZfpEL61MK+wAzYJ86UmppDjszPsQGX+kdKInQ?=
 =?us-ascii?Q?lr8lo+5nu9MqFh+rykmZh1hBZoL03JbTbIft5ELXDXcywEYh9g65aGlTeqLI?=
 =?us-ascii?Q?3Id0aCYlQKlJZVGKEQYYBjPRUOB3OtMdgKVPw6q3/cQZgMeYaBDPkdAcKXFP?=
 =?us-ascii?Q?pabworYds78sf4cGdzvnvQLK5h0qk0zBNzKuz/Sk3CL4DXn7OkNcLWr9dJ/M?=
 =?us-ascii?Q?JU9twJ6ycP8S//8+vGTWtzUsmZyL/Xt7hlzr5WAvDb2uTDjfNsMCio1+rYbb?=
 =?us-ascii?Q?zrvVGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tS1fPBKerKcectlCxlsCTfob2g11MuFfnXSDRaAOyM4F5mlLxa5GJy202DEVj/PcZ6siAhaVWUS+3uw9pgkqroLzZd1wikdGDMQ/hneDrEJhZLm/I+CjpQXLSQY8NRO9A2fFUDxp+MgLrhkqLx/ALMunG0yjOOmmO5Jo7oR0o3nZs5UYb1XlF8LBgzjufnwnalhCvUBbTyisELuaF1t+Xdk/mr5bNqZdxLpn36WW8nHLypm7k5CR9BmJSwZpBkwwanJpB9Ih+VGP8Na//LLvi4WjaMzvz4xnr/izoLzXlX0H5BHw59YpMDBEuQHFCVoQQvRWUyrq+MigRpDeb/LAH3ikqpujX7tSNt3sd9GI13I5eONjVipfHoMmSVcUCObLZqDuLmJRM5n+WAotvIrEuCcpR+pJ1VRi17nVPzWTqO/VUtK4crzSE1u8qKVpJFrk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:36.6006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a6ba79-a395-412d-2fb2-08de65088efc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
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
	TAGGED_FROM(0.00)[bounces-257352-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BA960F833F
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
index 2cfa37e2f83f..340104b22a59 100644
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
@@ -5722,6 +5725,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5806,6 +5810,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -5852,6 +5862,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -5879,6 +5902,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
index 552a6b3a8a91..c7d01e3edc80 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[] __counted_by(count);
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


