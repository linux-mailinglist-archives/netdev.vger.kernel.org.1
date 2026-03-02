Return-Path: <netdev+bounces-262666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIBlAM6apWnxEgYAu9opvQ
	(envelope-from <netdev+bounces-262666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:12:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF81DA728
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4195D3002F9D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655F3FB075;
	Mon,  2 Mar 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="EkgfyN/Z"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D23FB066;
	Mon,  2 Mar 2026 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460415; cv=none; b=YiD1TrcZ0XMtgQ1H9S8wSyvUReU12KC7vds5scPvyermbXCRaRux/fimaU4Q8XCiuP/+Xk/Ql9TGxVoasuhJ4kDoRxU7hclt54NwG/ZXgjH2zAYTuB1ICu/6t5uCqXSFCFE+P4DJxXKGCSZH5FFfj5ZqPc0dF+TGKt/cv/VCLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460415; c=relaxed/simple;
	bh=qz+MRlLnx404EUH9IVSOOgg1u89pJ72HWWqf0TPGV9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpWXPTA440ZieKqNTWVIA+wUK7sXb1m8Xcs6MuPd0yW6Y4C0uzU1A8d67CLYqa/bYfWm7JcMcJ+93wYDPcuepdqNyrNcHUBZ6tfJVe+IVlRhfSgrhRGqJZoGnAuIw2uL33Q5/NOZ/TYKg5AYaeXd8vMvrW+bqrZoi99NeAgFji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=EkgfyN/Z; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1772460404; x=1773324405; bh=qz+M
	RlLnx404EUH9IVSOOgg1u89pJ72HWWqf0TPGV9o=; b=EkgfyN/ZxULzXmokVX81
	7fNEE3w8BvikCNwIOtT4ZQQM87hqLef4W4R6wD/ckMiVaTxp7xpxtd7GJgwD4ZXa
	t88gIsMC3wxPg/ioGxqpX/tkzfSQ5Ya88sPlRJuSupyPsgGxuP7/lK+1FbhXStTn
	1pa7GvaKcFzUrn22Kiu+grNFK9gI1adFfq4GvHV7o1T5aLKGWzPLXngnY6TBZkiS
	uRb8DIPyt6j+wKNRvF9kZafzjOk1WFS+Uv/lYVzCIgNOMiiXTKCMaKzob9Cf2A0G
	sYzv8DCtSLqBbMHFp6d+A15zsRtH93tDiDDjrwzoBzmaS5gbYF5AlLy+xb3a2iwY
	7Q==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Mon, 02 Mar 2026 15:06:41 +0100 (CET)
Date: Mon, 2 Mar 2026 15:06:40 +0100
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Antony Antony <antony.antony@secunet.com>,
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
Message-ID: <aaWZcLZzdydDsQX_@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <dd1d5b341323d6e0f93057c214adf4fc51c3cbd1.1769509131.git.antony.antony@secunet.com>
 <aXygrzQrsQxGdDG5@krikkit>
 <aaBqGgkGWfjPdJRv@Antony2201.local>
 <aaB8CL1uZ8_PzyLA@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaB8CL1uZ8_PzyLA@krikkit>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262666-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Antony2201.local:mid,secunet.com:email,phenome.org:dkim]
X-Rspamd-Queue-Id: 5FAF81DA728
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 05:59:52PM +0100, Sabrina Dubroca via Devel wrote:
> 2026-02-26, 16:43:22 +0100, Antony Antony wrote:
> > On Fri, Jan 30, 2026 at 01:14:39PM +0100, Sabrina Dubroca via Devel wrote:
> > > 2026-01-27, 11:43:42 +0100, Antony Antony wrote:
> > > > Add descriptive(extack) error messages for all error paths
> > > > in state migration. This improves diagnostics by
> > > > providing clear feedback when migration fails.
> > > > 
> > > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > > ---
> > > > v4->v5: - added this patch
> > > > ---
> > > >  net/xfrm/xfrm_state.c | 13 ++++++++++---
> > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > > index 88a362e46972..2e03871ae872 100644
> > > > --- a/net/xfrm/xfrm_state.c
> > > > +++ b/net/xfrm/xfrm_state.c
> > > > @@ -2129,15 +2129,21 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
> > > >  	struct xfrm_state *xc;
> > > > 
> > > >  	xc = xfrm_state_clone_and_setup(x, encap, m);
> > > > -	if (!xc)
> > > > +	if (!xc) {
> > > > +		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
> > > 
> > > When xfrm_state_clone_and_setup fails it's because some allocation
> > > failed and the user won't be able to do much about this, right? I
> > > don't feel extack in those situations is super helpful.
> > 
> > I felt it was usefaul to know, and to log this happened. May not a great 
> > idea.
> 
> I don't have a super strong opinion. IIRC that was the approach I
> picked when I added extack (no extack for kernel events that the user
> can't do anything about and don't result from an invalid netlink
> message), but maybe that kind of stuff deserves an extack too.
> 
> Also, I thought that something that ends up returning ENOMEM to
> userspace is explicit enough, without adding a string "failed to
> allocate memory for $object" in extack. But I don't work on *swan, so
> maybe it's more useful than I think.

*swans are slowly catching up with extack. For years we ignored it
due to two reasons: lower coverage and lack of documentation.
Both are improving over time, so I think it's worth embracing more broadly now.
I hope we add a better extack support in xfrm_init_state().

E* errors I find hard to figure out as user, may be *swans log them as 
numbers not as friendly names!

> (Steffen has the final word, and you're closer to him than I am :))
> 
> 
> > > >  		return NULL;
> > > > +	}
> > > > 
> > > > -	if (xfrm_init_state(xc) < 0)
> > > > +	if (xfrm_init_state(xc) < 0) {
> > > > +		NL_SET_ERR_MSG(extack, "Failed to initialize migrated state");
> > > 
> > > xfrm_init_state itself doesn't handle extack, but it's just a wrapper
> > > around functions that do. Maybe better to make xfrm_init_state
> > > propagate extack?
> > 
> > That is a great idea. May be in a future patch set. For now, I will drop 
> > this patch from this series. To move forward quickly.
> 
> Ok. Or keep the patch with just the fixup right below this, I'm not
> NACKing it.

thanks for clarifying.  I will keep the patch without xfrm_dev_state_add() 
case. 

> 
> > > >  		goto error;
> > > > +	}
> > > > 
> > > >  	/* configure the hardware if offload is requested */
> > > > -	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
> > > > +	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack)) {
> > > > +		NL_SET_ERR_MSG(extack, "Failed to initialize state offload");
> > > 
> > > We already set an extack in xfrm_dev_state_add, this chunk should be
> > > dropped to avoid overwriting the more specific info we got.
> > > 
> > > >  		goto error;
> > > > +	}
> > > > 
> > > >  	return xc;
> > > >  error:
> > > > @@ -2161,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
> > > >  		xfrm_state_insert(xc);
> > > >  	} else {
> > > >  		if (xfrm_state_add(xc) < 0) {
> > > > +			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
> > > 
> > > Not a strong objection, but this case would be the EEXIST situation
> > > from xfrm_state_add, and there's not much the user can do about this?
> > 
> > Fair point, but logging it still has value too, userspace can track these
> > over time and adapt. Let's revisit when we add extack to xfrm_init_state.
> 
> Ok.
> 
> > > >  			if (xuo)
> > > >  				xfrm_dev_state_delete(xc);
> > > >  			xc->km.state = XFRM_STATE_DEAD;
> > > 
> 
> -- 
> Sabrina

thanks,
-antony

