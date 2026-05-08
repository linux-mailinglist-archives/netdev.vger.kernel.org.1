Return-Path: <netdev+bounces-285599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAE9LiJc/WlqbQAAu9opvQ
	(envelope-from <netdev+bounces-285599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:44:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CF4F13BC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A80453010523
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447AC314B8F;
	Fri,  8 May 2026 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="CKbff5eJ"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D67314B72
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211872; cv=none; b=Out9oRTsn+Og84t3HJESrxZOH5U7ItHaQxI6LCdqIN7cuBAi7BXbztxut2Nr8ciqepdULBhfPO1M5rjVX9Vd5MDeB9YEAN4HLOZ2psv//MD0rl2gC0vcwB43aGD41r2gYNXWac8U+2ZJyG9cyLJAyl+KkfCG7l3hFrfq5iWAsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211872; c=relaxed/simple;
	bh=t1BGEajc5T/kBapN6HEi/t1JscU6arGyElBAiSR/eng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooVgj5wEtAmqJae7LV7mM72pxYyzC6HxDSKU58sBIlkzsjLhsKrvg/67McGf4+fgYERGy24YdRg3aLyLagzVSpRU8MQBTSOKvkoR2BNTDHGMPJGUv9LrPp90HxdwNpPj24z0Wi2V10GSGYykdOuEBqB5kHFAqdoQrKXwlsfPp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=CKbff5eJ; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1778211867; x=1779075868; bh=t1BG
	Eajc5T/kBapN6HEi/t1JscU6arGyElBAiSR/eng=; b=CKbff5eJYf0cJweYMs55
	u5n/6i1aMmts9h60L3t/iH22fX7FfEhQ5zVRjSZVgEVQaAV2eVlGZX803fR/gG5Q
	g6kupaIQZDw5fkLsgwqYMyMWv7fpICNAQBXKmeAWccG5nIIw6moMe92v3VlMqYnw
	v+8LOHPgA2ojYVdZuVlYH5TRlHf43Bb5FNbbuOBM/kdNd9uTADt7Y4ADn1bGffUI
	vhv+HIcz6K4n8zON7s3QcSZwge+ngPCT33VQnVBtK9PnUbmuQ+x8d2u2oXzYyWyS
	qIK1dzqOz5DGzYsCNpcROt4PeZscoYQV6kDlk2BeBa2xcVrIaWblM0sTY2MJmAcW
	1Q==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Fri, 08 May 2026 05:44:26 +0200 (CEST)
Date: Fri, 8 May 2026 05:44:24 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] xfrm: Use regular error handling instead of
 BUG_ON() in the netlink API.
Message-ID: <af1cGISaaBmQQfqJ@Antony2201.local>
References: <aftnl6d59WUM_Dfm@secunet.com>
 <afwhdRPx-Mko28yM@Antony2201.local>
 <afxJOGtMkRK5FrvG@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afxJOGtMkRK5FrvG@krikkit>
X-Rspamd-Queue-Id: 1B7CF4F13BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285599-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:11:36AM +0200, Sabrina Dubroca via Devel wrote:
> 2026-05-07, 06:21:57 +0100, Antony Antony wrote:
> > wHi Steffen,
> > 
> > Thanks Steffen, I was hit by this in the new XFRM_MIGRATE_STATE I am adding.
> > I am glad to see we are addressing this.
> > 
> > On Wed, May 06, 2026 at 06:08:55PM +0200, Steffen Klassert via Devel wrote:
> > > The xfrm netlink API uses BUG_ON() on failures since it exists.
> > > However all these error are uncritical and can be handled
> > > with regular error handling. This fixes machine crashes
> > > in situations where an emergency break is not needed.
> > 
> > While BUG_ON is an extreme measure for a recoverable netlink error, it does
> > have diagnostic value: it leaves a stack trace. The patch trades
> > a crash + stack trace for a silent error return, which loses observability.
> > 
> > Would you consider using WARN_ONCE instead of a bare if (err < 0)?
> > 
> > -     BUG_ON(err < 0);
> > +     if (WARN_ONCE(err < 0, "xfrm: build_spdinfo failed: %d\n", err)) {
> > +         kfree_skb(r_skb);
> > +         return err;
> > +     }
> 
> OTOH we already have a bunch of functions doing something similar
> without using BUG_ON/WARN_ON, so at least with this patch it becomes
> consistent.
> 
> xfrm_notify_userpolicy
> xfrm_get_default
> xfrm_get_ae
> xfrm_exp_state_notify
> xfrm_notify_sa_flush
> xfrm_notify_sa
> xfrm_notify_policy
> xfrm_notify_policy_flush
> 
> 
> (I'm looking into generic ways to avoid this split getsize/fill that
> always becomes inconsistent in areas where new attributes are added
> frequently, but nothing to share yet)
> 
> > Something like the above would preserve the "shouldn't happen" signal with a 
> > stack trace on first occurrence, without panicking the machine.
> > Or are there better signaling  styles in Kernel?
> 
> Maybe DEBUG_NET_WARN_ON_ONCE so that only developers see those messages.


I would discourage DEBUG_NET_* here, because these situations are not often
caught by testing or by developers. Typically IPsec builds disable debug 
completely - and I would even speculate that is why it was BUG_ON in the 
early days. If IPsec failed, halting was justified back then. While these 
days it is less so.

I vote for something along the lines of WARN_*. That has a higher chance of gathering better diagnostics for developers.

Would other IKE userspace developers like to chime in?

-antony

