Return-Path: <netdev+bounces-266307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO7AOMN0sGnJjQIAu9opvQ
	(envelope-from <netdev+bounces-266307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:45:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB42571C1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3889D303716C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC63355F52;
	Tue, 10 Mar 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhpczSfd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8211356A0B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171905; cv=none; b=bsh+6DIYyOurLoTGYhvg8QSVCXTlJ9Kg4KnpHESV8sFc+pVwtk0OQbCi8hmL/L1gV9zTlJbSNSl8Z54L0ZX3syYEt+NPk5NQkQhCJtpU4wEhW3+UTSvGEAX+XyA1fVze5h0EL6Yt1/1MDppPYS/+uj+elA20trACVLP9N0DZAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171905; c=relaxed/simple;
	bh=FPlFck6czZf7vZxe6SyJm3juUdUD2c2YVeBE65NZxI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmJBvVOy2qOpLzglj34uXo3ANRQ35nShXNWMlHuNtrAPJN3dNLpPlH6msmhaBkJuHRntC8n+k31EF2XgdtNI25Aidn6XMTTENxbTP8IT7ziwRqJVoA4hlNgQrHv29PlSfFhnDmWgxAhqYiIjoIVUh16Vu9N6XtnBFFiwXdu75To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhpczSfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA84C19423;
	Tue, 10 Mar 2026 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773171905;
	bh=FPlFck6czZf7vZxe6SyJm3juUdUD2c2YVeBE65NZxI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhpczSfdGjuf6QGMj5AMtWnwJdi+g5iUznm+hK8BWbaIoo3CbmggumC9tdrjdFIgT
	 8VkBQYE4uQefOfijsEX73o9ErJKK3eOVcrjLLHQs5vMyYNoArbuOrFr3ccdMk9OKba
	 E8kwIyuzlqOMO3krRGiUkPO12K4tQGurqNxSIY11GCBAbmYFmenMu0E2o6qs+StYWQ
	 dYQDGbnSrux5paEMbraSSMnFm0vJItn6s8jyMLC7SnBAE/5Gpx1JeXxiJ7spvNnICm
	 jtwwOu5YbHbux8S0xPIHmSeG+QcciVlVfd4Hka0SpsWT8+vgMjFE8ZFDUouaSmSC8d
	 qum9TVn0JlIZg==
Date: Tue, 10 Mar 2026 21:45:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <20260310194500.GO12611@unreal>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBv6zR4Qq_lrzuC@strlen.de>
X-Rspamd-Queue-Id: 74CB42571C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266307-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 08:24:27PM +0100, Florian Westphal wrote:
> Leon Romanovsky <leon@kernel.org> wrote:
> > > > This change makes me wonder why we need both xfrm_state_hold_rcu() and
> > > > xfrm_state_hold().
> > > 
> > > Commit 02efdff7e209 ("xfrm: state: use atomic_inc_not_zero to
> > > increment refcount") and the series around it [0] introduced the
> > > possibility of that refcount increment failing.
> > > 
> > > I can't tell you why a 10-years-old commit made some choice, but
> > > keeping both variants has the benefit of documenting that one
> > > increment is expected to never fail (because we already hold a ref on
> > > the object on that path) and we can skip the error handling. We don't
> > > want to add error handling that will never get reached, it always goes
> > > wrong (because it's untested) and it adds uneeded complexity to the
> > > code.
> > > 
> > > So I wouldn't get rid of xfrm_state_hold.
> > 
> > So let's add some comment when this function should be used.
> 
> Before rcu-ification, everything was serialized via state lock.
> Entries still in the state table thus always had > 0 refcounts.
> 
> You can only use xfrm_state_hold() if the refcount is already > 0.
> xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
> if this assuption doesn't hold true.

I know it, the thing that bothers me is that it is unclear how
xfrm_state_hold_rcu() can have refcount equal to 0.

xfrm_state_put() decreases refcount and when it is zero, it calls
to __xfrm_state_destroy(). The latter assumes that the state was
already removed from various hlists.

For example:
  1175 static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs
  1176                                               u32 mark,                                   
  1177                                               const xfrm_address_t *daddr,               
  1178                                               __be32 spi, u8 proto,                     
  1179                                               unsigned short family)                   
  1180 {                                                                                     
  1181         unsigned int h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs->hmask);
  1182         struct xfrm_state *x;                                                         
  1183                                                                                      
  1184         hlist_for_each_entry_rcu(x, state_ptrs->byspi + h, byspi) {                

<...>

  1193                 if (!xfrm_state_hold_rcu(x))                               
  1194                         continue;                                         
  1195                 return x;                                                
  1196         }                                                               
  1197                                                                        
  1198         return NULL;                                                  
  1199 }    

Thanks

