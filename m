Return-Path: <netdev+bounces-91579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C038B31A9
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C7628186A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2113C912;
	Fri, 26 Apr 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="Rek2s5pp"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D713AD25
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117666; cv=none; b=R6G7y5Dp5ZLB/KuqlwP2Ed0Q/ViSipKV78FguGZ3koWGS/IZkSEqX4yCZ+Bqp/SLJybWkLD/PQ/zSMiA23GnlehboWmvVXXtK8g7GMM1FitP8Q3hUS/60PIwCoRQId3SFIWX70vpZsYqz7Q0PdMCqsYCNVZEPi9xQWHeACdqnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117666; c=relaxed/simple;
	bh=OoQYugA6Tz4LP2ZVl65yGQkddxgI09RD0FRcvKpMyeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGXrqYSZ/J7FMCcy2b9oV+gBVDkWJ3xM9dYp8EEvJAFFWiJrMUQcUuXp5wucINcoRCmK6sVvc5PGQGSbn6KJptmiLaE/ktunfJGJZcKpf73sYx3ndhmXf4sBQplZni+t7uFih5uXT6WYbCsfgtjHR2rtEzVXjlgRo6cpOOzsAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=Rek2s5pp; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 3d2c27e9-03a1-11ef-93a7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3d2c27e9-03a1-11ef-93a7-005056abbe64;
	Fri, 26 Apr 2024 09:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Ml5kD9DbAKlZtiq1aHaBXW9xNYtTH9+BfMi/qkwn1ig=;
	b=Rek2s5pprjo9OUxYwQlSM7Upjft+/nXrUDBIJlSxC+sSnBKewGMNFN4ri2Ufb2l1J2su0a4abhF7V
	 Y4rplpCXTtfJse/UbrUQ+wtZgRPEF6Gh0RlfUycqEwyLo7SSg9nXLNnFzU5rwE5JhNGneVIrkFF8mb
	 fsLnqtmQPnRCosfI=
X-KPN-MID: 33|1oJOnZrko9zkXQ0Jcv+N0iqbY/iN6h7sRMCVZu1XPwDva8xgQqCD/blvCKdo43k
 m1N/ztHTSYz3kLLtmdpIdjkLo+p2PNF0pl1OeV92de0w=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|lXmcQwnWjgD2D92ZgRJ7Nr1p8MD3Hg0JSkrmoUb0Z+9nYJDItCvA8Et94XNA4N7
 JI5WqaTZMJzHFH4NoifGLIw==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3cbfbc4d-03a1-11ef-a212-005056ab1411;
	Fri, 26 Apr 2024 09:47:32 +0200 (CEST)
Date: Fri, 26 Apr 2024 09:47:31 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v12 1/4] xfrm: Add Direction to the SA in or
 out
Message-ID: <ZitcE8dJnwLi5bYx@Antony2201.local>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <91580d32b47bc78d0e09fccab936effc23ec8155.1713874887.git.antony.antony@secunet.com>
 <ZijTAN_ns1gRU9hz@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZijTAN_ns1gRU9hz@hog>

On Wed, Apr 24, 2024 at 11:38:08AM +0200, Sabrina Dubroca via Devel wrote:
> 2024-04-23, 14:49:17 +0200, Antony Antony wrote:
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 0c306473a79d..c8c5fc47c431 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -1292,6 +1292,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
> >  		if (km_query(x, tmpl, pol) == 0) {
> >  			spin_lock_bh(&net->xfrm.xfrm_state_lock);
> >  			x->km.state = XFRM_STATE_ACQ;
> > +			x->dir = XFRM_SA_DIR_OUT;
> 
> Would that make updates fail if userspace isn't setting SA_DIR
> afterwards?

Not in typical, operation of IKE daemons. I haven't update acquire state.
I don't think iproute2 supports that.
UPDSA is called for input where there is no acquire; acquire is for output.  
For output SA, added using NEWSA, will find the output acquire and delete it 
if p->seq matches. It won't update.

May be some other userspace update acquire? I extend the code to accomodate 
this possible case, in v13.

> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index 810b520493f3..d34ac467a219 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> [...]
> > @@ -176,6 +200,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
> >  			     struct netlink_ext_ack *extack)
> >  {
> >  	int err;
> > +	u8 sa_dir = attrs[XFRMA_SA_DIR] ?  nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;
> 
> nit: extra ' ' after '?', only one is needed.

fixed.

> > @@ -358,6 +383,64 @@ static int verify_newsa_info(struct 
> > xfrm_usersa_info *p,
> >  			err = -EINVAL;
> >  			goto out;
> >  		}
> > +
> > +		if (sa_dir == XFRM_SA_DIR_OUT) {
> > +			NL_SET_ERR_MSG(extack,
> > +				       "MTIMER_THRESH attribute should not be set on output SA");
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	if (sa_dir == XFRM_SA_DIR_OUT) {
> > +		if (p->flags & XFRM_STATE_DECAP_DSCP) {
> > +			NL_SET_ERR_MSG(extack, "Flag NDECAP_DSCP should not be set for output SA");
> 
> That typo in the error string is still here (extra N in flag name).

sorry.Fixed. I will send v13 soon.

-antony

