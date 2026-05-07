Return-Path: <netdev+bounces-285255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBpEFq9x/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:04:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69C4E731E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81B7F3032A4D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D3B313272;
	Thu,  7 May 2026 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WJmc/Awy"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7731B4F0A
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151620; cv=fail; b=iPSH0O6xL3K4ktm1+yBFxC7GQwn8X+wJYTdJ8xdlTNuQvUtmydm9N82zuqrZQPc6PL7ueVRCdTakxAlyyYXBBHr9n7WLL2uxk78/qi6D3AwLFUYdzp8vuY27k96h8P9glMRlq4ilZ6pNeK1BvFXDOKIyRYIBFkp4z1bP7Z0wb70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151620; c=relaxed/simple;
	bh=j7kOCVUWuKRZDsCx4HYT7XTX9JbR36C6nhQAGJw5ssc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgB2ASHMtGsamv6jeWGNfROHOTGyoYj93rzvSz18/L8cKsk85FySJUCBmyuPKtwlES3KwQ0l21/QyKjR9tGk9wMYT1oJWGmVwt/TSr6LhmWV8K9ihCOlCjR2UFT61SssH0ME4YbVBShqayezhytWqMpZSMXCLWarVH8pL4zu8JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WJmc/Awy; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVnvhTgap6FXsVSRTWuhH4VBS3/vBJezMBx8kIVInsMtTOV+DLuojYX/GxVrSUvvqtsVcoreRwBdZfCHqBmncGUFgN5wOEsQfGtx6RhEoQci4q7voNfkXZJS2IV1czMkjhLb2riE4voRz2A7MvlIwkYo6N9mtHjGhYqPE/CiuSyta1AMH0tgTsdDkK1T1TkI9EIEWxuLWWJEDy3aUQCmRp5oNX4zWfNT4tcCjyvFQARBJBMKw+WktqfryZZBY9khy1TmFvvCOVZ3S+Qfs9/J/uKVcEUKQq8BlLtJSvW7vaoNpVJr4lCeegzOiBeU4J5eF266/Y0oc5AVLmaU6lQNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQLLHaHTMx4Kwb/Aip6Wtr4EIkyUdc6G8DMM+Et0H8k=;
 b=bg9EF6qYIB/60h3DHMDLmA/bukzZGz3de8sXTtSZaHFfoEVNkb0/+b2tMjaSpOU/0wtdPmqjaF7KK/hA566123YQUCdo2GVEo3/2gODof7Iji7cNa6rPKVwocZ0YXm5+TPzourU2uSeOwkojOLXniWbMS+MyPuM66WtofVtIXhjcVqDyZO+pI02EXb57OMZlwTF/x2kCxu3UAguCRiZK3bsN/HQmwBEmEVlKjy9wi2pYbl3H1d9xLaGmF9oABxmmaHGuUQofwwy7LYrZiqVJtyeLSls1xCDqCaYHGFdv5G1w+83olOD/01miNorDoeHS05CXwJkZ/LIMc7o1RIj/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQLLHaHTMx4Kwb/Aip6Wtr4EIkyUdc6G8DMM+Et0H8k=;
 b=WJmc/Awyr0QJUMJBMebVfJw/ARGKA26OWD4KWnIFSnoWrAArWoJqjaRI9vu0G8ief06g4O0gYUZE74mTswXQzmXWtBE0HCV/SaZOMtaugYzaYg0PTdhue6pWJXk051nIjRvXHGTzZ2SF/4NcFnpjQabbXwONuDCP+AYk18RaZQXY0UoueQNt0X7xmByLM6Wco5ZD5+iG6UIMFBTkZH5hrAqG2/flYYKgKAjqjWuyr4AqpzOcfRQLwBkLu8DsLgsqaJvdJufR2S8uXXXdGdSNZ2fHjBKFCZOHOgQIIGGvzb5egDmXCb4ZsJ2NNmV3HXXLUWPR+hpEPnyGfbJnFBz99Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 7 May
 2026 11:00:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 11:00:06 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 1/4] net: Set dev->proto_down before changing carrier state
Date: Thu,  7 May 2026 13:59:03 +0300
Message-ID: <20260507105906.891817-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507105906.891817-1-idosch@nvidia.com>
References: <20260507105906.891817-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: e25f3a08-3dc9-4222-42dc-08deac27cc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d2dxhTUrwDXXD9QuIwXzwv+C0IVwN1BPQ1Gbeio5+y9IUGbX3enQkQvUbGjriPCUMkO+iCNk7JyqPF6c08DP2kDhJQLtWNcCNYQz7eerIdSsADAEweSN9JyBkhG2ZK9+Ke4FE24QRG/IXi+64oeUx7HEcDPNft2RbCKZ5mYK4w3x97rOJ9JzWIvC1J1U28r/aKXBrgLwiWl1YV6syeWulG8LCQFXd9LFv49csjVhXOtmPQ77bhxX8IaYwMkw4FdM4sTyr33sXkSBibFKswgiX42fsJyoLNf0QM6lq5faw4EEDcjx9/V9jnbvSFYIGUHTKyOgiLNRxDu/qMwC9I0WRxEyHpqXQt69HB8sCq1HXZbxljZBg0A1Z0u6wKhMNyttabLrEesHqoUDIFXsBGdJU40wFeiIkDa1QYIQcyCrUnkm0owk24lxcQwE8ZSQxEsjuF0Gpr7tKwUwPHTCUbvYlGFEWxxNJUbbaZeQEVv7H4/KSgJZPInvjuLZDF+ajxdcaZEXe886ts6Yu9hc86i8j1uT+Gn0hpxKgDY1zDjsT8n9WEnqq3o60itoApBoAwGq64kiTx8z4SRJHWzTh01paJldOotLReZ46PPlx/RXiN7+ijIE4JMkD4XSrsDRhM31KG+FsfsqY1yTodESJmuEnzzQe8D8U+aEmPh8hNmZrAxQHS5lea5PORUm6B3Bsnl3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JMZaHldiGhxx6EMcPskkXzX3QvmeH+N4jnUg3w6SsyFfiDRKQlvr3Ze1KnKI?=
 =?us-ascii?Q?J9SmXhrj6DmJgsP4iFsITHP+75s1ZkLnWAobhtqtRvCzHeLcyMX5//bPDpZd?=
 =?us-ascii?Q?aZx3Rv9FIncVJqX/iBC0yYt940bQjo5xrJ30o6DUMjeQGaVwVBXqBT+I1gUe?=
 =?us-ascii?Q?og87oTqAZ+a5dh2BdjwnFvVz/DC106/60K106rsF2A4fMqA/IsmrPe2Xmfhf?=
 =?us-ascii?Q?fxdcUOQaXisVljX2rSz41vZPW0GIPEJTjEzDPlNyiLnuJE/lATp8UyeGu7li?=
 =?us-ascii?Q?hlEUnK1JUeXWpnx/VqJQ23vWx75Fy5MFrX4lCQWLWAvG1c7hEroI/VqxcSGE?=
 =?us-ascii?Q?7S4qGdKUCApuooF4bhoxqskdJVgbgI0R61PT8h1syUq2Mo0HzQ7g1LGTSWOU?=
 =?us-ascii?Q?LIvc0nrNymZ7p043RPoBuIpZVQnEpqJa8YmGTwHSO4+1HDktATvGD6I9TmDd?=
 =?us-ascii?Q?bhCZm8WbsBcsqF2pQ+spnf+bhbc2xP3QFV/pyv2tstmAuEpjzGCcGhloiWpd?=
 =?us-ascii?Q?pwjp6CttD5lnemc7DEb0gNkRmzB5RpTQj92XUnnkZGHQBf1CZgau8739ycIO?=
 =?us-ascii?Q?uSJqFxph28RxKhfrLIGjmBiOZT61cd9TLI3K2YEU5ZnMULwMtwVFe44347Tj?=
 =?us-ascii?Q?Vf7jCo2uj0AIlqh+rh8+I48JbQjxp5lhwNBfsr38lo3K3LvnCObsOjiZh/HI?=
 =?us-ascii?Q?49MGNwXhUShqcL9OFStrsmUHT4rb5e/+bCb+IrBxmiVMKNKoSfJ/CNG7aHrq?=
 =?us-ascii?Q?A0Co3dcuu0/EXYNbHWhOrZaTSMZGLSYGScg2eF6jOtQEJ27UdNIRB6LwhjrS?=
 =?us-ascii?Q?FYjS+fsguuOGagZg4JzX/5AgdC0ymrUPqPkjsmno+FqBaeCGWaLT/IsMbm94?=
 =?us-ascii?Q?nogh1jYy7MFRygwp/C+xONu3EbE7twF0r7OgsADc4qbCwB/0qfsCxoxiSPUQ?=
 =?us-ascii?Q?dOhnisZio/HF2k8ZKogwGSxJnHjatRIDS80pmQps4gZvyVYD0oeKEDG5Qg3M?=
 =?us-ascii?Q?JPgH7S7KwP5fcB0TltPuGtNSiAuv7DRQ4+L64noNNBBfE1taC3IkxCiHoIFs?=
 =?us-ascii?Q?WPGD3TZDk9h97W0dk5yFSWuiYB72rpkZQmjP/bULqksKwDI5lsQT7kSDAZc7?=
 =?us-ascii?Q?foYnf6VEUUCi6CN/KZvA4GIR8gX3NAkY82QxfeiSzOpPbtfdpRQobrMmPSKJ?=
 =?us-ascii?Q?B4s/hESyFmJFgybAZRu/OTmjpSr99VWXVrHlkWf/AUmBJRf9AAHGyf5pOert?=
 =?us-ascii?Q?AiM+iSFzuYSLERg4+kIf5PGkqk6XcfAA+EAzrpE579vB+ryFlG5YX83msCkU?=
 =?us-ascii?Q?UMSuQ0+yTe2yEn8F/szAox2LedZtlExSRpLTN8jZG7vLqffgtxG2Jv2oa27p?=
 =?us-ascii?Q?lABKqHlMAH1L1dsxV3jskfHD1A997bcGrxq+AtQoNyF/Rd4zuZ8DEEHDLXl/?=
 =?us-ascii?Q?XrvuSAKfwCV7j8VAYoxK0cl8B1SOEcPq6vgCCpdFh5qW/Z68ofEnpPz7zKpo?=
 =?us-ascii?Q?q9eUw/Q/2sESdKiiW+5Swd8q4bEzfGXEKJGGX808FUOLD8dybAB87w/1t/wa?=
 =?us-ascii?Q?0i5qN5Yb9T00lKWUx93QQAGXTNmNKVM1i7a+mm1pdOVtDnTRj4gGRtULNAJV?=
 =?us-ascii?Q?SoI4FG6KSM3nnIyWPMIZEGz2kcHyJgrRWZufKZOXDciu+LtHUxs7gLhkgvYS?=
 =?us-ascii?Q?X1gZj62cN7O4LU47VK6n57PLwSqiv+DBX3XKdRZZ4noeYqBH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25f3a08-3dc9-4222-42dc-08deac27cc25
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:00:06.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K3L6VoLziQ4lSvbecF1DjIe+Dck/slAT/XYwJwzgdnuljDWetMJx5oLhNO/AQjJ6b4KAqIGjjjD4aCtTyWaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
X-Rspamd-Queue-Id: CD69C4E731E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285255-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

A subsequent patch will make netif_carrier_on() a NOP for net devices
that have protodown turned on so that they will not accidentally gain
carrier. As a preparation, set dev->proto_down before calling
netif_carrier_{off,on}().

Note that the only driver that supports protodown and has a notion of a
carrier is macvlan and it is calling netif_carrier_{off,on}() with RTNL
held.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..cb6e90058619 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10147,11 +10147,11 @@ int netif_change_proto_down(struct net_device *dev, bool proto_down)
 		return -EOPNOTSUPP;
 	if (!netif_device_present(dev))
 		return -ENODEV;
+	WRITE_ONCE(dev->proto_down, proto_down);
 	if (proto_down)
 		netif_carrier_off(dev);
 	else
 		netif_carrier_on(dev);
-	WRITE_ONCE(dev->proto_down, proto_down);
 	return 0;
 }
 
-- 
2.54.0


