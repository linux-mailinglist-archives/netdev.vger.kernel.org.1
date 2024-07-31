Return-Path: <netdev+bounces-114633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0939434D3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C681B2428B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D01BD4FE;
	Wed, 31 Jul 2024 17:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8281BC065
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445924; cv=none; b=SBHMtl3KMfksuasBxuLEiEbWUO1L3xcmUWnCWQXwuyCfjDX4q4ipe2B6o7Kyqn9cr5kIbPh9sRNWI6n1U3LwxWWuvomCSUlrcUlbe6jCUxlIbZQtYq+ILDuwW8lGCHK4A+rnlXCM+nIFbjMJk9XVsgHYwkkqNUY3iuEMcOxJJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445924; c=relaxed/simple;
	bh=C+IfCW7zU1DmYobnFVqdAzVw94QfgfE22ecn9Qjmzqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EpGHaLjrP2XFf+VZVO+77jHjrvZHEmJdAtufD5XZIds263HjYdkrxgz4zbMBANsjLyLrgLV8Sx3TkBmH099Ff49whMe2qcNvi9q9DGmwc5DOMx0Q7MSMyxO1yMLee+umQDswuioxFe8VCXIeahQYH9lWnugm8AyIhCDsldQ6gVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-ZM_ZAE1jOqqMVVa6i-34Yw-1; Wed,
 31 Jul 2024 13:10:39 -0400
X-MC-Unique: ZM_ZAE1jOqqMVVa6i-34Yw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76E481956088;
	Wed, 31 Jul 2024 17:10:37 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18D3719560AE;
	Wed, 31 Jul 2024 17:10:33 +0000 (UTC)
Date: Wed, 31 Jul 2024 19:10:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 06/17] xfrm: add mode_cbs module
 functionality
Message-ID: <ZqpwB-kDLXt9N8vT@hog>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-7-chopps@chopps.org>
 <ZqJT4llwpzag1TUr@hog>
 <m28qxhapkr.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <m28qxhapkr.fsf@ja.int.chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-30, 17:29:06 -0400, Christian Hopps wrote:
>=20
> Sabrina Dubroca <sd@queasysnail.net> writes:
>=20
> > 2024-07-14, 16:22:34 -0400, Christian Hopps wrote:
> > > +struct xfrm_mode_cbs {
> >=20
> > It would be nice to add kdoc for the whole thing.
>=20
> Ok, I'll move the inline comments to a kdoc. FWIW, all the other structs =
in this header, including the main `xfrm_state` struct use the same inline =
comment documentation style I copied.

Sure, but I don't think we should model new code on old habits.

> > > diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> > > index 7cee9c0a2cdc..6ff05604f973 100644
> > > --- a/net/xfrm/xfrm_input.c
> > > +++ b/net/xfrm/xfrm_input.c
> > > @@ -494,6 +497,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr,=
 __be32 spi, int encap_type)
> > >=20
> > >  =09=09family =3D x->props.family;
> > >=20
> > > +=09=09/* An encap_type of -3 indicates reconstructed inner packet */
> >=20
> > And I think it's time to document all the encap_types above the
> > function (and in particular, how xfrm_inner_mode_input/encap_type=3D-3
> > pair together), and/or define some constants. Also, is -2 used
> > anywhere (I only see -1 and -3)? If not, then why -3?
>=20
> At the time this was added ISTR that there was some belief that -2
> was used perhaps in an upcoming patch, so I picked -3. I can't find
> a -2 use case though so I will switch to -2 instead.
>=20
> Re documentation: I think the inline comments where encap_type is
> used is sufficient documentation for the 2 negative values.

I don't think it is. Inline comments are good to explain the internal
behavior, but that's more external behavior.

> There's
> a lot going on in this function and someone wishing to change (or
> understand) something is going to have to walk the code and use
> cases regardless of a bit of extra verbiage on the encap_value
> beyond what's already there. Fully documenting how xfrm_input works
> (in all it's use cases) seems beyond the scope of this patch to me.

Sure, and that's really not what I'm asking for here. Something like
"encap_type=3D-3 makes xfrm_input jump right back to where it stopped
when xfrm_inner_mode_input returned -EINPROGRESS" is useful without
having to dive into the mess that is xfrm_input.

--=20
Sabrina


