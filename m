Return-Path: <netdev+bounces-256473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHu0Lgt3gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB6DF45F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4014F30446DD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F2376BC8;
	Tue,  3 Feb 2026 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vv4KUwgj"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFCD37416D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157786; cv=fail; b=kNBJZOsh/lWHH/m9buH0l2RKGZ85wOqVouTiOXVgrb8wFAVXeKcAjYz6rZAVbxdiyYUoS93tz0V+jbOKGzIma859s6h6aI2ightdatNNWWm9/W8DpvckbWC5HbkYMeRCYO+GUO0ivssx9G8EDobRPUMxqfEQiU+5dkOISmda0e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157786; c=relaxed/simple;
	bh=+FrtVUTG0x9V1qUKjOjs4LeMxY7QGdychtyxzWqzKEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n08Dt9jyl1yNpyv/ArK8VnZXg8qHa73xcse/l7OdDejfM55UGswWtgozCMPfowrAMu0PKs8p+3tXpzvomnihXGmlWg/0SCJPBBdDcU/sL+FcX3Q0A0MWWgdAAATGGqzjJtcrkMzaeh+7I17omao59KY0j/+uQ10ZrWW87mOlEY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vv4KUwgj; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga4ED9jsRvLYB1xUHuDAs7+X4eJ5MubJfSlIBDxdi1CW9ES/a0wmVcibU4eXBxosIeaxwweNe+4O9QiBYZ1AQZJ/2o8fvUHX+YclNvHGpkwYQvmOofQXsH9btetdo7GM1mLBcmQ1yuxhfFFKoBRp6inbffbcn1Y42j2WI95/HJHbglI0dZkdk8u4SVLr24FujesJdoGuDus0o37/GYc/V07r61N8remMj7hgIHi4GY+alhdMao35OEMgldG8a2Mbt/VQEDjirktVwsXhB6T2fX3fKAMyZO4Rg//9KeYQxlOKsI1vxiSC4JdppeR5+gcKZQq2pko1mFfSI48jKbkgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKXsToYtlVJyQJxh72m4uHXpcNX0aF0OkedUdR01jQY=;
 b=NsRxFXuIn1VziVSNKHeTMLHEMvGzDFrUlMCrRCMgchNEyewVaQW/7/8QjHq0wtfBBtgZOZ/4STdfCa9LzCICNh/Gz0iz+LhIqFw0a24l7yxnCKbf5OoQ1hGTH4KokBvtjPSfDMMsZctYOay2E8IkpTAIvuMX+qkYrmqIr7NiK0Ki6C5c3CvrVCqu2v36F4BdDpq41nx9DMY1NXJDI3vokDykIthZ8HSjci2E5EFGZ1jfeEGE8UTZDXFwk+tO+R2hwzbb4JA/ctJ5HGwZKl2xvIZN+KktV38xafXCx90BStsj+zWTP0fGdBVMi5fde85A9pUsxvjLJ8RDlKENxEl8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKXsToYtlVJyQJxh72m4uHXpcNX0aF0OkedUdR01jQY=;
 b=Vv4KUwgj/n48X6/gwSyr1UyC2grmoj83RLmN0G8o/c/WOOCn8sZOa2Mwr1T5Rx0OkL9qOIpf6b6ZQPFQBJxCjRzeUi1Nns6b5YeVnBuRmtHoF8rEFaf/YtY8vJCPHPrDy1GupDaMDYuU++7rbz/kGSQ0U6nGm7rcRqpvjeqXRc2OfNU0GVVNL1qSxsQ599+1vnHFXygS86Up6YNT3BXkPxTEhAhQwWHwYWxRYeZfla6OsV5H0e+PHj3mwmkDt2Wjxf5R8jyw+CEkiMfJsbhBj+EJLaWDGVpKbqiRqvP/UE0/dROZReRiDaUPoiMi089cA7UH1pMGEHz/CvsBO7kjFQ==
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:29:37 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::23) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:18 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:17 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:16 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 08/12] virtio_net: Use existing classifier if possible
Date: Tue, 3 Feb 2026 16:28:55 -0600
Message-ID: <20260203222859.4219-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203222859.4219-1-danielj@nvidia.com>
References: <20260203222859.4219-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd8ad34-458d-43de-b018-08de6373b6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yu1/91FqypEyGW7eRPacTgdaxMEqUl8gdbiZAFw5tOeK7eKFSJ6YN+Jf17op?=
 =?us-ascii?Q?2RytbSY6O5NTOE+b3PTdfra/+dLt72/zv5g0gqYG+jky+AaqA3XBf9C97s/R?=
 =?us-ascii?Q?w/0v3Hv2YyBhypdwQEXzPw88KavbNb/TrO37BL25VWEVr+EjuxJADBzgJH0r?=
 =?us-ascii?Q?Y4yzrwO3XQIu/41L1uvh1op6x+/Q+g1ARPQB+JKY0tsgcNok9VuffiZjBJKn?=
 =?us-ascii?Q?xwnOcy52vchVA1FfWCF56Sz42cInKnBdRGZr/8/9wfMJ5gG3qONhv6kWpoBi?=
 =?us-ascii?Q?O+pPGL44TjsOpY4PNgTpzhqXTsShwFbHRPQV7imV9IAjA5H0loLnzCIwQA3S?=
 =?us-ascii?Q?/mj7mz2gwKayJgyl3VoPoHTj4sMJK/bfhSitJ9mofxNPIPC9nMk9/Pd09ZKc?=
 =?us-ascii?Q?qB2hpm+lh7IiOD4UNygPuzquOHKnzHPDpmQ2G+bFde8HFVfLBzhGVnG052O3?=
 =?us-ascii?Q?6/4v4xkUUkBgt9tO3r71+ZSGzia9F+SajqonrB2NXi2nX+LgP/xtunCBualL?=
 =?us-ascii?Q?TnZoTnHEXrb1u8SXmExwOcNhN8cEhGxpMGLLSP48aHY+iU61Ol7I8lpeG91C?=
 =?us-ascii?Q?MpoPH0Y3ypCR6rzWv20cxwq2CVSBkLat7djs7QGPhY4tEtfDtW43HRkqldss?=
 =?us-ascii?Q?G+yhhD8InRPWM0cDk7IJErfz5dYuj55gwNVAUNL5pTojBOCyhp2jvPaWcbM2?=
 =?us-ascii?Q?IgDGlCBNxo5jSu++fCnvUqCbGTTaevlKBHNu3oSHiU3fH59OA9OxVDloknfn?=
 =?us-ascii?Q?Cd6JKo0GIuJNNTXL2/jugkJmMVYMfPGU3Ib0kbOQBvQW9H9K2vZe9K6ksPk1?=
 =?us-ascii?Q?Gc3rdVDiaPKfWq1PRY/5vyg6VvDjc3jLpfsZ77Ld/CRPI/2F0yTUDikiAr2y?=
 =?us-ascii?Q?gnQiRFKdF/BKVkIExtwuTOhtWWaoC0v2wOIofimEYD6A7zonVMgkuvLPRYih?=
 =?us-ascii?Q?XcEBLa48MDYEevQblwYsau/gs/cYfdVvzGC1YvS/sIn6mSSO3nVhqZYCINSO?=
 =?us-ascii?Q?0Z18v68OnoNfqpWAq0c0VSnyXRZk9E3unuYnJX0FzXBUe6HKqZ4e4CLUjw8x?=
 =?us-ascii?Q?e9GkDxgteVYh5SIgTOATtv2GCIsyrBTxJ3kn/glNiSjvvLlM634DSqvxZ+0i?=
 =?us-ascii?Q?XKorMbV+Pi3x7eDQImh+Bf8oxecME26sFXV3YODATif4MYkCQ0zRGG6n9lGY?=
 =?us-ascii?Q?WcywwPbs7n5PDjH/yGGPp4jLrHtZYsSiOlvnKNdhxJIhd3vFlnPwbawa68ku?=
 =?us-ascii?Q?VUl/qJIBIXXJkT+R7RTja/m6vTvDo8T9LmPEnPEmMPtXrrmEq4ftoWf/qMzo?=
 =?us-ascii?Q?KahOOM0UcOEBflLCaly5XfinA1mJGn4NZo4R6oL9TkOlv1mDxGl3jSdc/Bfy?=
 =?us-ascii?Q?ArUsKzCasm4uk0oY6kYNo5TWNug0XqqItbBLCu3d1DnN+zuWgK4AbIBERYQP?=
 =?us-ascii?Q?Zffm6FLBuKdjb2YXw1Y/WyyzCOIGEfXd1SWtrSqsb3oK+BTqhOao/iH7lGVn?=
 =?us-ascii?Q?xHVjatAZGEziH3Hueem9dgnzNRo+AnO20JTFwKs5Xs3UYYywo5BwbuUs6HB6?=
 =?us-ascii?Q?wJ7iS8xY1hTDu3VN7MUatQCzkkvv7Vyj5inKeK/f1SJD6ndUrJG5UXeygPRA?=
 =?us-ascii?Q?jx68xd+SeX6uKpU4lD8qaMqJ3iyRiJFRWQF9XC5AmKwLFnyl/FnBk80X41R1?=
 =?us-ascii?Q?sNpQrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rz7mVXNVXbiJ5ws1tpFVNvA2lvkRLPwAeyf7C5krwoZ/DY64svzH3mAkAqm5/IT9VX1C0F8zJOSeDy0ZU+wgRwebpuH/xIRm3wi0tIGpXYJuSWnmQTdDGQRY/i5FhRRIbJm1th+kQ3LEfSEXMlciBiJTcMwWbtsCeHR5IQqxJJ+kh/fTw78G1U+1tZOnFLOnnqpY4m1p+wfeW0zWDz3uVHEP9x2l/K9UvvNuQuwQFWGqYIfSuN4X8TeaddUwZJVy5YcKobJNjOzpBeKHNUWqht7poOe0jsuaydpHor7Iv8hOHShsEt7iMj+0z6I5Gen0JyY7TjhJdW4xW17tMUZGKrW9SyKfbz2Z2kbdRTeQmawhRsooUHfudNIPBZcWWOvUPK+JZ/BSMSM+UpcplLgu5Af4q6G9P2GBst7BxCnSz68vM+LyaLk/mZbznNfRMHx6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:37.3408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd8ad34-458d-43de-b018-08de6373b6f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256473-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 57DB6DF45F
X-Rspamd-Action: no action

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artifically limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed typo in commit message
    - for (int -> for (

v8:
    - Removed unused num_classifiers. Jason Wang

v12:
    - Clarified comment about destroy_classifier freeing. MST
    - Renamed the classifier field of virtnet_classifier to obj. MST
    - Explained why in commit message. MST

v13:
    - Fixed comment about try_destroy_classifier. MST
---
---
 drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 27833ba1abee..5cbf26d8f7ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -302,7 +303,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -5740,12 +5740,13 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
-	struct virtio_net_resource_obj_ff_classifier classifier;
+	struct virtio_net_resource_obj_ff_classifier obj;
 };
 
 static_assert(sizeof(struct virtnet_classifier) ==
-	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+	      ALIGN(offsetofend(struct virtnet_classifier, obj),
 		    __alignof__(struct virtnet_classifier)),
 	      "virtnet_classifier: classifier must be the last member");
 
@@ -5833,11 +5834,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	return false;
 }
 
-static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+static int setup_classifier(struct virtnet_ff *ff,
+			    struct virtnet_classifier **c)
 {
+	struct virtnet_classifier *tmp;
+	unsigned long i;
 	int err;
 
-	err = xa_alloc(&ff->classifiers, &c->id, c,
+	xa_for_each(&ff->classifiers, i, tmp) {
+		if ((*c)->size == tmp->size &&
+		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
+			refcount_inc(&tmp->refcount);
+			kfree(*c);
+			*c = tmp;
+			goto out;
+		}
+	}
+
+	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
 		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
 		       GFP_KERNEL);
 	if (err)
@@ -5845,29 +5859,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->obj,
+				      (*c)->size);
 	if (err)
 		goto err_xarray;
 
+	refcount_set(&(*c)->refcount, 1);
+out:
 	return 0;
 
 err_xarray:
-	xa_erase(&ff->classifiers, c->id);
+	xa_erase(&ff->classifiers, (*c)->id);
 
 	return err;
 }
 
-static void destroy_classifier(struct virtnet_ff *ff,
-			       u32 classifier_id)
+static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
 {
 	struct virtnet_classifier *c;
 
 	c = xa_load(&ff->classifiers, classifier_id);
-	if (c) {
+	if (c && refcount_dec_and_test(&c->refcount)) {
 		virtio_admin_obj_destroy(ff->vdev,
 					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					 c->id,
@@ -5891,7 +5906,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6063,7 +6078,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6073,14 +6088,16 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_classifier;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		/* try_destroy_classifier will decrement the refcount on the
+		 * classifier and free it if needed.
+		 */
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


