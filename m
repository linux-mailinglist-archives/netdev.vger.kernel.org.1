Return-Path: <netdev+bounces-86675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E5589FDB6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1E6B2AA42
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4235417B517;
	Wed, 10 Apr 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="KYGnK8b+"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83831552F7
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768349; cv=none; b=QkxbvR283CoHjcS7pkmGHpzFRaeNZxK4E1dyNUdDRU+wlpQza1G5+sjcwI7DA7BApiZLUnP9VQ82K8u/uxSFV+VJ94PDutkWPx+99ckDrCiBwqs5tSk5LifN0EJZJOf2Q0UwGZiyxEfR+X7Atqf3XfKzPRQaQSiO6DHvEmkKzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768349; c=relaxed/simple;
	bh=LlWmOEk4ryNjA+ktZGz7Jcjr2v5SMzX5yhcjOP71di8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzmwhLXomRiMfxAtYD6MMfdYUHEOyTnXdOuIAxWBqoEWp0g3rxqoqocr8mQwCMLtZww2icL9N1YGrll+FaMk24/CT87n79RfMLl0tJdxyQX0udIHFOWi9dLgTamcYiGBxCwWMwmz9JsrR0pda2WG32qoaHaP+Dt/z9XEX6G2pps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=KYGnK8b+; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 9d07f4db-f75b-11ee-8fdf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9d07f4db-f75b-11ee-8fdf-005056aba152;
	Wed, 10 Apr 2024 18:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=zBqgR2EdOr+uEaPW+rCVmRjG61+yZsi48WTK3tqDHho=;
	b=KYGnK8b+k8HBjiq1xUTJV3TmO0X/UBW0pdZcRDh5KyZP2zPlw4bmfzE+Ty4zXRlmQ26PxCHcOZCGt
	 ybquLEOpAYl6+xP8iCMBtNeyKVC1LmF539xKZXcDiA+Si3hjaJP9Qj1yNaUP5H3g0YDGTtqrY2eQrz
	 ljfQKom73XNEyQdo=
X-KPN-MID: 33|9aG98A7SvknsidWnL+HzQxYSbSVLxv7u38TV7PgcQ6Wfg7bi9r0zdzq/E1zfZ8X
 qatRtqXJFkO2AKBVACvPwcxARUtdZkFcpYmrDWayssQ0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|+VY3jgwrzGhHupBlrN8VxE5vK8JdMIHRliYdL7T2vocT9VQIETaoBK9uPAu2tiP
 +s90T1micC/A5dUjLu4WrRQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a0ca8655-f75b-11ee-8d54-005056ab7447;
	Wed, 10 Apr 2024 18:59:01 +0200 (CEST)
Date: Wed, 10 Apr 2024 18:59:00 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhbFVGc8p9u0xQcv@Antony2201.local>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhZUQoOuvNz8RVg8@hog>

On Wed, Apr 10, 2024 at 10:56:34AM +0200, Sabrina Dubroca wrote:
> 2024-04-09, 19:23:04 +0200, Antony Antony wrote:
> > On Mon, Apr 08, 2024 at 03:02:31PM +0200, Sabrina Dubroca wrote:
> > > 2024-04-07, 10:23:21 +0200, Antony Antony wrote:
> > > > Thank you for raising this point.  I thought that introducing a patch for 
> > > > the replay window check could stir more controversy, which might delay the 
> > > > acceptance of the essential 'dir' feature.
> > > 
> > > I'm not convinced it's *that* critical. People have someone managed to
> > 
> > Understood, but from a user's perspective, I've seen significant confusion 
> > around this issue. Labeling it as 'historical' and unchangeable ignores its 
> > real impact on usability. I feel adding "dir"  would help a lot.
> 
> Sure. I meant that also in relation to IPTFS development:
> 
> > > use IPsec without it for all those years. Is the intention to only
> > > allow setting up IPTFS SAs when this new 'dir' attribute is provided?
> > > If not, then this patch is not really blocking for IPTFS.
> 
> 
> [...]
> > > > For non-ESN scenarios, the outbound SA should have a replay window set to 0?
> > > 
> > > Looks ok.
> > > 
> > > > And for ESN 1?
> > > 
> > > Why 1 and not 0?
> > 
> > Current implemenation does not allow 0.
> 
> So we have to pass a replay window even if we know the SA is for
> output? That's pretty bad.

we can default to 1 with ESN and when no replay-window is specified.  

> > Though supporting 0 is higly desired 
> > feature and probably a hard to implement feature in xfrm code. 
> 
> Why would it be hard for outgoing SAs? The replay window should never
> be used on those. And xfrm_replay_check_esn and xfrm_replay_check_bmp
> already have checks for 0-sized replay window.

That information comes from hall way talks with Steffen. I can't explain 
it:) May be he can elaborate why 0 is not allowed with ESN.

> > Supporting 0 is also a long standing argument:)
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/xfrm/xfrm_replay.c#n781
> > 
> > int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack)
> > 
> > 781                         if (replay_esn->replay_window == 0) {
> > 782                                 NL_SET_ERR_MSG(extack, "ESN replay window must be > 0");
> > 783                                 return -EINVAL;
> > 784                         }
> > 
> > > Does setting xfrm_replay_state_esn->{oseq,oseq_hi} on an input SA (and
> > > {seq,seq_hi} on output) make sense?
> > 
> > Good point. I will add  {seq,seq_hi} validation. I don't think we add a for 
> > {oseq,oseq_hi} as it might be used by strongSwan with: ESN  replay-window 1, 
> > and migrating an SA.
> 
> I'm not at all familiar with that. Can you explain the problem?

strongSwan sets ESN and replay-window 1 on "out" SA. Then to migrgate, when 
IKEv2  mobike exchange succeds, it use GETSA read {oseq,oseq_hi} and the 
attributes, delete this SA.  Then create a new SA, with a different end 
point, and with old SA's {oseq,oseq_hi} and other parameters(curlft..).  
While Libreswan and Android use XFRM_MSG_MIGRATE.

> Also, this is a new bit of API. We don't have to accept strange
> configs with it, userspace should adapt to the strict rules we
> require.
> 
> > > And xfrm_state_update probably needs to check that the dir value
> > > matches?  If we get this far we know the new state had matching
> > > direction and properties, but maybe the old one didn't?
> > 
> > Yes. I will add this too.
> > 
> > > In XFRMA_SA_EXTRA_FLAGS, both XFRM_SA_XFLAG_DONT_ENCAP_DSCP and
> > > XFRM_SA_XFLAG_OSEQ_MAY_WRAP look like they're only used on output. A
> > > few of the flags defined with xfrm_usersa_info also seem to work only
> > > in one direction (XFRM_STATE_DECAP_DSCP, XFRM_STATE_NOPMTUDISC,
> > > XFRM_STATE_ICMP).
> > 
> > I'm familiar with one flag, but my knowledge on the rest is limited, still I 
> > believe they aren't direction-specific. If anyone has more specific insight, 
> > please do share. Are any of these flags or x flags direction specific?
> 
> [I typically wait for answers to my questions before I post the next
> version of a patch. Otherwise, reviewers have to do more work, looking
> at each version.]

I will not post v10 yet.

> BTW I just looked at all the flags defined in uapi, and asked cscope
> where they were used. For some, the function names were clearly only
> output path, for some just input, or both directions.

I looked closer at the flags and I noticed  several of them are direction 
specific.  And I am proposing to valide them and a simple data path check 
for directions in v10.

> [...]
> > > I think it would also make sense to only accept this attribute in
> > > xfrm_add_sa, and not for any of the other message types. Sharing
> > 
> > > xfrma_policy is convenient but not all attributes are valid for all
> > > requests. Old attributes can't be changed, but we should try to be
> > > more strict when we introduce new attributes.
> > 
> > To clarify your feedback, are you suggesting the API should not permit 
> > XFRMA_SA_DIR for methods like XFRM_MSG_DELSA, and only allow it for 
> > XFRM_MSG_NEWSA and XFRM_MSG_UPDSA? I added XFRM_MSG_UPDSA, as it's used 
> > equivalently to XFRM_MSG_NEWSA by *swan.
> 
> Not just DELSA, also all the *POLICY, ALLOCSPI, FLUSHSA, etc. NEWSA
> and UPDSA should accept it, but I'm thinking none of the other
> operations should. It's a property of SAs, not of other xfrm objects.

For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAGS in 
DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were set in 
DELSA, it would also be disregarded. Attempting to introduce validations for 
DELSA and other methods seems like an extensive cleanup task. Do we consider 
this level of validation within the scope of our current patch? It feels 
like we are going too far.

