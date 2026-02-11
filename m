Return-Path: <netdev+bounces-258240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPn5LbFRjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:53:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373212303F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D0BF305CD1F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9D357738;
	Wed, 11 Feb 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gb7WcbPr"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514635770C;
	Wed, 11 Feb 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802955; cv=fail; b=jNRXK8WGHsayqyf1tFfA/VmmArCtUDpMsUwwwP19sBJK4yfugqt4nEVhSocGuztT6Wz33IHtGOJ2T4+mzA4qdAgacEkl7NDMNyV8YF0vRGT27mqAKd6Tig7YdJEJLw1oQkw9G6LdpmfAreJ3H4v1jOv5Qv6Ojqtoufv5LliZTj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802955; c=relaxed/simple;
	bh=2A3MRw6idOyZTW8qNsPF0L3ikKXeregXX3vWie1VOYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tk71qpwJU+ownsDXqSpTIGzR/zT4Q+2d6gU3XPwlT/o9RRfIPZ3oBuFK3zE/Dq+GHkqvHL/2Alpj2RbvcwZqLPip1JGnUadx8MM7Bv02TRpBTHSB9ti5U9Cji3d1JCF11COMBOpzLuqyUq68YGoFTWBLRbtU1kFEsZP8JFxcBqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gb7WcbPr reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vu5GUJnXpKILzW9dW3pZ+7ODWx3QiR93GxCp+BiH3kSGN1YO3NLMIJGH/JsF8M0K1xNP8ACnzcvba3Qvg35VxkqqqHNKjmBOxO0Ova9sT6/6WeXV1eAK+QwtIwzkKX1qi+nG+7t+V57Uw3V8qpNtpAnZj90dc+oMKnEnTeZPOKUYANXgct5CQHjozB0RVmK9z/H/5RN6nYr3Z97ALVG/y8YFhC2170hCMutEJliMRqdU+h7C4g0T3FpFqDgmaWB0Jmsh+jnSedn5C5iHJRcswSfklUbXioQvUeN9qOdEX9rho6fUQwM4eFr7S8ZMYpdcm6wTl5G3kf4O6jmiuFQMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRzxOEBvQsckac+YQaREK5tZYr/oH3XQxjXyMzVSDwA=;
 b=pRQEAA6TmjFegyNLyHOay0enwkPIyEymjJ7hLp3cEeyIkk+hvJTROx8aFK1s3RGH9PVRxD0Rmo7dflxRlXALhnxJ6AzrtQNdf7lWV+xFJui2bIc/1Egxcawt7YMLCV/JLwY/vkNGvEzdJ/bQ6K0TMNltuvmQOqrhYBmkRR1o45S3wPi9FraDdMvfrhk5CcAoohV+Xx1viG2jWuTsnyo9dpjs13RR7erDvFIjNgFuezuXgw/FUMc+NTk+f9s01rOeBmcGoGQpsDq1p1+J3FQWTy6n6MOjy1CPWiMYw2LlbkmOE1RSBkhA4hliPvyqyP0adVk9g6zIqAeMxI+2pT1AHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRzxOEBvQsckac+YQaREK5tZYr/oH3XQxjXyMzVSDwA=;
 b=Gb7WcbPrNYes5+CRcLsc6LBx86+FW38uzgb5W7TQQR2evI0vLueOA/cLqU3hwrVVi7rga1EHKpSPBK/UwaRhms4b8O7Z+QdFqnI7v9fw+hW9Lfb5MWbJ2HVukh+0123jnQUEjfSAJLdseLumVEX2mKuaNE9/EyldcgGDWub0b8xfBy1+CUABC+7VT9PqRxKKObBUUB14vjrlLatXMy0y0MqQNzRVyBDTPpbNYA3zjCP6MEYhuaPoLkTtcr5q9eGmDlCjsbYQosNYQK8cBWioF8Fax2H6sRv9KRpqDXNNGY/rUviNoxj7b7mj4ahwdtnhfNW08Ml7tztmR3hgTC/hUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Wed, 11 Feb
 2026 09:42:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 09:42:29 +0000
Date: Wed, 11 Feb 2026 11:42:18 +0200
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
Subject: Re: [PATCH net-next v2 02/14] net: bridge: mcast: track active
 state, adding tests
Message-ID: <20260211094218.GA504514@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-3-linus.luessing@c0d3.blue>
 <20260208160046.GB154003@shredder>
 <aYud8nWZ7c0RxRIx@sellars>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYud8nWZ7c0RxRIx@sellars>
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5207fc-58b0-4245-9334-08de6951df13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?VchLfhbqeAllgWRfOnJsdok6S09JMRKoY2BLVMkzs82CUhmZnfyF03V9OD?=
 =?iso-8859-1?Q?J1r/a72RjmEiJD8wzylA+StcJipWVqfmRkZyIhII0Ee7RZONwXD5G9kH5N?=
 =?iso-8859-1?Q?Ez8gjdzQIGSFoaZKaHzVhFqlD2384qs1tNd9wZldVo7PLC6k/fvl8WRI90?=
 =?iso-8859-1?Q?cnyMy89BydDWCE4F7bQclme1sAvWrfO+Q/fuL/Q60Fc6JaAbJCNvv779DY?=
 =?iso-8859-1?Q?a9FctehfK2exIRm81x/TNYRZAPMMfyrSLyWjyPwAFC+Qn3sw6vRMkbQl50?=
 =?iso-8859-1?Q?c65KhxFTArPGf+7lIcWFBH77Gvgpjb0F3BtlpYRVfzSgK7mO66ZOIRBZJG?=
 =?iso-8859-1?Q?GCz1UFO1W6GcZzmM8rcmRxG5uNIXRjruxNjJKNQfferoNo4IjWJzasyyWj?=
 =?iso-8859-1?Q?UKDcSVx5GtJylhUIuZBOISB7fwIEEuGIEUc4JHAB1/AFLEv+Ug0Jsp9xNn?=
 =?iso-8859-1?Q?VNBHQA7YbByRZrqcNpH0UmfTosNX2fB+lryrmvTAxnoei8ElBgcGyMlQ/U?=
 =?iso-8859-1?Q?D2Zq2KL3+s8pNRsb5IJdufpcaNPqLmQ0lLzhlyplSs4Jo9WEttX7DVrEAQ?=
 =?iso-8859-1?Q?TbsMjvGpNPLvjjQ82RL/kHb82UC/r+kOfBTGdZG/xyjBQiK/vRUmgqlEF4?=
 =?iso-8859-1?Q?HcazAQujYlqhp3JtdwrzcEiQge92OObYPm6KFVqzqplfDM2V2N4XQLcvZR?=
 =?iso-8859-1?Q?zdr3bOIboIcgPGGX2yqp3WKm5xcWEmJfjXwBY4/cJdL/8Ky4Y2KnS4kCzP?=
 =?iso-8859-1?Q?ZU97+D/6qhC4PmyR6cdOmUcgIQZXP4cSFeWrFMgTrVGfefjJWyfI/VGa2O?=
 =?iso-8859-1?Q?1h+8kfG1B/IQ6jXYearYj1VDvl84LKMtGY9OzSZ3Xmt62Mvc+CDzJxcQU9?=
 =?iso-8859-1?Q?W82xXqxD89YOyT2Aq3z4tpVATiH0aIm+yIQuR4Wabju+HiOaO/P5LogJgq?=
 =?iso-8859-1?Q?HdWaozByq5W7ngA6WZnC7ISh7oqjEqvIgO7PQX4GCbOb6ZbCPe2ybW80DM?=
 =?iso-8859-1?Q?VJCefJcK7dNKhrXx/J71pknJONSWsCRwQHCHf2CVAlWuJZlUtmLAbHvess?=
 =?iso-8859-1?Q?+JGV8bpvgQd1iOISFJ7GYXwtGg8Kyg1mEtniyfhS20tSTtJr9Hz5fU2br8?=
 =?iso-8859-1?Q?bYL8da+HIXxXsk/Z2le7oDl/UKdntuMHbRgxhrMSfxxe1Fjnu2XTMfzAxl?=
 =?iso-8859-1?Q?3ybzrTlC/fAEeGI2ONM0S6aldINiJhS1N8FqoFuqhGtUrLWj8yT3llJE75?=
 =?iso-8859-1?Q?jzOMiSpZWfRBA8/0Vpcbc3dAb7NNG2voflEFH1/rezeNaGKD74RZ83xpnv?=
 =?iso-8859-1?Q?zBp56ZL6QJIIosGDRsN/VOyF2NTcANkIIVi4l42zVnhEj1FPgLxzV9KeUy?=
 =?iso-8859-1?Q?CU36RNPaFB7eNYMEksP8K9l+Rp7BIdVFDEv7EwK0Dn92p2/trWRyNl6UtO?=
 =?iso-8859-1?Q?BKq7RrEVKAF7HNbtFiJ6AFDVmZ8Sl8MlRCxOgY8yOwaYlrgsLLl6y4YrgS?=
 =?iso-8859-1?Q?TLJVtmXBl3rkUJ8hD8CVFp7Sr8V/74Hj2wnrmyxVl3ITaJln23HgFCo8Yb?=
 =?iso-8859-1?Q?/BjFC4Ntv3iLuGAqhAxmOSMxJFxBX5HSPec/1b607T1rOP13X+LmMriFPR?=
 =?iso-8859-1?Q?8ltM+DqkkaV44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ym4isidoNTKcF4VGc/xiXrWHlJHRLTw3+gIhgiJN4q1adggNc6qdepwFq2?=
 =?iso-8859-1?Q?XJW8FZ25WEm7OasoSaxJChipxmb9bc2BcTb2s7CANjNmNpjYZXc+0c8Ric?=
 =?iso-8859-1?Q?6aLfe0qJRMEZoidOe6CEquiGpw6yQiGw1b7ZXASvzwn+9fQG09WX29ojQo?=
 =?iso-8859-1?Q?a5meQfxbCygYEiYUMevol6yqzRi8W9AOmJanNGEOVkz/86Mc25rCBi451l?=
 =?iso-8859-1?Q?7NaQ3dDjnO0etMv+VU63rDBo6wCuhxVhVgKeGC483TZZOR8seYxAiEsf8w?=
 =?iso-8859-1?Q?wnsiICxShepx37+YCKBpAyO0mFKJGkFk5wCRMOOgj3LhX70u+BspaiLZmR?=
 =?iso-8859-1?Q?SxujExNQbMASxkbOPF6GWsWclgOwd32WVUTv4QJ9l0Xi4ADvx1Phf0gDCs?=
 =?iso-8859-1?Q?QqmxI3x2VvEOOPjY78KFRg3Fca9dXz8dQkpdH3K4wHdMIdpflbBpQtbByT?=
 =?iso-8859-1?Q?Su4blwnmGO+jTMNvaQ2djMNER4Hmv1dLbx1GWG0vNtVPyg2BxCv+aYivLw?=
 =?iso-8859-1?Q?HZ9/c6+lyeRIDq9V5s28PbMGxVg7nayvblxGLXkhPPluRd56hDbsnCNVwP?=
 =?iso-8859-1?Q?jKfGnz7IJkKkXZ9BLdYpOaK0nsKnifTFi75qGv5D+xhSAgmPB4EkMwhxOa?=
 =?iso-8859-1?Q?cUCTV3AEkv5Smdy6T8j0x+4CcucNPMnwKoFKRqC2CwWdZT08uEnNceGnZL?=
 =?iso-8859-1?Q?5cISlw6NqZqlqM4A0j0xSEURguOkCqv0FCED1u4Xn/jJFTHwEBpK1hxWQT?=
 =?iso-8859-1?Q?wzP+Dp2B1LMqyqkePwcirMzJaFx1DvQbU08POnJj43NwzVht1jey1d4Eg0?=
 =?iso-8859-1?Q?vXzk44BKgx1SPzlDNqKgFWETBSJ2tjwfPvIT7tmG3mUk56/wHcND//C0c7?=
 =?iso-8859-1?Q?dLwkOvyxS4NROqTm47GApIh+nhbMySXIBYLZEvEwK7OqR3iHb3kjE2G+hr?=
 =?iso-8859-1?Q?CLci+HlYOKI/uIEgMgQC8Ld41UVFZEB1BEsVAyoJ51oBmLKAoZdc1NCdTh?=
 =?iso-8859-1?Q?9e0g5x2bjhwzl7ozqsYcIyMKQio4pHXcMkFGBSNEn2iv8g2m+hQFc9QmiH?=
 =?iso-8859-1?Q?KyLuHqT4sPkABQAKAVC1ivXx5ZjZ/QcOlBaVPndrm4qkTzgtsty15orw31?=
 =?iso-8859-1?Q?495NxtWV7fZbZA8LJ2KGQ4gHMbN6CAmplBzob4oE7V8JafwAD5ap+yfyiN?=
 =?iso-8859-1?Q?H6h/tOv3TxCCkRxD1UOQjsQYDHtfgQLKxFT7h/rq8fI9DkdBTncS80MPMJ?=
 =?iso-8859-1?Q?PpGMalIrYJgv8TkrQxVNUfdIU8aKU+W640DacReJXbv/gGerP2vqP6mw7O?=
 =?iso-8859-1?Q?9QBAVyYyeP2HAMKTqDIBVT2328tLPxXG4H6EbuqAji+lUoVZvkeOCfItIn?=
 =?iso-8859-1?Q?Hw+0haMm8lNupB6JGLwkKh+04Vsq6vTnFm+udBCN8QeoPhoJstiIDSWzIU?=
 =?iso-8859-1?Q?ojoCvux2hxn+JS1IV3LIFRz3CV0IztJlfNUajtdRIWS8cSwQp/uPhEONyC?=
 =?iso-8859-1?Q?CvWfta/hfE/SBJcES8cYQa/NdOBwuLeu7e3x79UzRu7Ba/YPH334dHLwil?=
 =?iso-8859-1?Q?eisbJrzzbDx2Uaf6aQORo0HXNJsnuUPKnBVqYdNrVmcGAf+mc9fNxT+y2J?=
 =?iso-8859-1?Q?6Y+daqrLiPcG7yvPKSWEWoqrwDh2kvIuL+XtYRJ1whf7tev1ROauMEKhyK?=
 =?iso-8859-1?Q?PzQICZR7XT4h1SOrRNonHGnK70G3AbNJ0qo6HR4xk/0txlav1y8hzen111?=
 =?iso-8859-1?Q?4uq2jDRcStLQvVKX1xUAX0I2I4wOknhqL+LB3k2e7YRg5N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5207fc-58b0-4245-9334-08de6951df13
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:42:29.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nCgUxEaPNIM3NUX3GJaWw87c5p1DuuVfp5PPJJ8irmDfgYDr+15vlSghpzwz0HgCn3hBmQN9va42CuLAOSmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-258240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3373212303F
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:06:58PM +0100, Linus Lüssing wrote:
> On Sun, Feb 08, 2026 at 06:00:46PM +0200, Ido Schimmel wrote:
> [...]
> > > +test_inactive_other_querier_norespdelay()
> > > +{
> > > +	RET=0
> > > +
> > > +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> > > +	test_active_setup_config "1" "2" "3" ""
> > > +	#test_active_setup_wait
> > 
> > Why the comment? There are more instances below
> 
> The intention was just to highlight what was skipped in comparison
> to the according test_{vlan,}_active_*_querier() variants.
> 
> Do you think I should remove these lines? Or add a brief
> clarification, something like "# skipped: test_active_setup_wait"?

OK, I see. A brief clarification would be good. I initially thought that
these are leftovers that you forgot to remove before submitting.

