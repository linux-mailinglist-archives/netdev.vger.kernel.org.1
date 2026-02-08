Return-Path: <netdev+bounces-257839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDtcFRG1iGm9uwQAu9opvQ
	(envelope-from <netdev+bounces-257839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:08:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8364109593
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE14D3020D6F
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1934D4EC;
	Sun,  8 Feb 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+iTrUpY"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9746347BD7;
	Sun,  8 Feb 2026 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566911; cv=fail; b=CR9vg3zXGpGrCnRPnwORBFct4jOMs5t3aDSSOPBnncRBFnHo0WrjCv9XxinjgUFliDjQg+gIXY6oThu5TZv62SX++jk+dOqfzs8GOT0C/oiRHt2OjvGM8JdDpvdBi46fCJxVTMao75ZwsAucKxnUYT/NVGtaoHUTiT5/Wr9wMec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566911; c=relaxed/simple;
	bh=IE/scgM0ayWV8enDQIC5WtSSF6bEJXzOGgLTkH9TkBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m+1Fdlr4wREiKbt/9/BefirWagr0FHUTegvUGPkFh899H3t6NV3yCwmPEHwEI3bKMOtdQ8CRWZmW436f/jnNCu6Oqzq6/6iYOgOWvsoxojSs7gSTHWUby+LBI3gT86U1Sdt2nTDCacU6tGy2OUG5zxsiN9u5qO35wW/So+6FFuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+iTrUpY reason="signature verification failed"; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA4WKkP1CUvATlQQQcGo8KnkiuRLAgQOohDANBEvOObXzpRBCtz3C11ey6G4hUd85pBU42qfMji6BVTtgCuIRfir6CaY0yQth7oP+gnhCrTzC3P1ndRvpK4H9capiap94pONwLri8TmIV/iiysJCxtyDMMXeT68ZWcIrTvehJGI9z0jjl2HeO7ai/IkC72B8+MHISbeDC1fskgEt/EbE2eOaVWl2Y91GAM9jL8kYaUPDWV2FzGlJYGs2z/uaIZkoRQmlYnfgDuCAqeLzEqcRpl5aJAFQ7OT7rbXbrRQP12ZY6L7nqDJoP57OV2aO/IZ6/ncUlzt/v1rKj5Wz0EyCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCuVnPJ7GpL2o5iDF7FZzBS1QHUe6SR65djlG3yUr4g=;
 b=v9gXXwBSPiyiHWO9sYyv2d04AfaDKybc/KrQozpENjC/kC/Ier3inaLePsQDLTFbBGCU7WrRKyzIyqHn3NiYKI3GY2HSZp4vCxsM2VfZItFNhQwN8x496PvnnSpuswrjwPuX9YsUi99Tu4IVOjpihEntQFhYkKWsu968j8P19a5YzPliD3UY2x5STXUKbVYNSgmVgwwo4Q0LJgEP+z6kaR/Z9CdeVtwN1BgAeX04aGhSuGhho/btyyt+6Y9qS5+ozed+bFjeE25YHi37KaDU1fjpEYf/C2wcEmkA6sfs1K/WjUjm1/YTKGzJM2sIuJmhpRkFk8nPu18rzALJ9A87cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCuVnPJ7GpL2o5iDF7FZzBS1QHUe6SR65djlG3yUr4g=;
 b=V+iTrUpYnFAUzgCvYGxESZfLaJeBSsPbd515SwP/zJbypAX6g7MwmenRGl3latSDxk39zVGWzf2hkXqb/21cTsXiG3G0KsZvnLGsriwR87j+1UYsQQg1dKmDOdA0YYRaQbFLyMhi6w8KTQl9JT81st2CXAZvrHIWZoiAdhtN0R5soECmhsTXUmmELvnkm2gqZ64KmWpaMO86CQQP38G3MFgWotWHqB0babzuMMv1mAUFirWPOQEqZ96jaSoPTwgx5ODB25cCafOZ0SmieH+d0TtQE84VDZ81X5C0ssYzZFOGl9qDaWRcFRBG7uOq00J32ZJNhtzMTOY9OYAEBAkesA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:08:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:08:26 +0000
Date: Sun, 8 Feb 2026 18:08:16 +0200
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
Subject: Re: [PATCH net-next v2 05/14] net: bridge: mcast: track active
 state, foreign IGMP/MLD querier disappearance
Message-ID: <20260208160816.GE154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-6-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-6-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR5P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2a78cb-42d0-4c01-2b53-08de672c4ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?DHYsVfZ5G0grfcesHZrxqOLnD/K8N0fUN6ouhielWk1ch91EJti4paCLj7?=
 =?iso-8859-1?Q?6r99kA115z0JjbcrKm1+BoG1sAiK7XL01M7DssL51vvZPV3ZlcMWcjVLeL?=
 =?iso-8859-1?Q?wv2uKy7CxhVRnnD/Ypz+m8W79J6H/XSDmzLw8qLQCdiE+RzTzDtG51486Q?=
 =?iso-8859-1?Q?DmdSEuHdg5j9c+dx4tlrLC0Nu8LF8C+RDd1LM9J0bgnKOqqa817REcSv3Q?=
 =?iso-8859-1?Q?pGrkMr0FaYz385sHoL+sKGv+AJoBdLqKQ14tw8mu5w41nBD5VNti2DgoQ7?=
 =?iso-8859-1?Q?3mMyWtC/WgLZsn6ErUe6JJ+od7zhWsx3eHnWRZxkM/jIBgWtiYsSnK7V65?=
 =?iso-8859-1?Q?V7+/AGCLvJc9gIv/lwa4CXkbbZpsrV44FxypZ+L9iF24Xh7tLb47yNH4/A?=
 =?iso-8859-1?Q?lh668P9whJ/ZfmkChZyS4QiHPBfDhV5akUgvauje3FMn3jaM0KsC0gCly1?=
 =?iso-8859-1?Q?R9GJbdcqOz+H1Meg8grWKt3XnPd+OZRoepqDRPwPvT/Ir3nRXWc9dT/nGC?=
 =?iso-8859-1?Q?zR86U4lbDNkldUC9XHiTXX4iHYcrHPOt440m4MQQ0SqYQaYdr+B7AW3BQW?=
 =?iso-8859-1?Q?+ZrjrE+bow7jrQMasB3HVcG54Ymjq5DKd5pEbVT2j2fcWi/PA78KAU/hFj?=
 =?iso-8859-1?Q?/soqHnro4RI3iUNKMtSObvvLx2BI6ujCbOTZKHI2k+15HxXB0P38rGIw3o?=
 =?iso-8859-1?Q?SThiD2ZJxgLDP0O43htMtMMEJpG3feNLw6M6up7A9gNc4LFpekpmAoZ/D+?=
 =?iso-8859-1?Q?stWfH9cstOfz+TII3QVXL1UurDhRHS81nph+LFgJgMna/QTcOHd2M4ydWo?=
 =?iso-8859-1?Q?CTCsEr1cRSS48wnfnATd95hlKrzfkWaOrke0K+cfKwBDAVXyKFQoQt7+lZ?=
 =?iso-8859-1?Q?SJYaGvCZVbG905zGh+JtQZv8feKTxgqdxDZOoK5mgUqaD2hRwKZexw/q1T?=
 =?iso-8859-1?Q?xPAVVChR8WaG5B0xhevjVdQEChkuSovVf9rgxjrdARuRMEp5FXRir9+HbU?=
 =?iso-8859-1?Q?jXLTY4HFUlNuuBHmtqcypWC9BysCw4B//5HrWQkl7LgIvJVmMuFubR37eO?=
 =?iso-8859-1?Q?cMnfKiEHkqL3Dky6p3/6e6yI+BVHQeSjN3R8Z3VMeT4SJDoLchp97Bxza/?=
 =?iso-8859-1?Q?1Gms18LSRmRFmvppvTrx9r85u8YEhFUJLf3dfW4IKyNBmMyriz8FlhnRbB?=
 =?iso-8859-1?Q?HpU4wpduUY44sgsnctScNLQ3s0+6qiD60pC5oHIyj3z1NQZn6+xUQRqkf5?=
 =?iso-8859-1?Q?w2zyuKAVae9EnwmAXTVk1YbpRZMwzIvL72CrjxA/5F38lLnqH+yFVUmt3s?=
 =?iso-8859-1?Q?vwFiXyzHZnSgqvpKP9VEgYUaEGYqPqgo+yDJHsWqHf4Qq2QuRLWgHgGiOM?=
 =?iso-8859-1?Q?LRyF2VU4lrOyEcKlhXGr7J/Oa0c1Xa0dDy/NZg7HuJi+FNTWazYXn4BG65?=
 =?iso-8859-1?Q?yjX5RRHHsJG62OVNnDcBciTJ7znyAeMXRq4LxOCLnfzMRfsOkOylFFNcIs?=
 =?iso-8859-1?Q?UHxRTg9otVLckfyWIzK89j7t85tQKe59bggafASTHpwKr4lAMKxzR8DYKc?=
 =?iso-8859-1?Q?tF2cfRko3wKDGUhEJ2x2bJeHcIB6G37X7ELmZiY5+kt+V0hM/cGE6cb3hA?=
 =?iso-8859-1?Q?X6/4zOsYi9fYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?F2yguAdjlwk6/ISMxLYo2iHfMRR/4hC6IJF9dpxnfW5qDdy5p0fst3mAIc?=
 =?iso-8859-1?Q?yOVDYOxUTbPju0zEPwaevuoUlnS5pJM0viL2hten3iNzRcafK5PFH0l2An?=
 =?iso-8859-1?Q?9vx5PJClBbZFlqL36vhnQ5ux7C+SER3WWixKOakBqTxkYenXIbwxZPt//d?=
 =?iso-8859-1?Q?cPvpFhhVIELt1TSMdFRo/HAjxVn0ixCISWfj866Yoz8GUpqvmf/q6AuExS?=
 =?iso-8859-1?Q?h1KkKRIJ6JMROnnHAY6Cr8pIZqb4bKbh4YHZIjapCcZ5FuMIwL/1yf/Kqm?=
 =?iso-8859-1?Q?IyYIj2DH8BfPYF2MPRaQalLpP2J8YybZpSfy+Ad4JpG1+nIXYyZe6XIqEW?=
 =?iso-8859-1?Q?asmVJicI1qqEnLhfFw2BDsP6U22LVAHd1kZRx0GC2Q2t1zdqL4YxZ3Vbmb?=
 =?iso-8859-1?Q?4VYi4XT19UtRxbxzPm2nKqMtDubL088WkJq3sGV1ba05jYRMEQ3WPXqtnD?=
 =?iso-8859-1?Q?5zH/htxThjL+mILa5RWQvua3xyXqpv73Xe0V9lPXcrUapOJUTtUJjHJiPu?=
 =?iso-8859-1?Q?ffuXU3HtGXv/rVFCi//eF6HQ2E/hRlFhgTS+VvlF6TftTC6a+MYHAidba8?=
 =?iso-8859-1?Q?/RX/+01Z6qglddCiIOfDBHrtr8/2xexvojVYIkMB+SXt/VNKkHfbQUKgnF?=
 =?iso-8859-1?Q?CV9pYNuHPZTAn4rvlYSBPqZtLncARAoiyeIG4yGy01q4RtN6p7JQsuimTY?=
 =?iso-8859-1?Q?osxAcsETbzHX7ziCmMMujkGixYcTKoDZCTxeaaqBxxMAQF8yM0dABubzCN?=
 =?iso-8859-1?Q?/TnO+h2bRgWbqWDzKAk+cNbXlvCCJn37+jVHirK61JV0fUZNMj61xDm7Jq?=
 =?iso-8859-1?Q?Ux72wEa69FjXNZrBS9vmeIs1mFZGEr6hQZA50Y37DgecKThhLD8Qh7kqPf?=
 =?iso-8859-1?Q?8iLpx1Kq2VAQWZWO7N1UP92GLRoEhEm3LOMJz64QMOKPYtbwJZzmItp5Gh?=
 =?iso-8859-1?Q?d0UFnxEkv1ZsoMEzgECrHmt2y+7cSFMbQsCdcHaR+00FfL2uJsANNQZBWv?=
 =?iso-8859-1?Q?4X54MPTYEmxAW5vVZShafRTI3GkcYvTXl6rq+pfJBiO+eWiIBgo0lkz2zz?=
 =?iso-8859-1?Q?Sv0i0XiL+sW1hISSOC++/SmPpoJ2ousvTES8YbaGP3YL4LFrOJh6sx3U/U?=
 =?iso-8859-1?Q?5cNchEL1t38ezMj9P5FLJ7DH9OG7ETvXeqPUanNCrP55v/dvzYZQoouvoi?=
 =?iso-8859-1?Q?7idPXhsXehWfzVafwEO5VXh3nLmNFMCn1WdNLuIBioPswHf4iaYOx7pYHA?=
 =?iso-8859-1?Q?uUppY11El4lgiJkS426DMyghPkzbziaZpoA9syWUCt1/un9YKEtZ5v5drb?=
 =?iso-8859-1?Q?OderhYTiMVHWAYL2VKoR7GDJ+YuM/85kONm4ZNXD8rtDAK/zQYbCf+Qo3a?=
 =?iso-8859-1?Q?FXHnp7UHJS+WXdqfsyPI63KRv5x+TewnM/FKAvOzbsevjMCslaXKYeJ2l/?=
 =?iso-8859-1?Q?09gE+Cqs9mrENxDmQVD1vKJv1zAkW77te7UGWQ46wLtzA9HbTcv9m4YTJg?=
 =?iso-8859-1?Q?b8P+b0i7eFBc2fgxlSUhMWFcVHzIq65flKKI+Jns8V4ofB0Kd9gjRWdtkE?=
 =?iso-8859-1?Q?ULk9aLR9jV0e5K5MwClAoEiJ6V3xKUZUz8thlnvSOwP04z0itAqmvBngWc?=
 =?iso-8859-1?Q?ZNJFah/apam6c6lAyZYgKkz3Ad0230/tn8b8jPMz/4ppdegSI2NG1r6dC9?=
 =?iso-8859-1?Q?dxxATyvy5CYGBlxq/SiPgMK0HnvbttcLhoIJjeW1ltzBSSD2sVSSqqTY+w?=
 =?iso-8859-1?Q?GMjRnO2jn/wC/rqrUjrCBYy6xu1jXLnnE76FbbXuMFFn4Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2a78cb-42d0-4c01-2b53-08de672c4ada
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:08:26.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJJ/1aplyElcb7yEFA6L6VDl9MNVnzjQDOU8vv7N+RCjcyFjtOO8mYaztg4lQJLAu4JkftQp8bu/9BEZ2tMIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A8364109593
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:11AM +0100, Linus Lüssing wrote:
> This change ensures that the new multicast active state variable is unset
> again after a foreign IGMP/MLD querier has disappeared (default: 255
> seconds). If no new, other IGMP/MLD querier took over then we can't
> reliably receive IGMP/MLD reports anymore and in turn can't ensure the
> completeness of our MDB anymore either.
> 
> No functional change for the fast/data path yet.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

