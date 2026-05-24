Return-Path: <netdev+bounces-291179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEW9Mx30Empq5gYAu9opvQ
	(envelope-from <netdev+bounces-291179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6E5C26A7
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C9003007350
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD1392C39;
	Sun, 24 May 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tIsKXMyF"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715A227BB5
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627034; cv=fail; b=kAk4MLe8dTUblN0d/O8GmxSlgl8XJY87nBibBXAPthH6EnD1Y2aIPbInvJUlQd2A0ES3gOUSdBhvvn1vQSeCETX5VBB1pC6FCJUQhTqGzII+Q9arBnSt+8bgY0YGqpVJWiItm0j+QGlUaiwm1ceyAruYBLt992Xpmrb2qfzMYcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627034; c=relaxed/simple;
	bh=XJ0yZv4/f3s8tEObTnVSkzjcHXiIOpEvVdn+q2N1xts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpex5ovi8UiNvxgm4WYM499GOi5OBWGasmCjDdCE0eSD8DvfDGVzOdeIEM1AJ7cfLHFjFWyXyl7ld0UnztGAEcio0Yp55G/7hT5fOGLLX7wdHETAB29dZF1vK0MVr6ZKK0nU4p8dSzoTFiDgT+Y7QuPTCdW7P6Wo8KMgeYMQZGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tIsKXMyF; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1Rycj7YeU6II3JuaX4ZDk+ORhydRX/f6XMOAVoZCgErIAUQzDuZegKOI3WaYux5PB8rIzJTck70TX+55R1Yo7PsxkHPKbQcmBO868x/u30Tk7MHyzzxY07qUtgwH5/pvRevL+pEP/1Fe3iVHxglcN8STSYoVuGLxvSDO3aAzN9aGYXLm2+CiBDn+z2J1f7/7kpgdbB4y9SO3QTmLKoDovR2gJH+AAEKciJJ16i+k+s/GF3exsD4GjIHoo80cK8FnFzcqpR0vgoTmFyW+lvkc5x7Qb6s4EPjzSl30gQWHqNAMSGbjfnqsIk0xYJvhMWJtkmif04RK0+lhgYh4HJtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1VyLoYp8XMjFCGza+COGvT/WZBHnrsX3GdZnanO/Sw=;
 b=ktUzZgNJQ7/3R/OWuzV/7kURCR1X0EiFBLhxSoo+Ut1oPTvj/iwoD/Su7EbewwDsd/ktIkdVerUvSfEG21Rg26Ki57HUqAw37mE7QLEGAY7cfR1zs0TWAlCqQUztVnFGPN5aLwJLdIEPM3corcyqYAYOcCtbG/7eH7JXIkJwq2ruTx83POtrRgJo/41aiximpThDVDfV/foAR8P4zIAGKVs90v9SvGYX8xodUyR3fvRiOmHAeFZKD1KeB5ZT5ZXdRdJ2ZKtVM6f7lzy0Ham5KzG2H7rsmj7kBX2taau3Mq9S1efPplxK+fVE6j3Ue9FrJ0Agb8erJqEyz/IX4jOABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1VyLoYp8XMjFCGza+COGvT/WZBHnrsX3GdZnanO/Sw=;
 b=tIsKXMyFTagYf/wXtJdYKMIGd6QFu5VKDkiD8g1g3XG3FgVGWEwjPOaPyVdiGETjiD+/KgEepSrTW18vJsQyaDXdWek0ZeQpg1fN2PiV1DNrJo9L62pf02i/TlmsUnng9GCJwz3A4pVk90px75YJvybWwnOKPrZ0SSGXd0XEvtU58OcZnnuQ2B4Pn+Xyk/pZJmQ+O1AUnVU05ao43iTaDt/pieegG685b6g8PBAe8UJJhIrnV3AvXH1sTRR6qU2Tj4Xt/1pm3Eg6Hx6PZQJD7/EWkGwoumOUGYxyFBVvbip/uOxKjZMmMeMZ7pCIfhlg0ajvX5uf25O7m6nQaF1NoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:48:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:48:30 +0000
Date: Sun, 24 May 2026 15:48:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 06/11] bridge: provide lockless access to
 p->designated_cost
Message-ID: <20260524124820.GF74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-7-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-7-edumazet@google.com>
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 014ed7b2-38dc-405a-241e-08deb992c203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	G64VrZpEpYAaPDgr/djxhGBWDpyEcQvDN2YzT+2cX5X7cxYxKrCqRhUEp6lSSfrpSbe5/l1qT1ZMV2zCMfcv6ChC68bJHflV7YiVLruJhi0+AuaVEGEI7e+qBZfQN5N36WydWMI+2KMEa50RmHRCgEGbaLQ0HsAZ1B515A3y8hccn3poG3N/8KRRZXMF0U8RpTQrlqK8lIopGU5owfNKfriaKp5g7CUAiMonkmeii1Z/6QZbbiBdl7/UDbJp+oMGu4uGJadsh2kOBE4v4g6gtU0RHGAvFuvUDtS99PD9m7Lq9F5PD0uzXBv9h9eC9e9swu6xM026edZKgZ0iuheYBLEWumquovYuh+4wEZYdiuxNLVJfLEF6mYdlOf/VHuU8Un84Deq6PFSds+y00e1sSR2IBkPbcm851xoHxuj/+54JOAA01kM4HlwXQEuVvb2K9Lkzl2ZAJX/c0WL1KXxeMdp4ZmIKjedntN/WLB9proi6zPynh1JOdUUPRDgDPBTGUtvJSDoHGplt9W+aspxKLlvfDVscV1lFIIWDwDx1pSIArEPaQUCelTixSXoxeHd0wLX6qimQBKS1RfuEQFA8zJqz/Id/3bx3YMlW5o2yI67b2VbZoWoKlIXOaY9yI0a5Z3ZKnFXJ8aaI9sXGkEbQdiiolywviV7WE2HPNRqK4TTSKKQjM0zGxZG7Tir0E6ra
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iyeELtn5dqsrksPDZ8FlVr8fhYARc1cjzlWdjN5RDS0FZtChqeE3qMY14/1S?=
 =?us-ascii?Q?GU7G/XbnSKlxQo6/+UmKDllLQFza09ZhuyzH6Rc6DiTFjbIGv/EJeqQRIl7s?=
 =?us-ascii?Q?jX1KmtsPevft5cn+e4oYPBPffaJUjovhdkCFdKvAeADEboOsftwNzYrzG07F?=
 =?us-ascii?Q?MjZ5QQkVuoXi1AXo85OlkPB0qIlEgZe2J/d7rxbeqC4MtnUZiDoDRKgXmP8o?=
 =?us-ascii?Q?IwOqq98IgwI9pudfK7gvEd+h3AUhtXePg3imR3UvMOupHQ2wlgvQK5eb/L/c?=
 =?us-ascii?Q?4uhqv0IRikwiowIDzyGMhR7/J9nxra6vH0LuMrO+2FBx2Z7+ycPC9t3+9Kdl?=
 =?us-ascii?Q?RjgfsweIp3X4etZVpcwugq+PoTBoMObIiE5as7zdxQ0JlPt8I+o4Wsxy/gcd?=
 =?us-ascii?Q?BZu4cgbzAHJzaF4V9EQIWgGol7gEePTSrn/8YuztlSNZ22pGEJeKXf7QmvCk?=
 =?us-ascii?Q?wv+HL7jubT6WjhFuU+0yTOGzPjmhlV6EBnLmpata9SHbGH+uiAZiUtMYhmVR?=
 =?us-ascii?Q?dfb5h/fb1c9hwne04Uz/hoeJqyjek8NevQjt2uh4WSVH2zt6b5Ff8ykMtZ0a?=
 =?us-ascii?Q?N4rBw6oBZjSirj400kOEvmADSTEQGvU6ElsAsDl8yphYty7rjaQBpKem0ZLc?=
 =?us-ascii?Q?i9qjf+fs9oNXSAt1iYVYoz6zyZBlGiNUEz6S9Mf31jHZEWXd+Dkkzc/9VJxf?=
 =?us-ascii?Q?H7uvAmJQw4Q64usdmpJVxJ9U7SZbh/piELhNtRBolll2wpjt39zgKVr4CmTH?=
 =?us-ascii?Q?JIqHs3XPXCKOLINtJ04kXvQDnR8g2jDGH7ILNP7IJMZjfOwpTOw+mH6HuIz5?=
 =?us-ascii?Q?OdNoX5njwOHe+Gt7UL206J8rEd4myoEaAaEbUi58UNq/o3uID2gP/7nCLnwY?=
 =?us-ascii?Q?OGhmTrsTsOcDRuc30T69FKx6xC1Du2F46yQ7dfZnCwh/FLjpR6ndizGfk+D1?=
 =?us-ascii?Q?TXrUr5yKOl5l1soR98Fy4MqATMsA96/16V+ak/K7+kyk3tv9joeQwNFcfIeg?=
 =?us-ascii?Q?e3LWPfTH8yRWXGurE2PiCo6n//ZrUs4lLTvnsfbi5XiwD5NlhvzDo6sD/B3w?=
 =?us-ascii?Q?+WPwNCyh0FP/4AhNhMxrgpiKYDS0J3rz4lf+mq0jG1UT8eqwmvQU1v/i5za2?=
 =?us-ascii?Q?HVaqOsmf4RMvp3f0+qvzO1DZyxveWM9cByYBq9/LaEmv5keNZYNC1jJmNYOk?=
 =?us-ascii?Q?IxZK7266HO2QqgrEsNcomZbN+kGUhuMJnDTzbCmd+a/MgCy/WUx1bX2ktEFO?=
 =?us-ascii?Q?96O5o3aaTTTBbWl4PM0K64qPwQUcnd5ctj3dmzv1g1Szqmr6qiv8mwokH6eB?=
 =?us-ascii?Q?qtUSzUS0nkrS6snMKWMh7HB7tY1mr0mmlaQLlfTpqO3DGS0+xSpUJp/Gs3BT?=
 =?us-ascii?Q?jNVKiUi6Uo6EpvFAj9ZP9n3KYqdmqYKR5WPxEY43xJkYPfAE8yVtsEcqRKh5?=
 =?us-ascii?Q?yFg2VzSanWNunBO9IRCXI5fDGtJS5hqVju6nisJHmFuaVAD9FAS3kLKBHUtw?=
 =?us-ascii?Q?yb7kbhSKZH6f9mC0zeKBfj9vp+jWtQkoOVaJm2rdyMezdTXw2pHXvNTVQq45?=
 =?us-ascii?Q?8xX/i9pJmkl/AccHJTwwWBP+d9Ibg2rQimqIA0IO9N6HORUNKzigqnLy2zwf?=
 =?us-ascii?Q?PS/d3iDRm+SJG+rEG1u6bTv1tm5iwF3D+PJKqguhhPmlPnC6p/Vff+UXKZA2?=
 =?us-ascii?Q?vCsGCoXFsnIogTy4dDRDFomwcagV8SD2EBZYUD1wWi5iYqkv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014ed7b2-38dc-405a-241e-08deb992c203
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:48:30.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKnXRWPLiPB8SeH+XuW3D3sVjCDNhuspcIbfVslEsd+BsXtO1PlEIk2CRWPueSnoq6EiNcsrl3b2FBLxRPGctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291179-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 18A6E5C26A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:11PM +0000, Eric Dumazet wrote:
> @@ -299,9 +299,10 @@ static int br_should_become_designated_port(const struct net_bridge_port *p)
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

Same as previous patch.

>  
>  	t = memcmp(&br->bridge_id, &p->designated_bridge, 8);
> @@ -341,9 +342,10 @@ static int br_supersedes_port_info(const struct net_bridge_port *p,
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

Same.

