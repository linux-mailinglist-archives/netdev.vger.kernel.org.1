Return-Path: <netdev+bounces-36991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670DA7B2D8D
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 10:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 847411C2074D
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5FD312;
	Fri, 29 Sep 2023 08:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5781C3F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 08:10:18 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B81A8
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 01:10:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-V-eKdlGtNjCLQJKswWmyoQ-1; Fri, 29 Sep 2023 09:10:02 +0100
X-MC-Unique: V-eKdlGtNjCLQJKswWmyoQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 09:10:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Sep 2023 09:10:00 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'joao@overdrivepizza.com'" <joao@overdrivepizza.com>,
	"pablo@netfilter.org" <pablo@netfilter.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kadlec@netfilter.org" <kadlec@netfilter.org>, "fw@strlen.de"
	<fw@strlen.de>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"rkannoth@marvell.com" <rkannoth@marvell.com>, "wojciech.drewek@intel.com"
	<wojciech.drewek@intel.com>, "steen.hegenlund@microhip.com"
	<steen.hegenlund@microhip.com>, "keescook@chromium.org"
	<keescook@chromium.org>, Joao Moreira <joao.moreira@intel.com>
Subject: RE: [PATCH v2 2/2] Make num_actions unsigned
Thread-Topic: [PATCH v2 2/2] Make num_actions unsigned
Thread-Index: AQHZ8ObIeUWAs73e2U+3ivRy5uEH5bAxdYzQ
Date: Fri, 29 Sep 2023 08:10:00 +0000
Message-ID: <09695e42dfaf4dfe9457aa814fef297e@AcuMS.aculab.com>
References: <20230927020221.85292-1-joao@overdrivepizza.com>
 <20230927020221.85292-3-joao@overdrivepizza.com>
In-Reply-To: <20230927020221.85292-3-joao@overdrivepizza.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: joao@overdrivepizza.com
> Sent: 27 September 2023 03:02
>=20
> From: Joao Moreira <joao.moreira@intel.com>
>=20
> Currently, in nft_flow_rule_create function, num_actions is a signed
> integer. Yet, it is processed within a loop which increments its
> value. To prevent an overflow from occurring, make it unsigned and
> also check if it reaches UINT_MAX when being incremented.
>=20
> After checking with maintainers, it was mentioned that front-end will
> cap the num_actions value and that it is not possible to reach such
> condition for an overflow. Yet, for correctness, it is still better to
> fix this.
>=20
> This issue was observed by the commit author while reviewing a write-up
> regarding a CVE within the same subsystem [1].
>=20
> 1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/
>=20
> Signed-off-by: Joao Moreira <joao.moreira@intel.com>
> ---
>  net/netfilter/nf_tables_offload.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_=
offload.c
> index 12ab78fa5d84..d25088791a74 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -90,7 +90,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *=
net,
>  {
>  =09struct nft_offload_ctx *ctx;
>  =09struct nft_flow_rule *flow;
> -=09int num_actions =3D 0, err;
> +=09unsigned int num_actions =3D 0;
> +=09int err;
>  =09struct nft_expr *expr;
>=20
>  =09expr =3D nft_expr_first(rule);
> @@ -99,6 +100,9 @@ struct nft_flow_rule *nft_flow_rule_create(struct net =
*net,
>  =09=09    expr->ops->offload_action(expr))
>  =09=09=09num_actions++;
>=20
> +=09=09if (num_actions =3D=3D UINT_MAX)
> +=09=09=09return ERR_PTR(-ENOMEM);
> +
>  =09=09expr =3D nft_expr_next(expr);

The code is going to 'crash and burn' well before the counter
can possibly overflow.

nft_expr_next() is ((void *)expr) + expr->ops->size;

It is far more likely that has got setup wrong than the
count is too big.=20

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


