Return-Path: <netdev+bounces-289410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD2MJkhFDGrQcQUAu9opvQ
	(envelope-from <netdev+bounces-289410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F157D404
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B6563074C89
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8B3B4EA5;
	Tue, 19 May 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pvIxDIGu"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F83DD503
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188536; cv=fail; b=ux6ebTjwgKelE+EB0z8qY589kgYB+v0HB8WBGQtmLdM8xqVS0eIRH45wQdz1xFWKXXApIy25j8WLL81hrLS5LrbeKCOXM9G/DdEbDRW8GB+ah5xhEV5A0c6MQ0rDghWyZV2vGAaAZ5baDc9Ykvxsy5Rk526Z1B9xhOWR2ChVNd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188536; c=relaxed/simple;
	bh=MQKX6OQvk/aOBUZ4V/DPBpQSod17RdonxOQALYNmbMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PS42r4QD7UypkRSx1OUvkUqJ1hcnoTtODjZMYYeG9PXNMf+8vC9h6jWi83+5umxMkeihMIt3xm8+GAxih4YAxaSaouWFSxo3NAlIM5z/Ak0Z9InPG+ocajj2XswigXpLAkK6mMAnxRggT3V0Sk1tCUmaEJ2ezpvbtAksiId3hcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pvIxDIGu; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0yKSMQj5emXNcERvN+jru3L5JrxPHp/MzcWnuTqlwbhMYD7HhtXOv5xoYCT9o+FmaeZDXQVzwieEfueRbGfXwg2l88oJ9uF6b9DXXC2S41rUoGo/m+0U0SzzIl2AffiN74+L8rozfVa6jXeTc8wp1xAASIeEz22qRiW0rexRkIksjt81P/lSN/PdNjapy9g8nZ2M+r9z0CEotzOFF77ooH6SS2tuCqZP9+DzySzfxnJQdIR/3HxFoHidvgyEqyHcpsEfPhDleIsaS241f5sRAu6P5C3NqUOpll4e7p/2gTMrPnRXy2T4tp2a0UqIk8e+ohp9aYoSO6h1GfSJVwM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLXxBysE+1lFmA3sb4UPoSHiNq5MkuMCErB1cSBB/Ds=;
 b=QWt42fAwEfx2eI2kzg9b6GNAq0Nm1RrEWQ0UYPNrGYPVh259hQrnwqz9RGZef2qtHpXoadIk9FtQp6dkjHxiv4MXaUT+TH1EKulEXgnolXZoJIZNRJHhtFmeqMz9U0p8zPC/uCLZDkD0klvg234xwHto1Kt/YLYn7QFlBKWU5ZC/8hm7ElShAQezhvqL53Sb/ZP5nNw7qbUYkId387wKXNsVOoMPi2tooYgqMB9AEam30ZiHS8idvdlSi6+8/S+xT3VLxzdf6R6SbC6SFozoG8B5/Urj085xa2xSlKdCLivSjnlXNf3uPQEvWYR5nLm7SXQ4jhWPPi9ttX5Fk3+Gxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLXxBysE+1lFmA3sb4UPoSHiNq5MkuMCErB1cSBB/Ds=;
 b=pvIxDIGurArZSGOp4ItcEcX2TKzigHwFTRhjXi+7ugY27eJ8CIOwsGQg+BKamhUohgfgzNDRy0+xEF+UaDGeqJUD41RJQIV39DBFPtuC6Hd0Vd9RngKdsYvHuMT79U6SG2B9mkvmuapM0iEoQ30YLVd+nTg+s6Nn1GElgELuCV9eb1ATI4k2eSOGKH8dhFjaPXM5DfHoAY0EHZrF0hpbqNkYH+TsUbW1vzbG4KXTYg7nvBZlNm4YJVqZC2uvq2B3HQjm5spoN8Yn7TsqFkRWXK6KEGaPzXUKbJbZH58ySnMSSrJoLHKitT2OGpkZYsd+UMcwjXGJbO8ZXLQV4hfy0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 11:02:10 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 11:02:10 +0000
Date: Tue, 19 May 2026 14:01:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next] net: bridge: remove stale rcu_barrier() in
 br_multicast_dev_del()
Message-ID: <20260519110155.GA415776@shredder>
References: <20260519095540.2643318-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519095540.2643318-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bbd444-a3c4-49df-e10d-08deb5961313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WPEMOie5PGf4JSLc4bs7eEG8a5T8e/URb4pdegPFIYYdaoCGv3SNLbjYi5Tzpn2jg4AXYyUjOV9kU4NxTIoIBCuPz2mcFYpMjBNx6ucWmAYYctiaFkoa+B/Oh3wcY8QNxI34iRMu93/LZbQTxw71PKZgMN9cnpI2RtmH8OnR4BO9neElwAueQsqWEtjNu19QhnWjxUWIvMGrBfeET+HpHC5/tlR2q9XKS+cKKBbiM27G27lyQyNGHfZROhH97ckSDpYlIe/FClm1govXdFm5D+fswUmffnnpmrNbD8RTevrFufgkqtKK16iY+Tu3tDkuN/rMu7f5VUZL/5sU2Zba8L3nL9WzkjZcRtwgs4MAzh/NnerTANtRWqXVDhdjYtMH+RTaUeF6Ds+NcHstjpkCP+G+GRFOr38670r+z755T2M2pXgrqqMTpGLR/QfPgjjXdLSmadDLXejfjXSFbCyX+8OmHV2IJYjokxzg+0UuorotIBtWU6ab+5oSJTyQAj8cW8PMrr3a5eGuQo4x3I6eREO1q9D00dAjikQVmAyJTQ7kycHKFqsp6NIwoQzHRzcdA3X/MhqD6fxB7q1H5MkhdM7lSpLs38nmtTLJvMl1NKWrv71dRnOr1QzUxAssmzKXBaejRY6AS/D/yKtbVId2DjM5NzecKSFqODGKVdtViCgnpGVKdkM9kQLz2Sq3z9Ii
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+vFzFQtrxiU9cdxk0ux7bAdelbW+6/Jikr7xLo1rkxNtQdfMPjVngH9ZaOvr?=
 =?us-ascii?Q?VgYy55bxk6j2Z6aAWqV40SXJH7Rpo6djFJj9sajpNTWIqK/qa5TNMgA18bt2?=
 =?us-ascii?Q?CoqOD7t2OoZAxxQCvV54+uJNSY/vQy/gMQCmIAQKS1pJw16rph4g/5On8g2i?=
 =?us-ascii?Q?Mv5doFhGaCh3G+/0oW5PAyvnzwTPT1puckh4TcVj4VfeTZ0Z3IoSlPub1s+x?=
 =?us-ascii?Q?PKbkbiF6oGcnS72uq8iY0wX3FPB99rCCHkpiZLFkB4KogKqfUE+dEtqqSINd?=
 =?us-ascii?Q?SB0WKIpLMqbJQwr3s0TmCoLaJkOn+azhmGMcFoeuuxqV49b9QGVFVMtaZH6w?=
 =?us-ascii?Q?ADlsFIEW5emORwIeq4s90EbBDM+FxdPXdwQ01SZ2nEgeyv54DijQpyfVGY2I?=
 =?us-ascii?Q?8h1GGlVBAMqTzedRio1E7r0i/MiqZoWpFs2PghJVt4vWP7nTn0pvzwRjcpRm?=
 =?us-ascii?Q?QU5Qj/RcoG0Hi6b/GQ584vQA88gVeqj/cybGJ9tEsV0R+AgnqbIB+2EKF+r4?=
 =?us-ascii?Q?xE9TiErpOhrx2U1M5WecnJ/HiYoawVSBx4SryrNmnxrlB6mBFVQ0R8uFp5Jf?=
 =?us-ascii?Q?fDKT4Wmg2et9MhHpcszV+vbTJ7Cw2kDUsW2AHkLl1B8+Iyz/vlIpMNGdzD68?=
 =?us-ascii?Q?LkjxB/BDpozQR5SUoxFeR4MO5pEnG99nmCjBtAncSE10+fk+Osh6VJ+KaA7H?=
 =?us-ascii?Q?abB8L2m6KUP2hLDWYvtf6TPk1j/PlhZ9u/WrfA8WbTiQmAWEw6Z2Ob4Rph+N?=
 =?us-ascii?Q?RLaAFwCst6nXqBhyG3BwLKmZ5L6kiCeaAQvV+eQ+bqcFjVVfCfOFZ5T/yrfT?=
 =?us-ascii?Q?1x7pR9NwfeYAF7NMR4qjfcvEJPw6P7aAa0DfwrdELrXuSKSwcrDCWuLnjuhh?=
 =?us-ascii?Q?dZcHWt7AZW90iZ/foA9Plq9xDuaUzThLCs2+e15AjljSYlprc1xeMfda/QnW?=
 =?us-ascii?Q?XhVzN/v35iWgzGkIYheKtnwg82Doop5+HtIFS3dgDZdmOvwj3SPC2nFSqJMU?=
 =?us-ascii?Q?aP6e1Rwr7uZXZlVQqz8aZUuee75qtDwszU4WDJcANFnwrteDGF/Ez04K0+xH?=
 =?us-ascii?Q?D43E/AW3HUcLR/54bTvVeg1U5Nani+VJ9ZLJ8lPvWC+tdm1iPKD5BL2Zy2fk?=
 =?us-ascii?Q?Og/HQE1qcJSTAoFZMhKHS5/5Pg1hKw/1TLlwGH0KYxeh3o2EDZ7d9AGJ8ON2?=
 =?us-ascii?Q?aoDsLi5/EFAQRJAhjtNFHfip8/i6V6hkAohuoRquhj1fPH55UtbwShgL1wY+?=
 =?us-ascii?Q?KQCh1lh5AUQeon1bdqNvAWABwI3mtfVd6hiLiGFMpYhBCbEqXoYDcn3Z87Jx?=
 =?us-ascii?Q?YWlN37TG1YyqT3ABZb29O8Ww0VVQVkzq/7ae4ADaH5wBZS8TUDOXCvr8WQBp?=
 =?us-ascii?Q?JsaNxLHpR3brOrs+9TlrtNrxMektMDSZjwsjt6ZuM4ftY4CzehJ6rkuxAjB0?=
 =?us-ascii?Q?/xmRBdfakadD62BNWC3fA5xyHLIw9v4g2setNMWbWh9rg1jsVcKJrssGEgG1?=
 =?us-ascii?Q?JBFhXrhVoyRNMGpfjdOr/30kcIvcZ0ZewbnsYQD95j7jbJLzp1IMsKUNUaOq?=
 =?us-ascii?Q?GbhGS+iX8dQumaz+S2jFmrD1kegx6bCA4sNsO2nrbte4P3aon51gq+7mYs1z?=
 =?us-ascii?Q?zsw0Ox9eb0ZwuJXBrptX3a9AuLJLix8p5/kX+mihrs+sllHMJxPHywGJxmLP?=
 =?us-ascii?Q?t1gwBrPydJbROfYUdPIcShOLSLJ2vRpkRx7s3pzkOWtq0183?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bbd444-a3c4-49df-e10d-08deb5961313
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:02:10.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Gm3TXIbCsTENTGycLwnDltSUmFeKED0B2p90MonptEI6ftad1LSb5mbJTIjSZtre2urSuNJjjxJ/yjaAjppcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289410-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 442F157D404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:55:40AM +0000, Eric Dumazet wrote:
> This rcu_barrier() came from a time call_rcu() calls were used in
> net/bridge/br_multicast.c.
> 
> Now kfree_rcu() is there, we can remove this problematic rcu_barrier()
> which causes extreme RTNL pressure in many syzbot reports.

[...]

> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

