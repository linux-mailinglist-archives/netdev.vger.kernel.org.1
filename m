Return-Path: <netdev+bounces-28760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9447678088E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1647C28229F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8CA18002;
	Fri, 18 Aug 2023 09:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620A4689
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:35:19 +0000 (UTC)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2124.outbound.protection.outlook.com [40.107.121.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94843A82
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsSr/YKj7yosKfr1VZw/DMfY7qfrk2M8/A6xxtAVlP8ayQjBHR6YQFV1mUyhDGV9pEIX5Vwl5XMUNun1aoN/9BxznSU0oRIAyEddKUGIXQHTGe6iFQbij3UVu0Wqow2uMwrEPEbqSELd/SYfash4XnjpK4cK1uMpAPJ55IrRvQN8kEQWjUZe3Ed9hV8iUmLN3Mm023R9AW1ovwMWc8XZz5tZqVPRJInReFJRBEgNaRbVcUeAyRW842nUwAs5u0E8SYU4YAfWHOEB66qp2q3CicPgahUdgT/qQDWzCiX9p7q8tHIINyrHuqiyH7zRZV7P6SeCdcgDZ6aD1gqfQWoHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lScVMifA+st19I3LzDGpH1aWlV66lttRUsdV9ItnSoA=;
 b=h1mR2DGh0+//Dph2/ZDD8td+VCmbOYxa+im3r/FpVxOigTkzVXR3g1TBGBp7TJY9tUd3Z0EEyL/Lb5mR3wCl7X5PxcCd+gqRcHwcBFt9p05Cwm1jf1rRSMr7ZqN0hkKGK5kf7MZ4isf0QSGSa7kxfByjdR7CoYlJ2zxxQHEUZ0/iSk+qBY26DQkfxBRkVeQ2YnqscV70YnpYcMDCpLTJqqYDsbfBTgBmt0Kg6Qbw8xvL6exhD9GGddCo0G9G6sLfi2dIlmUzPniKJymU5TsYc1/F2pnCbt6xmh8i2HyjKCdf+N0FH56pnJgTVv/M3f1XIE7og4ZBMnZ2cHToKzvlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=city.ac.uk; dmarc=pass action=none header.from=city.ac.uk;
 dkim=pass header.d=city.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=city.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lScVMifA+st19I3LzDGpH1aWlV66lttRUsdV9ItnSoA=;
 b=oenErApYAkKYC3YqE1zflCv5OVfKxIJwuITCs/6fITh3BXdS9vtvnCybR044rfpZ+u5onMBPKJnYGyMY35llxmaI6Anhtx1pY3ZejkBbWMjpw4VfsDfKJmWkA40qdAW862brv0Cda0vm5BuNXfpQlnb0nv3T8sUdxt3UJQGhp/6BwMbN0TSvzHKpgRTGXFgd/DQdCdSC/NblfEuNomOw/5gnI+Tswd1Y0W4+i/IEWLN1MBepN8Pk53163BReSERwXMkiP/l/ZlCzJriU0GAythfsms5CZeH/vUokv4xM47FUng8n2wwykXU2DTvtL6+VJWtGSXBp6siJjrT+5yz6jQ==
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::6)
 by CWLP265MB2050.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:35:02 +0000
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d]) by CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d%5]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 09:35:02 +0000
From: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Rakocevic, Veselin"
	<Veselin.Rakocevic.1@city.ac.uk>, "Markus.Amend@telekom.de"
	<Markus.Amend@telekom.de>, "nathalie.romo-moreno@telekom.de"
	<nathalie.romo-moreno@telekom.de>
Subject: Re: DCCP Deprecation
Thread-Topic: DCCP Deprecation
Thread-Index:
 AQHZsyaN7TZv6xK98EGiSIL1O2/QRK+zUMeAgAAj8gCAAND+cYAAErwAgDh/to2AAGYxAIAABfPKgAAf/YCAAp5C1Q==
Date: Fri, 18 Aug 2023 09:35:02 +0000
Message-ID:
 <CWLP265MB6449B1A1718B6D8CD3EBFB27C91BA@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References:
 <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
	<20230710133132.7c6ada3a@hermes.local>
	<CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
	<CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230816080000.333b39c2@hermes.local>
	<CWLP265MB644901EC2B8353A2AA2A813CC915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
 <20230816101547.1c292d64@hermes.local>
In-Reply-To: <20230816101547.1c292d64@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=city.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB6449:EE_|CWLP265MB2050:EE_
x-ms-office365-filtering-correlation-id: d507e93a-4d87-481d-aef9-08db9fce65ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 E5+60EXUbTJ/P24xjl5PA/zGQgZdRYEzICagOH/UdlwxCBmeDko/aelb263wegHn1FawYuycb5TAQX0G49QkdYQTbAqwgSfJu1Nb893zC2YjWbvW7gv45KmOACG5dt0F2JtRdgc/CJMBOfl+okyXZ0913B2pTS/6uyExTt89nghnf9RTEMRhFvo70iWDjS7Gt1ZzPgssoqnSEMexSZi5RE2JtmJfw45V+uUv8YeiVpPpUSucJxMYsxu1efHSdGzxAiIOJr6LvATB+M7Y6iONgRSu+ZAaht3Y7nBCHerY0Z77q0DwoOyZm0uVef7PTi/Al63qgr1EImHOC5GzOAIcgiFAOonUQP4ezdjy9dYhwM4/5Xaomv2tOZzdJ3ELRiQ88xhkrgfxnh+6RQlp1deKKaDy0JnSLhwYAeSwfbD2QqiU1ZHCM7lacN/2pdUsPlUJj3l+zdEACZFvlj8sMF1I5kXszJLkVJ6pKe9mlEUS8gtjMhGP7xa0vhs680OOZbu2QyWvyuk8DnTNpyN5jSi9Knuu+FzHyKB5QmReVggdokmIw7w0FDm63Ae2mZIBDvZ9tGw8vWusuwkNmaIZ5SQlga1F+OlbmDgKlI9upPQI/07Vcr5qfhsyQQfmQYBl4SBG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199024)(1800799009)(186009)(71200400001)(7696005)(9686003)(53546011)(6506007)(83380400001)(4326008)(5660300002)(8936002)(7116003)(52536014)(8676002)(2906002)(7416002)(478600001)(41300700001)(786003)(76116006)(54906003)(64756008)(316002)(66446008)(66476007)(66556008)(66946007)(6916009)(91956017)(38070700005)(38100700002)(3480700007)(122000001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Bp+1+rV+4RRgbkPyf6r81wudOIhbpKeeVQgRB+PiokfD/HIDjdf/X8s88A?=
 =?iso-8859-1?Q?b8JV9bKkD8hMYhqpEQCR6akKCNKhW4KVKHHINnD9QsKPSus8eXDmaV7iH6?=
 =?iso-8859-1?Q?mcbxyTRbbVbdy8NJA6NIMQ5Q8L1AoRj6aiQfnEX9j3v/1WDCLveEhvLixs?=
 =?iso-8859-1?Q?uFQ9nw8xECxe8NCjsMJd6Nhma96BgvJ7X7VwlQ3jjtKxngksyBjIPLyJng?=
 =?iso-8859-1?Q?iSWJ0utK0h3uxAODaDrFjIjUBfu9qhTDXoDEw221WcyWl2OaHwKieLZlGN?=
 =?iso-8859-1?Q?g9OrMVh8sYtG+wss5mGnVK9EQB7qQN6Y3v6vyhDs5UAqb68GFLhXHdhyh7?=
 =?iso-8859-1?Q?W9Ch1y/48s+gLR+BM+QBIitnM9r1PufOhkKeQzOgmtYRDy5/YMbVUga+rv?=
 =?iso-8859-1?Q?KThctuC14w6JCdatxaWro09/fd3bgzI6wK11/jkgpQqXDBI8mTt9sPMS6d?=
 =?iso-8859-1?Q?z0PWfY/p7HGwKGTo9vqO+zD2FFxXSnUl9x6g2aVJ15FLWa7dmR4B1aHO7+?=
 =?iso-8859-1?Q?uirEE74xbiQmJPI2zm8ft2U5SxHF50c3cTQr/nU6jFNUB/k+dL76p5Apm1?=
 =?iso-8859-1?Q?jJRcv8HI24hmUJ+0W9D52qiYGCSbPzW7j6qC70jeTtv81g9Zgzk8LV0ij+?=
 =?iso-8859-1?Q?1W9PZHhWTfzfgGCobyw8W2wZa+go41Fah2NH2ex+vNjXOqvblH+j+UZ1md?=
 =?iso-8859-1?Q?aV9hrxIfzXJgMCo7tyBxvKFXD0kW6joR6DXDyLBtDSMlIwsYKprQvx2OrY?=
 =?iso-8859-1?Q?AUW0zk/Gx88qwRUZjxL8MHk5AKxi5jTX4K1a45ZyinXe1PW316o2Ae6Gap?=
 =?iso-8859-1?Q?ORE4Fm7wj5l91a/5uCnPow6uRf3+I2iXUX9AkYpJemTutgA1hkY7nhESgW?=
 =?iso-8859-1?Q?joWg37/VoP2/O9rf8/V0vE3fYHJ913OB0wA7Ru9KacBAKbD96NN1+6Rmja?=
 =?iso-8859-1?Q?40sDO9tei5WMcFLh73Z3rxezbElzXqjifGYgBdK5821jpld4DsMZacedgQ?=
 =?iso-8859-1?Q?Fl3efolFBfmswjoYG0RWT+sfZBCodD8LJjnJk5nnHoeBU8HgeIOYDKX6I/?=
 =?iso-8859-1?Q?KE/VSXtH7FXSkAnYMVTBZDDM5E5Iszx6jhT22xIiQ8VxH2wGs7C7ws04bS?=
 =?iso-8859-1?Q?39XQbeXh/FjkBXjKLZXbjoi23OJpCtMdspjm0XcFc+va97MEu4IFpbJ7sH?=
 =?iso-8859-1?Q?t35cu8MnapP27fhtNK3ttrauIhlOPLlrF1R60zTVSVmyCI9gvVpzD53xf/?=
 =?iso-8859-1?Q?2jDevNjk45R19KhkMCh8NZrdHEm4liGyT9msAtz2s5aeRYOXIQ2tBfa5RC?=
 =?iso-8859-1?Q?85nDGl2bckut/gNWEjOStPguiYdje55KonbBeII45c/9q62P8eE3XEZJHj?=
 =?iso-8859-1?Q?/BjG/5kO/MtLF/+Kh/YKC/yrEqeC+uDfAa0U8pR/IwVYNaEcHfqSF1OIRv?=
 =?iso-8859-1?Q?3fmPPX1BjTmN6lTzRKz3X4om+haySkdAsyZt0CSgm57WPsKldEFlpwpHkx?=
 =?iso-8859-1?Q?earvZEzWNm/DjaE/AD/RVfEnr1CIk9H9DG1qVkUNyaeRt/3fTPPibaOLof?=
 =?iso-8859-1?Q?OGk2coXjC6ragQobY7rhdmDz2NOZN2Vql2wXorJwd9K4pQilL+eOqBGJvI?=
 =?iso-8859-1?Q?xjfwMlDI0TRmNpVyYaJhjvAxgUxzJwJh9dcI1uyvfrDyw0Bb9rAlHBdW6o?=
 =?iso-8859-1?Q?1J1iARPzHXCl1KLB1AtkCeAG8p6vMmcpaFjvIm2dhZdXQhGODONS6IPuyO?=
 =?iso-8859-1?Q?SmwA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: city.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d507e93a-4d87-481d-aef9-08db9fce65ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 09:35:02.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd615949-5bd0-4da0-ac52-28ef8d336373
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxBqm4ZjuN1GZNu1VHS0NRsEU/RGmr5VGwjQGnr7KOA7NXPw/RfJDr6Yol7rA2w1oTxWnEmaA7x4QzwG7rfET3Y8CilFqZSkXdYp4/qZOfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > Is the scheduling in the kernel? If so yes, it will cause a MP-DCCP n=
ot to be accepted.=0A=
> > > If it is all done in userspace, then it leaves option for someone to =
reinvent their own open source version.=0A=
> >=0A=
> > The protocol works at the kernel level, and has a GPL scheduler and reo=
rdering which are the default algorithms. The GitHub implementation include=
s some non-GPL schedulers and reordering algorithms used for testing, which=
 can be removed if upstreaming.=0A=
>IANAL=0A=
>=0A=
>The implementation I looked at on github was in IMHO a GPL violation becau=
se it linked GPL=0A=
and non GPL code into a single module. That makes it a derived work.=0A=
>=0A=
>If you put non-GPL scheduler into userspace, not a problem.=0A=
>=0A=
>If you put non-GPL scheduler into a different kernel module, according to =
precedent=0A=
set by filesystems and other drivers; then it would be allowed.=A0 BUT you =
would need=0A=
to only use exported API's not marked GPL.=A0 And adding new EXPORT_SYMBOL(=
) only=0A=
used by non-GPL code would get rejected. Kernel developers are openly hosti=
le to non-GPL=0A=
code and would want any export symbols to be EXPORT_SYMBOL_GPL.=0A=
=0A=
I see, the problem centres around the implementation rather than the protoc=
ol, as the protocol itself does not need these non-GPL components. So, woul=
d another option to the ones you've already suggested be that of creating a=
 repository without the non-GPL components, and consider only that for purp=
oses of upstreaming? =0A=
=0A=
=0A=
From: Stephen Hemminger <stephen@networkplumber.org>=0A=
Sent: 16 August 2023 18:15=0A=
To: Maglione, Gregorio <Gregorio.Maglione@city.ac.uk>=0A=
Cc: Paolo Abeni <pabeni@redhat.com>; Kuniyuki Iwashima <kuniyu@amazon.com>;=
 Jakub Kicinski <kuba@kernel.org>; David S. Miller <davem@davemloft.net>; E=
ric Dumazet <edumazet@google.com>; Florian Westphal <fw@strlen.de>; netdev@=
vger.kernel.org <netdev@vger.kernel.org>; Rakocevic, Veselin <Veselin.Rakoc=
evic.1@city.ac.uk>; Markus.Amend@telekom.de <Markus.Amend@telekom.de>; nath=
alie.romo-moreno@telekom.de <nathalie.romo-moreno@telekom.de>=0A=
Subject: Re: DCCP Deprecation =0A=
=A0=0A=
CAUTION: This email originated from outside of the organisation. Do not cli=
ck links or open attachments unless you recognise the sender and believe th=
e content to be safe.=0A=
=0A=
=0A=
On Wed, 16 Aug 2023 15:26:07 +0000=0A=
"Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk> wrote:=0A=
=0A=
> > Is the scheduling in the kernel? If so yes, it will cause a MP-DCCP not=
 to be accepted.=0A=
> > If it is all done in userspace, then it leaves option for someone to re=
invent their own open source version.=0A=
>=0A=
> The protocol works at the kernel level, and has a GPL scheduler and reord=
ering which are the default algorithms. The GitHub implementation includes =
some non-GPL schedulers and reordering algorithms used for testing, which c=
an be removed if upstreaming.=0A=
=0A=
IANAL=0A=
=0A=
The implementation I looked at on github was in IMHO a GPL violation becaus=
e it linked GPL=0A=
and non GPL code into a single module. That makes it a derived work.=0A=
=0A=
If you put non-GPL scheduler into userspace, not a problem.=0A=
=0A=
If you put non-GPL scheduler into a different kernel module, according to p=
recedent=0A=
set by filesystems and other drivers; then it would be allowed.=A0 BUT you =
would need=0A=
to only use exported API's not marked GPL.=A0 And adding new EXPORT_SYMBOL(=
) only=0A=
used by non-GPL code would get rejected. Kernel developers are openly hosti=
le to non-GPL=0A=
code and would want any export symbols to be EXPORT_SYMBOL_GPL.=0A=

