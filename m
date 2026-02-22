Return-Path: <netdev+bounces-259894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKcQDAhEm2ljxQMAu9opvQ
	(envelope-from <netdev+bounces-259894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 18:59:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64F16FFD5
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 18:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C5D1300D941
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8532472AA;
	Sun, 22 Feb 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="alVhp5IT"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81118787A;
	Sun, 22 Feb 2026 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771783164; cv=fail; b=lEzm29MEL7yNsRLnSv61d3wIaRg1/NfJ5E+1N9YgzA+X9h23ajjsBr4R9NyXcVgvftvxM5DPObfrS6sbeN1rwA0yvZh/iKCK9+aVs7CEmzDeXfCfoARpEgUZ3jWgplJo3f/u2YQmS+4w5MEkqWdXecDLghvieU6QL3+xQ/uEYEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771783164; c=relaxed/simple;
	bh=ghtL16l2NhndetjVKrwPDvqSjd/TOXXkHHqr+fpJbjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXk2BrQatm/ygdkJcThtar+tJCuXJbug2BOGpe9vQwLwTBb3Z62pdzVISVNaLncwjWYRJ2uQ7V7S6ooasiHgS+Aw1Nz3WDzYvk3iw0Em1M3oa3zvBrn+Y2u9b7W/tomO3gUkU4iSGKfmsue+5EAePUbDcpIbsc+aVitFRQz7LhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=alVhp5IT; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J27jQEBnJavFnE7fiP7Bm+tSBujIJNlOKwLfEfNWVbvp1tiR3CvPjYvglh0vLzPvwrbo+yoN5RrgPPK+sWJoXZOFHVJsma8rJFINYrbHaL2waSc3nZJANRzfEgiiXOMb+XZB2USNIg3FwAIoseXV9EA4ATF9T4GDLlWPofX5RNvnDlDfw2QQEQScSu4XhNuqYyoHwqGJzJdGOd3tcBTcV/7+pJVBLmTJIh3/siStNv7YWklVQTJSyz6pPh5xIvhW1WhtrC9E14KMdEecMDX/ceuaZHATKr3VX4xMgTbYBhNksIE5pc1e2wvMH+oZYWZxwKe9yg3xmhoPQwU4zjlDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzHoT40cY1VJeb9ybtWOjX4DcXitPrGtk3Iq0cJeFks=;
 b=SWRC4VN74qk3eAczaXuC5VbDWncSgR81T08ooZrsIbGdwGtRtyYeLf2kcLpZn98KD0N9u4jwVcZq1dCHgNOrns6V0v3U/ZVoFKce76rZFkUzLv5DbzdKpKzxLuWAq8YVJ0DBfa5Uqm2rgX3s7ZY9E0UC/PBB1RKWeLf0VVtcgbeDYXoR2rGY6r+kdGwxzsh3cCZxD/C2hDKmFUjUr/rWOLsdwccJNW6Ndnm+x9eM7ShS12QSBITM5GOxjZ9vkO5DqSov5h0mENu0Wd/Q5cJ/kg8BJ2o37qM4oGhabbHSnNrxsQeQsXmP1HAlIiBA6p97ZiEjNvDafCjEhaF1RobqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzHoT40cY1VJeb9ybtWOjX4DcXitPrGtk3Iq0cJeFks=;
 b=alVhp5ITKdWS+1qdqWvHe//FNhBpHf7qZvuzYlUxPKA4/tGfk7N0wZtAVraOFL6g34y7DHFsgcQdy8XxHLwh74s4SYTSGQdPAwqAzB6k1jGQdpcjCFmK9Q9FLPrAAQjN+PYa6lHqG+tUcJyF+mX7PP6R2EV4id1wXJrMARSl3xD/2BBLAU4FFD/Ud6CFsecngHZDAe2Sh6qPoA9SIfsa2FTg0giv0yMFkRFweR8xH9KqCanZrEYHBxQhO/W9/3/l3jTN5st5eAh+2HeUkF9teCHoMbBV+OIaqNOpeJ4QBakvEzAsi4Fsh/LdkjC50AlIq+VisR0fugG5VmuY8vNulA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by BN7PPF49208036B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sun, 22 Feb
 2026 17:59:19 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 17:59:18 +0000
Date: Sun, 22 Feb 2026 12:59:14 -0500
From: Yury Norov <ynorov@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ice: use bitmap_weighted_xor() in
 ice_find_free_recp_res_idx()
Message-ID: <aZtD8klexMFal8GI@yury>
References: <20251223162303.434659-1-yury.norov@gmail.com>
 <20251223162303.434659-3-yury.norov@gmail.com>
 <20251223190846.76ff4dc0@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223190846.76ff4dc0@pumpkin>
X-ClientProxiedBy: BN9PR03CA0500.namprd03.prod.outlook.com
 (2603:10b6:408:130::25) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: 86581eaa-cc4c-4b28-5199-08de723c18f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bGby3xZ4p/B9+aYcgpm+4t5rysKQCYtnMRCMjqA+2HSxACUrDIrPbgRvGKDh?=
 =?us-ascii?Q?w0erL0ZqRBhY+GJh08LoZ5OadSY1VnG9k5ZoxkTsNrQc1yNH3lcUQmxHfSsr?=
 =?us-ascii?Q?m8mCE36qQLbFYcLpfclzmkAP+6A/MN/uu/QDjsd6Zb/mXOAzWHzxsD8N8Evp?=
 =?us-ascii?Q?4woTNBZ8lSZNFj/3xGUcnrNsyZ1ePZjbd+aMmMQ6bl7Bu+nNvaVepbc11msN?=
 =?us-ascii?Q?97GOvu/G/Z/rxOQGpuE04DnpFg7srSJ1TrPo4YAMA3qI6LZNgybDbjJvm7Kb?=
 =?us-ascii?Q?TtlwWVFaVCHFDLoGv4fjX4NeSfImkl7pGz8CXi/A1JRjpjeTuznT1N/UcIQi?=
 =?us-ascii?Q?1Tvqp/jdJj/SSJCxBakW2llffavm6DyKHu/v5OD+z5eQtaWSDORxeQRFlieG?=
 =?us-ascii?Q?Y1Scnjz49ZW+DsmnszDOojmGgRzTZjGpCfGdLV3DfPotqunVts2W5wN85bkU?=
 =?us-ascii?Q?fhehCYT6ffIUZTSNKa6iEiUn50r0H+L8z5/9ti7B+ieQTXT6DdBNobd/eH3/?=
 =?us-ascii?Q?ZrQri1DJhJHKoNH5NKxJHQtki2CM1ZuCSvMKQcHjoj7/U7Iflbbm+MqzFjc8?=
 =?us-ascii?Q?EFCq/D7kmnSV+BKTUXZsmiMDdpPeGOY57iZG+tIuLSI7hboSGLKXdyZ9vZMf?=
 =?us-ascii?Q?lO9cNz1b4U8S7wewmRgmQyvCThZiHGWKyeOX8pPzcMU77M+qoIF2OHbQT41U?=
 =?us-ascii?Q?In1D1BEGWlNBlB6gsrIZB7Jt8p/sEVCfGFXVIGMY8gooTcN97sBHFDE7h0tz?=
 =?us-ascii?Q?tOxaIvtVdxk1gffKtshPUjUcSAb8EDnBfph60n1psXI5GkIcT0AhdWKYIBMP?=
 =?us-ascii?Q?ZUC6msdKRKt4ltWAyMiQ5OlCGivTsqIng5gO+O/iCDWybvjnIMrpOyUTLa6O?=
 =?us-ascii?Q?zyVKdhEeWpOXMZkDYmUTq4fY3fErEUe5HcCGQGG8co6RdoO0jmN2oWxf14Z6?=
 =?us-ascii?Q?qiQKJigv2nqWEoQnFjM2KMDrOzJZw2TIpQ8lcIxn+BmKg37et26iVFBkxjQM?=
 =?us-ascii?Q?HqNcK8Wea3xEvaq5hIwk6U4MGRG4ej2OtZHJbyL+JXC5kQd1qt0efyuxQ2Mg?=
 =?us-ascii?Q?JVmiN+YHa1OK8TuY5Tm3YwfLM10VnFecu4jICIjOd9G6XR0F7hrZjLSvr4cu?=
 =?us-ascii?Q?E/9uxt19EquGYk17c3w3vEJKS6kUN5PeAobOmYdxLd/RIsgixL7m2k9OtDWI?=
 =?us-ascii?Q?fnN0SojptATsGE+ClDC4EOmsWNJTCZ2GY/01K9ENY9jSvsHBdphAQNWgzcBH?=
 =?us-ascii?Q?Y3Mpkw7umdrx9moniIftI/BQLpkcZdpSaHszxKnkd417d/AadbGfT1fFnaBU?=
 =?us-ascii?Q?ljQlFHFpKaXUwOqbTd/1n5t7Te7xNgd5ak6Jz6OGEQdMc2oPb8mPInCgIds6?=
 =?us-ascii?Q?OCeqeBERQtxNjTTbjLT+1K5dAnASN2W+TN/VF2j22y1IQIdqw59hWms+2vvC?=
 =?us-ascii?Q?RhFEE55abvPaSxYc2TLF5TKnY8++V3hgRJ6oPxmqR/VPCBXqs5dRoqRxZ5/U?=
 =?us-ascii?Q?tUx8//wriE5DUjUBawROK3gWZiC6hx4ZiJp/NzR9b2CF+Y6/E1qMRPXIEjx1?=
 =?us-ascii?Q?j8f9ISE/tJemA14nO9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EzXxnPA5azL6BJ3AeuRJiQm9h/ysCBAh7cZ4rMbp51/MvxHG9VB7XjpqkEj8?=
 =?us-ascii?Q?YeLU2te0hjwx5uYfYrHRddrsr3g197Lay9JI/OaiukEzjKh0XY7N5T5KHAJH?=
 =?us-ascii?Q?KNTdAczXW5hCFBau8RStwHdiVMubVMq5Hq0qc4Ah8UCr9fCRwsIqYhQlWNIt?=
 =?us-ascii?Q?9ul+4MS5hogkbhGVXUj4sEZNxi9gBKLYAggp6RfHTNWTPesLedTwvNhn1XPs?=
 =?us-ascii?Q?pHD40KUjSY52Ink7NOX+wexNUGDB8DM6x/YnnD/X3/+VMvm2odwgXtTonMh2?=
 =?us-ascii?Q?bEcuPPrBvG5SCQ2q0k0q5gdmbn+qQzlmy7wcxgJtISccp7hLf1EjHDjju0Uc?=
 =?us-ascii?Q?HeL/M4qM+yP9Q6Q+Az6lk/Qn1v6UcmE9EHkjv5sHyQvB/5kisaoR62AFH0HW?=
 =?us-ascii?Q?/aUTdn797BcJUq1/ZQ62mpe2z2Tt0wJfKxJGQTSN6a8OYCNai4jKaMwK+dC0?=
 =?us-ascii?Q?Il3a3RPSq4/3BXaMOyaSot+fvcEn9T0GKPTygnWpzHuYGPbzDKt8YZTjtU0P?=
 =?us-ascii?Q?jTW8WrJ3Qiye/kChjD223KCNE1R7K0iBn1uNNLHofi5qqTwoARR3n5SN6PkL?=
 =?us-ascii?Q?ucTTdBPG6Iuhb7PQ0rnB6LFJ4if9KZ3fp0tVxc1i+W3Xot8PsQ4BOChb2tCE?=
 =?us-ascii?Q?1/PwcwmRWfzyhnULgE7knnvTyU7cvAfroDlqSQhmAYpQstXDFGLsZisJyo63?=
 =?us-ascii?Q?AkvDn7u/r2EXUMZSfMbEXlJLOyhqNX6bKfhqs1WSs6HCQ8oFFCjUjlgUOeJj?=
 =?us-ascii?Q?5v+D8so8k0B5Zr9ojLtgwXgvsNca0MuH7AjoEERsxkEssQjcqqOC2VgZqZRC?=
 =?us-ascii?Q?j/erv2GVyyXDJq+/wVhxNBBx/urCWjPhH5SUgiSGIHo96slPlmECBZbPOpkl?=
 =?us-ascii?Q?7l5HfND2xk2wyGjvULl0A0uUoOmLBWGYdnX1xDstRI/IFv54Yy6iB08QdOxj?=
 =?us-ascii?Q?dMPEEwEh2uwwzqtWMWoWpmJriOsgCk0ktAwV9JMOhmHWSzHYlRj5K9LGitFi?=
 =?us-ascii?Q?ExQ735iSzsRZ1faulTdNCsLPk+K+H1FyDQbkjULkkLVDDqs7bBx2Kjq5KJkA?=
 =?us-ascii?Q?MqKiycsDdNGxA8tYUHPJcwRPcL29Ss2lC0qOgRlWpQ1xcpNha40iyz8b3wcA?=
 =?us-ascii?Q?ID1vY6nBu0NX6PfeI0BGqCMPPWTcxYKZIfeKv9pWMFK+yeeACWa/GaitlXBL?=
 =?us-ascii?Q?kckbxmacApLOduaIUdzZZhk65FEpSgamlhmZ6dgigw+P46DoT5TZwiMPooD7?=
 =?us-ascii?Q?tWkyI+VL+0FVcwSVHObMtABhvhtXZbzi3UsIykHOEOp9CJKvaU2z/GgqCmVQ?=
 =?us-ascii?Q?Zeh9ccBFB5IQwmAHgHtctJab/3Xmp1obbzm4VfaJspu07WSFIS895dFY+sDS?=
 =?us-ascii?Q?prQMFrrHXRhkDUc/Vds/gEu06uH4FbWOOMjbAVXYFrfwT6aQ/BgwbJd6XEwz?=
 =?us-ascii?Q?Qc2YGP6hWDp9vTvexWj1B6UoIxd+Ml9K43CCT8iOTBjcpkb9JSfkF7ytIRGj?=
 =?us-ascii?Q?vQE924vGGlDYbm3yV8267GaTgGYIVGrOy4s2Ez+D6L4fYnNKWrmd1CDP1JDW?=
 =?us-ascii?Q?wrDx7hGaQ219/iclAvgWLg8oiOJTXLLO0cpdIDT0AfMPjkLD0Ujhk1yyj0ah?=
 =?us-ascii?Q?etsZwTqROSHG2LYZJwFPtsOE5jyla/1RTYYKkJ8Mp5nd3ag6IfOy48X+RmLX?=
 =?us-ascii?Q?GX9TE5hM5asCE78naFDu+X3p1IWFtMMqHEyFtFJFGNuvHUujKmW5N7HKVOSP?=
 =?us-ascii?Q?pXnbNpv94hsmg7fYrlxeNvO1Cj6qN9zBPinCwfxjfZbeQMK406hs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86581eaa-cc4c-4b28-5199-08de723c18f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 17:59:18.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMDemL97p9qmElAFf4zn/v+8MwvR/2F8B+MNpAImNqXDLAGdOW8ub+7qxA9y532O2k4025wWxWVQ9h5WBaNUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259894-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rasmusvillemoes.dk,linux-foundation.org,lists.osuosl.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 7E64F16FFD5
X-Rspamd-Action: no action

On Tue, Dec 23, 2025 at 07:08:46PM +0000, David Laight wrote:
> On Tue, 23 Dec 2025 11:23:01 -0500
> "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> 
> > Use the right helper and save one bitmaps traverse. 
> 
> It makes no difference here.

No it makes.

> The bitmap has 48 entries and is just a single 'long' on 64bit.
> It is also already in a very slow path that has iterated all the
> 'set' bit of two bitmaps.
> 
> The code is also pretty convoluted and confusing already.
> One of the other bitmaps has 64 entries, recoding using u64 would
> make it a bit more readable.
> 
> Doing the 'weight' here is also just optimising for failure.

We've introduced bitmap_weighted_or() recently, and now we need to add
siblings to the new sub-class. Regardless of performance impact in this
case, having a dedicated helper for a typical operations saves a lot in
debugging. This is proven by decades of code development.

> Oh, and using u8 and u16 for function parameters, return values and
> maths requires extra instructions and is usually a bad idea.

Changing function signatures is not the patch purpose. Feel free to
submit a separate patch.

> 	Dvaid
> 
> > 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_switch.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> > index 84848f0123e7..903417477929 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> > @@ -4984,10 +4984,8 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
> >  			  hw->switch_info->recp_list[bit].res_idxs,
> >  			  ICE_MAX_FV_WORDS);
> >  
> > -	bitmap_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
> > -
> >  	/* return number of free indexes */
> > -	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
> > +	return (u16)bitmap_weighted_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
> >  }
> >  
> >  /**

