Return-Path: <netdev+bounces-275733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKLdM4sb1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:46:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135E3A74CB
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA87309C208
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A930FC1D;
	Mon,  6 Apr 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FAk8uuNr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DB30F94B;
	Mon,  6 Apr 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508118; cv=fail; b=rRaU3PXPSbnrR3PrFiGMaYqNV5T7supl6t+zqbujrVgeKIaNsKa1IBf+Nzn7atAHkoWrh8ftBzp4PkxKB26kJeL5EdQVicOmFehOJczw+jWSrtm+wLxFaF1vWIiXEJZJ+svu9NKaio1NzWmXJ16Afwnkm9a9shYTaNxNwmcjl8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508118; c=relaxed/simple;
	bh=zBw3Ylbwsj1kCY8qa7NH0oTZGTVuU4pdCpBZJAPEBi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIb/9FUT61bskS9WS0tWq7KFsvi1QsJj/0+4b+nfcUja1lOIdsppw9HxX9l5CzHztl7qomu/UddYvP3eNa0zvDggQL6tTl6SN5HWADe6dWhiSeIq2+gVV074P0R2Auk/To8saA7XFHwnULqIfD7qo5wvS5MkkanoiypNtA0qj7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FAk8uuNr; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvKMEir7Rfhip+2IMZZaEyAVE+uI2fJfQhsmgviwCTrmXqd9QrgsoHakernFoO0LXfjjYdjfTzeoC0kmgcqAXoL19cKW/NMGWF3WtY98ZEMhUyIM9k/psnuomnq6WbfIu0iIA75ydLqv2lU6T9LUE9Fe3iZ7VFSQ/rGtHPhVI50m9ltPMGzgG1yM9+K+dSR4ktbyupvwrQ3aOfui1hLTlU+jhQeINn4jFus7opSFZAo1OBMaOMUQI5XG+ud2BBJxA3XoYRUO1NxOE1cgulXtUDNZOdSSk/bdg41WwsYbmf4YZLpq3nPsheDCtjVP9ma0sFD1XtwEs7pjVghEWmGZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggx0MDj0n6q9KOp6w6WvkpbbvrIkB9SSZZXNJ85oWDE=;
 b=r9KLLV95E2+FVjtfVjvsXidYI5BJRioQBsp70XI7AnvERL+83b0tQxjqqCgDfw0YCEDPoLjvajA7btX4d1cphJJFn4/f3vyrxbcXRAX5lT0eJ0bpLiG9c45sK0sDlNfMKUKpCziX9ER45ObeTjWX3Z1mSnGc40+EvLplVXJ6qlyOa6a1XDO4iaXst7vqKOwykZvYjjCUZfKa7X2mPBvPFrlY8+K59ry8eSAdzwLDpQKINTJJBCnpjkYhTvdCjthZLTLA8OxvlX4N3SE/Yb+R+ZUZJxq0D/+7CtfiprwpOrpty7aMMj4obakWL3FYI+yTeLg194O+mITxpgGCd3QY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggx0MDj0n6q9KOp6w6WvkpbbvrIkB9SSZZXNJ85oWDE=;
 b=FAk8uuNrnX0RWrsyVSwRl6AKh5UlM0bVKaItmcxr8fRA92kSvJsuahWyuusWPUkQpnhAdoLmvp6Q3utIcFJVGXF6MN7ZudZXkqaQ62YKQnP7EcEeinZPI+41qtoEhqg1DjRbHMT56F+BhX1b9Zw2YJ/mMvFWZXrwCiuecKTZGAeoDJgxjWONjSubczH112e+o2S+9gIeKQxTnQzVgHWKOT4gNg9yB6c8o6joJpF1do+zGDZwjhwTH46ZbeJyqzm9Vcf3XsCvyUCTPd7p3jKBv46V4zRRi1OL7Z6pu0pXvff37QfWIJunN9UgF8+5kd6m5+ZYX3xEjKjLCLhjjibvUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 20:41:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 20:41:43 +0000
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
Subject: [PATCH v2 net 6/6] net: enetc: pad short XDP frames coming from devmap
Date: Mon,  6 Apr 2026 23:41:22 +0300
Message-ID: <20260406204122.167237-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406204122.167237-1-vladimir.oltean@nxp.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca71c76-d5db-4136-46a1-08de941ce996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Z0szbtvcQoweGZypzfal4pnR8q9nVgP+BKUgQlqsGPQtw2Uj+19l29rxGQL4Z0JAGME5U+qibcDTW70yEcILbyqa3Xk7qihQIKI1zSYd0qkp5AO3SD9W+4H8y7EHBRvcav0+UgXrsoWs9rahoJa3o7tt0yObGmSwO3wWR8hVz1sqm+0E9ueW46QuopKzc7jKnq26x0IWLGkyMngefWO9iGVYB66BURL0xRexNWZcUs19JyZse5XKJdeGk9Ht2mJF78KpDdQHcBnquUHaKbxPpMO7jsomQz6oduACi5b29+sBVeg+jNKMWIs280N+JU4FdLIaa7U2dighLQ1WfE5XMq5tpY+Oh2fMWFeyZfvSLcbvsV14yQcLwi0orRsxNLTVPiNaqeaBmTkYy3bUXJ6Q8PuxDn7fqOlvw7gWusKWFwNJrPYC1qqiAqb8kybJytlM/amWfnogvncrqXqmWDzv375Vk38lqiKPrjwc0AzAy8zABfqp/TpaP3dpzb4T/oTURiN1VTRmkp4+5k1hubd6faBftScmOj+rpG8GxY4SC6mU34Gdno++vkenQK/69/S1ObuA9zDOH6BKc7F4orpLahvzBWyoJ1NJ68MNfpI+/7+cxj7j3chMmgnVDEo0mY2fkmarv0fnv8bSh0rIQoP7dzoK1SuQMfLtWMaZnnKSJslghFaGrp4e5FUlbdphKxlypSTtzleQw/fhw5LhJAkhhNlIj8BPRUIvrWghmqOQY94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQWXjuoIR4p6MisQtUDh2wytmx7uYQJ2PNw8Y7s46keSDHLwwAwcFlYYjZrj?=
 =?us-ascii?Q?Hi4WyBBtao58+EfwrK2DYxaSypG4JkUlSclUhA6XMJQwWp80pj9FbwU+6Wrn?=
 =?us-ascii?Q?sgd15QJYNpptCTieCb9q3446+u/qxVWqHd/aoIa33lUv5w6BJK5G9TgUMu38?=
 =?us-ascii?Q?l0eFl2x/lLAlRhUMVzjv5teb0ePtvwgqHH/DZSlrmpYmK//+nb3865lIMyrJ?=
 =?us-ascii?Q?uG+3C5zPgQKDfucB2jFXgBrxsH3JH9dTvvuph6x5DmbnTTOATHjy7cbdxoqg?=
 =?us-ascii?Q?OGdkza50FAqbvx9+r85636L83OX7k753iNKY1zB9RGkb/Bd4q0fJM/6kPJ+O?=
 =?us-ascii?Q?8IjnnUxfpaHsdbsbNVfUNS79fP4KFvUw50m83KexPIFCFW4VqaHs/acl9ZHX?=
 =?us-ascii?Q?JtqYuWiBUwUwMbp6CWXk3vMzc4o3G0hFlTA9TGCka0+iM468rCHRcJBbArFc?=
 =?us-ascii?Q?Jou2Ri594RhCBpwQID23SBQ2A29/i3FzMOGvGGxVeySd+1X0z3i6xriywiGa?=
 =?us-ascii?Q?uigSkP5V4h/biNNJ3rHem85vk0xeqlfel/0y6aF1+2p0PBrYS7/ZSg5WZ7yv?=
 =?us-ascii?Q?jkCBq51s46KaGXMQD/YrOASu/sLKOMeVyyWFKe881YVT/sTcQW1ALIW95+2P?=
 =?us-ascii?Q?XDen07DRmD9JfifhwvS924uHYMBBvkh8pFKnXyBatVnzkf/jvqaW4CqMR+QE?=
 =?us-ascii?Q?SUXEYRSKazEolTwzwgjBFROjuuQ018x3bzxwzRqfu4d4iNty0mOqtdk/gBYB?=
 =?us-ascii?Q?e0/FPZqSShbGXn+Ndfpsq4zTDrkU91whbF1fF56g2IkzE9YQzea7hbkOlBKE?=
 =?us-ascii?Q?bQSDTUfLm/Q0zUmc+EwCtSL6xwCpKKxW6/boT5FAoZuOvp/K2Xur54TSbHqL?=
 =?us-ascii?Q?VRewsIxgWAggtTnKtzUB1TiMh/EqP8dwcUYMDwy1BMDSzj3FU5Yo1gopYWBF?=
 =?us-ascii?Q?kPWDy3oIzKYlbu0M6qH9cQTaiMYq/e+gtv5s0vAVP888x+afdraU2luRz9IK?=
 =?us-ascii?Q?caVVSSN5q+pYv9KmoZAZunnuUO9bUFFz6uDm+pPjK34aqGzDA74cDtrD4xJS?=
 =?us-ascii?Q?0O4uOYLx881XRVaDBNV8l6mARcBq7MxcaE+E2whPObbV/r0+ZNvahtIUni8z?=
 =?us-ascii?Q?JAi1fOTz1uN2Q3BXwVVSrwQNg4S888XAg16QsqOxZzpdLRFJ3EVY02uWdqJg?=
 =?us-ascii?Q?IYqKef19R43bWe2lMltCmSyh8y6Hp6vqqx0c4lt5eU8ShYi7KYYJoD/DcwTN?=
 =?us-ascii?Q?G3xWnOPGJPBgUDQeeGfOnufi4MASEnYud+nJnQTyEH0tBVSXAq0DDreDqQ9P?=
 =?us-ascii?Q?DxFw1KAAyJPuds8pNNEcTnLn1g05QDP5CUMdKFS/tlsOr/8+ffLie8BWlYAa?=
 =?us-ascii?Q?fHhJ31vms7IM6UMW4TsdrCo7tJHRxFilpTbBp0pAMCuLunWs4+JrQ+oHAXap?=
 =?us-ascii?Q?EhsLM3PvWN3B+Vnu3ow+mKa70Ob0lSmR5ZhSKQjzUZIZtw1qP0xC1zjUag3D?=
 =?us-ascii?Q?HrStGemeb3UxQCTDqvmBsOebV8T/GJmHZdBbuqoISjXWqzHhwyZANhimiOul?=
 =?us-ascii?Q?mxH7cdMhoGIjATXgYuy07t+I7/f7KxsTD7wIap8xW9okubMj4Ft8sFZthBlX?=
 =?us-ascii?Q?joKeIHdqg9XhAdQxlp/ETA0E1tnWo5oR56bItBG84XaatLVCHq371uLZbTKR?=
 =?us-ascii?Q?AJPSsGEqbpZLhAkgFBDhEZi6e91AO6p9bGEfrKx3jGzJDc2yGH6+/5kiD6bp?=
 =?us-ascii?Q?s1sowcK5Az3Y6oASUnr8c9MAl+P2CO0Mo80v19Y5JHgMvMvMoOzIIFj49HE8?=
X-MS-Exchange-AntiSpam-MessageData-1: n8Y/hosDvSRH5LGpKivdJF0i4FjDkXJXg1M=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca71c76-d5db-4136-46a1-08de941ce996
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:41:43.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMRq4/m833x6X3Mt6j0Cn/5cGUXeqtB5MMn+cSlF71trjwhYPC04h4C451xPsQ2+XPwC/dj0LBCCRJRQrXPoMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275733-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7135E3A74CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the skb path issue explained in the previous change, ENETC
could end up transmitting short frames coming from XDP.

The way in which this could happen is a bit contrived, but it involves
XDP_REDIRECT from a veth interface pair.

As for enetc_xmit(), there are two separate limitations for the overall
FRM_LEN and for the head BUFF_LEN. For the head BUFF_LEN, we add a
direct restriction in enetc_xdp_xmit(), and for the overall FRM_LEN, we
introduce a xdp_frame_pad() best-effort generic helper which we call
from the same place.

This helper alters the frame, but that should be safe, because
ndo_xdp_xmit() is the hand-off function where the XDP frames become the
responsibility of the driver. AFAIU, struct xdp_frame doesn't have
multiple copies.

I say best-effort because xdp_frame_pad() can only expand the head
buffer of an XDP frame. It cannot expand the last fragment of a
multi-buffer XDP frame, because, unlike bpf_xdp_frags_increase_tail(),
it lacks access to the rxq->frag_size, aka the capacity of the chunk of
memory being pointed to by the fragment.

So, if the frame happens to be less than minimum Ethernet size, but
fragmented, callers of this function will have to drop it.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- handle multi-buffer frames instead of being unaware of their
  multi-buffer quality
- add separate restriction for BUFF_LEN
- increment drop counter
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 10 ++++++++-
 include/net/xdp.h                            | 23 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c70df45422e0..196b7828e2aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1816,9 +1816,17 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	prefetchw(ENETC_TXBD(*tx_ring, tx_ring->next_to_use));
 
 	for (k = 0; k < num_frames; k++) {
+		struct xdp_frame *xdpf = frames[k];
+
+		if (unlikely(xdp_frame_pad(xdpf) ||
+			     xdpf->len < ENETC_MIN_BUFF_SIZE)) {
+			tx_ring->stats.xdp_tx_drops++;
+			break;
+		}
+
 		xdp_tx_bd_cnt = enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,
 							       xdp_redirect_arr,
-							       frames[k]);
+							       xdpf);
 		if (unlikely(xdp_tx_bd_cnt < 0)) {
 			tx_ring->stats.xdp_tx_drops++;
 			break;
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..276afc9aa21d 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -477,6 +477,29 @@ xdp_get_frame_len(const struct xdp_frame *xdpf)
 	return len;
 }
 
+static inline int xdp_frame_pad(struct xdp_frame *xdpf)
+{
+	unsigned int total_len, pad;
+	void *sinfo;
+
+	total_len = xdp_get_frame_len(xdpf);
+	if (likely(total_len >= ETH_ZLEN))
+		return 0;
+
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		return -EOPNOTSUPP;
+
+	pad = ETH_ZLEN - total_len;
+	sinfo = xdp_get_shared_info_from_frame(xdpf);
+	if (unlikely(xdpf->data + xdpf->len + pad > sinfo))
+		return -ENOMEM;
+
+	memset(xdpf->data + xdpf->len, 0, pad);
+	xdpf->len += pad;
+
+	return 0;
+}
+
 int __xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
 		       struct net_device *dev, u32 queue_index,
 		       unsigned int napi_id, u32 frag_size);
-- 
2.43.0


