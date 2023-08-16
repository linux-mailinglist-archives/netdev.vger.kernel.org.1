Return-Path: <netdev+bounces-28128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A577E51A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137DD1C210FD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C1156E8;
	Wed, 16 Aug 2023 15:26:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E1101DB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:26:21 +0000 (UTC)
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2108.outbound.protection.outlook.com [40.107.11.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6575126BE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMlR+wI/UHfUS3gwkG9Ij5fIBGIRoVQWdlj4i7VgnNTW9f+P4wDFPeye4lUTwhpxLhVpRqMavHQlgNT8bMz8OyD86F3e4jtS9IXFyhEyB0q19gGMLGiHMShkzYo+C8zLiikp6X90ELdP5hpZHcjKqeUPBAfrwEsNfIP03NOjOxC63zjInGQJdXSqsDA8xNelbK9nPVup4Zc32z5rP5hNDVDYCLRUKsnOiCJRW6gBsCazr4E1wQY9xrdxOl0X/hUmSlfE01euJWEAKt4u6+NUukE7CYzG4WMz+CmklRpIw4EnWeDINypH2t0aVB3HR2q987tjil6NEFbTwPfpolvFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhQ60jf6Ols+bgfrF/fYur7wX4I9bFxpYoYmb6A+qfA=;
 b=KDk6dtuwjKn89MNYFpFjsl585ct9teI2n4ilckhOI1DIArjetn9Pn9sRe9BTXOjQAkovVdHmZKc5rVKP6DfgnuUoFGn5frgPIktBmsZAiMDeFM6SJR0nD+8ojX5eZTQa1Y4KKig21wocuXuArigz6jpgBYf2fuIx/nqSleOty1bwmRUoZsvJXPtxGc0urU4Ik4qMd7zWJ5XrPDw6TTJUEmI7Eo/G4wm/jXIxlKxlxOl9UsgwJ9vF8q7c2ulwXfpFGECkqtPggpQHo9i6qLg5J0gRzTbhNFra+/hhgynNopJT9GW3QXfprzSH0tbtgwiXUMYVH5NBflUneJa31Z+KaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=city.ac.uk; dmarc=pass action=none header.from=city.ac.uk;
 dkim=pass header.d=city.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=city.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhQ60jf6Ols+bgfrF/fYur7wX4I9bFxpYoYmb6A+qfA=;
 b=tkYjCGjqXjSgyq4lqjiy9VkvuSYdKz9Uk8wXoVUM4B3wR+8jqxHKmfitftPnnuykTocjSfi2RcFSiPGcJbEv1sOHNNThm1+BENPJyZMhyxKRnhFpFUJTI9W79L65tY7/GCLhoI/h3AeSi6V0IrFOEjt23NFSBThal4uJR9SJHIokYJchurkX15AiUGNsQiKarIcwz2DQRng0aid3/yD8xLw82vEZiRnyhcg00v43y2DTf3Jav25kxGFN8isTTDBRStB35kzNgwcHw0pZ5QVE3S2kBOxwWhEMH6ZX+p/m+MGuE44q9C0mRU0ipPdwxs3ZU90lWYRkkoAW4Mqls2divw==
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::6)
 by LO4P265MB6121.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:27d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:26:07 +0000
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d]) by CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:26:07 +0000
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
 AQHZsyaN7TZv6xK98EGiSIL1O2/QRK+zUMeAgAAj8gCAAND+cYAAErwAgDh/to2AAGYxAIAABfPK
Date: Wed, 16 Aug 2023 15:26:07 +0000
Message-ID:
 <CWLP265MB644901EC2B8353A2AA2A813CC915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References:
 <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
	<20230710133132.7c6ada3a@hermes.local>
	<CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
	<CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
 <20230816080000.333b39c2@hermes.local>
In-Reply-To: <20230816080000.333b39c2@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=city.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB6449:EE_|LO4P265MB6121:EE_
x-ms-office365-filtering-correlation-id: 493b2a7c-607f-4418-cfbf-08db9e6d1cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RdjLXvVkRaFbj7xwNqqogJIooDqZq3k1qRxVa5uj61tdMlnYG3iZwRStEPzR1+CJTgF4Iu4X6zFw8R96Xp/mPnXl7HJroG4Bwd0hILWbD5JJS4FfHOOlauLwBO8pbI10DmEdgmVzvPe9UQGJTexHIMuUVPdUIx6I+04rl1OEWroEOE0Ja2doYQ9hYhsC8UkR/b9s0Dk5cQ4rASzPLcLfzHNSAKHgYGDVAiXFXVqrlR79eLeZdBAzoKwjGXiM0Xnd9rCVXuzpCvm8az7PsWakbO9+TC7x89IiHvC8XADlC9oqoX/86kV2GY724cqn0jT8iyB3aOb86bdgzquGEII5M/7obfF+mk32wBeEycP25SPEjdn0Sh7CZsW9JB0K5KBtWtOyP8bLvzCzN9xRDiQqm0HFLJNKWOyKDtfpmHQ8BMORAE08UNrLB1z6ajRWLBa8d+gAHUnCTpM/Zdhh+K5dXrAMhTPPBzbQQlDAYTfr/b2M6nST1ibwz2WSNuTPSP7bXQSOpUWEywuCK49SESj0O73ecCGXWxlZO8xhf0vh+570FOAIzmyNpfeZ89EQFrIUNu9HVXrww+v4JNSo/UJ0vPgHChIFaCHH+Y2Kz3eRLxZm7G967wHkn1dFRIAdFlpH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(786003)(76116006)(6916009)(66946007)(91956017)(64756008)(66476007)(66556008)(66446008)(122000001)(3480700007)(41300700001)(7116003)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(2906002)(83380400001)(55016003)(478600001)(7416002)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sU1bCN9ktTl38tx56PqqP65P+HYHMNfHMymjghXprbosDEnuaq6mehJAPs?=
 =?iso-8859-1?Q?U2UsASVrYPSVWlIkbezqHDV3UNsmbH0aieaeBLY4Rxlt59ojXw6kKIyyXw?=
 =?iso-8859-1?Q?K1+LP9kc/sl2oTwK8QNbHsHZ79wXRBsDApZW+sHT8BdZwRYu5UZdlhNP/N?=
 =?iso-8859-1?Q?g5wCS2u4zO0vZjtfw/9fLvkwr+Lf4EufJLvD49GzKnHmJrB5nWbdbPPo2l?=
 =?iso-8859-1?Q?j//pntPxYBPWTzE9/Vx4NlozhpN3fueFK7+QaklkQFRcE8sHHEXPgbPypD?=
 =?iso-8859-1?Q?CyjWn2XN7tgQTO74QJnalXUL1m7FXjb2PON2r+NuKZ5BTj9uQH1+FWRhxU?=
 =?iso-8859-1?Q?O1CF914MSvA6tmz1Ht/1xJZSQqWqV7bVKmFb6bf40m0KV7OWI7MLgdpMZK?=
 =?iso-8859-1?Q?CoxVTLolk7KPWJB8xHlKl1qsJlQ5WaHPFxkvfWfsUoiFjy2MRSMwZXHobR?=
 =?iso-8859-1?Q?miLuqvJf82nSXlKxJI1owwS/IozvrEbWWCYx6OnLJd59ouXyum7yJKibpM?=
 =?iso-8859-1?Q?Jt5TsQPPkHtW8a7mzQDeF1U3JoKf1+Bl6GtFcxW7NrjHNAfDXYzuZnIYMQ?=
 =?iso-8859-1?Q?xciIjstK7adR4TzNQYeG+y3KM0wTuofjk1MuH6yJoo5NuhlbaIq82Bpg0o?=
 =?iso-8859-1?Q?C16ofGOEEeGNmvFpfEpfkDjOfZsXoRA0DBiIaaOemaHyLkf0Vioq2xGlTK?=
 =?iso-8859-1?Q?PYKOCEc1MN8/mZbo1Bf++KfPnyoIos+6dmbUJ7yRUFbcHt4H4/QCpFtCra?=
 =?iso-8859-1?Q?RRE+sNPx0G8185WZFb6o59dABoj2gsbIv70ntiu3GxM7F4HmM1+h9ZDMll?=
 =?iso-8859-1?Q?jZFLtvoYHKBzWTlie3JFiGIgmRm/OcKGdatnHBqYWgsOpJ/W//974lME4L?=
 =?iso-8859-1?Q?FGQ8dfNELTzxJKwtT1EVYMaNvXm8v0Af0hpVNKZx6XMky6ObCQvAwMSEeC?=
 =?iso-8859-1?Q?bKAKzC+uJfgy//LmmXD62TtTyxc4jjdQvSIC931kDb886/WnIc3d8mr42m?=
 =?iso-8859-1?Q?al4GS3z7/Ma2Dw7s7Fan5M93AavXK6/4QDsQ5h0nLcHI+6+B5ssRucVmXE?=
 =?iso-8859-1?Q?SCd+9j+9AIEW+VoUfu6MY74sEgt/IabI9SvdP+qeRUZo625aTvaCNKpogt?=
 =?iso-8859-1?Q?UNm8r3qtHAPO1UIoiR9tfUOJKCPlhMckuDRTVSrBE6YHSjKesin2pnFLQb?=
 =?iso-8859-1?Q?7C9nrez74oqOUYHgjucbM/etf5VdQLJPq3slt1yzQiDGlxBbfcvJEcf0Db?=
 =?iso-8859-1?Q?VyW+GL+e9Kf+b8xEln0XXTYM6k0RTklCuHj/xm6KBWEEHnN0ejh4i9G22W?=
 =?iso-8859-1?Q?aNmkKAB991Hkn5ddEXoosjVm6tVQveVe2A+TNBOetqvvG8CseRgEHgaO4x?=
 =?iso-8859-1?Q?tD/Mn8N5LzoFeumKUFyKW6qpM6UNXR0F9e9e5/z1aDpVTftFfe2qVtzl35?=
 =?iso-8859-1?Q?qdFERLilt2MvuElrVgGu5Kgb9SVMnVm60HrXc46uq9ac6IsnLP/gE4bCHv?=
 =?iso-8859-1?Q?X5bOWijv5UP5Bg8UUQHyQnt4s9SwgCAgOWb6eUEoeKHYvvetesX3/KDAP0?=
 =?iso-8859-1?Q?Iwa/a98VPX/Dyuoee20K/upHQdzoE8HTlug28MZ9pXnoiI5mNjNkTrdqwI?=
 =?iso-8859-1?Q?QDyIW77QTD+yL1YUjN6W45VR6PUqN9TlGPSp6cYm7QIOetn5CKa/a4keWl?=
 =?iso-8859-1?Q?MQE9uCT1Hk2AiTt4PM7uXYXBh5DnD7dScaS+Tya04INLzzrqHVOgpz4QTG?=
 =?iso-8859-1?Q?IqGg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 493b2a7c-607f-4418-cfbf-08db9e6d1cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 15:26:07.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd615949-5bd0-4da0-ac52-28ef8d336373
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJgcD+TaS3kvGJoyMblS/ThnVtLIeEIrcUnmQCzlfRgkTBQF4Jf9NJ4jr9ZfBJtULkEFIn5610zZaxcNAHw1iZlAnPNTxHPYnpPhDdgFIxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Is the scheduling in the kernel? If so yes, it will cause a MP-DCCP not t=
o be accepted.=0A=
> If it is all done in userspace, then it leaves option for someone to rein=
vent their own open source version.=0A=
=0A=
The protocol works at the kernel level, and has a GPL scheduler and reorder=
ing which are the default algorithms. The GitHub implementation includes so=
me non-GPL schedulers and reordering algorithms used for testing, which can=
 be removed if upstreaming.=0A=
=0A=
=0A=
From: Stephen Hemminger <stephen@networkplumber.org>=0A=
Sent: 16 August 2023 16:00=0A=
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
On Wed, 16 Aug 2023 09:38:21 +0000=0A=
"Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk> wrote:=0A=
=0A=
> >As Kuniyuki noted, a relevant record of contributions to netdev would=0A=
> >help/be appreciated/customary before proposing stepping-in as=0A=
> >maintainer of some networking components.=0A=
>=0A=
> Admittedly I have minimal netdev experience, I thought helping with an un=
maintained protocol with no users would have been good experience. However,=
 if we're looking to upstream MP-DCCP then our project would no longer requ=
ire a DCCP maintainer.=0A=
>=0A=
> >IMHO solving the license concerns and move MP-DCCP upstream (in this=0A=
> >order) would be the better solution. That would allow creating the=0A=
> >contributions record mentioned above.=0A=
>=0A=
> MP-DCCP is open source under GPL-2. The scheduling and reordering algorit=
hms are proprietary, however, they are not necessary to MP-DCCP and can be =
omitted. Is that enough to solve the license concern?=0A=
=0A=
Is the scheduling in the kernel? If so yes, it will cause a MP-DCCP not to =
be accepted.=0A=
If it is all done in userspace, then it leaves option for someone to reinve=
nt their own open source version.=

