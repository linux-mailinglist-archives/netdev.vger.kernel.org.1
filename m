Return-Path: <netdev+bounces-252297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKC0AqsQcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:57:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F7664A0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F02DE8AA353
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1093A9627;
	Thu, 22 Jan 2026 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="wm8JCK/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kO5gEcDa"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8236BCE1;
	Thu, 22 Jan 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080843; cv=none; b=Mxg39MitEWvQJJJdcQnBKB/OaTJkYu6zO34HcU1LZDyY/1rtRKLbECh1ikxTfYMbszDlSs5G5yKQv4MvLdYi8lqbY1H5S6Kdv6rWw5N5xqw6W0gtYEsxhILuh0mh0fldd4JhSyw9Mo0FmvROFajKh5NVy6HmO0c6pYY5ZtkdHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080843; c=relaxed/simple;
	bh=bJpnp5aIwRuu1xd73cRIqk6ewXcA1D1stAsGp2g9bW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLmZglhy/Bum0ihesNqUyMA66lQVMjYdAzg0EOiAChxALEE+FbVNRYzOlf/hEMBY0zDSpK2Ez/0hyIUkeU2wjOnBNSq4V6B0aRigFLsyFVDIe46t4COf2M5PNOw2cRHFd8oo3aeeG71LMiYMLKfL2zz4SwkM95ugtrO3cVWg7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wm8JCK/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kO5gEcDa; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EC3414000F8;
	Thu, 22 Jan 2026 06:20:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 22 Jan 2026 06:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1769080839; x=1769167239; bh=O2G8GCSOLyzSBWxQZdHOWDzcNZAjYQui
	68vaPgub5l4=; b=wm8JCK/xjEhEapeFnpflqZBA0FsTBX/7nO8YIsChO1URiaaD
	zLt8b0nr2uFXhBv6sAvBXNL8SKJ7iRthD0ftSpVKXBmXwRzzVt6OvBXOKoe9v/rS
	smadd/OMlHaM1ZZtZXhJrVDU3Ua2Y87Ivh74CKx1bvd7NPev1bjSbhobTA/RBW6U
	UAOQzXlk1HHvFiap0KRhs5cRfYptKGxhcs1WVyihddAt4pLKVpI6n38AisDvcE2y
	QuK3PHz6P/4+t5u8qX3xXMuzUmeVM1K4bdKdZWIt4fDiRAsc/RCYdEBBhHZooeKb
	Gf8pcy5rigP7lO+eeD14KmkRZcGPKd6uumxdfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769080839; x=
	1769167239; bh=O2G8GCSOLyzSBWxQZdHOWDzcNZAjYQui68vaPgub5l4=; b=k
	O5gEcDaEQOrRxnyiK87A5nw0G0XqsynAE1T94MLVhG+K5U/7C/uTlkhkMo2iZpEW
	1Ct6UvgoqSsxYVVCQG9QmLXVl6knAJ2GN4ww1JUaHkXPECdWoIHirGEA/+f73HXh
	nNzUx60Sxa3tEJiHrfmYK1VJZaS2H3E/3np8y0dKpoh6ZIzDCEKWF6xI4mWjj4X2
	cNFq+uN9YCuzwtLmpT2qdjJsMB+5yiqYcZkqsM8znyYROIOwylIToK0iOSuu4Cr2
	gyKDJMMJmBn1CVca/v09eCM8YAMqCLAv3nJrXYR4zLyPWHLVj8GDsjhyLGVKOEZN
	v1odn6IfUa2nq9JJnua7w==
X-ME-Sender: <xms:BwhyabmhLYrFFfeyi12EwcZmx50jIUGqn8qGcuM0NajAYWHrhmrBcw>
    <xme:BwhyaZHEBWaZ4MV5CYI-wnePhTQHwW5XzYjccbJt7Gqxex7TjxQEKeZqkVn2vv2N3
    jF-0se53MtO8MEM3-80qLnadJLax4A-7Df-9Z2yyORCU-J7Mi20ZM8>
X-ME-Received: <xmr:BwhyaXGT4y88Hbj_HAQ3mWYlH77cbNi-J53T7RT2Okqh9lcaN4JgrEPzEjcC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeitddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmmhihrghnghhflhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepug
    grvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhgriiho
    rhessghlrggtkhifrghllhdrohhrghdprhgtphhtthhopehiughoshgthhesnhhvihguih
    grrdgtohhm
X-ME-Proxy: <xmx:BwhyaZ1sKA_ChYRWgN6AA8gmUTxKXTt4DgngsNZkvon6XSIE82rZkg>
    <xmx:BwhyaRfkoW5R3naVazTbRSnTlt1y9FLPtTg4Ha8zWtyRk2GTKgROyg>
    <xmx:BwhyaTKHxWCqM8afIRLrH8rM0Y3_gyfGS4FG-2dFBtsQyfXlNysuZg>
    <xmx:BwhyafEyoK2fsO0y3RUEkgv7u13G6Car9LOXMW8jnujg9xo5uAc-3g>
    <xmx:BwhyabxdzvWz_9fVDmVWrZ1zMnI-9_u2_kLYa40mONeD6QhGCaSPXHDp>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 06:20:38 -0500 (EST)
Date: Thu, 22 Jan 2026 12:20:37 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
Message-ID: <aXIIBbCpuY_ISi-t@krikkit>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
 <20260120092137.2161162-2-mmyangfl@gmail.com>
 <aXELnMSc4UU6DkbZ@krikkit>
 <CAAXyoMMAMAbEu=-wTf3MGMiZr2Uq7pqJXC+_zrtxKrsjyYi+AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMMAMAbEu=-wTf3MGMiZr2Uq7pqJXC+_zrtxKrsjyYi+AQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-252297-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 780F7664A0
X-Rspamd-Action: no action

2026-01-22, 02:22:49 +0800, Yangfl wrote:
> On Thu, Jan 22, 2026 at 1:23 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > 2026-01-20, 17:21:29 +0800, David Yang wrote:
> > > The following (anti-)pattern was observed in the code tree:
> > >
> > >         do {
> > >                 start = u64_stats_fetch_begin(&pstats->syncp);
> > >                 memcpy(&temp, &pstats->stats, sizeof(temp));
> > >         } while (u64_stats_fetch_retry(&pstats->syncp, start));
> > >
> > > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > > against load/store tearing, especially for memcpy(), for which arches may
> > > provide their highly-optimized implements.
> > >
> > > In theory the affected code should convert to u64_stats_t, or use
> > > READ_ONCE()/WRITE_ONCE() properly.
> > >
> > > However since there are needs to copy chunks of statistics, instead of
> > > writing loops at random places, we provide a safe memcpy() variant for
> > > u64_stats.
> > >
> > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > ---
> > >  include/linux/u64_stats_sync.h | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
> > > index 457879938fc1..849ff6e159c6 100644
> > > --- a/include/linux/u64_stats_sync.h
> > > +++ b/include/linux/u64_stats_sync.h
> > > @@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
> > >       return local64_read(&p->v);
> > >  }
> > >
> > > +static inline void *u64_stats_copy(void *dst, const void *src, size_t len)
> > > +{
> > > +     BUILD_BUG_ON(len % sizeof(u64_stats_t));
> > > +     for (size_t i = 0; i < len / sizeof(u64_stats_t); i++)
> > > +             ((u64 *)dst)[i] = local64_read(&((local64_t *)src)[i]);
> >
> > Maybe u64_stats_read/u64_stats_t instead of local64_read/local64_t?
> >
> 
> I think casting to u64_stats_t is a bit overkill here since we accept
> const void * and we are the actual implementation.

It would be a bit more consistent. Just within this function you have
2 lines using u64_stats_t and the 3rd uses local64_t. And reusing
types/helpers within a similar context doesn't seem overkill.


[...]
> > Since this new helper is always used within a
> > u64_stats_fetch_begin/u64_stats_fetch_retry loop, maybe it would be
> > nicer to push the retry loop into the helper as well?  Not a strong
> > opinion. It would be a bit "simpler" for the callers, but your current
> > proposal has the advantage of looking like memcpy(), and of also
> > looking (for the caller) like other retry loops fetching each counter
> > explicitly.
> >
> 
> The callers may want to copy other discontinuous data as well, albeit
> no one did it then.

I'm not sure why they would. I think the main point of using memcpy is
"I don't want to copy each counter by name one by one", and possibly
"I don't want to have to patch this code as well if we add a new
counter". If you already have a batch copy for a bunch of counters,
it's usually easier to add others in a contiguous block.


> It would be redundant to provide two variants of the function.
> Moreover, callers can (and already) invent their own reader/writer
> helpers, for example
> 
>          #define SLIC_GET_STATS_COUNTER(newst, st, counter) \
>          { \
>                   unsigned int start; \
>                   do { \
>                           start = u64_stats_fetch_begin(&(st)->syncp); \
>                           newst = u64_stats_read(&(st)->counter); \
>                   } while (u64_stats_fetch_retry(&(st)->syncp, start)); \
>          }

Probably because the retry loop is a bit cumbersome and they'd rather
not c/p it everywhere, and see it in the middle of whatever function
needs it.

> > Either way, I think extending the "Usage" section of the big comment
> > at the top of the file with this new helper would be nice.
> >
> 
> I think callers should avoid memcpy() eventually, and they almost
> certainly copied more data than what they need. However, I took a look
> at some instances, and it would be non trivial to modify those
> drivers.

I'm not asking you to fix something else. But for example commit
316580b69d0a ("u64_stats: provide u64_stats_t type") modified the bit
of documentation we have at the top of the file to help developers who
want to use this API. This patch is introducing a new function and
should also describe how to use it, so that new users aren't tempted
to re-introduce a memcpy.

-- 
Sabrina

