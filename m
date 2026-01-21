Return-Path: <netdev+bounces-251858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGwUMQrGcGkNZwAAu9opvQ
	(envelope-from <netdev+bounces-251858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:26:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5656BD4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B28A423898
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6C3D5256;
	Wed, 21 Jan 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="alhq4ovk"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED065346FA7;
	Wed, 21 Jan 2026 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998260; cv=fail; b=HrumASZysumQKeDzDNgvEYncGloBngWy7yisfIS/O0v3yCSE71qNAsH9pA1uT8JSBRWECA1reuI2Noz+BsHNbQLfJw/RDRrzPFX6p9kyAFQkrIGmOLbMMx/hYNKdUzJsMqpqvrboQGvwxDmZUcV+yFFDu2mmFQUVzGPG2IE4piI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998260; c=relaxed/simple;
	bh=mWnc1IANa95NiUbc9ftkWBoRPkEgZsVkv93kvNkymQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c/0JhAFw0pE5ouD3Ma8xn8p4NLIRlLCtNBzGjrONOh48cErJJMxmICn8uFdqdiCGB8yvy+WVcmsPmDiM1Kpnan9nCroI84Be5oEDKKyD07sS7pzxvphLN2mN49prbTK2Q/W+hPz5xGCfZkgW1ImffSD9mIt9nNjuaOMf+h+sn8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=alhq4ovk; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKgOBFeW4VrXsZFWCdguNG5W5HrxqT0dr01OdN/Eo7ZzCQ0lPnwnsqt+MOuHXeAwGCtl6s826Sr1jLL0G8LPt/Hfq7jg3z4n2VbGa4U0rp2du13kr8+H3BjHyvdow+xBUVrSfIU/ezSaX+bu728E4yiivL9o9Q2l4SvAAeym8yoyA0i0v/UsDHww+FnkbQnQXEH3KgZ5Js1WUyd5f1sbyGgQ1HmOv47PFEU0kvff5rGTXiw7J38167SPXeNqfJbayt8G4iL44zogsfAQEzYVtsVC3QOUcgjK0MiVr4jLL89IuEQQ+smupAyT3qK5sBAmINZc6CxfZCBNpn6tjpCefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DehsAOoCJo2JOksd4FAPPUO0N26813y3hlA9Fvvd/0c=;
 b=xgHwHnMPtvRW2E+6WNI5DQKMLBqERDXVPkE6WlH8FUp4RDF5kmNdxQ7HTSEt+n+bN3AIVmAreRZo0kIEv72LyFlU6fQCVnfpx+vc7+QtyLaHjS4sXp57+5jzZYOzF0PCchQibaBG3RI9z7z/p5wxAr3Zx2r5RlT36tdnm34gAp7bWWlwT3+f1NBXErZ0TqWVx21KCv/O6/EfeoJVD71vGMzXipTncMq6aoYDT29iQeiqvbsYTuhHBvmZHwY9teYnVZz/r0qOu9E29+PofJ0hTrRcP80oo1ToHtX3k6K8wn3VjSYO6HX2rsHAIkL9LOhuhuFxjEzuEVwkyinYAo+xNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DehsAOoCJo2JOksd4FAPPUO0N26813y3hlA9Fvvd/0c=;
 b=alhq4ovkNgxS9dh4orhm50AJdrwXslr5ElJfAmHHqEKeht67CEn7YOjgYVgnkPU+joh5XFuGxuUDydt7o/ryNgBHU6eO6t+Kq3l9ZmC3/VyvwBbwUPQ245U0S7yr4sJEkVu89K0wdRZS7x6tg4n+VMlXFhg8OO6UikyDRm1PVuFr92KoV91iuEwDpZiStlq8ogGURYmEIHouEQt6iCz7r0HzwJKHsbYSjm9yk2JyPPcReGT9RSqKhrDqt7gqYYvdvkC4P9dCeuLQJ25V2ek6aRi8zZVX8HKAQyUMh8kSiys0fWW2Gjg8HtSDY35MiTX2oPJ0CRs95WZbx/TVKrHhEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:24:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:24:13 +0000
Date: Wed, 21 Jan 2026 14:24:03 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] selftests: forwarding: skip tests when kernel or
 userspace support is missing
Message-ID: <20260121122403.GA458529@shredder>
References: <20260120230208.328337-1-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120230208.328337-1-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: be72c9fb-84c0-4e5c-2602-08de58e7fcdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lp/JPz3BPT/sasL/OW2iHmvjYDHm4f3HV2kExloNsgNVXVD4h2UtaXCKTJjY?=
 =?us-ascii?Q?AGYLlYWzcHHayli5hhHoJ+jqhS6KsomzCU/l9ufDSPPdXgEJ3J3FOQL0Yqt2?=
 =?us-ascii?Q?fB8Ix9kQJ07OqgYQLj8HHNAUsy4ziVHH/PRlIjPHODu6xdhwgDqylhxaWIcv?=
 =?us-ascii?Q?szdprOVPzRi2An7+ueQyz7p5wcBMq2kPKLK3BDzQMvDna0DJLK8joJBRRkMc?=
 =?us-ascii?Q?dNpzWIRxVLBlddCUkAi6Qr18e809PxLfxyd1CSKxtqkDgle2j4Dj8+tCnTHj?=
 =?us-ascii?Q?OFurZtymTZz19RiTjndf8utxKeUaxrCPopNBBZdrgPMwqYyXGEFNI0tVcWXb?=
 =?us-ascii?Q?qRYg8FzWPV+Xr4MKUc9SYWdQz6h1Ppv0p0G38U1asHDYRqHVX112nWuYtrXL?=
 =?us-ascii?Q?slcD9HNNGG44Rj16ilAjtTIOvPh4aXU8AeMQPTtPWKNuxfDrrDEjp0V5XKGn?=
 =?us-ascii?Q?KWyyTquRFmnsIqtlkcRGmVxdTltRA8MQ6361aJ0L9RGpsYhfU6oEP9DwiKcj?=
 =?us-ascii?Q?6G0Yn9SlDccSLvy/3Z8LT1xPQHRG8/Fa6EBXahl3b0lQcw9EwHFclZq0O2Qr?=
 =?us-ascii?Q?WBOUmQKqhzYdwcaYUk/9ij6eXNc1UB2wYUh/AciOf+pCeMcKVHWAkbBUMLUI?=
 =?us-ascii?Q?lOtA1RRwAfnmVNJ8nhskXz3zmzouIglLPInAVvzbmCXPFsoS9WkCKsBmRNJB?=
 =?us-ascii?Q?hoiFzIzFNdKCkniKrXvUPPP9Zn/h5ELYe6Oupjvx8bXNkdGVFflQjUsnfOaV?=
 =?us-ascii?Q?VQSbzWTjcPcoNIaQhpQ/SgCVpDDp2McAi7MgaOMk3TpcBzcAHagkaBHNrrl9?=
 =?us-ascii?Q?osaoolbXi+I36bvtzTY9zLAOrbRGe9v3ff5KFBmrvmiOS6GzCL+fPtDDeFBt?=
 =?us-ascii?Q?Cz8kZ0mBCuaCPgqWRPZfT01l+J/9jk3mi9QJOklrJ2xtwjH3ZeuQKuhV+nx1?=
 =?us-ascii?Q?D+783iYUFLq5NhHtvNeOR78StRPN3cYdwtWhvjABmbBhvYbjd9Vmo4X6/Fc9?=
 =?us-ascii?Q?PIbjKK8U0fDWdL8i/enECaT7YCTOmwc8X33OTHxpd4aT8Hc1O5+wm/wn8NN3?=
 =?us-ascii?Q?wH5qAehhT7A03dTVKBziwp7W1EYrfRr2F2MAAqj8/oUVJD1MBY1l7r6X9av1?=
 =?us-ascii?Q?OZYqbFCKWFQSi4aSIdIK8LbyvIOhbYpVwqY8FkEQRnFx7LH3LQ4RepAmdnxh?=
 =?us-ascii?Q?mPzO9quYlT3eg4KuxQmjWGaiTb4ORK7pzXOR0mebp9HHjopdbDvqh9lwbFGH?=
 =?us-ascii?Q?7toc5Fjr8bsSpp62xzMA6uBOeOisLD5XIq0SajSTHvZRM7QlBjVBaJveW71f?=
 =?us-ascii?Q?KkYcNNsuPGk3s8c5V66ujnbUsBc2NYc79V/Jr5NtLSahYepzbhHILmO9GJCH?=
 =?us-ascii?Q?P2Cd/3LfcZy3kgxy2M/moTuqTlSWSXADAiMdk+3NA6Su8BAi2Ikzm0AFqkrV?=
 =?us-ascii?Q?H8ixqv+oyIFWHz0C9zteaDayywQphphn3zoYFoq0ZLdS16vNST/K/oXl0tJl?=
 =?us-ascii?Q?BDyDVHpfeg9PdyeddjiA9AQmg491Q/Tw2fZuP2ykBT4De8amDBybGt67w/Ry?=
 =?us-ascii?Q?+zF/mNmb5VTwY8zAJck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lwitkLQbzj6YU35pCRLy0IfbFoDejgQQerfmUshgv/KB64zB0DQNEsYIVdLM?=
 =?us-ascii?Q?FbibRZlQ7qAo4zwVT6yUJuoIB0SINRSIi9+BJYyOCmsiTb6Q/YYtA+Xq4jsg?=
 =?us-ascii?Q?W0cqYf2OENGhEOBlRHE+R852ll4QqF/crNavXUIgkQFz+Dw89gEcs/M5XnL0?=
 =?us-ascii?Q?kHKGl/KH3RXIx9j7flhpd59Tqta6359n5Qft65LaPK1OkLYwt+WyZaQraAIJ?=
 =?us-ascii?Q?LZx4LzuZmQhGYpp9S2fgLIFgtILmnzH2jRphbVnfgHfkXtbGMqyFcrRsE5+G?=
 =?us-ascii?Q?jXy5M+ZFb0mdySHfYiZSiUtUj8z/vGkMbzRT8W1DT+IusKERG+2vSPhDhSUK?=
 =?us-ascii?Q?uuJXkRpIkCenA7D+ongBojuTWqgJS2HhIzQaCt/lTxalPUNeFw21o3jqthAX?=
 =?us-ascii?Q?ML+nXhVkF5BdUiS/6SYrmC8A9+59ritPKZJJprAh4VKrprLy4LBp5+siooOx?=
 =?us-ascii?Q?QQWVCyZGkOIzXnPX35vgSR+3DwPzfg4ouBfdbGBG3iGc8dUa2+6/4SCzsCza?=
 =?us-ascii?Q?0xoXqerGoixX7zkP0OtiF4xt4TWdy1I/G3V4NcFYZSL2gZol6CwwHYnj9ktS?=
 =?us-ascii?Q?YciJ8FqkzLg4fr+B0yZlCNCkG3Wn5F0rqo03TVHrVoyepgB67kIAh4rx2hVj?=
 =?us-ascii?Q?DFYKQprFeQotQvt5wgnJJPPxqQchJ1sLpJGgNpq8o/eFD23DFDu3EXfmCy3q?=
 =?us-ascii?Q?Tee77IBRqzNL79WwdleyI20AcwC3Llp6ceRwb+tfpQqrYAZL9mkLNh4ItA2m?=
 =?us-ascii?Q?JIHQ8MFFpCxRdSGbzc0ypUrOCjsMF56SgoV8z/vwt/hZeofg1Zkrfc9F2uCS?=
 =?us-ascii?Q?JoaHNwZw71yOsTwCp4zCPtQ/QskcT5kVyG5Dso1p3Dnkg+uVJL1QTpgNBuOF?=
 =?us-ascii?Q?+rnJX/3tYgl+z/lrIinLBCufC7eQs1UFgWPQ3aGL+gfyRFUpH5Rh6Ej3wUmA?=
 =?us-ascii?Q?LG6uz2XuaTnXpJkFov0WP1oKun+h2w5gyCp3DYZhUQa59EJzlK09FQaZuLu8?=
 =?us-ascii?Q?aJAHS+duS+aPHlTHntAoWy1kVJUQ4fIXKv4ihoIPBgoHZCBwlPUpxg/e0Feb?=
 =?us-ascii?Q?RxxjxnguCsIFhmGrRy6qplH68rK/8Z2uAfWz5xZhVVhs+U7W0V0+GMfuptPJ?=
 =?us-ascii?Q?1BysrIlVUaszzKCbgFrOJwYiKg8KNWuIGtE4il9A0vuGhYBOXG95W3OfkgDl?=
 =?us-ascii?Q?6orqeqonZXIVCUhC6ftD/g6laEoBAi+6UbVhwk3jBK5p64ppGyr3iPkx16kD?=
 =?us-ascii?Q?iOaXpsfJFz12WSs8K4d6XTcFjtrICZT0Yecy1h8wVKA8MLTt/nRwjloInT+Z?=
 =?us-ascii?Q?uvcw+Pd5oPdbKjrWqpRRECnpBIVjl7qe/A6yDTlKnd+CtOoORaZ3qjbsgomd?=
 =?us-ascii?Q?t6/WWqvAm4L9tJmlTf8/83ZITHe4HJttODZUITmVoFKRJRX0c16AAcKejZLp?=
 =?us-ascii?Q?oQgg6J/xxlHV0rKBXLf7JY4aHOw59/UiX60j5pf0GX/BgEY2F0AEddmeQYld?=
 =?us-ascii?Q?czVmT8kkl+Q63ymihxD5geSb/DqeIIr4BUGIVclFplKUV18UVqUxfDx01KDt?=
 =?us-ascii?Q?mviFgnEI7C3JiEy/zL9MtcIpr2w85fd1ySNo2i9Mqpds1q2Wflhhi2BJiRov?=
 =?us-ascii?Q?Zq3taY58NR30Xckhbt+2Q8E6oAAOvJikqHHL12w31p6mb4ibI++vZliFIDjN?=
 =?us-ascii?Q?NuT+JBGz6KRQh/URVmTBlXgcanTD6Z9FO2io3OhoFAcEuEJK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be72c9fb-84c0-4e5c-2602-08de58e7fcdc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:24:13.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pq5U/RkjSZuO2M8aSpaAqCisLGZViZm4hCO0QieLfAP/NaEfJHxy22cBTkYe6JGcrjfp8qKDWhxF2GrC7jhCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251858-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B6C5656BD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:02:02PM +0000, Aleksei Oladko wrote:
> Hi,
> 
> Several forwarding selftests currently assume that certain kernel
> features or tc/ip capabilities are always present. When this is no the
> case (e.g. kernel built without specific CONFIG options or older
> iproute2).
> 
> This series adds explicit feature probing and conditional skips to
> avoid false negatives.
> 
> Summary of changes:
> 1. forwarding/lib: skip tests that require LAG devices when the team
>    driver is not supported (CONFIG_NET_TEAM disabled)
> 2. forwarding/sch_ets: skip tests if the cls_basic module is not
>    available (CONFIG_NET_CLS_BASIC disabled)

Both are mentioned in tools/testing/selftests/net/forwarding/config

> 3. forwarding/lib introduce run_cmd_grep helper to probe userspace
>    feature support by matching keywords in command help output
> 4. forwarding/tc_flower_cfm: skip test when tc does not support cfm
> 5. forwarding/tc_flower_l2_miss: skip test when tc does not support
>    l2_miss

Both are present in iproute2 v6.5 (September 2023).

> 6. forwarding/router_mpath_seed: skip tests then ip does not support
>    hw_stats

Present in iproute2 v6.10 (July 2024).

Latest version is v6.18.

I don't see the point in running netdev selftests with such old
versions. Especially when it should be relatively easy to put a new
version in PATH

