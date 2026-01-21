Return-Path: <netdev+bounces-252086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFn/HgpPcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B5B5E8E7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A62A46C4F9E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB538B9A9;
	Wed, 21 Jan 2026 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvH55bHD"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362343DA2E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033311; cv=fail; b=S5HASNgKGFzOw9bFn91AQhlOq8y0+xumY7pTjXVVN0Y0EwjjW/Mjcwp6svrlypIuSMFNLz7MIzxwTxuFVTc/S9ZHEJULx8pWtAuxyYHtW3+Rjj+TyuwgVhf6HtGts9++qnwjxZWJj8V1kh/2Vzh3BatHcUkQ317M1BkE8lv8MNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033311; c=relaxed/simple;
	bh=jRNJ0WYPMuQMnY446DAJ2vNg/aTdUXErx5l5vs3rNwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo/1i6khcXJstKODwpXWfROYBuwQEj8wyyvfCeGfLe7uDVVck+BlZWeh2UIVgU1UXT4DERAKEIdEgDJj9cd1rHgPcgjIMtoshtmkoS0scMJzXM+n8/7iMT+bJNNcZ0mNQTCHy/T4BQlCWv5mOsBBA+cx0jKTGeHIqKQqWX+0T6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvH55bHD; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+7OC+MgRi/67aTVDeifJATZXoHPKOQ0Wu95E9bqWCpHT+atqGaHiEvzw//HLyt9KHJIcOGoa6P+IYF7YdPMb/G215AicbZM1Qz3KkIJH8/4C4JbBaYaN0McNe24zHw5hrh2fLuqPtu+QP7MefAj4dEv4zCqzy2/j64Qo8onfTKJAO05fgo0aQopzVmn3CufHjkxc9G/i1vZyREYhylvi0sMSsqHWtB6my0FbfNB6icdSMmDs+Oowb7mw+pDeXFypYKcL8drx2SqrlkHkJiowviQjHpFWO1c5YSwSD5h4BBiaYmMZQkSMJbmO00UjeyQVZsGOSJQ9V+Waupp7cknaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l09aeHS2+zlDLpJkKqVmur/9TeIGWIyf7g5mLEeqaE=;
 b=ljA+FICGhcjcwCnuqlc4PlpHnGMmcmOynQFauaWRVtiHVnWRyvg8UuVPnltk4Y3/lq0mYqn9mlKRydNWgJgCAT53+ZE8MFNTWyDKhePPCEn6lZx07OLFuUiQkTPYTdF/Q0DPMIhsPqeVAh9ryL5cadXFZMh6WO6oIS1MJ3jgU4njRrbIuwcO1ClSRk64u4df8AriEBNELV+IiBp0vs3VppsR+zu7Wa2IiDabqP/72W/HOai2cOzw2LZAlTSNNWVtJKV4S8ycbtnTbWJ5/mFy3+ifLrVj5NFkrcALKYIEClkin9nkNxX++ZORCur9R30GxM5BgcKs6AvU7J2akJ/G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l09aeHS2+zlDLpJkKqVmur/9TeIGWIyf7g5mLEeqaE=;
 b=jvH55bHDWmwDRl9jlnJuhKOib4RQHbYkN6JZ7CtW0MZ4ajtvDO80oKNY45E2CP1Er+kcCvmWunxx7iyK9Z0M2ntQw7Ghzg9hTLp2QdFykNoqLc2jDGF24X81sDZQvPlMYuw9g0fvNDFRuvRek78wf5w8xT8sb8AImN7J0Cr8IQrW0XhmaWlOXzy+RWV1hn+NzSP0BSuK/vareEHSTqUyyVyt2Thv0VNHJOe/EzOtpjtwzu7yvDH7jUcNWKGzsztnhi05yFbzDVKOd9ykzzx+q33o68qZ9UXUR+bzqCHHORpe81ZDwrTFZYUOsExbz9JqDnb0pPEey4CekExWoJCUvg==
Received: from MN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:52f::9)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:08:23 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::ca) by MN0PR03CA0025.outlook.office365.com
 (2603:10b6:208:52f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:57 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:57 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:55 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 12/12] virtio_net: Add get ethtool flow rules ops
Date: Wed, 21 Jan 2026 16:06:52 -0600
Message-ID: <20260121220652.894364-13-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: d0018b03-736d-463d-1d8d-08de593997ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ryOvnKM9t82EtP4u71lqwdVNJMBwlfyByBRYGJTVRXoQ1l1qVFuo2ZtCmPeE?=
 =?us-ascii?Q?lqZqINC9OlN3QJ2Vw/FqfIFW67OX3GeHLmQlArRUnnd199FgCdM3V+R+vr/e?=
 =?us-ascii?Q?KV9lybSLl181wjBf05oq9ZjOF23bD2nPOrQ9AFjb3jRfHzZNLt1dnANjhZRz?=
 =?us-ascii?Q?YkHkMQz+/0zNySe56g7TnJS23VkDJrY3EWcG7it6AJU3czlfdSYRPuHaRu7i?=
 =?us-ascii?Q?7SERrqikdm4xH8hxNr2UeE1IV8Q1vz7hi8vlTZGAbyAclGsv9yBQ6U84Rfo9?=
 =?us-ascii?Q?mWT1O5MujZoal/p9CRfO6eLpRF0Z4YZTsp7mfQPAtze7JNxqUTAUlU7TCQXm?=
 =?us-ascii?Q?ihu96zId+EEgshZD4UwxAqjuREPZle5aKgz8iesr3bc+Y28qFKn4Tuq2MIhY?=
 =?us-ascii?Q?ouJ7z0BZnwkN/jC0d+9DsHfoLuDgD0fEXEIPVmKWbYc34utDPy8le/fOten3?=
 =?us-ascii?Q?N3uyfJ10K1RQobomFGezX/Ym0Q/Awrx4G+YkmtxddS9d9PpjFrQ2UIiRNMPX?=
 =?us-ascii?Q?T9ynUJvF+bn3NyVRtPQJvGbOSn4Ct/LJKpJ4N6giaBxC2LQershy6rNVo9jK?=
 =?us-ascii?Q?0bWThO2Sw56YUO2AAWkR1NfQrEfatnBgv0KZnxS+BDKIGXPE52yze5EUQtud?=
 =?us-ascii?Q?wKLfkLE+dcfYr895JDjIWd8K6gxtxqBVQ6WL9jIfFv4tqjJ0oHJJKmCKhC8r?=
 =?us-ascii?Q?Io7pIcYgr0jEbfHJEyPtBFHPp3yuT4A/YnAmiJfhm72paW6+I7XVRgk7BHGS?=
 =?us-ascii?Q?25HCmh5GXpby2yKlDkOogagKwSMjUX2xWJNIjEe/4x6IHcTFOpHQTopYl1Rk?=
 =?us-ascii?Q?GvmU2N9/Hjud6ugKIEh/H8FsvIKtm6yjfOHixfTCLA8lNft5G3w7ppgVjHSW?=
 =?us-ascii?Q?0QrbHDH+mFjyjy99ut2ND30cKnZdl/x4lKthlgKYRwef0U4uY+gZUn6Lc4h8?=
 =?us-ascii?Q?K0B7zSlq9/72dg89O86qA2ZTMQXa3Gjz1ant6X51zzBAQ6LGB6m4BcU7h/PE?=
 =?us-ascii?Q?R93O0CWSaC8DZoYtq62tecIbmNYf4xWjN+ot4TtgLr3MgFWb831po6M5hj8h?=
 =?us-ascii?Q?/68IDIPvwknuHPiW1jKVzk/iBW6qPQAUHdqdp+QzbaFTn5Av11v4yXwIvUT8?=
 =?us-ascii?Q?BR88kRqsDEIwaT2YThGK2zibAg1HZYd1E2i6YDd0fCx43yWmOpXErU2vKTKL?=
 =?us-ascii?Q?lRWqEZPpvSVuVgs9yk7d+7sqPiQqjOdj6yYSn1sr+z+VN7nF8nFfJGs8YHU/?=
 =?us-ascii?Q?vcWR9FxFk3yb7nsgzaXXVNJv5NAgskKhKWna3HrE5CG1M4bUT+C1QhnFXPMq?=
 =?us-ascii?Q?tB8wxEj5wmaeEQRZ4ZGZYygnmYdmeiLlbHAL84OqnxVn+85CB/VdrsjJtDZn?=
 =?us-ascii?Q?KpE4IYFJfm4OIZmpbh+lyyP28adwv+oO+9euomGjthwKCiJhQ1i6NqUFTNt2?=
 =?us-ascii?Q?srAAcTue/wg96eCRyj/6A+tYKZatJwcaO/j9dFML7H2R8vK02neHtw59GPf3?=
 =?us-ascii?Q?rBpqWewHUQmHDUwdU/vd1QB2JcX5I65K7hQJPkFLXn1a7bI1nHMiDz8+OJU3?=
 =?us-ascii?Q?vvoyilN54mXYuSAj+kgQm1RoLQVLF9qr/RrSG5/z7qeUTsbUytvYxIG+8Yy3?=
 =?us-ascii?Q?dgb9TkwiCNiRcnAIe/co5+Loq9Q9AkPz4P4S5WLCmWnTkA30kp1n/62pRSp0?=
 =?us-ascii?Q?xe5xMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:22.6213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0018b03-736d-463d-1d8d-08de593997ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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
	TAGGED_FROM(0.00)[bounces-252086-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,Nvidia.com:dkim,alibaba.com:email,nvidia.com:mid,nvidia.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2605:f480:58:1:0:1994:3:14:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received,216.228.117.161:received,10.129.68.6:received,2603:10b6:208:52f::9:received,52.101.53.40:received];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	DNSWL_BLOCKED(0.00)[10.127.8.14:received,10.129.68.10:received,10.129.68.6:received,216.228.117.161:received,2605:f480:58:1:0:1994:3:14:from,52.25.139.140:received,52.101.53.40:received,2603:10b6:208:52f::9:received,2603:10b6:208:52f:cafe::ca:received];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B6B5B5E8E7
X-Rspamd-Action: no action

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1d95cc7d285c..c6f4a87427c1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -312,6 +312,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5595,6 +5602,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5636,6 +5665,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6559,6 +6589,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


