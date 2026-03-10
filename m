Return-Path: <netdev+bounces-266309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PYIOt51sGnJjQIAu9opvQ
	(envelope-from <netdev+bounces-266309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:49:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F3257243
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72220304B3A4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E082D3220;
	Tue, 10 Mar 2026 19:49:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160132C11D9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172187; cv=none; b=qOEG4YfXorXyL4gpkH9mWF1JRepWkjr14AKp5bTPHcwELuHCF0B+o2S1pHOzeA3iCkHt1hZU0BM+MWRrW8RfwHpWjlNzoNO2JfAkh+1c8Si7k7LFC/aJr96huEQxQl68hf6+OWvKTM8UTHloJKMd2i4vGAgZ4V6+Jl0zYvgJJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172187; c=relaxed/simple;
	bh=Cbk+TPCTTua5crdvvKusCVU5CfZ4/K0YX1H9qIVTQBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdgGJW0jEMnEadYx5wep2wKElWpjWlMkLXDMbqluiAFjtBztz0EMpsY3AOVDVhCdCILT4cEbkO7NVZRYbgF33wUS6BU7SVqs3PPwRB54K5s6kCuyBxhw8T3heBZD+PQekcnoCQaBRqR55VZWffz/87+PJFueIxq+BARjcAEol0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6CBC760345; Tue, 10 Mar 2026 20:49:44 +0100 (CET)
Date: Tue, 10 Mar 2026 20:49:44 +0100
From: Florian Westphal <fw@strlen.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <abB12Ae769OivuYB@strlen.de>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
 <20260310194500.GO12611@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310194500.GO12611@unreal>
X-Rspamd-Queue-Id: 744F3257243
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.895];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Leon Romanovsky <leon@kernel.org> wrote:
> > You can only use xfrm_state_hold() if the refcount is already > 0.
> > xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
> > if this assuption doesn't hold true.
> 
> I know it, the thing that bothers me is that it is unclear how
> xfrm_state_hold_rcu() can have refcount equal to 0.
> 
> xfrm_state_put() decreases refcount and when it is zero, it calls
> to __xfrm_state_destroy(). The latter assumes that the state was
> already removed from various hlists.

Yes, insertion in the table means refcount is 1, but userspace
can zap states at any time, e.g.:

xfrm_del_sa -> xfrm_state_delete -> __xfrm_state_delete (which
unlinks from hash lists).

The last xfrm_state_put() in that function may cause 1 -> 0
transition.  Parallel lookup can still observe that state,
so it has to pretend it wasn't there to begin with.

