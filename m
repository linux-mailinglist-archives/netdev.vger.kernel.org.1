Return-Path: <netdev+bounces-268486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGp5LnIPuWkaoQEAu9opvQ
	(envelope-from <netdev+bounces-268486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:23:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67E2A58CE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8C1A302924E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809139B49F;
	Tue, 17 Mar 2026 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bW6E+3Ql"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603B393DF5;
	Tue, 17 Mar 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735702; cv=fail; b=UDJWMk6fyECM+eHKG3W7cfiXG76jU1L2errZzKjkiwWdlUEpSl2yqVl4myjDwmz3cQ/PAoJDdeNUA/VeKmBgEJViwtKezYo+Im+J1YP19cDytBjyG5s0pJL6tGjnm8FMCPzaoWLMShkocWoCnzoP4dxBXacADxtU1a5qX8Zv3Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735702; c=relaxed/simple;
	bh=HPJj9OEsdPjwH7waXp4rbZF9nzEvsoMwHJkrF0UcbuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KUF9g331z/XSstvzdvwzk0PUoMmRCC4yN4HYAr2Cxonmj4j4JoE9h8+wEToTTp6NLIuYN6eMq/jGEeV90nJ7rtn5vBgLmNWmr0XY05uxr1J3/b3/QfMteqOxbYlZ5SU9hEBnjdz1NUuAjgh3suLku5g+GOWaz+iXUJ5EodNQ4PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bW6E+3Ql; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFDHsKD0+pSlrmeYmtiLPOZEIjia+Jyid3e+cU7ZknrDvwd7Q4cXXvsdGHi2BX+SlgHrFxCrNTE3YGOOYz1Bv1/KxyL4nPWdgMQA/dJxZ2nT51pEy1R6QkOTr6Yjr14Bcem/RLi9emJ+rRZPnDoMQyQqCay7shTZ/zok/QboFmbI3AbL47N8Iah/HyNlxwqRqSTBRsDNRonhhHf+6vuLladXKmw14VCGFGEJ0xwCZfZRzCUcZWoW92BIw5whK8pd48KY+2t2k5Wk4+mA65OcNBBhco+nBWuFl4cq0uP/3hA2Supky+IBqZejVBSaX6gC/wRgWoUijYP69XpCljgUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m//OsmXPkD6b2ajkAnwxveU42v+lEG17geKPtGinqh0=;
 b=MxMyLqrBCcYwd+FWnXrW5b3+dkX488RrG+15EE8Zu6RWlzwSC6PJyRM5hYv6wE5dT7RHjPQ5gYhhzvJzTYI7RQV8lsbxirwMlwg+shV3KbCEfslb67GqsUkXXKwRuTrELTGZ2HT6noHJPr67IzZDuwEI4RklNOQpFATValt0rinKpwZHoF/QJpKtckBVtwvqSKvvCJzLJa6Y08aFPuog7060Y3DgwyLPrVz9S8E3B45dVKuzNE7nMfRsDnL32xBSeF226A/ltXFkgfJtkIcx8NbqCOPkps8gNE8WSBb+KdXhs3wZ481tpdD7ii4X4i4ADKEC6wrTbEaCykZ3SonyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m//OsmXPkD6b2ajkAnwxveU42v+lEG17geKPtGinqh0=;
 b=bW6E+3QlsjkeR1jHqLu7XCoIBmruLgEK5blDlvZyUy0ThZQKDv47ntfY7oCbUZotJIDUUkIFyB7hNGrXrPEwx8s8s/qhNoTXvRx+t1Se71a3RukgMdgGXHmzORDqd9NjlXAfOS+3o0d0SGylGQJ8gCNv0nD4zbzQuHAm8qa6jFz1qOa9OcKGGI9vcvDQHdFLStffIYheTvQEvhfCpozMDTmW8VtFZ0jV65kMyRY6nhVBVdz93ofcb91eUBa6UcL5dwob0Lz+SLyiUcZYFtSY8TNvNQkycOJAWpVJpJxhD5o1NhY4Xm9Oyd1neaMPli+lPVQBZ0CjDHlb/kCxG2BhEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GVXPR04MB12092.eurprd04.prod.outlook.com (2603:10a6:150:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 08:21:26 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 08:21:06 +0000
Date: Tue, 17 Mar 2026 10:21:33 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: dpaa2-mac: retrieve MAC statistics
 in one firmware command
Message-ID: <yywld3x6pqovdsocjsxj6xsqnulx5hxkslhyzxi6s4cmkypuft@5wjh2k64hj3r>
References: <20260312142249.297192-1-ioana.ciornei@nxp.com>
 <20260312142249.297192-3-ioana.ciornei@nxp.com>
 <20260316204153.4643cd16@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316204153.4643cd16@kernel.org>
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GVXPR04MB12092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b10ff3e-41cc-491d-9e0a-08de83fe2304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lZnMi2FSumVGeWUom4qX38ivS5vutCtuhmwHJzzflrlqrAXd/nELXyC2nEDL0T7EjRz9zAqe06ygC8qhoZzzsz0YQhiXHqa2u0Tlc8HpPu874kTZ1cdoHHChOT/KWe20AAJFQphv4B4JKqVFcsUZ/xA+BoWSDgRja5+0qSMqT3tA51EyHvYcolQJSzgRUestPvGp9PKpRtCpEjA+aG5ecgCNtGT5d26bjRGm/im4WDsZLcKLtuFlldOEYazkkxItL/xnRtxn/c1aTefYegtcfUUgq0+0Nt/hGboyuLPMSfMP0+f8/HUkzw3OTUIkV72gWLsg3HjIRujL2fZdW1cf3Y8X2Dl3YbpnMGz5b3ZTXDLErkEkUbSoZ/TTO6zf7NWhCC3JcWCznjZinZ+dbP1Ws8clwp0FZPZP6DQxQjAQwON4zetcUD6jx5Ok7BsBy7balijJ/Yco3OlxXmTZvRwhibtwQiYiVAeCQw08KuiaJYWO6MvGCtxCpTuvcjm8kchp1lpLbqYuSQmm9ezkAU5QMHvNZGUq3jYpqecOKmqs4S35oxgSz9NJw7KJKyx8kATJ9Qd+AcyrL9mEYhkSfkLjXWHmlNbhUP9giluRKAT6t2/6+RrTv/qDizBXhUdGYKmQSsC2wNrNhcO18SS4ILyn/xxF8DuGm4OqzwVQ7B7yJTir3PUiwnt8JL3PCaXH2ZUY3k4RUXRsvCHXzycTbNpAzLrpkFD5xnGU7M9Lo7ak3q4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5vj3qdCsQO66MGP2O8ElRiDoPXsYlgktcZcT84KR9KDMwE5qXt32CPAz07Xd?=
 =?us-ascii?Q?4IuC1BO/Fj3qMBtK6TVez+UEe3xjgVc+kmU8c6OrcSBG+RtOiqCiF/orKEFq?=
 =?us-ascii?Q?RDpVtK/0vS0THB3djJ3f0zPb8mfG0culgijgYrudMeRtM8PaYnyjdqMAdVRv?=
 =?us-ascii?Q?4jPQ+yna3zxQmPn3IV80fDQsvxQwfzCix4XrT1LEF7s25hAEKtkP9kMKmr4W?=
 =?us-ascii?Q?lxe9JOAAotIMHKbhAoKjXGZjG9pAQroqCGS8O4ljPq/JNFRL4vL8xq0bzeOf?=
 =?us-ascii?Q?9jlQhf3kkwq5gQdOST5/ZyKix+Xl+hxhuGpH+zjzFiqW/e2e8SHL0EunHY0g?=
 =?us-ascii?Q?9i0uTqmHD0Chz4nk0kWy9YJv9/o0mEeeTvDJSLYA/81jfjb649gnFBvE+ART?=
 =?us-ascii?Q?vxxT33QDX3RgLjPcDfhSL65agtyjGMWW1i4uUz5kqe2cUk/Dg5+1UTN0FaTV?=
 =?us-ascii?Q?LpnYYS6L4WpDo4xTGT5lmsykbqNKcqTeswC1dUTuqBmxksOiSe483KJJ8ZYQ?=
 =?us-ascii?Q?dPgiu3XKqE09coCS2EV6Fk+THlmTISqp2tmYwX76zJwSvR2WOtQyNyOLuuxQ?=
 =?us-ascii?Q?kUi6WTCuqxiYqBA9uzephsixwrPjcy3mp3ju3ur1Rz31vc9DO5+cSL3HdEQf?=
 =?us-ascii?Q?wcyfZ6/Kh/XBGkI2w08U1twegFbAI2OZyQeA8MfmRgL7f0EijdB8ltO+Kf+8?=
 =?us-ascii?Q?w/9PU8E+LuA7pV+od4cdZ5tCbA+OtzKagnFmMr4Im+SwHq4KDdK+HFyQtYfr?=
 =?us-ascii?Q?wT0zMuix/E0pwaOWc4bW7eYak0FJjP9hVxotCSWiAOL7tB4pxP3gK++KaxgF?=
 =?us-ascii?Q?zjf8yQGNbDlDV6/mdAC1QbZJHzlBSRfw3G3XRZSt7Z+rtZtWGUd/OYxtN56+?=
 =?us-ascii?Q?byjRrQxTyUaFpinLsOpVBWKxjapm5od2UeWMqN0GPuii1mVaKYeyJ0uVqIYS?=
 =?us-ascii?Q?DZB5ggMPQo1rWwVo9NEKdCTR40BaNUXenbFWBJ9RwIJuvdRKec9X0nzWuM0J?=
 =?us-ascii?Q?jdH7FA1nBrQpISEQMsOTD//KVoXLFj7UeI9i2uej2jxEWlHYCCPXoXn0ukHg?=
 =?us-ascii?Q?foMZutGv2KIPK9rc1O44O9hKOvPzu+3VjPj0PGqj8i2Qc487wKD96Ewdbpm7?=
 =?us-ascii?Q?tOvhD9mNw41Pb75aljH3tjquf2ZhiePQKwXrigb0bA103gWxyhT5bRhJztnT?=
 =?us-ascii?Q?8Xy1r9Ev5k9evVlqWFI/b9wcAQ+1ZB1HOXgZeATxZE1mdiBKBEUBIJaFC/6/?=
 =?us-ascii?Q?ikDwBaX9vwiryik/YBu29owfFhFj+1+LWIZjDKxF0yXrfLtkNBVmXxPg9Om+?=
 =?us-ascii?Q?OBlhUxp2PbmYNWNdQNVbHDvrjEGqRrclnwmJ+vkJuvhxHOu9HSG2Cz5O1Nfy?=
 =?us-ascii?Q?slAGbGfb9zXILTjySM8KpDvUJXjU1oaoGyl+0v1tChuc1ZaUZtWWoYMIBTlr?=
 =?us-ascii?Q?VVrOOYJRrwtY6/8ypqCQ8uhppKrbrlHOGAm3MqwmaQ8hqpVhTrxl92VG/cKo?=
 =?us-ascii?Q?b2zT6tdL8kBNJkqzRkpQaZ1A6qXGUMvg42CWpuZ1w3cydWD1rhlH6t/G3ho+?=
 =?us-ascii?Q?VqcPRb2v9ptu2Zn2EL/nukIB8aFB4SgJbDiuvZoqGlXXVeOtCT+72hUavkX+?=
 =?us-ascii?Q?0Y8VhKK4IcYrcFNuJK3Abjtd5SxBieC3QCSyzaoCExz+Y1BQEbPcC8cyw3+u?=
 =?us-ascii?Q?wduwoiq0srCYIi6Pd75PDOC2YrcZMTB5N1ASuNIjkzB+Oi+h1GT+RlJsetpz?=
 =?us-ascii?Q?bQ30nF31hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b10ff3e-41cc-491d-9e0a-08de83fe2304
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:21:06.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm8K83tJ0er0X7MAZBtB1JenGtpI66dIShhtpG01i6esRmXw4PDDsFExnpVa7D8nPYHfKEswOxingzWBR+nR7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12092
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268486-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A67E2A58CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 08:41:53PM -0700, Jakub Kicinski wrote:
> On Thu, 12 Mar 2026 16:22:48 +0200 Ioana Ciornei wrote:
> > +	stats->values_dma_mem = kcalloc(num_stats, sizeof(u64), GFP_KERNEL);
> > +	if (!stats->values_dma_mem)
> > +		goto err_alloc_values;
> > +
> > +	cnt_idx = stats->idx_dma_mem;
> > +	for (size_t i = 0; i < num_stats; i++)
> > +		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
> > +
> > +	stats->idx_iova = dma_map_single(dev, stats->idx_dma_mem,
> > +					 num_stats * sizeof(u32),
> > +					 DMA_TO_DEVICE);
> > +	if (dma_mapping_error(dev, stats->idx_iova))
> 
> dma_alloc_noncoherent(), maybe ?

Ok, will do.

