Return-Path: <netdev+bounces-260520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOs0IGCgnWlrQwQAu9opvQ
	(envelope-from <netdev+bounces-260520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:58:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3987187530
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E91C304B463
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09F39B49E;
	Tue, 24 Feb 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+ULg5wP"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3239B48E
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937872; cv=fail; b=VBeyWSbRs0m0tF/5k0JlJm4z5BRa5X1zn5GVqKjidbbG9b06pXLgyCzbuHcS8tXhVPcjrxo4MZkPZDFbpwgxa07YNQJa4awAwq4ve1+W5q8c/MEdk1DSAUozGmcLYbOpRZ5nYFjOywseslugKmfE5jmpGCxFiO7huikQ8dBwC2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937872; c=relaxed/simple;
	bh=SFe3NgZY2qzdKFEO42PBGpu0k4BhEwLmCctltl70GNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKE/rSo0Rj5Pyz46ZIwzH1Xi45/EyNPBfHNNbmUnABLxWbYwuTcjmdCkzKrmYQt9ypEr2bjvrLEr3Oa4dZk0kpIj+ISk08iByHDz9uYDNIi80NxxhUQ2IfvEK7nRhkzz5uUpil/GxM63HTqzGEL2o2FDZmFmP+Mhv/r/sI3jpXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+ULg5wP; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V42LgigTPM497l1SuvdLvLwLdpH7pita7wFprRIVwqEyeJD6ACiyih5sr+HzsRdKXX2UJIElg7y2auKSmpD+uowEw+39ORI4GAsKx8dZy72D2+KuEUJGVBOxn8A1PgLNQyAXX6YFWyMUiWtr8MlbYNINx5Fk8q/ZVje9LhpM9DUnlpAbDd6Sf8KxNQQbc15FcG2mlLSezPQG+wXFiz0s1hTExTNROLwiQaEbSY7qoWHNRrTH+fomwGFIAVn8FiBhSLMoStkm1JpBCDHOxcfJlKxXdiuyu+hC7fM9rtkYjBGTH48qaPsznnhPkD7iTcEV4Xhg+2Ejrn2yWaqVxbkGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DGYO6oHoi7pm1gCqDAQYSmxTfnt+UZD2IW9Tm8pZd0=;
 b=P9rERKH9PLQ0lZt6y5Mpzgmlvf4+A+LQrfxV5Ma07IlUktAvkJkfBNaCjM66Gr2DTgJDZUyW9vGzl0kTMSLndQDuP+Rg3R/kscFoGTghEoVGncvVae3hoEYuRxR/kv8oR2U7WRX7t1PMgoHDvyiG8S80OI9L6wOyiURIuQrU8jSrG90vE5mXW2kr7KWpl1SCydjHWqDAGCpkFl/ELclm9T0eXxhc6WurYfZyj98FErUuHbY7cKIRhotmnvB6xNZekHSpFuPSy1kfRoz5USADZscVhczYCuGucOKwWTi5Q6XzFom8WyAIXTRGJ7zpxWV2RQA7iLMPYAquxDhZz44Y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DGYO6oHoi7pm1gCqDAQYSmxTfnt+UZD2IW9Tm8pZd0=;
 b=J+ULg5wPExvX5X0wcm2vHgjMWfAYs4l4ANIODLeLnmAW42VqABSTJ6AYZorZCWiVDiD6+NvmomkorQlN2UCB9xU7KL2OFvbRpMjXLngqfBISFa5Okeopphep98SsyoMTXvVwnfI5YxUQtXOdUufGAmJZSPkrhlvbHXr1BG0eTu3anGrP8TFKy4j+MicJcQxQlRecUD4vspIzPVKB66jit5cISiWwNpOglIsImxoSKC4ntyGNr0rry5Tr6c3OU2WibH8bucDnZGLgidyEdsrwM1Z6Elk+CssL4YJ3gJofzjpfhbuRX4NG2ZY61kA6Stwslsi2OnWKUlfwEaoSu30e/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:57:48 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 12:57:47 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	penguin-kernel@I-love.SAKURA.ne.jp,
	stfomichev@gmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v3 2/2] selftests: team: Add a reference count leak test
Date: Tue, 24 Feb 2026 14:57:09 +0200
Message-ID: <20260224125709.317574-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224125709.317574-1-idosch@nvidia.com>
References: <20260224125709.317574-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f133e8-1e5d-4e7c-7828-08de73a44f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yEopALT4M2WneUNV3lu5OaYUjyacK7N28xB4lVDg5WILpHlV8ak+ucPpb1HM?=
 =?us-ascii?Q?47oNR5zOKHOuO5a/tzt99a7OznvCshHNgkMHViyX7QiztVqfdtiyo6m/93bC?=
 =?us-ascii?Q?5aVtAiXb9EKbk+7JFi2pT//5p47tGdfE3iKMA+UkWm7UvCqksrc7A/fM45vt?=
 =?us-ascii?Q?h5bQR11aZl0+QkRRSqRPXp0t7tSnZQub1VG2L1LlUBKlE2Gq3DWrsawTXLer?=
 =?us-ascii?Q?i1G8sUAzHZHyIERa9fjWoeoUlcYGPOtcpfYJNWxcwqt65dbFDKeOPPj3h0eB?=
 =?us-ascii?Q?6ZlvmUYQpCXNm5h73ZjLrTQuR2pDcIZI+X9lIgXINIV65Wgt/7x+znUio8Gl?=
 =?us-ascii?Q?SVHDRrE8Ua77L7d8LK09W+lrl8a5UT1LfVtQ6XE9ue3/4B/3kXH78Z0VEOmk?=
 =?us-ascii?Q?NCSD040Vgl+YJTQpQa3u8kNsbrXFzZhK6Yu20DI0dnDcvMx1Xn10LGOigXKL?=
 =?us-ascii?Q?OzgWPabIkLbFVAjDzTnmTNwH2gIYMPplMgS63YQ2P2dlPiYE/Xc8n3Sz6FZm?=
 =?us-ascii?Q?am9l5sQIAlcIaOmFDOoQyQCRzovc1escXtB/cTZ7seT6IH25xXHOJ8czuX+a?=
 =?us-ascii?Q?voePt4QWQbBTjcjdb+SYxQh4wZIBz+ZgLlrlyuBTsqbswpeJw//ZkdlucqrZ?=
 =?us-ascii?Q?dSpU6yF3qAPG9aZu19TUazPWwi1HBqfWFUE2fh9dlC5fWoq/zM1u1nunBXpB?=
 =?us-ascii?Q?4A0HzHDTeXQgR8xOJ9Twd99iEHZCdW+noieIP3o2xODi/QSZ0qOyZwsFfFG7?=
 =?us-ascii?Q?fHLs2NnlxeTNWiZ3Cir5p76C14Zuw+We68vrufx2DMEIQTG0eszgaZBmM+CT?=
 =?us-ascii?Q?/e7gk9jUpgT5mSQqGl/7UKsQOUUFh0s3I8BJeiDRm8Q2ZXKiTCGfJgDs2Vd8?=
 =?us-ascii?Q?9HppFOTv87zRpIhVHFE57Pe2qYjtLiZZWv7qsxIL8P55nVB/mv7ez3HP7Gs/?=
 =?us-ascii?Q?eU6g8QXj+gCtYWm/VxTOYAWOSJ2/Q60rMHDScliJe5hgiGxp07JLB7yUjpX0?=
 =?us-ascii?Q?gYGeTVoWXaxoIy+IVTngOt/gBNh5ZWlmmBKuX3AWkR50HwJb4My2fIm4ghW0?=
 =?us-ascii?Q?r6zgG4sPF17Cv+S5SVpFqjMHV1wQJBuDpnzZuemAAiMjRqpP+tV1R3uLqWsz?=
 =?us-ascii?Q?hycF79/9M1SV/h304cjvT3OUgUMQdhNDlwc7SV6yys3784+N25YYY+Ov4Dhz?=
 =?us-ascii?Q?29pzzq9GJrrouD5VVxGl7GXkCtlFPL2H5cuClyB7Y/1Nl4frrci8b7Cv8Pcy?=
 =?us-ascii?Q?CKU0nt3GTLzfP2VdLPuuVFEPNTw6pxd5OC0pOMLpE0qWe0vkOyEmjqBB4DeZ?=
 =?us-ascii?Q?rWJ/fkoQF7WQJQTnxKsSWCD47BfnJLjfhbEc+PpkZRv6XO2MwbvPTDrqik0P?=
 =?us-ascii?Q?cpgBqc2czi4Pl30XvN0Ja4kj6efqDOZrDrCRe7/rBh+k9FGHo/EKPahbNNob?=
 =?us-ascii?Q?SQsTQrw7MrWr3RNZBd3oLiAZtYTmNGPhJoEO0WvrggDITzzHd3qeER64RDcp?=
 =?us-ascii?Q?CPIqj3umzmAOJguM0L55AyrxW4wNjK2ZR2YWyUE+FH7ZiJ+dvy7UCG/Mn4Lx?=
 =?us-ascii?Q?dNu8ZhAZOFLYiC0c3Pw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbL2m3O1gtMr0XPlulVtL4fQsBgDaio3vTcWMrAhyOvPRLWi2LJgCIcsUNhK?=
 =?us-ascii?Q?Pxmxt+NiJWjnzc8wUFHJz90O+r3UyPUG5BsOGu6dHOvtrLo9exdeNTnPkOzG?=
 =?us-ascii?Q?BvoXKJQgZaOiNdEljnFcvkCQY5LM5J8fx5ZUPjqjXUNAiuxZMhWQP7OT6O0c?=
 =?us-ascii?Q?1RheJYMcTYvswC3nUM5oefRVvSiUiScW8BpL2KACmlHGQE99JTYLU8tJ8wPQ?=
 =?us-ascii?Q?P9D6NLpIaAsP06OPTrBHX0tvnSBehY/JP71JUxO2mG29HvUxchqIWyGktTDo?=
 =?us-ascii?Q?xQQUiUjVzPIIRpnO1+q26C3AwmJs4PXH2x8QvrkvCFEzWMuULafX+OjAMe34?=
 =?us-ascii?Q?QBJTZ+qEKE7f6uSr3HjBvvX7Y3q+cGSGszT1I1POukBMrumcGNL18qx9hjF6?=
 =?us-ascii?Q?OQ9lDCqH6GV885vSZ8Z5ewe1t9SlLcUv6HWjZaS+UyqL7dYkrxsOiwgdXQ71?=
 =?us-ascii?Q?JEnvUwYuVM1CEcp1BYiUMP/31KScA0aKyJo38zz3U9Dm9G9ZwXHKEZQye4kF?=
 =?us-ascii?Q?henqBZ5JspviSiQflXGc3FVLlaj5SDe/+MpKFIDoHSVQOIim7t4PtDkOvzNu?=
 =?us-ascii?Q?M46fvjIujWzK+rSAmix4uk34cScgsnk9JBqTMVYQtVuS4gC9015uYWXYOvNM?=
 =?us-ascii?Q?sJ5ws9tk83pXSi65sNLuSxxS11tNYuUQxma95oIrzF2gRVtr15Dz9pUp8TAG?=
 =?us-ascii?Q?2lPBhSgfhRaYmD+fABMpL4dA5DeZP7kX+Xy67dqNb2k1U9xzyxWGkYS95eFT?=
 =?us-ascii?Q?tLjPvn34txBIJreCty3mXYDU9C0rIf7EUR60JU9XODtwIqd6D9vo60BL6Tx9?=
 =?us-ascii?Q?vUIXj+Q815MgJQq/Mw/WNqrzxlu98mDfQAVhu6THkmYP2/jh/wvRGuZD2n69?=
 =?us-ascii?Q?7x6lo4KzzhAY/TrJYXuhqKslxAFb94oio6KpfDE1gPQ1ZagkWvYN3fIe3sIN?=
 =?us-ascii?Q?sj1tXPs55fvyG2rHGwrP0/wlu7mLjkL1Wf15AlHB8zux6LISd6n/4V7cIX6G?=
 =?us-ascii?Q?sCyBShuOawfzddrluaoOPjHoCl4Ha4rjHyXQbxvVXbYQluWnZw1oZm2t1We8?=
 =?us-ascii?Q?Aq+ME49wlfnf0zMNgKtvXdS2LCtOfDF5VWxuyMRcI8TMcWmV5l2hxdQFcZr0?=
 =?us-ascii?Q?USlr8jJ864f+UpbwNLrvwbOixpPiG95tB8WC1UXUS1/SGuh4kV1ccs1Hd0QZ?=
 =?us-ascii?Q?sLRNcgr7L61gCpC8ZnJGGJoJ++F0kvWheloDCDoq7vvDgY6uM7OlAtVpIHKX?=
 =?us-ascii?Q?TJlw1XADfDfO5XNOJIbWLdn4UaDYST4gbG7p9uiCKUn0XXtfVy+1sp3ypdGD?=
 =?us-ascii?Q?+p0SkfXa/405ARrTvXmuHVgQHxI5EG7aC75lEcxK4Vb8s1CJCAFvMQegS+jE?=
 =?us-ascii?Q?wKnGH4PHmXrhlIIIsn19AM4VOzcePEjtcf39g6LqhV+kcVQuvUZUztHvkC8u?=
 =?us-ascii?Q?GOfoKWczTLa4nQ1VOQX8lQqFZFF3MkVS2hPf5WAi71V5NdxxWVNaQ6xhqkuP?=
 =?us-ascii?Q?PqjcZVdhUxRh3OlT3KAddxpflz4oYiOOH0QNBMWy7VB5nbEC351UN2bYjIDi?=
 =?us-ascii?Q?AGJ+wsXqTOPLPEDYvGz6taJZOVAG/Rxl1XMK2qjQLXNB6Ev/erCOt52V3r3b?=
 =?us-ascii?Q?9Hd3LDf5VnGXdv+l4r7couGDXeRgyVO+WXsOcS1FX68/XR6Hg0GwsZ4T4wuP?=
 =?us-ascii?Q?hPKJTM5kkXc7AhJAWM4J7wQqNOymLK0YqRkHnbSAyB81eWa+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f133e8-1e5d-4e7c-7828-08de73a44f61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:57:47.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtE+a30CqNxlNFA6IC+u30pCndNFcph/uPP34UZ+AwmflqPfNa5yNrgKWFe7gOhbgoLIq1pgUqTwBoevD5nK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,resnulli.us,lunn.ch,I-love.SAKURA.ne.jp,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-260520-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.969];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,refleak.sh:url]
X-Rspamd-Queue-Id: A3987187530
X-Rspamd-Action: no action

Add a test for the issue that was fixed in "team: avoid NETDEV_CHANGEMTU
event when unregistering slave".

The test hangs due to a reference count leak without the fix:

 # make -C tools/testing/selftests TARGETS="drivers/net/team" TEST_PROGS=refleak.sh TEST_GEN_PROGS="" run_tests
 [...]
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net/team: refleak.sh
 [   50.681299][  T496] unregister_netdevice: waiting for dummy1 to become free. Usage count = 3
 [   71.185325][  T496] unregister_netdevice: waiting for dummy1 to become free. Usage count = 3

And passes with the fix:

 # make -C tools/testing/selftests TARGETS="drivers/net/team" TEST_PROGS=refleak.sh TEST_GEN_PROGS="" run_tests
 [...]
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net/team: refleak.sh
 ok 1 selftests: drivers/net/team: refleak.sh

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../testing/selftests/drivers/net/team/Makefile |  1 +
 .../selftests/drivers/net/team/refleak.sh       | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/team/refleak.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 1340b3df9c31..45a3e7ad3dcb 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := \
 	dev_addr_lists.sh \
 	options.sh \
 	propagation.sh \
+	refleak.sh \
 # end of TEST_PROGS
 
 TEST_INCLUDES := \
diff --git a/tools/testing/selftests/drivers/net/team/refleak.sh b/tools/testing/selftests/drivers/net/team/refleak.sh
new file mode 100755
index 000000000000..ef08213ab964
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/refleak.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2154
+
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/lib.sh
+
+trap cleanup_all_ns EXIT
+
+# Test that there is no reference count leak and that dummy1 can be deleted.
+# https://lore.kernel.org/netdev/4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp/
+setup_ns ns1 ns2
+ip -n "$ns1" link add name team1 type team
+ip -n "$ns1" link add name dummy1 mtu 1499 type dummy
+ip -n "$ns1" link set dev dummy1 master team1
+ip -n "$ns1" link set dev dummy1 netns "$ns2"
+ip -n "$ns2" link del dev dummy1
-- 
2.53.0


