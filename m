Return-Path: <netdev+bounces-87181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0118A1FF4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 22:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382F7283312
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7CC17C6A;
	Thu, 11 Apr 2024 20:14:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405B17584
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866484; cv=none; b=HEkwj1MiBJrCa6lkUgWNguDDxpw3ZsX/k1l1ISDDWGEs/q5f3xJ0t5hhwK2xosw/zYTC0u5L3VygEDrw1myE9ubvKMOMJLEt1vU3UNIKZ2TI/ljWDWciqQrVyP/kMmSXXTRMTrcMzHKMiXYFqpUrMAIep46LBuwwgAC3JLQ0GJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866484; c=relaxed/simple;
	bh=2QSLdNV095NUp1T3pQnS1ty2QqIzyqQu7DCwWuGVGNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eRLsH3AymCYXrpwi5BXbBKRN59MHA9J9XVELU8BvCrtA1rXP6Ir07CKfojo2oHkyhC+5n6dudPFm03ckRVTndu7/Tri+x/svbc/DKVkXOpNb9AtUgcc3/UoxZF7oADzjT27BEWhXyb+Z2pAwJkDjKRzpEt2YpPSlqR58JM3gC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-dLMzB0njNF2KG_0f51kAKw-1; Thu, 11 Apr 2024 16:14:36 -0400
X-MC-Unique: dLMzB0njNF2KG_0f51kAKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2D4D806604;
	Thu, 11 Apr 2024 20:14:35 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E799910E47;
	Thu, 11 Apr 2024 20:14:33 +0000 (UTC)
Date: Thu, 11 Apr 2024 22:14:28 +0200
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
Message-ID: <ZhhEpNPyKPDohQoH@hog>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog>
 <ZhbFVGc8p9u0xQcv@Antony2201.local>
 <ZhesNtc8tdTfuvRd@hog>
 <Zhe9LB97ik37hM3q@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zhe9LB97ik37hM3q@Antony2201.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-11, 12:36:28 +0200, Antony Antony wrote:
> On Thu, Apr 11, 2024 at 11:24:06AM +0200, Sabrina Dubroca wrote:
> > 2024-04-10, 18:59:00 +0200, Antony Antony wrote:
> > > On Wed, Apr 10, 2024 at 10:56:34AM +0200, Sabrina Dubroca wrote:
> > > > 2024-04-09, 19:23:04 +0200, Antony Antony wrote:
> > > > > > xfrma_policy is convenient but not all attributes are valid for=
 all
> > > > > > requests. Old attributes can't be changed, but we should try to=
 be
> > > > > > more strict when we introduce new attributes.
> > > > >=20
> > > > > To clarify your feedback, are you suggesting the API should not p=
ermit=20
> > > > > XFRMA_SA_DIR for methods like XFRM_MSG_DELSA, and only allow it f=
or=20
> > > > > XFRM_MSG_NEWSA and XFRM_MSG_UPDSA? I added XFRM_MSG_UPDSA, as it'=
s used=20
> > > > > equivalently to XFRM_MSG_NEWSA by *swan.
> > > >=20
> > > > Not just DELSA, also all the *POLICY, ALLOCSPI, FLUSHSA, etc. NEWSA
> > > > and UPDSA should accept it, but I'm thinking none of the other
> > > > operations should. It's a property of SAs, not of other xfrm object=
s.
> > >=20
> > > For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAG=
S in=20
> > > DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were s=
et in=20
> > > DELSA, it would also be disregarded. Attempting to introduce validati=
ons for=20
> > > DELSA and other methods seems like an extensive cleanup task. Do we c=
onsider=20
> > > this level of validation within the scope of our current patch? It fe=
els=20
> > > like we are going too far.
> >=20
> > No, I wouldn't introduce validation of other attributes. It doesn't
> > belong in this patch(set), and I'm not sure we can add it now as it
> > might break userspace (I don't see why userspace would pass
> > XFRMA_ALG_AEAD etc on a DELSA request, but if we never rejected it,
> > they could).=20
> >=20
> > But rejecting this new attribute from messages that don't handle it
> > would be good, and should be done in this patch/series.
>=20
> Definitely see the value in such feature in general, but it seems ambitio=
us=20
> for this patch set.

I'm only talking about the new attribute here. Introducing validation
for all other attributes, yes, that's a completely separate thing (and
we can't do that immediately, we need to work toward it, see Paul's
suggestion).

> Currently, only NEWSA, UPDSA, and ALLOCSPI need=20
> XFRMA_SA_DIR. I am wondering how to reject this atrribute in remaining 20=
-22=20
> messages.  Is there a precedent or example in xfrm_user.c for this kind o=
f=20
> validation, or maybe a Netlink feature that lets us restrict NL attribute=
s=20
> for a specific messages like DELSA.

I don't think there is, xfrm_user doesn't do that kind of validation yet.
There's an example in rtnl_valid_dump_net_req and
rtnl_net_valid_getid_req, where some attributes are rejected.

--=20
Sabrina


