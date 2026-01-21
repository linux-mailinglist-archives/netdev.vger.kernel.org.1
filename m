Return-Path: <netdev+bounces-252085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC5KI0ZPcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:12:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2A5E925
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D835728A4E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087543635C;
	Wed, 21 Jan 2026 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uQWk6c8k"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8343D4EE
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033304; cv=fail; b=B3QxNdtmxMLrNEyYKRwFKj8XqmRkYxrIIRbZYaEkNfTXcNDzamQH8q6LW1+K6sHAcisTq7/reHO4KLIblBmICkcuVQCwPbhpb+1GU8j/d3DmQ7bIWknmjpjnFOq2+CfbluX9D0XdVfNI8Lgm7pWIo9VuF4CnQDmAmMokPgwA8gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033304; c=relaxed/simple;
	bh=RYl2f6QrH9PGKVv7ZUmWepGphrXo+X8bLv3FkH43t5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBOxiPf94eFzxW3IuFgNYUIQ6M0tjdqJw2G185LNzxKYzu7D+4wdJpf7fiwVs9ffz1mk+X/xfEGFQ723fqTeRPFDJ36/dwNUvvecRX/Ms+uPcaX1IZ6lLltSc64bpGuZMBZFDJJXwJA6nRQbu9B8ptX5nhHbRmK+YbItkCICZf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uQWk6c8k; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGvV7I/MEXApsWTmNxGmn8qW2rWVWz2cUPQTlaBaTACmVsQRDLCpn707CiwJMeJaRY2KN1rZCV9AZ0gp8IZbZMcZjOfBNNlPucbC03xtW4IEzLHA3IwkCWwWm9Kjoywu8iao0AjWCRZIYT37pF1SJQZD+GSjH/Yv7zie4Zhg2a5OKnao+vOsP73j0KHKXUoSBlr/kjObDc325fnbg5rS4zfanKnVMjWn1H54ZZXun3z7RrhHgksz2xFE/ffKWxrbbSuy5MMi8YZZqQdo1stv3nI3JOkoVrt8BEnboY0QVV/dJuWJGTXwEI7cMKAP8Z30X5FU3CyUliQx+MSbpjPY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv9anq11yAhF7FBpvX4nToAiZX3t1Dnr71mH2sK/pUM=;
 b=jQrY+sCKM2Vnqrj4UVuS8qLHAo5Nc+pOiZWCc58mT015kad2yNeoq11GVTM5VEIlZQDvMHxdsggVmzeWSyk+TIkqLTr0zWISXUTcgSj62KAM2KO4qOCC5KMVc5eorwyhqEQ+i3um1NumFhGrPqMUGKwmHKKE2qooCfDAU0rybK+mceLR/VSUebOnoILOsBh3e2V3He1boskJlUzBv+t9szGdPlvPUopI0bgHegumSTH4rLV048jdsKLexnEVP7VQiXM1xWeN2UYiYbKRSjOsQuFdJNl6YBq+kmiH7MQSfrVM0NgsRQUBWfSuzgmKPqLe5UeddogTbjgpeTBs2GytOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv9anq11yAhF7FBpvX4nToAiZX3t1Dnr71mH2sK/pUM=;
 b=uQWk6c8kPuoqnuoHLj2FnM/gJtPId9INTmW2zqmEKIMQzsm91yFY8VZxZtxCdBc+Rsxhdh3Kp1EGr5LAjROk3N2TjcI6Q2z1PGmh5p1DsfpPxas+7Y8tAolrTKejwxFBVn4BOKR5AyzVi2dKjESBKixpvr8ec6f9ALsl1POQ2sp+sFULltmiti74TlFAx7X2zw7zsNVH976HAPEPjmKhpzWSRa0pHte0uD4CtlfwqTwnFJjsWiieLuEShUw3boSiID8+/+iYcEZi+smoTt6Qj/QhbKCTVwaBLldKZTdHajTW5Yz1DAv92so84LkegAIH9O+ZrZivQFkwdmCKs1jzIA==
Received: from BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:08:14 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:207:3c:cafe::ac) by BL0PR02CA0026.outlook.office365.com
 (2603:10b6:207:3c::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:47 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:46 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:44 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 07/12] virtio_net: Implement layer 2 ethtool flow rules
Date: Wed, 21 Jan 2026 16:06:47 -0600
Message-ID: <20260121220652.894364-8-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8d2795-5735-4d53-aeb2-08de59399171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FtBp3IvyZxw/Itkw/EvoxX8vTEc64c+UAzRHhKGr2Lmd9n5bImFHyHgTg1q2?=
 =?us-ascii?Q?01pxrddgcS1CRjYiN51uYOiBP3uE1f4VYNaD6eEUZcYh+y9Hap7OaU2bgcPh?=
 =?us-ascii?Q?vlG7Ntx8hMBgiTML3/AmD3xOaKnbfBd+OjHz+rOYQ80qweC3NXENRc7hbV+H?=
 =?us-ascii?Q?rMPtvByrzfTcX0n6Pb69w+y6Ep1kC8tov+IALiY0AhjS8TuZ/jmb9Wr7hjZw?=
 =?us-ascii?Q?tPuU+gIGn6hpRToFTGhm8znwn+yQUowj3G9ygsCMT+3fyy9PPMcb3T0Bu1lp?=
 =?us-ascii?Q?FNLKZHMmi5w3EDiE1as7GuPI8YybpUNbbG6z4H8SR+o/pGzv8RdNDUAbclzv?=
 =?us-ascii?Q?BO11kEaiWgE8IRFigHe3REFlrv+td+iJchj0Sf2V2Cl/fr604mZNKfcQ8JSy?=
 =?us-ascii?Q?tlBKuHdFI1JjV/YD4PAawCyt4pMo8LzbzBBY81hGPc4+hVFcHD2xzTTIT+nD?=
 =?us-ascii?Q?/dn089blQTUKV6axpSFAiy1ULyGnw3B8n4kv9JIc9+X2mTCBjnnS2EVhl1mP?=
 =?us-ascii?Q?XJp5rwygmUrsb+CDdLkqxSsDp0GAHASYUNeMxGHGCrxhTYSJmvjie4TT1XbB?=
 =?us-ascii?Q?AqKN+gt+FNpeUET5IeW/c7UL7ew9qjCkG9EkUro/DIG1ij200jKbGjyzQmj+?=
 =?us-ascii?Q?ZFp+PeSoDA6hREkRkLDN66d9zkKkPLow63adXcj8DBIKdIBZkl3HtbthrbaF?=
 =?us-ascii?Q?nXoMd+uyKRd3YYLJfDj5brcufI2avxZzrh3yQ13CEaS6ba3Ov0CKjATDLflD?=
 =?us-ascii?Q?dwbwqw9BegxToTd7pVxvrGiV12bkIw5lDZ1CsvCS1Zeq5XOuUpJJ6djgKCph?=
 =?us-ascii?Q?VZ7k19oH7c6jr59JuyE6y9lyuH4wE3JFa3fCZlPBl+fcAfe8/EQBLczhvWxm?=
 =?us-ascii?Q?znZsVCivtwc6CwcpvLf0eAgCXicR7451LlRfZHZevDXHps77SeZPXqPmHPYp?=
 =?us-ascii?Q?8ps5B2hfY6gTjMdaRkUiHcGaB5y55VzdaCkwJUQnCFx6o5ds7nzA97O01nPP?=
 =?us-ascii?Q?46Qq+vqLmyWjMDoeo+d8F+PDEB1xF6S9eSVO2058I4kH9rorm8mqHqQZfQOP?=
 =?us-ascii?Q?DgH75Am1Unm6I7fiGCzJeieZNecon3GJycAvqUvrJG+zEFB1yCwF9vyzqKLO?=
 =?us-ascii?Q?cKYmZFIbhfJ8uIgRNaVowfem+7MY0V3dtBGep22x737g0eAvi/BUDPA4EoO3?=
 =?us-ascii?Q?+sbP+rJaqGOjFCwg5b3PMaWzzV9S2w2hudysjao1XVBcnXEzwpqMa1IUTe6a?=
 =?us-ascii?Q?fnWdtGYGkjZ/VIuCV/VfQ4W90owJqA2gaXUW76+bMFD3gJz3wRJjaGZxKGiV?=
 =?us-ascii?Q?A2rMCyUgVkpmCIFNyzJngOyuLvvTC67pfGJ9LsZefVh1i/7Pun5DjxRLafhP?=
 =?us-ascii?Q?cVIbnbJjy26rFRTolKzmHhkNG2X3Vyd3n0Vy7oxgUAQ8E7rZEJf3snG+OOZG?=
 =?us-ascii?Q?V+Xw0tdfKn577GqK8XPZ0R4sc2upK3YkJNZ+t5J/WuyGdAP/uYfF3PyOh3ov?=
 =?us-ascii?Q?3kupJiEg7xehUGg6mY3joWVNwo6/PILebf88iWrpqz6psGGNj4xUUYa+qGGB?=
 =?us-ascii?Q?+VLdfoZ5x8/Vtm4gjQMrOXwyGo5grluP4yenNhz5YNFElvso4CY9XtKOMct/?=
 =?us-ascii?Q?Tp9ab3niIJcJosgeUjo20gBV0i0kHuKncilU8qiQx/5OSAIsaTyyh+9OGOE7?=
 =?us-ascii?Q?xcR6Lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:11.9514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8d2795-5735-4d53-aeb2-08de59399171
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
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
	TAGGED_FROM(0.00)[bounces-252085-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[213.196.21.55:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.127.8.14:received,10.129.68.6:received,52.25.139.140:received,216.228.117.161:received,2603:10b6:207:3c:cafe::ac:received,2603:10b6:207:3c::39:received];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[213.196.21.55:from];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4DB2A5E925
X-Rspamd-Action: no action

Filtering a flow requires a classifier to match the packets, and a rule
to filter on the matches.

A classifier consists of one or more selectors. There is one selector
per header type. A selector must only use fields set in the selector
capability. If partial matching is supported, the classifier mask for a
particular field can be a subset of the mask for that field in the
capability.

The rule consists of a priority, an action and a key. The key is a byte
array containing headers corresponding to the selectors in the
classifier.

This patch implements ethtool rules for ethernet headers.

Example:
$ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
Added rule with ID 1

The rule in the example directs received packets with the specified
destination MAC address to rq 30.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed double free bug in error flows
    - Build bug on for classifier struct ordering.
    - (u8 *) to (void *) casting.
    - Documentation in UAPI
    - Answered questions about overflow with no changes.
v6:
    - Fix sparse warning "array of flexible structures" Jakub K/Simon H
v7:
    - Move for (int i -> for (i hunk from next patch. Paolo Abeni

v12:
    - Make key_size u8. MST
    - Free key in insert_rule when it's successful. MST
---
---
 drivers/net/virtio_net.c           | 464 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h |  50 ++++
 2 files changed, 514 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b406f5f1c75e..e3f2a7e0e99f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,7 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <linux/xarray.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -286,6 +287,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ethtool_ff {
+	struct xarray rules;
+	int    num_rules;
+};
+
 #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
 #define VIRTNET_FF_MAX_GROUPS 1
 
@@ -295,8 +301,16 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_data *ff_caps;
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
+	struct xarray classifiers;
+	int num_classifiers;
+	struct virtnet_ethtool_ff ethtool;
 };
 
+static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				       struct ethtool_rx_flow_spec *fs,
+				       u16 curr_queue_pairs);
+static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -5579,6 +5593,21 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
+						   vi->curr_queue_pairs);
+	case ETHTOOL_SRXCLSRLDEL:
+		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
 		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -5605,6 +5634,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
@@ -5702,6 +5732,429 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
 };
 
+struct virtnet_ethtool_rule {
+	struct ethtool_rx_flow_spec flow_spec;
+	u32 classifier_id;
+};
+
+/* The classifier struct must be the last field in this struct */
+struct virtnet_classifier {
+	size_t size;
+	u32 id;
+	struct virtio_net_resource_obj_ff_classifier classifier;
+};
+
+static_assert(sizeof(struct virtnet_classifier) ==
+	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+		    __alignof__(struct virtnet_classifier)),
+	      "virtnet_classifier: classifier must be the last member");
+
+static bool check_mask_vs_cap(const void *m, const void *c,
+			      u16 len, bool partial)
+{
+	const u8 *mask = m;
+	const u8 *cap = c;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (partial && ((mask[i] & cap[i]) != mask[i]))
+			return false;
+		if (!partial && mask[i] != cap[i])
+			return false;
+	}
+
+	return true;
+}
+
+static
+struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
+						u8 selector_type)
+{
+	struct virtio_net_ff_selector *sel;
+	void *buf;
+	int i;
+
+	buf = &ff->ff_mask->selectors;
+	sel = buf;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->type == selector_type)
+			return sel;
+
+		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = buf;
+	}
+
+	return NULL;
+}
+
+static bool validate_eth_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ethhdr *cap, *mask;
+	struct ethhdr zeros = {};
+
+	cap = (struct ethhdr *)&sel_cap->mask;
+	mask = (struct ethhdr *)&sel->mask;
+
+	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
+	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
+			       sizeof(mask->h_dest), partial_mask))
+		return false;
+
+	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
+	    !check_mask_vs_cap(mask->h_source, cap->h_source,
+			       sizeof(mask->h_source), partial_mask))
+		return false;
+
+	if (mask->h_proto &&
+	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
+			       sizeof(__be16), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_mask(const struct virtnet_ff *ff,
+			  const struct virtio_net_ff_selector *sel)
+{
+	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
+
+	if (!sel_cap)
+		return false;
+
+	switch (sel->type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return validate_eth_mask(ff, sel, sel_cap);
+	}
+
+	return false;
+}
+
+static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+{
+	int err;
+
+	err = xa_alloc(&ff->classifiers, &c->id, c,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		return err;
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+				      c->id,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &c->classifier,
+				      c->size);
+	if (err)
+		goto err_xarray;
+
+	return 0;
+
+err_xarray:
+	xa_erase(&ff->classifiers, c->id);
+
+	return err;
+}
+
+static void destroy_classifier(struct virtnet_ff *ff,
+			       u32 classifier_id)
+{
+	struct virtnet_classifier *c;
+
+	c = xa_load(&ff->classifiers, classifier_id);
+	if (c) {
+		virtio_admin_obj_destroy(ff->vdev,
+					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					 c->id,
+					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+					 0);
+
+		xa_erase(&ff->classifiers, c->id);
+		kfree(c);
+	}
+}
+
+static void destroy_ethtool_rule(struct virtnet_ff *ff,
+				 struct virtnet_ethtool_rule *eth_rule)
+{
+	ff->ethtool.num_rules--;
+
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				 eth_rule->flow_spec.location,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+	destroy_classifier(ff, eth_rule->classifier_id);
+	kfree(eth_rule);
+}
+
+static int insert_rule(struct virtnet_ff *ff,
+		       struct virtnet_ethtool_rule *eth_rule,
+		       u32 classifier_id,
+		       const u8 *key,
+		       u8 key_size)
+{
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_resource_obj_ff_rule *ff_rule;
+	int err;
+
+	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
+	if (!ff_rule)
+		return -ENOMEM;
+
+	/* Intentionally leave the priority as 0. All rules have the same
+	 * priority.
+	 */
+	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+	ff_rule->classifier_id = cpu_to_le32(classifier_id);
+	ff_rule->key_length = key_size;
+	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
+					     VIRTIO_NET_FF_ACTION_DROP :
+					     VIRTIO_NET_FF_ACTION_RX_VQ;
+	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
+					       cpu_to_le16(fs->ring_cookie) : 0;
+	memcpy(&ff_rule->keys, key, key_size);
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				      fs->location,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      ff_rule,
+				      sizeof(*ff_rule) + key_size);
+	if (err)
+		goto err_ff_rule;
+
+	eth_rule->classifier_id = classifier_id;
+	ff->ethtool.num_rules++;
+	kfree(ff_rule);
+	kfree(key);
+
+	return 0;
+
+err_ff_rule:
+	kfree(ff_rule);
+
+	return err;
+}
+
+static u32 flow_type_mask(u32 flow_type)
+{
+	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
+}
+
+static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
+{
+	switch (fs->flow_type) {
+	case ETHER_FLOW:
+		return true;
+	}
+
+	return false;
+}
+
+static int validate_flow_input(struct virtnet_ff *ff,
+			       const struct ethtool_rx_flow_spec *fs,
+			       u16 curr_queue_pairs)
+{
+	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
+	if (fs->location != RX_CLS_LOC_ANY)
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    fs->ring_cookie >= curr_queue_pairs)
+		return -EINVAL;
+
+	if (fs->flow_type != flow_type_mask(fs->flow_type))
+		return -EOPNOTSUPP;
+
+	if (!supported_flow_type(fs))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
+				 u8 *key_size, size_t *classifier_size,
+				 int *num_hdrs)
+{
+	*num_hdrs = 1;
+	*key_size = sizeof(struct ethhdr);
+	/*
+	 * The classifier size is the size of the classifier header, a selector
+	 * header for each type of header in the match criteria, and each header
+	 * providing the mask for matching against.
+	 */
+	*classifier_size = *key_size +
+			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
+			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
+}
+
+static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
+				   u8 *key,
+				   const struct ethtool_rx_flow_spec *fs)
+{
+	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
+	struct ethhdr *eth_k = (struct ethhdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
+	selector->length = sizeof(struct ethhdr);
+
+	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+}
+
+static int
+validate_classifier_selectors(struct virtnet_ff *ff,
+			      struct virtio_net_resource_obj_ff_classifier *classifier,
+			      int num_hdrs)
+{
+	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
+	int i;
+
+	for (i = 0; i < num_hdrs; i++) {
+		if (!validate_mask(ff, selector))
+			return -EINVAL;
+
+		selector = (((void *)selector) + sizeof(*selector) +
+					selector->length);
+	}
+
+	return 0;
+}
+
+static int build_and_insert(struct virtnet_ff *ff,
+			    struct virtnet_ethtool_rule *eth_rule)
+{
+	struct virtio_net_resource_obj_ff_classifier *classifier;
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_ff_selector *selector;
+	struct virtnet_classifier *c;
+	size_t classifier_size;
+	int num_hdrs;
+	u8 key_size;
+	u8 *key;
+	int err;
+
+	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
+
+	key = kzalloc(key_size, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	/*
+	 * virtio_net_ff_obj_ff_classifier is already included in the
+	 * classifier_size.
+	 */
+	c = kzalloc(classifier_size +
+		    sizeof(struct virtnet_classifier) -
+		    sizeof(struct virtio_net_resource_obj_ff_classifier),
+		    GFP_KERNEL);
+	if (!c) {
+		kfree(key);
+		return -ENOMEM;
+	}
+
+	c->size = classifier_size;
+	classifier = &c->classifier;
+	classifier->count = num_hdrs;
+	selector = (void *)&classifier->selectors[0];
+
+	setup_eth_hdr_key_mask(selector, key, fs);
+
+	err = validate_classifier_selectors(ff, classifier, num_hdrs);
+	if (err)
+		goto err_key;
+
+	err = setup_classifier(ff, c);
+	if (err)
+		goto err_classifier;
+
+	err = insert_rule(ff, eth_rule, c->id, key, key_size);
+	if (err) {
+		/* destroy_classifier will free the classifier */
+		destroy_classifier(ff, c->id);
+		goto err_key;
+	}
+
+	return 0;
+
+err_classifier:
+	kfree(c);
+err_key:
+	kfree(key);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				       struct ethtool_rx_flow_spec *fs,
+				       u16 curr_queue_pairs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	err = validate_flow_input(ff, fs, curr_queue_pairs);
+	if (err)
+		return err;
+
+	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
+	if (!eth_rule)
+		return -ENOMEM;
+
+	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		goto err_rule;
+
+	eth_rule->flow_spec = *fs;
+
+	err = build_and_insert(ff, eth_rule);
+	if (err)
+		goto err_xa;
+
+	return err;
+
+err_xa:
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+
+err_rule:
+	fs->location = RX_CLS_LOC_ANY;
+	kfree(eth_rule);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, location);
+	if (!eth_rule) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	destroy_ethtool_rule(ff, eth_rule);
+out:
+	return err;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -5877,6 +6330,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
+	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5901,9 +6356,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
 static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 {
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i;
+
 	if (!ff->ff_supported)
 		return;
 
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		destroy_ethtool_rule(ff, eth_rule);
+
+	xa_destroy(&ff->ethtool.rules);
+	xa_destroy(&ff->classifiers);
+
 	virtio_admin_obj_destroy(ff->vdev,
 				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
 				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index 66af9ecdb674..57765ba3516c 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
 #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
+#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
 
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
@@ -102,4 +104,52 @@ struct virtio_net_resource_obj_ff_group {
 	__le16 group_priority;
 };
 
+/**
+ * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
+ * @count: number of selector entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: array of selector descriptors that define match masks
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
+ * Each selector describes a header mask used to match packets
+ * (see struct virtio_net_ff_selector). Selectors appear in the order they are
+ * to be applied.
+ */
+struct virtio_net_resource_obj_ff_classifier {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+
+/**
+ * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
+ * @group_id: identifier of the target flow filter group
+ * @classifier_id: identifier of the classifier referenced by this rule
+ * @rule_priority: relative priority of this rule within the group
+ * @key_length: number of bytes in @keys
+ * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @keys: concatenated key bytes matching the classifier's selectors order
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
+ * @group_id and @classifier_id refer to previously created objects of types
+ * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
+ * respectively. The key bytes are compared against packet headers using the
+ * masks provided by the classifier's selectors. Multi-byte fields are
+ * little-endian.
+ */
+struct virtio_net_resource_obj_ff_rule {
+	__le32 group_id;
+	__le32 classifier_id;
+	__u8 rule_priority;
+	__u8 key_length; /* length of key in bytes */
+	__u8 action;
+	__u8 reserved;
+	__le16 vq_index;
+	__u8 reserved1[2];
+	__u8 keys[];
+};
+
 #endif
-- 
2.50.1


