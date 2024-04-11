Return-Path: <netdev+bounces-86911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627768A0C3D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936331C2196E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5613FD76;
	Thu, 11 Apr 2024 09:24:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FC62144
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827460; cv=none; b=DYGCxqqPY559d42PPPn+jbzxQXnt5dWklX773gW/f4/Y668ZXYjuBrs6+0KfVJEPUXNbIfq+LJB1Md0I768LdxUOZjx/nOS06DmVfrNnUys6+tYd07ejUrEdlAftPeBPaQg0QybevN+H/UINnMoxOYE9h56c86FU/dT+9X/FIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827460; c=relaxed/simple;
	bh=YTxoBNxpVIJz/OqqIbQTQzSgr/pnXnoRp3diNSa7Hr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ICUWWPMt6ATlgKXuexY1L7x3ynom5S7QT7IJboLxYG9akqlhswfe1NsvF2SIFNAytWmVOvnba0Xf7krHVHActDzq7DZI5ZEMykkUKUiVERE9OAMkF5ZJFakl/aYroqS2q3F1YcYwnF/3bE84xZfUykj+i/plSeKxzs17qOGSMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-fAwpQPziMAGmeHJ_hhUO4A-1; Thu,
 11 Apr 2024 05:24:13 -0400
X-MC-Unique: fAwpQPziMAGmeHJ_hhUO4A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC85F3810B33;
	Thu, 11 Apr 2024 09:24:12 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 79ABA492BC6;
	Thu, 11 Apr 2024 09:24:11 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:24:06 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhesNtc8tdTfuvRd@hog>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog>
 <ZhbFVGc8p9u0xQcv@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZhbFVGc8p9u0xQcv@Antony2201.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-10, 18:59:00 +0200, Antony Antony wrote:
> On Wed, Apr 10, 2024 at 10:56:34AM +0200, Sabrina Dubroca wrote:
> > 2024-04-09, 19:23:04 +0200, Antony Antony wrote:
> > > Good point. I will add  {seq,seq_hi} validation. I don't think we add=
 a for=20
> > > {oseq,oseq_hi} as it might be used by strongSwan with: ESN  replay-wi=
ndow 1,=20
> > > and migrating an SA.
> >=20
> > I'm not at all familiar with that. Can you explain the problem?
>=20
> strongSwan sets ESN and replay-window 1 on "out" SA. Then to migrgate, wh=
en=20
> IKEv2  mobike exchange succeds, it use GETSA read {oseq,oseq_hi} and the=
=20
> attributes, delete this SA.  Then create a new SA, with a different end=
=20
> point, and with old SA's {oseq,oseq_hi} and other parameters(curlft..). =
=20
> While Libreswan and Android use XFRM_MSG_MIGRATE.

Ok, thanks. But that's still an output SA. Setting {oseq,oseq_hi} on
an input SA is bogus I would think?


> > > > xfrma_policy is convenient but not all attributes are valid for all
> > > > requests. Old attributes can't be changed, but we should try to be
> > > > more strict when we introduce new attributes.
> > >=20
> > > To clarify your feedback, are you suggesting the API should not permi=
t=20
> > > XFRMA_SA_DIR for methods like XFRM_MSG_DELSA, and only allow it for=
=20
> > > XFRM_MSG_NEWSA and XFRM_MSG_UPDSA? I added XFRM_MSG_UPDSA, as it's us=
ed=20
> > > equivalently to XFRM_MSG_NEWSA by *swan.
> >=20
> > Not just DELSA, also all the *POLICY, ALLOCSPI, FLUSHSA, etc. NEWSA
> > and UPDSA should accept it, but I'm thinking none of the other
> > operations should. It's a property of SAs, not of other xfrm objects.
>=20
> For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAGS in=
=20
> DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were set i=
n=20
> DELSA, it would also be disregarded. Attempting to introduce validations =
for=20
> DELSA and other methods seems like an extensive cleanup task. Do we consi=
der=20
> this level of validation within the scope of our current patch? It feels=
=20
> like we are going too far.

No, I wouldn't introduce validation of other attributes. It doesn't
belong in this patch(set), and I'm not sure we can add it now as it
might break userspace (I don't see why userspace would pass
XFRMA_ALG_AEAD etc on a DELSA request, but if we never rejected it,
they could).

But rejecting this new attribute from messages that don't handle it
would be good, and should be done in this patch/series.

--=20
Sabrina


