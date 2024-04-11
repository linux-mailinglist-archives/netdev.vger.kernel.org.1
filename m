Return-Path: <netdev+bounces-86910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E418A0C3C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208752851EB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D91448E2;
	Thu, 11 Apr 2024 09:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCFA1428FA
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827437; cv=none; b=BlBjmm6jjiT+WW76EgS7t2XJsj1fkGciFlsGHOhgzOZLWmyc+nX9GGepBcZYS5SnhzrcyGzMFdNOXthaRo354DuFJrBewgvuBP2r+Vy2gA9RbG34HrN5ZqEqcVwwOM501FyC/HbxI78aSEVdecfEegI14hLcna2zgFDMhMAfWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827437; c=relaxed/simple;
	bh=DYCUQxyGNKtTnNnxXntoj2lUHiLBF6HgV/vhZK0E35g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zu8JqS4agGPY9vy9+ya6E7KmvfBPEaREjcbcsqCcq3lqQzJDqeScMEzVb5fNdotC213l1G1CeVppcjEzf4D9tl+KTUDH3HDpepH70g+0eDdSSdqnwEczuDmMJy+QtezCqMzjhJkeYtaKhYyhhjF4HKU03QxYrYNlWmvIyaFyywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-eTqzzde7NIi43v-KrynQpQ-1; Thu, 11 Apr 2024 05:23:44 -0400
X-MC-Unique: eTqzzde7NIi43v-KrynQpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3AAE1802A04;
	Thu, 11 Apr 2024 09:23:43 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EAB80112131D;
	Thu, 11 Apr 2024 09:23:41 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:23:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paul Wouters <paul@nohats.ca>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony@phenome.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhesGJtMXk-PPtzz@hog>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog>
 <ZhbFVGc8p9u0xQcv@Antony2201.local>
 <81b4f75c-5c43-8357-55ad-0ec28291d399@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <81b4f75c-5c43-8357-55ad-0ec28291d399@nohats.ca>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-10, 20:58:33 -0400, Paul Wouters wrote:
> On Wed, 10 Apr 2024, Antony Antony via Devel wrote:
> > > > Though supporting 0 is higly desired
> > > > feature and probably a hard to implement feature in xfrm code.
> > >=20
> > > Why would it be hard for outgoing SAs? The replay window should never
> > > be used on those. And xfrm_replay_check_esn and xfrm_replay_check_bmp
> > > already have checks for 0-sized replay window.
> >=20
> > That information comes from hall way talks with Steffen. I can't explai=
n
> > it:) May be he can elaborate why 0 is not allowed with ESN.
>=20
> With ESN, you use a 64 bit number but only send a 32 bit number over the
> wire. So you need to "track" the parts not being sent to do the proper
> packet authentication that uses the full 64bit number. The
> authentication bit is needed for encrypting and decrypting, so on both
> the incoming and outgoing SA.
>=20
> AFAIK, this 64 bit number tracking is done using the replay-window code.
> That is why replay-window cannot be 0 when ESN is enabled in either
> direction of the SA.

It's in the replay-window code, but AFAICT it doesn't use the
replay_window variable at all (xfrm_output calls into the
xfrm_replay_overflow_* functions which only look at oseq, xfrm_input
calls the *check and *advance functions of xfrm_replay.c). So I think
we could accept an unset replay_window for an output SA.

> I have already poked Steffen it would be good to decouple ESN code from
> replay-window code, as often people want to benchmark highspeed links
> by disabling replay protection completely, but then they are also
> unwittingly disabling ESN and causing needing a rekey ever 2 minutes
> or so on a modern 100gbps ipsec link.
>=20
> > strongSwan sets ESN and replay-window 1 on "out" SA.
>=20
> It has to set a replay-window of non-zero or else ESN won't work.
> It is not related to migration AFAIK.
>=20
> > For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAGS =
in
> > DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were set=
 in
> > DELSA, it would also be disregarded. Attempting to introduce validation=
s for
> > DELSA and other methods seems like an extensive cleanup task. Do we con=
sider
> > this level of validation within the scope of our current patch? It feel=
s
> > like we are going too far.
>=20
> Is there a way where rate limited logging can be introduced, so that
> userlands will clean up their use and after a few years change the API
> to not allow setting bogus values?

Yes, this is doable. Steffen, does that seem reasonable? (for example,
when XFRMA_REPLAY_THRESH is passed to NEWSA, or XFRMA_ALG_AEAD to
DELSA, etc)

(as part of a separate patchset of course)

--=20
Sabrina


