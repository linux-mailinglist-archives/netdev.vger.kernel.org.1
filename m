Return-Path: <netdev+bounces-273150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNXAMMRqymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:21:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00335AF2B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371DF3052604
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0E3CAE9E;
	Mon, 30 Mar 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Td+dAQNH"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405493CB2C1;
	Mon, 30 Mar 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872762; cv=fail; b=YxYnFJeANg2ac7SYcLoX78JTM2iLBryD/mxto32yCjjwHoJfKOjs446MKaqJOhMHzXnEWhdjdJkPsGhqU0K2Vu5oKXHKhKKycAHqCX6yrpIQHLXvK0dapfeNYKD7LxgtCLuasZR7bSwRgKrGURglLY65kLbY2K+ZqRGpRYDYVBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872762; c=relaxed/simple;
	bh=5xc6qft9hyuc+QXcQtjWtd5YdQ+iMgeSlFXMU9BrbT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ikoSZPYjQtzi1r3HQorVwpUaisy6Jgv6ZOTllX2wsZuQZ0O0T/Qca6TQD4HaBcIp9WmBOS5ytemmJ3bfnUSji0is0RXjwNoS/2FNIJQ1nLlIQNf6PKmV8y+LDLXSHhD2cfA+KGBJJTGFWhOmPoh0APz8erkALDW8CVBIz0xKCT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Td+dAQNH; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGTqgRSrWxLTVDlpFxNyVUfTie3b6YrRElnVSySaE7v5r4T1Df+9eT20GRgzGvMzuwh5VXhjdPdt9eorjoX2E2Fux56KuFD9hs7kYYIurq0M17YXABXEbB89h43w2sbHLWCmEaBO9cW400+QYwXzwZQtW5tGVo7vyzx+5iFIlgDedgwQTXtDH74+gs9dxBeN53hFwmnYoU7274/D8Oxk/v3kEHrYXi+JhyBuvNGn7rmKIUu1E62Oc8ecBzL8E8sN1Pz1I2V8Wrb1Zz/xDZM9AfDSdU1BRktgjhE1iM8rBtsnljxuW0E2UnpCE7E1YUvXHAcn/KFSmiA68oHSMCmWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn1RefXgBrxZ0fnSBN4LpVLxdu44VzAuaOjbwe1S8Tg=;
 b=h/zpJ55Bu/yzNImEWBusdcrPOSxXxYX109JgmXbsnZsfYr4/SzPUFc0WUdG4sm+nByE3fSvN7F5ktAv+2AeF6kWmNi6k2JzhRgCZpcUpePXOMBJG8IuUI3RfwA6/JiFJSQ/T3XASKOCmRRdQQ7fZBYJdadl4rzvduWqO08tCxyIioYhIN+QR8ooUuTtnu0kWqmsBzxFG9xBOvwb4Pqps7qTj9G0I1lbphf0DIaOFevcNWJGj3zfdfm8pjvhicdw1xNRPoyfMilqz3O3LptBnMTvxC8wFrWggg95aDx/XX9yZC7vDSKCEJALIGGGukchO++dCFVb8hoesEK7yCKZqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn1RefXgBrxZ0fnSBN4LpVLxdu44VzAuaOjbwe1S8Tg=;
 b=Td+dAQNHyGCZZBgj16r4C2N2z3vy9LmgQEyQ3g8IYfk3PERrti9JaW2fSl2HgvH5DH+SOz6sd4DNcMz7HJ9uSAfp8jadHqpF0kfM2b3iREc+y7b+6Ska8sSdmoczEj3YVEhajHzXk1rq8zhOP7ikcx4mZAp6HTnLNx4NZ8y9Yyvhq+frZXSLzLFSLUPnrPlHJ98JzNtd0VbMPxcfnNc7vizDMlc8zQn+mCUWnp+ZzQm5LXVSCndmf//jZw3szjlH7PUmVypRjhe1vd3z4jwYkCJRNrbLQ4srYXTlJntBwd6fPQHg0nhjJl9GvecdDIPIi3dif4gcjmk0VfomE2Hilw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV2PR04MB12436.eurprd04.prod.outlook.com (2603:10a6:150:343::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:12:35 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 12:12:35 +0000
Date: Mon, 30 Mar 2026 15:12:30 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S.  Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/10] selftests: net: add helpers for
 running a command on other targets
Message-ID: <mmr6xs4soark6ilc2xymgcvn3wij2yoaeokpuv5i62mxtddvpa@jdyswkdydpon>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-3-ioana.ciornei@nxp.com>
 <871ph15zip.fsf@nvidia.com>
 <87se9h4juh.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87se9h4juh.fsf@nvidia.com>
X-ClientProxiedBy: AM0PR02CA0121.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::18) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV2PR04MB12436:EE_
X-MS-Office365-Filtering-Correlation-Id: feb6ba24-8475-48cf-c1a0-08de8e55a0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003|27256017;
X-Microsoft-Antispam-Message-Info:
	fwjAtBV81gz71W2Y3preWoAKDEUAXKjQIbtva9qDDB4r/Si9VwWkN4UAE5LbT8mgMZlCziTXTnrRZtMPT4a976kENP49SC6XJtxeAdw65zuXQRV/HPaVH50QbI/Ozx+HjDNDVkGJtSmDOnTAaV9a41VNsctgXgvGkoXli9Y8lQnfmVUqh9QoTE8QGB2Cdf6Tw/Iut+TW6fSSdumIJq9cPkDtBK5L9xbQt6crUvlsc4wdRz4ILsEbfoBP7Z6dJCZnAWO+zB3b0y4eKIyn1wHZGfM4LW7+FejYZlFg8THF3MGd0g/bveMthc2R6e6Jg52CvtawOuFq2g46SDxGXxleQXcAjW7sHuXCTG+7b1Cr3OIxuMNsFtmJjCcWmdaT48f4lJqgy6ilHjzy0Clg2s4ZWWLIHEDgM4ieVpm593k+KnyT2h0Q49886EDu5RNjHc7PbxlFFEmUlzEIWFsfEdRccHdH3Tt0igrsN6KAzh+yA00z6LgO3IwdaIQrv00x+h5KuOnUO9FFrr6Vl0705wqC6f0UQXt9ekc9r0fxEL7yOamwT126cRprz6gdjRr4YphU32sdezQIJaYUPfrCRs1hlC0Y7BP9fnHMwe2XrDqckZy+L3zXphmegEcTFARq0BEn0Xp/jBKKZj9VZUpn+la9yn8PNCtQ/rg8fDrTi3AATMEFqRscZKt8Y3kwDslV73hsRrRvB5iD2+J4gb/6b/selJH9JYFInV8jNYiTsGTlxTc1tBPO8IlCz3xXUQszHjPk3YYO62JhcOJyELETLrQBwQqWe7LQMKOE0HM40nfX8xo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NhM+yun4Kw/MjhO61Lxn3L/qz2bVNv9Z+V2n4AynrvACULJPU4cb9p3LooRD?=
 =?us-ascii?Q?xa61bQM7KYP4Q4L3ltuF6u8h7Iia2b0Ap+LKEkk/tm6mVlB9u+sQ5AuqkPQh?=
 =?us-ascii?Q?BQ3D2Cb8alP1HBQ+D0KMC2qVb9/IlxgTLxjY0saCzYT8SE1t8xrV6EMcO61Z?=
 =?us-ascii?Q?SV6tLKd77DzPLuggxhbrcyCFAj1tWNrucu8HNp8Nt22NvLGVzdXxA00s3G9m?=
 =?us-ascii?Q?e/f7a+JG6lW+ucvUFW0Jku/BbDj7Ua0Epxpf5ILKcMi+jLSPoHIQ7cE3Aq3C?=
 =?us-ascii?Q?qqxg+y/RFPche9JhyLTMe6zWnGffGEvhRHD9NOMLCQMc7RP1MoIpTMZwGC6D?=
 =?us-ascii?Q?svsSYCcU85YTfHLY7uzCrXKWEvPwpq/THulb6338pmBWsKX5QdaCsK3Vfkz1?=
 =?us-ascii?Q?/OMFMxB0+kbSvlNJ84+30C14Au3w+N4W6qUwdGeu8zlhAxmYY6lQkyv/qpTf?=
 =?us-ascii?Q?qhonSqtVQwffxoITZtPEZXxtolN9bjjy5NOwiRBInX9hqDkebRHFOJwj6P6Q?=
 =?us-ascii?Q?6BPKdOuWQRX4H4v/i1wxTMR3+TyX9XhQBhMZakMtnM9B+QF5Re6QWdvDZ3DX?=
 =?us-ascii?Q?IzMihlKwWrppdkivyN9gtbHksTFUjlHSlmoq8/njK/MAOnNuCsq/TPSA3rXH?=
 =?us-ascii?Q?iRKM5aKvI3ovUQxksCntA5ZlkyQflzn5YNBECnyTIn5jbOK/GHSVRtVamqj/?=
 =?us-ascii?Q?BQo9y1qw9D+O/cESYa2FmQYQXjBTpWKa7LF2vWpaFlxwXnZic3d08GGsrj+D?=
 =?us-ascii?Q?IFi9d59vTeE5RXKvNLkl8mx8lnQZPWm5KuJ9n8Nnwk33V55Tkxyyn5v8Hf//?=
 =?us-ascii?Q?bAi85lp+/FYo9XUH3JfmWxHQcpIzDmuuv7FLN70TTH+P1fp5fDijHh7yF1ul?=
 =?us-ascii?Q?QXQYD5MzFlEUpmCKL8Usxo4dJMtqczJWZV07msRzHLvdFkuM41p39aLJNXIG?=
 =?us-ascii?Q?I9R0lWyyqgTU65KD7zgfYhJe+3d7UDSpS2JWPWvtS7PvrbtupAmZyRCK3FGR?=
 =?us-ascii?Q?KG5V2SEtjzukQ8wGcFTOMtK7alxPj+iTC3/xfHmJ6vvBegLk9Po/IXA/b5kh?=
 =?us-ascii?Q?MsanrGfqkz1RKaHgmNCsTMP+fvdtOQoHpvaV0prdty85tN6WEOOswQP65ruf?=
 =?us-ascii?Q?/HXWZdhgeVb2VtB4caViZ8qUXWxxrQ+kta3YlWXzkhPchHGHtb2pB6AHok0x?=
 =?us-ascii?Q?+IfR3RrFIrvSj/RDYKU4Y2wTBz1ZmgKD8ILDrmHY7hSOyqV7ezz2kQLjDzRJ?=
 =?us-ascii?Q?ZqqGlWlKH/EJxTEYcivQimywO5NctKYWrEOXP8ID5FNNUNyXh5OEHADt0lMA?=
 =?us-ascii?Q?/JbMMSm4dXdTDjKVYrDXRIDr4/SKZB582vDiMic7NJFbtprrZoYdzr2tCKDe?=
 =?us-ascii?Q?HUAiPAHI2wcpJVdxuIVZaZ+LP/F/n/1M+R8vdA3Ityrz69uIJCpebbWTbllK?=
 =?us-ascii?Q?ZE3bw7ZK1gikdkPMGYZWvGFF9azD4ANvijYC7TJOKpEsL0XfEsh2dqttaKrt?=
 =?us-ascii?Q?/Eu7kJNGP733Bv0v5ZXToSW7QBvwe9h9J9fwEAzlNsa3/smldOnQsuRPDbZg?=
 =?us-ascii?Q?E709v4HexeAvhjSY2k+XDjOp+RfKeTMVjIYln278VjOwzXHkqwCdJGrTfTal?=
 =?us-ascii?Q?lStwy1yI+NwzWBNv8k9gDaXldru1+k3Im7+fKDRrOUYIbSOTuqm7OJ2CUiHN?=
 =?us-ascii?Q?Z/dRPdWfbvIPC/rdD5ULRYCJRpsCp3HhXRAXGn9T1QiqtqUJ/ssGkjtScgQ+?=
 =?us-ascii?Q?U0b4dls0SA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb6ba24-8475-48cf-c1a0-08de8e55a0db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:12:35.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+8eUJbZOx91fYCUVak08YPYyzFLGONxMao7OF0subfOx9oQY5RUU2CJbGUbc0FSnC7+HZR/kSICqqIDTsZxZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12436
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273150-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:dkim,nxp.com:email,host:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.sh:url]
X-Rspamd-Queue-Id: 3D00335AF2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 01:32:41PM +0200, Petr Machata wrote:
> 
> Petr Machata <petrm@nvidia.com> writes:
> 
> > Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> >
> >> Add a couple of helpers which can be used by tests which need to run a
> >> specific bash command on a different target than the local system, be it
> >> either another netns or a remote system accessible through ssh.
> >>
> >> The __run_on() function is passed through $1 the target on which the
> >> command should be executed while run_on() is passed the name of the
> >> interface that is then used to retrieve the target from the TARGETS
> >> array.
> >>
> >> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> >> ---
> >> Changes in v4:
> >> - reworked the helpers so that no global variable is used and
> >>   information is passed only through parameters
> >> Changes in v3:
> >> - s/TARGET/CUR_TARGET
> >> - always fallback on running a command locally when either TARGETS is
> >>   not declared or there is no entry for a specific interface
> >> Changes in v2:
> >> - patch is new
> >>
> >>  tools/testing/selftests/net/lib.sh | 38 ++++++++++++++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> >> index b40694573f4c..6c0d613a4de5 100644
> >> --- a/tools/testing/selftests/net/lib.sh
> >> +++ b/tools/testing/selftests/net/lib.sh
> >> @@ -670,3 +670,41 @@ cmd_jq()
> >>  	# return success only in case of non-empty output
> >>  	[ ! -z "$output" ]
> >>  }
> >> +
> >> +__run_on()
> >> +{
> >> +	local target=$1; shift
> >> +	local type args
> >> +
> >> +	IFS=':' read -r type args <<< "$target"
> >> +
> >> +	case "$type" in
> >> +	netns)
> >> +		# Execute command in network namespace
> >> +		# args contains the namespace name
> >> +		ip netns exec "$args" "$@"
> >> +		;;
> >> +	ssh)
> >> +		# Execute command via SSH args contains user@host
> >> +		ssh -n "$args" "$@"
> >> +		;;
> >> +	local|*)
> >> +		# Execute command locally. This is also the fallback
> >> +		# case for when the interface's target is not found in
> >> +		# the TARGETS array.
> >> +		"$@"
> >> +		;;
> >> +	esac
> >> +}
> >> +
> >> +run_on()
> >> +{
> >> +	local iface=$1; shift
> >> +	local target="local:"
> >> +
> >> +	if declare -p TARGETS &>/dev/null; then
> >> +		target="${TARGETS[$iface]}"
> >
> > So I think Jakub's runs fail because there's a shell export somewhere
> > that gets inherited through make to the launched test. I guess it would
> > be enough for the test to validate that TARGETS is an array, because
> > those don't get inherited.
> >
> > Is there a reason not to reuse DRIVER_TEST_CONFORMANT as a tell though?
> >
> >> +	fi
> >> +
> >> +	__run_on "$target" "$@"
> >> +}
> >
> > Does the latter helper need to be in net/lib.sh? Since it uses TARGETS,
> > which are a forwarding/lib.sh concept, it seems misplaced there.
> 
> Oh, I see, there's an invocation from mac_get() in net/lib.sh itself.
> Hummm. Not sure how to tackle this.
> 
> I think lib.sh might unset TARGETS explicitly? Or declare -A, but leave
> empty? Since it's now an API, net/lib.sh needs to set it to a reasonable
> value (or erase). Then forwarding/lib.sh might in theory rely on
> existence of that variable and not have to declare it at all.
> 
> Or, maybe have a stub run_on() like this to satisfy the run_on() API:
> 
> run_on()
> {
> 	"$@"

         shift; "$@"
> }

> 
> And have the full-blown thing in forward/lib.sh. All the magic with
> TARGETS really belongs to forwarding/lib.sh. Bash allows function
> redefinition just fine, so a user importing just net/lib.sh would get
> the stub, and forwarding/lib.sh users would get the full thing.

I really like the idea of the stub run_on() in net/lib.sh. This would
also give me the possibility to check for DRIVER_TEST_CONFORMANT = "yes"
in the full-blown run_on() without having to move its default
definition in net/lib.sh.

I quickly changed to this approach and it seems to look good.

