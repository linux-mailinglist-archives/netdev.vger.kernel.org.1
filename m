Return-Path: <netdev+bounces-257823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEFiLciIiGmGqgQAu9opvQ
	(envelope-from <netdev+bounces-257823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 13:59:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36114108AE6
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 13:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93F8B3003515
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC0227EA8;
	Sun,  8 Feb 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kDEuVQYU"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01638207A32;
	Sun,  8 Feb 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770555584; cv=fail; b=YkedFEm2yQ8OaGbHoNYq2Oy9LxmjGYLhn8+5J+ZpGATCcu9ka2AA2tNk7fqcISAIWYT9HdGWtEZp9DpLK+6BhIg2wjDNzehu7LO9DlPohq8DfJ/3O9gnwLRGTqPefDFVlPzeHrjzJUIysBSm0v9+3wR0YO27oTGE8N8N4BO0kbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770555584; c=relaxed/simple;
	bh=rIkNgHv3jka08RRZ70QXEEIF98/sidj5RNIPXJz2OX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lx2nAMBtbeqOsSqc6PJ+6RQ+/JVIGBQfoRXddPEg4IEL9lRNOSJDme+KqCeZAkgvLkgr5GKDF9qrpmlHR5MAHtOKCB4EAw+HtZouLetsiTZvmz8MJQYXMJsKUOFIiiThCH+Paaif/SZqQEzO0ZMbFqB9ait6kIsciMU+y4YfUhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kDEuVQYU; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7218mSPAu+UuVMaPMzOeXK6AQaixBBL/uD0Wj5CHKm+wyFngzYKdQXLMSnqRt3srINqKAHE/8JTQa6xuTzIgiNehH3yAlM6Jv4UdH71qmHToRaodbnnLX44g1F0Gi3ZFj0QpnYca+Y5xwc0IEo7MWVPNRAeuUfPUj55etCQZIdvVlh6r4IBCRIYHk/5H3wkwShVJEPvGxbELyqQRGSIPdJaMS1bsgL4JskT1ub9HWOF6tSMEtHDyFmvV4xQeYgYDonhjBJuy+w6bFuKzGcHMUt6VVZIPf3XhFE4akwp0GEXgjRGOk0fWdGHkZA+nEgYa96LHmjyzwq3lYZM8P1htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr/XIC2d6FGoYwy7L7vsitxwYPjosV0yjsxLuIsaA0k=;
 b=T9VsBko9WpliLS4mA/PdHRApX7biUQRrfsTSe8goADtRSr8UKKHvX6JzPK8ekM+JnxtCeqyapm96ZZ0VijsKbnNTSnlHTFy1DUOh6GRsAPDuwuUt7SQ0un8bvgXJN0CLqooV6SBVKBf3KSFJ7H31aMCChENL92V4B5CBBwIxBvL3NOIY1zJKETUHZoaMaUKiE2hkp9W2GewrRIx+6O6NkU739A2lPNZx89kHKBVqEgHTGUf7R5YC8vA2ah3rgZbV1oFWrxU3qtljQAre7n53+bHR9fUJQswfl1lQ/e+J8xNtZVFA6QMSherIj6E6h1wVri7n2Q1GNs1/QGhGzVHm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr/XIC2d6FGoYwy7L7vsitxwYPjosV0yjsxLuIsaA0k=;
 b=kDEuVQYU2LKFyOglhtQJpGPY97muxxMdWxRK82T2WFQ7MmxNRldrdB/snTmi9GA4I2VGfvHwFMkII73VksGIfSC4YKKwuI0K/pPc1XtMM3ZQt3O8cZsq7ClGk+ti2lLvLpSvL/6N2ZuFvfLVCSHh4rOaC4daHfHYcVtiO7Ggsy62Gf4eY8ZvFkeZDNbyXuHKyBGHxt5vq9x5hfGTJ1ZNyrNYJPWM1oaHPzdwyyUFKxk3H3eaZFEga+bJrMAfV8w1pKKkEhRwB7l3R6jMYBLK4FDqLYKJKoMbnwLOs9JguUXhqhmuSFcJ/m9m48bp+e/qOU4wlz6KLTR6dezTnLU44g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 12:59:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9587.010; Sun, 8 Feb 2026
 12:59:39 +0000
Date: Sun, 8 Feb 2026 14:59:34 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	Ricardo =?utf-8?B?Qi4gTWFybGniiJrCrnJl?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info
 frag_size
Message-ID: <20260208125934.f4n5mri2pit6s6gn@skbuf>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-7-larysa.zaremba@intel.com>
 <20260205005901.gnju3zmqimtgeu2b@skbuf>
 <20260204173401.282899d0@kernel.org>
 <20260205122953.lscemcctayrvszdu@skbuf>
 <aYSP344FT-JlylwY@soc-5CG4396X81.clients.intel.com>
 <20260205124638.hxzvjiocephzlrk3@skbuf>
 <aYSZw4wbd-nvLTuD@soc-5CG4396X81.clients.intel.com>
 <20260205134046.pggwyosutj7ggi4i@skbuf>
 <20260205175408.30ab72a1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205175408.30ab72a1@kernel.org>
X-ClientProxiedBy: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f87fcb2-3396-4b0f-c469-08de6711eaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2968HSiAeGXhzrc7hbhRzB9MjbsSFesdzBOBL32LzSAcuUNpnBJuSAV4MtNQ?=
 =?us-ascii?Q?+DGuEAQyPio8kSwYXUfzD+NLEsWyEfj89XTqjQhY0qltU+grlT50BWaJrtIv?=
 =?us-ascii?Q?7ARhJT0R6SYwPtgjnpm73UkSAfZZx/179b/1QPBLn24KxuHPoUglvYRlj4KB?=
 =?us-ascii?Q?TARGXUeM71BIJSfzPce1iwm+C9N8rq7A2T0TtwmbTIkuLJLDEZefl6GdA6Wa?=
 =?us-ascii?Q?O6jYdfz2GPX9RAImBhoN/Yi+6W6I1vexl3xBRBdQg0cpRQSG0GURTc2UVAAa?=
 =?us-ascii?Q?iwKmJ6i4pbjeS8HTVAZC+h0JcWqxXZkKt+b0QJsOXJawlYSv5kw1cEBjNifS?=
 =?us-ascii?Q?uLM65O3C5WoOknHsSxvF3B6LuNQmhOSMc3ev5hWuLtV9VjQxx02guuLfTsVy?=
 =?us-ascii?Q?l7nD70aY7SxgMJIrvy7FUU/goYRZoQ5XAA13OghJU6Epj7o5BVSOvjhWgoNK?=
 =?us-ascii?Q?FE+wRWO7aJbzAG3aVrJ3xbV8SKdTPRFY+y2o3uFyIBD46d9DcFw2/LG3ClOx?=
 =?us-ascii?Q?jNPa3TXRNKcMrKVKqSlXJ9vqIwqgWN4FfB+hgiOT9xMmkrjvR+7acTMfvxrf?=
 =?us-ascii?Q?gqVjH4CIBgH5m3LWJ57upewrLhDiN8HQFLT/I2ekVBloC2j2nowZ9obRqwsk?=
 =?us-ascii?Q?zr5rHccm+9ahwdRcnYpjMrtmsBr7jZPWLWJT4EFO5ZONIOLHVW4vqoRiRJU+?=
 =?us-ascii?Q?IoA4Ielch/pn7JoONqpChVh/7zY0dMJ3u45XJBWEdO93ezPdDV7B9XsEgw7C?=
 =?us-ascii?Q?OOOqlyJ2RgJLLS4ZiFvxGp07nFSWPZqeGzL36Ry2XU8OmJOVZ5o3WGQV4EJe?=
 =?us-ascii?Q?HXmeQlHEsp9irkXEFsdAPoITZPG1UKU0uLniqoz1jHuii43Rj/4p2fGUCVlO?=
 =?us-ascii?Q?Lgh8YvUma6V8z8UIZbcHrUmN2EtB3lzplfd19ExsBZou49CpewQKe8JS75hu?=
 =?us-ascii?Q?Plhb0gUh/Cpls7upcp6TKXRw18Xn9fw4ygukakClJnUlrHUeGrY/ePZNkRCn?=
 =?us-ascii?Q?x54zn9/8XenucwqE/rVPbRfYxwXW76YmiPx6hEuYxyVwmWiW4xxTRSWunIBS?=
 =?us-ascii?Q?6ff+YkIB/HKc1rEbbmjmN/oBOEpTK9dx96/2auRFp08IEqpfiLL25ie6eUB1?=
 =?us-ascii?Q?UgM/s46feo47mglAt+V+pIxM4zvrNaLJEKfkbUNvD3WborVTfULKxaODdqzZ?=
 =?us-ascii?Q?TZSg2KIPS6fuGn0tfvmmdXB4ogcYNU5wLOdW+AczJtv0b+y47Xkc0fisBO+I?=
 =?us-ascii?Q?3eOyyALSeyZ38XrEqXnVlkq5nb510bD7+axkc39E3nfeThSLV8wp9M3eCp+z?=
 =?us-ascii?Q?W67Rq4BP+PHafKWTzEbcLIepkfPpQiZM813I+EY6fdIGo8i1qJp/ZaRivWoe?=
 =?us-ascii?Q?eqXQWcumPbHgEgR62VW12KI7khhl7lETMxqkciSRk5J0UJrtXhUXuh+LILSK?=
 =?us-ascii?Q?zl6n9I6IsGHbB7+BnEm3584dybqaemHjq/whxnT2Xid0Wpeg7Ly+wdz0py+a?=
 =?us-ascii?Q?E1yof72cfuR9veiTPcps6F1ySc0843YX4TNaCFSK/2mPk+MivsQzop8YlRhg?=
 =?us-ascii?Q?hdIvVQRe8w+9opeomPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efqqSRQPcEpckUSyfJtq/zS2v9/81RnU+m6th5sZTgHiJzhY0e5X8tv/faCh?=
 =?us-ascii?Q?65CP7KtGsMGbRNVyFJHfUfCK3b3KCJ9AtTPi5og6EAl9gpxuSaPn8AENywte?=
 =?us-ascii?Q?k0sv8SZEeFO9brjE7wXl7IHW3+SWzoR+k89MFF0+0OYfv5ZubZZhn90bLEOf?=
 =?us-ascii?Q?wOQkN8GIf9SShHIkHoWDYaYnYpGNIrY5QPw/E38xsY8qwN9Pb5HiIXAsW4Tu?=
 =?us-ascii?Q?fb5JQtH9BWq+JYLt4uTUglI5o6Sx5aYuPGY239GkTTsrIpJEHYPfOBo66NwT?=
 =?us-ascii?Q?fRCT8I43eT5f/aH2yvF5n5Yljrw91KIW1rQnBl/LWZV2CyAfGSELNZOp1FrK?=
 =?us-ascii?Q?snvyiGo3sv2PDLBKEDdnYqKybSCCvGSyU4aaA/IsIRc/VSQeYMv/Al3DZq+G?=
 =?us-ascii?Q?yxi36UPq2DDcvYMmqXJV/704XN6pqtifHDZw+2huWFalc0hSOgG8tnXEJOQ3?=
 =?us-ascii?Q?RL4C+JPixXWH6tA3Zs89bsj4LGp9dsnhPUl69aJA8iID28ascs7qEmDS0qtS?=
 =?us-ascii?Q?lMKwLZaRR+E/4jJLlH9n9brJAA4UuQR90aO3xcTA0pS0nBs5dCDOX+vghIBV?=
 =?us-ascii?Q?t9c6W7jl5T8fn73FPK+yn1A8g7uFxDg1SnkvuHDTgQlFiUzIk1jb4DrVp6L1?=
 =?us-ascii?Q?1JEs0ekYVCxz0smQV2PNGVgG1hMUrzvlyn7PZORebnhviFJ0EhY5uDjghZwu?=
 =?us-ascii?Q?Ts89bMHdghJzPyov5R5BugfvHjYSA4xUeagap0hcTz7LurEyFjv2uo/DWGsl?=
 =?us-ascii?Q?yQMB2yhfm3MjHIkoJBOPAzfH5vwgJHvbEy4Tlf0+wFYyBrsX5gl94WaEdvld?=
 =?us-ascii?Q?G5nexlZh0Zzgrgr/bJfiinPh7TXgbnVdSrxSV0cFvyOszwUBOgHRTqbAI783?=
 =?us-ascii?Q?wxPm24w1DfGerLON0myLeeL8dnyKMYT1hVgcioGv45m4y6MgUuDTssgXa3cz?=
 =?us-ascii?Q?CEAsE66ONVD63OR/sLqiNz45Av0ZrkCcU+pTv2oARJJLxJDNuG+p1WEdsLob?=
 =?us-ascii?Q?kB7kTy9AwaKV5d0jWy+1d8NsRvbdf2xjjeblom79VtVfLYlHtQ+ayOb7May5?=
 =?us-ascii?Q?DcXnzCo5VYB/8R+6MK9/4aiFmXZrtbHURzv/Rkb5ItADtTrk1DruGaHLvFoc?=
 =?us-ascii?Q?gFF8aIVi7YB0L8l0kz59YJPnKCwMhDOifHV/NCzDh8RLY32tz6uwt9tLTBM7?=
 =?us-ascii?Q?ooojYxp5SNSR8MLKNYGFU0QqRu4c+VchK4pt/i7OeZs1WbelncQsKwYtyQCO?=
 =?us-ascii?Q?3+1wvIaNdWbnzWDgUaOgB/g2d/2Euoc6LnxNURTHT7X2xtYtJgD1SSbsFSMf?=
 =?us-ascii?Q?+dSxFjF3ug5xH7G6T/gLRjcj1w+XcelLzQRYaccZtpXFWShsfEmHhQl9XVwo?=
 =?us-ascii?Q?8H4em7JWkQqiBbfN/XwH5s6NxT52Ib2lFlO3nR6z3M8Oypj+5TL2zz25NVCI?=
 =?us-ascii?Q?yaPn4pmKfXCWyaZzYZszP8DGbgFBvI5e7zj4scUALB9o6z4TJ/KSLMNJDSMt?=
 =?us-ascii?Q?2wD5PoRDEUFiLnKqIHxNijxz6waiGTSpQeMguKENa3iJTqraSER1+2gNQSa8?=
 =?us-ascii?Q?BvTbtviPD3ORODbW81ZHHOuvcJ8EWe266W29aTo1juq8XBa0LXc+RcDxDqe/?=
 =?us-ascii?Q?ffNG+CHN1zxgXtM7SzptoLZ8sD1Ey8/pooH0RaX62oUWL3X+AxAykH1RwCvO?=
 =?us-ascii?Q?qircJ176UAz0waLScMvQsnYj75ehBqBrMiPcMbwfPh0bxRYQbamcNb4xDYUM?=
 =?us-ascii?Q?LNhMPNHaeh5zewA8OUuNSyR+huvtX38yh4OVbwslgbGEHNz/V8/HfCKyA9A1?=
X-MS-Exchange-AntiSpam-MessageData-1: MAATTmjWMPcIPKFTlkpcBs4+ha7YVLbSZ14=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f87fcb2-3396-4b0f-c469-08de6711eaea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 12:59:39.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW9b9Zp8zGViC8jU7UXVDyupvl/WPHoZuTizgbM2ujFz+4eIEGlaZHoTtYwwjMJSMw3PRLd820gOBaTJmL2uMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36114108AE6
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 05:54:08PM -0800, Jakub Kicinski wrote:
> FWIW my feeling is that instead of nickel and diming leftover space 
> in the frags if someone actually cared about growing mbufs we should
> have the helper allocate a new page from the PP and append it to the
> shinfo. Much simpler, "infinite space", and works regardless of the
> driver. I don't mean that to suggest you implement it, purely to point
> out that I think nobody really uses positive offsets.. So we can as
> well switch more complicated drivers back to xdp_rxq_info_reg().

FWIW, I do have a use case at least in the theoretical sense for
bpf_xdp_adjust_tail() with positive offsets, although it's still under
development.

I'm working on a DSA data path library for XDP, and one of the features
it supports is redirecting from one user port to another, with in-place
tag modification.

If the path to the egress port goes through a tail-tagging switch but
the path from the ingress port didn't, bpf_xdp_adjust_tail() with a
positive offset will be called to make space for the tail tags.

I'm not sure about the "regardless of the driver" part of your comment.
Is it possible to mix and match allocation models and still keep track
of how each individual page needs to be freed? AFAICS in xdp_return_frame(),
the mem_type is assumed to be the same for the entire xdp_frame.

