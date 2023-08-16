Return-Path: <netdev+bounces-27998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191877DD6F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C241B1C20DBF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D1DF6C;
	Wed, 16 Aug 2023 09:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E0C2DF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:38:33 +0000 (UTC)
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2095.outbound.protection.outlook.com [40.107.11.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2826A4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf6V7FTR38/k4qx7xxtfiumTIqEkI0fUd9YKrqp3/r324JvK66v6Lc1Q0536gY8Z2uhiDrc2kmIVEzqsqtHS5uvGwHFo30Vu89VSSJXzIJU/RoQL4CdQOKkFW/impB9I94j3T60RGFW9uVMYnrjPNGOgeCPKN6Z8d/6upaFLL75yMsgi9uKi6AFJoEEg1gNV91ldx6BDoPoUl+0ZGi4vYMNMSd96mwLzSzizUJcwT7A0g5h1NT/DZePKh6KoY+tvYNS1ho6UVyoYLB2h+IbpvRZ5GyQMoxWBAXRiexMLWnKlkGNVYz7/FNmhaxBW/2Bl4OffYfWKP4TImv3st1DdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qawhSLDQvkRYQ/mv4Mc1LlHRSNChSebzkae/qKKGMdo=;
 b=PRu6e+hdhsKvPlvgkei7pVW8jLVrcbbol/z4SvUbrYQLNLt0KhcMgTvuJOE1fKqZOgQoKPtztbRZiJEO2bI9I7VCa+2Bi3/bBr2SOh87P9pWeV69+2OZUTAHcB26eHzhbFq1+dnXSFKF8LGe0fXRkctmoYeWrL/G0zxeFi07gG4XQhaOA2h9baL4riI/kObgoEgVQlnYITLvv/IN2QDvOMIC46KsnvEJjP2/+O63UiO4x55ZmqnmOzebkusItIthignZ2ociGu6KMpd8qbRGdI4aEHtjRJtKDBDk3RMs8qZOTTF4wS8f+F0ljogdtslc/pwaikEyeftFVhtxtoowQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=city.ac.uk; dmarc=pass action=none header.from=city.ac.uk;
 dkim=pass header.d=city.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=city.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qawhSLDQvkRYQ/mv4Mc1LlHRSNChSebzkae/qKKGMdo=;
 b=LrMEti4ZjGXE0y0z7zIVQyhZF0jJWvKRnVxopf+pX4Ephw5Wix+uUo+rmRhguedEJmOkltL5povW1ZOLKd7tLVVdjWgrIjsMelVSwpXRW3wPdfl49QdA+sOTVDwM1hIcfKDxtoqJza1IdnRqRXvphy+jV0lgHSjFwj5Ib7OgLZO+8ZkWanOqPuZ0yMGN6gsFRZH+MudFbudoQOB5iuBQ9xvlWI+YyQa7lQ3PRuXzTwJrkjlE3FSb1Q/Hbgy+VF6dS1Cq9wcB9fODkUx7dsRYD1BAG+4DgUTnVyRJJ14yw7o6qm7os4I58yhnw2AYmVTb+YqoDx9YIr+cf/QgpP8gBw==
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::6)
 by LOYP265MB1871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 09:38:21 +0000
Received: from CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d]) by CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2dd7:2a0a:99f8:5a0d%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 09:38:21 +0000
From: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
To: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, "Rakocevic, Veselin"
	<Veselin.Rakocevic.1@city.ac.uk>, "Markus.Amend@telekom.de"
	<Markus.Amend@telekom.de>, "nathalie.romo-moreno@telekom.de"
	<nathalie.romo-moreno@telekom.de>
Subject: Re: DCCP Deprecation
Thread-Topic: DCCP Deprecation
Thread-Index: AQHZsyaN7TZv6xK98EGiSIL1O2/QRK+zUMeAgAAj8gCAAND+cYAAErwAgDh/to0=
Date: Wed, 16 Aug 2023 09:38:21 +0000
Message-ID:
 <CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References:
 <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	 <20230710182253.81446-1-kuniyu@amazon.com>
	 <20230710133132.7c6ada3a@hermes.local>
	 <CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
 <0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
In-Reply-To: <0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=city.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB6449:EE_|LOYP265MB1871:EE_
x-ms-office365-filtering-correlation-id: de775f30-7408-44df-148b-08db9e3c87df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iC10LJf6s+OD2C53ErXQnZ+M2vuCEc3igu03oH+mz7WGQFQ5TW4L5/WsSmjbn88IN6TilTD4tcbrvGY+wakNHZ1wl2AsTszdpIZDkrBirJ8JdAZpnPdG+vhSUrMKuQ6dYkY3fjxRDCgiEqBWU1J8q+mI9n5V49p7V4mEf6qqPiu8rcGQt9MEH03uRFkO8lxsvqnjkF7Q1nOCt/4+ArOACyrivOBdKcbYv6jJKo7uvE627l3MG0z7481BTifHAH+oXQMaG1KgKRlZHAOn5T3yZL8GgYiBJ/L/FNPkY6DnuJ2L8z4xXaU4StOq7WmkWlhY/AtWm3Bo8oUYmVaYJHWmfVr82xa6X+T7uzbuI59JfdINLHDVpfupvG+ieIYm1Hx0Lgy6UCxi72f7/xlsEUW/5BLq7+MwkyQNBK3SG+xseNRM5aT8GNWVBYqFsEM14tE7PpNG8KvrRU8R+Wx0UmW1MURC1E7K7i+eyy7mFRi+Oyt62IXXPf3cBRWyl02/omA9xt8XJTSix6VsDCP1lqGo+NfTacPt5RsV+MlhH9kHdB3KxMN6/VYgA/0Oap1JyitMoKsngKuQL+I2z6KVG32WstOVxQvF1Prpuhi8SUAxvi4ramKYz9dloJqnZX3r9Ynr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(7696005)(6506007)(71200400001)(33656002)(9686003)(53546011)(26005)(55016003)(3480700007)(5660300002)(52536014)(41300700001)(7116003)(122000001)(786003)(316002)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(110136005)(91956017)(76116006)(4326008)(8676002)(8936002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y51icAcHnJZmUNwgeLPi5/T0ggoRUIkFKWgN/qrSsWgkhN0oc4NjDnAHp3?=
 =?iso-8859-1?Q?CQkJ0KYKDg1GoaZ+PzZyYcj62ekc+QSo81xS3bXC/LJmepirQ7VZhLut54?=
 =?iso-8859-1?Q?vRDA7lou/lxt/z1fa71989FUy/IuGMM6J/2cnqd+nTWqMu9ep8lIwhlLdx?=
 =?iso-8859-1?Q?jpVWri2t9LbJiIYlRrpbaKZeW2xcTTxBz5HdWNeyv5PgxifFfSf1x3I840?=
 =?iso-8859-1?Q?DUGPb1PcD/GFH8fX9Q+NjW0ixqt1pTBSDfXqB6aG5UitVgYPBtHMkaLt4o?=
 =?iso-8859-1?Q?UHhRzgOOBtfZsKJJWr4GYiUQP1bGydK3Un9552aqwmkNx6tj54IKyYIlMG?=
 =?iso-8859-1?Q?RlILMIapRMohI9VM98UI5gHfkSvnPMSOLjn1O2W0T/asjGZpdP9K4MPQn6?=
 =?iso-8859-1?Q?jj5BLEZIAwsyuPBU1CbR8ldKgfANcPFRjotWLNsMhAXW4PFbR/BrhKOmKv?=
 =?iso-8859-1?Q?nnwOCgWW1PVrHcNjOOTfajhCp6yByViidoTF4gabjtFhyi8JggajYUQ8uC?=
 =?iso-8859-1?Q?Z/nDVkd8cXjSZFWrKvXMIRuLE+abJTicc8nsReC1iNRSiuShKUQAO2dT1X?=
 =?iso-8859-1?Q?jP8NxwsC1AD7Q9AiIoJYpGYqY///1KYdsTsC66sX/qBsY2UFVNITpIs9R7?=
 =?iso-8859-1?Q?WPbyYOsdIGlI0n1YA8GUdxgNU0bXQC/TRa1bYRpXpWUDwCA3SeqKeH1zqk?=
 =?iso-8859-1?Q?4mDUwCMHRmYpOnNeQv9OEGem54H/9K96f2i4PUY41tvtxdwvNQCPkIoGAp?=
 =?iso-8859-1?Q?edDwjTRl//OdsYxD8IMl8n62xNExWDJ6Ef4+F9WPjKRbfC89sqo9eZxVU8?=
 =?iso-8859-1?Q?WMsHQrbBgxooevMVsdVAbejzt/eVx2u0L9FTuL1nHf6gttEhzXmP1DZN9B?=
 =?iso-8859-1?Q?BQr2onePFYLxE/2xEjOgzQ1mS5Qk3b53olMebnmNe0CdH+c1FChTutTmTb?=
 =?iso-8859-1?Q?b6nP+UUpMtNmt+rEFLQ9MYkG6ljuJtpEYHZx1TKJhZFGUF1wjO18DxzZSb?=
 =?iso-8859-1?Q?5MHTM8kJgDAVEPGQj+AH7erGfObLQc2JC77MinWyqc2weGslT/NB9Vshpe?=
 =?iso-8859-1?Q?6Eu+UyuhekBsvP0LdihARr9Jn2K+1KQ/VpgytHbzcbHu0meT+gOWQBPdrw?=
 =?iso-8859-1?Q?IIbCi3O69zyXMYs93tVwQI+zJUdKzju/v6SDuswUfxv2kfdUAphATUCjZP?=
 =?iso-8859-1?Q?vuBWw2mvhlsNNHuvUkZIvksykVwQGf78cZYtU6ufQsTjlomPmhO2aW7gBM?=
 =?iso-8859-1?Q?6mo+APqtTJekbVkPQaxOQhAsDcyr2oG4UWOHYr9f80z7QWdtiLLEtfiS8b?=
 =?iso-8859-1?Q?I95xV6davwyfGl1729l/padszq61kYq5oH/wIyPOW0M3UOlzt6KTYJNI5P?=
 =?iso-8859-1?Q?TT+hOAIKLX6GH/uad9Q2cXyN+nz18wKIlYNX4mgRBOTmnZDFBFk3PPWUfI?=
 =?iso-8859-1?Q?PxcxiDZGf2aJqUaQHoJ+p00Q4TBE74UDxGbqxVe6FGCouX0lDJYTJTez3m?=
 =?iso-8859-1?Q?KrA6nF4mjjVi/UiqX9Giy0wzXxzJFv+QSMPhDH4/DR4r6A2WW/Z2fm940S?=
 =?iso-8859-1?Q?zi7peFnfyufRNgf4kMuqeflBksjxpY4IEO7Fpj/PUs/22lV8UZaLz5JGbB?=
 =?iso-8859-1?Q?LvIuyD3ueh/2rrJ2URYL69OEamNisQds1Y4JEkkJMz/TFDFmDIAswozw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de775f30-7408-44df-148b-08db9e3c87df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 09:38:21.7479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd615949-5bd0-4da0-ac52-28ef8d336373
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVZ4nNWEVnWEO8kb5zpaO5MY6vGJDdlW63TeSGyKoIlcYzpsitM4a2iBWzbvpJ0vLUPKtKf2TffRy8YTDsXD7LNnRQ1FCNEXcaQyEvpB0sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>As Kuniyuki noted, a relevant record of contributions to netdev would=0A=
>help/be appreciated/customary before proposing stepping-in as=0A=
>maintainer of some networking components.=0A=
=0A=
Admittedly I have minimal netdev experience, I thought helping with an unma=
intained protocol with no users would have been good experience. However, i=
f we're looking to upstream MP-DCCP then our project would no longer requir=
e a DCCP maintainer.=0A=
=0A=
>IMHO solving the license concerns and move MP-DCCP upstream (in this=0A=
>order) would be the better solution. That would allow creating the=0A=
>contributions record mentioned above.=0A=
=0A=
MP-DCCP is open source under GPL-2. The scheduling and reordering algorithm=
s are proprietary, however, they are not necessary to MP-DCCP and can be om=
itted. Is that enough to solve the license concern? =0A=
=0A=
=0A=
From: Paolo Abeni <pabeni@redhat.com>=0A=
Sent: 11 July 2023 11:06=0A=
To: Maglione, Gregorio <Gregorio.Maglione@city.ac.uk>; Kuniyuki Iwashima <k=
uniyu@amazon.com>; Jakub Kicinski <kuba@kernel.org>=0A=
Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.co=
m>; Florian Westphal <fw@strlen.de>; netdev@vger.kernel.org <netdev@vger.ke=
rnel.org>; Stephen Hemminger <stephen@networkplumber.org>; Rakocevic, Vesel=
in <Veselin.Rakocevic.1@city.ac.uk>; Markus.Amend@telekom.de <Markus.Amend@=
telekom.de>; nathalie.romo-moreno@telekom.de <nathalie.romo-moreno@telekom.=
de>=0A=
Subject: Re: DCCP Deprecation =0A=
=A0=0A=
CAUTION: This email originated from outside of the organisation. Do not cli=
ck links or open attachments unless you recognise the sender and believe th=
e content to be safe.=0A=
=0A=
=0A=
Hi,=0A=
=0A=
Please send plain text messages, and do proper quoting.=0A=
=0A=
On Tue, 2023-07-11 at 09:31 +0000, Maglione, Gregorio wrote:=0A=
> The IETF marks MP-DCCP as EXP and is set to mark is as PS soon.=0A=
> Removing DCCP from the kernel would likely impact PS standardisation=0A=
> or better. If the reason for removal is the lack of a maintainers,=0A=
> then I have sufficient time for bug fixing and syzbot testing.=0A=
=0A=
As Kuniyuki noted, a relevant record of contributions to netdev would=0A=
help/be appreciated/customary before proposing stepping-in as=0A=
maintainer of some networking components.=0A=
=0A=
> If, as Jakub suggests, DCCP has no users other than MP-DCCP, and as=0A=
> such shouldn't be maintained,=0A=
=0A=
FWIW, I agree that in kernel user would help DCCP "de-deprecation"=0A=
=0A=
> then are you suggesting that we investigate this license concern to=0A=
> allow for MP-DCCP to move upstream, or did you have a patch in mind?=0A=
=0A=
IMHO solving the license concerns and move MP-DCCP upstream (in this=0A=
order) would be the better solution. That would allow creating the=0A=
contributions record mentioned above.=0A=
=0A=
FTR MPTCP is already there, perhaps there is some possible convergence=0A=
between the 2 protocols.=0A=
=0A=
Cheers,=0A=
=0A=
Paolo=0A=

