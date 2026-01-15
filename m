Return-Path: <netdev+bounces-250189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522FD24C80
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D21F03000B4B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B1378D87;
	Thu, 15 Jan 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEfcjtdd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214334E770
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484695; cv=none; b=o1HqYjkdSyhczszOMCb3UPZRpUKKey9oWgkh7F+WSSL2rMi6D/yZD4mXRxT89pLHYxu9GMlp8hcGqRI3Ktu+OPU14JW7HwU4LDgKdN5OdqgOURdgulQrgWh7Ha/hHIY0rGtKdD0UBEK3dZg1TrEZKJFq2GwcXvddndo4DsEsiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484695; c=relaxed/simple;
	bh=5WvZx0ilNW/0Ct5Qn3xg8xCn/hMJHqntCHWuFRyuYns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAkm/EnwIO+Uhwo82ESA0Hn0YP9PQohCjSdMCRr09TsUgFLbQ3/QUYFCRv0dLJ6pdbOq4DTKsMorKf/4BFsJ9cOAmsp1ArpkLhhGDJ55Vfnml0FNF7+3gPSOibuYj3dSpI/Yhi64balKqoV1mlwCpXxnAGCdZPH0xzUOMf5ZLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEfcjtdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440F0C116D0;
	Thu, 15 Jan 2026 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768484695;
	bh=5WvZx0ilNW/0Ct5Qn3xg8xCn/hMJHqntCHWuFRyuYns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEfcjtdd4MooXBRr73uC8Js4fvcugx3T8mk/hH20UUm+o5o8aI8f8BSZYJGY3BPrX
	 Hmmi4j5raEJCFvkgyI22ObTmepi+N4EcPJ2xLPOdzafffnVrd893T6f7E2DFTofcUa
	 B+urjTOcS9EALSI3xMTGmADjua6asxKEpcBrgibev/WI2huxEz1x6wfjSE59dvh46x
	 SM0fFVW/Gi7oYgvxGVlQmGipDPCVNmyZWGyzSod0HIxK2FJip5v+F28PigOjxQB938
	 XVMr5wfcX5w3qpR5uz6qH22VOkEGNtF2SBGZbiN8iTZGgEhC76C3+i7WLzUxWmd6OR
	 yZ8S5+YgqzD0Q==
Date: Thu, 15 Jan 2026 13:44:50 +0000
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next 4/6] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aWjvUllZ7Clf3pm5@horms.kernel.org>
References: <cover.1767964254.git.antony@moon.secunet.de>
 <3558d8c20a0a973fd873ca6f50aef47a9caffcdc.1767964254.git.antony@moon.secunet.de>
 <aWZdTOXTn_YBKKhv@horms.kernel.org>
 <aWe_sIibKYzdWL9C@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWe_sIibKYzdWL9C@Antony2201.local>

On Wed, Jan 14, 2026 at 05:09:20PM +0100, Antony Antony wrote:

Hi Antony,

> Hi Simon,
> 
> On Tue, Jan 13, 2026 at 02:57:16PM +0000, Simon Horman via Devel wrote:
> > On Fri, Jan 09, 2026 at 02:38:05PM +0100, Antony Antony wrote:

...

> > > +static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
> > > +				   const struct xfrm_encap_tmpl *encap,
> > > +				   const struct xfrm_user_offload *xuo)
> > > +{
> > > +	int err;
> > > +	struct sk_buff *skb;
> > > +	struct net *net = &init_net;
> > > +
> > > +	skb = nlmsg_new(xfrm_migrate_state_msgsize(!!encap, !!xuo), GFP_ATOMIC);
> > > +	if (!skb)
> > > +		return -ENOMEM;
> > > +
> > > +	err = build_migrate_state(skb, um, encap, xuo);
> > > +	if (err < 0) {
> > > +		WARN_ON(1);
> > > +		return err;
> > 
> > skb seems to be leaked here.
> > 
> > Also flagged by Review Prompts.
> 
> I don't see a skb leak. It also looks similar to the functions above.

xfrm_get_ae() is the previous caller of nlmsg_new() in this file.
It calls BUG_ON() on error, so leaking is not an issue there.

The caller before that is xfrm_get_default() which calls kfree_skb() in
it's error path. Maybe I'm missing something obvious, but I was thinking
that approach is appropriate here too.

...

