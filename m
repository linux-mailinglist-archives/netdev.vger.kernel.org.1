Return-Path: <netdev+bounces-275731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO/5Dzwb1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:44:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D354B3A74A6
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 259423079B9D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003D30BBB9;
	Mon,  6 Apr 2026 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZPxD9cJ/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994A3876BD;
	Mon,  6 Apr 2026 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508111; cv=fail; b=hJJmgbuEAe8Ee2cAIJUYivZxM9kgIuRfzaM16F0BOQ0TAZaDgeH9Q2EQNvmm44Z3Mp1daIAPJOUDm+K8KxV76VHVzHVYFgxMIfAVGs6UQ1S1/A3oVzpkZpa0W73a6aGXBLJrXNw60rcwxLYC7p1jK4BnObowBCxnYAA+0zXqArQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508111; c=relaxed/simple;
	bh=ot+biiMAn8WYbbyiZZ2hCKHvvSYZUDjPAsfSgaOqsSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTCbNDz8WG2X57AsFEZBKLeSRIqDW3Z2q8EJVjRwJ93F93YF2blryOBMcQMD/SbHW359tRNqPu4DmvUBELhJ8C5r40W13kjycJR+OqrixJBV14spuk3eFzsKUBt/lvPjNTxf6WyAm7Z63rbgxRnXq7IsLJLMfrrEItIO0nvF/p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZPxD9cJ/; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYV/m6XgzxOdOr9F/3cL+uwNxIwOIJUVIm7W0PIsvUbg8Z30WWznkp2DI4He1MhdAMFZdP+Q6HhhKiU/EObJ2AF5ydzIa/sMV9moC338g/f8y+3rSX3st7f5+wTEzARgjw1cVMol+ekM6uyesVzvuS/UVBsGv3jvMX4qkN24pRbowuwUAdlWWQlKOGTlL4RoLQD2Fy44ZA4nAfMkLl7Cf3kL9oAF8WC5hcE1eVRlbG19F+Pcysv1iKeqySmlOZNpIJmTLhwoGdNWc/CTj7RZpGG0+nS5tegUVmBjau77k7aeiPdqxlYxUZGXHe3Y9w/WWxFgiABABopl8UcO/zbwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS7OTcZIMg7asBA41mfU39F+pUhrJ2X1g58ircLbP/c=;
 b=rax9s7b2/2QiEEuds4wKE/i+fvEpSe7fMg3uZ+AfPbUBGLuLZtwhSfVKr9Jp31+uExxKw15892yDR38Fd2SgWwFlB06EqPQs9ApFKX2NOrpPXjiQ/OCHXQJoYgIsW/FNjHJpOW3KONgqu+3j+leuaWw8mlPEfpyIIUq9HPvI45rn+ooPRwLAeIBS9DqbnvG9EXP19mA812HyS3xKNE7ZthnMTvFL9tM4dUjIBRbvvj70ZgDi9AN6igBiSg181DQcPNi3X9HxwBtoE8LbmlgHg4VXnbhqtwkLaMx5PvzoL6IqhtVc1TPFlqZnGDvhzmoIsRUnT/7RwdXepVLdwocROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS7OTcZIMg7asBA41mfU39F+pUhrJ2X1g58ircLbP/c=;
 b=ZPxD9cJ/YxlEvAzZo2zr7g/pwkc6sBmDsRI+0ox9yrByHmkQM0MCN74DLgCm1rm4lNA/4tsWqLb5YPjS4ACr0IgeZP8VSHXdrWYtIGcAX11iEgb9YEGpk5wro4IGS/ZSYvkKk4tvCR5nJdzc6kv8is8MZ4KBt6Kbse9T0UFkfFlve76ZQ8R3VAsQCNiShZfKk/FXKCjDhEKPIgpEdKuWIxYZwcluzEsrWtaKs0rCk6Pvk3f7u3ANJwtCaBwdRrDiMnYeEjdHBpn5+sx62a0dPKzZqhHeGw2QtrNtL5zkAlWLHjyAeELDai7QIPtJKwewcMyUwq5dVmXN+WMgH4mlSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 20:41:39 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 20:41:39 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 4/6] net: enetc: fix bogus TX ring consumer index after reinitialization
Date: Mon,  6 Apr 2026 23:41:20 +0300
Message-ID: <20260406204122.167237-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406204122.167237-1-vladimir.oltean@nxp.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: c93ea8c0-3821-4135-ba31-08de941ce745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YQcj7aIasYnL0bby+Al7MRO6SuyS6NTSR/PkzwWLvpSTOdyExVwJ+SPoWpvmpe8qPcxoYYEeEyBKfFoLgH4ipaBLyDLYT8ow5XO1wZZGFijJQNfSBEmeRCiomdPzqZ9znEN/DbdHQb56Il+GeeZkR9QeQg74hJzfvCyyycqJZxhpi/VjRb8YenyHOvAa04WxEegnw9O6ERf46UgRxaxwsG5DLqv7L/ZUIfqofEQ4Lx+jW+geBT2FnpDx/1QKIwpqiccc8bCrlp1kFhZispYO4VJkuULy89+lzZnoy583sWD8uF+QhBhf6m2kVU7nXAA7ZJVmmTLSQ1vMyh66lgLtJNsmJzdWMqSjNexrc2G0KqeQJ8iLyujrHlNdkxg2m63pp4uvs4gkFc6AX/ubbDAhsqEVycHKJSRC/G+qTXV6rvfEhX5u6bnOQrrzQzBvt3trBUDNMTPDqg5GVhYYt805np2Zd8mNogKO/l7AZ04kbY56lECqJhcrIyKYjz6aywpU+YVcBMUnactc07QZrlOzOZa9cPmndt9HzJY8tHm4BRaT5IQPBQYcwQN8AK//cyvj+paOfAa18AzXMpJZ2fFXSjsXPcU3mPegZ3lV4Bm9NNFSVdqwloc2nvYsZXL2sg6sp08jv+Sn3shFmvzavmu5WWkwdM0XJfL5CgZ7yfb1GOChk+tzWnbsciAu7KotfZ5aVRPEDevZOvfH2Yah8kdNy1wYytdHw1PUzz6GEB2XJPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R627Yy6IJhD+A5p3laBBag8yHoL8hr3QWZgEC3ko4aMA0tz6BTELq+/zh5YF?=
 =?us-ascii?Q?kxCGsgarguLEmU9RSlTKMNezCVLGCL7MYSawrEzfT1ItCxPegBwjgY6KHwMa?=
 =?us-ascii?Q?+5Lk4QAZOJImt3wawijdIPBmYCVgs/Z0hTMKewvCnC5wmWzAP4E/ekDy1aP1?=
 =?us-ascii?Q?SrpmfJXucRr/JI4R0MSU4+eyDoK+stgFqoYzK1JgOMRZtkixqBEBXNnx4+oM?=
 =?us-ascii?Q?vS4FqA+NgcbN6Uv8igreKU8BA/iOHlOU617dgWBp/Kab91GE13XjxaHgi2Ek?=
 =?us-ascii?Q?VmJQQJoCfogaD5XlSg78JEi59/2veOTZDLMZWBHO/KfjRteVvTBhs3aVUpxO?=
 =?us-ascii?Q?vYIM/+uxhqymDcByGB/XDRD3ztUm9pzmahO3MpW+UtplTX8tFlV1Zazo6zqD?=
 =?us-ascii?Q?V9YvFFxrZxQhqWA45YlwtP7TlElBrMu1b1XO8aPBlzDm7XqyLbDipEnyHvXF?=
 =?us-ascii?Q?B3ippoK7a1VbKs4MQh/BRWxl3XrmQy0Jxtn80IJBdteklLrk3BbphW9j4a4s?=
 =?us-ascii?Q?LgiXAljhyroHCrPCYpYRffuaPJhz5l6rv5qUQBtTFD2/YsiZA1VfvKu7cbrU?=
 =?us-ascii?Q?DkI8Z1Z99gp/Pu0Io6SCBmlZeyd+gB9HHa5IkVmEUcdNXy7wmW06dbWnrq/y?=
 =?us-ascii?Q?R0W5TF78Ow+gLpmH3CgdK7jwp4pj7dbpeiSnOK9pVrLbKMWUOB4/ryTFdoGJ?=
 =?us-ascii?Q?T7T4jikx8OTxF4XhP+dzuXKo56JAw+6Ofs7KQEQ7nDFdDdkJL36WutcJEF92?=
 =?us-ascii?Q?52RxtHcqQmBCSnneDemnCLAveMqMxPM1StUzw0yWEt8O2+3wlOOjIHuJvGWO?=
 =?us-ascii?Q?LNRikpWXvvyPkBU9WEJUYzA338VyFoE2D3pSPLLIiYn1ul1wQdw2H2agsIzr?=
 =?us-ascii?Q?Ehc8RPKUpLWg7LCl4RUAqF0B6n5Cn/zfRu2vPJygHT28EoOLw2RkmcnZ/z91?=
 =?us-ascii?Q?SZGo6C3OJhNhRAR7BBTNjf+uRrRth2fx7qRkGLrnu3aZdKpo6ENcjHA5ykjh?=
 =?us-ascii?Q?4StvqCNbHakfkc0CaEvbAaZ/ZpMQfBjwdUIFooZiX4TuJi0MmyKQYbRqYSn6?=
 =?us-ascii?Q?i+GE6drcIeYoD9P6G6Xow4hHEBWSw+LTNMfPsQi2LN3WZeWmpIO3IuGDfO76?=
 =?us-ascii?Q?xn819VrPXYrJh0tmHFKnV6TewEccubOSUOtFcVhddNrRRp3VQTBS/SYIQ8VQ?=
 =?us-ascii?Q?0nWG+cYAHu+WE6U4vf1wLffLDy4SBg4eLQDl+YVsaClmdoP3/9GB4HNypFNt?=
 =?us-ascii?Q?siycXkSYAwidcENub8eksPGyatOOF83tm4cc1ELjrjew3aqU8OzFmnUFJ+E9?=
 =?us-ascii?Q?Ny3qeY2lOkcgfcYQ/nylTRhJyM53HHfZIN+MlpbjsWsEoLOpmHr32aCyVC6l?=
 =?us-ascii?Q?3zp9u6AXbDF7clCPFaubvHITdxAQsAR03QnABwpQ52eSHQhhUA2UdnMeboD3?=
 =?us-ascii?Q?cHegUOiaz3QIt1GZezs4gCLXY+4eLX5/m9JakQt3w3FnZuyprt5HaM5cLscu?=
 =?us-ascii?Q?aNwxvgXoOKyGuXFWvrm/TK3HK6mHdk0rUBuIOpruW2fNYu1kh/EllEUOVq0n?=
 =?us-ascii?Q?v9ty8y4zt5BoHAou0K2eCXo+9ZTBGGJUmxzEZfmgSi1WWvK9vshYVf4CAVKS?=
 =?us-ascii?Q?fGPUva7tgqSokPL9FA8yNFg8LkHY0RBa9IFheDoer0soosJwzU6pkjNJZ10b?=
 =?us-ascii?Q?9l75C/myGqc5uGfaIHpv5Dryb6s3zhbathKQxtV9lJTa1jCqKdGqvLk6HTGC?=
 =?us-ascii?Q?a/cn54xZwHNaHeOcDTFHCS+vFZ+RBG/qRuD2IUs6C5roGDBfK85w7hYDtbwa?=
X-MS-Exchange-AntiSpam-MessageData-1: Gw+SO+3M4ro7zDmdTuYKv87xY6/EIF+tbWI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93ea8c0-3821-4135-ba31-08de941ce745
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:41:39.5090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oEk39C/6LgD7WwYuYUIWMExJjeTZwnj643SicBOQZY8muB4/KQoVo8cYDPw7dxx4vG+IHSWuDrudP98at9Lrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275731-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D354B3A74A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TBCIR (Transmit Buffer Descriptor Ring Consumer Index) register has
the BD index as the lower 16 bits, but the upper 16 bits contain this
field:

  STAT_ID: Status identifier. Incremented each time the BDR_INDEX is
  updated and an error status bit was set for one of the processed BDs.
  Clears on read.

If there was any transmit error prior to the ring reinitialization and
this is the first time we re-read the TBCIR register, reading it will
give us a value with non-zero upper bits, which is saved in
bdr->next_to_clean.

If subsequently NAPI gets invoked and enetc_clean_tx_ring() runs, this
will dereference the &tx_ring->tx_swbd[] for the bogus (and huge)
next_to_clean index, and will result in an out-of-bounds memory access.

Other places like enetc_bd_ready_count() do mask out the upper bits, so
let's do that here as well.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5b97f9e668ba..a48ee3040b80 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2604,7 +2604,8 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	 * adjust sw indexes
 	 */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
-	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
+	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR) &
+				 ENETC_TBCIR_IDX_MASK;
 
 	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
 	    !is_enetc_rev1(si)) {
-- 
2.43.0


