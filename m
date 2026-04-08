Return-Path: <netdev+bounces-276279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDs9Dh3d1WkW+wcAu9opvQ
	(envelope-from <netdev+bounces-276279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 06:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9443B6E18
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 06:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DD643014C16
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 04:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AA34F48F;
	Wed,  8 Apr 2026 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BZ1mHj9N"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACC2BAF7;
	Wed,  8 Apr 2026 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623446; cv=fail; b=rR5ZKKhDZ12FgOxli+qStYuvDCVyr6f4Z+9tPhWe7D3gx9dHSmRjZnIS2smqmEN9+/VzqkmylnpvDNJ9GnehpEjJwdeYzk0EIDhF94+VPleTFrEO+KNzFDUq4uRvNqaIs/bmal+oGVlzM3LF/g8LDXhDn+q/1pMh9kI5lPBq2Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623446; c=relaxed/simple;
	bh=4mjreigLTtMVfACvZO5eIB7KrUErUy5ZurJYNKmYgbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nDrYntMhk+a+5aokQSK3xDUnv0DeS2nHph2t1d9D2R+3HfAqzuGjhfukN8Il7ZAymXjiLOiRoZOWfdzcQnhMRM84MouSmAmb/oibr/QefLDc/sP3q9Pup5kZ9Qu4iGXDAAmLhfMpa6zeviz8ta+bgWphXbmpUDkx6fD8a0fkN6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BZ1mHj9N; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU/20cnkOsFDDZxZdioMgPclDUAvPqhQpPvGq67Dai7Pm+PaDcKBbS07LxiEzsm6jHSTD6tRuoJeu2gzcvDX+tArrwR6B+LP3QXRkZZGgpzdI3xXB5QFppMB8vmXzEJxaCtNqHa7pD5E9Hb7i9ll4fpbHiyBoRAtjQ7y3kJTYY9l7BxfWgzxd+ViCdu5t878jT/vxR8mGa5YokAcUZIDKUSvg+lN4YOe/5x5gADBG7uTgT6XUzgaZdTjnGTlADmkkmygNpgASUzUTtoixFFbeTz2zHsuR+2BL0QyK7uhjaJyDSKxLgGKiaEwH5rGTHeZ4fFDwkugW6ME9wF6H/9VJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjNd1YLT7Kes2ggLqiTLPAvMel4rt6qXOohS2//Rm34=;
 b=xNWc2qlCiWKZioiNvsVEm5fh7JivIqclVVr8rxN0CAmfFyWmgHyub9gNKKZHZlsbrHImvRoI5SPFvBKxfkrzPh9OlZ+Ib9PEd/Hyu4fsPuuYePHOvx3wE5O1B0/9t60GbGTryr8lWCYOKDqZhw07gshXP6pCbKFMIJQeUlvrJhXXe1/DQzgfDXBINXjhx7m4FTMb3dJtqBDCD7Suh5JRj59RbJoWQiFbKsMWgvGZwML6cOBAyUxMTWR4BtLWyEDlopTffoTTg6UC3bQBKBriN5lZ1GHL468PmZOQIE9JcU+8D+FezBz3B3c6U9MxKHsGR42jZHmlJRYsR0xXsMXK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjNd1YLT7Kes2ggLqiTLPAvMel4rt6qXOohS2//Rm34=;
 b=BZ1mHj9NlF4/Lh9ilpXWxpeVb4jDmNO8riCHEQk1I5dc3A16rM/HqG/Utz126ppKfO6lqIvPHyXEQJQeeD1xYJWxGjOCpjSs1cpD8JWN+wUWE/mxgQskVBc+SQxO701tK527RF2A5kTaJFBVJBKbJHBt6DH1CNDAbS8NQF49HLZ0ohBhXXXVSdVv4iisygj4EL9O5dQEQSpsLdEt16Jbace1jFE76v5hjMajFp8DjibexLXqJv0FF1JuDt2dzWhBCKKIkFuK3mHgm8+oWdHLo6zTI0iQNqylEjlHJ0ox01jhYsMXXW1NgSfsojG45dTZ6nGIgoEf6yHX1XRNvovRSg==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 04:44:01 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 04:44:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Zefir Kurtisi <zefir.kurtisi@westermo.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net 2/6] net: enetc: linearize PTP event packets with
 one-step TX timestamping
Thread-Topic: [PATCH v2 net 2/6] net: enetc: linearize PTP event packets with
 one-step TX timestamping
Thread-Index: AQHcxgXDfkmmu1nzLEaLzgxbmswkm7XUhM6g
Date: Wed, 8 Apr 2026 04:44:01 +0000
Message-ID:
 <AM8PR04MB7284A378E8FD79C53E77B0C1885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
 <20260406204122.167237-3-vladimir.oltean@nxp.com>
In-Reply-To: <20260406204122.167237-3-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|DU2PR04MB9212:EE_
x-ms-office365-filtering-correlation-id: 625d27ad-1625-4a15-d1ac-08de952974c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 kbdWSnaF6U1X8Ne0kxmfIv0tzu/T++OT7JPb2TGR6S2zGYs50NjpSfHsbNl83lRyLtvsXDcok4YcKHUyM93x1q5v/SwVaDL75jiyQYNd0Ydl0R6giZCO9W/pG/SiZdb76Cz44uH4i0tooADjLnnVLIANtP9tvBbr/WDeVw7+vAhBcPt1F/NJ+wBwkrTItBwbupvjGR+WR97rblcyN75bQdRUQ/atxLjZpjJfgJMzT+l0NC5Te9nsCIOt/5M7scdDAvFueMstEKTR/c1pxMsHKznNFm4qRGD8Ecufy7Gpkj9mZaXaZU7snai2E3BU15zFPftbkI2pgSnqw6pVdJeYw5cTSj2FGJc2Opd44vP8HOawjcniqgO8TqDEGJGMnoyotlb9J90HF3zcW3dG6daoE0l6qP1e+/wc8xENtX/WbEygVjf8H9+MfEZT09lnIqoWCa/MvJliKCYZHCWWYEPvULC8jJTl0q8WjU75VtGs9Dq5wla7peEVfJIbYCJURynYs0H3X1kQh/AJDtgLudR2fFN9lwfGBc284F5/lh+CP9NAw9AywNzwJa0Yx4DNRBFHGTxzMdONF0HqL2fJlFRYwBV4BLsLzpW5jAycv0be1k2Pa/OraDRgkqqyvm7UttHVlJLG3KoFWm6M5f3C/LYRk89pDBiti4Y0namT+E8rRUjVZpSqhNNMJRsIHH9hGr1YL85Px1r2EBy+2rcSU6T+w+MJvGOTXR4OP7x+6NVwGDBPS8vjpnUoxN+HevEVuVAA9UaWT3Tq/C8gEG7GFNQHuPt74pU7el0Y+tEIfQv4BDk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O0ytI7AZyrciu6CMm0DlP4aJJVDk/erFrBPNxsIhCMciyK22qwMh2+NODV4+?=
 =?us-ascii?Q?VDPFM0QHAp9a5DYYm5yZ6otCQtHN2hqowwsOMDXdfuCtipM7zK0rlR6+VkxX?=
 =?us-ascii?Q?q6NIUkqrKs4ZZ1TEBXZ8/rTu+tgD//k6qSOEly2x6lrEEShpuHEfjDSQP7qQ?=
 =?us-ascii?Q?XzrTZyRM8wZTuOKQ4sr/KXe8SzRCKqDJF7iqojlO0j4oHnYGyc6lHoFcXVGM?=
 =?us-ascii?Q?d3gLQVzl+BEEZLhCw+34sarP/h3FJBRchMnAt2o86eHEWNYZ0RU/3bn5iE5S?=
 =?us-ascii?Q?6/RfrmEl7Dqyn3GUJwR2AnG43Ae26CzHubFSPz4uN0Dbo4yy/sH6clwLAncC?=
 =?us-ascii?Q?Dt5K2wTQSM82cPy/WitpMSzk0o8XMLGl6HDjfd5RuzNMepo8izqihnOM3/bT?=
 =?us-ascii?Q?Srj/A9RdqvNAE1CD+RFQ+FnankH0HmZ+JdJxnMOi23r5c0zHs53LF2dXizX5?=
 =?us-ascii?Q?IUoqH04TNLWUaIvrBxZWFetbbUp4kpm3LtRT3P5Ylq274mTIS3mP+O9AFFht?=
 =?us-ascii?Q?HLvjPqnT8TP0CX8HgtyBHX6HVTCcQY4oZqDNW+t2mutDic3dZzaVaJmE+Lrb?=
 =?us-ascii?Q?BBAPGVOI2Q/7c0J8+0CUr5tOyHgPETsgWRY/44KY+SqcQayDHNX9Vt8ctGEk?=
 =?us-ascii?Q?j93st4blaNV+eeN0d4lTRtSS6VdmOqu9cB9ulyGSobtgc1ZbvzmIBkpLyxIS?=
 =?us-ascii?Q?5x7qvzk4vD9rNj2iURfWHLWz7/zMCRoFAHqGNF2G5Lj2gcwglkkpGftqS8RZ?=
 =?us-ascii?Q?wM6+OuwwRN+RKTyoMvHu8HEM1C9P48Qrr2SSAXiO8QPVAyOGZ5YCaoZAMseZ?=
 =?us-ascii?Q?bMgkNuYDiviFeK0T/qIhvpjXJINvT6R9HjXBTm5m7FcvrKAIy1ZU5xMTQPcf?=
 =?us-ascii?Q?Cig7F5OkrHhrOXbjLKJWLUOvPrmK1AMQfXBZckLcs4kSA7SoQKYwZZr5cwX+?=
 =?us-ascii?Q?1MZQKXz++GgPpyTi7oxmwHce8LzOhN2vOGpNCRWS4QFrbNlxJJSs3A1lUbA2?=
 =?us-ascii?Q?Y07xZ8gNZBihwmGR5IC2HrxykdPmh7CHtEHJqVeMopKGynEVzCS6/kv5ec+1?=
 =?us-ascii?Q?5R7IILcZ+IlonU6rAaIdP5UaErBxAalPHIk0JTkuX+DPu57exyTNOEEXlX5M?=
 =?us-ascii?Q?ikk5Kx6AbtMHX1pOAevUkVFoNtYVFS04cYBqUCIV8G/SsoiNFoMxJHWSygji?=
 =?us-ascii?Q?SYMRZt6F+soyf2JfB08++SJte2brauREpfo4MVtRuK91TUHq2FYOIT5cJgpU?=
 =?us-ascii?Q?u5Gf2s7++G5A9NHecziBQhDJvLT5z6c8GLZ37QaSHIOBCrby1bsKIrBx5PRW?=
 =?us-ascii?Q?IFnZ0U4SFdlEqxcqGuOgTL6nHy7+iGEj61pBCVKr/iPHdp/mx4Y/nVqIE99k?=
 =?us-ascii?Q?obrtDJOIKmfu0pbcP/ku7aUD0swtPKkwaUsF3WiCe9tAsNy48XKl32ewzgS/?=
 =?us-ascii?Q?bqAPDiLFxXauECwZPXJjsvqsrRzSOiN9VrzWjp7a8MABnAROZjfi72CPZSfZ?=
 =?us-ascii?Q?raoRBAOg4Q03KiFlqoVAlaHnvWjfqfVwG2PfpcH6WtjSHLkfgcEqTyCNAsOg?=
 =?us-ascii?Q?ZtgVXL9CJVzm9SxJMN4+FEgC26Bbv/NnWqoNGikXbI+H2oAMRva89PWPrXb4?=
 =?us-ascii?Q?2qfZb7S7tAIVWW4eyq3Gcnrfj+nHkBbXQbQz9RUdAit3nIYw5gxn9wvx5aGg?=
 =?us-ascii?Q?SGCT9sbDT+Ugqk7qPSs0iKEpRtnEkbAThTubgOtaz5JDDMr5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625d27ad-1625-4a15-d1ac-08de952974c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 04:44:01.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ajNQQSR+WPzqU/jbE6c9tNGSaSGqkgyTRlMgg+2ULq4a6z7wetqPdU9pA6SMcukns8jejYHO3QBi2zPQ6FEWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276279-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: AE9443B6E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Sashiko reports that enetc_ptp_parse() uses ptp_parse_header(), which
> does not handle fragmented headers, and expects the entire area between
> skb_mac_header() and the end of the PTP header to be linear.

I think we should correct the check in ptp_parse_header().

@@ -130,7 +130,7 @@ struct ptp_header *ptp_parse_header(struct sk_buff *skb=
, unsigned int type)
        ptr +=3D ETH_HLEN;

        /* Ensure that the entire header is present in this packet. */
-       if (ptr + sizeof(struct ptp_header) > skb->data + skb->len)
+       if (ptr + sizeof(struct ptp_header) > skb->data + skb_headlen(skb))
                return NULL;

