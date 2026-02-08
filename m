Return-Path: <netdev+bounces-257838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHY6A+K0iGm9uwQAu9opvQ
	(envelope-from <netdev+bounces-257838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:08:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F493109584
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E87D300AB1B
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831B34B42B;
	Sun,  8 Feb 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AcyN7W4n"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D5346E71;
	Sun,  8 Feb 2026 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566878; cv=fail; b=EYfd3PexEdt3TbQqAnZ3y+05Lz7XIYIwZ9kJyDpb95zd8IcXK8oK7JT7oGc6BhJKglrTQ8fxKfC49qgJvThvkivH+ZfFcCazzg3ogcEwDpyv/+cx3k25KmoRgjag5xDM+bsiO9eKrcqXUMKiLD5gz+cdvaE5uUWnOn+d+DidOYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566878; c=relaxed/simple;
	bh=PTSOaUQnpzgydZT7UTnarLM0ANUrSXj5sSEJC/3+UxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SyqZKS2tFi0erSpXxqJJVN/MZPamA9yt+fUpPx8QVzEAb6x+I4/fp2kEtTCIXXAfA50ATq5QHGprNbA3C++wJtVJz1xUfunueBNeCXvS/4HKChH3IG1GwiXwI/gopOdIcV9189dajy76jGbqWloXoPvnz0l7Bw74vVskowsB2EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AcyN7W4n reason="signature verification failed"; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfWZkaC0MZ6kMgi4yal2Z1EzhVEJ+wLs5nYTh/eHlhBBdbcmEh5g5+D7D0f89bpcUNsRVJ92DgT72s0hqKyqp2BULxpVjm7AFXa4RKnXZio+USAT/Ib9BihfRntqoa3PZ0LOrqJUid1BhsRT7IwXJ7PjmHBaPvkr5Ji6TX/Mq/nWecX3SjXVxW+0gRmIyVfOBOxuIFnP6jB3F1xgcYXiWGZ1aeZ9aHivmmwJuROrxyQ1d1ZtekPXAab33QinUpbl06uv7EoDdnBiroFs5kmCWd1I4DVCs6UFLBiR+q1q7V1T9LqgwKAUnPM0hX65hn1AdNpNC639F0ce8RmOqm6ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo1yPvMtaVG0pZOcX5k7ApWpQk+f9JI1W/FctCLw+k8=;
 b=pfGqkRsmS0362gZ3Vwv1t3qK2Mwsb98oI8iJAslIcDstIGYmPPRZFaEATnICRSqiIoWdWO94ji3LHjb6KsVfkOaFggweeMUszCCkf0cRecliHWxD6QaRDNaYFcrj4aO74GjL9ubVG/pCtaGaaxIhlf4l1GpbKnKVjdycjXS1jD0R3rk1e+kqgZMaSHUm9WH6gXQ+bM1saZCkzW5nzS7ZrJO2T5qpP8f9S/4+MTIsNojLEzWypcAEJKfv2Uzbkou0LCORPBiZneF6zsbOni9uaPvGWg6ipDEOm4nJdjas+V2Ke6I8CyDzjbaODzxXaNgz+l8QxykSjktjgCpQh0ZaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo1yPvMtaVG0pZOcX5k7ApWpQk+f9JI1W/FctCLw+k8=;
 b=AcyN7W4nrBLxMrT8sRu5cC6CN+Z/AdNZ01ENWljeBnk4yaxQCtPbAnXmxIrgarCz8yZWx23pKWOPdqaJ25uMvc4+o0BJ+RkcVn9kHG3ggu2BVb8OIvBwQoI6SDdDJxLk7ig8WN/YtQGREd+7bLO3X82GJJ8VAJkVjpAskHw4gMgEHyi0Bs9uX+5DHHzNkrfgk+U5/4eVxbVpSEUNNGOOUS1yfDU9AkYKoUtCHWaT+uEAWk3uAgne9Z+2e9n25OaAT2p8CwejdUpmhN+By2HFCyyfu0Qc4FdaFQLraw9c3NbA4x3adZBBjUuo15darjh/64FXY2I7fVf9Xwsz5ls5qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:07:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:07:55 +0000
Date: Sun, 8 Feb 2026 18:07:46 +0200
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
Subject: Re: [PATCH net-next v2 04/14] net: bridge: mcast: track active
 state, IGMP/MLD querier appearance
Message-ID: <20260208160746.GD154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-5-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-5-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: dfec9976-2efd-4199-7f64-08de672c3869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?jd7/NT86Sr6UNNN0RskZo5fbXr5ZPeFiwgLHZRC5l4g+v87GFHxAnPvNqf?=
 =?iso-8859-1?Q?IQb39d4ELH7sKWii533/yJnPhwXNCIBmw+2dFAngdZdUZ50Cs/p6xUv3nP?=
 =?iso-8859-1?Q?NeprRD2lJZ38oWGA+K7uUsf8o/HJHAdKD/kZxhgkcDiUy7tohNFFg8J+l5?=
 =?iso-8859-1?Q?1E4bqVzVo2d6RVhCaGxkUKoE9XTOwzsPxNb/xUNjCkFnkoGY5UZZBiSavj?=
 =?iso-8859-1?Q?WZPsL2cyDKUptrFeI3tjTBTcWWUStUKI4z6b4qspWhVhUqQIkKWn1kZrL9?=
 =?iso-8859-1?Q?Tb1Nf8VZVYvzSUxB7aagnlDb9AlP1EbGGrKCmG/DBlRWK6g9XTemUNxbAB?=
 =?iso-8859-1?Q?7ff63bnkkzf0KeJQ1sCeLT74g7q5xRfc5ZcavRpje7zslJqNbrWco5OX9p?=
 =?iso-8859-1?Q?PCVCfzrn6wwKvp6fEtDiTgG61njTiwJUnYlUbS6O4J3Ol9/mgBoHsLt0Yx?=
 =?iso-8859-1?Q?ICcci/huynbdSYWCLpUlbzNIxQHo2nlKyxV9qME0RJNzOodGNiYsYbFiBS?=
 =?iso-8859-1?Q?hTXvZDq4fwkOpUtiJt3CmFp+DJmXv3Fvg6At781lb/4kajXeFfDEGj/w3l?=
 =?iso-8859-1?Q?nQzBkCvLWSLIkxYjAf2OwY4F94clSf/Oe3lc3FOmqbtQtYwRbLmtLiwKEI?=
 =?iso-8859-1?Q?CCSYeUeJfjr3QLNl44WQOsS8CZIVo1NYLjou3Pbowd6rHCCZa3W4ypTuAx?=
 =?iso-8859-1?Q?9VYmvMcK/eDEqMmtnheEAXk/fRfvyNwsvtLhi7ND9qEXuCHkJregeiz1lf?=
 =?iso-8859-1?Q?qX+w2usk+O+Qx2hHyt+wa1osxf2liJrVoItFOJXVS3ec+Ri49eniLWHJYY?=
 =?iso-8859-1?Q?qtSDHv8Mt55ObmfcVNVxrhAnKzG8GUjAJbl8QEftkJJFoOz8JGCkWO/z0i?=
 =?iso-8859-1?Q?T6eomifhOalyZfoTWJrRsvoyea6bhnVyeufaTvf0M9QFLdh93YaesLsSsy?=
 =?iso-8859-1?Q?PrqYwe9UQLbpvDdE3AXCAGM/5LZ+H+0+9xodB4mH3oGqw+kn/5JQZ2l3Ez?=
 =?iso-8859-1?Q?KeNYjhh8EDphMwjeIdbQOT8kqRiPr0bsXtPRX7EzJ0Cl1RrJNAZYuR7IBR?=
 =?iso-8859-1?Q?UWLo+0XNdQMPHi6PkIhoFPA/a1j+gPm47ZSMmYBogMToNP9AJpoEYmv63I?=
 =?iso-8859-1?Q?nvHBg3JBy4BUbMycsnnc/8TPeG2EhqY6+j4BUrSJVEdNbcnbGfL+2h7JMs?=
 =?iso-8859-1?Q?HqP/5HbB9YRlHZti87R6iU/23RPbpkCRasvgWxvA/BHVlxCJ62FeUSjnO/?=
 =?iso-8859-1?Q?aKnI2FU2l4kAtcEu/V+YG2a04uJw/9nNwx4dCJ0W2jEWY0pqzhxM1teZYr?=
 =?iso-8859-1?Q?IKIi0Lq2X4hHWTr0bue855c9nte7IdObEgTfvkKeXN96zkd5Ve4TQgyaNa?=
 =?iso-8859-1?Q?fvXXTXynTg8nTnsIlSjTgqtull+0JuAy8vJXV8Oj65BNzIllyos1SCd0m1?=
 =?iso-8859-1?Q?q3n1OPApPWrP5X9wB6bB4TWIfSqL6z/pIYQRktEuboxZFDJjrn37+RPrtZ?=
 =?iso-8859-1?Q?cYgg0BGF4yyk5jPlUpuMYmb5mEDXXj+12QUCIaLVaWuelWUUcdOLaYr0QN?=
 =?iso-8859-1?Q?7GQp9DpCjHZAL+51721LMEnuuLrsUng/HFElnikm69b4rvczIwwRrLofIV?=
 =?iso-8859-1?Q?YDBWG9rG0G7Wc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mM1QSGASxru1KKC0y+KCzaIT8udhu9bTSM0U9hDI8uR/pLc4hGvF1YKC9p?=
 =?iso-8859-1?Q?4YUBSJ2/KZhT2rZmkDArCyRpHeHg20a7988+uXPdwC5WhmeyzJtfNARbwI?=
 =?iso-8859-1?Q?OY+FlSlO3B00Ap+AtUUc1iK54gX0PFtdquyg57y48t5PgfatZQeMyE/EKX?=
 =?iso-8859-1?Q?XoafW09A7z4oy7sioWYGuQ221dVriKwn1584sI+q8wihyCLqbApvz02uwt?=
 =?iso-8859-1?Q?YMRFmD3DGxq70faKLO82KuwLpWAgnG8CqneGOjTxnRNWsgtcZVP71HzJcZ?=
 =?iso-8859-1?Q?/nktnwpD2Yrs+XbI3TIoVWUxcrMoeULOnOp+YkUN7ppVXnkZNTETSKKcLD?=
 =?iso-8859-1?Q?ZvKdgKFXo09ysPLUCL0lqwRLkRMQhJl90JHlAG3nafeLANqKVIhOOU2uE2?=
 =?iso-8859-1?Q?CWeyZJXjyAIGDethTFxgTQh6VcBvjCTqJosgkEgNoNMk+j948el6RTbent?=
 =?iso-8859-1?Q?5fYYOejy8Pt+9sZS5+w6UoDvdnWjVoebbvveWmjAFSoQ16NgU50F2EyDhc?=
 =?iso-8859-1?Q?hdfOUs1FVfXxoYrcWQBJNavGbZVTWAGoR6ZPVTvptgJQJ6lHhx9nSgDwW3?=
 =?iso-8859-1?Q?FvHzaUHDhV5qa7dxsZXZYduJyDoeOZ3XLohr739sgrwcbtNPSCNZIOj1gu?=
 =?iso-8859-1?Q?oBeuHMEpRv6kyAKYj/u4zEgD3pmNw2zclBwtCWsO/bxCcOXyfCHhAYfwiy?=
 =?iso-8859-1?Q?1IRy45vB3SRxzu67bz1vBFq0Ak9j+wJnS4u2YxQfiKz9Yrz8h+jMnv7HXe?=
 =?iso-8859-1?Q?wB0Lp1/NlYLLrxMrkQASRvPA/A3IyxZWykAQ7FZMp+4nQ3NQrXGm2SqTwk?=
 =?iso-8859-1?Q?dowZTZvygE9Kw/cSgek8bK+sG83hE3gI6fy0NpJh4HSzuc9N59mgO/Eo4M?=
 =?iso-8859-1?Q?89yaOrylmYK4Ikd+Yw3AT5Wiihb4Ya/wFy7ivMxm3kFWaEzBTcOLtMvhcG?=
 =?iso-8859-1?Q?VZpsVMXVpdQ1KUfxs2T+oGt7poxOwg4FJ/sPzkT/zHCbkQFp8XUEqD+v1y?=
 =?iso-8859-1?Q?8MqFRZwdte9DDp75vYrVIUyS49Rjauz4ThzFxsCGIw7xvgXS+wVTYYxejN?=
 =?iso-8859-1?Q?00K19ZOz+g61XhTwa8Vi+ZltKvbrsOvc0VvStBVmp7BojNGfNIDSdnYhn4?=
 =?iso-8859-1?Q?rWBT2LTMfk6FwgOTnKn8GLejdEiOsa9mJCdzsi8MbVmVWkF2dmqUYxC6L2?=
 =?iso-8859-1?Q?ayD9tQK6PL9hM5xRFaeOUP2S7wROn+WjFmSR2H5PAsXsFFw3Kx4wC2zW5H?=
 =?iso-8859-1?Q?7w06lS8twZk1Qiu+lPv0Bp9QbZEWCdbY1/zlYUDyEW3q+GGU1H37DkG505?=
 =?iso-8859-1?Q?knLi6wKpW0+V9ipCbPZBDBFy6bu9a7zCDf2/2xaMgZITAHoJ4vZe/O7Y1c?=
 =?iso-8859-1?Q?wVlqaBgFgbdFujJf+dJQIe6RgATBvIe7JY+VlG49RLC1bKencrtmkv4aTK?=
 =?iso-8859-1?Q?+RnLOFJCEY11dUZ8ByFOgZBoMHEps2h3QPdL89+B1CrISG35HEjABSvr5e?=
 =?iso-8859-1?Q?qtrYmg2doyzJI4Y1meD32R5paHCagb+eYIWlgpRdnpuDFZE2IFliDlHyFU?=
 =?iso-8859-1?Q?c7j31AQZSwBRHyYiq/9ajiqdN/TLyuZqyU6ORMfdJZtJhTcOgKy4/pgCZi?=
 =?iso-8859-1?Q?j7WJ3yyaS6Mk3DW5i/TS0uJNFsFf0TwrH/Iyu1FWqbJ7sSuf3fgX0TS3St?=
 =?iso-8859-1?Q?ScMOsmDmDYox0YCvbO+zeW8rFDmG3IvQvHOG8Iwx8uVr7RGsg0UlSMgTWE?=
 =?iso-8859-1?Q?NQ8ghYLDbFzBeeU3qQ1ZkosMWxlGd/4Olde9ufizAO1fTj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfec9976-2efd-4199-7f64-08de672c3869
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:07:55.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOeCcgzJwmM8+TiEGg+ax+X7BF5XZ/+JMmnNobpWAJ0Q7zjoM4vMsTmdhctsTmdvvgELzY6bdm9bfovbvg2Bhw==
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
	TAGGED_FROM(0.00)[bounces-257838-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5F493109584
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:10AM +0100, Linus Lüssing wrote:
> +static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
> +				       bool ip4_active_old, bool ip6_active_old)
> +{
> +	if (brmctx->ip4_active == ip4_active_old &&
> +	    brmctx->ip6_active == ip6_active_old)
> +		return;
> +
> +	br_info(brmctx->br, "mc_active changed, vid: %i: v4: %i->%i, v6: %i->%i\n",
> +		brmctx->vlan ? brmctx->vlan->vid : -1,
> +		ip4_active_old, brmctx->ip4_active,
> +		ip6_active_old, brmctx->ip6_active);

Make this br_debug() to avoid spamming the kernel log?

I am aware that this can also be notified over netlink, but it will add
extra complexity and I am not sure anyone will use, so it might be best
to defer it for now.

> +}

