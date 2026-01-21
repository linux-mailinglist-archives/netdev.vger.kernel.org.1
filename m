Return-Path: <netdev+bounces-252083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JThBjZPcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:12:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD185E903
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24703865A4D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536343D509;
	Wed, 21 Jan 2026 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sO2Dso3O"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA33D7D8F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033303; cv=fail; b=c+6TUz7p2Wpct0Qk9Tu3tOhZgeMqsHAXzlNvECcgpM79BQOqnMhYNotmFnzALxL+WbAOYJioWq1Revi/JxREJoXa/XtfB4ehkSPxIN7XxBInVeQP2aj3xAuNWttiXRmTSUV5OXKNbEU8glz+r1YFKJtcQQyGo+1rGUHlHvQMmvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033303; c=relaxed/simple;
	bh=Wa0EgmnDRD82l3IxtZ9cczZ17uCTeWj+wXEpg9A4UL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXaJfa2uwjhjOOUxt3t4D/r/hr0fA2UeI4XDZKm3HB8Vhcgct4HiB3uCJVZ2nJh4eXzBbVwAThCZXWOJihHdEbP2maq1BM5dAi5E8qjwJlWzSjbisfg+oNIVP/S6CEhVxSrWIQTLfXbmZD0qk/ncGms3RNstaN5ltAWLipnt4wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sO2Dso3O; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJzXFv6DEBaqKA+u+nrWCNHNN7gjl7vskxy8z2FfitksJeK/loaCWBU6+uFWR07U+AcFos6mTaOCl3yRdGI3Dq+nxw9AAPmAxjP1vENOS/focYOWN3T7t7awv8j+BfR9Dtx5o4rL5Ua+FO61IE+Fx2STUWF+LiFbZUG2eoPiX6v9wH3HFKrFTEFcuk0dqlaDXQ6loU/yjWF2zsaQLjPMaiG0LiNn0nBtpNv/UbH0MY+kxPY+X2bb6j4T9YYcR+AhPmqeWHbMjqF71Xkytx2wKJFzytZPXfzcxy1yErzjmwFcRBQ4KyjSKW39Abqit5f8eIX+2fePO4QnUxvxciuGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYXmaGv3Z+2sbynld3jDsgs0YrnUhcRVOsnrVSLIlq0=;
 b=tciwxg1talzKDJX4gv3x0tMHJbNMlHiNvzKhOg3WjZPCFyLHiXpCQo5eyaXM0GND7vzs3q/JAH8f9yDFuu39Hw7x0xUKMTxF2FUaZ4PbLwspL82bd5Hn3GzonhYBrkVNclPjcEmb5NPHwxXBfs0aWm/scWvns31h+cnbN+/HLT1sGSDHGSIePquWQ2z/FT/8NiYCobDiEatGXYGKNtitX5VpkyChEgAYDLj4P5Sz0SA24SjywyOZG/TPtbk2aidd7CgBhqAtUT6BNe1kqLmyXywFYJD0Lwgs+G82nudo8K45pb/2ZA60Q5Zb/9jV/cnkzXOSAxunTnZ/wLHLYOYE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYXmaGv3Z+2sbynld3jDsgs0YrnUhcRVOsnrVSLIlq0=;
 b=sO2Dso3OEsETTDzfsk+x4/ERuIpN5+chsiTyulwoYfHjuIzBbM5ORdDSh2rUYA+6ud9ooZyv8DRXm8pW8SxpUlLT5fnBmPiv/kNU5aqGMpAxT5yIjS6ugK28ohOszE3cSWWz9yCOFrA/YQAbvKMVmGK0AYHEkk1K06nhrHDrbUxiNVTVkXizoRTJqciDmQitewb5eJQMq6/KsURUWTMkWZqQC8BUOH/XVm5fFxbXVZ8jP+mtpIA8pexaGVLwxpcFhD1dJF83KFS4cJGqR3+95CrkV1cQx5kUWPPcw/56evKQxFobN2imVc7eK5SrSfOWChoPcSHlnlVs2/8Y2taN1A==
Received: from BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 22:08:15 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:207:3c:cafe::45) by BL0PR02CA0034.outlook.office365.com
 (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.10 via Frontend Transport; Wed,
 21 Jan 2026 22:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:49 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:48 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:47 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 08/12] virtio_net: Use existing classifier if possible
Date: Wed, 21 Jan 2026 16:06:48 -0600
Message-ID: <20260121220652.894364-9-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a26f8b9-0307-4892-0955-08de593992a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLwZ9kb1Wme4Ax9oAYeITXtqt8IhHEZ9UjAO6EQ2y3n5+Y5/7Np3Zq3TNi0B?=
 =?us-ascii?Q?ODp4Nx4Ah3Eo5LG8yJcJnqmRC44LX7Od6g+rtj0LQhkPUupSm0S7OrA3200x?=
 =?us-ascii?Q?UOvCLVtVxClAh9DRa1N0g9VtFmLsjSjQmVov3QFJL9SP1tZjk3WPTspduUZF?=
 =?us-ascii?Q?wy9HWi/lbD3ydgUA6D867uSQjsXBoXv9DRlCTBMIMjwKkgU7QCSRcDsoDHT8?=
 =?us-ascii?Q?c8dtaDjQdmqxh4dk3YvoyK8RJFfBcz5d4iDA2VBrAPLQkDe4AxGh8XPaBB++?=
 =?us-ascii?Q?IxRG6eICk2X0LgFGZHdn1V6xsD7XmNS09aNKCcagMAbPT8M+4iRJ2YJO/3lq?=
 =?us-ascii?Q?+I6TELvJBoiwYkeffCrnCRrK1P6Of+qTNEjsh17bHxSBROLSjtrHMUxSdVRQ?=
 =?us-ascii?Q?vxWCwGb3Wh1iuItoRU2LEQ9+peLm5nkBH/JykVxI0YQ0bAxxChTPpFLBaWjw?=
 =?us-ascii?Q?3tz4osCspdETD8UtQWHA7fvZu3VUpRFF14e9cOhzBbPBIlGLRWQND9k6g0ek?=
 =?us-ascii?Q?kjwFL9b9JC261GBIK/vWU1UIRZgjkaoqtuRM5XLCNA4yob5DB07ktv6Yie4s?=
 =?us-ascii?Q?h9JxtPE1nb8QqaH+ZUM9HGuf6Mny5+7j9hB3dwYqGj7UIwmlKApiwNMMhIMX?=
 =?us-ascii?Q?br6+DoRpNXxcB0wy7nUiwqxLS+FrFdybHhIQEB2OP/8rKnkcFl5XP9TaGui/?=
 =?us-ascii?Q?VXQvNYtlsmL4MCl6ehb5fc/XVc7JmGint/GbT62WNPlH2rusxXVI56LlntUE?=
 =?us-ascii?Q?aeD6yr20+nsGUIx79DpvIaXrkPCmRVzWxHdsUCR31MW0GoNkz/U7Zc1G6zVU?=
 =?us-ascii?Q?tgWNZMEmWg9pVd4MrfhscG0Go+neMv4dG4Gs+Ib9azCCJZJKEUUmTM+5ev4Z?=
 =?us-ascii?Q?YZi1Ed6p1wCqg5ULNwHYcBTQSpqbjr7uXYkQqNE+554cAMZQ5haCO0ssVHgG?=
 =?us-ascii?Q?hIJD4Njq0Br+0wqwnyaQAlrGMnuws9QiSa7XDUh0BTC8UAa9g7mZe7fObvRK?=
 =?us-ascii?Q?Rp0KTCUMxAjY1Qo6+e/cjm9xvk61xqjeqWepg0RXeEBOwKMRz/rj8j9eLp9R?=
 =?us-ascii?Q?W/BLsji7Z4lfyhKURu1V+NXuy9CkLCkmXxh7E7kj9LX8tfK/Ib6OJiq9qQhx?=
 =?us-ascii?Q?2oXDFevBB0onl7SlgylepyXJvnbsSRBJCGqLgM6+7QlwPTLwOpGKhsLYqRcS?=
 =?us-ascii?Q?p2d+H0PDzEkQqWAMJ33ochiFchbZ4SMA6LPr9UUTRlURk1ZfNnW+F8pRBRC6?=
 =?us-ascii?Q?prNEY/YG7fOJMKybf0DsQKWq2tKO2e/jK3fP+14QYwCMKW4VuLLTw39SUsZA?=
 =?us-ascii?Q?G/r6jnqfRU2x2GbLIrP87K4sUyTGMfb2ukcq4nkMYY+gLp8FD/m4qZm9+Mh7?=
 =?us-ascii?Q?rbTpmJKU3/2Zm3RI0PAIO293hMH8Yj+TWYuG6IMCbQQw8rg1UNYDMr2Ou7jy?=
 =?us-ascii?Q?vp3ImhYskyuCZmxwNC0C7M/I+fcp78qoQpO9Mb5gr6/Q5UbpMh/+bRiunuwh?=
 =?us-ascii?Q?eqMLsVTXoKQu0EzxW4RjE6VaZGY/4EBf5bm2ohgU7JhCJXR8iGzg30eaZQ0l?=
 =?us-ascii?Q?wRCPzlG4ePnG1uWqDtcSOrN96PxO+fN7Gzw8EScvRkWjhWcqjmR9JwY3DMBw?=
 =?us-ascii?Q?fq+AwivWNKJYbYxdwk1a7HXOxLNmoO/ocaNd3qELcN+xRU+hNqP15H3SJOj1?=
 =?us-ascii?Q?LLoUAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:13.9427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a26f8b9-0307-4892-0955-08de593992a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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
	TAGGED_FROM(0.00)[bounces-252083-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:mid,nvidia.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a01:60a::1994:3:14:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.127.8.14:received,10.129.68.6:received,52.25.139.140:received,216.228.117.161:received,52.101.61.45:received,2603:10b6:207:3c:cafe::45:received];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	DNSWL_BLOCKED(0.00)[216.228.117.161:received,52.25.139.140:received,2a01:60a::1994:3:14:from,10.127.8.14:received,10.129.68.6:received,52.101.61.45:received,2603:10b6:207:3c:cafe::45:received,2603:10b6:207:3c::47:received];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: ABD185E903
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
index e3f2a7e0e99f..ba231f10b803 100644
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
 		goto err_key;
 
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


