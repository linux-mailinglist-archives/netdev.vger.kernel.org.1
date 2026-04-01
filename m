Return-Path: <netdev+bounces-273838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNvkOvaAzGkFTgYAu9opvQ
	(envelope-from <netdev+bounces-273838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4EC373C75
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D11AD3027E5A
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A831F9A0;
	Wed,  1 Apr 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d61Acx19"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662B314B62;
	Wed,  1 Apr 2026 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010033; cv=fail; b=nghog+lqcmvU6Q2I8l9EIf10IeUgWTu+UDfNp1ECYY6bMBBouPyLGSwrdcQSg+xbMPt8EaLwk1DZMq4H1peP4qjNcnQVhQHVIgtA7xeDDTyKbfzAKy0W8sZgCpKlsWN1eM6g1Hc0UsQE7zFJnFskBPIDdadNAhcaYBFzUBND5CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010033; c=relaxed/simple;
	bh=aXeCOL+iZaU7KG4Xskahd7R1e3WhI8TyaPi2N2SxWy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bG/GXB5mkLUS4g+CxvwOsR6WQ0ciQYO4uOAXDBn37Rg0hsoCUnnEjgkgFt49z1Y6cON1jJxTU+cWCOaa9U4/rVsJpI922lfY2MTyL7w1vb3w8rEB/JueeEF03N6V1JuARXrFti1ujJqM+geJ8LMdBsOgqhm9lGhftLEBv4bp9tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d61Acx19; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH0+h+u6t9mIFAqEgUfFCSzmimwriN3eLfgdIQ31BNu9cfGuTYgEKgKdklXoJHNfqszVEyIAgE7Im5dHatAHaiSpUPQRNLaE2PjH5CKIIcgtVwoocdLwLxQn2H8ypfpkBSU96w+btBfdR2nuLJP9bi1HUq56yHtJiz7Qg+e2e+Vc7ka+5XTfm07koLQsOc2Mr60xtj2fyRKGZzgXSE/YVxScOFSuM6x6S8S4KIUBIdx0Ou7xpeTPuPK4ndIIzzwKaejDrrQ5LkLuztGqRjX/EQEelp14oIpHWXkILFD0DniQuZ4rIFljxsnzFIiUOXVnwo0C56OHUEPbK0ru3Ly5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSzYOMnYz6RMb3xj1DrEM/4rTkBw37+PnTWZNeB3+B4=;
 b=DTMifQnI2Lbop3P9FQqZNDn5uFMqDxkxmkjGG5SkigirG4Agtz1pQI3tcuYMQuJ6HWClg0gcA2Yo23JGZ2xWklrwuy8HIY2BelGqT18u1t6cNnUZ2Sq/LnzxX74pZ26Y53UdP5h80qD6tx3sfU67f34e2gjPUXlsxX/1hXYh4SXB6Zr0zrFbrNkZfjjldMbeHwAG/ZjCD7pvikJRj/dxOaZNwEvaSxYO3DVQ+l1P0hX0/j2RT+V60N5Nqs+p3WtOLUya4RyhvAGvOjIh8RpDPOHq3b6u53Zduwtpgac+w7Kk5KvZ59jTtVICb7mRj9rcFdpzyaOzWm1uBo0rGv8Tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSzYOMnYz6RMb3xj1DrEM/4rTkBw37+PnTWZNeB3+B4=;
 b=d61Acx19NiKg755NOaRl0f2ayf0C8zS/j9xJ4y1XofGxvcdDQAFP7TfQv/aM9egaDX889bsyffDPwiL5NLLO78JJAR3AHGhvj+8YOpc0yc9r0JLjO70FFXIEf9ZmB/+3OatfuloqfIr5YuGIfy9svUoA5z5EbUviHPFwtvv/dsGDUeNtSreXMEhbJ/Xtad0NeEWNmR8lszDM7FM09MJZb08LQshP8+vaYw8v02LX/qqJbURyZx0FR4FyobQ/Qdl+oQwoaXitRgPEeRb6qfI20bn1AMORXOA6UV6GfEcQt9v9bvK9VOsENu4r7qA0hHdtfaTmV/v6a1btZD/1Z56h5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 02:20:28 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Wed, 1 Apr 2026
 02:20:28 +0000
Date: Tue, 31 Mar 2026 22:15:49 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Message-ID: <acx_1dOF3EjvGt4B@yury>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 95917a4e-2c67-43f6-c6b3-08de8f953da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o04GyfrGE2BB/UCGqTw49cnlwnSSpY+PjlxH5X1Fl+0DRml6YuWUhDmqDyc8XACVznhYUv8DlyRf3eUOycNnvGnmpZNTdeA0mBln7i2nD4ZHg2zU5YpyWumKH0IhXVbWERb+Voh9ytiwdmMXvnCMY3lQLffNFIY0JRzB5IIU0a1CALQdXN1slRW/skN/zSLq6d30pHjhKfzU0rUaxn3Fenu+ceLr9FlhmqjtRQhVEQOP+4HLkoTK6i1kvm/GGgxQXg3Cxx3a7jO+vHgeTITH8xJxmacJ4lnB+zbtovPclM4EtvxVF7k//elk9sZpEk4KVJvqsYYkx9JlQorYg6yZN3LGUMv+hS+h74x/Uknlb4lV9UiQjjzjnGIjP8uwCzdsyeSmrNeYVQuH8Y1mDGfwyPxk4eal74vJOw2QElgzQvF6h37VMrHCtCcHMvYO5Xe6DTYK9+YdYwcxzi6J9tqU5CaRvr8rfxOjk00C6QeLjw9WBk5t3uV+sEgvOWohoftwA328tzOadIL3PmYpDe1QszBXVoZdkUdfjYMnbeEmxA+TEvU6bhPi2IerjRYH2JkQBF1i7smZxXVsGqwW8K4033UhhC8CS7ADNbx2IHnPiY6y+sAhNJIYhjwkys0UAkIXw91023oPgTxSibp1i9hzrRvStLwnK7OPVMS269/phz06i7cNfjvIPCuuCRQWebDkCZkVIuEw0rPIYsK3uHmuSrqWpX3knFViGOlPHaCjXHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NIfjNP/wK4IvMSyI7kOdyjSvSPAC/+FuyoVb9pE/mSStthwJTjbsldc/QBmB?=
 =?us-ascii?Q?baujXrc867UFqlcD+UGcah/tdE65EIWObIO4s5Pow1YP2m+gx8j2OAGye4w4?=
 =?us-ascii?Q?ysv/i3NQRyhxrMVs4Vvcl6Oi+L+1d5WAIziy5Wc85JHqVv6RDVVqM+8EDhfh?=
 =?us-ascii?Q?XnppTCeNYfDWqZvE4YzySuVJStKbMFW2IH23N+QeIK31DVbxZ7g0pL03ibua?=
 =?us-ascii?Q?Cdw1zXgi2H83WuYghkpzUVaC+Xd69f8HxjYw76zQTNcSq4k2X1yEfeKgWGvT?=
 =?us-ascii?Q?PRcYo/4geivdpPHJmvjFCQkyq6EH8J3iMhLa7r23btohC7Ut2nplu/CK0NAH?=
 =?us-ascii?Q?QmGDcLwNCfiTu1ta5bdG0d5EFVEOmY1BROPm33+j+xwHixDGnZpZggG5VoVH?=
 =?us-ascii?Q?MqwxaSmsROCW4y/NOdfyI1zbetYprmB8CgcsKhlZPt6UQPDugnUqjEKkjIUK?=
 =?us-ascii?Q?CaDbRWDtaMFi0WhiWTT9LgdsmyJKRfjDZJjBrl6jCMSxrpFGzS+qlGgyCHPw?=
 =?us-ascii?Q?e2NnefwJFCnee+rBAkUJV+kOACNSE9otQv2LoyVbnjiPy2pM+uH+fAk/V1KB?=
 =?us-ascii?Q?9YCvzAAOkfstvZUaQnV+bqHC2lcI3eBYtZaWHiBQ52qoeGcXsgcFumHWPACD?=
 =?us-ascii?Q?gZRKGpokUKd50VK5VxWtEeTfhR4uHSbMaeOdvDuyU397fRt8AOnBXspH/q2c?=
 =?us-ascii?Q?AwCUa60rqDStWyGGWlDM1lJ4uQMWjhGFR68qG4YcUx055r1H28OxkfJNWMqr?=
 =?us-ascii?Q?1CzGNi9ll1bnDdeVBC51E2iuIGXes5Qbuk3bxPQ+cG9L4R7dkvLCWU+/DSEv?=
 =?us-ascii?Q?Xm5Uyn6kJZi65U0x+1T/sO0Q+xGsqOzAr8p8vtVImsax5S0C58xh+AwZplwT?=
 =?us-ascii?Q?XbQ+xtRCASlL6ptzz1fW8IWMeiasvO8tsAhrZ16zLXnD69dC3HN/T+kBaGYi?=
 =?us-ascii?Q?dOllreTQrEsaBAxBXcFI/zQ8ruIPdb2GFa6TAv/AHOW0aZ4fI/LXbhqzt8AL?=
 =?us-ascii?Q?/r42vH+a2vNY0ozMWV8+338rL/U71cXKQdz7PWhmUT1ODAE2aZc/R2hQSwHY?=
 =?us-ascii?Q?LuBnuB//PVI6yLASxZfbwTs624jVPrQm2H8iMOwATEjO7a9R1tTBKwbTx1i3?=
 =?us-ascii?Q?fhkgvTi7+tH4kyP8PbLl2ENBmGo2Zr9GZv+QhD/r9iodbPSxRiK34IT4czgp?=
 =?us-ascii?Q?NtVTZEBQCqmtjJ0twBu5q7BieVpqNPzZ0jeXWs7SUyA1J6hjxZmWWL4dZcgi?=
 =?us-ascii?Q?87H2bLzrc+ijadZ6u7iyw1qa/0r7Ya6EhjAWuKH46oztUxFQgtOOOjFiIxdK?=
 =?us-ascii?Q?z6kSEQjjVR6gkpLGrzRPFdqiVzllgMv+NEuTTzqi1qvhBDyQ4fvQ7MNhgbOR?=
 =?us-ascii?Q?G9B2Mv8+e+gzskkWHsq2SgAWUUn5fBjmUnwcC6pRvgwaMch+dCA6MNHi1pkw?=
 =?us-ascii?Q?xYHozPyNMORccTresD2RzXaLZKUM/w6T8sCqyVCz9PjFjt0ZrSp/b2NCiqFe?=
 =?us-ascii?Q?pRlQhpo7xlNbCeV2NhNg+iCqQ12uS7ninRTjvTVpI4s9PmOpdq00mAGdT6J/?=
 =?us-ascii?Q?+goI6ih0I+dGEBU6MvBEaq+BfMENMObKeMDbDVFL2eqRTaQatGk6uPBVRP9x?=
 =?us-ascii?Q?R9GfcNg3ZdkkoENAvkoL6r6aKvw4WoqR+gJXyWHaJwXqVOiP6GaoXKB9KQLv?=
 =?us-ascii?Q?9zKdudgFx2PyyVtny9e79PY7HaZhz/tYPRHo1b6QSPtUjUDmRH2ujWP0QW7n?=
 =?us-ascii?Q?PkwMm/axtFHrammCRh7PQAHmeT7uAeEnSpYhQnpXVyWoCC5u8yxT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95917a4e-2c67-43f6-c6b3-08de8f953da6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 02:20:28.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfzxW8WLN6usJXxXC3wsMUBCIRcWhPBLEdJQsWULKbZSGgus5Hsrbj35VH7DJC2EjRExB3Al/nJH6GA7FxUoww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273838-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 7C4EC373C75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:00:04PM -0300, Luiz Angelo Daros de Luca wrote:
> Some hardware stores logical fields split across multiple registers,
> requiring partial values to be reassembled using shifts and masks.
> 
> Add FIELD_WIDTH(), a helper that returns the number of contiguous bits
> covered by a bitfield mask. This allows callers to determine how much a
> partial value needs to be shifted when reconstructing a field.
> 
> This complements FIELD_MAX() and FIELD_FIT(), and avoids reimplementing
> bit counting logic in drivers.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  include/linux/bitfield.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 54aeeef1f0ec..8d6c1c309c3b 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -111,6 +111,19 @@
>  		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
>  	})
>  
> +/**
> + * FIELD_WIDTH() - return the width of a bitfield
> + * @_mask: shifted mask defining the field's length and position
> + *
> + * Returns the number of contiguous bits covered by @_mask.
> + * This corresponds to the bit width of FIELD_MAX(@_mask).
> + */
> +#define FIELD_WIDTH(_mask)						\

Please no underscored names unless necessary.

> +	({								\
> +		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_WIDTH: ");	\
> +		__bf_shf(~FIELD_MAX(_mask));				\
> +	})

I believe, this should be:

  #define FIELD_WIDTH(mask) ({                                  \
        __BF_FIELD_CHECK_MASK(mask, 0ULL, "FIELD_WIDTH: ");     \
        HWEIGHT(mask);                                          \
  })

Thanks,
Yury

> +
>  /**
>   * FIELD_FIT() - check if value fits in the field
>   * @_mask: shifted mask defining the field's length and position
> 
> -- 
> 2.53.0
> 

