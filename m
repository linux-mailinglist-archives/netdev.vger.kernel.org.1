Return-Path: <netdev+bounces-279616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG+sImOF5WmDkwEAu9opvQ
	(envelope-from <netdev+bounces-279616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:46:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F204260B8
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 609853003807
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 01:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125E375ADC;
	Mon, 20 Apr 2026 01:46:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D281C28E;
	Mon, 20 Apr 2026 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776649564; cv=fail; b=OmsN1Rv9syEv9Vg0tMmlg/agUy2CTYQUme9ijBwwsqpX5X6kFdFjmch16ofdG6JHFKl70ptip85ul+1sJPlwgSVOuoDZ5Nqt9oF4sy8anFeMqOwPYdYja+3EDJDfdCbgYDW6v3KDfQtuCDEUykGhyvFIdTf9Nb3I+Y+5KQe24JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776649564; c=relaxed/simple;
	bh=X8SL6Qwd1oeEQ6OyWzOfVQ1YDduP4zCyjM3uM5MVSvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwDCZdsnFCrGN7jCy/EIjzihKLYnpXWcGbCBQHniXUpTyLaFZ+8G8x58KIrhhHQJnqtABJvfngewVl5RVbFVBPk3dBCNlpvsWvxzGJRpN6C1m78RtxAFYfehPND341pjZQX8Zvf83lHddqI9BV6VzJKS8fxwgV/sSh9irk4FYgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFRsXqiOTwg3Z+XBzFYDVwzeufPvDjXU8ZufYOCcWbqFgTG5LB9aGq/hUPHawAVrj6hg7+bNsf9jTxKSEr47zUx2RKx1LJIyFbxQrpiP/RAVZJWKGPkF6BgkXyKigdrLBn0/MV1psB73GX6Vd4PUUhAy927eH9GcMut2ow4pqEPlfALDpuFPWOs+Dj9CJCkTjM7FDXzvXsngj/tVbBa7QsrMAVNSAQsyFawHchFVzFDUeYAXXVmGO/4Begk7yphRZrZR2AjlNN97zuV+53bDvsZzi7Qr2rOVfz3hS483VWiOkPc3jy1EoXNtKorhoKdbpwGe94Qt0V6HOWa+B3JqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7HFJlP9QXFfyKUOO/FmcBvXDy0Ay9xnq8yPc8zE97Q=;
 b=NErjG9tPwocfo1VZfdYDX+hjEv6WDORer8asQGe4mFwcBSYin+friXZjneyAKiolGYvc/EuTDGvgZXVFZY0huyoIygZM+449dd9fIM7wZIosfntUCZhCRrjcmgDcSjvZiJn3k0LmIrGP0tqEPur4n3Rq0tBNdDtvEB299Fj3GEFGBke/TMidC+focRD2eIOmnAwqi6ehklxuawROyRtCBGZN8lshlOVKX0ObFzBcuEkZ5TUIED2cu/bhp9lU11fawRaIRmXqwvO21hLnPpGReybqtC24c7dAdc1QCZ7UG8zYS8b3xhmIpvFkI4sL8L/9wEeLLqDjMiqHtiY1U5ZbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0790.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 01:45:48 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Mon, 20 Apr 2026 01:45:48 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v2 1/5] dt-bindings: net: starfive,jh7110-dwmac: Remove
 JH8100
Thread-Topic: [net-next v2 1/5] dt-bindings: net: starfive,jh7110-dwmac:
 Remove JH8100
Thread-Index: AQHczhRCnOOfCJuOYUCcp0gRDtomF7XjWCQAgAPahKA=
Date: Mon, 20 Apr 2026 01:45:48 +0000
Message-ID:
 <BJXPR01MB0855CA5A38AB100F641F9076E62F2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-2-minda.chen@starfivetech.com>
 <27151bd8-6a3b-411f-94fd-7b1b932b9aa9@lunn.ch>
In-Reply-To: <27151bd8-6a3b-411f-94fd-7b1b932b9aa9@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0790:EE_
x-ms-office365-filtering-correlation-id: 040ba719-b6e7-466d-58b9-08de9e7e8bfd
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 mDGcSG29J4v93KgO3/2M/WNYf849JNAHm5WovA8G8irQb6o7jGF3eu7nlhcXJ2cyNlTcZbHqk9jwFJHhPXAKxjsTHX/lPnfCYYWT31mfom+0fdf4CMrbclQyKH7yBjV6+23PBmAZC3/jCiPlyEznPwi7pHxvShyOeCIFoV5GFjDy6gQP9PYWedDxGOhkCrdeavPHpWGjXz2IEbnjF8+WNWMW1YSxpmpVgvudfcgNjYxyrN/xTWJ6tq80tJgrXnCh335132YuwRm6Mr8EN29DXqHQ0IgJ08Vr0YoVz/yKR0TB14V7E4JTZhTp57uojDQg0JlSva//++ornF3WNQcHKOS2b1WPpmY3ckoLWkR/DWR+3gdkMj/HjijTfiSzUUh0vPMA0Cs83yLktlixJTfCQoVk8ytZ8JmAtqrhNhpq9DIGnh2sQdQbmAGYaIt2S5MSpnsKZgq74jWwQNT5bidtE2AYUE92TnQOhblpe4/A0iJlnaSNeMSodhWArN3VLt9KHKxZqU4i+o2LfWRrVuAkQyZBnWDWwIyA++zCJZxaFwebZ1mh+IOIFpy5W4CTK05yZ7HAvgctCMfq7j+qnAYXfclvWUk0TRlrDanHNCbSn8c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E2YMR91/gPuSwq4RLbcB9nwePMRdTIDIr/kRlfW7sQSRwz7g4Ko9BsbrBCBw?=
 =?us-ascii?Q?BffWMuLLw/vSZnyGQ00uPVJ+NtVbebb0A6/islhtu2S8esPmAyVSBUivHih8?=
 =?us-ascii?Q?VzfxesbZwE2Y3SbaLYxjrs4m9ObFYoZoVo2nNgftVlFgjf5hWfqopGGzODTG?=
 =?us-ascii?Q?xYjBP8O1AqsCAWdklLH8K9ue0FWMeHdvqooEI+87nKQV/FxQvOwzFszqSJhE?=
 =?us-ascii?Q?7KK/msl+kyV7/GxBsujh4h6i/9lyjZREyEo9MIPjkcchSbWP5d3pTJhsSY5p?=
 =?us-ascii?Q?Twg0XOmoXx5zziFTWwjHaqsbF8Z/PlMvJkqoS4pYfRXIPek9c8ajO6eXcoZk?=
 =?us-ascii?Q?MP3LofveFzFg8szTySPReeXDc71dtpUy+RVY7K+HdV5xDNvS8nkJYjHdsoqD?=
 =?us-ascii?Q?eMAMbQFmw12LsnaYpIPQFGjtNNP9d2Ff+5mQxhv0wYeSvf2c1h/WwvWTcnbK?=
 =?us-ascii?Q?GxYTdZmEC4ftmnWGLqcrEB6BwRuc8cSZNvye9XweWUVoHnsXpaW7Cggiysja?=
 =?us-ascii?Q?LpLzCHjemPEeZCseY40aRABZC67sHsrt0W2tMf5ogp5/v9FGCKpehL04NyKI?=
 =?us-ascii?Q?4YQb+0QvUNGIsbeJb3HnTnoDEkd+J66LSqVUGgVuDl8NB7mY5J/kJNWGDjjo?=
 =?us-ascii?Q?h2cXntP9ABMjKZcmqngnfyIjh33DuJX4Nc5mIPgJ+bM4mbUFUqMhzQpsGT6U?=
 =?us-ascii?Q?PkGtJsw4uFpWaF+vFSZugsXZdSc0kloZGwMbxwRHeCGEvOiC2gP+TXUx9VSE?=
 =?us-ascii?Q?SDO+/Z0TRT/+QQZ5duyjGss0dL8TE5yjDKKivOubFpxdgArnBacik7BB1IiM?=
 =?us-ascii?Q?pfSyPiVcVlF4eX4Ito6CGuiPyg+mRirTPBGfIUMO5TYDtqmD9kn/Xt0POPW+?=
 =?us-ascii?Q?z594W8AejYJdLeTDHTa+PLH5Yb1TxZr+viQKXOZeIz7RAkIZDonjeUVjATC7?=
 =?us-ascii?Q?8mwrjLjzX+4SPoxm6GOAjVqHGccaDc81Sasmb2Mn6EJ48XylE9bmNJYmM3J0?=
 =?us-ascii?Q?GWxIrUPXg/74Z4nIi86jzx0nygmEieAHLouTA/1mWqF7ChisEjZJ9TPXyGuW?=
 =?us-ascii?Q?wO8sh/5JruiHF+giSrDZPBEQw9Tlzlfys00mQ1Dcmuf8yrADzfTUovyUaoMW?=
 =?us-ascii?Q?sicJMAP0fQh8x/Sdh5Z+5QpmWAeMgF0+o7RK5xagTGxg6LO5ST1i5cyEk+Je?=
 =?us-ascii?Q?YEcRY780W0JnrEOEyVPS+DV0mbQdQQgfXIWt6h4hwws93J9YV5oD12kQSvus?=
 =?us-ascii?Q?MWKNeDMvTuXlZZuSsH4NM5rjjP3yd+D0UgAirVPgOTOeIdDEP6eht2rMmJvV?=
 =?us-ascii?Q?svwpHUU9i3KaZNKhVxTEHHIj4SW6a0sIDGuAOmlELdye1J7sVHBRJ/qNQ9OD?=
 =?us-ascii?Q?0aUIV6kFukwxtEjrBI0NlJB3zHL7cwG7cfJa1Oij3AqrbYChFx8/ZVyFu9a4?=
 =?us-ascii?Q?n7wdfeb9Igu9Te9cbRiakCSc5ZzNhIXHnUxqLv6FOEFLagBXda98rqN8ca/K?=
 =?us-ascii?Q?rJSXi93G+QhoiB82AmL87tsATth+k3TGSutJyok4ea71bQgStMuNZ4ra36dE?=
 =?us-ascii?Q?yUtyBXa8WlvUpHqmlIETm9iTLfDSuLUoTyOu8DFrytkzYTJ2aAcTkdO4TItu?=
 =?us-ascii?Q?0fnQcUPryuma2cPBSGY5SE/NPWr/fu+0JkE1mwX4qrahu9mRB6OI3mLZZ/RU?=
 =?us-ascii?Q?QwctZaBBAtiSZ4r2EuF9vRYM+/rJBU4wzA8DZHaDzUs+XdU3Tb/WIgi9RNQL?=
 =?us-ascii?Q?7DrO2iujfA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 040ba719-b6e7-466d-58b9-08de9e7e8bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 01:45:48.4275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WP7xYN0bgzULjagpPiPyY1N1nmZCOrtYFtK6oQnY9pLGPwJiMraSDsYTm1WuTtFh9B3UMNKosy8orYFF1ylrpKn1idW1m6vV8V4CESugRt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0790
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-279616-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89F204260B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


>=20
> On Fri, Apr 17, 2026 at 10:45:19AM +0800, Minda Chen wrote:
> > Remove JH8100 dt-bindings because do not support it now.
>=20
> > StarFive have stopped JH8100 developing and will release it outside.
>=20
> Is there a missing "not" in that sentence?
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

I will change it next version

