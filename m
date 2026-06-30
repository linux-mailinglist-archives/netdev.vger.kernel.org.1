Return-Path: <netdev+bounces-303003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QnkuEPFrQ2rJYAoAu9opvQ
	(envelope-from <netdev+bounces-303003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:10:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E596E0FE0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:10:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=WEvHxmlJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303003-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303003-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DCD83015709
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463B3C10AB;
	Tue, 30 Jun 2026 07:10:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A923955C1;
	Tue, 30 Jun 2026 07:10:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803405; cv=fail; b=cojGozIlQGu/Iw0fIQQNOnMTEBk+kMqoPq5BPDwv1kbjlNdYKaS96/9Z/bACwzRVA48/vhk5xJWVaf/WzEAghm9srE28iLAUnCqNgHsL0rhmO/F+mwhC9ydO9LwIBZFmXQulFmTENei8wnXxTk2YqYYRJEjP14iwLDiObhNLvnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803405; c=relaxed/simple;
	bh=jCtm6sWBSh41wi/vtGxIzbXaBlcEIQnjq2DN2o8lVS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qoi1R3I6NCR8b7sckgQuxRI+JK4hOcnafevdt2msP26r1+94qc+S5UPU7rsuqhyVArxYS/ugEx8sqLUQMMIdUZA4IpprOyzBorC5SVteousHryouji8jbShvtYHLEpu462plVKTQJJAwxkWyoblpddU8bxsFCXbtFz5RalgTLS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WEvHxmlJ; arc=fail smtp.client-ip=52.101.52.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONDRa6QJWU4avpBLntE9M3SebwtSSqV9hHTVBqnz+3I7cYmtH2FDBtpU3okqtCSMyKp0+g6rXG6Ob70zOXldwlZqDMreN8QHbhY6Txqy9BLTI++iBcqrU1soEcZFc7GAqunSiMQnj5nVvij9eFqFZWFli4r9IqRWM8M+EfQMiLdwws5n0AO41/e8Ei4FFxIfXU4xxHeuaSh8+stlUW+lFVHpjNjn4uSRi9jTQdwWjUMPnDFfK6ld1kdRVDPn5BZRkmg68z91uOUt5M+/hHHohT1VVycaHAO5/ipx9UT7lz4tuNZz+72FO+8nnJJbdeJDxz1BI7BGSiXqQyD+umBLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT0BfVJ/JEcVt9HO4/mH49Ms7rJMim9ksIoq62KQLSc=;
 b=sOlvbjQ6ya2RJidOt+zXpOR7gJCSYqQTuRWh0SIumVhErvinoLdLPuvl/dH5M1hN60nvtkex9LOxOUjZPU3bNigS7z/Wdb2oQlvmbTvkIPYD7zAYuVcUtbp0OBgY9UC4NpaTrgU6R110KrtSfA+dr4aXvvtOHJ9HQQrGn1V/0QSzKy1lqcUdAQSaRYX7vLNI8e7L4V573wAupq0iFMZFG1gsithK1CqugHL3mFwCtedlg2tC6idubvpuKI5pOomY/gsVOVolH+8ijVaK0q5YVnLEkHZFAU7Z+0XOnVC+WtFO+Kj1gJmaFbEk+JJ9gMISHttcgt0+d4vWvczXh2oR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT0BfVJ/JEcVt9HO4/mH49Ms7rJMim9ksIoq62KQLSc=;
 b=WEvHxmlJyifVHV4WnFeAeGj8nQxDw1OebkFVTR060e+OQKpKDdK89L3wVTKG+4dH+0P2AxpB2XtiiNRzYxztTfv+yDLbgacBQjb7+Knq2DHQV2ZtLzAZA0VTKtWeVsrC/Vm476C+blM5hJ6O0gTHFtvQNdD2M2C9jCLtwImC+uQR1ahL2+VDvYJlTxUfS3T8t0tbQMUwkVAoqS4MagejaA2bE79C114y3OPT4DU2c72zadeZKz7CbhmuXai7ZlQBWFsoktSSucb19xLujaXp6/57rx3wzmjesSl0YsyATZa8DB3zX+l+QJvd/qfq/AvLoBZF1OVEibtdjasWyTBmDg==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:10:00 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:10:00 +0000
From: <Thangaraj.S@microchip.com>
To: <davthompson@nvidia.com>, <arighi@nvidia.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Raju.Lakkaraju@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan743x: Initialize eth_syslock spinlock before use
Thread-Topic: [PATCH] net: lan743x: Initialize eth_syslock spinlock before use
Thread-Index: AQHdBYl03u0T22nJ70uDYXPu8iu5I7ZRPxKAgAV0i2A=
Date: Tue, 30 Jun 2026 07:09:59 +0000
Message-ID:
 <DSWPR11MB9715C6EAB1F96D4E71A17D73ECF72@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260626163218.3591486-1-arighi@nvidia.com>
 <SJ0PR12MB8113F67510A03A9486C8EB26C7EB2@SJ0PR12MB8113.namprd12.prod.outlook.com>
In-Reply-To:
 <SJ0PR12MB8113F67510A03A9486C8EB26C7EB2@SJ0PR12MB8113.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|DS0PR11MB7768:EE_
x-ms-office365-filtering-correlation-id: c8f37926-c59e-4ce6-80bf-08ded6769954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 yuM5l6mcDMSfrbnsdantg2ksBoaGPK2a1+Ido6GU7KO+5U0FbZ/NUNmQ8DGsziDunReml44n2K/SEuo0sC4qIzlq5Co7gW75RXNwZ2kPuup0pX6nciNmSnyKZbOpel3hFTdmSw3p8smx0Ot2+fDwIXMbK7ySUVWzkmlBZfvxDbKQVofaOQCEKNKKi+5gqPu6mUfZ82sHV3M9cflpMX8nA2hKuobx0XoR+P5mjfFnXy0Ag8wvGkJkFXd59/NGl+VW4LfVTcPObtVXutNZkCZD2Zmcpe2Llag6tHcGpJ3wY4rM4yxfu3lW0x/QE09Ca/JNrggLDeOu5Jm7ruDBc86IQN6aqiyBKi4p9QFqwJgFYbpADO3JUKKvDTZERTt4P11kvfwLUg5aIBwFKZUEMQ1Qty4bNEJDd4rBVzyNCsslHDDsoEzGfI15maTaVkqYOl20Yu35zI7CQxnVuWjA+wbJiXfSEKNKoHiyLpOr7gWbKyl1RhwesI9UzwWK7jAl+uNfMfawA3ZjRXQep8SznjI98mrf1FBuRKH3IsH7KrWoXRxl5fH3PxriFoqC3+Ub3ibT08FBDhKTsQt3bAoI4Nk1d3/Ht5gY2V0KDZAAbqoE/lnFWVIAPTY2ZefmmT1PZ5O3DXsLSE7O7Xki+Iep1VvCzEQUoNMP1026NmlO3L+xN+AEtXHoRJsySY6Cl+nVqKXzJGBOmBXP7e6v8jrOOizbbAXeLcMvB0dhBtcTZyaBieg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x21oTGfA/jCfNMNmbBRgQsIVXodBP4tihVXFR1usWVblLyM/vcDBm2jGsZB2?=
 =?us-ascii?Q?Z1dnAzNlbEtyoQd5DMtpe/5u3bXKpK8u6DJj2UjxkBf5TZD5GW/07HXOGq6a?=
 =?us-ascii?Q?D55wMHBxhoN7GlG0aC6okCjczZnnS0us9RktVk4O7hYlE6b8yACk+9dyRVkB?=
 =?us-ascii?Q?1FqJZagRZJlj9PGKPtXgrcJhy+SR0ONzSDkpbrbNVtcE1AJ06m14bgCyeqr0?=
 =?us-ascii?Q?ob3q8rSLQTYx0RDLNOalB1D1f7UhLxGZxIokuJEcrKNwoWj9hlIEoEPVgBzO?=
 =?us-ascii?Q?EE+kKkGMVXw3jHEKaG8Hln+nKFYzQ6DGtOMPoKayr4Alfp+xU2VOg2Nitq9d?=
 =?us-ascii?Q?+6QWFYQ/W4BtUQ+BbQZ7+AkB8rYx35ekv68ys1LKUeV4K5uNtM+meLaOeHbh?=
 =?us-ascii?Q?ZEHSbSLzneBp0lEG2z5dYQfYjOos0rBBz6vO56yM6KS35zfqICwbsSR/xREE?=
 =?us-ascii?Q?aqGeQ2sr3SmZ2TRyxYdx9byFwuWqCg8PfeE/kQcnjm/DgCKP/npV/J45/I3c?=
 =?us-ascii?Q?VPIkTtr6dqavOL6LKiQQWVSSldFDV0+2BcAnCj4pDrJpe0506j4xCdyk+tS0?=
 =?us-ascii?Q?TuvzcLBFI9T8eS/YioOQL6eoIcf44aKzWDEAanssWZzs8ZUXxi02GIX7XYzA?=
 =?us-ascii?Q?sNc/Pikurupy/kL0U5co+IHxPTUSCv7BKiP3oHBnbh5vtHkO5mNzIpFbPDLj?=
 =?us-ascii?Q?UqHHppdmatMkS2Lxhv7z3yXtHmZ+FuKbhKOuDb0yr2Vghys4rSaOw607GEZz?=
 =?us-ascii?Q?VzZVgs6T2kvlCz5Yk+8+5XToMeUh1NZzumX6JY3uR1AQxGRqv8myMbOCsbfC?=
 =?us-ascii?Q?FL6c1lKgLqXA9uP19gtJg+aYQnDUWhnMF+JeNkBeWZz2YPI3vG8N8VfEK+Cf?=
 =?us-ascii?Q?2hbasJUTPTfk01eC6cQkoQXvftgKVC/npdDRWeag+YwK/vvFgJpchCbeRyNF?=
 =?us-ascii?Q?LYXOh+JgE8lSGFxc6rMG1ugrhpaxmKtZr/Ta5dmm6wF0S0QSyl/asrKJpSYT?=
 =?us-ascii?Q?0szNJ1rwYZe5jn1eTskKdIPVatJU6C4U6r8drExBjy4r3NRK+dfuWlZmY0DT?=
 =?us-ascii?Q?sjjb9+HYGuoC29VSymROrzwhgP1iAJh5U9NgqVrRa9CA7jsacxvetr5Tm4q9?=
 =?us-ascii?Q?g0LCtZrMZ1uy1Qk37EWSTJCXCKO+JHWGdx1iPxfy7ZWuznypErdQxS8dfnRF?=
 =?us-ascii?Q?NaSEdLZHMXIQUdB72fOJmwkFoCsH9WUtMkwwIm01GAouASMnR+vhoms8Mmb2?=
 =?us-ascii?Q?mnrmk8BO24RVAVohv83dJ6Lf8O04t0bWF4tt4wW70d9wF80cZM4an28pC4xG?=
 =?us-ascii?Q?lhHiRk1O8Z5wgcf1UY4hM6wpeWqmIp+Bv0rvAWp2IBBQvKM643gIAtGy+sfh?=
 =?us-ascii?Q?GWAd/z4ULo+uHhOneppoPIX9XAj9qUV0EvMhgoYCG536cRl7MB7kEEL4YX+Z?=
 =?us-ascii?Q?0YVOlwqsSxYVTuHSZaj3YpUBtyai+oRc2MxR/A7EeY81BhgR+0ThtAPxgUZ8?=
 =?us-ascii?Q?xngtX4fXrAAPv1DFwCVeWX0EQFnxuXoI6zxvfsudBKMFk6ZAsGe6/cUYLTlv?=
 =?us-ascii?Q?vhXExD2gad5KIDk3ZEIjtUHQ5SUtbNmuP/+ntpf07/db8eotlb2+gxureyEC?=
 =?us-ascii?Q?PfthuBfgev23VSPk5hIf27FGOkx83PLt5GOK/h9grsi+A68UZjx1xXJQvtPu?=
 =?us-ascii?Q?KNaTT+fMsLQqYvTqEZnxaGgpJtNJB7MsWR0ZM4NR3PnptPp2GpjfKE/ZXMDY?=
 =?us-ascii?Q?9xhrBrCZ8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f37926-c59e-4ce6-80bf-08ded6769954
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 07:09:59.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlxDiqrfXHv2zxHnhWjtgE4gzJ+6WDklZNjrjYTNj+g1/cg07gKb7/supnnjyRzAakCvQUxlDJQy4y49sF2HQvg8vKpARX7mTFJG4b5ZzvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303003-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davthompson@nvidia.com,m:arighi@nvidia.com,m:Bryan.Whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Raju.Lakkaraju@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,vger.kernel.org:from_smtp,lunn.ch:email,DSWPR11MB9715.namprd11.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85E596E0FE0

Reviewed-by: Thangaraj Samynathan<Thangaraj.s@microchip.com>

> -----Original Message-----
> From: David Thompson <davthompson@nvidia.com>
> Sent: Saturday, June 27, 2026 1:21 AM
> To: Andrea Righi <arighi@nvidia.com>; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Raju
> Lakkaraju <Raju.Lakkaraju@microchip.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH] net: lan743x: Initialize eth_syslock spinlock before=
 use
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> > -----Original Message-----
> > From: Andrea Righi <arighi@nvidia.com>
> > Sent: Friday, June 26, 2026 12:32 PM
> > To: Bryan Whitehead <bryan.whitehead@microchip.com>;
> > UNGLinuxDriver@microchip.com
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Raju
> > Lakkaraju <Raju.Lakkaraju@microchip.com>; David Thompson
> > <davthompson@nvidia.com>; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] net: lan743x: Initialize eth_syslock spinlock before
> > use
> >
> > lan743x_hardware_init() calls pci11x1x_strap_get_status() during the
> > PCI11x1x probe sequence. That helper acquires the Ethernet subsystem
> > hardware lock via lan743x_hs_syslock_acquire(), which relies on
> > adapter->eth_syslock_spinlock to serialize access.
> >
> > The spinlock is currently initialized only after the strap status is
> > read. With CONFIG_DEBUG_SPINLOCK enabled, taking the zeroed
> > initialized spinlock can trip the spinlock debug check.
> >
> > Fix by initializing adapter->eth_syslock_spinlock before reading the
> > strap status so the probe path never attempts to lock an uninitialized
> spinlock.
> >
> > Fixes: 46b777ad9a8c ("net: lan743x: Add support to SGMII 1G and 2.5G")
> > Cc: stable@vger.kernel.org # v6.0+
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index 1cdce35e14239..e759171bfd766 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -3541,8 +3541,8 @@ static int lan743x_hardware_init(struct
> > lan743x_adapter *adapter,
> >               adapter->max_tx_channels =3D PCI11X1X_MAX_TX_CHANNELS;
> >               adapter->used_tx_channels =3D PCI11X1X_USED_TX_CHANNELS;
> >               adapter->max_vector_count =3D PCI11X1X_MAX_VECTOR_COUNT;
> > -             pci11x1x_strap_get_status(adapter);
> >               spin_lock_init(&adapter->eth_syslock_spinlock);
> > +             pci11x1x_strap_get_status(adapter);
> >               mutex_init(&adapter->sgmii_rw_lock);
> >               pci11x1x_set_rfe_rd_fifo_threshold(adapter);
> >               sgmii_ctl =3D lan743x_csr_read(adapter, SGMII_CTL);
> > --
> > 2.54.0
>=20
> Reviewed-by: David Thompson <davthompson@nvidia.com>


