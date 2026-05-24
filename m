Return-Path: <netdev+bounces-291175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMdeLJrzEmpq5gYAu9opvQ
	(envelope-from <netdev+bounces-291175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:48:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0542E5C2688
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDD930071FB
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC7E3932DE;
	Sun, 24 May 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zmus6BF1"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0142D8DBB
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626896; cv=fail; b=CZCXPlo/EWsiC2+zuPVsk8RRYxGF7mZQ6xu5Jzy0vdk+kh/lJi3yqF9ncQAM0xHuXIWT3fGn+R/bdO3xIhKScS/UapTkXmMyx1Ft6Ei8m84AYqUVB2mFbJBKRr2w/NjpFQTSuj4VbWFM1pTJg4g+WieDxrVrvHv87wyGAVpEams=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626896; c=relaxed/simple;
	bh=QbVn31KuGCSQxBHbJ5Ef8Ww8FSBRtnwDMMGVEwNnlKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TuT1XYx5QGNem6OvLiUwe0KN/APr2gNTq1rTugFILD6stJ2pLHQyGu1dV/iQm937G0Fu4bH6olFomRwfj8yxPGoDwtFd/9KUwaeE/AfYHdcpjM1aenq+8otGCD97klF3f4B/i0AkfIBX6f43B0iXVuK765yLRLJ5y83taFpOTZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zmus6BF1; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbaRchbzaFEf9+ux2n+Z+l7wDFOKWR1b6qV982dHV8vBvc8hRxiGXoXAxTckxAiBlb6qnmP5v5I//Z8PJRMmp0IjhxquLpFxy2uBUFPwgUIl6wS6InFV88Q4qxS93wGKau6PnPAK4sbaBjMdydEqgnLTww1jFwxc/OFCM/CBnMtiIElqejc0bFCgBtqa9P7xkhE/KEJG2bp7RuZUNHBcsLZv08nLoGht9ZqHlaNq3cv36tAbmkr3SndsQpGyUSz/shhEItQaQWW1dK5vY5BA/ud+hKWnB/vDIiOA992kZ+w1oqjxYguN/RFqVrKEa6iAPEsV2apYxiiDYO2EPb4yhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czQ+wpnoYjX+R3Yvwqx+6MEDZZi9pkCBRZCHE97H5Zc=;
 b=LqLNh8Uk+W/w9vwczdQK8lz7ePHPissJVZvU8RWfHY4gmylKvgBBv6xysKgiS3wtq6L3PnmnpPdutq2HBnvmZYBqEgfG9onGbZgAluqCxCRlvJiNdrzasjzhozrYvl3gK03RZ+SfJx48uL5FTN1lZg7mWUuggb8Dt+zcEjWGBhVtP3WJ69VbtM7xEb31dm0mmUcSdUV6nokMgspUPWF3dnXIQcaTChXoK9QB6SyyEMKnKc7YciyVap26T6YsPjXkPQwA1b8v1SkIgwVkhMG7H2QKP/YjbiSmm2t0Kg7pv/azzcfrhM54S6qD9ikkZKBmzLmNSWx5q7XJMBgxvt6vOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czQ+wpnoYjX+R3Yvwqx+6MEDZZi9pkCBRZCHE97H5Zc=;
 b=Zmus6BF1CUp1S6M3cjMqYFE4MpLXQ+9NcoQ/IxZvGdMWHENSWCX7j7fbiLkchZFczOTwU6669tejCAHGrT6+0b11cOa5afv9/CeKL0mJGE7/pwKum2u61GqhfGoPVvRwR/w4Fz3RB/wqissA4ylQ66bC6dowcZQjqA4B+JUfnroChxUsxSe6qlWTzUbZ8wJa6fgGfyjeR75bke1mobk8mtvLqYaZ/hTWaSignWwYWe2123T9XwXEpb956do/IhH3CuFXcOQVSFn+A70E6BwQ8AOdGg5R68sfaqkzFF015KtO6kmnd4Ln7QKiDr46mw5if7QXj2cVVcZ/eO0kIS0R4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:48:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:48:11 +0000
Date: Sun, 24 May 2026 15:48:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 05/11] bridge: provide lockless access to
 p->path_cost
Message-ID: <20260524124802.GE74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-6-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-6-edumazet@google.com>
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 03dd88a9-0938-4acb-6934-08deb992b6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	FG6/aR+aFTGoU8ps9hasdbvOarP1RoA6KnDX7LsKP8QeDhD/eJP/RgUVoO1mHK7VTJvwWMVHtzdQ0TrdZ90PSCjaTOqd/y2VCo2fBy2ufMO8HfHuji23QXxi4zkI0NRtWxcDnqCgiVs34hgp9FkbfYvX8sUD9pUqCrj4d9/N9swUeAbznM9QL7OCkD28DsTdEE1+H8reB3dLAsMqsev3xGZf43H9gl4cSTNxnIP68npc+XxVVW6eydwtSuqaj5ak+zUj/LnddhGbC6hbESWKps6bzHqfnclxTUlD90b9T+cIDnPvjljLWTDbZbAwHbWGtpQsg2Ppk8gBK5cBdLNdK4bZMTupkLHxz8S79MtK2PEvVMPcxZ1weXF9bohB8hLT13iDdoThG+hNUt7eALpteCYQ9xVUjssM934J3IPEaZB0AMG5EqAdySMThJofD5mGuDcQR+VAyqpOjpTygRelKz6vph65fapei9uclP+lfjDyvIe5M4m7u2afDtnUlSjd8WxlXFl9UjVa2H+np0wLVOERYZZFhdhXp1BTdbIOhXZYVFxwpTdX9G1p5o4OcTjuMfgIT0bsy3Fn1+5o3uynoLXx1dZtHNOz/auWKt8wGFFl0rOpAbTBGdtp86bEUJTdacQPArCy8Iu3qCTYHyyboLgNL77e/mqWPwCrk1EB7IGJ1dT8jbbVTEY11jrHUV2I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHI8TgFt6qTBoH66gHdl0hJJ6FisldGpKh/GNunQwQdVBO8EAym6Zr7YNA2U?=
 =?us-ascii?Q?fxosPIcI73twej7Kjb6YNZvyDCKgyBuFkjbGg9UTFq59rzn8Z0sWe5CbiU8q?=
 =?us-ascii?Q?hRk4FoRy7eR6YuLQhx4PSuBlUZrT1IwXTVjUsnW7Xi6B49Y/yIh5qQqMYB+h?=
 =?us-ascii?Q?gRgyBb6QRgDm9Lyti9v+Gw7XcQ/V0axFHY+2uRgRgueTEPA+y9F+UwBwhIBt?=
 =?us-ascii?Q?bYfCQ+aou3pfkaOjnbvgOaoETBimaAJaGVThAslF8TRy5vsAz9g6ShI2NN8B?=
 =?us-ascii?Q?UJ1QXvumk5Fa4fYTE0hstFY+PCuqfXrkPnvIGfRs/c9Xvsx2MqHkoyzhFR5T?=
 =?us-ascii?Q?XRUV5lGFetQ4d6eg485bO/SV5ZnLd8gY3lqfLJTDKIwcWevaJ6Ea3Q1g7b91?=
 =?us-ascii?Q?a6aXjlj5eMPzQhyQreYjY7usFIuWnkVPQ7uOfvZH0/GV8Vp/wwoGTCB0eZpB?=
 =?us-ascii?Q?KXY9/Z1/9moEZvBiBNjfoxRLKKO925uWMlPtP0outuVH3qMFVjc68Of/3KgL?=
 =?us-ascii?Q?r27ew3L+uWWhR7DlcEfg30xaDsdc9i0uqen2LMibjx+/i52n7pIexzzi2sBD?=
 =?us-ascii?Q?UPeE+5EXJ5N7Q64fscKSyxCsGlpRbmGM7bOvDV884gu06Y/1K+PFhMOdWtK7?=
 =?us-ascii?Q?YtywfqchwkJvQWPmY10+GnwG3AEk62HtWWaqwPb5Qlyabp+my/zgPyJ1p2/V?=
 =?us-ascii?Q?a9iT9t88Dj9KKa1HHwWkNNsH3ZohJbMr+SyKDrKHIqSZTJIC/gktJF2MTYrw?=
 =?us-ascii?Q?jnZnnmGWG0MEKJAEmtT4Xb1IBLGtYBeTnVv+oDm8DDOaEAOmk1uywp4tqLo/?=
 =?us-ascii?Q?7lIsfE55ZcDwEvxKVDZsaHfDm6GB464TVvQs+8PCG1wX1VcJnVpU+Gdx+C1u?=
 =?us-ascii?Q?HyU27M+8haRYLxzYzSUHNtjy8HIDu9dGN40L+nZL/sWheAhiBi15fpfqUO9q?=
 =?us-ascii?Q?lOVW1nrlv/wyQxuu8l7k6c4iXI2O9q1wQbFrQ33pP4NC3aqSFGcEeTfzSnYU?=
 =?us-ascii?Q?KlnJ+XUibE+vc2TbngXO76sVEfCRUucZUSyweWFccyGvQJUhLFG43xj9oOZJ?=
 =?us-ascii?Q?MZ0ma1OpH7n4AivXPSlyPWQokxtPngkY71ZaJxEopMF0JNQB7Jlg15TienNL?=
 =?us-ascii?Q?6y2SUCXIITfFIbFUHIkZFnvNaQF2l/qXaMiD0CYoCy4P2AnGKI/7dvXhFxKw?=
 =?us-ascii?Q?71XHyqMeNbg7MyjxNXwPy7YujLXQL2ALFLJ5pIQ77G48yx7EGHzCP6z9D6to?=
 =?us-ascii?Q?HC2ZCIH2gVoHwPpdu4xu6FKhzgg1n1QQxmXkTERKJgC2zFc2HANlIOYb8svB?=
 =?us-ascii?Q?jqF0z8vwrUiphql9Vu7ibMrYq8rw11MDJjthiOF5H9s6zzfzAlhVWPy1sVSx?=
 =?us-ascii?Q?xZiQBcp+xicdxgqLeV8PvHnvQvDjq5eZYMXSDYbPpJugcKNmcdmF/V6t9FlK?=
 =?us-ascii?Q?O0rK6hIouYKOQvlqI9pqWNmuzROjOjHaESqlUUVl6Oza2kZWRLjc6YU5C1nP?=
 =?us-ascii?Q?oj8ayYSto1Q/y/saIh27LIJ+0cXW52Y8tw+GhOU801bTdmI8bVyz02GIaBnL?=
 =?us-ascii?Q?4LSxreuQie+xaGaGGwoeBREH1GppAesajnpGkRgo2Abpq2ZVtHQQOp26Yq+t?=
 =?us-ascii?Q?v4f5/2GBzNLjiHyb7TX02WMb9MClrUG8xdBUK4DodPqICIvn8FD0VQnDDQxJ?=
 =?us-ascii?Q?E58vGa62Pzv5exyop96srymthvv+c4TL1s58hTdpAW34ZCuF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dd88a9-0938-4acb-6934-08deb992b6cc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:48:11.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePl0yvkzpxzN4of0B0PsaQeFCGOULH96vcJWyNQ9U53iYSzi3pPPYBwTD7KmO/r4OQOuuqu68jHHBfCNtPXh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291175-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0542E5C2688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:10PM +0000, Eric Dumazet wrote:
> diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> index 024210f95468308066827ac2ae71f68f99fa77f5..1367cd3ac4dd6a587d4a6471184453a14af6879c 100644
> --- a/net/bridge/br_stp.c
> +++ b/net/bridge/br_stp.c
> @@ -125,11 +125,12 @@ static int br_should_become_root_port(const struct net_bridge_port *p,
>  	else if (t > 0)
>  		return 0;
>  
> -	if (p->designated_cost + p->path_cost <
> -	    rp->designated_cost + rp->path_cost)
> +	t = p->designated_cost + READ_ONCE(p->path_cost) -
> +	    (rp->designated_cost + READ_ONCE(rp->path_cost));
> +
> +	if (t < 0)
>  		return 1;
> -	else if (p->designated_cost + p->path_cost >
> -		 rp->designated_cost + rp->path_cost)
> +	else if (t > 0)
>  		return 0;
>  
>  	t = memcmp(&p->designated_bridge, &rp->designated_bridge, 8);

Both Sashiko instances complain about integer overflow and I think they
are correct.

p->path_cost is [1, 64k] and p->designated_cost is unbounded. So, even
before this change the check could overflow, but now it can overflow for
a wider range of p->designated_cost values.

In practice it's probably not a problem since 802.1Q recommends a range
of 1-200M for port path cost, but I suggest to keep this change purely
about the READ_ONCE() / WRITE_ONCE() annotations and avoid the
unintended side effect.

