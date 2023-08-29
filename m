Return-Path: <netdev+bounces-31288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390E78C86C
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA45D28121D
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17217AB8;
	Tue, 29 Aug 2023 15:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710E16404
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 15:17:14 +0000 (UTC)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2131.outbound.protection.outlook.com [40.107.121.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4EDBD
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 08:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz7z2VbgeH1q/HW1nmhKxzCcR0yVHEMqxOmR651/KrIP1AAnGxKu86O5PTeEwBMIzNzCn+6frVVSfTVYY9K2bfE0PwUn7hk4VOBNn7uyZhRqVpjhWSg4c6PTYo39MBJwrucYWFwcvw83yKLtQCc/iXbYXGRj8Eh5kxhNeuqkUw7AzUn5kk9P9PuGf8+NhdgTUziJTj6tNhtbnbWoUru0voSE49pHxJyTLGY6jF019ZPLWk84IvFOngf8SCZu4QaQ/nnOMLDyY4hfnr8c2SssoQ5t9FpnVejE8JpXifQhcbFSajFN7Oo8oVVE4EjVn+f5BDELKaOX7bVTyX8eQ+amrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V+2gJffgrCEEdwJmyZXw2fCIdjqzFixXOv8s+oB93U=;
 b=l/bBz4b6nSTaS+T7a7qvQwedEZyy7zIaKjOcH4LPK5suEGBOAqqzRrylMBnr4HvxSS+Tiymv0GFNSQ0tRTJ7g3KbeHdfzZd4sjh9SpJ4mr6qU7dGj9B979m7XMyubl65p2OJAP39hXSfIlZq1rHIrt6FIl7FxRxPppTR6kqcClJeqWJIKdLt8lDTxlk1T/rHCr3oymUDxymhH7yAMQlUQMXj4S1okugqWpfAlcUlRG1ngF2MK+MIiV5cSlhoTfN5qA+NGSwFTDDMlocR4P+m5sWQesmvXJf+TQTs73yVnQV/qeij8qKcKPUiJAoi3smPO3SGNhgbfdvHYvZk+DFk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=city.ac.uk; dmarc=pass action=none header.from=city.ac.uk;
 dkim=pass header.d=city.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=city.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V+2gJffgrCEEdwJmyZXw2fCIdjqzFixXOv8s+oB93U=;
 b=KoQt1hoKlLkvpW7qtdqk07XUuOZ1lz1C+4C83hWKXurWw618qOavmLustu4s2XrkK3/d7VxbbJe288TWzidxHBtVWXMr8CvNFE1TVrbHjS5QUtsewAoliuwJVFHpikvdSMdgAcTUsGUyiAcb/2m6J+VZGmpi1+BME1b+CUZqkpt8jW6X5bZ9aDtOGwHJXNNib++acixdxScmbik8hBkoFcrt+9JHC2bzrA/Gyg1G47V6ypjxX+ckzKGvCSY9MGNrt5hHBjtRNp/5EzJUQmEnV9YOhnHP+M0Loifpuw6UGTdaX0O15BeGWCaMXzrn4nSUaprGttt50PGN08QuEllJEw==
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::6)
 by CWLP265MB5867.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 15:17:08 +0000
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d]) by CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 15:17:08 +0000
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
 AQHZsyaN7TZv6xK98EGiSIL1O2/QRK+zUMeAgAAj8gCAAND+cYAAErwAgDh/to2AAGYxAIAABfPKgAAf/YCAAp5C1YAAdvKAgBExn/k=
Date: Tue, 29 Aug 2023 15:17:08 +0000
Message-ID:
 <CWLP265MB64494218BFFF89EFB445543EC9E7A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
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
	<CWLP265MB6449B1A1718B6D8CD3EBFB27C91BA@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
 <20230818092027.1542c503@hermes.local>
In-Reply-To: <20230818092027.1542c503@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=city.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB6449:EE_|CWLP265MB5867:EE_
x-ms-office365-filtering-correlation-id: f78c48af-c622-4c4d-7265-08dba8a3030b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H7k9GBjQXkqBqifhEqz/B4a9KXsrOyZNPZg3wiz3PTzmpx2sXrcFscjusIvS+DFv2e7LkMyXrDNKaGSbMNdgW3HvO4jz/FuvsJtFhjvgiP1qMUydl2UHieZNTHf9+RQSwOAFsr9YBIFyjWgnnZBKz5vL8P55Ic4F0A931JSq6BGsGEQEY+0Whuy0lDWvbj6pf08wdYtQtJFBMaFWCx+xQbB91bsyyIi/oG6Vu4Fb0sz3h9YXRjddk/upL9Lzd21V5mpriyQRg6JyDhm8q02LdgS9mPagPXs27UFfeudCFJU629q5EieefWSOS16VEhsa7EqI6AWdjyb+Eby99lbppz/RY/Xdop/02GsKmuFMCrk8IqF/hwgKOio2HA7jgy3gJRqleF/J5dcbgnFG93VSDrkyOIoeoTo/mZoigZwMo9E0t6fqalu0Fs9luEaGQEsPo0hxr/40zQUx22xRHagV0P5T+wkQb8uq73o9VR3VX8PmUHDcfnZCBHVM/hIYl9rqNgAMiFdqMFkFiRfHdl1s9a8geuwkFY6njzfEOuW0xXPTcEDlqDEZWbvgNrp7nZSxJ+CsPb+C0aQnA2800UyWWhiTk4h0Y4wgom9v/R/n/JY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(1800799009)(186009)(451199024)(9686003)(71200400001)(7696005)(6506007)(53546011)(478600001)(76116006)(83380400001)(26005)(2906002)(7416002)(6916009)(786003)(316002)(64756008)(66446008)(54906003)(7116003)(66476007)(66556008)(91956017)(66946007)(52536014)(8936002)(41300700001)(5660300002)(8676002)(4326008)(122000001)(33656002)(3480700007)(55016003)(38100700002)(38070700005)(86362001)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AgIt3UqWysr12l+srqEM0hJemjo/75e11a0UcmYJB7KOW6y59aST8LeLre?=
 =?iso-8859-1?Q?0VnNdSjA+g9ehRjeQ2gThfwCkEP59MBfEeAcC8aozXM/0NXDIsw6Sm+nI4?=
 =?iso-8859-1?Q?kdn1pJ3pf9Qv0/PbLPVqtM6lRUh0d302ogc9AXcF5pEeqZ7EqnbD2TaDQm?=
 =?iso-8859-1?Q?aaTmC+h7cmll2trlXoH2ZwKq64VaAiErdn4wj1Q8Sgyb9XoqwKTSofD+Q0?=
 =?iso-8859-1?Q?P2o978yjKZ4pddrI4H1sheRvBl9tMNH9Dx81KUIDwBngI+NXCwSIrFt7z6?=
 =?iso-8859-1?Q?kUfRgJHM0grCVOIGfHBYx5Gvp9u4JV/3oYJElxNHSsT4OuKd/UqQTCid4E?=
 =?iso-8859-1?Q?qyOMX4E5OaNbB+qYNV9hddWiqgh6G9eMF42MHu3mCktlOhnbnuiSaJWKI4?=
 =?iso-8859-1?Q?HL+OHAC0Oko2qZddabsF3sOsIKhqi7Rs6y10ckdsrh1e4FtGYWX9BiHBTQ?=
 =?iso-8859-1?Q?CWNmZF80DPsfrR1+zT7Z8Q2nLGxDYGdk9kg8YxT4I7irBZ90tAIg2NhUzC?=
 =?iso-8859-1?Q?iSrNcYmZQmO3N4uJ5wU9mzlXW5R1VotSBfh81UoW0QoY6AtGvD3VubCUr7?=
 =?iso-8859-1?Q?eDtwv7VysJbS6FNaeQvwd4l02A27RIbdlEsYd0Jx3/5wHpcUUvzDuG8KWT?=
 =?iso-8859-1?Q?djdxixAyKW71mV9FCkhjaGdDz0F5ttSLMmasrkmrw2Zt2aCM7Fgp18ZK33?=
 =?iso-8859-1?Q?3ED8oF6N+YJ8FxPnCpfO8ilpgn/C8rhBcZBLo43r6reFGTtZGp+oeaaszM?=
 =?iso-8859-1?Q?0tOSqCN8nJA4aHjRdvvGqSkMuGu4XwdJVPaDO6JPKAr+F03E4586ZC3sN3?=
 =?iso-8859-1?Q?YaLOhlxK1ddFX0TUpsAe6GWalXRhNeUBQyXdRMHYYc/bXCNhXBXqDWZ+t+?=
 =?iso-8859-1?Q?zTXEt/P5NsuDHizvo/iSeKbCd+4WMaaufSyjWsQuQHCiSlMBchwvuYM+Ad?=
 =?iso-8859-1?Q?G1e6UoJqS1IQeKY/SbjmJmEMyaUSBVs6ZPBs1v1sfrO32qy6qYqO6Yoww6?=
 =?iso-8859-1?Q?fhIkI+P3qu0lWtR7RaUDPpOQo9HraDdYlwfZJdrUK3IzzDOLpOOX4Bkq/V?=
 =?iso-8859-1?Q?pSAqgmvmUPBV1Z4cxIBM7gCkmSIByvBHDcxhmL1YwNzfa53Q9hmwdSebpc?=
 =?iso-8859-1?Q?Ib643akAvnbfFx33+2WXbKDnJChjB+csqBdr7yj4SppYnSfYMs96+qEz5O?=
 =?iso-8859-1?Q?5xi4t6AO6B9DjcUOeSR5nrIOOFVy3i8bmZSUrH9WONO0mBPEW5BjJ6lIYo?=
 =?iso-8859-1?Q?PZdzwiSRKiTWpIFCrv8J0X0Ht+yJ2HRXjBh8ZFNDaxmRp7skIMg5CgDH9o?=
 =?iso-8859-1?Q?n5qfRCK567JvFM4daGhh3auRStr0BdIpPIXzyAWnskld/ucPrcFX38o1LM?=
 =?iso-8859-1?Q?L/dNCWhCmCzW0YpOKyaoOma19ogZ/FpgXWvx7ZceNZglndKx6j1RK1h/xm?=
 =?iso-8859-1?Q?fqcpluaqNhjboE5osOyTqAFurwKmGjEYONvMvBwxsFGVSyXFhpmxLisPji?=
 =?iso-8859-1?Q?94D6XKWouhGrWoX4Io+wyxGawJpnM3wOxwHmRSQqsSvJXKPWwpABSDYKsU?=
 =?iso-8859-1?Q?/KdXG6VfE0d+Uql418qa7rHt/WyemCwnZYvdugWVesu0u5QKQL+2z2AjYM?=
 =?iso-8859-1?Q?0++KH4haTUBgSwdBQVoGF1MzLKiiZb/X+9B8MEISeJQhRl5RW/rvOpWw?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f78c48af-c622-4c4d-7265-08dba8a3030b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 15:17:08.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd615949-5bd0-4da0-ac52-28ef8d336373
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: np8pp6cRryVIfIZIkLhHJ02uktoxHk1LcQn18hh1KeSp6SNQnNZ/CntwUrrXDbpUtD7QFHqRR43DorPk2phFmwJE6Pz+G7/vWTsC/0nhD+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Yes, the implementation needs to be aligned with the legal license requir=
ements.=0A=
> It might not be the ideal solution but any mix of GPL and non-GPL compone=
nts needs=0A=
> to stay with in the legal constraints.=0A=
=0A=
For the purpose of upstreaming, the repository was forked [https://github.c=
om/GREGORIO-M/mp-dccp] to remove non-GPL components and to update the licen=
se to show GPL-2.0. Is this enough to solve the license issue? If so, is it=
 still agreeable for us to upstream and maintain MP-DCCP, so that, once DCC=
P deprecates, MP-DCCP becomes the sole DCCP enabler in the kernel? What ste=
ps would the upstreaming involve? Do you require any information about the =
MP?=0A=
=0A=
From: Stephen Hemminger <stephen@networkplumber.org>=0A=
Sent: 18 August 2023 17:20=0A=
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
On Fri, 18 Aug 2023 09:35:02 +0000=0A=
"Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk> wrote:=0A=
=0A=
> > > The protocol works at the kernel level, and has a GPL scheduler and r=
eordering which are the default algorithms. The GitHub implementation inclu=
des some non-GPL schedulers and reordering algorithms used for testing, whi=
ch can be removed if upstreaming.=0A=
> >IANAL=0A=
> >=0A=
> >The implementation I looked at on github was in IMHO a GPL violation bec=
ause it linked GPL=0A=
> and non GPL code into a single module. That makes it a derived work.=0A=
> >=0A=
> >If you put non-GPL scheduler into userspace, not a problem.=0A=
> >=0A=
> >If you put non-GPL scheduler into a different kernel module, according t=
o precedent=0A=
> set by filesystems and other drivers; then it would be allowed.=A0 BUT yo=
u would need=0A=
> to only use exported API's not marked GPL.=A0 And adding new EXPORT_SYMBO=
L() only=0A=
> used by non-GPL code would get rejected. Kernel developers are openly hos=
tile to non-GPL=0A=
> code and would want any export symbols to be EXPORT_SYMBOL_GPL.=0A=
>=0A=
> I see, the problem centres around the implementation rather than the prot=
ocol, as the protocol itself does not need these non-GPL components. So, wo=
uld another option to the ones you've already suggested be that of creating=
 a repository without the non-GPL components, and consider only that for pu=
rposes of upstreaming?=0A=
=0A=
Yes, the implementation needs to be aligned with the legal license requirem=
ents.=0A=
It might not be the ideal solution but any mix of GPL and non-GPL component=
s needs=0A=
to stay with in the legal constraints.=

