Return-Path: <netdev+bounces-286420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bz4H5Q8AWqcSQEAu9opvQ
	(envelope-from <netdev+bounces-286420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:19:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD7150724D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E48300A612
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF8221721;
	Mon, 11 May 2026 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="arUDNF94"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2944503B;
	Mon, 11 May 2026 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778465937; cv=fail; b=FMKF/7Al68mpANh+lj3jgoaznu4srJVf1pAYlYx/JyKoJ+z9eu5edYqrFJ8MosRW3aTdFHEROFFf+sxaBeFOaToTgVWJwc2RUo6n4+sghz0Fj+DkDY93oBM1hvVjKsJHBJEanYW7KfMS43uJRJrVlXeJvlKfCtZxkHidTmLbzaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778465937; c=relaxed/simple;
	bh=oel5h/QqEQ7roEtzj8EaTK9IDWqMv+rz27ReJ3mGnpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dolOD0w8bas96Z1FQ/fz7L4nhu8hHbshgXtnZlBk3ZTqb5id5vP+FJdw4ZCM16lntUCMmcD8nsBtLa+lyGfxugpo4vvFIBIAYGDqTJMV8cTHKT5WpK4ocmGr2bFUnKAdVrfFhsU5Xd7Yirief7BPsR4jN+BINDTr6dA8qsQxAMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=arUDNF94; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBnc0H+6mVL+o80KN2+GNwcxjHviyNKnsKMFjYA+/ENEkA9BtDQdzuz2yUMwRIl4nRjzO3Zp1pPmlO/CekKqkCKw5Bw6oI0FxFIqi+zOJJ/81JesVprD+fYStGsII/D617sXhEXI1WKT3fZxFV+D9AtalguN54qChTZEdwEzzNr5vyvUo5z9BwIXoQRAI1pPy6cDLN5hYs8VPBp3sl0PpT+wGg8Mz2d6/KRq2/WJ8LJuAwVq65soF6Aa4/wG5RiZO8C4Rn03Wk/rBuGOzfwTdXh0tUSVkCAJQCfAslTlU3YdWZ6f3J/fZSOEOgnGPkkzMZPOQ4I8Kv3KV0UC6QyF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZyjBTNg8m7QcFB7lLH1gBqxvzBw1msLjrDH/y1/nnY=;
 b=cFjOwjZoqfAIY39G0cblPh4KDU9VvcN1J+R9iDtEIMLubyT72qd/39GV8MjlzaVpgqiYQ3xYAGYBXZw8Fz9HeqmQg8wnXlK/371evDEF2DjpjNeSGX3tIQm4NZE+uqcF4RzSQnbnExUEo7uDW17/FnacQBlMOREjYLLj+Cps1GlYk1X0ylOzCVYiHDLVjCHyq6dsIt0iTuUYvaoGKZmZ1/m2k5vo39tYpM08G+UXvd+fAcqOLT6fDv8XC15giVxPcIQEr+MsLHsXbJJOr74fnwDjK+E7STbqXL3L0H46LSAYhAYvRCdI9uI415fXjoubDpZvFt7coh/9pq34/6QTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZyjBTNg8m7QcFB7lLH1gBqxvzBw1msLjrDH/y1/nnY=;
 b=arUDNF94gsivGE6rUJ0HCJjiywZaCQj+X7X614+oyTZuYXJuECbw/XXhm3rW5bjmmwWzQeVzLt+zjg23o1ulq2JIPVGG82jOCTbHoEhXMW4Sr6snKXRYQ1iKEcBIITzWt+XPDvD1YYQgK5SxjUDbG40+v4n68ksa4j8ZKOa58wwL/e+l5Xb770CzrOLHr6DB1xEQNXivwwvNs32wDgRmnWssFeVpHw0tQW4nhSfvttHVWW28fXKIeWcdmJCiZdN9t1+N4gL0CO0Zw3BsPG7BV27Q0uVAWYyDatnazR9GuSgJ8z6h3snZuxKr6SbEKx2hAAPFdjLb5S9HaEqcVQe8bQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 02:18:52 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 02:18:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, Networking
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 09/15] net: dsa: add NETC switch tag support
Thread-Topic: [PATCH v6 net-next 09/15] net: dsa: add NETC switch tag support
Thread-Index: AQHc356cM426CfdqcE+1X0sVkdvZF7YHFdyAgAEDz9A=
Date: Mon, 11 May 2026 02:18:52 +0000
Message-ID:
 <DBBPR04MB75003719269D7D7DE01A923688382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-10-wei.fang@nxp.com>
 <20260510104835.E0009C2BCB8@smtp.kernel.org>
In-Reply-To: <20260510104835.E0009C2BCB8@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS4PR04MB9574:EE_
x-ms-office365-filtering-correlation-id: f2083761-0497-4267-295d-08deaf03a511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ZM7jUZ5FXPwl1JMzeAEcwZjXq849EUsyyJ9abyWlcBldmiDj84K6Vkb4e2B+Z/9Q/KSYiuAvrIsPvf72iawpuffEj1rixOfBn0rOX78AjMVZa7sb34vd5DbEFbDvBNvlTBJ3a8VLRF3DhTki4IJWTRsZEPLROF2iLjOD9PlrG03VuqU2YQGFLRFigS85THZ+r+OkuTsGCnZR0SHZK5wKlcQJSq5K32wNN6yQ6/KWlS8bjBmYomWVOfSluQvvfTullJJnbxFkjjOBSWR94iN8XDlEV4RCeNtACdKyR/mjzM7XadrBk9/uDNO5JQqpMaCSM/tr+RHZJq89Rz6d10lTiBfOAPZ9v3cILefil7Oi6mI5OQgPciu1lmKUecYXAlqXiyEK+t8812lhPK3lcE7yQbnckuOvkKYQZqqGcu39lp55pHyxL0nZQjERgJYAyie1mXY8NZ9GfgBpZnHc2DqyllhO/93jXvk3eCnAo3hJKtJslzbcBVFV2Nab3r2OMqFD+yKfE8I670mUV4AoOu9qArUzJVN7d8jZRLi/Sgxu8aclgO1pHAuSHbgqXbQjqoFwz3rS8+HiEvDj30U+dpVZhLMmGPTiUiSgUGrckbyNfyC28eH6b46OHvv6wcFkoktyr6XnTkLx3x06nc4efrhzypquzDbpWKlcfVdrZOGj/oE9c6Vbs6Pw1Y1TcMO5inSJ1yC4N+IYP8A8zpsP0pFQwONpaFC2oGrO0H9IN+iGk/CEiUVEjF/gJBwgfKlYkcyf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yZJxODlzgwzh4roQ4ObGe+1QUux7tVkUD9yQuJsUnEuxqMqHar6u1tyiXf9N?=
 =?us-ascii?Q?AJBNh8mZTKu7S/yMFn5Mw6/ym6n4e6RaxZKnzl1m4e3E/iR7DZLQJjnTF63g?=
 =?us-ascii?Q?cbw+e3sDQs0U7Lzul/bc8MVl7qC9AuC0EaBJdb+iHxXVoPVQp9rFJg1gVF43?=
 =?us-ascii?Q?4ROnSvNEIFJN6sgdBg6t0DutVfETWIKs8OiGkNV2dtHneQkLRXIR00xbg4n+?=
 =?us-ascii?Q?wGvwhO/g1vD9VX6cMBfIu5UpI4xAwRV2GYW3xaxG8y73EMw41sNPQwzwlUmm?=
 =?us-ascii?Q?7SG0xKxr4/zOlh3JH2EyCkrPdxcLxrZVoIXO0os/6n0Yf9WRvhy9oWw4Zjr3?=
 =?us-ascii?Q?Vwfsi2ftC5/UA9s1+mCnvnU9lrpZgc44kTrlFAXVLL4lU6d6ceK9JEeJDpC/?=
 =?us-ascii?Q?RaJK9peVWmr3iAJHj44VoJxrCEU+mLruaCsEgBuh6oWHUNShPGOwX3XY8JFz?=
 =?us-ascii?Q?7XTuYlKqA65YXWeDjekfiRM9OgYeFNI3KgknpRY1ADLtlKinzmhF4U5o+HwH?=
 =?us-ascii?Q?JAwsqCqA255eVJDjk2rWCOkGtxK7IpC02B9y8MosbI+BnZcRQajEMFDcF2gt?=
 =?us-ascii?Q?W41LWm2TLyhcKiBLJskGuSQyZUyns+0umrKR1qVopcTAZBuqhNuesQKx6iLl?=
 =?us-ascii?Q?17+nMDPcputrOIjAqXaWtUHHOjEOV+tMkLzbRujXnCw/iOYXtC0WqYTYrXp0?=
 =?us-ascii?Q?PmZUYy2CZRApDnsIxA5xg4Ln8PexGG7NV6vTpzY2osGJiXASyvI8drc4wxar?=
 =?us-ascii?Q?hOq00Iq7R7S1EoZWFG8o1FRrvzTpJIZe//lVXMuzTKfvOLVihYKr+SDK2fZa?=
 =?us-ascii?Q?qHN6CvrkQZ14CJdSw5nNVoFlDS48QdYUv9peB4k3FcAlhPWACr11ikdkh0/3?=
 =?us-ascii?Q?CahSExqwYA95ZZISCrk+fvrNgnDlzdCHJ2hE9AAP9uEMXXPpR1Qgo+KB+tdf?=
 =?us-ascii?Q?0YlVB3LCEuguyli4KMS4eDE1VtcY0OmngzN7vyaMaMBB5TflO4JLbqhcwTs+?=
 =?us-ascii?Q?6QYIranvYe3NLs+0qqIuyOT6nVgrbXYIldUYtN9CaXBgI1c/A3jpSRj2+Wbc?=
 =?us-ascii?Q?PfhrnPc1EtmkN+IJfBM+LtZzx2Tfsj1Jkt8SIE+2FAvDXUH/zNTIF6EC/tUt?=
 =?us-ascii?Q?MaB0OyJ4Z9wLs+fehVRU46nSsO4YbGXQFV7mH8WZAALSCB56E0gGT1yTI23W?=
 =?us-ascii?Q?Gd2oBRbDRZjGTxiwgsdA/lPhWynOHkp3puDR83j2mtQiARU0K3Ewx49RxPkQ?=
 =?us-ascii?Q?zFtCLn/dl2TUNWVDmcDwk9OyfyzYbNET9arPvWhy4hjRIb6Dxzt13BdujvhN?=
 =?us-ascii?Q?WF4KKEaEHpjNGojImnC3mNFgoFy6dcjWSC+AntRePoH2LAWXyBa9aw7pPink?=
 =?us-ascii?Q?jBf568QUWwAxgFieJpQ7rgYMkwv2okpShdB77fhI6n+mgbN8sMIRUZdh+C2T?=
 =?us-ascii?Q?L5O1tZYACSuKCv/9PoSD5S4sCOE0O/wZcNahIXR/2tt6Vcu8w7JNNxcvNUDX?=
 =?us-ascii?Q?+HIiYIDdhzj0vcgQmT5HEhG6AaDegR05ivZg+hOiUv54dnJbUL74gG6vIOQM?=
 =?us-ascii?Q?BUohsbXCpeP2YFLrTXq9MCIL5bROCTZCjdlbrUVUpxUFPnODgnZhsHKC4lQ4?=
 =?us-ascii?Q?juDd7hg/nO+bQWGd1pbD8PzFrBnSRjN6c3yvV1F9/CsqOTJl5qFCPv6n6Rdc?=
 =?us-ascii?Q?y/lZXJIH5NUmHW2vYHSAGJRm7c6bTU0cSXz+fu7OoxaL48G4?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2083761-0497-4267-295d-08deaf03a511
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 02:18:52.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6ZoCl/4m++qQzExC31h0QzQI6m5voDziiqgZxQRs/9GAaBrqMA9DrjHeW7KVvSgG6Bpq7pH2xasvqAtqIWtBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
X-Rspamd-Queue-Id: 2AD7150724D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

> commit 497c9819ff3bedb82e4e40b92e407f5f3d81f984
> Author: Wei Fang <wei.fang@nxp.com>
>=20
> net: dsa: add NETC switch tag support
>=20
> This commit adds support for the NXP NETC proprietary switch tag to the D=
SA
> subsystem. It defines the NETC tag formats and implements the transmit,
> receive, and flow dissection operations for the new tag protocol.
>=20
> > diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c new file mode
> > 100644 index 0000000000000..b29aa54b19881
> > --- /dev/null
> > +++ b/net/dsa/tag_netc.c
>=20
> [ ... ]
>=20
> > +static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto=
,
> > +			      int *offset)
> > +{
> > +	struct netc_tag_cmn *tag_cmn =3D (struct netc_tag_cmn *)(skb->data - =
2);
> > +	int tag_len =3D netc_get_rx_tag_len(tag_cmn->type);
> > +
> > +	*offset =3D tag_len;
> > +	*proto =3D ((__be16 *)skb->data)[(tag_len / 2) - 1];
>=20
> Is it possible for the packet headers to span paged fragments when this i=
s
> called?
>=20
> Since flow_dissect takes a const struct sk_buff pointer and can be invoke=
d
> on untrusted or non-linear SKBs (for example, those injected via AF_PACKE=
T
> on the egress path), the linear portion of the buffer might be smaller
> than the expected tag length.
>=20
> If tag_len reaches up to 14 bytes, these direct accesses to skb->data
> could read past the linear boundary and trigger a page fault or read
> uninitialized memory.
>=20
> Would it be safer to use skb_header_pointer() here to reliably extract th=
e
> tag and protocol fields instead of relying on direct pointer arithmetic?
>=20

This is a false positive, or at least it can be ignored. The RX minimum fra=
me
length of each NETC switch port is set to 64 bytes. The frame will be recei=
ved
by the ENETC driver. From the hardware perspective, each RX BD receive
buffer is at least 128 bytes, so the skb's linear buffer will definitely co=
ntain
the switch tag.


