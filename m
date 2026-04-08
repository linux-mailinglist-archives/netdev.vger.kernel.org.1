Return-Path: <netdev+bounces-276281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN6DFiXj1Wm2+wcAu9opvQ
	(envelope-from <netdev+bounces-276281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:09:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D03B711F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F78F30091DE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 05:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F39355813;
	Wed,  8 Apr 2026 05:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JjUCzqU8"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D02749C1;
	Wed,  8 Apr 2026 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624992; cv=fail; b=tM2tSjTSjfnbCCrbACAKFEmXZ7YWjX+0oicqOiTgrjq5s9qav6YK8NxGex8jsDgljdvSD+/wKSYDh3898QpGCR+CCyQsbdNi+yTIwWCLgJNOcc7xb3P79dIOQINvvm0sQAU4DclFo5iGF4gOQgczJsbRWvd6c1x73NWbFogzMBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624992; c=relaxed/simple;
	bh=Ecsb78z4UeglqZTzZTaQwNiVNauLaoFIaWZ5dkibk6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExA6Aum4f7ncFF65bEnhY9p2aPQRO0CRiZANBvwAO+vlTZqxIEzHqPGtw+tg6MoLo3W27JP1TYFW8lFtiXVDd/L+Gsa3tFk/P2+nUY+1z9/p4mkI/MXGbwJdh/OM3CEFqdQ5xK9SIwLPLTtLDSNmu0CCGr8Vfdzic+SAcaBJtLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JjUCzqU8; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrbdsOpT64KCgQYBFgVLNK+vqXToWoRkagv+de5v3J9Bam3QUYLaNLF+OgxDNyDm71bFsY4iRy4NpATB/jdGhkJj2dI3bGTcevO1bAna+bX8dY4AVb1oVRgz3xRSO+MJ9MGfy+AiIHEMtmVeB0yNZbI8KAnR6z6NAIwil7DI2jKU7Lj7wTZ3t/9vSLqZd3JPwhosh54qhvnaVpIFxE3NWjqRbVejT5YLWA2Rpr93CE8etOHsC569TGb9MGV4P/MjMqyw8c9JkVBKowttgphFNjeXLKP89TpS+zoWEiwvTZ7sF6+cjRzQ1bTuVmf4WJ0G30E1Ec1labn0XE+/UJpWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mvKJ1KNv+RYA6dgfjtpUgXeewytWiKq4bntRiAMg/M=;
 b=G4NpaSICeNpRPzIy+KORhXb0tjBKcLi3cNGCghDTLJ9wU2Ms6MLdDXoVZnd6V23Od5sdUcP+gs4TFqOFXfQoyy/5amYnxSkyleVo3IeGV6sJOvDcHzCk1TPAW8E6LVsBzBZiYDbSXrkBk9kQMg92TFYRleJtYecJtz1yhpiK6fApOm+4uyV2g7fyrRJCZY4arsJcUQl8QDlPtCF8nQZ0dGVo/ZsNIMvu+gkAZ1KkiQxIuVDl/nW2VQWcCOPOD88NkxHTCKVQ7bd8Ie9FAfcu1h937S1hjC+TqZorNev3z5rE1a42IzSLhYVxTy4I1HN1LGDZLdKPkA0osJyMiGBNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mvKJ1KNv+RYA6dgfjtpUgXeewytWiKq4bntRiAMg/M=;
 b=JjUCzqU8U9zxmb60PoPNdjGqTq6sj9au+10jTJYBIGUeyea8DDPLmYt+63K3i9nfi7D7aKcPX4SmrHcfxYJA9kawwNHUxlNWu01rKEkZ2J5Y/Je3XcON/ypKOdgBoxPCpXJncrXT2P0kvTZ0ucM861bhVJ13k+5ii8xlFL6doHvJuxNSTIRIW6hzJMYJnHCvMUt4XHGDHkOLa1D98BYIn+Y7sw+XOzyv17MKXKAqz8t9tMRUAfQ+NdvvXZAjqN8sHI+cc0HbZmpp9P/NQklQ/sXA0ZIlBKt0V1HO1k6ejyqhHAxUS3GIz9Gnpg5dqNTle2uYJbIU4lqC3Vg9ZBuTGg==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 05:09:47 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 05:09:47 +0000
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
Subject: RE: [PATCH v2 net 4/6] net: enetc: fix bogus TX ring consumer index
 after reinitialization
Thread-Topic: [PATCH v2 net 4/6] net: enetc: fix bogus TX ring consumer index
 after reinitialization
Thread-Index: AQHcxgXFnaV/w4LNBkWCQNqy1NFfLrXUn32Q
Date: Wed, 8 Apr 2026 05:09:46 +0000
Message-ID:
 <AM8PR04MB7284727CA12DEAA6587A70E6885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
 <20260406204122.167237-5-vladimir.oltean@nxp.com>
In-Reply-To: <20260406204122.167237-5-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|DU2PR04MB8759:EE_
x-ms-office365-filtering-correlation-id: 638eecaf-059c-46ef-611f-08de952d0dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 dBRxtmO7mxWp/XWVq6Vfc6dsn5Kn2aIaGjKqiO0nDpbmOOF96hEPGKrKUmy5c7R/sbsu3AtIloUofL0jZWQXsvIcRqMaTklqo8y9Jd8ulqKNpS4M1PO3sDYh1595zRga5nsjy1bv0pQ++XNG+i7miFRXx4KeQirluxQ6tP1Ng0Hp8t+kWwLQjFAIAcguaQ7hZak/2QIuQa/MEzykwvpieBQ7egiT6nrE+lHhy5AhrAMhE8ZdEvUTbnwpFyGeBr+BopaJDto4YpUHkdKP/vn9R3gt9bDw/pERkI98GopJt6+K/jqcDOtE37gLBHyQv+H4nkVyem5hGMWN86GhueZ8/Q9m+fE/SqnkrD07gdGeBXyJaZH8uxnysnZEyI0+NqwNAoff0Rrbx2MwSp5LhFIxKjtGSZBzSQ5oBYgR0XET7YGDqxi6WNAd1Xbid385oINiQFFs0Tjlv0+FA4aLpSyHq19YhyKFIbXZoXoL2LnJnf0v1ngOgwNSRqGgyJnyPNGwjZOs/mjYVLS/mxL8IUXnrtSp2so47Lls89z8ddn9R8LMYWZ8QV8hLihioAfb3rofHTO3/U5FQiHG3S+BgKeZRMDke/G9y5vdpZIvi061SM8IqUIRlHj7imXzKGbZVEQe0Apx+Iioa4hkyFUzcWOLW2RVqSt91suFap/Zi3cBhvcRLC4CGqBIltS92e2CbIoDqpjxt0FVXxlFrZlrP/ExxsKdNrDj2yScmnRcQByWa/qbPN4VTkOWCU7oMkwoFpJ+58ayZJ4a96KBJKeT0Xik6coDqCszldsSk+UD6XtCfPA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JvymcrThtwQaR2PnbwO0YCwJnScDd9we99/XlL4ct6xIY+2GKwryRErijTSc?=
 =?us-ascii?Q?yk+uUtDbVagr8EA4nHO/H+hz+moFzGapxLjYoMKjJIAXP/7DV5d+FW1x90cf?=
 =?us-ascii?Q?7zCN0Q3E4kADxjZL/AyN6QmsEUA09zXVacaon/mpnk06Rkxms40LPY/+x4lc?=
 =?us-ascii?Q?J6q8lD3lx8QXpM4u6cSOI55Faelb3OMlGTQ0EZyJd0QhaSIVX8Ptly2zmLhQ?=
 =?us-ascii?Q?kGHb9cPJyK9sJoZat55lhdgMhu1iSYn52CwJcEaGfDkM3Blfg6KrzIEs7HLu?=
 =?us-ascii?Q?ZVLwcMEZy1NulLhZnLnLhRLl7v3DJiIQkPzBfuk2dHYqzDmXKpDlCTjAZFye?=
 =?us-ascii?Q?Hj988dmmO968mN1Ks++4jvP+Bh6JOhywjymRjckVM1M0aTXbFarJk/Do1gtJ?=
 =?us-ascii?Q?qvpuJonZLeyte6smUXel6xcAV3IeiuseUgKD0B5ZqvXBmtRlAy7CCiHSa2By?=
 =?us-ascii?Q?kQKwxoXmvbJpESbLM9Jw4W43U14yAnf7Ph5XxjnXmLWEUuDCKOdRtZrWUkrn?=
 =?us-ascii?Q?50cNF0JKrY4U57/7jAlXeROlF6NSzS9AA1HrcSJW2bvCmZynPiQ3z4LXkmBD?=
 =?us-ascii?Q?mdWbhBuwuLPh4VvNkYmkz1FlBLYKefjluyBbMXdiDROIf9+gUcMmvYyOzQii?=
 =?us-ascii?Q?nUnMoIn5TaajoCgRN475yC98ChmLfW977mEajyrzBTH+dMJSqgtGsI5tc5Dp?=
 =?us-ascii?Q?HPcvyLF29Bb+c79q+eKGXr9Wa1tKyciv8nD0S1Lf/V6OVEWEYfjsPtNWAdii?=
 =?us-ascii?Q?buUTnvtsB2WVDukiG8Kjs1GN1f/3AV+wixkVEo+NuscbvsCJ/B41+sABaX1/?=
 =?us-ascii?Q?gcRau1gIcOPlXz/bkSzO5b3Cyz2GixOBL9UxD9AxyaLFx/eOcitA44eDckk2?=
 =?us-ascii?Q?a0cHIlL78/lJeEUgaTqbWIW/fLYTF6u39/UOtS29Kkb4gxztrIsFsPPnaE2i?=
 =?us-ascii?Q?p7tghj1VkvMNW9ZcYzoYl3mB27Lemxco5wnR9oM4hFZbwlbUBB8iPkdXR4YQ?=
 =?us-ascii?Q?XoA4G8R2pEzWHchNUZubWgYWsnP5UiXlBJ89teYKBqNpo5QokfPjBDM/w+Eb?=
 =?us-ascii?Q?OdSBvBIGD2fjIp6XBjysK4usXqLuQm8V+GGFOA7BnNj3dMsl5wf81DBWx3S/?=
 =?us-ascii?Q?oKTEl1XmHJz/wXHTpySdioBHExH3+bEgBZrPAKpxMXs35al1Ocitbr5k68pt?=
 =?us-ascii?Q?fyp2bKWkcehxBDNIbDSSI0i/jqVH/WmMrqphEEa8i4vXM+7OtDIBtim+w9rd?=
 =?us-ascii?Q?1AVdAUjJbSZQv73Bv4a7Dsxy802nsfqa3WKWa82f5L4R+GENcbQ7FDFyxOjI?=
 =?us-ascii?Q?b4EolBgw5s0AMbwHyQH0C7JmNvpJYi+qZ7EfvSIN8Jmoo/zs3stnj3C3/GAf?=
 =?us-ascii?Q?O0HBi0/k28UZ6xh/DqRgTQm8cYP4+cf2QlabZFsl7n0AJRl3jurjHHfPrQuQ?=
 =?us-ascii?Q?CplGaNJVw5YKcJXcqAzWoegd01M+TITaowiPmW7+R07nhue1kbN8kyaFE1OG?=
 =?us-ascii?Q?vJz7KY9IYKKty959rxUAPAvPCWd0hCHsJ+vslns6lu1dPmokr3S6muj69fyi?=
 =?us-ascii?Q?8sqfreqLub1QpeQthc4Tbb5WA+UHXh7o0VqjIG1K3MJ+IqeprBdeVaLPmM73?=
 =?us-ascii?Q?l0QsvD4zwOe5vv4TtmmfeBgvMRyUquiq22Tg4PA/ZgQ2E7G4j9ktbJQXVaOC?=
 =?us-ascii?Q?qaYGqFK5xXBkW/7ZlJ4Vij5Cp9IXnBiwjOvpxfxpKpMsUAql?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 638eecaf-059c-46ef-611f-08de952d0dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 05:09:46.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7+URCzVYTZh3qP4FcefGy7GKJh+cb0o9QrJvz6tUnMJ9haLKwdyzsJ7SXvdCrhDjtFrOeqmmkUlSfc0xy9Z6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276281-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,AM8PR04MB7284.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 626D03B711F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The TBCIR (Transmit Buffer Descriptor Ring Consumer Index) register has
> the BD index as the lower 16 bits, but the upper 16 bits contain this
> field:
>=20
>   STAT_ID: Status identifier. Incremented each time the BDR_INDEX is
>   updated and an error status bit was set for one of the processed BDs.
>   Clears on read.
>=20
> If there was any transmit error prior to the ring reinitialization and
> this is the first time we re-read the TBCIR register, reading it will
> give us a value with non-zero upper bits, which is saved in
> bdr->next_to_clean.
>=20
> If subsequently NAPI gets invoked and enetc_clean_tx_ring() runs, this
> will dereference the &tx_ring->tx_swbd[] for the bogus (and huge)
> next_to_clean index, and will result in an out-of-bounds memory access.
>=20
> Other places like enetc_bd_ready_count() do mask out the upper bits, so
> let's do that here as well.
>=20
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> drivers")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: none
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 5b97f9e668ba..a48ee3040b80 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2604,7 +2604,8 @@ static void enetc_setup_txbdr(struct enetc_hw *hw,
> struct enetc_bdr *tx_ring)
>  	 * adjust sw indexes
>  	 */
>  	tx_ring->next_to_use =3D enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
> -	tx_ring->next_to_clean =3D enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
> +	tx_ring->next_to_clean =3D enetc_txbdr_rd(hw, idx, ENETC_TBCIR) &
> +				 ENETC_TBCIR_IDX_MASK;
>=20
>  	if (tx_ring->next_to_use !=3D tx_ring->next_to_clean &&
>  	    !is_enetc_rev1(si)) {
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>


