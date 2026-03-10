Return-Path: <netdev+bounces-266314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF04AAR7sGnLjgIAu9opvQ
	(envelope-from <netdev+bounces-266314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:11:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EDA25766B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5036830209DB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA23E1CEB;
	Tue, 10 Mar 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNJOZV16"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98D3164DF
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173425; cv=none; b=TLu+BnrfPb0lyHz/CHGftKRx6ZDC40ZC3QPn9LLmhXmDmXfroeApKqXL4d4zjpIRkeR8zLORO4cnT3X1LGFUpEiSDHvOPMerbn/9s0oVcE+LzdD2enSZw913Cwu5+Z7hLCH7OLBM44zLfme2FeMP+J0yo9Ce7e66ieA5DRua0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173425; c=relaxed/simple;
	bh=Avd6EHAVmJ55wAOW8xQt+Ahosy3/IqeEuJnL/ZqjDtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOPviWfI8SQ1ZKPBQcqXnQ9MubWWuiM/EhFZ0pmtfi2HYmfShPIE1+9L2XyJ+P7zrzaV3mbFbW8SfqTcEmsMnREqYz/kJWxFEOvJpuXVUjSy/zX6NmvRjYWlWXyWv1YioTJV/fKeED1XCx+FimSToJtNdvMxdKgfUYkFG2CY/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNJOZV16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916EBC19423;
	Tue, 10 Mar 2026 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173425;
	bh=Avd6EHAVmJ55wAOW8xQt+Ahosy3/IqeEuJnL/ZqjDtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNJOZV16ZNwx0rmZmez+YnpR/crPCfBgiV2xP2u7oT3AYT2cExmXadbhen2+8hAp/
	 UE1CiLMo/QmjnkNcnlr+AnJHF2l5+EXRYIjszqSrT3Bm3b/GC/uMfogyFI4S/+7ffK
	 LjBryofI0PUAcYkYrrP7sVY9xqCpMO+h5fpLMrLkonYV4ZDCjk57koIokAbv25VJjp
	 OF2kXG5FnY4R79ypIQPZ/WlAaiphEFNQZ7/5SDS6/KgJIC+EYPdcTUsEoe8KkBAl0k
	 sdu2FRjEB/gUHjvio2cEylTbJxs8+8vF4bOVhRgHPanDj9jMtvChmxK8NlhOgAAS1w
	 iRWgcTKBGuIXg==
Date: Tue, 10 Mar 2026 22:10:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <20260310201021.GP12611@unreal>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
 <20260310194500.GO12611@unreal>
 <abB12Ae769OivuYB@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abB12Ae769OivuYB@strlen.de>
X-Rspamd-Queue-Id: 93EDA25766B
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
	TAGGED_FROM(0.00)[bounces-266314-lists,netdev=lfdr.de];
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

On Tue, Mar 10, 2026 at 08:49:44PM +0100, Florian Westphal wrote:
> Leon Romanovsky <leon@kernel.org> wrote:
> > > You can only use xfrm_state_hold() if the refcount is already > 0.
> > > xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
> > > if this assuption doesn't hold true.
> > 
> > I know it, the thing that bothers me is that it is unclear how
> > xfrm_state_hold_rcu() can have refcount equal to 0.
> > 
> > xfrm_state_put() decreases refcount and when it is zero, it calls
> > to __xfrm_state_destroy(). The latter assumes that the state was
> > already removed from various hlists.
> 
> Yes, insertion in the table means refcount is 1, but userspace
> can zap states at any time, e.g.:
> 
> xfrm_del_sa -> xfrm_state_delete -> __xfrm_state_delete (which
> unlinks from hash lists).
> 
> The last xfrm_state_put() in that function may cause 1 -> 0
> transition.  Parallel lookup can still observe that state,
> so it has to pretend it wasn't there to begin with.

Yes, this is possible scenario and this is what is worth to document.

Thanks

