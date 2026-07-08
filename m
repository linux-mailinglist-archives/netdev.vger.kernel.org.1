Return-Path: <netdev+bounces-305798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bjg2I6NFTmrsJwIAu9opvQ
	(envelope-from <netdev+bounces-305798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:42:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00938726637
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:42:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=oojXBtvO;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305798-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305798-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1749330316CC
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38844D6AC;
	Wed,  8 Jul 2026 12:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AC322B6D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:41:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514516; cv=fail; b=CUiVcCSUJsp7avt5v7nfAGAVu//nVmcErukdcBJkDMst5l4v7/j2nQShKQ+pLH31HQnPeZzRo5G2VMk6DOEt2w7zKZl8V1tjXyb/2jp/tZDjQavjTcPtiihnuNE5GkfLW7zx6LLykgRDCuPT7m/2mimGmWTe9bD4ES75xOH+WJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514516; c=relaxed/simple;
	bh=ij6SLuhPnHjTqWbVm7iUTMeCDz8+3qFDhrW5uaEespc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgIRovjqeooU5t8q1Riewx/ccI/3i+ZAuww8kEAnfxGFojSgulxrKVnZijoK2cJWtuZNh2wzVJmUj1DtTZOzjezGG0SF4SugxqoA4yK8iWKU2CvVqdv30jbnD30Pjeu6RCfuudiemCwfUx8jT2YwarIsLYum9pTs2wnLAYZgwTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oojXBtvO; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl6J/AZH26nwyhqTA4NYNmo+kXZgRgjnBOEqFSvOgP+oypDxhU8t2kaJdkvlhx0ErnzkNfu5w9VUeZnnPlmEFjBU9xwvmi60+MHcRaUcHmPs9YVh7RM6CID9PhaOo6Dp3eUUQi1xou3icJ2KZHoyiQ2Q34w9e+L6ZM/T3BGMTA7JdkWMgINDZQ0WnovIaT1vRXZDOIIU1LWjC5WTFR8LI2XP/DiRhw2JzfkAdYqNZkzdLZryCsrrL1/Snd/TxVAJHToqgn4/M4gTPWZ42NWzVgm7/WPPQNN+xSvwBJ4KzsjpdknrAIQpCkc93e2qr6hH2+LMDfJSQpSyhlnOvSOeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDBp7iT/M1OPQl+IS1EZxJNyV1AULsTIZIGek1MaKlo=;
 b=dCaeX+BnAPv4xG0luW2iwCUNisJmkSqqBfqmwHtwDcB2uDmA5a8zsY4ivKtUDENuwjVC3+79JcCv9dbK1Mg3+FyJiausY2K5YSCRYVVU+4+E84xm33fKwBMP5bDuG87BwaWnvCEOpU9KKOYB1+p2pO6PvyfEdyFtGHhd767k7JfwWJxtNjIBh9iapuH2MMFCyZBN2gtabTUaY+4C2J3/9B7kalFbzkT/HBTXPo7UwzIKF4QSOfqrihSxSJjQ5rfsP6iIKT0SMK901zRxY2RG7K+MeCub7i1zg9M9hioSELRDiv9ksanbpLiWEpXwmPSPNg8kZM9xT40dPyaopEZzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDBp7iT/M1OPQl+IS1EZxJNyV1AULsTIZIGek1MaKlo=;
 b=oojXBtvOkAAG3+fvNh9TMVJCb07EFn9dDwQkBH/ZRf1b4nkTJOcjvogfvhyhv1uQTblNnSYSmG65j0NsX1AYJnMBu2PlyW2G2NS0nogCmZe+5eVA7sacb9aq2yZ3Ab78A2GepxLflmcUTMooqIbKVBdK/ZNm5lrzU2Ve/x76j4V3+3DxiNVnD3ChyS1cOU8QYssPi/CTIobiLRLrVijLTDsyl3yEtx2dmNvEi6Hg8WXPUp2LFT7dNHQEf6UO4Qfr6V4tRdad30XyvjceeCyL38iQUMPE/p9RMivqEALwiQPTYzfmlIlRStJVq7sNA0OYJIooa4rMsFULnq/VoQLayw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:41:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 12:41:48 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/3] mlxsw: ethtool: Prepare for RTNL-less ethtool operations
Date: Wed,  8 Jul 2026 15:39:32 +0300
Message-ID: <20260708123933.1303291-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708123933.1303291-1-idosch@nvidia.com>
References: <20260708123933.1303291-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: e97e9f10-da09-4ba6-5b94-08dedcee472f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|3023799007|11063799006|5023799004|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gG5mHrNydUTVK2ozGjDr/8fKlRdn0S0XfGsM5a64X+vfBiC5/Ncss/5knuZmsWFlxPzhvmPcAoP28nfE/6iNhkUEsMjIZfBOHnawDcL8KgRJgIQhdOqa4hxdf49aw2cSZYm2g79H1c8t42c3CBpnn0ypFMhTglhpkwevGxbv4gbl/SO6GywdxZAW0sZ7Xk/lfCWtEjeg5FcxeOyHZKLYzgLFg6gS5pVrfVIDHlx3AehpyhPS5yGY/QEi6RdBiGyWyD/joyJZ/Gxval8rgSAj1rE8kuvL0awA/5FPrIfNU6s+64RKiJAVPqiQ3jSP5D5AfL/YlbCZBWQT7d9IHzvb47vTf+zjL61e7N8GwDmJ+O2ag6LzDVBrfFggz+piFO9eBhxzxWUahra5ziALtbUYwYkIlhlQf3t7hFm90kVsAmpzUMAyGORr4iNB2afFS/g+J6XNHPGbe3o0cgJcAHNjW7F7t0vuGod3FJZIz7ap0LxZKRoUYzY5a7LA+j7ksl7ZsVkOu84X1CG5l4FF81dKMQN6pgSF/snu18yw9no9X+zUSOtS+9bGufTlCd6u/xFd8m5+95nA0tL4Ib7N+/y2CP9yT1qlbR7cL09eYiDWcovi5nCfGOBvOR+5nsuaXLhF7F+hEEXQvxJpi7iAxMuKyrl+QKaYUswG0SLgKs7XAic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(3023799007)(11063799006)(5023799004)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqRwVrJotRCdZ/RlkK95kEKowtJJuEm15gaaJ4qD+3GwhfRt64RFnOxqhQtR?=
 =?us-ascii?Q?qalor2cZEsePN7jWieoV3bn70ShmpxdfINVBCDOrjuBVkJ+4BNrIt1xkmLg2?=
 =?us-ascii?Q?COG/p1C73NMDebd+ZUMO7HylOy0BNsxjPPHvNue5FA361kFuI3zz46TQPYgg?=
 =?us-ascii?Q?mrevb8fufalWtRZPBQdyZbufszZAmSNP3stYF/6CpYJJ09F6hcBVDSj80+R/?=
 =?us-ascii?Q?waGI1H1U80AV8fLm0mNnQQvEOX65gxWxBJNyIOU6x0eebHrY+npOWe1JSgzR?=
 =?us-ascii?Q?WYbq2/ne18u38gX5cxvpDnqxh7erQpj6DyjwQ92X4Fm/7Rzs382Etg1hyfdK?=
 =?us-ascii?Q?ysX8mYH6HB8ke5dRULpPxE951vBeccgQnfjbf1XfnqrdUDFnzFGLAfzz/G4n?=
 =?us-ascii?Q?25UryP47N6lYAiDX4vZpgesgk07RfirrCPzUk64ZWFNTfb7jCyZWzOu4pWYk?=
 =?us-ascii?Q?cEkWfPQ5cmljD+xfx6E09Agy7Ekjb5hJV9kFoGbvq6tx9ztlRf2/hW9cMi9i?=
 =?us-ascii?Q?4sbQmqzvLH1ZwPWbTiOz8rCmAAlmOVLpZOuET+4BFSsjeOUQ8RjOLgqx1aUH?=
 =?us-ascii?Q?tqATEDemu616rzgD6hSpXLrOjLzcZakaAF+SSN2KfAbtsyUq8W+RcJZtKsuH?=
 =?us-ascii?Q?Itzp6VzchMbQsXoa6ehU3YsTL433XqjVoa0UbKpF5PzcNEXmZnbl/38ueHgR?=
 =?us-ascii?Q?5z8MdAbB0PqBzqOD7hEISexanLjAsCE/CN8k/ifwgINCnZP5EyUleC0/ls5W?=
 =?us-ascii?Q?1Zdv7SR7BobGuKBsVM/rSkhTlO+CHhLJiyUwa59QNEGq3cFEk2ceLtA+TarO?=
 =?us-ascii?Q?Vw2qw7DQKrhZtjkftcJVamWkAAs7FjE2cm4GvCSqMcpKI61N2RKQfVFS7I3o?=
 =?us-ascii?Q?YJKdYpINmbn0H2OMmitCLc5Xkjn/E6svWzECvws+hqWHXW4CMSthQ24tJm70?=
 =?us-ascii?Q?ZvB9QqFpKBO6MFbBC0ykesNuFxf199YR4pcqslFigLIZETeP8RBtC/H/3Mzd?=
 =?us-ascii?Q?ytEZ/eStQiV5pKYJ4QskLlc2bFOAQvYYpx4KhNUzCEqyh6MZdupKRLlYZzI2?=
 =?us-ascii?Q?jU37GmJeOULS5j4iKNTbAkTyTDfi7xGdkY0NZZk0dQLtDwgg7/5EgsMHsFdX?=
 =?us-ascii?Q?2MwJ9beQjXim4PgfElIwvubRkOQcGi071kW9iEJC2N7dTne/ksSvc2EmaGY8?=
 =?us-ascii?Q?kPgi2IL5yY3Le7VwiQfw+LNRSw0LbViqkki451RxwifG0SAJiUF3CRKoO9qL?=
 =?us-ascii?Q?MlbnKEYS9cBucSi74twkb9aJIa6LzJc4RxuG+/RVoZGUKx48+FkS/W2MoT/q?=
 =?us-ascii?Q?TAYgyqll50fb+WBv/LXZuuleAgk8gF+WHugKgsqWZ170RNAeJUeUGSsdBWl5?=
 =?us-ascii?Q?mUDESUbv/HaHP/ozym2nhd0xO4bBLmng9Ip/KmLGAYuObemoYnQEzCaP+cvI?=
 =?us-ascii?Q?5f2IKWRHmo0+meZ7n3izec+o+QerLOUBYw28OZlYw2JwBF81WmrgXFxkRcV/?=
 =?us-ascii?Q?bD+ncM8anneBsivufFTrRHkcUpwzfOMUXUIZTjgLlBBrl9nkZEcMbWEpjQ5G?=
 =?us-ascii?Q?Ds5Aao7IbUeLRHd9d613Hd81FwVPgPO/xlIkdKJaxK1ZKJesRUf+xWipLAH2?=
 =?us-ascii?Q?ZbV5NacWhIWMu8IrUeiX7FhfeaSaZ0pKkw/7ZAV+of0nTpnUAxJSR+HvCw5p?=
 =?us-ascii?Q?6/BKe8gwtPkSuvgbOP6EpIBLv7+dQEaTLAcew1EvW5afL3ah?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97e9f10-da09-4ba6-5b94-08dedcee472f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:41:48.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OpZuZy7h9qMVgT4B+xrDGWOV9ifyYCcPwAv56cmG8ifY8tO7ym+sCM9MFzgsQnEv5ZiqPw/qS6NYInJdiOb2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:idosch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305798-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00938726637

A subsequent patch is going to make the driver ops-locked and allow
ethtool operations to run without RTNL. In preparation for this change,
tell the core about a couple of ethtool operations that should remain
under RTNL:

1. Set pause parameters: Configures the port's headroom buffer which is
also configured by RTNL-only paths such as DCB and qdisc. These paths
can probably be converted to acquire the netdev instance lock, but this
operation in not frequently called (unlike stats query), so avoid the
added complexity for now.

2. Get link state: Calls ethtool_op_get_link() which requires RTNL. See
commit 1105ef941c1a ("net: ethtool: keep rtnl_lock for ops using
ethtool_op_get_link()").

All the other operations do not access shared resources, do not invoke
helpers that require RTNL or already have the appropriate locking in
place.

Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 7f78b1ef61cc..3bdb532d833b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -1262,6 +1262,8 @@ mlxsw_sp_set_module_power_mode(struct net_device *dev,
 
 const struct ethtool_ops mlxsw_sp_port_ethtool_ops = {
 	.cap_link_lanes_supported	= true,
+	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM |
+					  ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo			= mlxsw_sp_port_get_drvinfo,
 	.get_link			= ethtool_op_get_link,
 	.get_link_ext_state		= mlxsw_sp_port_get_link_ext_state,
-- 
2.54.0


