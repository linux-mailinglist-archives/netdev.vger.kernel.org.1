Return-Path: <netdev+bounces-255944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLZDEKPagGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:10:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CBACF681
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A573D3017754
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99697385505;
	Mon,  2 Feb 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HuArXDBR"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8333815EF
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051970; cv=fail; b=HMtdDTnNthLvP5NS2xpUCkYBoqduIeJFnExcdoXdSJKEPnbJd3jRAjE39PhlH7dkjSGtottdCTRfxspoCBSy7HV50Sf/EGJCcENCZ/dJVI/tbXX77ctuvSxhqkUbBdhEJYBCq1DYut/oOJEfq15HDxYSe1dZoTnBl//DRdkZyV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051970; c=relaxed/simple;
	bh=UGVEtPU7wQQ64sAO3R9jkCYRJAeyXzrzV+iIhAuJZmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJZx52tHNLbH5fAtEF/uONpQTX07NJG8dWUutqBiWJK2xJjyUmhCvpefYpbuZTtv5UlVrqay21OkGAuTRKw/mQksRHbBHINDhD1gqxUl10aM805f2SX5L11KvaUuwJ53eIDxPfumLV+mNqE/w22CcH1S1ntsYhDNsBXeX/vw1Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HuArXDBR; arc=fail smtp.client-ip=40.93.198.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVQ5Dx8gA8Z4Fbzz0dYSQLmbNURvjWCMF8K1eksyQdNPia7fw2rCjbMKu3pqWf0n/8YtRnJeHiwyVMrKW+dx5+Jxv2TKIK3K0G50K8astQJiTyMVW1/bd5jb+OEe+NhoWykyINef3Hfszdm0M38IKDSNLVmWCR8OGfQvQFLcc081MjZEMZjwI5yvG+2R1v2mXn1MiM/eFFcYs8+PQEKkMv8p/x8qAgXBO8OgDQIrNShgsosJSNMXvXhilj6aIkCP8xCMlKt1BsbVzrAbKT1wJsl8kOLdtbD+7sCFEzVNIlTbNTDUP7uyWVd3xSNaLPL8es3nkOz15w/qRqbUjsjVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YerWUNVC/7VypczKFEi+y7+6LFXvc+gn6xm6W7DP0ps=;
 b=nd3HbkkeX0iLeeqGwTK5dnuZYg6zv1sO481QHihHJ9BBMH3qMO5zxkcW7k49RDtFGJShQj2R0fSKyPGnDOdAHGglfKPoxqJ/YZ3HCRquBQPEeLQa2X5zmw3BBLq1GqBsysBt0VHaOT29r+rq3dBACJqc3QTEc2XO9K47vk07AEvFbh0WVienfSaUD8RLG/JR8EGnVQxOxDGhCAHPqePEFHS1bEmM3PyBF5eq7WiibGALdgyGq9cHeX5Xvm38IEsiAeGC5UUA93D08xCkSajGNo86t/+4Zhh/gjp9M1vWHQhAixA8nZLNnWRzA67Pqy2esYVujS5ojxmGSMmaY/I8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YerWUNVC/7VypczKFEi+y7+6LFXvc+gn6xm6W7DP0ps=;
 b=HuArXDBRMwtM8sn88nEAV7Q9MOETjtGT2iJUHtqsmbGIflRDKhL5HFG9L85Ku5uN5NIIa3exAY8wcaXl75RspkVeDMdbT63cJaSY6F9WeuXdptGogfizuoaGlVPEjq3hW9CSau6bBqGuMnH1EJGqePQJs2LnVQsZ3Ja7wI6oYoWzyHjihroJ64f3eggnWpH1SgHSFge9oLGeykjPwOa+3DDDtsavGQHD4tmMSgla6hmcWy5CG/XSEholytt6s48Ud2k3Ip0VZk/qDdeTfSSZ3Zbuf2lEjj4MNnTOASZjDEzqju7VbfFqd1JVwkV2xgtMq8Aai6/0UGDr+yZYvtAwyw==
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:59 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::92) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Mon,
 2 Feb 2026 17:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:05:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:42 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:41 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:40 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 2 Feb 2026 11:05:15 -0600
Message-ID: <20260202170518.9076-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f6367f-57c4-4e1f-f9f3-08de627d5650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rC6eMBQNUvyEc6je3Nl2KN8VlZ5JWyBp7Sg5pcfcn6h5QYxpuCh1ALygAsbY?=
 =?us-ascii?Q?lBytmKPBMr18mQYCt++3N0dKoBDkHogOicuOa2+amibXFBNbN3UBRqfsgLMg?=
 =?us-ascii?Q?ep6bp9YaFQfJPi93Zx85RXGqPzDR1pY7sSaOxoq98Gvx6JVbGEKIYBNxSR7+?=
 =?us-ascii?Q?aCVAzNEmyuVvpQGZxyCKYmgfgeWNaG7qvccjfIxVwAnvBp23bGpQvzM4RB7p?=
 =?us-ascii?Q?cBKzLOGin8E5OOHf0rxngaA2it17qB98dWJlaknYKyBNSDe8dTTFlU8Sx3si?=
 =?us-ascii?Q?fhP/0lPRWpKuObBTbzM5Z26oryRwjyePyOWpp2cjfX4DCD2wR916whWgwuaE?=
 =?us-ascii?Q?LZOPjLP9nn1t0hAA31d2n1Mhb8etB4BjCu4JmtN4ngXvxN8gg1oyXXTlU7Lq?=
 =?us-ascii?Q?mMbvvqApk+zU7sVliDqNumjlme4+l+MoGprOACGwEtBb5cIskJmoP6EsQJNS?=
 =?us-ascii?Q?w6uIS+6R1H2NZajjrKdZSBQeU8xUZhpEP+4ihBo0PFinyDCgwpd1vRvtGVH4?=
 =?us-ascii?Q?jiVqAx9bhsEPAheiqorBtqjR2dgI8n/P3XO6gxeDtBaxOs6CF2O+KV7f7OKA?=
 =?us-ascii?Q?y8dosG58/D/kxvamEmSU8MoT+1XA/lcR3Z4x9C7TX0tWDVRt2OAwgJHowSwO?=
 =?us-ascii?Q?SbGyONSQQDwhfh6rPFyUmHvi6MAV4lT43TkBwfrFi6Mea9DS26h7kayEnN5q?=
 =?us-ascii?Q?6b3Y/lkeIRVv/O7Oxk+y1FkBd21JdurkL1L50mrbzOzORMBiJPaU7ReO3/Wj?=
 =?us-ascii?Q?cjCxmJaC1fmHN1+MYdC64s73Eh+Z1YZXSAJKJ4kygJ6uZa7j4RZAPd6TxQbV?=
 =?us-ascii?Q?0XhKZxGyJIrFohdEFQb4f5hr1qr2uAeTvfrlDXFyencz19FBHzXSynSO/2Nz?=
 =?us-ascii?Q?iGKz2lKl/S2VRTDUxsXFwyHvGgSQFwX7wduLyo1QdlVy2gAPzce6srX/f1a0?=
 =?us-ascii?Q?Q7I99HwuX/UdLVJn22c/vI2QaF3OMaGvdt3svzn6J5JfAa5Scx3MYfgZJj0O?=
 =?us-ascii?Q?P05QNS+O549RVdDYeGehMGEbzP28c+IK8txvm3sZ+p70INoCwkpRgCcJpzfV?=
 =?us-ascii?Q?vSC/Y72EY6vYyncV+/6kt3/CO+smsCMy7/VxJkk8LSidZhxNmyESmt2hVSxt?=
 =?us-ascii?Q?78AaXYE4eVOZA55XIC+Z4xHIjVDvJIUSUaeeJPgHCiRw5NHsQFxy7/c9sW+0?=
 =?us-ascii?Q?arCFDl5cBUa3x+GPxgF+HE42i73JKk0UCPmjP9KkZJnFp29hH/uzOSm64RRE?=
 =?us-ascii?Q?SnbZ4mOmKy0rn4CKsZekbq40bmqDEVY6XR1V1FhslEsXo4QOQ1gM4ngReoTy?=
 =?us-ascii?Q?xooOEELiurK52CBZjt6WaJHXYfW5tQqmseG19q1NNP+8+6EK68t82j/W7AKq?=
 =?us-ascii?Q?QqZvfCrYzSiAdUqkxUQ9ESPsA9ZHJgw4+7RYb0EifjVX077eO58tFH6t4IGO?=
 =?us-ascii?Q?vKMoti1CpZz2VNLC2T09NpumjjNIihOHLrzQ1zkcKA818Xoxnea5d9P/pdgs?=
 =?us-ascii?Q?pLoIObIERUmE2oYlv2L6J/Yg0xkOST0eM80pznKCxDTfMkQT0+kGRjesQYTu?=
 =?us-ascii?Q?xPv43PwZLwH7WxFMO+TL6mzqxkF5PoBlQyQ3qOKz0IcU8UqLvWtwJ3JCw5lF?=
 =?us-ascii?Q?AKBJy5xMbeLXHljN07Ugmk3t+eLok5mKntgpLxe0LTR1iRrq2c0S/i8zRkOy?=
 =?us-ascii?Q?jtkjxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	76LTDvfxWdjlIw7A16KppXy+MVC5LpJ3nYmGEpyO4m9cMeCS4bzgyDoGuE9XKKLNb/JTH4lF1CxPJ8DdTIj9UtK4mOZg5irprs8u5uHweWYrTB8ezgdlhNHnvCjvpQNZAPAMIQaJySed4sMd7fXrsP4uOUi0CYXaf/eV4IXDZd4rnWFlbuHngVUYegWVP6XT8yIKe80gC7uMQbFqtPaPMS04mDxdoBXDu3b/DPlzNg5dkQ6tgOTP0KXRCSNW+M/PhjasPLWY10NJf8J31Fkf8P5L8ixYxGWVybyeYDefSCB08J9+yaEu5Yzx7A9ynRJcBwAf0C+nW4URDAXqTA64djvcGq7qJRlcSdT/CFfkSGVGNVWD7KyYxFuG0xF1gsJtrosGtkCfuKlEcu0DoCOee6R5/4C+ABbCdPqBiWcWxGcRvHPIvBP001zFmDCbxesa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:59.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f6367f-57c4-4e1f-f9f3-08de627d5650
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255944-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 56CBACF681
X-Rspamd-Action: no action

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.

v12
    - refactor calculate_flow_sizes to remove goto. MST
    - refactor build_and_insert to remove goto validate. MST
    - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
    - Check saddr/daddr mask before copying in parse_ip4. MST
    - Remove tos check in setup_ip_key_mask.
    - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
    - changed return of setup_ip_key_mask to -EINVAL.
    - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST

v13:
    - Set tos field if applicable in parse_ip4. MST
    - Check tos in validate_ip4_mask. MST
    - check l3_mask before setting addr and mask in parse_ip4. MST
    - use has_ipv4 vs numhdrs for branching in build_and_insert. MST

v17:
    - Fixed portability bugs for unaligned reads and writes. MST
---
---
 drivers/net/virtio_net.c | 130 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3fc0ecc74a2e..adf7b493ac90 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <linux/unaligned.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5818,6 +5819,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	if (mask->tos &&
+	    !check_mask_vs_cap(&mask->tos, &cap->tos,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5829,11 +5863,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	if (l3_mask->ip4src) {
+		memcpy(&mask->saddr, &l3_mask->ip4src, sizeof(mask->saddr));
+		memcpy(&key->saddr, &l3_val->ip4src, sizeof(key->saddr));
+	}
+
+	if (l3_mask->ip4dst) {
+		memcpy(&mask->daddr, &l3_mask->ip4dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, &l3_val->ip4dst, sizeof(key->daddr));
+	}
+
+	if (l3_mask->tos) {
+		mask->tos = l3_mask->tos;
+		key->tos = l3_val->tos;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -5969,6 +6033,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6000,8 +6065,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 				 u8 *key_size, size_t *classifier_size,
 				 int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
-	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type != ETHER_FLOW) {
+		++(*num_hdrs);
+		if (has_ipv4(fs->flow_type))
+			size += sizeof(struct iphdr);
+	}
+
+	BUG_ON(size > 0xff);
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -6013,8 +6088,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -6022,8 +6098,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->m_u.usr_ip4_spec.ip_ver ||
+	    fs->m_u.usr_ip4_spec.proto)
+		return -EINVAL;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -6045,6 +6148,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -6082,7 +6192,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (has_ipv4(fs->flow_type)) {
+		selector = next_selector(selector);
+
+		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		if (err)
+			goto err_classifier;
+	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
-- 
2.50.1


