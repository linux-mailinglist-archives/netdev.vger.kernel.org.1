Return-Path: <netdev+bounces-300730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zX9UBkFrNWp8vwYAu9opvQ
	(envelope-from <netdev+bounces-300730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:16:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625F6A7015
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b="bwy/zWEE";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300730-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300730-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D972305930B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85503B38AA;
	Fri, 19 Jun 2026 16:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1C386C1E
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 16:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885137; cv=none; b=Maj579lCe5ToW/x3u2TJI0L52PN+c8fElZ1y+qfpJ0oEEHJRE4TyjgQy7lEDYZvPsyeteEug9vWQz81kJH1iwrNtjuxGN5o0h7tu16mH+XNdpsrVzy6gddHLmxzMvSNiOrQxtuwVSqNi2ix0nXLPxuBBKTSUQMFjVa0tsc/ky4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885137; c=relaxed/simple;
	bh=+0nQqVuRMPQjg4Pni4V87Dju+ww99YTd3QIwXeLMiCY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NElhUpgcESSY6xh9Pgqvi24HXwSjcERHosRBoYimFp3DXHIVbBs9i6YgrVrNI6WAmKWMqA0P6FSpR5OJf+KrSYKNHYSeryOJQz2SpH+HUV/u/d32HukWqkZxWhB0AQpH/PFEo0r7LOuXjk8ihw0g1AvHAII9zZ3p4R2jFhIOBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=bwy/zWEE; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781885130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+0nQqVuRMPQjg4Pni4V87Dju+ww99YTd3QIwXeLMiCY=;
	b=bwy/zWEEndvfcEw+exaytr7ayZIOp3XU2/leScdgvbijxYuHP3jgfAFr0/7D9NFQ/PvwUD
	J5n0UDm/RFxQnVjk38ZLzwQ7xpXGaTYe0YQhgZMQPcaBETu8Qx4hMr6yduvTMUCjtPSOzi
	s/IuAx+zf67etlMu6RtiHnY9jfFjidpt1IY8E+7MVbDkacwjnl1/mPN8kjnDBbIRilFfod
	DKG0Ob7zqPwUgX4Ls42SBpbhfhvRwTolklAWQeveAjHDiVeBBcFrsS18yiCgbL302r4YD0
	kkNvf3GzI/V8LiM02D7SV7F/49htLAVQqhfjYiHmQ90qmCdik8RwowlNEauPpQ==
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-62-xztO_NosMG22vJW1eUHhZw-1; Fri, 19 Jun 2026 09:05:24 -0700
X-MC-Unique: xztO_NosMG22vJW1eUHhZw-1
X-Mimecast-MFC-AGG-ID: xztO_NosMG22vJW1eUHhZw_1781885119
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by DS0PR02MB9151.namprd02.prod.outlook.com (2603:10b6:8:13f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 16:05:15 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 16:05:15 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Jerry Ray <jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v5 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v5 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AQHc/B9qR/Obe4EEv0yRbQBFI3q6zrZF73MAgAAi23A=
Date: Fri, 19 Jun 2026 16:05:15 +0000
Message-ID: <CYYPR02MB98283966554323E452EFA65583E22@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-12-89874b72f725@onsemi.com>
 <ajVKfBKPuNk9zN7b@monoceros>
In-Reply-To: <ajVKfBKPuNk9zN7b@monoceros>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|DS0PR02MB9151:EE_
x-ms-office365-filtering-correlation-id: b23f145f-176b-4f38-c7bf-08dece1c8d25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003|38070700021
x-microsoft-antispam-message-info: u9ymMLuTSQlOdf5+Cj24mMZkEjqyVfpEjPsgqN7Z+xbGHdd1CrSb2P68rfOwCXOOls+Ba4nVcGkYs0x6iR3d3e6IMlyIOe75yYWv5waW6c05UA3HXQNGdaPLrQTQLpUdXaCDPW0Fxyq/3PCjeJqXPW6M1msjCW0kzUGxdKLrxlbRF07A2huXAyzoYYPaHAEIQgkj1Ntk8qqqQf242LHzkwjZqcxXdxMkTd8bqOS30cpF2QMnqycpz286IY7aIfHSu7eB7vxKrXngbYhsUP9H6WXLUzMfENs/7M4AY2UpdsVIuEgZOl/MvFdw13HArD1cmLrMYqoXu/aukt444rKD4xuu+Guh6CLrRHzSVNeViX+KVAXLONX0c8elK4vr2Af7ipdn0o1IV5EAHAHAMr2krJ+Q8rWfwdmpn9plCIxFlcZOlz4cPP0ddA9SkuO8KEXpjoaSpDKmaJ+GzoW/ubT2Q50Di6f9O4AugaWFcWZG1YmBAB2ZkEbw9xsTCM2JWIJzO0/fcZG3rJeEtNrOO1dU4kEJs5sQMNhJE3D/cixWky8XdnOWRwVjQIaBrgRKMyqyLAzs7WHDvzc619ettX6LCvlvkYR5PZGceD7R9lPVRJa2X22AMrVhIdlJsi9YzYBiaMoZVGBgjccHoNwT9Yq75irI9HStAJIPyB/0sbFxFliaO8auQg+2RW6JzMv1+8NtWXXTV8H+OBJ85yYfyN1NQVcSKTFr2ysrStGUW9LgjWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VUPeUEAqgJo/+3MxnMbEsLmLeFDPykTB4MACW4j6OphQMTm5T7bsoCY+x9?=
 =?iso-8859-1?Q?e8bUnOOm65O/OvztUGPZ4Bj6Iz8l4EzKXa2CvvX6anJScWZXrKSXvZ2dGu?=
 =?iso-8859-1?Q?WMBKzZwVSIfSxVTJ6s8uQPh6RTqi1wcC9RJ7n800fpMXzFQgMuiXXA8r01?=
 =?iso-8859-1?Q?cR6A33bJpdV1NLUqULC7vrjg3HX2r35/143/Jv0f8hUq8qtTNFl19rKMEX?=
 =?iso-8859-1?Q?TwsqHPgiWxp+PbUgF/e9wPm1mEptkfZ5KGKn2sDa6vhCuCiUQeZFJT4Dlo?=
 =?iso-8859-1?Q?3oc+8jZ8S0VoiIb6XBsaaaPEpyn/XqSinLsemcYziUnskxFjBIHeG5VZpA?=
 =?iso-8859-1?Q?tdOlWjQRckPg+hjO/1oGAmBFti+GOaIZ12O+NTiMZzU4qeLQR3S4bpyTKZ?=
 =?iso-8859-1?Q?KqgOfHP7eyxN5K7X/e7ML2AbeBx2qo+BNPA0Y8HgDG4W0rN+XK94q+wPPA?=
 =?iso-8859-1?Q?IlTaERNqv6dDMIV/S7LCzDmAcoy0sdT1YMQ125dJYDt8N0ZPF8R38RL4xl?=
 =?iso-8859-1?Q?0DH6aYB7350zJQWmIb9Oe3nFvtVUPFzpWQM8otpBNd9gXRfTy6NDVtMIuT?=
 =?iso-8859-1?Q?wVtjfXzYyoeGIJoAWFf56vxqGJTuSeEeRvpr12fCZATG1KM3jTgTF5lvwM?=
 =?iso-8859-1?Q?aJaDCkxuW7AIksWp9FklEFNwhb5TKb6fcl00+NN4ppprRrgUHlirW7bsDY?=
 =?iso-8859-1?Q?SrPtwupRPqwcuacF3l5nAFZRfezZ14hvbeqrZoBxv2paRa6SyQa7i/c5ok?=
 =?iso-8859-1?Q?mf0O8pYiKTy5VdSQKOOmGxqdCs01FgM0UzfhVHJGbt3yBvtXbHFgLQrpeD?=
 =?iso-8859-1?Q?OX04DppIVEc8+zTVUlYypTRqPjLjJHpptqY+voOwnvwUZDYv1leZ1aDzd2?=
 =?iso-8859-1?Q?JjMJEI/rvxnS/ONUynN9vOc7sNl2Kk17YLL5Oqls7jS7HqpIhVMARd3w4A?=
 =?iso-8859-1?Q?85cqlg0xzJzV8BdIgb5wRjFWWNPT5DV2dFMWApdBU0eXsc/pwIJk/KnCW8?=
 =?iso-8859-1?Q?dwsOtUhI7r6mpDn8/ALuNf4BNvHlvSbiM6/cSWODx1B1HeIjh6nneiN9NT?=
 =?iso-8859-1?Q?cSuhH3ij4OQO1pz9zZoiyaFoBxkEbQWu+ROBtQubvEeFkSBbgrBKx1fmsj?=
 =?iso-8859-1?Q?MkvyfeEZ2UBErOz2ws7+QMDm4STW7pvQhhEBf2wC8JID9bBM4Vu5XDiwlk?=
 =?iso-8859-1?Q?U6ACgC4owfRYkHy0LOpmKgO2yBxtLnom8iyVd1iryiANvEpwl5zwmSfimU?=
 =?iso-8859-1?Q?OyTLKuaHTF49UCijtWnZ4klaDxHyvzDvXzqVrToN5LMnQrWKc9No7aKRUH?=
 =?iso-8859-1?Q?Y+lofIZ7/Qy5SMuOhznI7DctXksrJFDVJ1BtYkonFD0dzRTtOM6KnCzutj?=
 =?iso-8859-1?Q?+xjCV7M4JCD5wUPMuZKrbNz8hyb0QsRI+iTBYBzwQtjzT/O57BuzNXqOFw?=
 =?iso-8859-1?Q?tGOvSnDmveeeLhq2QUfTGh8P95sDvw75ScNCcObwhTAaWm9DGhi2Gh7HXn?=
 =?iso-8859-1?Q?Js74dcWVlCvKL0DRzDrOofTwwv8lCPLFMOAiCQJFim1yJL9qmHZf7jf0cW?=
 =?iso-8859-1?Q?iZ6pq0wECXUc5RR0M6Fj/l04V/W8zS0G72hHK9NuWTW9S/E/KEyK3GXt3U?=
 =?iso-8859-1?Q?Q4SOj/E+2JWnJvebtTuDX7UFTBa/d2Ll1+Ndr4FxJZyHnDgOTHYcDyfDuW?=
 =?iso-8859-1?Q?77whMSLoG8Up7Ma/jgA/ygpmOKSyw6p8P7bjIOpsL8WTkamXnx1UcebDA7?=
 =?iso-8859-1?Q?WH1gRq/fUZDxx6G5k+/QjYCK4K3gqnM6TETUKvSGOJgmQ073uyho6lWFsA?=
 =?iso-8859-1?Q?+NZ++69Fxw=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ibPKggffYkec9Zbobr4i/Bmb0fKy0/4jDr8euB5/Nv1TDSvanXw15HsfXcUiPDuyO5W/vGdUBPA7wFkPbwH84htwl2on1tNyvVMM+1gjdm/ZSCC+uEcbtp5DFrzlHYXcwaxxxnYeUNW0O74m3pZRwk0IUft+vMk30IJijYk8vnTiYwTUBkb07D91J/xpqTfokCiIVb/zMnLlWMDgQM273CAhAjrvCTv+xR4xnPwAJBnFscg4ItKDYdd0I7SfRcN14gK8knVfDuu6FdgGnaWgHNXwD27kgBa8qyaixmqMLydyYKOy9eZ04inJZZ2ZlAj4HpPMTJU6TbFkCR7v1/ZBlw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23f145f-176b-4f38-c7bf-08dece1c8d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 16:05:15.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OUuyAcX4hSNLHWUcl4vsAzjAlKnCGhdBnGqkXvrLUXs7zHN7zaDAuRPgVxAjPaANiCKOv4DJRlfcv0U3/cV74R9GvIGBJ32BCm/SAbRsUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9151
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0NS8_l6oPGRFf_OwTY7wpYp70nV1u_98jUiGDyvEuBk_1781885119
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300730-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,onsemi.com:dkim,onsemi.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,CYYPR02MB9828.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6625F6A7015


Thanks for your feedback. Will take care of all the three comments.

> -----Original Message-----
> Subject: Re: [PATCH net-next v5 12/15] onsemi: s2500: Add driver support =
for TS2500
> MAC-PHY
>=20
> On Sun, Jun 14, 2026 at 10:00:28AM -0700, Selvamani Rajagopal via B4 Rela=
y wrote:
> > +static const struct of_device_id s2500_of_match[] =3D {
> > +=09{ .compatible =3D "onnn,s2500" },
> > +=09{}
>=20
> s/{}/{ }/
>=20
> > +};
> > +
> > +static const struct spi_device_id s2500_ids[] =3D {
> > +=09{ "s2500" },
> > +=09{}
> > +};
>=20
> Please make this:
>=20
> static const struct spi_device_id s2500_ids[] =3D {
> =09{ .name =3D "s2500" },
> =09{ }
> };
>=20
> > +MODULE_DEVICE_TABLE(spi, s2500_ids);
> > +
> > +static struct spi_driver s2500_driver =3D {
> > +=09.driver =3D {
> > +=09=09.name=09=3D DRV_NAME,
> > +=09=09.of_match_table =3D s2500_of_match,
> > +=09},
> > +=09.probe=09=09=3D s2500_probe,
> > +=09.remove=09=09=3D s2500_remove,
> > +=09.id_table=09=3D s2500_ids,
>=20
> Tastes are different, but the idea to align =3D is usually screwed by
> follow up patches. Here it's broken from the start. If you ask me: Use a
> single space before each =3D.
>=20
> > +};
> > +
> > +module_spi_driver(s2500_driver);
>=20
> Usually there is no empty line between the driver struct and the macro
> registering it.
>=20
>>=20
> Best regards
> Uwe


