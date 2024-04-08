Return-Path: <netdev+bounces-85763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9402289C085
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644EFB2A912
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0DA7D3F4;
	Mon,  8 Apr 2024 13:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC56F08B
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581373; cv=none; b=OsLtyPlG407bUgP3WO1UTo0/a0FyAKeXhZlRqsJ2+pqelnWSa85T53ogkFFBt0l4xc/6nS0vz5i5qc+MxeXIEIReLgvbMlnvf2JTmaZgmaa0RuEl5RHGt+61p7g3CP9ybBF1uq/dzdkm6cyDOiZJq5QRmmGRD9DNpSYlqW/jGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581373; c=relaxed/simple;
	bh=pteGFMYsPq/MM603iUlNnEZK49ejpJn5CSpKsoQy57I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=myqlWj7uTB0sb8sE+ocDhE9iiULvUj8vxhIwl033CBNtnqaeBxEQCTRkuoBYB1d9Tqx9L7SdFsG4K7kLZEcumgQjUXbAhX7v+aEz6T+2uahOnZuu3lBL3d/E2h3+ygP9ook1/qdWpBQ90saT+vx6WfDjys2+Rm3si5UkhcKxfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-7wGp3ECaNfyaohg7KMraYA-1; Mon, 08 Apr 2024 09:02:39 -0400
X-MC-Unique: 7wGp3ECaNfyaohg7KMraYA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE14D8026B9;
	Mon,  8 Apr 2024 13:02:38 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F9D0492BC7;
	Mon,  8 Apr 2024 13:02:36 +0000 (UTC)
Date: Mon, 8 Apr 2024 15:02:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhPq542VY18zl6z3@hog>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZhJX-Rn50RxteJam@Antony2201.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-07, 10:23:21 +0200, Antony Antony wrote:
> Hi Sabrina,
>=20
> On Fri, Apr 05, 2024 at 11:56:00PM +0200, Sabrina Dubroca via Devel wrote=
:
> > Hi Antony,
> >=20
> > 2024-04-05, 14:40:07 +0200, Antony Antony wrote:
> > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > xfrm_state, SA, enhancing usability by delineating the scope of value=
s
> > > based on direction. An input SA will now exclusively encompass values
> > > pertinent to input, effectively segregating them from output-related
> > > values.=20
> >=20
> > But this patch isn't doing that for existing properties (I'm thinking
> > of replay window, not sure if any others are relevant [1]). Why not?
>=20
> Thank you for raising this point.  I thought that introducing a patch for=
=20
> the replay window check could stir more controversy, which might delay th=
e=20
> acceptance of the essential 'dir' feature.

I'm not convinced it's *that* critical. People have someone managed to
use IPsec without it for all those years. Is the intention to only
allow setting up IPTFS SAs when this new 'dir' attribute is provided?
If not, then this patch is not really blocking for IPTFS.

And yes, people will sometimes make comments on patches that cause
delays in getting the patches accepted. Some patches even end up
getting rejected. The kernel is better thanks to that process, even if
it can be annoying to the submitter (including me! it would be a lot
more relaxing if my patches always just went in at v1 :)).

Nicolas, since you were objecting to the informational nature of the
attribute in v5: would you still object to the new attribute (and not
just limited to offload cases) if it properly restricted attributes
that don't match the direction?

>  My primary goal at this stage is=20
> to get this basic feature  in and to convince Chris to integrate the "dir=
"=20
> attribute into IP-TFS. This patch has partly contributed to the delays in=
=20
> IP-TFS's development.
>=20
> Given your input, I'm curious about the specific conditions you have in=
=20
> mind. See the attached patch.

I didn't look into details when I wrote that email. The rough idea was
"Whatever makes the kernel do replay protection on incoming packets"
(and if any attribute is output-only, skip those on input SAs).

> For non-ESN scenarios, the outbound SA should have a replay window set to=
 0?

Looks ok.

> And for ESN 1?

Why 1 and not 0?

Does setting xfrm_replay_state_esn->{oseq,oseq_hi} on an input SA (and
{seq,seq_hi} on output) make sense?


And xfrm_state_update probably needs to check that the dir value
matches?  If we get this far we know the new state had matching
direction and properties, but maybe the old one didn't?

In XFRMA_SA_EXTRA_FLAGS, both XFRM_SA_XFLAG_DONT_ENCAP_DSCP and
XFRM_SA_XFLAG_OSEQ_MAY_WRAP look like they're only used on output. A
few of the flags defined with xfrm_usersa_info also seem to work only
in one direction (XFRM_STATE_DECAP_DSCP, XFRM_STATE_NOPMTUDISC,
XFRM_STATE_ICMP).


> non-ESN
> ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2  \
> mode tunnel dir out aead 'rfc4106(gcm(aes))' \
> 0x2222222222222222222222222222222222222222 96 if_id 11 replay-window 10
> Error: Replay-window too big > 0 for OUT SA.

I'd probably change the string to "Replay window should not be set for
OUT SA", that makes a bit more sense to me. "too big" implies that
some values are valid, which isn't really the case.

> The current impelementation does not replay window 0 with ESN.  Even thou=
gh=20
> disabling replay window with ESN is a desired feature.
>=20
> ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2 mode=
=20
> tunnel dir out flag esn  aead  'rfc4106(gcm(aes))'  \
> 0x2222222222222222222222222222222222222222 96 if_id 11 replay-window 10
> Error: ESN replay-window too big > 1 for OUT SA.ww
>=20
> I wonder would the attached patch get accepted quickly.

I'm more interested in getting things right if we're going to
introduce a new bit of API. IMO a new "dir" attribute that doesn't
fully lock down the options on an SA is worse than no attribute (as
Nicolas said previously, it's really confusing).
And I'm not that familiar with all the API for xfrm SAs, so the
properties I listed above may not be everything we should lock down
(and maybe some are wrong).

I think it would also make sense to only accept this attribute in
xfrm_add_sa, and not for any of the other message types. Sharing
xfrma_policy is convenient but not all attributes are valid for all
requests. Old attributes can't be changed, but we should try to be
more strict when we introduce new attributes.

Sorry that I didn't notice this when you posted the previous versions.

--=20
Sabrina


