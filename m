Return-Path: <netdev+bounces-249882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C0D201F9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB120300100D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EDA3A35B0;
	Wed, 14 Jan 2026 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="bbW+Aq8P"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11C3A35AF
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407341; cv=none; b=Yi/6xiQW/IIYK6c0CMbt5lMb83SUiDVmst0K2ebLZsxxKcRVfD6TE/MRvbXd/RX9O5E7WCUEE5HAoBMYuCwZLaFIrpGktQX59wEgP3MPKoBQT09T+2GpXOeFqk46AU3dBwCSGspGB5Eqvco2LxoW1R0R+pdDUsvHUjOKFs5jGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407341; c=relaxed/simple;
	bh=T3PGiunjMtfEky24Efp3g6lTcEYvuq+fn/JbKrjgFko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIngdcejt0R8q4v/iwc2zQ41y/2RwezwANcN6mhS40AxfYVs7+h7280Rn1rf/ySVTfTWlLkT1Iqqo5fMW++T0OeX64nPGQUmswaT59CpcyoJ3SDBc9hR91ruR1jA8PqBvexl6t2KXDxarV3mBFdJOJupgzOD3p+53ShFST1Wyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=bbW+Aq8P; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1768406964; x=1769270965; bh=T3PG
	iunjMtfEky24Efp3g6lTcEYvuq+fn/JbKrjgFko=; b=bbW+Aq8P5T1O134WTEin
	j2NDLY9kxgLuN+CZaMiclPHTso10WCEAiZVBaP5pJnJBBzcUlqLxDyNCEjISSAvk
	rRa3GPgNmsfpnYgug486dzvMYuyo7bMWFZojWP5XV2I2aTSJ9I4EDsMcrnUu5i2Z
	vbapAQXn9608XNVoIy5PpRZoEyrcsJUHOEikj/jzP+rYwiCsFAp6nDWY0aqFNUJl
	ntkEm+gt9g0/fcpcPQ00Xzh+qJz814an4zllhDgFDtbI4RaamVn5zd1WI8ROAVqn
	YkdkUC0MeVxKNJerTWaCOhBcnZtT3nHPkuIoZ3bmY7AhqBIon5t3AAHd+S1qjrCi
	cQ==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Wed, 14 Jan 2026 17:09:21 +0100 (CET)
Date: Wed, 14 Jan 2026 17:09:20 +0100
From: Antony Antony <antony@phenome.org>
To: Simon Horman <horms@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next 4/6] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aWe_sIibKYzdWL9C@Antony2201.local>
References: <cover.1767964254.git.antony@moon.secunet.de>
 <3558d8c20a0a973fd873ca6f50aef47a9caffcdc.1767964254.git.antony@moon.secunet.de>
 <aWZdTOXTn_YBKKhv@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWZdTOXTn_YBKKhv@horms.kernel.org>

Hi Simon,

On Tue, Jan 13, 2026 at 02:57:16PM +0000, Simon Horman via Devel wrote:
> On Fri, Jan 09, 2026 at 02:38:05PM +0100, Antony Antony wrote:
> > Add a new netlink method to migrate a single xfrm_state.
> > Unlike the existing migration mechanism (SA + policy), this
> > supports migrating only the SA and allows changing the reqid.
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> 
> ...
> 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index ef832ce477b6..04c893e42bc1 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -1967,7 +1967,8 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
> >  
> >  static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
> >  					   struct xfrm_encap_tmpl *encap,
> > -					   struct xfrm_migrate *m)
> > +					   struct xfrm_migrate *m,
> 
> Hi Antony,
> 
> Not strictly related to this patch, but FWIIW, it seems that m could be
> const in this call stack.  And, moreover, I think there would be some value
> in constifying parameters throughout xfrm.

thanks. It is good advise. I sprinkled a couple of const.

> 
> > +					   struct netlink_ext_ack *extack)
> >  {
> >  	struct net *net = xs_net(orig);
> >  	struct xfrm_state *x = xfrm_state_alloc(net);
> > @@ -1979,9 +1980,13 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
> >  	memcpy(&x->lft, &orig->lft, sizeof(x->lft));
> >  	x->props.mode = orig->props.mode;
> >  	x->props.replay_window = orig->props.replay_window;
> > -	x->props.reqid = orig->props.reqid;
> >  	x->props.saddr = orig->props.saddr;
> >  
> > +	if (orig->props.reqid != m->new_reqid)
> > +		x->props.reqid = m->new_reqid;
> > +	else
> > +		x->props.reqid = orig->props.reqid;
> > +
> 
> Claude Code with Review Prompts [1] flags that until the next
> patch of this series m->new_reqid is used uninitialised in the following
> call stack:
> 
> xfrm_do_migrate -> xfrm_migrate -> xfrm_state_migrate -> xfrm_state_clone_and_setup
> 
> Also, while I could have missed something, it seems to me that it is
> also uninitialised in this call stack:
> 
> pfkey_migrate -> xfrm_migrate -> xfrm_state_migrate -> xfrm_state_clone_and_setup

thanks. I fxied this by squashing the next patch to this one.
 
> [1] https://github.com/masoncl/review-prompts/

thanks! that looks interesting.

> 
> >  	if (orig->aalg) {
> >  		x->aalg = xfrm_algo_auth_clone(orig->aalg);
> >  		if (!x->aalg)
> > @@ -2059,7 +2064,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
> >  			goto error;
> >  	}
> >  
> > -
> 
> nit: this hunk doesn't seem related to the rest of the patch.

fixed.

> 
> >  	x->props.family = m->new_family;
> >  	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
> >  	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
> 
> ...
> 
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> 
> ...
> 
> > +static inline unsigned int xfrm_migrate_state_msgsize(bool with_encap, bool with_xuo)
> 
> Please don't use the inline keyword in .c files unless there is a
> demonstrable - usually performance - reason to do so.
> Rather, please let the compiler inline (or not) code as it sees fit.

removed

> 
> > +{
> > +	return NLMSG_ALIGN(sizeof(struct xfrm_user_migrate_state)) +
> > +		(with_encap ? nla_total_size(sizeof(struct xfrm_encap_tmpl)) : 0) +
> > +		(with_xuo ? nla_total_size(sizeof(struct xfrm_user_offload)) : 0);
> > +}
> > +
> 
> ...
> 
> > +static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
> > +				   const struct xfrm_encap_tmpl *encap,
> > +				   const struct xfrm_user_offload *xuo)
> > +{
> > +	int err;
> > +	struct sk_buff *skb;
> > +	struct net *net = &init_net;
> > +
> > +	skb = nlmsg_new(xfrm_migrate_state_msgsize(!!encap, !!xuo), GFP_ATOMIC);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	err = build_migrate_state(skb, um, encap, xuo);
> > +	if (err < 0) {
> > +		WARN_ON(1);
> > +		return err;
> 
> skb seems to be leaked here.
> 
> Also flagged by Review Prompts.

I don't see a skb leak. It also looks similar to the functions above.

> 
> > +	}
> > +
> > +	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
> > +}

I will send a new v2.

regards
-antony

