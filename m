Return-Path: <netdev+bounces-252814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJSbDnhWc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:07:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBB974C96
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEE6E30071ED
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190A31AF1F;
	Fri, 23 Jan 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TgDkxiin"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316D21ADCB;
	Fri, 23 Jan 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166453; cv=fail; b=VAtdhVNjupUBP+qdfAvSFOnDNnxD0DNsUrFEIObJbp26btcUU9/bKEKYay2P9h4Df9n6b2NkgoOuDtkMS7jRzA/iHU/HhcdgWIJfDtYYKjD0H9XiWflYAF4uO1AtxMkUFgvWiItdNdwo1n905mkQe8VYhXxYRfSjvt/cAdmKFR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166453; c=relaxed/simple;
	bh=1PtJGx/RIwZblItg229jfzBvCWoytLZwcs/xU6D7qR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rr8SE43ZoRAU2KGltXZm+6WWJZhGa4vVXHa48L3hhekgKs1AjIozESoG3UnCdXAwFn3paVBH7furPg+hamw9diNqZ1CxUdatcacwn0B+ns1jvnZS11dtW+pRlPkpoCH470IQOHyI77w7nS5q06PQWDWJgCWUBsJaDFhF+q9Q+6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TgDkxiin reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/bBZFhdUaXVU27zGIk5JKzFV65zeqhAwUmFgtvQNHDg1LOGHuUxPdx4FyrD8vW5yXnnTpD3lJvvaZfR8b4Z9ALLqsCsCNMUVr/ZGiI3Ih8H7EzwZl3VuEk0U+vxYYHTtQTWidnwepOIcsq6uEF+KWoGI1wtsfzSleV09ltqLqs8IwDUoBUDdlXzf/+BW6bLiCSNaJCzIFiGnkaZY5rYPJ+BqZREkev+cKXm1pdZnSB0XAR0AgbxZ0tg6Xv+TtKfzUd2XWNiG83wYYCaJPQsFchhlBKQBgVN1DcC72bW8maWvSWHERLNEiQkv5wwoKxfWOO0sTqvjrz5xyqmBlTb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOMm6cl6PZkl/SqI9y9XWv5bINrfjekA2JlEHjyOD98=;
 b=owhmcCKK3oYlln3Gs0sMTH1maM7csn3ZNq7RhJoiFzddoBGhsClheIs6BqnMoDx2m5Ro7LSX9/aB/ZXgUiB/m35zJI2BrrlsRtihupeJvzsQnkg6cgp6FByIB9iaQWFflWLgKtJndLK/pQ3WwUr3bGb29Kk81iGQc77uOEhvKYB8YOskSDs0+uFIgELLvbuL57zW2c3xRRsLbsuzdQ2YsTfpdBBXDFgr4wqUXi7N51RzYoCuvfIhRyiygfKxOEzRk1B/SytERg9UB9r9njhseOwiCeF8W9QS+CMfH2w6qGXz4kAD0J7bLpk/EEHQNfambQgNk9rcc/BvSSE51D/Uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOMm6cl6PZkl/SqI9y9XWv5bINrfjekA2JlEHjyOD98=;
 b=TgDkxiin0KBDNU1ooDQFO6pY7X+/gSX8lvWPtk5FgbmKb2xlf0ypAurRij6wlfnQmp0MZKcCBHswYurnC6Xc7P9JHzTOLgP6Y4cDuh0JsYzhUBjqU2tTbDF0+ejuF9iu7reMW+h/qItin45z42JqUnvar5/E8Bg9f3l2JV1D2kdGapzJcqqLIMJLq6RwvQvx06zvGqZ9XgGfbAoGuGlCt2s7rCEG8dWu3uPSXfeqqgztWw7ouiv7h7xr21029fZY3LEGEg86JNBaUnB/MTgGQmSsBLtZncvkNi78CadI6m/Spt5y2SirjQ8NfJzI1zJsvptNjNsIgqigfxrndqjHgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:07:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Fri, 23 Jan 2026
 11:07:25 +0000
Date: Fri, 23 Jan 2026 13:07:22 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, broonie@kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
Subject: Re: [next-20260122] Build failure on IBM Power Server
Message-ID: <20260123110722.l52ei5bfmx3u7wvl@skbuf>
References: <43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com>
 <f07d721f-ac80-4421-86a3-1f7f76ea8e6c@infradead.org>
 <136ae3bf-b1a3-4ee8-a7ea-dfc90e7b4baf@linux.ibm.com>
 <fa330d98-653c-4643-aee9-9697068e734a@kernel.org>
 <20260123103922.sr7m7py7d4afvc2f@skbuf>
 <2b41debd-9a05-4707-b270-a8fa3dd7768c@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b41debd-9a05-4707-b270-a8fa3dd7768c@kernel.org>
X-ClientProxiedBy: VI1P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5862e9-3f68-4d6b-0c3b-08de5a6f96d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|19092799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?bOLF+or4oKulFFFOarKnlm+PRM7ybZjzhl0sJrkbRPXKMRoMPBoJNBmEYn?=
 =?iso-8859-1?Q?2KpcEEQL+XRfJU3j21s9suy3WY5AJG0pDEO16d5/jZvbVvty4+40wLbmpV?=
 =?iso-8859-1?Q?LDS0MD1B8FSfJfrhb5lfM8kcDDI/ZKFpF1yO2aSpohJMs2HlAtbs+6cHds?=
 =?iso-8859-1?Q?AP30h4Ba0uE6Ro8pRCdguy/yBFIKww7TX2dzz5tFuJEU24JoOy0mW8jMy0?=
 =?iso-8859-1?Q?mbyp+7eXygYzuw1MvccQQ0fJWi6S5BvCe+sqXq2d4zZ2R2A9+P9fqwmfIk?=
 =?iso-8859-1?Q?2YCeWHFPnpq6Ld4YYvJKbOaYoAIfMn48jw0eikkhFMry6/ZpvmpQjhZJfG?=
 =?iso-8859-1?Q?HRvBJj9+xTLYTZG35BHU/9zjb9z81E3awdo7CPWqkeVJzgv5FHuZ/KJ4tF?=
 =?iso-8859-1?Q?GmjWMiNKgWb40Ywq3fqI8I3rhqOaKOqtk20AB1maVXLjoi6eydDjKktgZ2?=
 =?iso-8859-1?Q?Tz9GDiw9ApYgT2iGetFa/olAfVCtMeuUlXpiL9fpCDGjRuuegHYtRjRAwH?=
 =?iso-8859-1?Q?Uvu03p8n0AYgCWcq1PrlHo6eU9ifdGHJAkeuVdF1KKiAOZCSVTbwGzgSX1?=
 =?iso-8859-1?Q?9FxW7rBFWJTldTicP9smIWMK6FwvrrnM6IHydgzjtP49iUX6UKnDLp1/o5?=
 =?iso-8859-1?Q?xRh7KQa1H0OqbEO8PvFl27CQ1P4Pjg7RfI5VnTgs6dHHMJ57pcMZhF6nBy?=
 =?iso-8859-1?Q?9meUWomKO4fMbAnSNOhpm/zmSkj6SU4NVqDMqbpY6FA0aVotTOhRsTFhuq?=
 =?iso-8859-1?Q?y6BC8xvXGipiUi1aRCXl5o/zRu3diHsi5wgwXTbRG/PaDoYdQlSIgKUXGk?=
 =?iso-8859-1?Q?CBcN1ij30yI7Mc0RBwy0tCbFWWyHEWn5dw87Lc8dOdNNUvDBtyXQnGvYTS?=
 =?iso-8859-1?Q?omZZ5AKgz8RpL7L+BAyCegzJzvIOMMCbz7UwXRKITXIa6Dkt/DKPs1IbD+?=
 =?iso-8859-1?Q?NXJ/U7ZL7/tRGg4binzFk2kJJLoowDq/RGlH7f8PeXjn6DkKhnqi5qrCtq?=
 =?iso-8859-1?Q?hSBqVWfql2QFT+j6pnboLfvrTxbz5Bj8ug4cWnyiTLx7qMk2EkmGW17kJW?=
 =?iso-8859-1?Q?jHogI98PcGk+J2YD4AqN6Q2t5viLOI6DLa4CYj29xj/mEF6QWcjdwYYWZx?=
 =?iso-8859-1?Q?FnwPSQ7bAjwY4uPlJHu8lzGVNsNaZ0aP6wnMm6t5mFdUvHnNsMqxBCFesu?=
 =?iso-8859-1?Q?PODe1tc50bEDzWF0oIxB11DQCpQDvUWHyBe0Jv4DiVG/3mWaIQx0bbXiww?=
 =?iso-8859-1?Q?SUk7Jyp28Y3v+R+2ubcIBnFjc4A6UPAclXoT0cHMZF+mDGIusxbMKtk3/N?=
 =?iso-8859-1?Q?T8Y0eOO0eWw9dytxbxeAniSvedtbSgjTRDaAeFUuNjf4Uu+LMjV/LMJuvI?=
 =?iso-8859-1?Q?XHqp9L1koGaIQ3/J8yvSzxkeFL6aOgvXKKbrQ9miN18dJgJIYxPAHN/7W7?=
 =?iso-8859-1?Q?X/tbLCB52vzNNuxiD5Nk7v2oy85SOCuQDKcfcOtdB7FORUFXZj9r1ipJzH?=
 =?iso-8859-1?Q?0JRld+Zk166iVyVueLOq2QDAbNPqnsbFbByZ3wq5k8LnqntLYbyyYvjoTu?=
 =?iso-8859-1?Q?XYoRoU2XxUTIDZmDbusdVD9SXDVb/+rZjwYnq9bME8TqT38xXHfRwG7wXL?=
 =?iso-8859-1?Q?HR7DgMT4pRyDw3qQDqCcjrcyWtRFp0fKU3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(19092799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ln/4r2Bsyi9OkL/4aB+Z1ttUtr3Nu1AjKD0axtI5ub3KC7LFLQut1LnulM?=
 =?iso-8859-1?Q?yZ+TgiKtcatYZPDztl4P/aZHNGJz/jaZOIuKzBVKPlHhg6pdKUxofvpMMl?=
 =?iso-8859-1?Q?FVj8cHqZ6yXCY2XQ2u6vdlz9f4Jq4zZcEI6yVwiiKii/HChH5+mPtVy5oC?=
 =?iso-8859-1?Q?q/k5tjEOkwNTgLtLblExjsV05UZGadSovHS4lTNSH999rcSnFHtqq3EkBc?=
 =?iso-8859-1?Q?AT7zeDMJF5xlpziNfsEGr3NG0udFqteGkCx0viRrYig7xaqpVQKkwmLrPw?=
 =?iso-8859-1?Q?YDXfUqlQlx8g17e1JBqxQFFx6CmAjnFgSNjf27Gk8ujWvi3s6kfqIX5um3?=
 =?iso-8859-1?Q?WjbpopehaXR3k5gv9SPwFZnOwMshhsXofHFqHzNR9mX6Y5oL9QYl4ObDYG?=
 =?iso-8859-1?Q?2ZdqHDdmim5mGqZzmplDQ7P7Yo8thbcAO3KAgWoNkHY3PeeHn7QBf1eYkc?=
 =?iso-8859-1?Q?xtSprJTOMNBS5r7miCj6pvLK7+e8abkuyRwGVGBMjLrq0g1vBAYy5TwtBK?=
 =?iso-8859-1?Q?/PKsGLMJIagdbWrpxlEPlPZYb45GnigetdJF+a9qbjs+fSQT7eooS4S/rF?=
 =?iso-8859-1?Q?n8qoL12wGeGGoVVXgfHeYIu98pTUAI6ANxfkyEH0Mf40hLAWBlkP209dMG?=
 =?iso-8859-1?Q?uGfOZl7a9YUMwfuz5RoW+S5i6sQu/AgZVo2rrY/QeTtgfe20RuPsvOCo5V?=
 =?iso-8859-1?Q?eVPIxQlh4dOqvlLuN9twgpywsLdSSiqIBDiuPu+KJ2VkI1QFGo/4FHtPDf?=
 =?iso-8859-1?Q?gEk9wCa/8ogoFDLibFXZGN40rKtVOd1H5jRUObWnnKSoy5Ra6SH1V4SYhI?=
 =?iso-8859-1?Q?A155gTmJNEiFuUtVZ2ykJJrMTYXqsMxOmkxWJdI2fRA4UhfcKQvaJBC6gH?=
 =?iso-8859-1?Q?iGSNmuz4B+2LNMPKbrDFXGCQJTG11M/aLfAAQwoLnJdX4J5KnTaNx9wwpm?=
 =?iso-8859-1?Q?NwzKoEBWmlNyCyHH5Qcxf525aQJtSVXseLX2J6Ff05uI2a3ZVOpKdj5jmC?=
 =?iso-8859-1?Q?iueyrtREXSr/uDzGyhkviHk7kY5PgQEl8SnBdkNgZsmXL/mkSKn7aMEOYU?=
 =?iso-8859-1?Q?5c8xrLFQR615RsErnGFeoeugYPjTLAnqeJzvXLeuz0I3WlNvTjlc7l/Jx/?=
 =?iso-8859-1?Q?YueoPmGDqRQZMwfMRvAiPHbr2Zx2hXid+Qq93nJMjEu2HBdwRWFDEQBcFP?=
 =?iso-8859-1?Q?IsZAjAD9ErPnJ2ENiDoJbZeZEF8J4DdRLekC2I37X9pE6WMipxdphcbfoc?=
 =?iso-8859-1?Q?2n+QcZY/ZucxRAYDgm9AVL9tSqqrUPZs8wMkn6AXAKSByT6E9B3mgpbfZk?=
 =?iso-8859-1?Q?VDU0jpZIpcSDBeccJlyOi5hDsBO+/vrKL47n8RXpWKlNq4MHUeI3LNhUjJ?=
 =?iso-8859-1?Q?Ey/ieD5IH0W8Ek3T2pCeHHx+kImLug/LrrxL/vycpYVnaFdxeB+aD1xwYU?=
 =?iso-8859-1?Q?CqO8v/l4qw27z5anCLvllhoK/UFULeLS5vf3FOxbNw2PDG3t9gfe3tYVna?=
 =?iso-8859-1?Q?xb22CWOjPPB+78BoTj4UP7ezKwNnCTumGSO/vF0OV2Bmc5vwZ7dTrmX8o5?=
 =?iso-8859-1?Q?YJTnL57lqS12T6UMwTIRdzyy6LpOdXxDegQVHMUxj4XIfbfkIXiJVDF0zj?=
 =?iso-8859-1?Q?MPmEzooYylc23Fc4GuO/yomz6SLY1Q800gv8jq1vqze/K+tS0nEaCBfHQi?=
 =?iso-8859-1?Q?+txU7UBH2pz+T5+z8uU+Zt5OxUf0/qYuqr0M4xJpZsQsTA5bBSzMxAS0Ob?=
 =?iso-8859-1?Q?HzOAv1BeZYT650gCEdaUyqykH/8YTy5Sp8zFpdRFURsWG+TQf0cmi8mBbf?=
 =?iso-8859-1?Q?cP5oNF8bzTeyPqY0nBJLI5KLf8ZUCKYAp0W9nGS/9tGAKbRGh67/AKuCcT?=
 =?iso-8859-1?Q?AY?=
X-MS-Exchange-AntiSpam-MessageData-1: yhwnBB/4ZC2Sj59tozCKNaQcs78rk41InzE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5862e9-3f68-4d6b-0c3b-08de5a6f96d1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:07:25.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkKF3jCHrfXnycPN96HKdOKobGIq7le8QwYZEkB4NOGiNMj4jGCaan1Uzuu2D5oBqqtGduTzB61BQvOPzxGYQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEBB974C96
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:52:45AM +0100, Christophe Leroy (CS GROUP) wrote:
> Le 23/01/2026 à 11:39, Vladimir Oltean a écrit :
> > On Fri, Jan 23, 2026 at 10:52:49AM +0100, Christophe Leroy (CS GROUP) wrote:
> > > +Vladimir, Maxime, Jakub and netdev
> > > 
> > > Le 23/01/2026 à 10:11, Venkat Rao Bagalkote a écrit :
> > > > 
> > > > On 23/01/26 1:17 pm, Randy Dunlap wrote:
> > > > > 
> > > > > On 1/22/26 8:15 PM, Venkat Rao Bagalkote wrote:
> > > > > > Greetings!!
> > > > > > 
> > > > > > IBM CI has reported build failure of 20260122 on IBM Power server.
> > > > > > 
> > > > > > 
> > > > > > Error:
> > > > > > 
> > > > > > 
> > > > > > ERROR: modpost: "phy_get_rx_polarity" [drivers/net/phy/
> > > > > > air_en8811h.ko] undefined!
> > > > > > ERROR: modpost: "phy_get_tx_polarity" [drivers/net/phy/
> > > > > > air_en8811h.ko] undefined!
> > > > > > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > > > > > make[1]: *** [/home/upstreamci/linux/Makefile:2040: modpost] Error 2
> > > > > > make: *** [Makefile:248: __sub-make] Error 2
> > > 
> > > Thanks for the config file.
> > > 
> > > The probleme is because allthough CONFIG_PHY_COMMON_PROPS is selected,
> > > drivers/phy/phy-common-props.o is not built because CONFIG_GENERIC_PHY
> > > is not selected.
> > > 
> > > Likely comes from commit 66d8a334b57e ("net: phy: air_en8811h: deprecate
> > > "airoha,pnswap-rx" and "airoha,pnswap-tx"")
> > > 
> > > Christophe
> > 
> > The intention was for drivers/phy/phy-common-props.o to be
> > buildable/usable without CONFIG_GENERIC_PHY.
> > 
> > Does this help?
> 
> Yes it fixes the build for me.
> 
> Christophe

Patch sent:
https://lore.kernel.org/linux-phy/20260123110600.3118561-1-vladimir.oltean@nxp.com/

