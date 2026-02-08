Return-Path: <netdev+bounces-257842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DRtDu+2iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:16:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A6109634
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5422C3002F59
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727C34F46D;
	Sun,  8 Feb 2026 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OVCLdk/a"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF22258ED4;
	Sun,  8 Feb 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566999; cv=fail; b=K1HRSW9yfKvVY6kwdUwfy4Bx2MYI+iRPvCMyZnrkpfsKt7RTLeuyYnCpphXqi6mTmxlyIGRJidJbAbwkSVOpECcW/UtgkBB5odM4VzH5llme1zPTe3BZO/cuzqgwgF45aOd4TzemnwuKM98FSexlATzqlCEbTIG7VDuw2VSb/UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566999; c=relaxed/simple;
	bh=qI+cj4rj6vUUjaqRKqwMqU+6BuzXMNi3RcnrJfp0axo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=stqI0Xpi2IYt+dqaki1LJStuxLNtFKbaRpXKuZQkbnaKbZZn5jqEyLVg3M658taTAjNVL0eQCYdMyarwDg3UfbHHil9sSuaHGOuic+9Z1Q89S7FkYyuDeiSZIhl72fnu379Dq+vSbjvt7Ks6mFLgB7pcchM0mxgOWF9NGMFF+Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OVCLdk/a reason="signature verification failed"; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPJsu1OgRgqocuEFZGer8INfQKh3aJRr7nKW/0c8sTREA8KRnRd9PZjvFaaOKZREE4nwsNwJDjxMkhzkWnC3k5BnvrvdQx5SNK3u5941YxN+Nz3Fa1VfsB6KeCsfNs35z6hWRh4DmGhb3RGMvpNlWmj7FKxiqncDrlYasKjE2zIgujt8rQkfyDcXJ3gHaNekTTMBf67u6DuEdDNPFgfPLc2vuXQuK4SsXAIwTbHAvyGAZtfmnH+62QKKBSUQcMJAkVQbUnr4gwgvus32CHeN+DWOvWA4QnlEJ34OtA45IKANlSCoZFOXb0zuXPMbi49LwMPtmte/CRnpIMLSxFHeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnpUTXGquRjaHhUCRxfMRzhGXYY3WquTy1GzVLYsoPI=;
 b=qVoyDgRa8XzoF8vu2fmoZ1N6sNePreUzOTnj0Wx75SsmmcP545LVCe5Dg7UTnIiE/eVdbEnuxpCLxpaA0DtTMOkXGv562Qqse15EQoaDKNEfLPPYph70xy/6byTw7RUUgARWeIS4Ks6bbVOJ/JD2gw62CT21jm5L1YhhY64tpA9Fe+lfZGtuyqQmk4XQh6t66m6xpxfT3OHylH0EnhoUuw6YBlBNbzgvtJ85wK9kHgFsGuGe0SUGM1pEFAe5Far1ong7iAPiTmddH8ORImvMIqcvpVOMEU05Bmq1NofeIEjqd7pJHMW2mWbI8NDkjsqyshqrqoE03+1hhlaIxJDUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnpUTXGquRjaHhUCRxfMRzhGXYY3WquTy1GzVLYsoPI=;
 b=OVCLdk/aJ7Q/ktJafVQSz9LfxrSnjvwx4YSZoWfr8V19W1YHDwSKtDxJxPow7cYui6+kCzHamuO9jge1j1i8NVIwXA5JpLKLYd4bsXNtbvZyGec49bX9YsO40o1RCwcyl7d6mOnYH10d8MsOHxa8GKWDVlAEy5o1/nG2sr21C2t8xLcf+m/lROc8Mq1xZHxhOoZS6mAZRUlxJH36vyT0npp6A34P56tQz8DNv1tCEP4Lj1fvrh0z/sPCyBP2osWc9kO9N22vVHwGNLRllcExGn9sqZUt96RmE6WcKOTrBrAv122GbiRn/YGcoXYg3RVP9HwWcoZ6Ms2BSGAk8huxsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:09:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:09:56 +0000
Date: Sun, 8 Feb 2026 18:09:47 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 08/14] net: bridge: mcast: track active
 state, if snooping is enabled
Message-ID: <20260208160947.GH154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-9-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-9-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR4P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea00b4d-bd59-4aac-5c9a-08de672c8066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?4m73MaS79bjDeKEx9NE1xhC6aH+cEZmMwSkC9nHRD3kJZ3DzoRzdgV0gz8?=
 =?iso-8859-1?Q?KQRcAgCdsbLr64pw5KrBZBCevyWhWVzSrenanvyv17lu64QJqZJXiRlqlM?=
 =?iso-8859-1?Q?RRYPTLT+U98FDzgcHSYxbTx/Gt4Q65QV5v7NNE0LhVD5gqysEHNtckj5dd?=
 =?iso-8859-1?Q?kI8UlI83bs9+59g7AJ18JWfCnwbZKmKDuT0JCbJGLPCrcXUpk8994DkgEe?=
 =?iso-8859-1?Q?4YFp6uQtpx3isK6qlUzblYKfU5g7bKMED6PTz88Jwiyl85m1A9TUgGavs7?=
 =?iso-8859-1?Q?RJ1n5LAmnijn28LTVH1BF3i98oNjSUr5So5sJ3Y4gJ2izpYzNq2M6hp1GX?=
 =?iso-8859-1?Q?tWb773YvTiPZnu71XfFJqMrTzES8h2NiPHoN5HkEpiVMmsPUm/jbntcCKz?=
 =?iso-8859-1?Q?AOh8e0JcDQZGL3AdgP3bUznKBD6SA6OozeOJx6ip9tppwpBt03DSLW5HEd?=
 =?iso-8859-1?Q?HfIZ1ujrlaoOx0zU/At2Xac0YHugBHCPSJmcpfwtkMM33wMZ1NpzWVqY0y?=
 =?iso-8859-1?Q?traT/zSYjzl9TeqMeNaLujbwyZfZ8bxB1+t4DACFJuPGho7AIGANEyqAYb?=
 =?iso-8859-1?Q?KsBL5orKeoeHyFRsY4/ByNMoH4YnAIsnIGhb4Ep6lloi7VR7KzKa0oOM9c?=
 =?iso-8859-1?Q?xHGUET7fo6cZvMTEarV9nhyaxl4bB07xDw4AEa4T3un1vBRzkt9zDmM/05?=
 =?iso-8859-1?Q?5VQdoCTDBJqNpg8zM6y7zMztjfa7d4AI+hIjs8RsRiVCQR1PE2bI8HofD2?=
 =?iso-8859-1?Q?Knssad8lpJtisfwye87Xji7A8sVAlBHdBpWzadS/2kT7h0//JN/hHBOmse?=
 =?iso-8859-1?Q?gojdvzcR/SDJz065H64+9jFGLtYJwsshX9IaBTwbSyhnS1/jGSLsIdca7k?=
 =?iso-8859-1?Q?vAGEBxTJxK7FtNJsT7MWChEm0dBd639lsAXuI0VfNbE1g/hbW4yDUyy8fq?=
 =?iso-8859-1?Q?xPtuC/DNjPDb1t0/8QNUhXeGv2MCJPPTH7m2tT9w0o0JVtKw6dxc5L6vxK?=
 =?iso-8859-1?Q?23nkxP6Y49C/wltXyCQ92y9ar2Fl3Efk0FRrIIeSA8qxyGMkMFe8ptV5SR?=
 =?iso-8859-1?Q?84LE7a3WKwtwt09Gqe4HOyQebDAYvb4/dA2gyx4pFH9nyh5MHJF23GCKhS?=
 =?iso-8859-1?Q?P0AUx/S3SPn+m0NkJG+0tgR0LZrFoATp5OCB1jZd0yzYGnhL0zbIVV51cg?=
 =?iso-8859-1?Q?WAkAtUmSRTQwtwamOi6wpwcXmYvdbSwMatzDBdND/HmNwl/jiaJalKdzim?=
 =?iso-8859-1?Q?qGiicF62BzU1YYYXHFWqMHEPj3uTSX0ouAytoVaGTTFjEbYONlMBJdfEBv?=
 =?iso-8859-1?Q?q3GtZqmVivz+dvKc00w0OxtLnfFNVXmHY7ANSzG3sFYljtXBNV/ppvsWeg?=
 =?iso-8859-1?Q?+g/UxlORGGNZLw+G0O1W0UfipfFz5lfZHq1uzAP+zmPXNx4psZ4qKFXjOY?=
 =?iso-8859-1?Q?febGFyhav57LFf63UcYQntBIvYUEKPpcrRapRI3QZtBLzGVK6a3qQ5BMpz?=
 =?iso-8859-1?Q?mTiCi/2kZ9n8Sqo6AzzEBZGmltR5+ZzSKXfhx/6TeL0pjY9tTz3KUnNfi9?=
 =?iso-8859-1?Q?h1jNa3WAlCZ2HGzxk//ZPY9r4FDX5hmoDk5FBcOVN+QtrI5jt4NWFLfOcX?=
 =?iso-8859-1?Q?8TAO3DoPgVN/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?KAG+viTkz8EZ/cfcKOSeq8XWkiFHO+af53pkeEMNFE8Lu7aCvnz/GPQC1E?=
 =?iso-8859-1?Q?b+p/6T3NqiIta759HIpd/+wXV5ta5cQPJQXIbMOAGxNINQgYPLCVKK+Reh?=
 =?iso-8859-1?Q?1YSoy/rFzwxgflSanES8R3JhIe5AL7r4ejMcLuv811ZGBZ7dZl0+XVeMEh?=
 =?iso-8859-1?Q?dcuU3U2cwc+eieZIW1V67vWUjKWgIJrgTZnTIhYOCWE5FHIsSRekhrS5XL?=
 =?iso-8859-1?Q?J/D/7BOW17m07C3NnLNbk8J37LgS5Yhgf6FnsZhbM77Mcnu0thYOIYAg5q?=
 =?iso-8859-1?Q?APqnv+DBM/+Jra+XpHFwLsYwMn1DKYkd1HUpv3uMyrZzuW1qpJp/GFCLpw?=
 =?iso-8859-1?Q?jpVXlOo83Z5D9TM5vjwXQrVZmRQX1kLzP1rPHO7k5u+WPCj3reip93Q8Hu?=
 =?iso-8859-1?Q?XNeqB/ipSqyLj+QVZ3/CgWnhPaD/wGPnJNichLBCGvP9W1HZOyKXQ/r7Vg?=
 =?iso-8859-1?Q?6NtawJYX0o3SQrptryurtvv5JG6D3cXUiVoRIPiq2FXihZKT1PolAv2hxT?=
 =?iso-8859-1?Q?aXgACw8+MrDNs4X/dSgoe8TuQ1mTiGpIHjh3e0IC4Zu5alOE4leHRURMcZ?=
 =?iso-8859-1?Q?ZqTq1Cp6bd7u6C0kFd9gSvx78HyVbv9lcrq1837LfunRDGL61BQye4p5fC?=
 =?iso-8859-1?Q?JgbjsBE094rqDIIdVCm/Djx8TSzTy6izGFr3o33jRZCw2sbXjjIYVGzfTG?=
 =?iso-8859-1?Q?UQ+6ZGKLjY24xOw5yL2iQb8dNRlIdPBDGVUQbfmXjaIDB/PW1Jro6dF3ta?=
 =?iso-8859-1?Q?irgzig28Rdyp3ech8l+ZPiIJayQcBYGs++LnXPkh3hanoXmTJlxEMbX0VM?=
 =?iso-8859-1?Q?33bs3v0lC6DlLCHJImPCQaksLMe1wnMuGKl2BesUOFvdpd8fwy373uA0kx?=
 =?iso-8859-1?Q?RWtXMp3r47nTl6OOjt1nKaEbAJD8TQbXaN4DC+2/PqnmkK8UP33dnjS8nL?=
 =?iso-8859-1?Q?kKYoMLZN+LmoZwCc/2Q1eD2Crq/wz29rhS9LQCOU4GsmhogEgmFLlvS726?=
 =?iso-8859-1?Q?V3r0EWOBpHlvTznUSEPuKX16giis0Amzk58Ix0qJrfEY69z8VLxMycLXYu?=
 =?iso-8859-1?Q?dUCGNOnMPQwl0e4Ov8ouIRIfgXGrxMauX06VaEiagM9Fgy85P7peOvDUSz?=
 =?iso-8859-1?Q?sq3IhEKZlNQtVR5326RANt392ySuwSe8q+k0adPD0vcl3yhmgJnoB6KZf2?=
 =?iso-8859-1?Q?wysWywP0waLHWf2xWkCMueRwjNVp9a3uUtc8n+zZ87AT8nwEmDN5TDM3fi?=
 =?iso-8859-1?Q?Ed44+/iMXjbVbmiWJpNhdaX7/tspibkIifGa2Uegto/7Wh708ydd7o+MQX?=
 =?iso-8859-1?Q?ggX/ON3jm/1lBX4kxkFfcSdcjHPqK7mpRxo4o131gvK6Wiccy60Ejnw40P?=
 =?iso-8859-1?Q?fFaFugQrp/xV66KG56XSiwRxXafac4bTs2SsIdfx7emoKJgQ9RsJEP72Qf?=
 =?iso-8859-1?Q?AFl67KfJzqFEt0Uddf31elvY4uJE9pRqQ/O+TXzI4nbUjJdKgGDau9ysPI?=
 =?iso-8859-1?Q?rc6Xf4YyPivvQO4EgZNs/f5fKzcSBmhLvkJ3vZ5UDGStcxFwGaHI/+bs57?=
 =?iso-8859-1?Q?E1EUXI7BGgK7aeIEWoN78A0Yr8FVlq9SaN8iAkqmgHe+hvm4qXXg7iBmIC?=
 =?iso-8859-1?Q?r4IcXgl2R86OfYeK/pJpSzMsea6Dtk/LAnT8wukK9bgbRKPMhQAYLl3WqQ?=
 =?iso-8859-1?Q?u9dZrFLBHW9hIQEkqVTbkyz29ExwnYqi55+YjbKVctrXlnycvuMvEWIziQ?=
 =?iso-8859-1?Q?4aXEAqTOqoFu4qFWVrqdmCfPdIrqti0zWXMrWNhHUPBzNC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea00b4d-bd59-4aac-5c9a-08de672c8066
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:09:56.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWAoS/Q5RXIsta4GvRQQwtmEHQUNe1LV2WhXbui0/jlmQPXvkAVZfWVVIHmlbSox0bsrHFAv65L21sHRDjblZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 657A6109634
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:14AM +0100, Linus Lüssing wrote:
> @@ -4471,6 +4481,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
>  
>  		spin_lock_bh(&br->multicast_lock);
>  		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
> +		br_multicast_update_active(&vlan->br_mcast_ctx);

Can you move this to the next patch so that this patch is only about the
global multicast snooping and the next patch is about the per-vlan
multicast snooping?

>  
>  		if (on)
>  			__br_multicast_open(&vlan->br_mcast_ctx);

