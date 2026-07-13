Return-Path: <netdev+bounces-307140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +BbMEiPXVGqqfgAAu9opvQ
	(envelope-from <netdev+bounces-307140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:16:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E574AD55
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:16:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=LAIPNUq8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307140-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307140-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 976F5344C7E8
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C3407CCA;
	Mon, 13 Jul 2026 12:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68AF406805;
	Mon, 13 Jul 2026 12:10:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944632; cv=fail; b=Stkd0JICrTRYw9yi23FECFwYo3EeNySqzPGMakKpS0O7vmfZTXoK8G4HcMy54ntFmc73s1FmjDbp3IIK0jCV3i9Yb8ByXEtNP6J35ZKWSVrvQScxUSZoXA/6EQ+KxQEiJcBkrV6DXkc5rAkS3EZXNZ2d+ld7FMXQyWLpb86BlWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944632; c=relaxed/simple;
	bh=ondMywSYXONkmnqQRlLa/sVHYLc15lIOiHdLrL+Ot64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PNR14mfrXFzJnykYhHCArb5bggA1Erp3kqkCA2FtA2O61pWmSKZFet6qmJAbHTIkm7JolY00OuWYK27kyPgyed+HOOwMZFj6XkdGNM93fLXEYKgIRPe2b/DtQdxvbcAbKWq4KrOIZemRnivJPbZkcCUJMCPokXXhUnJOs5FO3+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LAIPNUq8; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h19jJPmxRMBo47oktgKLsHhM8Bj5GgIjl5GmfGZpSmuFiFifQHshFC/oOGMYY30jgqHmhEmDj9aNm4HNG4ItWaeAaZUcDBzB3PDzCRlyrD1XlFrwzVGF786xVneF3A7rjctG9pNpDgB+dlItQkn4HcPdLw9nlxYR6qfg+SF1WAAhF/GGBP4Qurrb9nVmb+X9vB+mWMv9DafTnBgs7NTeyFRNfTJsL5bVckdQO8GKjU+AK92FwSMvX5HK+3b4txrDQmyBLrfDHaDUrtH4X6k/ryWLk6jDmm6kM9JEZwMbZHOF2tgGf4Nz9MQ/wD3OEHMQ+C7BNGoOsFNNxCLZa8DeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBYTmP5QRAfHlTUoMc5yPiYhQtJRdx5zoMB8/VspJW8=;
 b=dKZiES3TnElT1dKfAIsWelHtz8ZlTG/AjeAidTdyu94NWcQTBg5TdZa/kD9ICavYy5SXzoeXU9jxzl5btqNyEajsjhyAjmJhnU0POlgf3J9dOHb2k1Fotd9RtzpY6sv2oocvzYCgKLcTg4UpiZiH88lBw4mku5PW+sko9mGVQQGV6d5lHxKfL0w9Zg7zm+sM2b4Alqp22Mcw0iwB2mpUsIg3UDsOLznDwX+WClIKaEojuK6K/hdIlIpS4WIrOpvkpb0sebzg9LnIp+38R7HnOgUzUX9SpsTf9iAWapu1Mx10BZpSX4GyXTu1LcW3bKnpjkgB5oJ7V0m8GbtMle1owQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBYTmP5QRAfHlTUoMc5yPiYhQtJRdx5zoMB8/VspJW8=;
 b=LAIPNUq8hqNUSWfnFIUNwUrgqDEP7NyOZvrTUaOjtSNP2jaWBGl+OXZKbCdHZe0W9ckufZPKAu6Jqwr5GiTzZBx/fnrFaxIes+Ml8lU8j0GJd5gPt2x5EApCsU6eWGCMw5SV9i5O9evTBAp3yBW3m4St5K70EhmTzknBaV2w1pHg/qBOw/BhDu9Uy8Y5xxWbPcw2CPpcWDaBHmPMGltmgV46DlTD8kvIJ2kLP9lgaZaDO3Bo5S5Q+/FVjZqI3royzFYyJc53psMf7qCE2K7C/RarJJDOQcFRwMc3H8q6ANy73DRPbr1cbBU+Wuaic+xm2Rd+u0u55xGpIUSdrecDBQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PA6PR04MB11886.eurprd04.prod.outlook.com
 (2603:10a6:102:517::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 12:10:27 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 12:10:27 +0000
Date: Mon, 13 Jul 2026 15:10:23 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa2-eth: put MAC endpoint device on disconnect
Message-ID: <qewrevjyvknd7uxiinxggebb3r6ctt7p7okp2hwybn7aimppbh@lhhybhsc3xal>
References: <20260708111738.750391-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708111738.750391-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PA6PR04MB11886:EE_
X-MS-Office365-Filtering-Correlation-Id: a86ecd44-0a47-4cc6-d110-08dee0d7b9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|376014|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	PXjgSGHDc3+ZL0s0bDfYmKTqajgUKEkQf9ZuVNnQo+Ohcv7CESHB5DCd/CJtW4XB0FaI4eONsihiVjLR8T1CwzTPPpiLXjpNqnmVz2v/rF7C9SrrcwhRRj40mEGlXI7pLpAueNDO+P+IkqG60KQZF2atcqgYsHG6ozj5C1pTZ4HVFSOzQE0LKvsorE40vyAklfogjLO+0O3sJ4hD3LGKIXEHT561fjt275GRtiCxoOmGFS2r5HdnlRdy5jXbcQWfakbcE9ZyMfWgQLJ5Sn6c4GuUy1t8t5ekzXd9A9oGwJbntWAeAcysKtrVFxkCooYeI7fVJbTFgp3kHwQvt0mvzubT9pS3flxnp+UqxdpKWvqyEPeWr1c5+sWDws89YEgAGrkm8SNd4svMhOqDdDnHYBUrHCzFmLiK9XlpYrcBEVnUsxehhDNB/eFmDJhVJUbD2WyGAUYImkhBDx75ytAwzKSFK3E72qed7XDUwCjJUEjry9U5Vy+eM7El+zyGmhTJFdX3NxGaeULn4+ICH2RPfxAnh7dj3qDFly9hbx556DdxXRd30i8EC4ON+pp/hKgzL6th1UlxC9gDGnQ7EowvXXTprpqbizZxtaXRBnQsF7OyFihRcF9c+DKJhMwNL5uANzZF/3qQS00cJ5T8boPv0ZdPs9efsM6ovziu/jfvpH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w4fmAacxOkXM2N85+9M9lmZazzr3DfRouNSIYW4QzPljwLIvuLhU4/5WlBZq?=
 =?us-ascii?Q?pRjlA+PW2fy8Etr9jugTRIJPmZpxllXRedvnS9V7KDqf/E6iROZkdd7PG2vv?=
 =?us-ascii?Q?CPMSTpvvn1vk2iBVNZWhHJniyy8DiZmmnSifKfWEbuRRt2UXidM1dnEkAsv4?=
 =?us-ascii?Q?4stQ4LQPtaEUyxL4s06aXGp7K0I5eLuWN+w5wsGR6o959vEWTJu1FSAl28gn?=
 =?us-ascii?Q?5HEh+LN+Nzo87pzypuRihnVu/b6M7To0ziCnvG+7InuVX6LSquXExF9oO5g0?=
 =?us-ascii?Q?x/uCNxD/62aFtApEdACALlS/jAvuoimqFQBxSOFYamgEim1eMLRC6iSX8tcS?=
 =?us-ascii?Q?NZWjMq923mJclgIwiSCJnjNgn8Ol8KeKt2T7b6piLYoFnu7OpVbCEPtP/niK?=
 =?us-ascii?Q?U+877/uL7PXxqajWzhGUBPb9GLpodEY0PqBwg/Zn8Erv1Uqz20CunHchn5o9?=
 =?us-ascii?Q?P4S592k2WQiKPgu2BUEmTqBwbJUhht9FbknzoNvgn+w78pMw4H1aQqSAGOPe?=
 =?us-ascii?Q?Ho/q07uB+dCZzBcj5t05kOYS1hCHuB11/hA1Om8umsj18xMud9GxF3YJDCXB?=
 =?us-ascii?Q?fLn8SQHKR03aDhHVvuhuEFD66mxzk1Etc3wAng3LGJ0mKbJP57tkJMnbndSk?=
 =?us-ascii?Q?e3BUTJ5OI4quwcThd5uOwUrAIV/qOSm7dN6xKQB5OKyTOWYdCfs/8b1qwHfI?=
 =?us-ascii?Q?0KQZT7nqRZIOi9Bzc0otNVul96yAVz7S/0R4DU/dfRvTR+Wdnx2DCegyziGA?=
 =?us-ascii?Q?X47VWtCjQRy5/RyDbJZD4068hKzPRezj7x+MG4ESAmwXbMAyxQHFib1/cI91?=
 =?us-ascii?Q?PgHNFYITu+4/MkF+3YDAzJKmx5yLEV5Wskqnm9JokYNax1VFf22APHk4pF0n?=
 =?us-ascii?Q?mDyyfCSEYUBoSaRF2r81srrwfKKadzWSHYY0qtyIfK+7kImRbZVmopG8wvhK?=
 =?us-ascii?Q?NQVVaGWXNW8XDLyf9EU1B0XDcMtEEtEbckkR0c+CCmvmfLCU3rs3mFI2xBAB?=
 =?us-ascii?Q?7pjAWRO7oneaosSkFwza0ZKEk7Ts1Nos5RLPnzWSoNUr4+rGCu9+q7eaojhg?=
 =?us-ascii?Q?FAx90rlTPmHfSOuWOR3WrCutAD2/8/1MmAmAtM8+VZC5G7FsLz+NYsh0ViWH?=
 =?us-ascii?Q?xJ34QYhhK9R+6T7RBPq3CpU/GfqPh5bpXAJ/T+BwVn//tFR6pkfT/kkmJTWS?=
 =?us-ascii?Q?YN2+tuSEfCke+tGvhtVQKESTMEN5MzaE3K+4V/fXJmLHjA+HKHJcQxFL1Wn9?=
 =?us-ascii?Q?1fZ28gyHzcjSzBZZJ374fUZDdnehhm7m45DB41Wvrpx9IqW6SM5xzXxySSuN?=
 =?us-ascii?Q?xOdhgn0Gy1CzscZx7SqHl5pXusChVRghlQBMZcqvK2FRbrhdVg8CoGYASts1?=
 =?us-ascii?Q?9O+wFHbYzJEW6m11Q4qFsYRfr3LkHRRzhYFs/m0qGbL83gpVGGLLOPUX1Ctj?=
 =?us-ascii?Q?XgaW0ZQqb1iq92/skitomZw9QIGgrUe5fdWwo8XY+ZIkXtNiNQsXmcK72Nqb?=
 =?us-ascii?Q?Q7/v5ZhRxWz1WMH4KXjlV/7lFcdeeP5HAe64bQEerJtrOfcZ+VfV0MpH0vW8?=
 =?us-ascii?Q?6dxO///NvaCPbgqV4vYfG4ZbIk/aWkKVajwy/JHZdWP8VRWhjOYKcGXzIpkW?=
 =?us-ascii?Q?WaTbnc+Zc19iTIomCA3+Rh/Tgd0bVApUqBBQq1QMUPkEO8Kj0yai7cGzR3o9?=
 =?us-ascii?Q?TbsKVMB/hDkcyst4ipRDfWOjPVo06U/z2r6aE9DfxST+dE/0BP6pNABacwX7?=
 =?us-ascii?Q?HrC+aIeRQw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86ecd44-0a47-4cc6-d110-08dee0d7b9dd
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:10:27.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50kfWKAOp6RqVWcYJI7bmZTLjWYpzh93ZE3dOCeKUXx8z5Q05i6niqcRBhCIRYGN21Flpu6QA2h4+7GA0tFnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11886
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307140-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:from_mime,nxp.com:email,nxp.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lhhybhsc3xal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B49E574AD55

On Wed, Jul 08, 2026 at 07:17:37PM +0800, Guangshuo Li wrote:
> fsl_mc_get_endpoint() returns the MAC endpoint device with a reference
> taken through device_find_child(). The Ethernet connect path stores that
> device in mac->mc_dev and keeps it for the lifetime of the connected MAC
> object.
> 
> However, the disconnect path only disconnects and closes the MAC before
> freeing the dpaa2_mac object. It does not drop the endpoint device
> reference stored in mac->mc_dev, so every successful connect leaks that
> device reference when the MAC is later disconnected.
> 
> Drop the endpoint device reference after closing the MAC and before
> freeing the dpaa2_mac object.
> 
> Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

