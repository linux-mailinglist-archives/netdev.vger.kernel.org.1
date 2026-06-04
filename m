Return-Path: <netdev+bounces-295388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id waU8O2fHIWqGNQEAu9opvQ
	(envelope-from <netdev+bounces-295388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A0642A26
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=klrBnbHq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295388-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295388-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 844FD301E402
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE3386557;
	Thu,  4 Jun 2026 18:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979E123507C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 18:43:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598619; cv=fail; b=dDBCEzJzKvxR8tF/gQaeUtqh9IMh1goImmf9TCEzUZi5aeT5W0yGjjDnlDxnVcHcLZ2yV0GqlpDKPWzTGZVNuDxsJt0RluwOJEljw5KN5540tvY2bvPQ04Mfr61GzngxgzoWeSqesTyOyVNFw26YaaPrQPP1VpYoxRPgsJI/aZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598619; c=relaxed/simple;
	bh=YXGiJ3ddDUMcmZiAuH1TKDu/bmOyktgzaBR12zRhYZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LcMx1gh4wV3JzBvJwwX+afpg2IfrpiQKJhZxOT/xqpbnJcLuhfqxpvAXcApNZOhxKHWQr7sxjacpk9d/5gaHnMVKy6tTEZZyC6xWxtEthKMuNUr48wIPtYrA+Htv3CzCWY8jo4XcaqCk3LKSziWA4HTCZz68UHxkCSXSSZX9ePA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=klrBnbHq; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktNYXhtQAELv2ZwgPsBt0zmqMcmNzm91FY8S9fBAiSHh4G225fW4vnnE0dLghUIupNvgnnOoI4xmjwu1bGnLRT0SP60AnibRMWymYiYLkF4VO0QJEX9O4gDvkEeovbhRkLOUlgicrI/NLmJALvGERSwMy1CW/NkI9V3qEP8zzcP/j8r3MfgFTbefXewvzdNipIeaE+TW0goQ8/9E0iZLNRFd5Xg6eAYLG1gWLKntS11/TNnT4Sx2Lq6uZYTxlszjKAAkYfaxUhk9EhMTPDKcqSw8x/guFdJn/0h+WBCoVGw0Sr+0fop7mAhrk3FG7RM7XM2P6vAvptOAdQRW5LF92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKFqa+8grRaCS/rhhsn+7+wj2WWZ3qx7ZvdQcH9Wj68=;
 b=ZCowtO7+9e5yKQJ9MfM5WCkWEWPKvL0/3LgYqTv01EBWLKuiJLFHdRDq9NrHiBhlI4IbzxVYTaljUZdwZ0hZp5qNnAHa5r8XXWME5sow34/o1B47GfXIXiHy10J668rQgKy0dv7n2MuJDarxjsSTuSSG+Y7rcHdIroeCY9QdbgquQrntQLcGB6aEWjXuzzs8aoy3gVk9Z2cK4I5dRGcA+JS56lS5Ld5t4AJcED5UyLvlXfWX8iKyA4fvfoO4ODNzcfZGbqjDWa5H/h90JOmiokD1jVDYdbTGBvHfTgERjftdxffAVoJvWND/7bJQ5PSALY0ayaKTKiqI784zk771dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKFqa+8grRaCS/rhhsn+7+wj2WWZ3qx7ZvdQcH9Wj68=;
 b=klrBnbHqrKPCTnwYFMhS1yy5EutDKkVimv2C18VowbtyYXu8dh1SKfsnDnyylx2F5Qudi7UlqwkFLyQQV2NeWXmW1ZWElDMkrbgc+NH3QUcJSmZZPCqubF5F6GO1w4/o2zkR9F+SbaHjAZ28Del0G9z3hnstLGBEKThwbwaAO+iTR2PaEDHkTy1+rVCWny/25EHiQqHslVZaX6GBLZKn/oQ7+bPvzMH+HYS8Y45k+Cd/7C6fGgDYo+kfSIMlunXNupyOyd/gImtC6fprIlrZ+X4RaJt8i6sLb2hDNWVeHC1zDunewwvaTuynxtNm+lY+wVh6gMoJJRn1m6G/R8mc0A==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 18:43:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 18:43:35 +0000
Date: Thu, 4 Jun 2026 21:43:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next 06/11] bridge: provide lockless access to
 p->designated_cost
Message-ID: <20260604184323.GB877115@shredder>
References: <20260604141343.2124500-1-edumazet@google.com>
 <20260604141343.2124500-7-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604141343.2124500-7-edumazet@google.com>
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe1c497-1e15-4f4b-8177-08dec2692f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	m0dzuvLU9O2NOvQIq1VFq5o6mQ6YGhkdblP9r6m3IpeXBuJzg/3MGYnT+3p7cJErD4Uj6bdz68Y1QYH1sC1ZahmRg3i9c+kL3WIbSyktLRtwYr3yFDJWvI5tdHyodAKUDFqSgLqk43Gz2KK1QHyi1/+3+e7nr/ECLmx+aZ51PrsUsXGj59gkiaWuO4qHZp5WnoKMiVjkpACtI819rk5RotiqZHrcxnxTYbWctTe8ALKFEMhPOvz6/Smx2gKeYmgE+ISGudxPsMUQ2x7TbF5hb/CzrFn6Cbl44pBdFVCrhqjceR/+nhJ+G3GIVHA59hofaJuaucDzI4ZBHQ6Ymq7SiUTE0c4g0+mlebPscXi9lr9S0/cRdwIFrmChSPKAvuOxLaCgbwJaWGehS/p39EFiUwmv89Rh/NlPEd/V36xd1c7Pv4/qmzCFXjK3/14W2oVxlfXwRrUysFy07clFSjrJghEgBJTZ3t6ANxKX3M2BSuPT/d0UzXUMU7za1wxq19gDFFkLiwkgY/KhyE5tk/2BYFrwld+jxbwzLpkVFFmlld/YINmH8q9pX3SnzZmG51WQzxcqQhq4VGFmmKojgA5YGMGOmn/N4GU/7j97jbJilLYdlsZenMtpH/SVQYm/KcjjgTP9knD9J63XAGhWQ0R2Qe1q8NsmjWPQsn3XSvXTLC1o0vP4qP2ijQ24uT961jnh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idiGu/AEAzFj5cCe65gkwexUXohuahyWXSeyKaR0G7Q9U9tfcxkgj90mtD0+?=
 =?us-ascii?Q?PUnJi99QOPBdVAmlDu8DR38D7+dNnF7zWdmTNW/qq+K//Aewj9iKfKvRMAYt?=
 =?us-ascii?Q?ujzfDhM5mJkArwRBewqELaCQW/kzHO5zW2p6bS1qCdWPl+ObP7d+My6A9ml6?=
 =?us-ascii?Q?9TGrCPaPiDIWtUki/h4DmChD4gtC/nN97sGWt6TGuxD8oFDLytWXLdY6AaNb?=
 =?us-ascii?Q?FPEBw9qsLwSARLhgfFMlMVd1GRJxVG2s2PwlXSZuLzve/FzvRyIaRuU0R4eE?=
 =?us-ascii?Q?oQql96gm7z5GtALhV93dBfRRPvtgTnVvLqXp6PMtNXwqGEH3awsWa8Ic+oWc?=
 =?us-ascii?Q?NtqQQRbb3zEfJpYoH7X3vpa569JEBcT6U6Pv7Ed0SITdfvWNJQEgkxj6QCF2?=
 =?us-ascii?Q?giRTc7Tho//FbwmvbXY4gCwsmGLDv9Qkua4+i78TTfPnvQ9xI9MDnbR0NxGI?=
 =?us-ascii?Q?0QAgqWpRwKWd11BpAkVC1Cs5tCVXBFyFzOwQ7i6AT1x+iplW2WjDdfNREivg?=
 =?us-ascii?Q?10eSJ+RBXo8rNzThFtNQMBMrg17jwsaeRdOj1+TDcWLBWRSIa7bXPkUnBcfz?=
 =?us-ascii?Q?YkcX5ourpD+ffNHTFRw13sTXyYnj9AeuiTrFfGS07KG+bZpWQaS/JtWLQWnR?=
 =?us-ascii?Q?Hby5x6Jpt8Vv0FIA6JTFg3i6QeqzuWnl9NMX8z/GXbaBc5CYEiHiI87o22GR?=
 =?us-ascii?Q?0VWzBRCJrdm5VSt781ub7uvjU40jZWEtK41xH2tg6bKGz1hiDbkbp5NXbfF7?=
 =?us-ascii?Q?3I2lSoSzIxrhyzKGPRE2/5WK+3zXJlTHSPfnTEHlmfDIQm20Iwfts5Uj2AcX?=
 =?us-ascii?Q?2rg65wPDjpbkfYKgfE1SwoMhry1zM06orn9WzJd4EuuatCXwJBQj9JIdCZWM?=
 =?us-ascii?Q?UHKq/OmdQDw+AWFBmpt87gOy4a8Z/ECMQ76FiXveqzy7DIQNT8ldpgVjRMEB?=
 =?us-ascii?Q?unUe6dheYKpgvlv5u3ILkA7VOFEUMRTtIuWAimefGiV/bh8j3+NghGbu9uBq?=
 =?us-ascii?Q?nyclG6qV2uXftc710q83Zd81GNVCenkPl4jxPJD0vlt0t/WEQG6nhwvEYhLb?=
 =?us-ascii?Q?3ZiHfy2jZNpZFyEd4T/4T7IiSrSZgQvLQ/u6Q0V2IaGNs5i63ZtRtHjiU7Wj?=
 =?us-ascii?Q?FV0H/P2h4QxW3U4wnCGIX4x8b8X0+dHgF9cvI214Py8RVPpgqwtn9UPfbvj0?=
 =?us-ascii?Q?he4tuRNUZxjdX++vS8wbZAi/oV/tZKMkZ//oSLt9d0Uwy7PyvvemJtQii9eC?=
 =?us-ascii?Q?Ld896YCcm1Z5V38s8IJ37CT0YeG013FroiHKdCNqFfFLFHesQGIa7ixTOTWP?=
 =?us-ascii?Q?ZcBlUG9k6XtHdwn81LgnUJhqvhtfR7YtVZphncefTVTN1Udc7lkApVzHOLmR?=
 =?us-ascii?Q?p20masmls9tKIhXaGhxaJbvcebRYb0gehU0tVwzgJpVrRdJ2x8in7RDHrYtr?=
 =?us-ascii?Q?xuAupvcylrQzDLcxRTe5lD1zxGEH2hsKkgbcDjx0tEKIDAT1j8YY1EWOBNZV?=
 =?us-ascii?Q?6IQiLcJ3TVnTyH29ZP/3XtbPImC7tDwxomt7sepdG4SpB1eZNXEIjqTU/urH?=
 =?us-ascii?Q?cWisqyDAIJiL6yLH/0gq1S1wtRPnMzTcl+nG6bLOujjOQ8I3XRddv/UGcUX7?=
 =?us-ascii?Q?373/uUQvgqafvUJsSJNBWkbbM7SbRCas4p0Cwg/JKUBy6l76Ys5kbrmgxpKK?=
 =?us-ascii?Q?xoX4osZ3XufcKSHBTP6GJnD8rISqYqd6P8lZU786YFJeXuJucbK1xCDurfhn?=
 =?us-ascii?Q?5gOcfnqoSA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe1c497-1e15-4f4b-8177-08dec2692f0d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:43:35.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGjTEtN9sm+xiu79OfJcHgrd5M7Ak2sxEqK1EffcWE0Oc2pqXneSz8+3s4uyNMAKa2E3Prtl+JkGLsTcUSmAuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295388-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,blackwall.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE9A0642A26

On Thu, Jun 04, 2026 at 02:13:38PM +0000, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_cost
> 
> This is needed at least for sysfs show_designated_cost(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

