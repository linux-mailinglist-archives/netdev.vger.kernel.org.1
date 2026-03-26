Return-Path: <netdev+bounces-272137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O+0IbVgxWlM9wQAu9opvQ
	(envelope-from <netdev+bounces-272137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:37:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A119633882A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 080123190822
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81223FD14F;
	Thu, 26 Mar 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YU3eeaNT"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57722DA755;
	Thu, 26 Mar 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542577; cv=fail; b=Wr9/1qVP0xWM14ILBjkvXeJc2wyM1HTUzREBYUrLBDHAWUwQPlSAWZZWsnT8Nl+WSCW8YnM7mFhcuExTHjWfXUSVQO5EE/0hLZNCgn5XaR9LYEUuwSWOqekdPzGZ7y+VeH8tbmxK65WQtTodus9gDyIpY/1H2TKRprF7ekxvzOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542577; c=relaxed/simple;
	bh=3E3mQn2UyPWmbHlEEjJ8V3WiSFaRuhAWglG9n5vDT7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vExLmR9qSAH399ZcOHLI+hDHC3vbe6sD7iS3JpO04lSaWLUCrGS8dpB7VqhQuwFG1FQ/k9o9EgRPhGk95v36ir1nHaQRwRJQMDeCcCyNEFlKWorxCihbGwE8M9uBJLZzdErUVOxr5pwcU5WvmvjsJxOJPpb50+9KxHrZDcHvOdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YU3eeaNT; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuuTMMnrWRMR/jKdBOXn9vtbmB2mT1DiSQQvl8AGJ2DbB8ao5E4oGoYhSt1oja4uJtObyFmcUKADTlJBuooYw3RCey1+Yr+wgrBC8QqQBaRWhQxMLoNpfTzW26Kx1pblyP01QfkcorL8azOMQvSuwc4x1ViTjrQBzDvMbdEtdQmWlOhUVqMRoLY8i6UH5v6syljpSrcbO7ufVsVQnBTJSnsPTgz3XI2+aFvyX+avUif+xdpBvbmg9UabOBgXVLm6P5176kzfJM9y0B0FPzwZOTYU889WatRYW3YJd/jcFWNfkAti1OSsqxpDIQTXOrXHWBltQxpbc61O5W9KkztFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTZkoJAqtclntFeekHfP55qGOqnRDXpz7ZBIMP7JIGA=;
 b=fa9u650Uc7APOYJ6vRQufqEHYkHMh39odL6e3P7f/Q68JM14WGxG5QdXVhkeQwBeRs7sz736q7l8bIugaAg0GX7Yc9nDL1Q7B6sWrc2JTvRy1YshtRPfGK68aAMtZgynlKTyG1nApbuFnMS+7u6dj2bgJXk3MT5mlgJ9YhRN7Qu4Fdt4b6QkjGJNFpbJr68FJHZFPyN+LqjL4gCBlem6SPcZMFjzMIdGG5gBY72ZWXAYpPPaavykhjH+IfHIicerSouXS/LEtQ473lWnAzZTKoGEw2v5mPGi5fYd3ud/hUumLjJf4sz9aP0dBHUkD2NUvOZUPe+ioVjwofDwrgsFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTZkoJAqtclntFeekHfP55qGOqnRDXpz7ZBIMP7JIGA=;
 b=YU3eeaNTKUn6yO4jk/u57fwieg6E7WuKUk2I7BVWSSRTDUFSRKL2VqmRkNDg4bO+NE+cAPJQDCEQwUNXtighcSCyxMIJ7CJyFYPWBtRuTjJOFruO7F3vEx8WAuEE9bArCReBcZjNuxXym9ltVvL+kWPIvOWhfZowkw9Z5NANZHCP5uDESYWboTFohKqJM5zC40JTMSSsHGXfTwQs9Bs0b45L+9EolYuKE+rzq4nAFOdH1cP90NiTQPYtbcahWMMwbHSTzcO9Vx3bksKhxNDQ4fqicnJ2gf7QzhUdnwJ865oB4ceSf0xoiFVgT0OPANsHWpx06/er5K5ulrwJ3zbJpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 16:29:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 16:29:30 +0000
Date: Thu, 26 Mar 2026 18:29:20 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, razor@blackwall.org, andrew+netdev@lunn.ch,
	horms@kernel.org, florian.fainelli@broadcom.com,
	roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
	netdev@vger.kernel.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, tanyuan98@outlook.com, bird@lzu.edu.cn
Subject: Re: [PATCH net 1/3] bridge: br_nd_send: linearize skb before parsing
 ND options
Message-ID: <20260326162920.GA1051615@shredder>
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-2-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326034441.2037420-2-n05ec@lzu.edu.cn>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: df8fab28-0ab9-46f1-bbd8-08de8b54daff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Gh+XCwyMLIH0QqEsrlcZrLAvfgkZkH6YIHGWp2elMaw61q+pcbx/FplNzfhuuQiLh7T3rZvR8taqvJbOrWyhTGC/GGLpD7tWcERbKCDq2Fj1AGG8w+psY4t1MkkinUbvmV+8OkzIupQPk34GylyC4w+6Z/PCtqyXbJn5up7sf/tftA3OJ1NzsdWa5i4aAsRKBEvLquF7+9BwL93XZJjXfIf4Zc+YKM0r7pdGL6KBemBdq+RaivZUF52QQkLYFFSOCzcA80WRvfVoYj0o/BiLclPYyisY+p+xhz3N64GOYN8HYsnZRx4BU/G7c46Xr41mWoYUJNXIF/INqy8DtFYcnBMRJDKzwXoPZ3k3mL3WJpm+JDq72VBLUIjZ19y+uyvPlOf+yMUDQ9PQSTexe7Q82vvv2PuNSqrY4GDzoaxB0x7Jal4ViPt1K6JoO38DXm488MnMhwBrCo7x184w3uOzFFWPqmSCZtOcrO46CRE4tj5wrX9aGH+SrC+J3P6uNJLOjI3FNWKvDY/bhxmBY53JtzXtGfYMdxM6ftOmAT3lH+kJioXx/m7sWfbh0FxeW3GC3ruFP5y8zc1r8Irwt2rBwOzL92DqMtV6sgaTtoTmwvv85jLHkhAjm7FsWENFGI4/ZeuKhvBJM2Fnp316OTr+ZUiZKzpTo1FuvucbaA9ZHk3OsDzEKnhRBLFT9pQ34nNtMyyF25RWO+deSQO5sDXC0KcfXcTzyTUYU0XpnZJgzkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNV8OKIX9uAerDzOLERnJ3Df7JLMVwGKmrm+Izh3Jp9dWVC20KDmGmZk01tr?=
 =?us-ascii?Q?Ip7LgRnooYDcBxPrAJzgovvB2ZRbxeCVl18u6c4ZoM9ENInIOv+z9crJ6p5S?=
 =?us-ascii?Q?UPj57fyBunuhe/Lv7dEZwiCG7zLsR6jp/A+1lKwDGzJPlKGmBrk5tKdG/uLZ?=
 =?us-ascii?Q?YyTjhaY2SRtGAxwdOPQh7e08DKrS4Pg8f4wsLTD2BH/Nhnn6lyG+9hKZo3mc?=
 =?us-ascii?Q?CaCq2ajmjefTghgLat9vIoJHZskFHAZ5F34kq4Lgezz7Gr/CyNtYzL+ixlIx?=
 =?us-ascii?Q?cfI+gBOsKou+zLXZXMaDF0EF1qV6JOcTTGiRFyMhu6H/ZtI+9GgeVg4fYT2T?=
 =?us-ascii?Q?rIf3yErOGku04PBFfRXiDM/NQI9Jsy11nPQ1qpEq8BMenjFG0Keegpa7eErX?=
 =?us-ascii?Q?cw+5+ELJ0yqHpuJeNco+NvGAjig6Yd8gNUh+KNtgOyW5kIt2NLfdbL3AbWAI?=
 =?us-ascii?Q?u3s/C4/ZmUxFXfgdrJotW90Dh5s4uLkBHciSNvlUDywObrCyXE/z3WonyZSc?=
 =?us-ascii?Q?joP3euuQp2q7MZOKjNKPW8kkoTJ5E08y5tgm8zKhL7gSNZeYg1yQck0BF9CI?=
 =?us-ascii?Q?MJ2vxD2OQGLrxXMAjjYUDwsXWUpgXI4ZLXEYlse7d96YyIBlgPjtrG3pWucU?=
 =?us-ascii?Q?C16jxe1gvgKGbb3xcOrFyTO6MdNK5XwenzKCFmP2UgQhqfGjar6TCbOMmmeR?=
 =?us-ascii?Q?NYnsUpmq18sxKZtNkEwGCaCk0I25E2SMihp5cSvk72slcl9cMnwcDz1f6VvY?=
 =?us-ascii?Q?2iIk/uOhTl/FiOpxQ3n363Wy0BIPmLmsFDP3vMNVEzTWtPqUp4IO0xGTv9Y0?=
 =?us-ascii?Q?oTmapWgw+2L0/pwCFXRVnNw7sKRy/NnTs/sQrwRBuIfY6Cl0jZzZNhsv0/Hg?=
 =?us-ascii?Q?zH+UKE7kYwIh4RCJMuU/Y/w7cwTFyHRtdhRgsByikpFE8Wq/P8QHEL7O1qe7?=
 =?us-ascii?Q?ZC0g5Yf5KXkQy9P76KyWxt76a/6fjwXRN5wBDosVklzPrqE1K2a6UJuKKzg5?=
 =?us-ascii?Q?cML9UT5tAuEj+aEmm89XbOhJe0Dzp+c41/6SPJ+HSunCgUgwhjjb+YTwyzq/?=
 =?us-ascii?Q?hdKj0QWv1FQ+oxfi+wTJpkRrpspFQm9YyNfFou6wmzltK5F/R0YaRaHrpmYK?=
 =?us-ascii?Q?sqZEooyDAQg9gG++/11DE+w5ecagPt0mG8sWyr947ryMHpfy8iAQBuWgldmw?=
 =?us-ascii?Q?a2mWv9iKsw4VxFo/HyOwjbkYbcUBGpBhoeSfHTnx/4RdBr0ygqOE3Pq42Ki5?=
 =?us-ascii?Q?8u1793fbMdurV2t1770+A4uIuFja4+iAPauYlEg1Gvnnbv4Mj4mnZXk0M/2S?=
 =?us-ascii?Q?Xtk4xH8RQ035BK2MCVP5IrfVb3G87beso4xrFqTlTxJEVxit5tcxZP+fLGqP?=
 =?us-ascii?Q?e4tY5yxCDF0UKaOs+RZq6LaKqWF2LWooa/TP5a7HgMwcflzm1oo7ER/ia7u5?=
 =?us-ascii?Q?qYnh5b79YJcEwG87w9S/H2MfW6WnVUY2D/KVDxqojU8pZlqyYVReVAOvPsCH?=
 =?us-ascii?Q?/0BwKG1TcytG/J2W6+3xrP/8VhSQhHcfq0CHHWkoQRS6qkY5BhN7RqusEoDe?=
 =?us-ascii?Q?8/C+z//Ov+/VvTUBePsQa2gOftdeqEHfUnxgkUV6m1stCc9rhPkcpJhWeOpi?=
 =?us-ascii?Q?7Emdjj564WMEbFhNKexnWsQ1AvnlHpI1ZJDOWDX8vxJbVBjPgNmxkuKwpgtV?=
 =?us-ascii?Q?RytykBMcNhjoiISFAbriuaIFPdwdk3jPl+vqIVniVaPG3hL4CG28oo62CnQH?=
 =?us-ascii?Q?/imXBoO/sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8fab28-0ab9-46f1-bbd8-08de8b54daff
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:29:30.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +k7ilfOcjEoRB3UF6R2q2Bhgy1ZGZ2f76iYB/6Ld/UqezlyHoco4Iba1rWNCO/U2Bzv4eKjqQU1NoaIsa2pAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,lunn.ch,broadcom.com,cumulusnetworks.com,us.ibm.com,tipi-net.de,vger.kernel.org,lists.linux.dev,gmail.com,outlook.com,lzu.edu.cn];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,outlook.com:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: A119633882A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 03:44:39AM +0000, Yang Yang wrote:
> br_nd_send() parses neighbour discovery options from ns->opt[] and
> assumes that these options are in the linear part of request.
> 
> Its callers only guarantee that the ICMPv6 header and target address
> are available, so the option area can still be non-linear. Parsing
> ns->opt[] in that case can access data past the linear buffer.
> 
> Linearize request before option parsing and derive ns from the linear
> network header.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

