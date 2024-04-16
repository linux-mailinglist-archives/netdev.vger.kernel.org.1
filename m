Return-Path: <netdev+bounces-88229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922098A6646
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF80AB25EDC
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5B883CBA;
	Tue, 16 Apr 2024 08:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F383CAE
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256596; cv=none; b=IBJYZhDq4SJQBYbnJFqVJ1taTcn1pBBZ8KySUgbuVrNTQMMQ0GuBoj7egrjqLkFUwZpAjP1OixFAnCPZ23uteEjGI5+yrXZ5rCfHshiSYR0RGlsJwiCTVA95QmJPzKuQ7qz0WTcG6jtLW7Zp0xyEm81fD3lSTvXj2ZTpqFpeq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256596; c=relaxed/simple;
	bh=Ke39qFcW28U/I4a9/xFt1cLdP0Ly1JfX5EqWaUJgYSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ys6hnXtRqnBy8QCeWXqiRPQQwM266OdK/U5gv9ZRd9vjAfB0lsWaJ39NnK1iVH252MlYdGJ7KqYHzkRYwDMUaTeGqhLLMNTebLFV0LMof/VjAqUdhiBavS3PkVyV39cG5SLxEMb1YPP9l4vJn3zPq3q+o5j5Gahb3tmv9fYsdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-pnJDNQZEMFqH81JcPsrwSg-1; Tue, 16 Apr 2024 04:36:25 -0400
X-MC-Unique: pnJDNQZEMFqH81JcPsrwSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F1518007BA;
	Tue, 16 Apr 2024 08:36:24 +0000 (UTC)
Received: from hog (unknown [10.39.192.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE50C1121306;
	Tue, 16 Apr 2024 08:36:21 +0000 (UTC)
Date: Tue, 16 Apr 2024 10:36:16 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 1/3] xfrm: Add Direction to
 the SA in or out
Message-ID: <Zh44gO885KtSjBHC@hog>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <Zh0b3gfnr99ddaYM@hog>
 <Zh4kYUjvDtUq69-h@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zh4kYUjvDtUq69-h@Antony2201.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-16, 09:10:25 +0200, Antony Antony wrote:
> On Mon, Apr 15, 2024 at 02:21:50PM +0200, Sabrina Dubroca via Devel wrote=
:
> > 2024-04-11, 11:40:59 +0200, Antony Antony wrote:
> > > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > > index 6346690d5c69..2455a76a1cff 100644
> > > --- a/net/xfrm/xfrm_device.c
> > > +++ b/net/xfrm/xfrm_device.c
> > > @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct x=
frm_state *x,
> > >  =09=09return -EINVAL;
> > >  =09}
> > >=20
> > > +=09if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir =3D=3D XFRM_SA_D=
IR_OUT) ||
> > > +=09    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir =3D=3D XFRM_S=
A_DIR_IN)) {
> > > +=09=09NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> > > +=09=09return -EINVAL;
> > > +=09}
> >=20
> > It would be nice to set x->dir to match the flag, but then I guess the
> > validation in xfrm_state_update would fail if userspaces tries an
> > update without providing XFRMA_SA_DIR. (or not because we already went
> > through this code by the time we get to xfrm_state_update?)
>=20
> this code already executed from xfrm_state_construct.
> We could set the in flag in xuo when x->dir =3D=3D XFRM_SA_DIR_IN, let me=
 think=20
> again.  May be we can do that later:)

I mean setting x->dir, not setting xuo, ie adding something like this
to xfrm_dev_state_add:

    x->dir =3D xuo->flags & XFRM_OFFLOAD_INBOUND ? XFRM_SA_DIR_IN : XFRM_SA=
_DIR_OUT;

xuo will already be set correctly when we're using offload, and won't
be present if we're not.


> > > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > > index 810b520493f3..df141edbe8d1 100644
> > > --- a/net/xfrm/xfrm_user.c
> > > +++ b/net/xfrm/xfrm_user.c
> > > +=09=09=09return -EINVAL;
> > > +=09=09}
> > > +
> > > +=09=09if (x->replay_esn) {
> > > +=09=09=09if (x->replay_esn->replay_window > 1) {
> > > +=09=09=09=09NL_SET_ERR_MSG(extack,
> > > +=09=09=09=09=09       "Replay window should be 1 for OUT SA with ESN=
");
> >=20
> > I don't think that we should introduce something we know doesn't make
> > sense (replay window =3D 1 on output). It will be API and we won't be
> > able to fix it up later. We get a chance to make things nice and
> > reasonable with this new attribute, let's not waste it.
> >
> > As I said, AFAICT replay_esn->replay_window isn't used on output, so
> > unless I missed something, it should just be a matter of changing the
> > validation. The additional checks in this version should guarantee we
> > don't have dir=3D=3DOUT SAs in the packet input path, so this should wo=
rk.
>=20
> I agree. Your message and Steffen's message helped me figure out,
> how to allow replay-window zero for output SA;
> It is in v11.

Nice, thanks.

> > [...]
> > >  static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
> > >  =09=09       struct nlattr **attrs, struct netlink_ext_ack *extack)
> > >  {
> > > @@ -796,6 +881,16 @@ static int xfrm_add_sa(struct sk_buff *skb, stru=
ct nlmsghdr *nlh,
> > >  =09if (!x)
> > >  =09=09return err;
> > >=20
> > > +=09if (x->dir) {
> > > +=09=09err =3D verify_sa_dir(x, extack);
> > > +=09=09if (err) {
> > > +=09=09=09x->km.state =3D XFRM_STATE_DEAD;
> > > +=09=09=09xfrm_dev_state_delete(x);
> > > +=09=09=09xfrm_state_put(x);
> > > +=09=09=09return err;
> >=20
> > That's not very nice. We're creating a state and just throwing it away
> > immediately. How hard would it be to validate all that directly from
> > verify_newsa_info instead?
>=20
> Your proposal would introduce redundant code, requiring accessing attribu=
tes=20
> in verify_newsa_info() and other functions.
>=20
> The way I propsed, a state x,  xfrm_state, is created but it remains=20
> km.stae=3DXFRM_STATE_VOID.
> Newely added verify is before auditing and generating new genid changes,=
=20
> xfrm_state_add() or xfrm_state_update() would be called later. So deletei=
ng=20
> a state just after xfrm_staet_constructi() is not  bad!
>=20
> So I think the current code is cleaner, avoiding the need redundant code =
in=20
> verify_newsa_info().

Avoids a few easy accesses to the netlink attributes, but allocating a
state and all its associated info just to throw it away almost
immediately is not "cleaner" IMO.


> > And as we discussed, I'd really like XFRMA_SA_DIR to be rejected in
> > commands that don't use its value.
>=20
> I still don't see how to add such a check to about 20 functions. A burte=
=20
> force method would be 18-20 times copy code bellow, with different extack=
=20
> message.

Yes, I think with the current netlink infrastructure and a single
shared policy for all netlink message types, that's what we have to
do. Doing it in the netlink core (or with help of the netlink core)
seems difficult, as only the caller (xfrm_user) has all the
information about which attributes are acceptable with each message
type.

> +++ b/net/xfrm/xfrm_user.c
> @@ -957,6 +957,11 @@ static int xfrm_del_sa(struct sk_buff *skb, struct n=
lmsghdr *nlh,
>         struct km_event c;
>         struct xfrm_usersa_id *p =3D nlmsg_data(nlh);
>=20
> +       if (attrs[XFRMA_SA_DIR]) {
> +               NL_SET_ERR_MSG(extack, "Delete should not have dir attrib=
ute set");
> +               return -ESRCH;
> +       }
> +
>=20
> I am still trying to figure out netlink examples, including the ones you=
=20
> pointed out : rtnl_valid_dump_net_req, rtnl_net_valid_getid_req.

These do pretty much what you wrote.

> I wonder if there is a way to specifiy rejeced attributes per method.
>
> may be there is  way to call nlmsg_parse_deprecated_strict()
> with .type =3D NLA_REJECT.

For that, we'd have to separate the policies for each netlink
command. Otherwise NLA_REJECT will reject the SA_DIR attribute for all
commands, which is not what we want.

> And also this looks like a general cleanup up to me. I wonder how Steffen=
=20
> would add such a check for the upcoming PCPU attribute! Should that be=20
> prohibited DELSA or XFRM_MSG_FLUSHSA or DELSA?

IMO, new attributes should be rejected in any handler that doesn't use
them. That's not a general cleanup because it's a new attribute, and
the goal is to allow us to decide later if we want to use that
attribute in DELSA etc. Maybe in one year, we want to make DELSA able
to match on SA_DIR. If we don't reject SA_DIR from DELSA now, we won't
be able to do that. That's why I'm insisting on this.

--=20
Sabrina


