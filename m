Return-Path: <netdev+bounces-297882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TgsNEXYZKmoNiwMAu9opvQ
	(envelope-from <netdev+bounces-297882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:12:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E00E66DC28
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:12:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Wif4xy8x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297882-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297882-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04A9F3010BEE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F326FDBF;
	Thu, 11 Jun 2026 02:12:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885C26E706;
	Thu, 11 Jun 2026 02:12:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143923; cv=fail; b=P23/YOM00ZOsXYAF35WMG9FXEkB0txD5I0pp3IGTphEMdF9+Rxck2DrDaQDvYmbR34ZhQQsBU2eMe49g6q3UK6EqAXjLNpB/uP2aGX+O3lQRgEnQ9SnuFXO68bbjLyjXP1Gx+vUamNfq30R1IogGIUaCEVTzXsB5peo67/wMN8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143923; c=relaxed/simple;
	bh=vEXFLm9DylGrsq4c8d3lugCowv8v0OZFrUELSql9dX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bT9gTwFTXggZK9kV3E0OR2jtuFAGssqc7vIK1Rqv3njOW4spzY6mjPLikyPKNgFARyq6qDeMCLFfV6ShZ9Cd9Av+0wnX2htR9YFgs7lIDT6AlU4JUi9Q0fcPVQ8bUsiKG4X7TFfXFpzXdK1vMT7D8xJKm0iDut4obLn4tvt5mWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wif4xy8x; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+ffXVyDi2gFA8pAI1qI1drbG4lHpd94HDuhIXKFyloZXfJGj92z6kh9hywsTiPRX7D2l85aGnUWmCsQ3pMR7BF8FjtzM0LTIxFoPMOOwAGrJ45+nzh5Xjc7Ig20KL07CF1MKTWBjrp/x/J9DyABG97jDxBeej7cm6p1KyWhpU+GShbfeleC8mHW+0u8xkMYA7uXotAuMbMTd/M0n4Ui4a8aG7A/VxQ7eapOPZHkfC5vd5KP7C82WB+3BKUCAr+g2pZYaD3QoSoRgDZpuzSUISBpo6ioESoiaB1ACb54sEn9qvk+uQzUoHfu0ltA2pYW7AfFqm4wPg3/uv6WIq+fTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=y3PAxY7SP03ZXImwQOJopcxfRGeyFfZ58nKRNwq+JVGfrQVjq00q8yeXefPYZ6HFyFKP3v/BufPiJmsAkn/Ta8JCQcN27+lnJjxE+a/JlOAuRQNEsTxShECuwBo8TrTXzTIcjcAxaHnnkcCXqHWZCW/FpT+nwmFHRbQf9yHeHH8IUTSpo8W27fRYfvA9QjB5KAIeBboemS7rmbW1RyiEbZ/4rWBWBGzC1vH4nb3YM95ombNDoCTQIAPD1EqLrgNbaJeKDtGEe8w8pumXZZizpO56u9u2ITwJ7C/MhFObdMy5gdCjs72FIrti09BfzANbSiTFeeHpHte4Ciib72+nHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=Wif4xy8xuEPlde8R0+qWaO1cs4F9RWYkxu0ifdK/czC729AEpeqonzjEKYy1MtKDJ8Pi2j4XnF7QCdyJpzqIXYZBn7rGJiLdaF0DsyCcU80nvz96GjXvppjkHl9NuX+hQWRLl6aiguYuq+qxFqvjJ0L+uWzSxZBD0Q6rD5EueaaH5hEylS2O6Y4ctzhfM1j4gu8AUUZJ/MYx37ruxV0F8ZB/2bzarOt3X7VnDtSicrsHruSFeQNeIhmgANgG2D1lnAqASZpPgK8IvWywNA95wy/aGRArm76KvEvAaCIXDzh03lOf6YAaVb+DLSxbCraunEyp8vao8Iosw78HnCWKeg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:11:58 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:11:58 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 1/9] net: enetc: add interfaces to manage dynamic FDB entries
Date: Thu, 11 Jun 2026 10:14:50 +0800
Message-Id: <20260611021458.2629145-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0198.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d37a3b-978a-4334-2972-08dec75ed136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|22082099003|18002099003|921020|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	rzUSWKT3bl4zilwLPHB3KCZa74YADDj3yvp5PDgXvhTfEQEVbmdg4X9rqeMmRrFe9Tjj7wxSeP8Ojti6YiHmqXIeFC44dW9nL8jDP1wjl6D0t1VOV4D7HIAqxgAV396pjvHuKv6zHJg3N6sTdj3NHGYNHbVs7XAdFFRPE3Z8XT4tf/JLI7FEyXX0KWLLBlAAhLGxqBLzmZoeHzeWlmMlUaY8Ooqw1sO1M0l1JD4VWqoOIJvU9OZ1r8Mkf79pPjbq8Rc7TdRnpBFhMqm//vXYjugMbDRMaCGlE7OGESbtI5K1xhNCllhT4wpkXM0RMf5uWwuv51DR5HfzMSqbzXTlbIAeEwX7fngS4Ljf+C3fLqmlqQDoenPooDV8No1Xf7qw8RlCutd2y+bEZ8KqcPQQNPYIFiF79skg9tpnXRAlbIAzIKMazZu/ziJpWn9FM0ZstIYVA2mvGGQFypQT97QziadjuE8kQfuKX4N5JSOa8Q1oFWSRXelFrto6rRnXcPOxt7jQ5sK6OKgkMqQt36ipu7O7zj2IG0mYQ4QreJpp88e3BMHMFpiGVBQpZZmO7Qwdx6bszLCCJ3L1reIMTjlBaY3hhqo+SLLQ3cTqZMx9YXuY0TznehZ5jq95oq9T+vNvvcnyiu3+vxXRhjpxrbWpfS1cKJA7Euf9OrV6HGWyln7yEkWPRP+i+PxDenD0/ApggtPn6tesuCb/p0xWZiQQISw4pv3T0sE2wALRNJu4g7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eu/56GJghxc0sYKg+UkgQAI7NWubEfp800HHanb7mjuUNxcfnWuG+pS6pCzK?=
 =?us-ascii?Q?aIBKE2YLgpTIqDC1lEiMkFuohsSoYVikh/us4kJlTF6nDQ9MN0bHxaVvMMoO?=
 =?us-ascii?Q?9F4p2uo6LURnvu8Bk0Nd2OtNCZgGWZfpgfUgQAy/oVFkXlaFI2WjCjDUs9wU?=
 =?us-ascii?Q?rRG0Kov906xO43ERsMErOA7H+a3y61zay2gvI0MCUCNTscEimhcBWhE5wumm?=
 =?us-ascii?Q?7+Hsw4dfNNezezbNhSncB8vYhoOvClbC1gIUUzkibSKWFEjaUepyTcz2EfrY?=
 =?us-ascii?Q?fnMCzwTQzlKXYnv5VGBv9MpNzWMQ4lF+/lu0SAxyjBLHO2NdkamFyLdLqMxP?=
 =?us-ascii?Q?yizOFlDEfxAuIn23qbtNXmuc04MVuOAHEBqI9T23OYkXM+5VzrxpJShWYkV+?=
 =?us-ascii?Q?xvEHSivLF99+8i/lx0/72K9zY/NYbJBkOM5urf6RNXsh5ikaF5qynXbVs1hh?=
 =?us-ascii?Q?04no2rdsO4YpIWGLzI6bocdszf0mLlQO0hdE4pjNfsGiv6ZTGQ8Aczs9nrTd?=
 =?us-ascii?Q?GxMKpxtP1+x63mSJMQy15ntQhy5/iR0JdWP1sA3+73gzJTtoFYDEJxnby3zG?=
 =?us-ascii?Q?dc9r7GwyBwrnMu+q6HfXVlouQsHGUfn/B72qeNf9fsU5zSQfYLuBKfIra0HX?=
 =?us-ascii?Q?sG3/3N5sYyZj2CP944FSK1LFZAUJ4hMGXD7csnQCYjdpg2/TsH75vyAkybc3?=
 =?us-ascii?Q?E0VKx3ufzArNLvnqaadf35uJK4pj5seQG6gpSDarEEut4VO3wzVddAQ+fR77?=
 =?us-ascii?Q?e84/dY0tu3TtmscXJhl3/kL5K7sNpA5myR7hXh0Va2QuyqW+qcwnx/bXzXMP?=
 =?us-ascii?Q?BMHJ1RCsUeTw+WMHDdZrwL+LezxYIcPEaN50HAoWcrnJw9olWvhdOk0xV+tt?=
 =?us-ascii?Q?t6vN5LiEIvLD0GfpSxaB+t/G+2/ltgy5s1acLjlaT7mihmC2knU7iX7Ue5dM?=
 =?us-ascii?Q?e6zkD4sKCodtuxPD65KEqHzgK0NA0UABgvh/AX00QnJuiGZFqNLnROHE4DgQ?=
 =?us-ascii?Q?23xZNfsKXJhiKbRKtOHFLE3U5P4mIIXC4Wr8WEWBYPD+ryzwLcnatThyxCbe?=
 =?us-ascii?Q?BJzIUoSAW+yr+x5G2q4FLGbE+0xo9w2i4GvwC0x8R/qZjdFbOc5pPQrVBjYY?=
 =?us-ascii?Q?0YSmVXzu62gjm3UxYE3pw8a06kPQgYKRa0kEYC8FpBaLtwvOJLiedQTXRZR0?=
 =?us-ascii?Q?cMxRTsrHQwoH/Ooy2KEERtZJPMzM4NobmKkYsx5vmeUflqbfGx9Fa29qfWhk?=
 =?us-ascii?Q?XPSBByZRkoTGOG/frA6EsU89/gxKgMO1wQGiQAHpw6kuQm2rAvObGEYs9n5y?=
 =?us-ascii?Q?OqKBMdRdEAHre+aMsdY8aP3ir1mmZ4c5g7lmN0F98rQAZvkCNoN4ns8cI7I4?=
 =?us-ascii?Q?iS7MHj8EE1vQfXOQBgQoP5SpA6EmcWMJPCB9gkROrSvrJAgNjHHDG3OfAeF+?=
 =?us-ascii?Q?fUYeFXQaSPOkOVNSKH0HkIi2AcrkGd4/qR+Kao1zpJc0BYjS0opRaOJlPQX0?=
 =?us-ascii?Q?1NrteXgO/xxWQPjCYqq1pf35AYORS8X2GET/EXqHR4V6YRziKX0t5CzwdQnB?=
 =?us-ascii?Q?2TJkqUFGBhwckeIvq6UfEfxVNhGgooXHCPlHE3lllDX0tXQPhaxUHfU+ZprE?=
 =?us-ascii?Q?Uo24+yD2R+s3G4mitqUpsahwRp9ruac+VY1DNb0ck6zyx3Adtf5GjVGtW9rX?=
 =?us-ascii?Q?1qBfFH13K7uz+wbObPHTE/RIIMZ0qrP3QwS4I/h/gIFtKsNRceLuz4TXEwzE?=
 =?us-ascii?Q?vcWlax+BgSX3ZdQgjhv3znPzlWAfC9/gASjHbP7KvwqYMiNGdZMb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d37a3b-978a-4334-2972-08dec75ed136
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:11:58.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C5wNDIh8sUAMnz0Pv2uEXF5Mn8LsrPeCZrA8v6PBKkLAz7cpKk/MJWZxpn1/40AeS25nryF4sSrc9B5wPNHIl34EvA4I+0hwIWHC0vz9trf/Rely0bfNlVb0sci+sgz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297882-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E00E66DC28

From: Wei Fang <wei.fang@nxp.com>

Add three interfaces to manage dynamic entries in the FDB table:

ntmp_fdbt_update_activity_element(): Update the activity element of all
dynamic FDB entries. For each entry, if its activity flag is not set,
which means no packet has matched this entry since the last update, the
activity counter is incremented. Otherwise, both the activity flag and
activity counter are reset. The activity counter is used to track how
long an FDB entry has been inactive, which is useful for implementing
an ageing mechanism.

ntmp_fdbt_delete_ageing_entries(): Delete all dynamic FDB entries whose
activity flag is not set and whose activity counter is greater than or
equal to the specified threshold. This is used to remove stale entries
that have been inactive for too long.

ntmp_fdbt_delete_port_dynamic_entries(): Delete all dynamic FDB entries
associated with the specified switch port. This is typically called when
a port goes down or is removed from a bridge.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 162 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   4 +-
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f71cad943424..bda26fe93b8d 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -31,6 +31,7 @@
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
 /* Specific Update Actions for some tables */
+#define FDBT_UA_ACTEU			BIT(1)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -793,6 +794,167 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_fdbt_update_activity_element - update the activity element of all
+ * the dynamic entries in the FDB table.
+ * @user: target ntmp_user struct
+ *
+ * A single activity update management could be used to process all the
+ * dynamic entries in the FDB table. When hardware process an activity
+ * update management command for an entry in the FDB table and the entry
+ * does not have its activity flag set, the activity counter is incremented.
+ * However, if the activity flag is set, then both the activity flag and
+ * activity counter are reset. Software can issue the activity update
+ * management commands at predefined times and the value of the activity
+ * counter can then be used to estimate the period of how long an FDB
+ * entry has been inactive.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, FDBT_UA_ACTEU);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	/* For activity update, the access method must be search */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update activity of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_activity_element);
+
+/**
+ * ntmp_fdbt_delete_ageing_entries - delete all the ageing dynamic entries
+ * in the FDB table
+ * @user: target ntmp_user struct
+ * @act_cnt: the target value of the activity counter
+ *
+ * The matching rule is that the activity flag is not set and the activity
+ * counter is greater than or equal to act_cnt
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	if (act_cnt > FDBT_ACT_CNT)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.acte = act_cnt;
+	/* Exact match with ACTE_DATA[ACT_FLAG] AND
+	 * match >= ACTE_DATA[ACT_CNT]
+	 */
+	req->ak.search.acte_mc = FDBT_ACTE_MC;
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete ageing entries of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_ageing_entries);
+
+/**
+ * ntmp_fdbt_delete_port_dynamic_entries - delete all dynamic FDB entries
+ * associated with the specified switch port
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	/* Match CFGE_DATA[DYNAMIC & PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete dynamic %s entries on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
+
 /**
  * ntmp_vft_add_entry - add an entry into the VLAN filter table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 0a9b87286105..ad532b059ba8 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -155,8 +155,8 @@ struct fdbt_ak_search {
 #define FDBT_KEYE_MAC		GENMASK(1, 0)
 	u8 cfge_mc;
 #define FDBT_CFGE_MC		GENMASK(2, 0)
-#define FDBT_CFGE_MC_ANY		0
-#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_ANY	0
+#define FDBT_CFGE_MC_DYNAMIC	1
 #define FDBT_CFGE_MC_PORT_BITMAP	2
 #define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
 	u8 acte_mc;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 88166f9ad3a2..5db078e1caa0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -263,6 +263,9 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user);
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


