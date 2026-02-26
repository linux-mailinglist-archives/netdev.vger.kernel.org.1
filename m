Return-Path: <netdev+bounces-261406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPLIH6FtoGkHjwQAu9opvQ
	(envelope-from <netdev+bounces-261406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:58:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F06891A947F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19F1B315DF3C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06380410D09;
	Thu, 26 Feb 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="Cuufnm4R"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A13A0E86;
	Thu, 26 Feb 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120607; cv=none; b=DqquzEUkLGr/PTG/pjItEGamcGpCRvjsFz9Nzy2InM1Hh485wFGyC2dxoNX3FHFVZAP9tPPoTtpoFgrhnIdkMzRcQTMpCnoFsD1S84YCx9xVY6RaoWdQ6lefIieghGi/ykYRq5zD/hUwF8ax3UgdpzVy0o/PaXsLnpC5LBpMFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120607; c=relaxed/simple;
	bh=5UWDVMPi0mHfxgsUg6phPstKgXIT1mWD8Qpz5o1/NAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWrwrR0PwZa6z+l0uCMAl1DMpTA1t/2BpfOy0A5fHpbwzTvSFrNjN+wxsnl4sg7sw191f7i/KBl3o5HNhoJeT8OlOCfc9z6zoRfx2wCRjGjhfWSdbX8siArM2aW3+EQmx9qf52ynOi5xNR6a8FLL3HuN84z3FapJhLsxczVidcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=Cuufnm4R; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1772120603; x=1772984604; bh=5UWD
	VMPi0mHfxgsUg6phPstKgXIT1mWD8Qpz5o1/NAg=; b=Cuufnm4R6s2dqkHLXx7W
	UN7HsWEqsX6xkjRqgDbHDJtG4C3z4OfAAVVieEbtb/20cGdn7X886ubBhPUeYZkz
	TbZ3s/NGiMZEcAvNfxhnKjorBxwxsd9VwUWu+EjbbGmLotYZw9aANVRCZuGZvMrR
	4X2PbcPr9NOh1cAF1qbGPqHoGlaUb6m8dozWPb+mht+KkeIDgWRfwZCVIN9QtkNP
	qtRt/HgZgqIRxTPlcH22UoEPrLUXcVEYjeV1GgHR5MEDKYoxRXzzFAkEFRXJtym1
	GRHlQDlkdVziT8tzdfvvRd6w6WPYFEvSZEkLvLhWh9ELzTRFUwea5/NZjI4TYDAg
	sA==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 26 Feb 2026 16:43:23 +0100 (CET)
Date: Thu, 26 Feb 2026 16:43:22 +0100
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 7/8] xfrm: add error
 messages to state migration
Message-ID: <aaBqGgkGWfjPdJRv@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <dd1d5b341323d6e0f93057c214adf4fc51c3cbd1.1769509131.git.antony.antony@secunet.com>
 <aXygrzQrsQxGdDG5@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXygrzQrsQxGdDG5@krikkit>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261406-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Antony2201.local:mid,phenome.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Queue-Id: F06891A947F
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 01:14:39PM +0100, Sabrina Dubroca via Devel wrote:
> 2026-01-27, 11:43:42 +0100, Antony Antony wrote:
> > Add descriptive(extack) error messages for all error paths
> > in state migration. This improves diagnostics by
> > providing clear feedback when migration fails.
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> > v4->v5: - added this patch
> > ---
> >  net/xfrm/xfrm_state.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 88a362e46972..2e03871ae872 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -2129,15 +2129,21 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
> >  	struct xfrm_state *xc;
> > 
> >  	xc = xfrm_state_clone_and_setup(x, encap, m);
> > -	if (!xc)
> > +	if (!xc) {
> > +		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
> 
> When xfrm_state_clone_and_setup fails it's because some allocation
> failed and the user won't be able to do much about this, right? I
> don't feel extack in those situations is super helpful.

I felt it was usefaul to know, and to log this happened. May not a great 
idea.

> 
> >  		return NULL;
> > +	}
> > 
> > -	if (xfrm_init_state(xc) < 0)
> > +	if (xfrm_init_state(xc) < 0) {
> > +		NL_SET_ERR_MSG(extack, "Failed to initialize migrated state");
> 
> xfrm_init_state itself doesn't handle extack, but it's just a wrapper
> around functions that do. Maybe better to make xfrm_init_state
> propagate extack?

That is a great idea. May be in a future patch set. For now, I will drop 
this patch from this series. To move forward quickly.

> 
> >  		goto error;
> > +	}
> > 
> >  	/* configure the hardware if offload is requested */
> > -	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
> > +	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack)) {
> > +		NL_SET_ERR_MSG(extack, "Failed to initialize state offload");
> 
> We already set an extack in xfrm_dev_state_add, this chunk should be
> dropped to avoid overwriting the more specific info we got.
> 
> >  		goto error;
> > +	}
> > 
> >  	return xc;
> >  error:
> > @@ -2161,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
> >  		xfrm_state_insert(xc);
> >  	} else {
> >  		if (xfrm_state_add(xc) < 0) {
> > +			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
> 
> Not a strong objection, but this case would be the EEXIST situation
> from xfrm_state_add, and there's not much the user can do about this?

Fair point, but logging it still has value too, userspace can track these
over time and adapt. Let's revisit when we add extack to xfrm_init_state.

> 
> >  			if (xuo)
> >  				xfrm_dev_state_delete(xc);
> >  			xc->km.state = XFRM_STATE_DEAD;
> 

