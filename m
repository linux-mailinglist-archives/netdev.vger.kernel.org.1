Return-Path: <netdev+bounces-295182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rGv+L/ZYIWqQEgEAu9opvQ
	(envelope-from <netdev+bounces-295182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:52:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 139BA63F36B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:52:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VMiqhIP7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295182-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7845301F4B0
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3D405C42;
	Thu,  4 Jun 2026 10:50:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB93DD509
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:50:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570245; cv=fail; b=pmUZ5E3gL6KxhZwX73kG19m2mrFRULkBF3v4BYa1nRo+FmMut9RGygBgN3z8GJgH/aAhZLM6GFg63HjjKKn620uc0+qdMtCUSk16JvBCfSrO+zNM0OT2YS/xKTjtUap3CKu9l/MYbG4F9nhnxPRxMITzmAEGfDK5W9UCnHVQdHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570245; c=relaxed/simple;
	bh=T2Z1Zfb33Ot+m6Gh2/18dDKI3XYoNTBQC0cCbNQ9imM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G351PLUsi1XvQfX+/6bOmYqvu782TT+RzBZuMXpIenpgDUS7nuJJme9QAO/At0xVe5YTj7/JYb/EnzTAILcOmEcV7CGFOQHNiTBeFIAUrouUGc62hRoGhbFicOb54Ty5E/FfpXzPcMwNm+9ydkNriEdgF7z4nOFQjTYZp4Lh/kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VMiqhIP7; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUeCEyGdXQNY72heSUrmjbj/VnCsZlsyR1ofw8+XImFZi5R3iY8V2U5cHp0BNVudYRHumS0jhIBufBmhZfDtHYx97h7FtfmXmNfmgs2vZjZiy9mSvHRXr2ym/hhqZZOHaC3jcnrpo5rbN11vP6Zbdzhhkl23dNFWNUyfelBFflzLpVbjLf6pEIyembpUTqwmRcWc4RnTyvX+/zs7hg2LndUjYQfVpGX/KDxJ2/62i3aN1kynFZ3G9/PgAbaNZmFwwIwfkTB2GSJQIsaVVQ66PKfG5pZaB6QioJ5Ne6ylLSe9KQwScwkMu+8NRO6LfX+OMMjfUL4lgbR1U0wC7s6jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX5ZyvPQUBMLcmUM/foEpyBgpabOzsf/5r+PeBytiuE=;
 b=NaGB+aH/CtDaaS9tjada1UjiGsc4GaNWzGObi2YSFmp41lAZeJMZWHCYDXjqV9m8TQtF+qMHfBMIkiPosQoHez0umCD7IkqUixNFSsaYeilSPCvS6v1PDxV744+Wy2lm+AFCpsFg+2TRm0zJOWcUY4I0eiuJ0tq0suXS/N90dl5rLhmhK9gHQ3kCmHoSWFn+q1AWdyoPeexr8/SKEpaUoxdEL7NAQ+3DdHaBRoZdIouKecg9ADVurR7Zlt9Nc1omzLe4Qj9jQK0G/Axs0jnLkQ5x+LqqH6IK03D90lknOqVrwiqeV0qttSLLdEd8JQsND9hMAVeyAyl4Ya0S6grxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX5ZyvPQUBMLcmUM/foEpyBgpabOzsf/5r+PeBytiuE=;
 b=VMiqhIP7Hqf3iDpAr1W1G2+KNhW03BoGEZw5MQINH9/iU02g6m3kMn5OqXl5nmPGUt+NzSjDDen6nqb7LysK1uH6brLmVgN0+D6XPYjN2Be52R6EZ7+rW0fMhCSbgHAoYHycMzpYdZYdIiyZVibqH6EoQipkn6yKROdTsM//S0/fTDvtF8yqtm7sAdkjQfqdW23WWbHjf5bIkKS8MY6a8YIOJVfbkq3gBLpPgd/fkPBD7zpjD7yAxN2MIzATVAqj6IWfTv+XtnCbX519UBk0Wf5oeJ/dGqwks19pn3r+iYOVER6p/Pb4Yc0CBZhbfhESs53rPHOrHAgmEjS+fB7ZKA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:50:40 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:50:40 +0000
Date: Thu, 4 Jun 2026 13:50:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 06/11] bridge: provide lockless access to
 p->designated_cost
Message-ID: <20260604105030.GA775294@shredder>
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-7-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603062043.3911278-7-edumazet@google.com>
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 497a55c2-a004-41dc-822c-08dec2271e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Zh4R8Keh1wbgGgAXdjG7W1ttyGX8C8GoBhzYUIUFCjgNxN52QRe8YgRiwWsUTbbraDMma4PhdSo7oTU+54+rmj6gYTO38iKlc6VDmUKFgZOdlZEdQDiUBe8Fqpj1eMq3iZd9LPQ7cvAfLim5wq0Oasmq4bh6zi1c/7digxue3dBAL4Owg+VEhz/dO3AyNe5+rV8SPlr1Vi1oqL6pRsXUi1vgHysayy7N8AIoSiUwni+59MGFppjPx4EbHQza7PdGQ81hRlx602EwKNDuZIRANaVgtxNOeik1Agx8CpYd8hitl3H/R9tEfCKVx4WgqRUQ+cfGGkxozVYYmMtB709S9Gw/HBKRuCdvy3zBkmpa6c/eHss2FIYjrVmsYq0VB4H0LgJe5fogU3xHPWYLdbcgNiD0j6UE6gF0sRl3sNohiOPFUCTjLSOxvD1iKVts0De3y1/8TQU0SAqCwdJOslv4fUNAMVGj3cqdt3rHE5qmnfUcCYg1f5BUf6ztAMTzo/44GUD6EaetyeicV6gz1kyNP8xCRxpKPk5q0wGOwg/rDdIxMl8SgWbusqZ94TAJnQl6g73bppfAEP3XVw+RYucgQRblvBQcBiTrMp5A3puJ+FtloP6ChSd1QpAoxSV9qyaf4SMF7XPnpacVbL/3ZLOS240aHn1C3i90B/ZA+RG1r5VWqJA3VGbOrXxl27iLQjpN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qF4uil+y61AsXPpr9u93tFnBR6rxKDDpetLK3K9VFllLYjgI2iYCUwf+HkZO?=
 =?us-ascii?Q?g2DHjrfPf6EEuRtxUMUT2MlPGMcIzpoS2x5SGp4arrJjuJ1NmIxiGMTfpLX0?=
 =?us-ascii?Q?tIiorwuz6sfLmSvCnyKCo1kfGiNL3PJU049NdXS789sKMRl8xsIUNBuIfeQj?=
 =?us-ascii?Q?V80uFUxgzcbKsU0i7X6avDXsKa/D3+CYq48MC9VwXWWxjfrQBndAFkOsecPm?=
 =?us-ascii?Q?usSCwCOJ4dQzD5wkqk4YeDwflgrgJxr7jG3Rh1jqkhmsfTRoCwq2CIyT8IlS?=
 =?us-ascii?Q?Dp4CquYtfOJ3333RpSkekFUDA4aCqg3sMNOwHMAItxKZV9Tx6eq5YOVoJJix?=
 =?us-ascii?Q?WSmEZb5VhhqhvJ5JxUbFZS5o7w1U0oac60nLivqewOLbqBEXjipQ2FGwu3o4?=
 =?us-ascii?Q?/oW4m40TOaP/0fCKL3/eXivKZCh6xbifxo4xmb5Jr5CyGKvANJGg+qKWoOau?=
 =?us-ascii?Q?V0jqUQcJneAuBUUmV+ZuYzZxOGQAYClTk90IU2jvtOoJ8+y7exyYqjSUc+Nd?=
 =?us-ascii?Q?g1PHi1u2a9fvAxTksB++kvl0CBshUPEn1zY+Neh3W1j8sbDyO5K7MpOo/gyL?=
 =?us-ascii?Q?e/GLJ9TJ7qdCk4I3iCWwXK4LJ8PeizQ6bNCeZsHGoXvG1dIMcXmUioXIxh13?=
 =?us-ascii?Q?PDWwQe/L1VQ5hwhEn4kkTCbixHx2WqaJNC2F6xmopjY0+WI9vGl8VDrVvNTf?=
 =?us-ascii?Q?u/nGeW0heMGKYrkPkZzCwk0N1QGiwxU72vFh6B/9H9DUFcq+4kRF/6qcMlJC?=
 =?us-ascii?Q?oeMyqBB27CEykIY2pfytEvg8/ZbPPrR763SD8SReyJaN72EIqwfbYt4CyRoF?=
 =?us-ascii?Q?YlshTLY49g0Fjr1or6YuNB+YQ373XaHNAVTT9jXZutpoiDJNSapLhXJvYfVl?=
 =?us-ascii?Q?iWi92RfsXB1qQgZTU9gk5FJgD+Y8/rKNNv+WxpZyjojNs2Le+xkHbg51KaCl?=
 =?us-ascii?Q?72IXOuBFyWdLugtNqdYacT1FOuthVEoYxOkDNTo77z4G4I367ao9Z6bOfCX6?=
 =?us-ascii?Q?MWZnR1SF46wisjykcvSrMJGA0637A3mJrQGOt3adGX1dP1bPXP+qSfTqRQDI?=
 =?us-ascii?Q?jkQULLUBKUv4KqgZkQva+DpnENZNK1Zh/4LI4QK1HAvlZefyAigeAKDKAgby?=
 =?us-ascii?Q?jDYGXB8UsDw4gT+qxiJAJdKGjd5ew213Qa2vFsT89pJB7vbHkQNpl1dSpZrz?=
 =?us-ascii?Q?rU1KkwAubjqfj8jpoxOHs7kLTj7l0JpqRd+hPVe/UBQ70upetoikJVlHT/77?=
 =?us-ascii?Q?YTOcdYp6xvxyT/vVXFtf1gZ4T0tinI1opvdAl6LdrYLy1k26yKRJrPyWVq/U?=
 =?us-ascii?Q?STXom4htPODn7ZxTkRSDA/m+7QnkuqjPNK7AQ7Y9dBRTEnIz1WW1s5yDMnQU?=
 =?us-ascii?Q?l2/LZxMo/h9JZJ+b0DPHHsRursMbIrSs0hoK94+yb/IfkkxHis7orHSA4oAy?=
 =?us-ascii?Q?SW9CL7/LImyXxiZ9lHVILw/N4rlEopDRZkOics/OvwVeZIc8h+/vw+oQa+zD?=
 =?us-ascii?Q?vPQTG7ZsxL4hrH0uAVOJ/jYyIMWy04uVH6nveo209WM5U4A1ROqnTl14UepI?=
 =?us-ascii?Q?o72LL+gdevQ7uFANCKSCxAf/NdQmf/TcEg6RHP1JYvWDv4RG+YzR9mqRjkhD?=
 =?us-ascii?Q?UUElRjUmqT3QHy6AKo/NnnI7xhgxt1KPuPCVAJtNYBozE5OzhFfqGaIw+BqS?=
 =?us-ascii?Q?rDuBQ/Q0KtZtvKoSKF1NfXnP4l6brbbS6qSkLCNS8Q/R/TDT5RhE5jwnlYN1?=
 =?us-ascii?Q?BpJBcDWOpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497a55c2-a004-41dc-822c-08dec2271e86
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:50:40.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5LaZq8ciPTIGvl6hyvMcuIOxW8LJVyfSnzKzy69mis4Ve7iRtGGk9yRI9Z+RIOz+GRNQq9gWuUlw0d4s3eEBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295182-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,blackwall.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 139BA63F36B

On Wed, Jun 03, 2026 at 06:20:38AM +0000, Eric Dumazet wrote:
> @@ -302,9 +304,10 @@ static int br_should_become_designated_port(const struct net_bridge_port *p)
>  	if (memcmp(&p->designated_root, &br->designated_root, 8))
>  		return 1;
>  
> -	if (br->root_path_cost < p->designated_cost)
> +	t = br->root_path_cost - READ_ONCE(p->designated_cost);
> +	if (t < 0)
>  		return 1;
> -	else if (br->root_path_cost > p->designated_cost)
> +	else if (t > 0)
>  		return 0;

Eric, I think you meant:

p_designated_cost = READ_ONCE(p->designated_cost);

if (br->root_path_cost < p_designated_cost)
	return 1;
else if (br->root_path_cost > p_designated_cost)
	return 0;

?

>  
>  	t = memcmp(&br->bridge_id, &p->designated_bridge, 8);
> @@ -344,9 +347,10 @@ static int br_supersedes_port_info(const struct net_bridge_port *p,
>  	else if (t > 0)
>  		return 0;
>  
> -	if (bpdu->root_path_cost < p->designated_cost)
> +	t = bpdu->root_path_cost < READ_ONCE(p->designated_cost);
> +	if (t < 0)
>  		return 1;
> -	else if (bpdu->root_path_cost > p->designated_cost)
> +	else if (t > 0)
>  		return 0;

Similarly here?

